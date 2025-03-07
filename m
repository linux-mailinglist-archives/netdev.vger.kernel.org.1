Return-Path: <netdev+bounces-172722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CBAA55CE9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3AB1885F01
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4754673;
	Fri,  7 Mar 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNmGk3nE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94B1CFBC;
	Fri,  7 Mar 2025 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310130; cv=none; b=A3Gzv+5xf2VqyWIkxhgR2XO+6C5kRo0cPKRyeQIFZQXPYn1R01zE6VczPTpZhBqokV3Pec/5lna49HV8yrWjq/sdPUPMK0wgQKxqY2BAwWFfiGpI89+BUK9597byliTGGe84U4MM7+mgXQBhibbDs3d1foIvxvKn3h3O+pKFilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310130; c=relaxed/simple;
	bh=2SkmmBfnw5BqmUcGSwb1jm1lXpdrwk6min7BB8JNPKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2FVTP3vP3a5U/0+dHTsjZMomqJcqQ2B3SWWQ8SqoTx9VOp5LQMHy4AfiFpvYOXTL8Pow1ksZQS45ymh2F0gxacp/Lvqs2jtvo6pYQQwwNytvsvg338VT1wHoZmuvVxmA8gD7OzRUBdpFm2GFqIjqO5q73emP6KLTfBXL0YYCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNmGk3nE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FCF3C4CEE0;
	Fri,  7 Mar 2025 01:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741310129;
	bh=2SkmmBfnw5BqmUcGSwb1jm1lXpdrwk6min7BB8JNPKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNmGk3nEUXfqZkBKB14+OcwsqEGtJcRmJlxT9KkDpy/4htNoHhfzxji90Sk1Tkh7K
	 xkSdu0RAYsxLzZlpOHfJzJvPOVa4hBlYuOsGIO4G+OhxwDgmebfFA0RMlUPWC4+jhl
	 0JcjdQs2KRlWs2RBjjr8JrJsXP6WVn0x4luPGteetoFESJcq5F8NNsnKpt/DK5V+NT
	 2Sq2SCtPW5Cw2UoWVTv6zqY8F9MIq5O11L+eMDtiK8wyleHcobqtSxw2sJnKbNAmFL
	 efQ/xbBciYVt+ICiMvkNNdrtmGz0RFx2+RddhjIULmpXIOGBp4Jf/BTsW7lfgz6oxB
	 L4FVSMbppVAVA==
Date: Thu, 6 Mar 2025 17:15:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
Message-ID: <20250306171528.6c24bf6d@kernel.org>
In-Reply-To: <20250307004251.55786-1-kuniyu@amazon.com>
References: <20250306180533.1864075-1-kuba@kernel.org>
	<20250307004251.55786-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 16:41:41 -0800 Kuniyuki Iwashima wrote:
> > +Selftests should be part of the same series as the code changes.
> > +Specifically for fixes both code change and related test should go into
> > +the same tree (the tests may lack a Fixes tag, which is expected).
> > +Mixing code changes and test changes in a single commit is discouraged.  
> 
> I guess an exception for the mixing is when a code change breaks a
> selftest, or is it fine for NIPA ?  (still other CI may complain though)

If it breaks compilation yes, but that should almost never happen?
Functionality-wise it's fine, we don't expect patch-by-patch
compatibility of selftests. At least I don't recall it coming up
in discussions before.


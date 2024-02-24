Return-Path: <netdev+bounces-74661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CD0862246
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 03:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3081F2449B
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6085398;
	Sat, 24 Feb 2024 02:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceD4syJd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01D6D53F
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708741271; cv=none; b=akiFxgvp+SlZTBbRZrRR7vngdvW7g6jyp3UxiKEuQHex9Q7XJ3pT0axJ9QV1K4o1UDdZBlYTr4XH0Smw/Ioozz1FZzRGxIzlaE1ogZ8VRNh1/dx4mOBcAZygG1+dO7pJsI8ORei4DIMlD8s/gimlkFdI+5EIKK5yFbL1MiVyRQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708741271; c=relaxed/simple;
	bh=ZWHVWTb/tKMSO9FtoWiuOLQMlea34Au7jQAlYOHicTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws68utLQg17hHrwJF3BDh58FRuWbv7jlzSUb0IdZ9m8P6xohs3+kwMR26mxlZgTn5duD2q4uPsXa8y0DmGYEbeF68M9D+7yT8G8aAicwYLspU/lsIVeuF+k0fPJpkPiguX38IkgSLzMdm6iF9G8QCSP2N3J6CE88IuDdDV+y+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceD4syJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CF8C433F1;
	Sat, 24 Feb 2024 02:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708741270;
	bh=ZWHVWTb/tKMSO9FtoWiuOLQMlea34Au7jQAlYOHicTY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ceD4syJd/t3JkGfJW6Gx+dqJ/ewEs7zz6b/q71JpL2l4ltN3G1zlh44Yj6WuQDG0i
	 GUUr7Ei/2vL4pfDdVfBpta/zwC8Ta7ayWa3nn0TWI2RXoORJOxUdskw9foTYfybNn6
	 homECxEBsz94BcvwL3rXTnK7hubTPo5MUpE8QdwIIqgF89VvbBYZ9jc0/NfwmGw0AV
	 CpLz4EhdPIITl/draqgJpAH7HFqI1cHDsEPeFevct9i4mpt9eqMs9cVJrR4SLEx1V+
	 Y9uDqpb1aBDGVxs6UkyplFetIf+wwuQbikqnEYBI0wlqZwOdLDjVDvuzaLANzIqkzg
	 CXCXh6aoIkTyQ==
Date: Fri, 23 Feb 2024 18:21:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a
 test.
Message-ID: <20240223182109.3cb573a2@kernel.org>
In-Reply-To: <20240223081346.2052267-1-thinker.li@gmail.com>
References: <20240223081346.2052267-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 00:13:46 -0800 Kui-Feng Lee wrote:
> Due to the slowness of the test environment

Would be interesting if it's slowness, because it failed 2 times
on the debug runner but 5 times on the non-debug one. We'll see.


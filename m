Return-Path: <netdev+bounces-224208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB76B823BB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 01:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C167546102F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5292F6594;
	Wed, 17 Sep 2025 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyWcrDPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA59478;
	Wed, 17 Sep 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150404; cv=none; b=XAbGSlCpVEkZbbRkxJQfsFQuBbij8XDXaSB+eutjLZrYPPmhFWGSyiIFnk6DWSnXN8Ur14/TTm9rCY7LPVWe5KBChWPcazEcQYhcsY6C8Y1Zo1/bWE1wQaNRyTdmWYqmlcAjvpfdN+/ynIThMPAuPIQs5PCPnbqajjrroRFQtPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150404; c=relaxed/simple;
	bh=BofU9LRlxfQcdJv0vR2i5ymOQNkjnoQ3cx03YxysCOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ht/5OtCmN4/+F80Pg2SgjR7Si115Y0Jhf0dXUtbyfV6tsKIsmEaB4hk5cryDJfRzI2L/kMEUrr8A5H2hJjuGQNGU9h9Ae1lY1hx5QsmZoOelkbBz9hfoN0j9aY9POWyQSbZvy29QPFpGQemL7+fC2awzNUkg4Lwqk1ITpaoKCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyWcrDPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646FEC4CEE7;
	Wed, 17 Sep 2025 23:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758150403;
	bh=BofU9LRlxfQcdJv0vR2i5ymOQNkjnoQ3cx03YxysCOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EyWcrDPHxGqBryLiRZSUMRK/ifxGfa4peDMJxxV/Tt/9iSrll6taUhOkJfCdGd7VG
	 wfBpse5i67caYRL0YFtc+tXfvPFGWfZbVFyzg+8wnlggLVHolukb9oUGg7aYOaGR5a
	 nuVECY5pXwRnmWlGbG12+dtMsd2Fb7IKKuZCbIfkR9oLErzIGY9+LxBtlwBpifSGvA
	 QWRfH67ZxgJfkTwUmNZe083Uhlwzx84k17sdzRyDGaGnPPjObbmVChVhnJXWT9CkAc
	 IF5LJY3cFZBAkkD+fIwr9gG2eQIxdqQKhlWy4fu8KJHQSJPf1ounBPFndsq/WiVS/K
	 R2iplUQEqRbPw==
Date: Wed, 17 Sep 2025 16:06:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net v3 1/2] net: dlink: fix whitespace around function
 call
Message-ID: <20250917160642.2d21b529@kernel.org>
In-Reply-To: <20250916183305.2808-2-yyyynoom@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
	<20250916183305.2808-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 03:33:04 +0900 Yeounsu Moon wrote:
> Remove unnecessary whitespace between function names and the opening
> parenthesis to follow kernel coding style.
> 
> No functional change intended.

please dont mix whitespace changes with fixes


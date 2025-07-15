Return-Path: <netdev+bounces-207294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB65B069ED
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951B117FBA1
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F902C375E;
	Tue, 15 Jul 2025 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulxSC3Xg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965029460
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622608; cv=none; b=ZedlqQs+Uidg4S94Q2bExtwL9P7D3cj2AW+6QESmUTE2odWAe+Yh2ARSOAP7nk7P44uPc5++3GYwe+HKMArxrihW3ygVgYkT9dFkzveM9D30w7JGUds0LaZf7scljHdsaB0stAxObJKkgST+T3wZKscuScbtN49s8w3qrrIQxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622608; c=relaxed/simple;
	bh=CQ20X6DeTzcnMm6nBBS+Sv3xtLoJEsfRpC4kUSpJ1A8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvakiZsfPYPd0ifW5EAlYk45XnYlLOVjw/Mk3mqEMVC9is4BY+iBrV+ZG7euF1lNr49dDNfAy84mQa1ccXhfYPfltvDdnbsdfHKRwlmLdAl241LMWXBG0MRdrJYpwGOHTsyVH6jeJxwem/YHTVV0b2tL8mLoS4W8fvSsL9qaKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulxSC3Xg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3E1C4CEF1;
	Tue, 15 Jul 2025 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622608;
	bh=CQ20X6DeTzcnMm6nBBS+Sv3xtLoJEsfRpC4kUSpJ1A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ulxSC3Xg6LfqYTVFx2RMM85AJsV94vQ8pRg/1ALLh81EvtsY6Eq4hFOVCUNafYSLP
	 y8ShrvtURYvKMPRHIPQEPvV8ZjsV/aX1+7gRr1n2Rtt25P86W4yMHn3w3Enn4kKIGf
	 No/8+A0v+N3oJ43c9lJt8FVdNUj6dEA1ImAPzSRTPH9gR74PUeIbPygvXMgl5IUzj8
	 +/HaXcUehrrrPk6Ix+fwliQy6sRyNUs7kYXuiinJieU+B6afGnmaQawmPenTZ7Jd1N
	 AOBAWHxDPZmuNIhbd/zI2HC0b8ZppRDMfGFgFnoJfQ/P1K1Xq4pWF5FOAm5YrXUUJg
	 qr75L/FD8MZGw==
Date: Tue, 15 Jul 2025 16:36:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v4 6/7] net:
 s/dev_set_threaded/netif_set_threaded/
Message-ID: <20250715163647.0c25d113@kernel.org>
In-Reply-To: <20250714221855.3795752-7-sdf@fomichev.me>
References: <20250714221855.3795752-1-sdf@fomichev.me>
	<20250714221855.3795752-7-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 15:18:54 -0700 Stanislav Fomichev wrote:
> Commit cc34acd577f1 ("docs: net: document new locking reality")
> introduced netif_ vs dev_ function semantics: the former expects locked
> netdev, the latter takes care of the locking. We don't strictly
> follow this semantics on either side, but there are more dev_xxx handlers
> now that don't fit. Rename them to netif_xxx where appropriate.
> 
> Note that one dev_set_threaded call still remains in mt76 for debugfs file.

I applied Sami's patch yesterday, this needs a respin, sorry.
-- 
pw-bot: cr


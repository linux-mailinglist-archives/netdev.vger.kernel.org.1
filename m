Return-Path: <netdev+bounces-99443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB52C8D4E68
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93E82824B3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0817E44A;
	Thu, 30 May 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwT4UPMa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709DF17D8BC;
	Thu, 30 May 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080627; cv=none; b=uWw3Gk+prYbPAJ+VdOn825hSZqZZiQz2Dq4ZYS4pFcbaJPmI8vx+Jgzbyw3PzTLJQ9J3gb1c2Soi1zOdEkK1EairPQVy+FI1Ym03lzAy+iKbbVKc2YVKUZIad8Y80R7ExW9BC0wJRkv/U+p2V7Xh2OLLYzSV8YFOw7eOwo8Zogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080627; c=relaxed/simple;
	bh=prxNjWcocA1xfeZ7ScnSmd77MXh4m2kvHooi1WN7euE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5lZBJImWNzKBAoNNo2pFn8ti02HCZ4j6tsfRwsohR0nqJFx+xmNrnysKtFMHsaIabkvhBmHEeW0PsDW/SOtssR+vvyOxtgJTGhCS2woVWIQl4JvxdX/+/H3xa6SJL1ef4Vmksbrhaaq/Ucy83xPeRawrb/FpwDJbzNyHZPucsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwT4UPMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B722FC32781;
	Thu, 30 May 2024 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080627;
	bh=prxNjWcocA1xfeZ7ScnSmd77MXh4m2kvHooi1WN7euE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QwT4UPMaJuQ/heKtWMpOUvSL1X8vkyCwSBGw93uC47juM1xpIzMmM5UBHX29dBNj8
	 1YovjBI0ayS/MdIfZe6mjOINDM6wClHOdJ6JeqzwqKY+Ep/bXZOu8S3mUHeN5JsGSb
	 9vKot8OxUBW+M4V34CJZVLpnCCWe0CtSarAsStqTOlD612CPlX4rtRs9eSdMuovoqU
	 dsxYcEj1K2AUXSsEJgpeDWTnwRncXCs13xqWs239orTbguXBShIrZ+xX1q5w27/rnv
	 e24U8jr8ggj7YW8H1DAQY81lhYtRLVjKWeUgMNXLv1qTNBVM++mTqTGT2ptsMrNkHr
	 fNSw5INnqt2kA==
Date: Thu, 30 May 2024 17:49:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com,
	lcherian@marvell.com, richardcochran@gmail.com
Subject: Re: [net-next,v3 5/8] cn10k-ipsec: Add SA add/delete support for
 outb inline ipsec
Message-ID: <20240530144959.GC3884@unreal>
References: <20240528135349.932669-1-bbhushan2@marvell.com>
 <20240528135349.932669-6-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528135349.932669-6-bbhushan2@marvell.com>

On Tue, May 28, 2024 at 07:23:46PM +0530, Bharat Bhushan wrote:
> This patch adds support to add and delete Security Association
> (SA) xfrm ops. Hardware maintains SA context in memory allocated
> by software. Each SA context is 128 byte aligned and size of
> each context is multiple of 128-byte. Add support for transport
> and tunnel ipsec mode, ESP protocol, aead aes-gcm-icv16, key size
> 128/192/256-bits with 32bit salt.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v2->v3:
>  - Removed memset to zero wherever possible
>   (comment from Kalesh Anakkur Purayil)
>  - Corrected error hanlding when setting SA for inbound
>    (comment from Kalesh Anakkur Purayil)
>  - Move "netdev->xfrmdev_ops = &cn10k_ipsec_xfrmdev_ops;" to this patch
>    This fix build error with W=1
> 
>  .../marvell/octeontx2/nic/cn10k_ipsec.c       | 452 ++++++++++++++++++
>  .../marvell/octeontx2/nic/cn10k_ipsec.h       | 114 +++++
>  2 files changed, 566 insertions(+)

<...>

> +static int cn10k_ipsec_validate_state(struct xfrm_state *x)
> +{
> +	struct net_device *netdev = x->xso.dev;
> +
> +	if (x->props.aalgo != SADB_AALG_NONE) {
> +		netdev_err(netdev, "Cannot offload authenticated xfrm states\n");
> +		return -EINVAL;
> +	}
> +	if (x->props.ealgo != SADB_X_EALG_AES_GCM_ICV16) {
> +		netdev_err(netdev, "Only AES-GCM-ICV16 xfrm state may be offloaded\n");
> +		return -EINVAL;
> +	}
> +	if (x->props.calgo != SADB_X_CALG_NONE) {
> +		netdev_err(netdev, "Cannot offload compressed xfrm states\n");
> +		return -EINVAL;
> +	}
> +	if (x->props.flags & XFRM_STATE_ESN) {
> +		netdev_err(netdev, "Cannot offload ESN xfrm states\n");
> +		return -EINVAL;
> +	}

I afraid that this check will cause for this offload to be unusable in
real life scenarios. It is hard to imagine that someone will use offload
which requires rekeying every 2^32 packets.

> +	if (x->props.family != AF_INET && x->props.family != AF_INET6) {
> +		netdev_err(netdev, "Only IPv4/v6 xfrm states may be offloaded\n");
> +		return -EINVAL;
> +	}
> +	if (x->props.mode != XFRM_MODE_TRANSPORT &&
> +	    x->props.mode != XFRM_MODE_TUNNEL) {
> +		dev_info(&netdev->dev, "Only tunnel/transport xfrm states may be offloaded\n");
> +		return -EINVAL;
> +	}
> +	if (x->id.proto != IPPROTO_ESP) {
> +		netdev_err(netdev, "Only ESP xfrm state may be offloaded\n");
> +		return -EINVAL;
> +	}
> +	if (x->encap) {
> +		netdev_err(netdev, "Encapsulated xfrm state may not be offloaded\n");
> +		return -EINVAL;
> +	}
> +	if (!x->aead) {
> +		netdev_err(netdev, "Cannot offload xfrm states without aead\n");
> +		return -EINVAL;
> +	}
> +
> +	if (x->aead->alg_icv_len != 128) {
> +		netdev_err(netdev, "Cannot offload xfrm states with AEAD ICV length other than 128bit\n");
> +		return -EINVAL;
> +	}
> +	if (x->aead->alg_key_len != 128 + 32 &&
> +	    x->aead->alg_key_len != 192 + 32 &&
> +	    x->aead->alg_key_len != 256 + 32) {
> +		netdev_err(netdev, "Cannot offload xfrm states with AEAD key length other than 128/192/256bit\n");
> +		return -EINVAL;
> +	}
> +	if (x->tfcpad) {
> +		netdev_err(netdev, "Cannot offload xfrm states with tfc padding\n");
> +		return -EINVAL;
> +	}
> +	if (!x->geniv) {
> +		netdev_err(netdev, "Cannot offload xfrm states without geniv\n");
> +		return -EINVAL;
> +	}
> +	if (strcmp(x->geniv, "seqiv")) {
> +		netdev_err(netdev, "Cannot offload xfrm states with geniv other than seqiv\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

I don't see check for supported offload type among these checks.
if (x->xso.type != XFRM_DEV_OFFLOAD_CRYPTO) {
 ....


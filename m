Return-Path: <netdev+bounces-122445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E2961605
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 19:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25501F240B9
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A71CFEBC;
	Tue, 27 Aug 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY1D+SDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C811CDA3C;
	Tue, 27 Aug 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781253; cv=none; b=sHWwnya2fRVIUNvNKEv/ilsXvmY8QOQlqKH90xCYuUbZvNfXjJ6kmqKQoPFeNb8UzDAZtlbydT9BDzq24Rl/ggdPmK/1oIf0CcSmd1ayMuZdEOjkWe/HViPGDdb0LtLRQe6bAL4+JbyuKKqdtWBxm9g+d5zAT7Uf/X9GZw1GC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781253; c=relaxed/simple;
	bh=8w5DExRTyDctlIFWIm3FFIdaZYVzpO+3H3+u6nwYWtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JF14m3YIX/w1tJZMP+XDUHGn1nlxjNiPocSj63ObDRLyZCPCG2ebyJnsY1NWPAmYBWiYGCvVEhceMLaUdllLpXHyfinNSd/Wy2d8rvf1lq/kRYnmN3aqRsyFc3Mj0uvCRw40quHIF2RWhy6fZ04EMoUFnzCJ6y42sSefvXSx4Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY1D+SDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8071C567C5;
	Tue, 27 Aug 2024 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781252;
	bh=8w5DExRTyDctlIFWIm3FFIdaZYVzpO+3H3+u6nwYWtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mY1D+SDYmFJ8Wh/wFhrWpuOkt83KaKaK6InyYTjM6yDqaky/ox4e6JIOodH2OGzRG
	 LqwqrvStTOwgkhgtdOap8rZrSpIwBf7XAoJHCfSSIGEBjm3ZVGdbWXSf893lHSHsto
	 DRlXgK/IWcFZhShWrVX9D+AFpzO/JlRAv9hwxPGOcl01+FWBHG2kgm0/gWtr81T/XK
	 nUg3nz6ykeeSlBWGHxFRTp4odL1+XLc+INm6/vKbZ+7/RwIfi8+9+e5yzl9+d+aGLd
	 n69vzXdoSQ5WgNKWPZlT0r8zSfmQyKajxNkHs6rt3nXn5SJn56n9/BuKdW6mhwNCt7
	 SApuMu2RL3qtg==
Date: Tue, 27 Aug 2024 18:54:08 +0100
From: Simon Horman <horms@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: marcin.s.wojtas@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] ethernet: marvell: Use min macro
Message-ID: <20240827175408.GR1368797@kernel.org>
References: <20240827115848.3908369-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827115848.3908369-1-yanzhen@vivo.com>

On Tue, Aug 27, 2024 at 07:58:48PM +0800, Yan Zhen wrote:
> Using the real macro is usually more intuitive and readable,
> When the original file is guaranteed to contain the minmax.h header file 
> and compile correctly.
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index d72b2d5f96db..415d2b9e63f9 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device *dev,
>  
>  	if ((ring->rx_pending == 0) || (ring->tx_pending == 0))
>  		return -EINVAL;
> -	pp->rx_ring_size = ring->rx_pending < MVNETA_MAX_RXD ?
> -		ring->rx_pending : MVNETA_MAX_RXD;
> +	pp->rx_ring_size = min(ring->rx_pending, MVNETA_MAX_RXD);

Given that the type of ring->rx_pending is __32, and MVNETA_MAX_RXD is
a positive value.

See: 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
     https://git.kernel.org/torvalds/c/80fcac55385c

>  
>  	pp->tx_ring_size = clamp_t(u16, ring->tx_pending,
>  				   MVNETA_MAX_SKB_DESCS * 2, MVNETA_MAX_TXD);
> -- 
> 2.34.1
> 
> 


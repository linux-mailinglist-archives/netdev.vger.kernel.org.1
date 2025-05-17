Return-Path: <netdev+bounces-191250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CFABA76B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E36F4A6C5B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BB2C190;
	Sat, 17 May 2025 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAEGM36P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02DD224FD;
	Sat, 17 May 2025 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747443153; cv=none; b=h+MFNAysSAB2H3KegH39+hd0TyhRWRAnfU6H5V5Ce3iPeq+5PT3wqFfV8BirJ+0e7iW81xdqDy+nSxfGb2QdqHAru7FeiTu0dcxFKEZIezH7ioXDYUAJRfoCjD6jIMgrTlQceH0S7J/k8KfqY4UGl4hwrkhkZRyEtl7MKKssH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747443153; c=relaxed/simple;
	bh=dWGybPNDenjK+NVEelTY1Dj671RHkrlN2XJR7npzoSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVzl7BI1k1Ak0RwF4SR97WCUVB3wx68MFS5Qx3O01njQD+WNvkaadqTArUjmt+29YdtMKc6W9WKkAvUTj3xaKJEzPAGZmFsIiqzOflMxzwb+4yn2kQ3wJ1Og9E+5X++0AOaAysKGLXYZMkHXuI5i7LrXKx/zUqqOnds9KCuubnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAEGM36P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D78C4CEE4;
	Sat, 17 May 2025 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747443152;
	bh=dWGybPNDenjK+NVEelTY1Dj671RHkrlN2XJR7npzoSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HAEGM36PtQ3Gn1HvEyRh+Q76i/u73gPZG4v6n+LuhYlAPriyHv4Cew40pIGdZY3OG
	 CNahwkucy500nbxTygBp5EV4bfi4JLTVzuJIJYIkeF6LbebhcjmK7oMzdoZzt5EsVL
	 HslsVLpUKLk6YfEIn2vDUd/H01WRgnk0RMhNOmKycuE6jqvDj5cqLXKcojkBAYVnyt
	 ZFoA03zcf0Euk1fOf6k4ebvbJ7IxkqcC3cnG9yCIu1d3enk2Gg22wrRs/i+SKoG01S
	 tUjdIWlTWnW5+qguEFsOmbVUhXevJfctY8hlZmiUGwb52oAh4JHpmTuCp5sqQjxPSQ
	 xgcApx79wPwtA==
Date: Fri, 16 May 2025 17:52:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zak Kemble <zakkemble@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: bcmgenet: switch to use 64bit statistics
Message-ID: <20250516175231.4049a53d@kernel.org>
In-Reply-To: <20250515145142.1415-2-zakkemble@gmail.com>
References: <20250515145142.1415-1-zakkemble@gmail.com>
	<20250515145142.1415-2-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 15:51:40 +0100 Zak Kemble wrote:
> @@ -2315,7 +2358,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  		if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
>  			netif_err(priv, rx_status, dev,
>  				  "dropping fragmented packet!\n");
> -			ring->errors++;
> +			BCMGENET_STATS64_INC(stats, fragmented_errors);

Please refrain from adding new counters in the conversion patch.

>  			dev_kfree_skb_any(skb);
>  			goto next;
>  		}

> @@ -3402,6 +3455,7 @@ static void bcmgenet_dump_tx_queue(struct bcmgenet_tx_ring *ring)
>  static void bcmgenet_timeout(struct net_device *dev, unsigned int txqueue)
>  {
>  	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	struct bcmgenet_tx_stats64 *stats = &priv->tx_rings[txqueue].stats64;
>  	u32 int1_enable = 0;
>  	unsigned int q;

Please maintain the coding style of declaring variables from longest
line to shortest. If there are dependencies the init should happen
in the body of the function.

> -static struct net_device_stats *bcmgenet_get_stats(struct net_device *dev)
> +static void bcmgenet_get_stats64(struct net_device *dev,
> +								 struct rtnl_link_stats64 *stats)

the indent is way off here, in general please try to fit in 80chars
unless the readability suffers.
-- 
pw-bot: cr


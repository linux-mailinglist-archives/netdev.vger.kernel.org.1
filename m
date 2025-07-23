Return-Path: <netdev+bounces-209481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C047BB0FAAC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 21:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B08189FD4B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8B220F4F;
	Wed, 23 Jul 2025 19:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teVvCzLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266471F12FB;
	Wed, 23 Jul 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297505; cv=none; b=NJunBjKBBzsoaUjL7Qo1OKbEDgzGamBn+r53jcrjyH2zyrPvqHkDuOCkdB6m5JsShnfjtNyTujGjAw/pk/2rp9m0AgUf9otS/zZ7pwVYdxlWnhS5t40Tr7smXLCEwDJBxAbpkHyzidgAc1ZNSllcM+hfqvQpkfe0RfU2yKxZOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297505; c=relaxed/simple;
	bh=dB9aMMkho4Eyo38LtVF27pFMseIGeH4LeUxlOFiRBUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+OS+KYHs/QIp8Na5tulUGr0jRtGYGgAe9zLKs7cU6xVU40RVt1f3wSx5XdcGOaVRG4I+DKZM63vZ9nKsKNh2b6KHDyTysqCXhHdn/WrCHtUjcFEmdLwDWYfN4RVhYafGDAymJ0Ip8Bmsjp2WkQfdyhEEI5yTZhtR8aDYyazqps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teVvCzLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BA1C4CEF1;
	Wed, 23 Jul 2025 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753297504;
	bh=dB9aMMkho4Eyo38LtVF27pFMseIGeH4LeUxlOFiRBUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teVvCzLcBW+bidHVXbX32wwtyaJ0FyQtup2JELABRo26mV9nSeFH4wNxYXFnXsJnp
	 jZHZ4cPHHss9jfRp05+adqDbBtDCM85ZclqrSplshWktanhghvl3bri8HQKI4f2R20
	 mcBoUrjROrb07FHkWABE8pXjMEeyUbovmMDmoFpIKlnoUPvxbUFDFl7y6/tXvNnjqV
	 /HqTCeMpKNRjVQt3iB0WYodAHg1qzCcIoKWtnbTX3ynczVXX2l+Kes9PNAZTnOOTW5
	 EIZsi0i6C9VAigGKK1V6nM/xz2hyZXbGl9nn7XgWeocz0TjZuNGX0qcncRvu8uc0nd
	 v/s41pTLAzm2g==
Date: Wed, 23 Jul 2025 20:05:00 +0100
From: Simon Horman <horms@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, git@amd.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: macb: Add MACB_CAPS_QBV capability
 flag for IEEE 802.1Qbv support
Message-ID: <20250723190500.GM1036606@horms.kernel.org>
References: <20250722154111.1871292-1-vineeth.karumanchi@amd.com>
 <20250722154111.1871292-7-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722154111.1871292-7-vineeth.karumanchi@amd.com>

On Tue, Jul 22, 2025 at 09:11:11PM +0530, Vineeth Karumanchi wrote:
> The "exclude_qbv" bit in designcfg_debug1 register varies between MACB/GEM
> IP revisions, making direct register probing unreliable for
> feature detection. A capability-based approach provides consistent
> QBV support identification across the IP family
> 
> Platform support:
> - Enable MACB_CAPS_QBV for Xilinx Versal platform configuration
> - Foundation for QBV feature detection in TAPRIO implementation
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

...

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index cc33491930e3..98e56697661c 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -4601,6 +4601,10 @@ static int macb_init(struct platform_device *pdev)
>  		dev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
>  	if (bp->caps & MACB_CAPS_SG_DISABLED)
>  		dev->hw_features &= ~NETIF_F_SG;
> +	/* Enable HW_TC if hardware supports QBV */
> +	if (bp->caps & MACB_CAPS_QBV)
> +		dev->hw_features |= NETIF_F_HW_TC;
> +
>  	dev->features = dev->hw_features;
>  
>  	/* Check RX Flow Filters support.
> @@ -5345,7 +5349,7 @@ static const struct macb_config sama7g5_emac_config = {
>  static const struct macb_config versal_config = {
>  	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
>  		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
> -		MACB_CAPS_QUEUE_DISABLE,
> +		MACB_CAPS_QUEUE_DISABLE, MACB_CAPS_QBV,

Hi Vineeth,

TL;DR: I think you mean

		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_QBV,
		                       ^^^

I assume that the intention here is to set the MACB_CAPS_QBV bit of .caps.
However, because there is a comma rather than a pipe between
it and MACB_CAPS_QUEUE_DISABLE the effect is to leave .caps as
it was before, and set .dma_burst_length to MACB_CAPS_QBV.
.dma_burst_length is then overwritten on the following line.

Flagged by W=1 builds with Clang 20.1.8 and 15.1.0.

Please build your patches with W=1 and try to avoid adding warnings
it flags.

Also, while we are here, it would be nice to fix up the line wrapping so
the adjacent code is 80 columns wide or less, as is still preferred in
Networking code.

	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
		MACB_CAPS_NEED_TSUCLK | MACB_CAPS_QUEUE_DISABLE |
		MACB_CAPS_QBV,

>  	.dma_burst_length = 16,
>  	.clk_init = macb_clk_init,
>  	.init = init_reset_optional,
> -- 
> 2.34.1
> 
> 


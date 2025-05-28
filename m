Return-Path: <netdev+bounces-194020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA252AC6D98
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974091BC7E82
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888828C859;
	Wed, 28 May 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHml+0Ha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23418288C03;
	Wed, 28 May 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448777; cv=none; b=hhLCtuNd5sy6YVr6xRl77yJWwMELpCOMprads1O8qZ83rBtTKfUciKgU25cL3tgKPm3SJyF1KZ0O+SlkEwqMLoNNcvqq2MSGsnLrbQkIZ6FX689+GtAZlD1LqbI2EMl6SkF8rVgChesPFqw7Od5dT2PW4m/iNGtMZf89i/2rRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448777; c=relaxed/simple;
	bh=fpi71ToKhzI4Ih0RsP1jwKepkejd8JqAFlfm4lSaG00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=co4kDXyYan99l1tRN7a4B/UnhNZtDfYoqNYT/051+TEs1Xh0PTAq/rZR9Sut3ha/JPdnWpmKDGTY2CTmmswzBLWlgwUvjahI86dphRFnsYx1dHoOg4NvoAkGYVo7QWVyFdDjn186B2N+HYy1bbTYMLkZfRul6ITLmbHF2vnkNe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHml+0Ha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C52AC4CEE3;
	Wed, 28 May 2025 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748448776;
	bh=fpi71ToKhzI4Ih0RsP1jwKepkejd8JqAFlfm4lSaG00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHml+0HaqUcY9UrUHjk+viHrLfRKcPDgWPT5GKYfY3635zzgS4jydPVsZ3YIk4vsu
	 OxwZDw9XNvoW5fIhEPZ7OpVLSKaxF0AkY70oHc/tdtbcmW/SVAd/agOb+tGeVaauVU
	 oZfW1h1OAyBHt/ScLR4+SOj2bv8TyKYsaAEbR97TXQu3Ak/htIc3iMcOol4h3upiuj
	 sq8zzSGeyujGxUqFI8Irqn7+RzWLrEuZW22criHBa3uiE+hfg8zHBdCYkjPxfhDN0H
	 9u+rB+GdOLELUr7J3ovntiXCYTlNDcZm9eBK7FKO9oRw196ml3AuUhZG5YSliJ+39M
	 gaTpVE4liakIA==
Date: Wed, 28 May 2025 17:12:50 +0100
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: saikrishnag@marvell.com, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix swapped TX stats for MII
 interfaces.
Message-ID: <20250528161250.GE1484967@horms.kernel.org>
References: <20250527121325.479334-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527121325.479334-1-m-malladi@ti.com>

On Tue, May 27, 2025 at 05:43:25PM +0530, Meghana Malladi wrote:
> In MII mode, Tx lines are swapped for port0 and port1, which means
> Tx port0 receives data from PRU1 and the Tx port1 receives data from
> PRU0. This is an expected hardware behavior and reading the Tx stats
> needs to be handled accordingly in the driver. Update the driver to
> read Tx stats from the PRU1 for port0 and PRU0 for port1.
> 
> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_stats.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index 6f0edae38ea2..0b77930b2f08 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -29,6 +29,10 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>  	spin_lock(&prueth->stats_lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {

Hi Meghana,

Perhaps it would be nice to include a comment here.

> +		if (emac->phy_if == PHY_INTERFACE_MODE_MII &&
> +		    icssg_all_miig_stats[i].offset >= ICSSG_TX_PACKET_OFFSET &&
> +		    icssg_all_miig_stats[i].offset <= ICSSG_TX_BYTE_OFFSET)
> +			base = stats_base[slice ^ 1];
>  		regmap_read(prueth->miig_rt,
>  			    base + icssg_all_miig_stats[i].offset,
>  			    &val);
> 
> base-commit: 32374234ab0101881e7d0c6a8ef7ebce566c46c9
> -- 
> 2.43.0
> 
> 


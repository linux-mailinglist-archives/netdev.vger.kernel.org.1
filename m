Return-Path: <netdev+bounces-104463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41290C9DB
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D1C1F22F93
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204FE156C5E;
	Tue, 18 Jun 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1ZTi43O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB7DDDA;
	Tue, 18 Jun 2024 10:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718708226; cv=none; b=JTbZDBrbmi29nS/6AG5r6FYNUJZLFHJzTiaFRz+ITnA384fFkvbRZ6bMaV5o9byYLfTIQnDiNN7jTY3zUwjTwx4sZqncXZcJ6W2FmuolhUFEG1cbpLTbo8wiRdBplNa3oJBK/04HpEzMvYnqUSyracWA8erJ2HyOYXpR+tHt2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718708226; c=relaxed/simple;
	bh=XG0My1/c07ozmDk65TvEOPJoQ8jeo+r+3UR7UrRFX9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fDIuflyw/02VwP3rwS2OMfWVTqEuEFc8hqmLaGyszto8/5z3K8d09gklzMfXh+ua3GlHD4mj+T8fpD/iQ8jyNYH/ypdgIR7jDa1444PABOu3SnKTtio2DPW/xoFCGZSt0v4+JLEdCM0K9bRN/G5h0VHPHHzwpkDbcmBtwuiZCUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1ZTi43O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEDC4AF48;
	Tue, 18 Jun 2024 10:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718708225;
	bh=XG0My1/c07ozmDk65TvEOPJoQ8jeo+r+3UR7UrRFX9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1ZTi43OV4DFMNq83eALZBNS3qIlWr5eADtosWX4DgtESBzUNdTR/d2EzaJmsu/bO
	 cnMqrA0Ud+oRE5gVAefVlysGPl7G7oSxTN6bepTEZBfDUmO0Jlpb7FU80CWs+LcjLI
	 BiASfcHx02cUPHf15TKw0hKk3Rp+mhHAxq45ZCKz5VUiDeFkuqE0oL8QEiGlw4p73A
	 t39OEeM3WlcMTMZaDOftM2hoeGgbGwtN2HytKqCDaLMHt/Y5GCh9th8sfOXzUhvKQJ
	 EPXVN7uLfojG1BRJvKdq+b9SfOWltzE8MgxKt+eJJ9LY02fZzf7sTfd974GDmXeKTx
	 mjfcSoil3sgiA==
Date: Tue, 18 Jun 2024 11:56:59 +0100
From: Simon Horman <horms@kernel.org>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v6 3/4] net: macb: Add ARP support to WOL
Message-ID: <20240618105659.GL8447@kernel.org>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
 <20240617070413.2291511-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617070413.2291511-4-vineeth.karumanchi@amd.com>

On Mon, Jun 17, 2024 at 12:34:12PM +0530, Vineeth Karumanchi wrote:
> Extend wake-on LAN support with an ARP packet.
> 
> Currently, if PHY supports WOL, ethtool ignores the modes supported
> by MACB. This change extends the WOL modes with MACB supported modes.
> 
> Advertise wake-on LAN supported modes by default without relying on
> dt node. By default, wake-on LAN will be in disabled state.
> Using ethtool, users can enable/disable or choose packet types.
> 
> For wake-on LAN via ARP, ensure the IP address is assigned and
> report an error otherwise.
> 
> Co-developed-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

...

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c

...

> @@ -84,8 +85,7 @@ struct sifive_fu540_macb_mgmt {
>  #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
>  #define MACB_NETIF_LSO		NETIF_F_TSO
>  
> -#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
> -#define MACB_WOL_ENABLED		(0x1 << 1)
> +#define MACB_WOL_ENABLED		(0x1 << 0)


nit: BIT() could be used here

>  
>  #define HS_SPEED_10000M			4
>  #define MACB_SERDES_RATE_10G		1

...

> @@ -5290,6 +5289,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		macb_writel(bp, TSR, -1);
>  		macb_writel(bp, RSR, -1);
>  
> +		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
> +		if (bp->wolopts & WAKE_ARP) {
> +			tmp |= MACB_BIT(ARP);
> +			/* write IP address into register */
> +			tmp |= MACB_BFEXT(IP,
> +					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));

Hi Vineeth and Harini,

I guess I must be reading this wrong, beause I am confused
by the intent of the endeness handling above.

* ifa->ifa_local is a 32-bit big-endian value

* It's address is cast to a 32-bit host-endian pointer

  nit: I think u32 would be preferable to uint32_t; this is kernel code.

* The value at this address is then converted to a host byte order value.

  nit: Why is cpu_to_be32p() used here instead of the more commonly used
       cpu_to_be32() ?

  More importantly, why is a host byte order value being converted from
  big-endian to host byte order?

* The value returned by cpu_to_be32p, which is big-endian, because
  that is what that function does, is then cast to host-byte order.


So overall we have:

1. Cast from big endian to host byte order
2. Conversion from host byte order to big endian
   (a bytes-swap on litte endian hosts; no-op on big endian hosts)
3. Cast from big endian to host byte oder

All three of these steps seem to warrant explanation.
And the combination is confusing to say the least.


> +		}
> +
>  		/* Change interrupt handler and
>  		 * Enable WoL IRQ on queue 0

...


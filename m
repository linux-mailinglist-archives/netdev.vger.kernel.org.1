Return-Path: <netdev+bounces-133458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21652995FE6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7BB212B2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2912B16631C;
	Wed,  9 Oct 2024 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f2AI7niu"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D58156F3C;
	Wed,  9 Oct 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455821; cv=none; b=OZsdGkqxxczk5QO9Qn1s1GPGUm3WOUrK1TyQ6LBOhyYzIjgck3vWu8DiJbZWVYJkRldEKmANzMoas24/steSCnEm81bflSbAbA9eQz4BtqAf5oVEl0HoE04QHSPjQWnvJHd8aTFQ4nkH238DNEjQk+py7F6gC1/rTB/dTVF+thk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455821; c=relaxed/simple;
	bh=AaLqVxaupLR0sEXa/2tWFqEe/cv7ifA21p0aqhxNXOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiEEtW4oPyEpJsXR3sP/7uCF6Yyco0RU8NAQMXtPFTgsOYb7lmluYddo+Bpywk3qKRGS9sFYJzUUDuFnoFraWmetMTQSzo9JGmOUbLn6E4uYmnWvQeJLA3B3Ujj3Md3d5sJvc0vchtR/Zo7QW8vafXxmHRYw9dvxcCfzvlp7twM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f2AI7niu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32D44240007;
	Wed,  9 Oct 2024 06:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728455815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtxIDRFov/vKrkS/Ks82oNZDDvCA5GB9lCrtAL2Nn8M=;
	b=f2AI7niut6cq82o+3vmyU75orEdC2gWnzdyEo/PrcHjY/gltGfLqaDJRzVCVWcaYuyHO19
	2kY8lg64xjeyRqSV4E6rtqQXXiU2fCZJUd/QfRGgoxG+OuaM0F7AVu6pBmHhzcMvq7sPpK
	EDAQUIa8v4g9ssHk9xdmHx5ppEGn2r10iz9TcQQvFSzxKY7f+z1eIgS2AyRHw5YhT8Izvb
	Gqan5Ix1U5Z/gL29++R0tWEpjcF7zAk4WslvWmmq5lr+8ZinA53oamxMBFIpOyr85bhYpA
	dePMaEgMYvQeZSYKHoUBscIzoc3B7Av8HcLqexupf59PIBYjCfMVtCxBB2Iibw==
Date: Wed, 9 Oct 2024 08:36:53 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
 <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linux@armlinux.org.uk>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: Re: [RFC PATCH net-next 4/5] net: macb: Configure High Speed Mac
 for given speed.
Message-ID: <20241009083653.3b4ffd6d@device-21.home>
In-Reply-To: <20241009053946.3198805-5-vineeth.karumanchi@amd.com>
References: <20241009053946.3198805-1-vineeth.karumanchi@amd.com>
	<20241009053946.3198805-5-vineeth.karumanchi@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Wed, 9 Oct 2024 11:09:45 +0530
Vineeth Karumanchi <vineeth.karumanchi@amd.com> wrote:

> HS Mac configuration steps:
> - Configure speed and serdes rate bits of USX_CONTROL register from
>   user specified speed in the device-tree.
> - Enable HS Mac for 5G and 10G speeds.
> - Reset RX receive path to achieve USX block lock for the
>   configured serdes rate.
> - Wait for USX block lock synchronization.
> 
> Move the initialization instances to macb_usx_pcs_link_up().
> 
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

[...]

>  
>  /* DMA buffer descriptor might be different size
>   * depends on hardware configuration:
> @@ -564,14 +565,59 @@ static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
>  				 int duplex)
>  {
>  	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
> -	u32 config;
> +	u32 speed_val, serdes_rate, config;
> +	bool hs_mac = false;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		speed_val = HS_SPEED_1000M;
> +		serdes_rate = MACB_SERDES_RATE_1G;
> +		break;
> +	case SPEED_2500:
> +		speed_val = HS_SPEED_2500M;
> +		serdes_rate = MACB_SERDES_RATE_2_5G;
> +		break;
> +	case SPEED_5000:
> +		speed_val = HS_SPEED_5000M;
> +		serdes_rate = MACB_SERDES_RATE_5G;
> +		hs_mac = true;
> +		break;

You support some new speeds and modes, so you also need to update :

 - The macb_select_pcs() code, as right now it will return NULL for any
mode that isn't 10GBaseR or SGMII, so for 2500/5000 speeds, that
probably won't work. And for 1000, the default PCS will be used and not
USX

 - the phylink mac_capabilities, so far 2500 and 5000 speeds aren't
reported as supported.

 - the phylink supported_interfaces, I suppose the IP uses 2500BaseX
and 5GBaseT ? or maybe some usxgmii flavors ?

> +	case SPEED_10000:
> +		speed_val = HS_SPEED_10000M;
> +		serdes_rate = MACB_SERDES_RATE_10G;
> +		hs_mac = true;
> +		break;
> +	default:
> +		netdev_err(bp->dev, "Specified speed not supported\n");
> +		return;
> +	}
> +
> +	/* Enable HS MAC for high speeds */
> +	if (hs_mac) {
> +		config = macb_or_gem_readl(bp, NCR);
> +		config |= GEM_BIT(ENABLE_HS_MAC);
> +		macb_or_gem_writel(bp, NCR, config);
> +	}

It looks like you moved the MAC selection between HS MAC and non-HS MAC
from the phylink .mac_config to PCS config.

This configuration is indeed a MAC-side configuration from what I
understand, you shouldn't need to set that in PCS code. Maybe instead,
check the interface mode in macb_mac_config, and look if you're in
5GBaseR / 10GBaseR to select the MAC ?

Thanks,

Maxime


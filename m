Return-Path: <netdev+bounces-204916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A1AFC844
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FFF83A9413
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8C241CBA;
	Tue,  8 Jul 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EtfpzEtq"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9624B20C000;
	Tue,  8 Jul 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751970171; cv=none; b=WUTlhUnQPuft9S5xurXUbWnQ3yTwE6iGNs7TsXNFEKz2Uf1NJ+gfyGzMUjcpCUOlcJbER03L0ittdR6s6qAUE3IdYH7x0xAS7e7wLovJg4sGhDNCOH8HngcGk1vd69AsEkeVHyNOU6eBb0Pqww45hVQO1xRozHKd7tPMbvWrrUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751970171; c=relaxed/simple;
	bh=YtEADF3lFuj3Z5pMye6Y/M18yeKy3rho+TrgFJuM+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmlSRhb6kygx0y97caWWiB7BNw5zSwHvcxd0d0LpANqUyi/51wYk0I/AvVApr5KHNGd6yYiMw4q36Kfw7QDa1yuf9qIvP2PWWeFp4RguCZ9h5gmp3DeWbIh94slF0gx67OGIoOf/ADiViUjYl8ckPxUPuNbg1VDnBN/B4nNpRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EtfpzEtq; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C81C1FCF0;
	Tue,  8 Jul 2025 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751970160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMltJK2jiEp2y6nrc3nJjItX/hovb2my2FZRg2UaWog=;
	b=EtfpzEtq3AGL3tizdCjYquOunIRzmjz3c7QDmxkwzOBGVHg2jMrfMyjGPb0vdiCLdY7g1Y
	4pgA9frjRF3i7RrO0o5C5UAtDjfSn3o8DnF97M6CatLSY3uDMcwSnPOP1z+rQxLbcGS6FU
	/JLTyYRCYTC9eD2u4lkZC5KEqNZNTwvcrUASdvKiY4xx0fsiDIKmolnT5CJXaJW7EThper
	9imBCfUN9FskkaMR2SMycsJQfFBRvIbEOfsNLwKaf+KHDQ2UwKuAEzMnQTz9iD9Hyx7gUA
	nZHXOF+QWRVt/T9JrnG6hKrdclB042Zp21JGECQBpFVYNSeeS0aH36dIJLyPQg==
Date: Tue, 8 Jul 2025 12:22:37 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: <Tristram.Ha@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
 <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6 v2] net: dsa: microchip: Setup fiber ports
 for KSZ8463
Message-ID: <20250708122237.08f4dd7c@device-24.home>
In-Reply-To: <20250708031648.6703-7-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
	<20250708031648.6703-7-Tristram.Ha@microchip.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefgeegvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepuggvvhhitggvqddvgedrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepvfhrihhsthhrrghmrdfjrgesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopeifohhojhhunhhgrdhhuhhhsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtoheprghnughrvgifs
 ehluhhnnhdrtghhpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Tristram,

On Mon, 7 Jul 2025 20:16:48 -0700
<Tristram.Ha@microchip.com> wrote:

> From: Tristram Ha <tristram.ha@microchip.com>
> 
> The fiber ports in KSZ8463 cannot be detected internally, so it requires
> specifying that condition in the device tree.  Like the one used in
> Micrel PHY the port link can only be read and there is no write to the
> PHY.  The driver programs registers to operate fiber ports correctly.
> 
> The PTP function of the switch is also turned off as it may interfere the
> normal operation of the MAC.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz8.c       | 26 ++++++++++++++++++++++++++
>  drivers/net/dsa/microchip/ksz_common.c |  3 +++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 904db68e11f3..1207879ef80c 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -1715,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
>  	const u32 *masks;
>  	const u16 *regs;
>  	u8 remote;
> +	u8 fiber_ports = 0;
>  	int i;
>  
>  	masks = dev->info->masks;
> @@ -1745,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
>  		else
>  			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
>  				     PORT_FORCE_FLOW_CTRL, false);
> +		if (p->fiber)
> +			fiber_ports |= (1 << i);
> +	}
> +	if (ksz_is_ksz8463(dev)) {
> +		/* Setup fiber ports. */

What does fiber port mean ? Is it 100BaseFX ? As this configuration is
done only for the CPU port (it seems), looks like this mode is planned
to be used as the MAC to MAC mode on the DSA conduit. So, instead of
using this property maybe you should implement that as handling the
"100base-x" phy-mode ?

> +		if (fiber_ports) {
> +			regmap_update_bits(ksz_regmap_16(dev),
> +					   reg16(dev, KSZ8463_REG_CFG_CTRL),
> +					   fiber_ports << PORT_COPPER_MODE_S,
> +					   0);
> +			regmap_update_bits(ksz_regmap_16(dev),
> +					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
> +					   COPPER_RECEIVE_ADJUSTMENT, 0);
> +		}
> +
> +		/* Turn off PTP function as the switch's proprietary way of
> +		 * handling timestamp is not supported in current Linux PTP
> +		 * stack implementation.
> +		 */
> +		regmap_update_bits(ksz_regmap_16(dev),
> +				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
> +				   PTP_ENABLE, 0);
> +		regmap_update_bits(ksz_regmap_16(dev),
> +				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
> +				   PTP_CLK_ENABLE, 0);
>  	}
>  }
>  
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index c08e6578a0df..b3153b45ced9 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -5441,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *dev)
>  						&dev->ports[port_num].interface);
>  
>  				ksz_parse_rgmii_delay(dev, port_num, port);
> +				dev->ports[port_num].fiber =
> +					of_property_read_bool(port,
> +							      "micrel,fiber-mode");

Shouldn't this be described in the binding ?

>  			}
>  			of_node_put(ports);
>  		}
Maxime


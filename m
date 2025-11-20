Return-Path: <netdev+bounces-240524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A39C75DA5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 19:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A534E0C8
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174053242AC;
	Thu, 20 Nov 2025 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h8v8Sofx"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CB12F49ED
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661365; cv=none; b=thets3uCX+mt2hYA64wnqh4SczS4CtvmiIlxSqtC7hGFdpkYBY8DxjMyusEuQwnRlG2HjAVfzM+grwq9iAHGskCJQWsQjZjcXRiV5oKuj32/SrcSal+ZXbAo4j6cAgruKAPn88zWI31kxhqzeV/lemw7ffbOEYz83hSwYkwawB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661365; c=relaxed/simple;
	bh=F/jqVffqlRniZ/JxFFzF1jkPrZAwpES5aiVsT6UqOsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYbWorFcxdSnBWZL7RMx7pIeSoXnPt+X9/VF1Zb98V5gB1tREClCW1pL563u+NKel09QYfGUJhlRKjcAtF9hwyCGdfqQyamCi3FY5AcrMreUo4dXVafYIN/opBNPb71pRB2zEH9I5kChDZJf25gVLFHivwX7cqXMq2VW+OlDXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h8v8Sofx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8F1D64E4180E;
	Thu, 20 Nov 2025 17:56:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4812E606F6;
	Thu, 20 Nov 2025 17:56:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D86710371681;
	Thu, 20 Nov 2025 18:55:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763661359; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=opCu9tUZ6dRzs3DchMoGWzKEXJzOmo4cOtB3ot/QnO0=;
	b=h8v8SofxLa3tiz/piFnvN2V8bdEG+Rrc9HWAtWjuQ+9+iwWJ4C8EbIlIpv1i/poQ2i+d4s
	4ea2ZgnC2j4VXnTbw+yySXpA1ItxYFi7vgfkiofsZ7wvFPdBZaZa+/jrpdylm4X3eIks4f
	SDz2mNR9ZsVHGFbsR2sSNK/p0rlA/GyN9RQmi8dYvVJ3rUBZbqZQSslmsb9FpLV3OZUqsW
	al1DzUoExKJwWkPNVVMqqgomkgAZd82TA968mnCQvNJJHJOjZUSY2c57upiUGAQ/M7U6sj
	Bpv99idY/jXmO7pc1MpSk6i8rTATT0l1Qn4DXXrvX9YAJTrrOe9hBXSeXyIsRQ==
Message-ID: <c1e5871d-2954-4595-b879-e51766b7bf48@bootlin.com>
Date: Thu, 20 Nov 2025 18:55:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/15] net: mdio: add generic driver for NXP
 SJA1110 100BASE-TX embedded PHYs
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-5-vladimir.oltean@nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251118190530.580267-5-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Vladimir,

On 18/11/2025 20:05, Vladimir Oltean wrote:
> This is the standalone variant of drivers/net/dsa/sja1105/sja1105_mdio.c.
> Same kind of differences between this driver and the embedded DSA one
> apply: regmap is being used for register access, and addresses are
> multiplied by 4 with regmap.
> 
> In fact this is so generic that there is nothing NXP SJA1110 specific
> about it at all, and just instantiates mdio-regmap. I decided to name it
> mdio-regmap-simple.c in the style of drivers/mfd/simple-mfd-i2c.c which
> has support for various vendor compatible strings.
> 
> Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  MAINTAINERS                           |  1 +
>  drivers/net/mdio/Kconfig              | 14 +++--
>  drivers/net/mdio/Makefile             |  1 +
>  drivers/net/mdio/mdio-regmap-simple.c | 77 +++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/mdio/mdio-regmap-simple.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c41b9d86c144..81c3dba6acd0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15473,6 +15473,7 @@ M:	Maxime Chevallier <maxime.chevallier@bootlin.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/mdio/mdio-regmap.c
> +F:	drivers/net/mdio/mdio-regmap-simple.c
>  F:	include/linux/mdio/mdio-regmap.h
>  
>  MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 9819d1dc18de..2f86a438a2a7 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -179,14 +179,22 @@ config MDIO_REALTEK_RTL9300
>  config MDIO_REGMAP
>  	tristate
>  	help
> -	  This driver allows using MDIO devices that are not sitting on a
> -	  regular MDIO bus, but still exposes the standard 802.3 register
> +	  This support module allows using MDIO devices that are not sitting on
> +	  a regular MDIO bus, but still exposes the standard 802.3 register
>  	  layout. It's regmap-based so that it can be used on integrated,
>  	  memory-mapped PHYs, SPI PHYs and so on. A new virtual MDIO bus is
>  	  created, and its read/write operations are mapped to the underlying
> -	  regmap. Users willing to use this driver must explicitly select
> +	  regmap. Users willing to use this module must explicitly select
>  	  REGMAP.

Thans for fixing these mistakes

>  
> +config MDIO_REGMAP_SIMPLE
> +	tristate
> +	help
> +	  Generic platform driver for MDIO buses with a linear address space
> +	  that can be directly accessed using the MDIO_REGMAP support code and
> +	  need no special handling. The regmap is provided by the parent
> +	  device.
> +

It would probably make sense to add "select MDIO_REGMAP" here

>  config MDIO_THUNDER
>  	tristate "ThunderX SOCs MDIO buses"
>  	depends on 64BIT
> diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> index 9abf20d1b030..95f201b73a7d 100644
> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
>  obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
>  obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
>  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
> +obj-$(CONFIG_MDIO_REGMAP_SIMPLE)	+= mdio-regmap-simple.o
>  obj-$(CONFIG_MDIO_SJA1110_CBT1)		+= mdio-sja1110-cbt1.o
>  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
>  obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
> diff --git a/drivers/net/mdio/mdio-regmap-simple.c b/drivers/net/mdio/mdio-regmap-simple.c
> new file mode 100644
> index 000000000000..6ac390ec759b
> --- /dev/null
> +++ b/drivers/net/mdio/mdio-regmap-simple.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2025 NXP
> + *
> + * Generic MDIO bus driver for simple regmap-based MDIO devices
> + *
> + * This driver creates MDIO buses for devices that expose their internal
> + * PHYs or PCS through a regmap interface. It's intended to be a simple,
> + * generic driver similar to simple-mfd-i2c.c.
> + */
> +#include <linux/module.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/mdio/mdio-regmap.h>
> +
> +struct mdio_regmap_simple_data {
> +	u8 valid_addr;
> +	bool autoscan;
> +};
> +
> +static const struct mdio_regmap_simple_data nxp_sja1110_base_tx = {
> +	.valid_addr = 0,
> +	.autoscan = false,
> +};
> +
> +static int mdio_regmap_simple_probe(struct platform_device *pdev)
> +{
> +	const struct mdio_regmap_simple_data *data;
> +	struct mdio_regmap_config config = {};
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	struct mii_bus *bus;
> +
> +	if (!dev->of_node || !dev->parent)
> +		return -ENODEV;
> +
> +	regmap = dev_get_regmap(dev->parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	data = device_get_match_data(dev);
> +
> +	config.regmap = regmap;
> +	config.parent = dev;
> +	config.name = dev_name(dev);
> +	config.resource = platform_get_resource(pdev, IORESOURCE_REG, 0);

Just to clarify, a small comment to say that it's OK of
platform_get_resource() returns NULL maybe ?

> +	if (data) {
> +		config.valid_addr = data->valid_addr;
> +		config.autoscan = data->autoscan;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(devm_mdio_regmap_register(dev, &config));
> +}
> +
> +static const struct of_device_id mdio_regmap_simple_match[] = {
> +	{
> +		.compatible = "nxp,sja1110-base-tx-mdio",
> +		.data = &nxp_sja1110_base_tx,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, mdio_regmap_simple_match);
> +
> +static struct platform_driver mdio_regmap_simple_driver = {
> +	.probe = mdio_regmap_simple_probe,
> +	.driver = {
> +		.name = "mdio-regmap-simple",
> +		.of_match_table = mdio_regmap_simple_match,
> +	},
> +};
> +
> +module_platform_driver(mdio_regmap_simple_driver);
> +
> +MODULE_DESCRIPTION("Generic MDIO bus driver for simple regmap-based devices");
> +MODULE_AUTHOR("Vladimir Oltean <vladimir.oltean@nxp.com>");
> +MODULE_LICENSE("GPL");

Thanks for this,

Maxime


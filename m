Return-Path: <netdev+bounces-149976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01B9E85C5
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7EE164F54
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249E14B075;
	Sun,  8 Dec 2024 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gO8NLcl6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062D149C4D;
	Sun,  8 Dec 2024 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670855; cv=none; b=QTgnS5RbjfoC2Y0LQ+9DcUYb3hCmfRwr5h8Ze+3z/GfRXndOhRx23dhImnZ2ZMPBvr/bpzeHWV4tVLMCpzEYpo0wBIA9nWtnYbMrqli3nvo33r99cSZ13RguqUDsrDIGpkZ8p7N2QQMH48xfQyhf1H6bYMzK5amGOiZ/eoHWaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670855; c=relaxed/simple;
	bh=wh/UWvUGZcgZWokg44nR1/nimiwZ3IkP8kiQTpA5G/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U7DUDsu5vlRnaHKdrcCrI4YXcffdaBlNDK8EYwVsGm5vEAecKMpi3BxXd9xCqte0m9zS7IwX+Cexm7HJU0xLhHWwmTL2vsN3F43zellMLxRv8ZaOBi/gWA5Zz086cyJatuu/OOoOYfB7B0Nrj/vI6SITsinEiF7dK5D4nC/xmW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gO8NLcl6; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KIyktPf7LKnkaKIyltSzZs; Sun, 08 Dec 2024 16:13:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733670838;
	bh=Pdf86gR/dMKzkGH5bal5f/VQlcSO3nRfeOeV/tWrQ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gO8NLcl6a4c7J73S19642SQgukw51ysvu4UFeYagLERMwA3v+/H7FNR1ucyg22b/O
	 892EhhwK1nkrqYNwJhWHEnbzX4oz3p6BvqqVU3FrisC8HYPAmGBpaMrQ6HtSNdIiYA
	 j7ncnZNgxSM46LYgXIc9uEoAHd5zyHrmUWnerYETEQoqdkZmIfl0Kx2c2cdBe9VJ9M
	 j3ASPrpmR3ch7IO04glAVsZCjNc5V8PP4BuP3rLHtYMjqsjUoeyfaJ9O0Sqp7u1l1a
	 QA7iQdH1oEq3JfI45mXOdlzcetKOMX9WFrx1J0ViJcjXa5mP3s0QN9rRBi4dyjO21i
	 wbie9Dv7Q4GvA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 16:13:58 +0100
X-ME-IP: 90.11.132.44
Message-ID: <42f11110-7071-43c8-a4fe-df99a60bc12d@wanadoo.fr>
Date: Sun, 8 Dec 2024 16:13:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 6/9] net: mdio: Add Airoha AN8855 Switch MDIO
 Passtrough
To: Christian Marangi <ansuelsmth@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-7-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241208002105.18074-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2024 à 01:20, Christian Marangi a écrit :
> Add Airoha AN8855 Switch driver to register a MDIO passtrough as switch
> address is shared with the internal PHYs and require additional page
> handling.
> 
> This requires the upper Switch MFD to be probed and init to actually
> work.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   MAINTAINERS                    |   1 +
>   drivers/net/mdio/Kconfig       |   9 +++
>   drivers/net/mdio/Makefile      |   1 +
>   drivers/net/mdio/mdio-an8855.c | 113 +++++++++++++++++++++++++++++++++
>   4 files changed, 124 insertions(+)
>   create mode 100644 drivers/net/mdio/mdio-an8855.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f4d7c48b6e1..38c7b2362c92 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -722,6 +722,7 @@ F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
>   F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
>   F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
>   F:	drivers/mfd/airoha-an8855.c
> +F:	drivers/net/mdio/mdio-an8855.c
>   
>   AIROHA ETHERNET DRIVER
>   M:	Lorenzo Bianconi <lorenzo@kernel.org>
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 4a7a303be2f7..64fc5c3ef38b 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -61,6 +61,15 @@ config MDIO_XGENE
>   	  This module provides a driver for the MDIO busses found in the
>   	  APM X-Gene SoC's.
>   
> +config MDIO_AN8855
> +	tristate "Airoha AN8855 Switch MDIO bus controller"
> +	depends on MFD_AIROHA_AN8855
> +	depends on OF_MDIO
> +	help
> +	  This module provides a driver for the Airoha AN8855 Switch
> +	  that require a MDIO passtrough as switch address is shared

requires?

> +	  with the internal PHYs and require additional page handling.

requires?

> +
>   config MDIO_ASPEED
>   	tristate "ASPEED MDIO bus controller"
>   	depends on ARCH_ASPEED || COMPILE_TEST

...

> +static int an8855_mdio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct an8855_mfd_priv *priv;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	/* Get priv of MFD */
> +	priv = dev_get_drvdata(dev->parent);

Ok, forget the related comment made on patch 5/9.

> +
> +	bus = devm_mdiobus_alloc(dev);
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	bus->priv = priv;
> +	bus->name = KBUILD_MODNAME "-mii";
> +	snprintf(bus->id, MII_BUS_ID_SIZE, KBUILD_MODNAME "-%d",
> +		 priv->switch_addr);
> +	bus->parent = dev;
> +	bus->read = an8855_phy_read;
> +	bus->write = an8855_phy_write;
> +
> +	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
> +	if (ret)
> +		dev_err(dev, "failed to register MDIO bus: %d", ret);

Nitpick: Missing ending \n.
dev_err_probe() could be used.

> +
> +	return ret;
> +}

...

CJ





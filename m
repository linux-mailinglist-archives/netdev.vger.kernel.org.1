Return-Path: <netdev+bounces-149977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA39E85CA
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE098164E17
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5C14B075;
	Sun,  8 Dec 2024 15:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Eg5KF7hb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A047602D;
	Sun,  8 Dec 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671125; cv=none; b=UPofshiigOwYJo1y3Jj9vhYifrCJrDBkvuc+tMKviZFU76cigp8kgG1cFRTjtXQrQUx85OCRXJNyw1vN9Ogm4sL31vQBdgqOvd730hyBEqMq+2LzCqd0E4sJNfhlsyPwuJTW6KHSWT+NF2Yy4XS6qn8cCCequk2f+iKyRGUH8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671125; c=relaxed/simple;
	bh=2OArod8sW4RreCC6MJSPMsq0MEeKaQN+IBaRZAk6Dac=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=iJhOm89WaI0+gTag9IqFJnSz9yGTKoXJKSwGw2Py7WQiWhglKJv0aGuGs+FZhPiP5CxaR+AAt+LsB7zDRUCIrHq6RK4qi3yYVVcBWLmjEta36JD+k8BAHnoZEDZwGLsbpmPh36MSYgla59TiiNfMpS35M8LjPGNaDxOMZTBIXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Eg5KF7hb; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KIuTt5Z1GhfQMKIuTtU2lx; Sun, 08 Dec 2024 16:09:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733670570;
	bh=pDg9j4Kgs8Eh6X0ImJM0JCCi0wdfL5kuTF+nMwtl4+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=Eg5KF7hbCX3H60W9Wj+/lz92hplkkTFtPhU035C3ifPmyjDdYtby33boSWgK2ehmU
	 i1TKka2qzTofga1fFeG2f7m3UrrRnk/rFrx7YMbmguPtUklUy7DxF0L6NAloyfVmEr
	 8DaiqPQkc8mDxtUAmz2BvboAoN056pWuQdxHWvfTkDNEg6ER/XO8ggKSpSjiiaVbk2
	 HOB2EPXTlnXQL3dfxkVXu9uLiGXlDUokjR3pkeTQ/vsV900einRnEknbJsIa6w5E3y
	 G2bEtB9S9WlYrwTCx+TZSuQpvtl654wHk2lqWtXGleHxEAjF8fxO8/kasnYWuF0DBy
	 oqlqHjA5P8+qw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 16:09:30 +0100
X-ME-IP: 90.11.132.44
Message-ID: <8e9cf879-b188-4bfe-8200-f6a6ae285cb5@wanadoo.fr>
Date: Sun, 8 Dec 2024 16:09:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-6-ansuelsmth@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 "AngeloGioacchino Del Regno," <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@airoha.com
In-Reply-To: <20241208002105.18074-6-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2024 à 01:20, Christian Marangi a écrit :
> Add support for Airoha AN8855 Switch MFD that provide support for a DSA
> switch and a NVMEM provider. Also provide support for a virtual MDIO
> passthrough as the PHYs address for the switch are shared with the switch
> address
> 
> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   MAINTAINERS                           |   1 +
>   drivers/mfd/Kconfig                   |   9 +
>   drivers/mfd/Makefile                  |   1 +
>   drivers/mfd/airoha-an8855.c           | 279 ++++++++++++++++++++++++++
>   include/linux/mfd/airoha-an8855-mfd.h |  41 ++++
>   5 files changed, 331 insertions(+)
>   create mode 100644 drivers/mfd/airoha-an8855.c
>   create mode 100644 include/linux/mfd/airoha-an8855-mfd.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3e3f6938824..7f4d7c48b6e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -721,6 +721,7 @@ F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
>   F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
>   F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
>   F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> +F:	drivers/mfd/airoha-an8855.c
>   
>   AIROHA ETHERNET DRIVER
>   M:	Lorenzo Bianconi <lorenzo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index ae23b317a64e..a83db24336d9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -53,6 +53,15 @@ config MFD_ALTERA_SYSMGR
>   	  using regmap_mmio accesses for ARM32 parts and SMC calls to
>   	  EL3 for ARM64 parts.
>   
> +config MFD_AIROHA_AN8855
> +	bool "Airoha AN8855 Switch MFD"
> +	depends on MDIO && OF
> +	select MFD_CORE
> +	help
> +	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
> +	  that provide various peripherals. Currently it provides a

provides?

> +	  DSA switch and a NVMEM provider.
> +
>   config MFD_ACT8945A
>   	tristate "Active-semi ACT8945A"
>   	select MFD_CORE

...

> +static int an8855_mfd_probe(struct mdio_device *mdiodev)
> +{
> +	struct an8855_mfd_priv *priv;
> +	struct regmap *regmap;
> +
> +	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->bus = mdiodev->bus;
> +	priv->dev = &mdiodev->dev;
> +	priv->switch_addr = mdiodev->addr;
> +	/* no DMA for mdiobus, mute warning for DMA mask not set */
> +	priv->dev->dma_mask = &priv->dev->coherent_dma_mask;
> +
> +	regmap = devm_regmap_init(priv->dev, NULL, priv,
> +				  &an8855_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(priv->dev, "regmap initialization failed");

Nitpick: Missing ending \n.
Also, return dev_err_probe() could be used.

> +		return PTR_ERR(priv->dev);
> +	}
> +
> +	dev_set_drvdata(&mdiodev->dev, priv);

Is it needed?
There is no dev_get_drvdata() in this patch

> +
> +	return devm_mfd_add_devices(priv->dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
> +				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
> +				    NULL);
> +}

...

CJ


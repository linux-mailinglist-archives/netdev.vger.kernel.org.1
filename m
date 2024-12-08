Return-Path: <netdev+bounces-149978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC99E85CD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1067164E8B
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380061547E9;
	Sun,  8 Dec 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="NVD5R1Za"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECB154423;
	Sun,  8 Dec 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733671130; cv=none; b=nutM4NoO37HEN0w9aI5j/smNzufAgpS/BTDx4tiwxkSRuleE4r0uIxeEohQnEod5WHzHIIMA4bvVfkIhSlNUk9WQWlteVv+29L9ru89JWJ/XkPGXJfHLg7TtoG0Lx9bMq+kVifz82gDCalCPX+76fgznq0SE5xlOLfCN/ePKy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733671130; c=relaxed/simple;
	bh=R5AmzsmOWVfZ+ozwPcT+rU8jRuDjT8WQ01KSM0GE7w0=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=CYG4nhtiM27gB6/vqvCGGepCsjYRCKTcDVf9KvogKSegZ/hcckPqcWkoJLWnNmJX2jp17E2siTc7cl3p8skDLRpuhqbMbgmLAlSIvvVh9WGEP4eWFDIj6JGe75aQG+wa/uU9WCCmxKTxmbXGF823O74wNfrEUASKDLT8LWj6U2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=NVD5R1Za; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KJ2Gt4wpMshnBKJ2Htx9HX; Sun, 08 Dec 2024 16:17:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733671056;
	bh=sYHyziBzei7Ds+fIuSTf10OdyGFX8eHRQWgID6llsSE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=NVD5R1ZaHNxedq1m7chVBNhs7hbkpp7jxcCRsxj/UN9WAhS72VWroeG3C2EuX9RAJ
	 KGLNCyl18R3YkfyE5pftthLHGSm4jm2vyEJFAyy9kpk7v7ZMplXmt3kOQN5qrOwYvX
	 H/gjeIPrEN3+AWVs8WJ6AVXkDJ43sjGwBD/FQBfJX0Y5dZOHOMELT9CZjN4EtZMshQ
	 pL/wh0JKduCo01j9XPUktm8XSrOVoLdC4t37XsrhIGbWXcUJtipFU3QVhH8el3HFvn
	 KsOzpGHZjHS37PMRyMnHLy2x+sg3tK/OnblTpTzX9yxeKMWJRXqfK657p+E0ZRUj74
	 f4lPWNHmIUK3w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 16:17:36 +0100
X-ME-IP: 90.11.132.44
Message-ID: <118552cc-e060-45fa-b93f-9187011f2c8c@wanadoo.fr>
Date: Sun, 8 Dec 2024 16:17:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 7/9] nvmem: an8855: Add support for Airoha
 AN8855 Switch EFUSE
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-8-ansuelsmth@gmail.com>
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
In-Reply-To: <20241208002105.18074-8-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2024 à 01:20, Christian Marangi a écrit :
> Add support for Airoha AN8855 Switch EFUSE. These EFUSE might be used
> for calibration data for the internal switch PHYs.
> 
> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   MAINTAINERS                  |  1 +
>   drivers/nvmem/Kconfig        | 11 +++++++
>   drivers/nvmem/Makefile       |  2 ++
>   drivers/nvmem/an8855-efuse.c | 63 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 77 insertions(+)
>   create mode 100644 drivers/nvmem/an8855-efuse.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38c7b2362c92..a67d147276a1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -723,6 +723,7 @@ F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
>   F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
>   F:	drivers/mfd/airoha-an8855.c
>   F:	drivers/net/mdio/mdio-an8855.c
> +F:	drivers/nvmem/an8855-efuse.c
>   
>   AIROHA ETHERNET DRIVER
>   M:	Lorenzo Bianconi <lorenzo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index 8671b7c974b9..599014970c22 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -28,6 +28,17 @@ source "drivers/nvmem/layouts/Kconfig"
>   
>   # Devices
>   
> +config NVMEM_AN8855_EFUSE
> +	tristate "Airoha AN8855 eFuse support"
> +	depends on MFD_AIROHA_AN8855 || COMPILE_TEST
> +	help
> +	  Say y here to enable support for reading eFuses on Airoha AN8855
> +	  Switch. These are e.g. used to store factory programmed
> +	  calibration data required for the PHY.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called nvmem-apple-efuse.

nvmem-an8855-efuse?

> +
>   config NVMEM_APPLE_EFUSES
>   	tristate "Apple eFuse support"
>   	depends on ARCH_APPLE || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 5b77bbb6488b..c732132c0e45 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -10,6 +10,8 @@ nvmem_layouts-y			:= layouts.o
>   obj-y				+= layouts/
>   
>   # Devices
> +obj-$(CONFIG_NVMEM_AN8855_EFUSE)	+= nvmem-an8855-efuse.o
> +nvmem-an8855-efuse-y 			:= an8855-efuse.o
>   obj-$(CONFIG_NVMEM_APPLE_EFUSES)	+= nvmem-apple-efuses.o
>   nvmem-apple-efuses-y 			:= apple-efuses.o
>   obj-$(CONFIG_NVMEM_BCM_OCOTP)		+= nvmem-bcm-ocotp.o

...

> +static int an8855_efuse_probe(struct platform_device *pdev)
> +{
> +	struct nvmem_config an8855_nvmem_config = {
> +		.name = "an8855-efuse",
> +		.size = AN8855_EFUSE_CELL * sizeof(u32),
> +		.stride = sizeof(u32),
> +		.word_size = sizeof(u32),
> +		.reg_read = an8855_efuse_read,
> +	};
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +
> +	/* Assign NVMEM priv to MFD regmap */
> +	an8855_nvmem_config.priv = dev_get_regmap(dev->parent, NULL);
> +	an8855_nvmem_config.dev = dev;
> +	nvmem = devm_nvmem_register(dev, &an8855_nvmem_config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static const struct of_device_id an8855_efuse_of_match[] = {
> +	{ .compatible = "airoha,an8855-efuse", },
> +	{/* sentinel */},

No need for the ending comma.

> +};
> +MODULE_DEVICE_TABLE(of, an8855_efuse_of_match);

...

CJ




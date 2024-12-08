Return-Path: <netdev+bounces-149981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243A49E85FC
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D357A2816CD
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A394115B54A;
	Sun,  8 Dec 2024 15:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gCsCg3wX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E415A856;
	Sun,  8 Dec 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672860; cv=none; b=uHdwddKW2CCskiixN+oFnSMEZFVkSvhTMiWgU5usPnlqV+HhNuA0IKGyGozScJjdCSB5VqrRx6Wv05TE00gpSq/Dr1TYUaoNN8wSL5tNlefnM4TRpGxqNVvR27uIw7xBBEva2QBkS9qMsGszl9IGmjr3wx5Aem4AT2hZ61ObfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672860; c=relaxed/simple;
	bh=xQ4K1exiIRG5IAYZjc8fndqK1WCMWyXSPBTQIJnOpdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry5LfCTB1Q2QWPoYmMCo4x2IOtpv0JG40BnXTKRAZ1Y8DirJtqoSi04nVH4VyEsT1Kenpnc+7yaTHRZwL1ejBjTvxZKvECx2wXqOsT8XvzBocaL0FAi4iACtsVyRLKJTA/XUrNeiwb9kbXwaWuM+mxnFvFSVMcrWummtHgJJlaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gCsCg3wX; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id KJMAt37SE3iIjKJMAttwqx; Sun, 08 Dec 2024 16:38:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733672289;
	bh=jkP4yA0W2YYcfH7OhgCU7OQTCVOg6mRF/p3ZKoISHKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gCsCg3wXWXtrA8/cwqt3m8V00Ppe79nUtznNwNqBibPZN+OA03rl2CIpkOL2+p7/g
	 Exg7Vb3ssawiNNMHd4CpQnezTdm4nCv4xw9GDzCtjSZ2THh0uu8wH2AskDJgYHawtC
	 OuCDMxvntOj2Qu1EC9nhkg3VQmo3sPM1hKUwJsgTPUGr7IrcimCygl4xHYJ92mjFb0
	 u4xW6bsIs26P+XAxvHbrBONNllOYKxb5LqddozMoVkoxv9NBiFda6amJDWSNRdSj02
	 Bflcrsiu4JXQzU7bWMDwX54lu0bQfIoyTPNRcfdVEWUorRriBCaIIptIGdltb/X6J6
	 eF7JiXnijx3Bw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 08 Dec 2024 16:38:09 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f8d990ef-203e-479a-838e-13780e758ab8@wanadoo.fr>
Date: Sun, 8 Dec 2024 16:38:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v10 5/9] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
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
References: <20241208002105.18074-1-ansuelsmth@gmail.com>
 <20241208002105.18074-6-ansuelsmth@gmail.com>
 <8e9cf879-b188-4bfe-8200-f6a6ae285cb5@wanadoo.fr>
 <6755b761.050a0220.223761.2b14@mx.google.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6755b761.050a0220.223761.2b14@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/12/2024 à 16:12, Christian Marangi a écrit :
> On Sun, Dec 08, 2024 at 04:09:25PM +0100, Christophe JAILLET wrote:
>> Le 08/12/2024 à 01:20, Christian Marangi a écrit :
>>> Add support for Airoha AN8855 Switch MFD that provide support for a DSA
>>> switch and a NVMEM provider. Also provide support for a virtual MDIO
>>> passthrough as the PHYs address for the switch are shared with the switch
>>> address
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>    MAINTAINERS                           |   1 +
>>>    drivers/mfd/Kconfig                   |   9 +
>>>    drivers/mfd/Makefile                  |   1 +
>>>    drivers/mfd/airoha-an8855.c           | 279 ++++++++++++++++++++++++++
>>>    include/linux/mfd/airoha-an8855-mfd.h |  41 ++++
>>>    5 files changed, 331 insertions(+)
>>>    create mode 100644 drivers/mfd/airoha-an8855.c
>>>    create mode 100644 include/linux/mfd/airoha-an8855-mfd.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f3e3f6938824..7f4d7c48b6e1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -721,6 +721,7 @@ F:	Documentation/devicetree/bindings/mfd/airoha,an8855-mfd.yaml
>>>    F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
>>>    F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
>>>    F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
>>> +F:	drivers/mfd/airoha-an8855.c
>>>    AIROHA ETHERNET DRIVER
>>>    M:	Lorenzo Bianconi <lorenzo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index ae23b317a64e..a83db24336d9 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -53,6 +53,15 @@ config MFD_ALTERA_SYSMGR
>>>    	  using regmap_mmio accesses for ARM32 parts and SMC calls to
>>>    	  EL3 for ARM64 parts.
>>> +config MFD_AIROHA_AN8855
>>> +	bool "Airoha AN8855 Switch MFD"
>>> +	depends on MDIO && OF
>>> +	select MFD_CORE
>>> +	help
>>> +	  Support for the Airoha AN8855 Switch MFD. This is a SoC Switch
>>> +	  that provide various peripherals. Currently it provides a
>>
>> provides?
>>
>>> +	  DSA switch and a NVMEM provider.
>>> +
>>>    config MFD_ACT8945A
>>>    	tristate "Active-semi ACT8945A"
>>>    	select MFD_CORE
>>
>> ...
>>
>>> +static int an8855_mfd_probe(struct mdio_device *mdiodev)
>>> +{
>>> +	struct an8855_mfd_priv *priv;
>>> +	struct regmap *regmap;
>>> +
>>> +	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	priv->bus = mdiodev->bus;
>>> +	priv->dev = &mdiodev->dev;
>>> +	priv->switch_addr = mdiodev->addr;
>>> +	/* no DMA for mdiobus, mute warning for DMA mask not set */
>>> +	priv->dev->dma_mask = &priv->dev->coherent_dma_mask;
>>> +
>>> +	regmap = devm_regmap_init(priv->dev, NULL, priv,
>>> +				  &an8855_regmap_config);
>>> +	if (IS_ERR(regmap)) {
>>> +		dev_err(priv->dev, "regmap initialization failed");
>>
>> Nitpick: Missing ending \n.
>> Also, return dev_err_probe() could be used.
>>
> 
> Can regmap PROBE_DEFER? Or it's just common practice?

It is a common practice to easily log the error code in a human readable 
format, even when PROBE_DEFER can't happen.

It sometimes also saves 1 or 2 LoC because it may save the { } and the 
line with return.

Leaving it as-is is obviously also just fine ;-).

CJ

> 
>>> +		return PTR_ERR(priv->dev);
>>> +	}
>>> +
>>> +	dev_set_drvdata(&mdiodev->dev, priv);
>>
>> Is it needed?
>> There is no dev_get_drvdata() in this patch
>>
> 
> Yes it is, MFD child makes use of dev_get_drv_data(dev->parent) to
> access the bug and current_page.
> 
>>> +
>>> +	return devm_mfd_add_devices(priv->dev, PLATFORM_DEVID_AUTO, an8855_mfd_devs,
>>> +				    ARRAY_SIZE(an8855_mfd_devs), NULL, 0,
>>> +				    NULL);
>>> +}
>>
>> ...
>>
>> CJ
> 



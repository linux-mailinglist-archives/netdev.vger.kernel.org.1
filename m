Return-Path: <netdev+bounces-222013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 226ACB52B27
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 251A7B6062C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C62D594F;
	Thu, 11 Sep 2025 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xzYSFwwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E82BDC01;
	Thu, 11 Sep 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577861; cv=none; b=sPd5OS4dFYyauz0ichUOxU4FuFVQsSee6jv/eNXF72p54UEQhkpP+QTsWNzGmSkvSg3LkwaUDGDt6KFEpps3MJH3z6mOHyZYadpopskvudvN34RRUGCgREY0y6SVdBOe4U2Une6nIL+f5QWLtRsSAxXfYEZ8wBnYjntIxb/OQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577861; c=relaxed/simple;
	bh=wel+RQMd/D0rIIzoZJ0pNSXaqgxpgXmD2e20QHrSRYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DynvlSwlqphFinFe7I4cJalqAdABVhF1AYexTWbhZhALTxTgLNWQ1MMvCVvnOLWPFFEyTMczaUKNG4ntEhrYBEDc0y76RvMC34SS0+Hdy3IvVjB9clFM6wlNRv55Qj3RPOtpUdoW/AD7LiMcioiW8DDk4lID+KxkjM7YQv7Npro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xzYSFwwk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 34EC94E40C9C;
	Thu, 11 Sep 2025 08:04:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 006D4606BB;
	Thu, 11 Sep 2025 08:04:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9E1B8102F28ED;
	Thu, 11 Sep 2025 10:04:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757577856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DZGt3QLwJ9N71a9DCxu/GWZRlIPdeB9auBfTQxCKJG4=;
	b=xzYSFwwkxAWb8XscvM7u98ioGJL0xDga1pmOx0T9nLMF0pNno67AEMgVGWgpTLeRJRXGye
	OepoelxKsa9Pdk72ubBxung9cUGTAmRfBTDHJRQD8wJU7bNzTo5yPNmYu4biGl9RK2oM6H
	SRKoqURim92TUohmwxP30oADP9perHg+TS81tr0tk6q8Ele65W+BeHMAlFUf2rTswvj2pp
	HR7r0/2DKOL0eZbka7tGuf3z4Awc/ISo4GGgkfGffug2ycZ42c29PjGYuqhE0geCm6VfhB
	BvegShwaQzZgwQKbW4wEnrdDoyCwfDDLo8L/cmmJbozgEt3ptGxPpVeI0w10og==
Message-ID: <9c543fa2-1ac1-463b-bb1d-f89be61f7ece@bootlin.com>
Date: Thu, 11 Sep 2025 10:04:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
To: Andrew Lunn <andrew@lunn.ch>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
 <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
 <14114502-f087-4d3b-a91e-cff0dfe59045@lunn.ch>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <14114502-f087-4d3b-a91e-cff0dfe59045@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 9/10/25 6:46 PM, Andrew Lunn wrote:
>> Support the KSZ8463's strap configuration that enforces SPI as
>> communication bus, since it is the only bus supported by the driver.
> 
> So this is the key sentence for this patchset, which should of been in
> patch 0/X. You have a chicken/egg problem. You cannot talk to the
> switch to put it into SPI mode because you cannot talk to the switch
> using SPI.
> 
> The current patch descriptions, and the patches themselves don't make
> this clear. They just vaguely mention configuration via strapping.
> 

Indeed, that wasn't clear, sorry. My intention was to keep it somewhat 
'generic', since other KSZ switches also use strap configurations. I 
thought the DT property could be re-used by others to enforce different 
kinds of strap configurations.

But I agree with you, it's probably better to have something KSZ8463 
specific.

>> +static int ksz_configure_strap(struct ksz_device *dev)
> 
> Please make it clear this function straps the switch for SPI. If
> somebody does add support for I2C, they need to understand that...
> 
>> +{
>> +	struct pinctrl_state *state = NULL;
>> +	struct pinctrl *pinctrl;
>> +	int ret;
>> +
>> +	if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
> 
> I would not hide this here. Please move this if into
> ksz_switch_register(). I also think this function should have the
> ksz8463 prefix, since how you strap other devices might differ. So
> ksz8463_configure_straps_spi() ?
> 

Ack.

>> +		struct gpio_desc *rxd0;
>> +		struct gpio_desc *rxd1;
>> +
>> +		rxd0 = devm_gpiod_get_index_optional(dev->dev, "strap", 0, GPIOD_OUT_LOW);
>> +		if (IS_ERR(rxd0))
>> +			return PTR_ERR(rxd0);
>> +
>> +		rxd1 = devm_gpiod_get_index_optional(dev->dev, "strap", 1, GPIOD_OUT_HIGH);
>> +		if (IS_ERR(rxd1))
>> +			return PTR_ERR(rxd1);
>> +
>> +		/* If at least one strap definition is missing we don't do anything */
>> +		if (!rxd0 || !rxd1)
>> +			return 0;
> 
> I would say, if you have one, not two, the DT blob is broken, and you
> should return -EINVAL.
> 

Ack.

>> +
>> +		pinctrl = devm_pinctrl_get(dev->dev);
>> +		if (IS_ERR(pinctrl))
>> +			return PTR_ERR(pinctrl);
>> +
>> +		state = pinctrl_lookup_state(pinctrl, "reset");
>> +		if (IS_ERR(state))
>> +			return PTR_ERR(state);
>> +
>> +		ret = pinctrl_select_state(pinctrl, state);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int ksz_switch_register(struct ksz_device *dev)
>>   {
>>   	const struct ksz_chip_data *info;
>> @@ -5353,10 +5392,18 @@ int ksz_switch_register(struct ksz_device *dev)
>>   		return PTR_ERR(dev->reset_gpio);
>>   
>>   	if (dev->reset_gpio) {
>> +		ret = ksz_configure_strap(dev);
>> +		if (ret)
>> +			return ret;
>> +
>>   		gpiod_set_value_cansleep(dev->reset_gpio, 1);
>>   		usleep_range(10000, 12000);
>>   		gpiod_set_value_cansleep(dev->reset_gpio, 0);
>>   		msleep(100);
>> +
>> +		ret = pinctrl_select_default_state(dev->dev);
>> +		if (ret)
>> +			return ret;
> 
> This does not look symmetrical. Maybe put the
> pinctrl_select_default_state() inside a function called
> ksz8463_release_straps_spi()?
> 
>

Ack.

Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com



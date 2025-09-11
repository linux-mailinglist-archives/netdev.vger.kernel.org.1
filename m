Return-Path: <netdev+bounces-222090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF8B53017
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA61BC4C5B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 11:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D51314A65;
	Thu, 11 Sep 2025 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rg548nDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9859919A;
	Thu, 11 Sep 2025 11:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589772; cv=none; b=luBEWkBf08jrzoPXqFCg218fVVtNWeIV8J/pgq9M75j/WAgvlGaM43y7jJZGSzfMvyjfXE54fVRRmrERlogbKNUcH2RraQbr7hRP7fZM7j4E7+w+70iTmnJfveKselO05fEJ9IXM1v5VHE3m6azMfHaE8oQFT9+iXS/Sp/Hqy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589772; c=relaxed/simple;
	bh=AirdKhZqAL8setUr4V5GTYPjm/44kfeQid2fzHbOz38=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VsbZuU9YcUpEhGQFltXG0HPw35F4ofYlV+wL+X5024BI5ZIlG8KJzuqYS3iLJR1XhlrcgOb+lIH4B1PTcaidnYgNESXfapX7Cs/LX9JHRfKi18MOURyhqZZchRNlVbqY1J5GfyFyLS1hmVyqPvR5Fnyqt65QghV924wmHtlY1C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rg548nDu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B72A01A0DD2;
	Thu, 11 Sep 2025 11:22:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7F94160630;
	Thu, 11 Sep 2025 11:22:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F18F4102F29EC;
	Thu, 11 Sep 2025 13:22:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757589765; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7mHOHltEqX8B0G9kFnwXVbwYEPoEFPmOITNQtGHOL7U=;
	b=rg548nDuSFFxObCMzRXoneppAwOfrCipAzt86agMW5AYRsdyihvUj2lIlXQMffI73pflcX
	Zx4bykklolsTe7RL5UcahnEZYaZcLHi1K52nKGvNULtwiGucfw6163ReXYK5L5G41Q2utJ
	zSI9qFkWGoikYwpRvgrqwmFgrkMKsqc2YCFIcQ1+pBG0HS6SzTMrTXv4boAG0O/NVgYReg
	9UzgnquhTtNMDvPxw18DeqTEI+2cXsuXPS73qJxialxm6rHtzOJybzPV8Gh3y3UUh46wik
	UyrtIDZziscrpNbVLVv3neuG9yXMQtl9jZp3eRh38yaNZW6lFGn6LAEfxoQ9fw==
Message-ID: <c320ebea-7c3c-460b-99eb-35f1dc1a3dc3@bootlin.com>
Date: Thu, 11 Sep 2025 13:22:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: microchip: configure strap pins
 during reset
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Pascal Eberhard <pascal.eberhard@se.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250910-ksz-strap-pins-v1-0-6308bb2e139e@bootlin.com>
 <20250910-ksz-strap-pins-v1-2-6308bb2e139e@bootlin.com>
 <87y0qmb9ne.fsf@bootlin.com>
Content-Language: en-US
In-Reply-To: <87y0qmb9ne.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Miquèl,

On 9/10/25 5:38 PM, Miquel Raynal wrote:
> Hello bastien,
> 
>> +static int ksz_configure_strap(struct ksz_device *dev)
>> +{
>> +	struct pinctrl_state *state = NULL;
>> +	struct pinctrl *pinctrl;
>> +	int ret;
>> +
>> +	if (of_device_is_compatible(dev->dev->of_node, "microchip,ksz8463")) {
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
> 
> In order to simplify the pinctrl handling I would propose to replace
> these three function calls by:
> 
>        devm_pinctrl_get_select(dev->dev, "reset")
> 
> I do not think in this case we actually require the internal
> devm_pinctrl_put() calls from the above helper, but they probably do not
> hurt either.
> 

True, thank you.


Best regards,
Bastien


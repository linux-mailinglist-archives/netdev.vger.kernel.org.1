Return-Path: <netdev+bounces-123048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7557C9638A7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0281C2487E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BF545C14;
	Thu, 29 Aug 2024 03:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFE481AA;
	Thu, 29 Aug 2024 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724901077; cv=none; b=p9BqxxFRpn3XCu/5pXEWFj75QFLT6ntJ+jPHkmQxDlVaV1gmku/wwNby4/sjW0pWXsOxiBYiOyqloy8TqZDwWTgbnIzmEjAL6ZVkaJRmoJ3tq91uyHl09u5RFMz1YHWI1KRjLgDavhRmKORuilK7cYpJXMuIsWyl2PZjTpbb0Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724901077; c=relaxed/simple;
	bh=nOd7xBPx/xzI4uCpxtkVei8qfHZ2vrlBjFfCXs0HT2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jDpn9V/rKJdhdkij3rl7KLa+ZkhcqT/cc2+xj2u6BPZINM9Vdoz+nxf3Uj77l0qFBlJL2zEUxWOGGyX0D8Y4Cj0cilF76vs5Z9SfuOuDlFyOrVVi0EQYLlWzWgws8PlYdKs3Ierull6Ms4NDM1aRQ44Tq72kh/MjBmbx/tToswU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvRBD1Lx7z2DbYd;
	Thu, 29 Aug 2024 11:11:00 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F5BF1A0188;
	Thu, 29 Aug 2024 11:11:12 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 29 Aug 2024 11:11:11 +0800
Message-ID: <c696926d-748f-1969-f684-727d495c4a12@huawei.com>
Date: Thu, 29 Aug 2024 11:11:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next v2 08/13] net: mdio: mux-mmioreg: Simplified with
 dev_err_probe()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-9-ruanjinjie@huawei.com>
 <20240828134814.0000569d@Huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240828134814.0000569d@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/28 20:48, Jonathan Cameron wrote:
> On Wed, 28 Aug 2024 11:23:38 +0800
> Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Use the dev_err_probe() helper to simplify code.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Ah. I should have read next patch. Sorry!
> 
> Might be worth breaking from rule of aligning parameters
> after brackets to keep the longest line lengths down.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>> ---
>> v2:
>> - Split into 2 patches.
>> ---
>>  drivers/net/mdio/mdio-mux-mmioreg.c | 45 ++++++++++++-----------------
>>  1 file changed, 19 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/mdio/mdio-mux-mmioreg.c b/drivers/net/mdio/mdio-mux-mmioreg.c
>> index 4d87e61fec7b..08c484ccdcbe 100644
>> --- a/drivers/net/mdio/mdio-mux-mmioreg.c
>> +++ b/drivers/net/mdio/mdio-mux-mmioreg.c
>> @@ -109,30 +109,26 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  
>>  	ret = of_address_to_resource(np, 0, &res);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "could not obtain memory map for node %pOF\n",
>> -			np);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "could not obtain memory map for node %pOF\n", np);
>>  	s->phys = res.start;
>>  
>>  	s->iosize = resource_size(&res);
>>  	if (s->iosize != sizeof(uint8_t) &&
>>  	    s->iosize != sizeof(uint16_t) &&
>>  	    s->iosize != sizeof(uint32_t)) {
>> -		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
>> -		return -EINVAL;
>> +		return dev_err_probe(&pdev->dev, -EINVAL,
>> +				     "only 8/16/32-bit registers are supported\n");
>>  	}
>>  
>>  	iprop = of_get_property(np, "mux-mask", &len);
>> -	if (!iprop || len != sizeof(uint32_t)) {
>> -		dev_err(&pdev->dev, "missing or invalid mux-mask property\n");
>> -		return -ENODEV;
>> -	}
>> -	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8)) {
>> -		dev_err(&pdev->dev, "only 8/16/32-bit registers are supported\n");
>> -		return -EINVAL;
>> -	}
>> +	if (!iprop || len != sizeof(uint32_t))
>> +		return dev_err_probe(&pdev->dev, -ENODEV,
>> +				     "missing or invalid mux-mask property\n");
>> +	if (be32_to_cpup(iprop) >= BIT(s->iosize * 8))
>> +		return dev_err_probe(&pdev->dev, -EINVAL,
>> +				     "only 8/16/32-bit registers are supported\n");
>>  	s->mask = be32_to_cpup(iprop);
>>  
>>  	/*
>> @@ -142,17 +138,14 @@ static int mdio_mux_mmioreg_probe(struct platform_device *pdev)
>>  	for_each_available_child_of_node_scoped(np, np2) {
>>  		u64 reg;
>>  
>> -		if (of_property_read_reg(np2, 0, &reg, NULL)) {
>> -			dev_err(&pdev->dev, "mdio-mux child node %pOF is "
>> -				"missing a 'reg' property\n", np2);
>> -			return -ENODEV;
>> -		}
>> -		if ((u32)reg & ~s->mask) {
>> -			dev_err(&pdev->dev, "mdio-mux child node %pOF has "
>> -				"a 'reg' value with unmasked bits\n",
>> -				np2);
>> -			return -ENODEV;
>> -		}
>> +		if (of_property_read_reg(np2, 0, &reg, NULL))
>> +			return dev_err_probe(&pdev->dev, -ENODEV,
>> +					     "mdio-mux child node %pOF is missing a 'reg' property\n",
>> +					     np2);
>> +		if ((u32)reg & ~s->mask)
>> +			return dev_err_probe(&pdev->dev, -ENODEV,
>> +					     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
> I'd align these super long ones as. 
> 			     "mdio-mux child node %pOF has a 'reg' value with unmasked bits\n",
> It is ugly but then so are > 100 char lines.

It seems that this kind string > 100 char is fine for patch check script.

>> +					     np2);
>>  	}
>>  
>>  	ret = mdio_mux_init(&pdev->dev, pdev->dev.of_node,
> 


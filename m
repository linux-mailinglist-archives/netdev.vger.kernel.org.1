Return-Path: <netdev+bounces-80981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DFF885644
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525E0B2147A
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFF3D0C6;
	Thu, 21 Mar 2024 09:13:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F23A8EF
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711012436; cv=none; b=Ez6xZrJc5XKQkSTHGkNmSI4uKTW4mEoJSL/gH6PN6cVsaRdJGYQG24Cjz2x6mjxLXiucDT+jB5+/elvTnTQlkzMgEKMqHcCU3sQs6SeSMWuX1NGDqHjfshRAaREMQlf05Veerk8vo2yOdgDLyHNJ42n7nJB4N8LWgLDOuk+MVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711012436; c=relaxed/simple;
	bh=El7Lg12kFaitdq/ohqrzq61GvimKgufkhGpfdo1lhfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIOKo/S7B6kct7lNZjff6poqp0DfcHBVLqBzVZTmJcQXfwfIj+XhOx2j21MXtVW5St2N3gan2HBDnQL1wcS5eLgQFPE83BlXll62aEULGVERJIRkbI9fNiytfVCxhTB2/fXXudG17wTyN5SMZRmkhXJvHv0wwNNyZLxvh0MTuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.198])
	by gateway (Coremail) with SMTP id _____8BxHOtN+vtlvMEbAA--.56152S3;
	Thu, 21 Mar 2024 17:13:49 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.198])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjhNJ+vtlGbxfAA--.64423S3;
	Thu, 21 Mar 2024 17:13:46 +0800 (CST)
Message-ID: <a9958d92-41da-4c3a-8c57-615158c3c8a2@loongson.cn>
Date: Thu, 21 Mar 2024 17:13:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 06/11] net: stmmac: dwmac-loongson: Add GNET
 support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <027b4ee29d4d7c8a22d2f5c551f5c21ced3fb046.1706601050.git.siyanteng@loongson.cn>
 <ftqxjh67a7s4iprpiuw5xxmncj3bveezf5vust7cej3kowwcvj@m7nqrxq7oe2f>
 <d0e56c9b-9549-4061-8e44-2504b6b96897@loongson.cn>
 <466f138d-0baa-4a86-88af-c690105e650e@loongson.cn>
 <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <x6wwfvuzqpzfzstb3l5adp354z2buevo35advv7q347gnmo3zn@vfzwca5fafd3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxjhNJ+vtlGbxfAA--.64423S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFyrKFW8uF4kKFW8Zw4xGrX_yoW8Xry5pr
	ZrGayDKrZrWry7K34vvwn8ZrnavayrWw109ryUGw1jvrs0kFWxWw1Uur4UCF97CrZ5Cr1U
	Xw4jyay7ua98W3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU


在 2024/3/19 23:03, Serge Semin 写道:
>>>>>   >> +static int loongson_gnet_data(struct pci_dev *pdev,
>>>>> +			      struct plat_stmmacenet_data *plat)
>>>>> +{
>>>>> +	loongson_default_data(pdev, plat);
>>>>> +
>>>>> +	plat->multicast_filter_bins = 256;
>>>>> +
>>>>> +	plat->mdio_bus_data->phy_mask =  ~(u32)BIT(2);
>>>>> +
>>>>> +	plat->phy_addr = 2;
>>>>> +	plat->phy_interface = PHY_INTERFACE_MODE_INTERNAL;
>>>> Are you sure PHY-interface is supposed to be defined as "internal"?
>>> Yes, because the gnet hardware has a integrated PHY, so we set it to internal，
>>>
> Why do you need the phy_addr set to 2 then? Is PHY still discoverable
> on the subordinate MDIO-bus?

Because the default return value of gnet's mdio is 0xffff, when scanning 
for phy,

if the return value is not 0, it will be assumed that the phy for that 
address exists.

  Not specifying an address will cause all addresses' phy to be 
detected, and the

lowest address' phy will be selected by default. so then, the network is 
unavailable.

>
> kdoc in "include/linux/phy.h" defines the PHY_INTERFACE_MODE_INTERNAL
> mode as for a case of the MAC and PHY being combined. IIUC it's
> reserved for a case when you can't determine actual interface between
> the MAC and PHY. Is it your case? Are you sure the interface between
> MAC and PHY isn't something like GMII/RGMII/etc?
Hmmm. the interface between MAC and PHY is GMII, so let's use

PHY_INTERFACE_MODE_GMII?


Thanks,

Yanteng



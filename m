Return-Path: <netdev+bounces-64176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08983199E
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 13:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F23B20ECE
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33653241E2;
	Thu, 18 Jan 2024 12:54:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073DC13AFB
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582473; cv=none; b=IXeulI5NEkGk6ZVoNH0/oGIVOF22Km6Q0Opd87bRX3GXlXiSb7h/SceQ7rpS4V4dWKWEjoYR9OcnREoEhQfJSUgAyAxtl8d9DDjIU+NCec0610Z9B6BjQyn6mLl6xafBUT2jjZ8Jq23gfovnqVv5zRn0FVeBsu1JhIEtzGv4/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582473; c=relaxed/simple;
	bh=f7omLXCZrx7YzfVa6n3gNiLUFMoyZnrcrMuZ15lyR20=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam; b=Z5elDqgdbv2YLzncYGIHjoKa0NF5qRbeWTUTE1u9XzOVCvnWfxdIW98ChP1O87PJ74ISaAygCtes8BpJtMUomO8sX7jnODSi09el+02ch1yqgqbbNFYvUt/DIVYgH6vvB6cGITFsOG7NKa8/wkplDI8m5Z9pJnEpBw6xMf/vIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.41])
	by gateway (Coremail) with SMTP id _____8BxOPCCH6lldqYBAA--.8126S3;
	Thu, 18 Jan 2024 20:54:26 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.41])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxPs9hH6llAI8IAA--.43785S3;
	Thu, 18 Jan 2024 20:54:25 +0800 (CST)
Message-ID: <c262973f-27d3-46ed-b30d-5d1ad1f3da8f@loongson.cn>
Date: Thu, 18 Jan 2024 20:53:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/9] net: stmmac: dwmac-loongson: Refactor
 code for loongson_dwmac_probe()
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@loongson.cn, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <aee820a3c4293c8172edda27ad4eb9cf5eaead5e.1702990507.git.siyanteng@loongson.cn>
 <ZZPnaziDZEcv5GGw@shell.armlinux.org.uk>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <ZZPnaziDZEcv5GGw@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxPs9hH6llAI8IAA--.43785S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFy3ArWxuFWfAryrXFy8Xrc_yoW5Jr47p3
	95Gasrta97Jry3Crs5Xw4UZF10vrW3K34a9w43K3yI9a4DZr93XryxKrWxCFyfCrWDCw1j
	qw4jvrWkuFyqkFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j7BMNUUUUU=


在 2024/1/2 18:37, Russell King (Oracle) 写道:
> On Tue, Dec 19, 2023 at 10:17:05PM +0800, Yanteng Si wrote:
>> Add a setup() function to initialize data, and simplify code for
>> loongson_dwmac_probe().
> Not all changes in this patch are described.
Okay, I'll re-write it in more detail.
>
>> +static int loongson_gmac_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>> +{
>> +	loongson_default_data(pdev, plat);
>> +
>> +	plat->multicast_filter_bins = 256;
>> +
>> +	plat->mdio_bus_data->phy_mask = 0;
>>   
>> -	/* Default to phy auto-detection */
>>   	plat->phy_addr = -1;
>> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> This presumably sets the default phy_interface mode?
>
>
>> -	plat->bus_id = of_alias_get_id(np, "ethernet");
>> -	if (plat->bus_id < 0)
>> -		plat->bus_id = pci_dev_id(pdev);
>> +	pci_set_master(pdev);
>> +
>> +	info = (struct stmmac_pci_info *)id->driver_data;
>> +	ret = info->setup(pdev, plat);
>> +	if (ret)
>> +		goto err_disable_device;
> loongson_gmac_data() gets called from here...
>
>> +
>> +	bus_id = of_alias_get_id(np, "ethernet");
>> +	if (bus_id >= 0)
>> +		plat->bus_id = bus_id;
>>   
>>   	phy_mode = device_get_phy_mode(&pdev->dev);
>>   	if (phy_mode < 0) {
> This gets the PHY interface mode, and errors out if it can't be found in
> firmware.
>
>> @@ -110,11 +137,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	}
>>   
>>   	plat->phy_interface = phy_mode;
> So this ends up always overwriting the value written in
> loongson_gmac_data(). So it seems to be that initialising
> plat->phy_interface in loongson_gmac_data() is just patch noise and
> serves no real purpose.
>
>> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
> This has now gone - and is not described, and I'm left wondering what
> the implication of that is on the driver. It also makes me wonder
> whether loongson_gmac_data() should've been setting mac_interface
> rather than phy_interface.

You seem to have understood this in Patch 3.

I'll re-split the patch to make the code easier to understand.

>
>>   	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>>   	if (res.wol_irq < 0) {
>> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
>> +		dev_info(&pdev->dev,
>> +			 "IRQ eth_wake_irq not found, using macirq\n");
> Whitespace cleanups should be a separate patch.

OK.


Thanks,

Yanteng

>



Return-Path: <netdev+bounces-108785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF00925714
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFF01F23E07
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 09:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96A813D612;
	Wed,  3 Jul 2024 09:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C682747F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999725; cv=none; b=MC9sINWNsjgdk3lDJvnM92N+917AqXiLLRX8GfsnIbUSTYrvYyf4A5dBTKIp3vgE4/DLXQfJP4jK1EyRLNRChkkIFQDCNvWlr9GFfKhwxFSeKpHqXnSyUG+r6TiFqfLOZ8HQpx6zrgNoqOCXjIRgUlyNS1ITijzSax414VEv4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999725; c=relaxed/simple;
	bh=/Nkk+07r0gtlTJcexFll6QbvHuezlz4YnuAXhVDP5SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCt0Mo1t5OV+CmVtOtaD9FE+V1HyA+/UTamcqMF6RMJN4rS01kU9sfwofe2ED2P10ILwlNtOnqi3YOn4J/0gjRXVtqgOItYQUiVU38cdrEcW3fyiMuYohgZ6Ay2tgxfJSXwtfroPTRSOcOAuwoyhfQn3bQcakfFporIMbIZDUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.32])
	by gateway (Coremail) with SMTP id _____8Cx7+vnHIVmDngAAA--.1383S3;
	Wed, 03 Jul 2024 17:41:59 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.32])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZcXjHIVmB3U5AA--.57678S3;
	Wed, 03 Jul 2024 17:41:56 +0800 (CST)
Message-ID: <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
Date: Wed, 3 Jul 2024 17:41:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 06/15] net: stmmac: dwmac-loongson: Detach
 GMAC-specific platform data init
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b987281834a734777ad02acf96e968f05024c031.1716973237.git.siyanteng@loongson.cn>
 <io5eoyp7eq656fzrrd5htq3d7rc22tm7b5zpi6ynaoawhdb7sp@b5ydxzhtqg6x>
 <475878c7-f386-4dd3-acb8-9f5a5f1b9102@loongson.cn>
 <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <7creyrbprodoh2p2wvdx52mijqyu53ypf3dzjgx3tuawpoz4xm@cfls65sqlwq7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZcXjHIVmB3U5AA--.57678S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxur1xJF13tr13GrW7tFy8tFc_yoWrAw15p3
	y3Ca15Kry5tr1akF4UXrZ8Z3WYyrWYy3srKF4ak3WDC3s0kw4vqrZxKF1I9FZ7ZrZ5ur45
	Zr48AFs7uF98trgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==

>>>> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>>>>    	pci_set_master(pdev);
>>>> -	loongson_default_data(plat);
>>>> +	loongson_gmac_data(plat);
>>>>    	pci_enable_msi(pdev);
>>>>    	memset(&res, 0, sizeof(res));
>>>>    	res.addr = pcim_iomap_table(pdev)[0];
>>>> @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>>>    		goto err_disable_msi;
>>>>    	}
>>>> +	plat->tx_queues_to_use = 1;
>>>> +	plat->rx_queues_to_use = 1;
>>>> +
>>> Please move this to the loongson_gmac_data(). Thus all the
>>> platform-data initializations would be collected in two coherent
>>> methods: loongson_default_data() and loongson_gmac_data(). It will be
>>> positive from the readability and maintainability points of view.
>> OK, I will move this to the  loongson_default_data(),
>>
>> Because loongson_gmac/gnet_data() call it.
> It shall also work. But the fields will be overwritten in the
> loongson_gmac_data()/loongson_gnet_data() methods for the
> multi-channels case. I don't have a strong opinion against that. But
> some maintainers may have.
I see. I will move this to the loongson_gmac_data()/loongson_gnet_data().
>
>>
>>> In the patch adding the Loongson multi-channel GMAC support make sure
>>> the loongson_data::loongson_id field is initialized before the
>>> stmmac_pci_info::setup() method is called.
>> I've tried. It's almost impossible.
> Emm, why is it impossible? I don't see any significant problem with
> implementing that.
Sorry, I've to take back my words.
>
>>
>> The only way to do this is to initialize loongson_id again in
>> loongson_default_data().
>>
>> But that will add a lot of code.
> Not sure, why? What about the next probe() code snippet:
Full marks!
>
> 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
> 	if (!plat)
> 		return -ENOMEM;
>
> 	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
> 					   sizeof(*plat->mdio_bus_data),
> 					   GFP_KERNEL);
>          if (!plat->mdio_bus_data)
>                  return -ENOMEM;
>
> 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
> 	if (!plat->dma_cfg)
> 		return -ENOMEM;
>
> 	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
> 	if (!ld)
> 		return -ENOMEM;
>
> 	/* Enable pci device */
>   	ret = pci_enable_device(pdev);
>   	if (ret)
> 		return ret;
>
> 	// AFAIR the bus-mastering isn't required for the normal PCIe
> 	// IOs. So pci_set_master() can be called some place
> 	// afterwards.
> 	pci_set_master(pdev);
>
> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> 		if (pci_resource_len(pdev, i) == 0)
> 			continue;
> 		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
> 		if (ret)
> 			goto err_disable_device;
> 		break;
> 	}
>
> 	memset(&res, 0, sizeof(res));
> 	res.addr = pcim_iomap_table(pdev)[0];
>
> 	plat->bsp_priv = ld;
> 	plat->setup = loongson_dwmac_setup;
> 	ld->dev = &pdev->dev;
> 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>
> 	info = (struct stmmac_pci_info *)id->driver_data;
> 	ret = info->setup(plat);
> 	if (ret)
> 		goto err_disable_device;
>
> 	if (dev_of_node(&pdev->dev))
>   		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> 	else

> 		ret = loongson_dwmac_acpi_config(pdev, plat, &res);

I don't know how to write this function, it seems that there

is no obvious acpi code in the probe method.

>
> 	if (ret)
> 		goto err_disable_device;
>
> 	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
> 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
> 		if (ret)
> 			goto err_disable_device;
> 	}

It seems that we don't need if else.

If failed to allocate msi,  it will fallback to intx.

so loongson_dwmac_msi_config also needs a new name. How about:

...

     ret = loongson_dwmac_irq_config(pdev, plat, &res);
     if (ret)
         goto err_disable_device;

     ret = stmmac_dvr_probe(&pdev->dev, plat, &res);

...



>
> 	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>   	if (ret)
> 		goto err_clear_msi;
>
> 	return 0;
>
> 	...
>
> The code allocates all the data, then enables the PCIe device
> and maps the PCIe device resources. After that it calls all the setup
> and config methods. Do I miss something?

You are right!



Thanks,

Yanteng

>
> -Serge(y)
>
>>>> 2.31.4
>>>>



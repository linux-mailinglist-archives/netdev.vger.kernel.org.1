Return-Path: <netdev+bounces-109145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC47F92724A
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 10:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF011C2405B
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0941A256C;
	Thu,  4 Jul 2024 08:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58CA1A2FD5
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083425; cv=none; b=ncl1lH008+EKfXrMM7SgoePKBXgT58wLGr3d7dkQW64yYGrsGN5AJuyyqxM8s7LXam9dkPNUbXmgPnt+vJxLcBLMloEIYbHqTVrxEmfZPxsfPFzCERh1XLl25UzImCHDg2jM1cD3UaUQUS2yWNM3k7uWrL8h8dv4Dsbwa0oxxTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083425; c=relaxed/simple;
	bh=M1ZT9eZrYKHNzTSZbz7u1jifd7qvDLVx7i9Rq8nYglY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBWMCUsegiP/JXJunxxAvJOl2rfGY/rcycFDEm+JSVw4BIfG+kSz0ONDvMac6COentnjjo3rMwViZdW2Z5tkG//vpI5N+zsxlNqgarP+goRdASuvNDK7YuSYomLyK5grxDXTiG2jhz7lwb1hxRyvY0wb9IPj/kF59OIgItzvIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8Ax0PHOY4ZmC+AAAA--.3000S3;
	Thu, 04 Jul 2024 16:56:46 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx78fKY4ZmHd46AA--.5745S3;
	Thu, 04 Jul 2024 16:56:42 +0800 (CST)
Message-ID: <648058f6-7e0f-4e6e-9e27-cecf48ef1e2c@loongson.cn>
Date: Thu, 4 Jul 2024 16:56:41 +0800
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
 <d9e684c5-52b3-4da3-8119-d2e3b7422db6@loongson.cn>
 <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <vss2wuq5ivfnpdfgkjsp23yaed5ve2c73loeybddhbwdx2ynt2@yfk2nmj5lmod>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx78fKY4ZmHd46AA--.5745S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKw43XryDtrWDCw1kXryUtwc_yoW3XFW3pr
	WfCF42kr90qryakF4qqws8ZF1YyrWYyr9FgF43K34jy3s0krnaqrykKa1j9FZ7CrZ5Cr4U
	Zr48AFZ7uF98tFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU


在 2024/7/4 00:19, Serge Semin 写道:
> On Wed, Jul 03, 2024 at 05:41:55PM +0800, Yanteng Si wrote:
>>>>>> -	plat->mac_interface = PHY_INTERFACE_MODE_GMII;
>>>>>>     	pci_set_master(pdev);
>>>>>> -	loongson_default_data(plat);
>>>>>> +	loongson_gmac_data(plat);
>>>>>>     	pci_enable_msi(pdev);
>>>>>>     	memset(&res, 0, sizeof(res));
>>>>>>     	res.addr = pcim_iomap_table(pdev)[0];
>>>>>> @@ -140,6 +142,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>>>>>     		goto err_disable_msi;
>>>>>>     	}
>>>>>> +	plat->tx_queues_to_use = 1;
>>>>>> +	plat->rx_queues_to_use = 1;
>>>>>> +
>>>>> Please move this to the loongson_gmac_data(). Thus all the
>>>>> platform-data initializations would be collected in two coherent
>>>>> methods: loongson_default_data() and loongson_gmac_data(). It will be
>>>>> positive from the readability and maintainability points of view.
>>>> OK, I will move this to the  loongson_default_data(),
>>>>
>>>> Because loongson_gmac/gnet_data() call it.
>>> It shall also work. But the fields will be overwritten in the
>>> loongson_gmac_data()/loongson_gnet_data() methods for the
>>> multi-channels case. I don't have a strong opinion against that. But
>>> some maintainers may have.
>> I see. I will move this to the loongson_gmac_data()/loongson_gnet_data().
>>>>> In the patch adding the Loongson multi-channel GMAC support make sure
>>>>> the loongson_data::loongson_id field is initialized before the
>>>>> stmmac_pci_info::setup() method is called.
>>>> I've tried. It's almost impossible.
>>> Emm, why is it impossible? I don't see any significant problem with
>>> implementing that.
>> Sorry, I've to take back my words.
>>>> The only way to do this is to initialize loongson_id again in
>>>> loongson_default_data().
>>>>
>>>> But that will add a lot of code.
>>> Not sure, why? What about the next probe() code snippet:
>> Full marks!
>>> 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>> 	if (!plat)
>>> 		return -ENOMEM;
>>>
>>> 	plat->mdio_bus_data = devm_kzalloc(&pdev->dev,
>>> 					   sizeof(*plat->mdio_bus_data),
>>> 					   GFP_KERNEL);
>>>           if (!plat->mdio_bus_data)
>>>                   return -ENOMEM;
>>>
>>> 	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>>> 	if (!plat->dma_cfg)
>>> 		return -ENOMEM;
>>>
>>> 	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>>> 	if (!ld)
>>> 		return -ENOMEM;
>>>
>>> 	/* Enable pci device */
>>>    	ret = pci_enable_device(pdev);
>>>    	if (ret)
>>> 		return ret;
>>>
>>> 	// AFAIR the bus-mastering isn't required for the normal PCIe
>>> 	// IOs. So pci_set_master() can be called some place
>>> 	// afterwards.
>>> 	pci_set_master(pdev);
>>>
>>> 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>> 		if (pci_resource_len(pdev, i) == 0)
>>> 			continue;
>>> 		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
>>> 		if (ret)
>>> 			goto err_disable_device;
>>> 		break;
>>> 	}
>>>
>>> 	memset(&res, 0, sizeof(res));
>>> 	res.addr = pcim_iomap_table(pdev)[0];
>>>
>>> 	plat->bsp_priv = ld;
>>> 	plat->setup = loongson_dwmac_setup;
>>> 	ld->dev = &pdev->dev;
>>> 	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>>>
>>> 	info = (struct stmmac_pci_info *)id->driver_data;
>>> 	ret = info->setup(plat);
>>> 	if (ret)
>>> 		goto err_disable_device;
>>>
>>> 	if (dev_of_node(&pdev->dev))
>>>    		ret = loongson_dwmac_dt_config(pdev, plat, &res);
>>> 	else
>>> 		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
>> I don't know how to write this function, it seems that there
>>
>> is no obvious acpi code in the probe method.
> I've provided the method code here:
> https://lore.kernel.org/netdev/glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn/
>
> It just gets the IRQ from the pci_device::irq field:
>
> static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
> 				      struct plat_stmmacenet_data *plat,
> 				      struct stmmac_resources *res)
> {
> 	if (!pdev->irq)
> 		return -EINVAL;
>
> 	res->irq = pdev->irq;
>
> 	return 0;
> }
>
> It implies that if there is no DT found on the platform or no DT-node
> assigned to the device, the IRQ line was supposed to be detected via
> the ACPI interface by the PCIe subsystem core. Just recently you said
> that the Loongson platforms are either UEFI or U-boot based. So at
> least the loongson_dwmac_acpi_config() method would imply that the IRQ
> number was supposed to be retrieved by means of the ACPI interface.
Oh, I see!
>
>>> 	if (ret)
>>> 		goto err_disable_device;
>>>
>>> 	if (ld->loongson_id == DWMAC_CORE_LS2K2000) {
>>> 		ret = loongson_dwmac_msi_config(pdev, plat, &res);
>>> 		if (ret)
>>> 			goto err_disable_device;
>>> 	}
>> It seems that we don't need if else.
>>
>> If failed to allocate msi,  it will fallback to intx.
>>
>> so loongson_dwmac_msi_config also needs a new name. How about:
>>
>> ...
>>
>>      ret = loongson_dwmac_irq_config(pdev, plat, &res);
>>      if (ret)
>>          goto err_disable_device;
> Well, I've been thinking about that for quite some time. The problem
> with your approach is that you _always_ override the res->irq field
> with data retrieved from pci_irq_vector(pdev, 0). What's the point in
> the res->irq initialization in the loongson_dwmac_dt_config() method
> then?
>
> Originally I suggested to use the PCI_IRQ_INTX flag in the
> loongson_dwmac_msi_config() method because implied that eventually we
> could come up to some generic IRQs initialization method with no
> IRQ-related code performed in the rest of the driver. But after some
> brainstorming I gave up that topic for now. Sending comments connected
> with that would mean to cause a one more discussion. Seeing we already
> at v13 it would have extended the review process for even longer than
> it has already got to.
>
> So since the MSI IRQs are required for the multi-channels device it
> would be better to allocate MSIs for that case only. Thus I'd preserve
> the conditional loongson_dwmac_msi_config() execution and would drop
> the PCI_IRQ_INTX flag seeing we aren't going to implement the generic
> IRQ setup method anymore. Like this:
>
> +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
> +				     struct plat_stmmacenet_data *plat,
> +				     struct stmmac_resources *res)
> +{
> +	int i, ret, vecs;
> +
> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to allocate per-channels IRQs\n");
> +		return ret;
> +	}
> +
> +	res->irq = pci_irq_vector(pdev, 0);
> +
> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 1 + i * 2);
> +	}
> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
> +			pci_irq_vector(pdev, 2 + i * 2);
> +	}
> +
> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +
> +	return 0;
> +}
>
> * Please note the pci_alloc_irq_vectors(..., vecs, vecs, PCI_IRQ_MSI) arguments.
OK. I got you!
>
> Seeing the discussion has started anyway, could you please find out
> whether the multi-channel controller will still work if the MSI IRQs
> allocation failed? Will the multi-channel-ness still work in that
> case?

Based on my test results:

In this case, multi-channel controller don't work. If the MSI IRQs 
allocation

failed, NIC will work in single channel.


I will prepare v14 according to your comments,


Over the past year, with everyone's help, the drive has become better 
and better.

Thank you everyone. Thank you very much!


Thanks,

Yanteng




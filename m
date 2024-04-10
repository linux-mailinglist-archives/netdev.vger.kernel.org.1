Return-Path: <netdev+bounces-86371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A288789E7F3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB892833A7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90C1854;
	Wed, 10 Apr 2024 01:49:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7B837C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713792; cv=none; b=Dzo3k0hJwRxzeRAPuuYTRhb1+dhh0QRVeo+I8khRaovHSLK3IItyvBrTe1aCs3Nri7Lkrml/vFI9qGWk5TWzuXmflxP+HMVl6dHN4Cp3AjAece1Nn7Zc3GwXEIhzS8O4sXYLzJR5rgoknBM04ngF8ZjWq4ZILDfkT1lWJuntTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713792; c=relaxed/simple;
	bh=94qK/oVlTt4PFH+NnCa4mc3rW/S9Ooh2EVXsz/pN2yY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr8g4Na3W69kfAkULpm6d1ZD+vJnsubHZT5VPbQmiPVSAr9zsLzlZXloBLnG4X6IDRbwkDaIlLZEd0zD9QSWlOrseKAW5ycQYbiBsIKL8NDRzkW2cxmG7vzocaoPO80tdPNvRxrY0Z3TJmgQbpRfG/tjVnn7eDC8NN+U4SX8mOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8Dx+7o78BVm7gwlAA--.3909S3;
	Wed, 10 Apr 2024 09:49:47 +0800 (CST)
Received: from [192.168.100.126] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTRM38BVmNQ53AA--.32543S3;
	Wed, 10 Apr 2024 09:49:45 +0800 (CST)
Message-ID: <6506ff6c-b5b9-43c1-804d-e1ca1029afa0@loongson.cn>
Date: Wed, 10 Apr 2024 09:49:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/6] net: stmmac: dwmac-loongson: Add
 Loongson GNET support
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, fancer.lancer@gmail.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 siyanteng01@gmail.com
References: <cover.1712668711.git.siyanteng@loongson.cn>
 <77daabe9ca5c62168d9e54a81b5822e9b898eeb3.1712668711.git.siyanteng@loongson.cn>
 <20240409185809.GN26556@kernel.org>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240409185809.GN26556@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTRM38BVmNQ53AA--.32543S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF45XF15KrW7CFW7WF1fXwc_yoW8uw1Dp3
	98AFyYqryrXryava1qv3yUJF1YqrW2934kCw42k3Wj9asYyr9aqFy8KrW29ryxArZ3Cw4f
	ZrW5Zrs7uF1vkagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==


在 2024/4/10 02:58, Simon Horman 写道:
> On Tue, Apr 09, 2024 at 10:04:34PM +0800, Yanteng Si wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> ...
>
>> @@ -145,42 +568,37 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   			goto err_disable_device;
>>   		}
>>   		plat->phy_interface = phy_mode;
>> -
>> -		res.irq = of_irq_get_byname(np, "macirq");
>> -		if (res.irq < 0) {
>> -			dev_err(&pdev->dev, "IRQ macirq not found\n");
>> -			ret = -ENODEV;
>> -			goto err_disable_msi;
>> -		}
>> -
>> -		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> -		if (res.wol_irq < 0) {
>> -			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
>> -			res.wol_irq = res.irq;
>> -		}
>> -
>> -		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> -		if (res.lpi_irq < 0) {
>> -			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> -			ret = -ENODEV;
>> -			goto err_disable_msi;
>> -		}
>> -	} else {
>> -		res.irq = pdev->irq;
>>   	}
>>   
>> -	pci_enable_msi(pdev);
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>>   
>> +	ld->dev = &pdev->dev;
>> +	plat->bsp_priv = ld;
>> +	loongson_gmac = readl(res.addr + GMAC_VERSION) & 0xff;
>> +
>> +	switch (loongson_gmac) {
>> +	case LOONGSON_DWMAC_CORE_1_00:
>> +		plat->setup = loongson_gnet_setup;
>> +		/* Only channel 0 of the 0x10 device supports checksum,
>> +		 * so turn off checksum to enable multiple channels.
>> +		 */
>> +		for (i = 1; i < CHANNEL_NUM; i++) {
>> +			plat->tx_queues_cfg[i].coe_unsupported = 1;
>> +		};
> nit: '}' rather than '};'

OK.


Thanks,

Yanteng

>
>> +		ret = loongson_dwmac_config_msi(pdev, plat, &res, np);
>> +		break;
>> +	default:	/* 0x35 device and 0x37 device. */
>> +		ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>> +		break;
>> +	}
>> +
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>> -		goto err_disable_msi;
>> +		goto err_disable_device;
>>   
>>   	return ret;
>>   
>> -err_disable_msi:
>> -	pci_disable_msi(pdev);
>>   err_disable_device:
>>   	pci_disable_device(pdev);
>>   err_put_node:
> ...



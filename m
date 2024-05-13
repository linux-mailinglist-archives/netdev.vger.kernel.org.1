Return-Path: <netdev+bounces-95960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8B38C3EA9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5AE1F224A9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E14149DF9;
	Mon, 13 May 2024 10:12:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6D1482F0
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595150; cv=none; b=Obhz+1epbRIlbvpW3P4UPuQ6W0FKxlpzv4l/yIuFge0zmJfhNqDwXH5htzmRUdtZs6QoyURJOxFXCIZ/q71G/TO+0ina3F7ugXaafyhuJlSMO56gusC2xfdPVj08tDhmmtkzFjMMSz8nCRVWip3I3BuV2Y1LDRXZn9ByeS1qv6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595150; c=relaxed/simple;
	bh=qTb42nnPOlynOdNWyzX3JG3IscTTZWdvLOdB03P+8qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1bWq1Bi1uM+5ibOTOwfMHsBl3Xb9yIAo9u1Tq8FRdQPlePiZ7vJ3wN3rWvwxugVeh6lSOwezLlghVGlCCw0BQjLDy4m7q3j4rCYfO0bLKoCdsQBE/z28iciKeefZAy2NJHhSBRRkJtuCbZjCyH/4cn7hHmx1AAIPUzdwvh58iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxR_CJ50FmbyIMAA--.29942S3;
	Mon, 13 May 2024 18:12:25 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxQ1aG50FmE9AcAA--.34849S3;
	Mon, 13 May 2024 18:12:23 +0800 (CST)
Message-ID: <48804c65-51a5-433d-952f-a08699c8db69@loongson.cn>
Date: Mon, 13 May 2024 18:12:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 11/15] net: stmmac: dwmac-loongson: Add
 loongson_dwmac_config_legacy
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <b26258cae28b19c8d204beca691fea877b3bf537.1714046812.git.siyanteng@loongson.cn>
 <cao2zykgxyxee2f3rsrtod22qiyovyuywnck4xlheajrzfke3f@k6nfpf5bz46y>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <cao2zykgxyxee2f3rsrtod22qiyovyuywnck4xlheajrzfke3f@k6nfpf5bz46y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxQ1aG50FmE9AcAA--.34849S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXry7ZFyfXF4xWr4DKF1ruFX_yoWrGryDpr
	Z3Aa4Ygryktry7W398Z3y5JFyYvrWjv348Cw42yw1a9asYva4SqFy5KrW2kryxZrZ5Ca12
	vw1UuFWkuFs0kFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uc_3UUUUU==


在 2024/5/5 05:28, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:10:36PM +0800, Yanteng Si wrote:
>> Move res._irq to loongson_dwmac_config_legacy().
>> No function changes.
> Since the code affected by this patch has just been touched by the
> previous patch
> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> just merge this patch content into there. But add a note to the
> commit message of that patch like this:
>
> "While at it move the IRQ initialization procedure into a dedicated
> method. It will be useful in one of the subsequent commit adding the
> Loongson GNET device support."
OK.
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 56 +++++++++++--------
>>   1 file changed, 34 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 1022bceaa680..df5899bec91a 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -68,6 +68,38 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>   	.setup = loongson_gmac_data,
>>   };
>>   
>> +static int loongson_dwmac_config_legacy(struct pci_dev *pdev,
>> +					struct plat_stmmacenet_data *plat,
>> +					struct stmmac_resources *res,
>> +					struct device_node *np)
>> +{
>> +	if (np) {
>> +		res->irq = of_irq_get_byname(np, "macirq");
>> +		if (res->irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> +		if (res->wol_irq < 0) {
>> +			dev_info(&pdev->dev,
>> +				 "IRQ eth_wake_irq not found, using macirq\n");
>> +			res->wol_irq = res->irq;
>> +		}
>> +
>> +		res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> +		if (res->lpi_irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> +			return -ENODEV;
>> +		}
>> +	} else {
>> +		res->irq = pdev->irq;
>> +		res->wol_irq = res->irq;
> Once again - drop this, unless you can justify it's required.
OK.
>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct plat_stmmacenet_data *plat;
>> @@ -136,28 +168,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
>>   	pci_enable_msi(pdev);
>> @@ -167,6 +177,8 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	plat->tx_queues_to_use = 1;
>>   	plat->rx_queues_to_use = 1;
>>   
>> +	ret = loongson_dwmac_config_legacy(pdev, plat, &res, np);
>> +
> By not checking the return value the patch turns to in fact containing
> the functional change, which contradicts to what you say in the commit
> log. Besides it's just wrong in this case. So please add the return
> value check.

OK.


Thanks,

Yanteng



Return-Path: <netdev+bounces-73599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5596785D530
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A7A1C22B15
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE33D576;
	Wed, 21 Feb 2024 10:08:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A23E468
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708510097; cv=none; b=gQJg7tUuTCXcvKfes8MMToAbBx2kU/bA2v42VUM5BgNhtoCeWCIW5lQJ+9RqGcHHoHkYNergEwJXmjTDbcz8t0doXb3ntbpIg0TOkfNkFgqXQWgfzWHF+K0co/y1mBCgNOSAPY4f+ocWkm66cHOl9qZcYEEsrqAPDOWPP2V5QdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708510097; c=relaxed/simple;
	bh=5HGe7CIurOvcBEaqWgJtWnhG+y0njT1yug8dMK8QD5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzrJs3fnIIMCyh3nTe4mWyM6uUtTAWLyEYUQ3PGll+DW9Sr5LFFfjqJmxcvKSTwacabrVzZzJwic1tPj2ujPJ2+nhquEzzmFFThwLCMODV/0Frhrz+Uhztl3aYvyblPHoL0be8AsGR7G5JMYaNOckn7kvVTOgusnub4NlHJscuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.108.46])
	by gateway (Coremail) with SMTP id _____8AxDOuGy9Vlr8UPAA--.31019S3;
	Wed, 21 Feb 2024 18:08:06 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.108.46])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf8+Ey9VltsU9AA--.28478S3;
	Wed, 21 Feb 2024 18:08:05 +0800 (CST)
Message-ID: <c1854a99-d0fd-4b96-875a-ef9be2b96f04@loongson.cn>
Date: Wed, 21 Feb 2024 18:08:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 03/11] net: stmmac: dwmac-loongson: Add full
 PCI support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <bfaed8692d6e03bbb53100d4e3695aa4a9f92633.1706601050.git.siyanteng@loongson.cn>
 <7dbvco63tgz65p7xx5tufwjlwgkpujjbqet52atrbj7s4zyrbx@qjxxtumcbbga>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <7dbvco63tgz65p7xx5tufwjlwgkpujjbqet52atrbj7s4zyrbx@qjxxtumcbbga>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf8+Ey9VltsU9AA--.28478S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3JryrurWxAF18Gry3ZF47Awc_yoW7AFy5p3
	93CF1aqr97Xry7Wws5ZFWUX3WY9rWYv348Cw42ka429a90yr1SqF1UKrWUuFyxArZ5Cw4j
	9r1jqrs2gF1kKFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2024/2/6 00:49, Serge Semin 写道:
> On Tue, Jan 30, 2024 at 04:43:23PM +0800, Yanteng Si wrote:
>> Current dwmac-loongson only support LS2K in the "probed with PCI and
>> configured with DT" manner. Add LS7A support on which the devices are
>> fully PCI (non-DT).
> Please add to the commit log more details of what LS7A is like and
> bind that description to the changes below like the interface
> settings, ref and PTP clock settings, etc. What is the difference
> between LS2K and LS7A?
OK,
>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 79 +++++++++++--------
>>   1 file changed, 44 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index e2dcb339b8b0..979c9b6dab3f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -16,6 +16,10 @@ struct stmmac_pci_info {
>>   static void loongson_default_data(struct pci_dev *pdev,
>>   				  struct plat_stmmacenet_data *plat)
>>   {
>> +	/* Get bus_id, this can be overloaded later */
>> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
>> +		       PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>>   	plat->force_sf_dma_mode = 1;
>> @@ -51,10 +55,14 @@ static int loongson_gmac_data(struct pci_dev *pdev,
>>   	plat->mdio_bus_data->phy_mask = 0;
>>   
>>   	plat->phy_addr = -1;
>> +	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>>   
>>   	plat->dma_cfg->pbl = 32;
>>   	plat->dma_cfg->pblx8 = true;
>>   
>> +	plat->clk_ref_rate = 125000000;
>> +	plat->clk_ptp_rate = 125000000;
>> +
> Is this compatible with the LS2K GMAC?
Of course!
>
>>   	return 0;
>>   }
>>   
>> @@ -71,13 +79,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>>   
>> -	np = dev_of_node(&pdev->dev);
>> -
>> -	if (!np) {
>> -		pr_info("dwmac_loongson_pci: No OF node\n");
>> -		return -ENODEV;
>> -	}
>> -
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>   	if (!plat)
>>   		return -ENOMEM;
>> @@ -93,6 +94,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (!plat->dma_cfg)
>>   		return -ENOMEM;
>>   
>> +	np = dev_of_node(&pdev->dev);
>>   	plat->mdio_node = of_get_child_by_name(np, "mdio");
>>   	if (plat->mdio_node) {
>>   		dev_info(&pdev->dev, "Found MDIO subnode\n");
> Shouldn't mdio_node setup being done under the "if (np)" clause?
Yes, they will be moved there.
>
>> @@ -123,41 +125,48 @@ static int loongson_dwmac_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> -	bus_id = of_alias_get_id(np, "ethernet");
>> -	if (bus_id >= 0)
>> -		plat->bus_id = bus_id;
>> +	if (np) {
>> +		bus_id = of_alias_get_id(np, "ethernet");
>> +		if (bus_id >= 0)
>> +			plat->bus_id = bus_id;
>>   
>> -	phy_mode = device_get_phy_mode(&pdev->dev);
>> -	if (phy_mode < 0) {
>> -		dev_err(&pdev->dev, "phy_mode not found\n");
>> -		ret = phy_mode;
>> -		goto err_disable_device;
>> +		phy_mode = device_get_phy_mode(&pdev->dev);
>> +		if (phy_mode < 0) {
>> +			dev_err(&pdev->dev, "phy_mode not found\n");
>> +			ret = phy_mode;
>> +			goto err_disable_device;
>> +		}
>> +		plat->phy_interface = phy_mode;
>>   	}
> Please collect all OF-specific code in the same "if (np)" clause if
> possible.
OK,
>
>>   
>> -	plat->phy_interface = phy_mode;	np = dev_of_node(&pdev->dev);
>> -
>>   	pci_enable_msi(pdev);
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>>   
>> -	res.irq = of_irq_get_byname(np, "macirq");
>> -	if (res.irq < 0) {
>> -		dev_err(&pdev->dev, "IRQ macirq not found\n");
>> -		ret = -ENODEV;
>> -		goto err_disable_msi;
>> -	}
>> -
>> -	res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> -	if (res.wol_irq < 0) {
>> -		dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
>> -		res.wol_irq = res.irq;
>> -	}
>> -
>> -	res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> -	if (res.lpi_irq < 0) {
>> -		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> -		ret = -ENODEV;
>> -		goto err_disable_msi;
>> +	if (np) {
>> +		res.irq = of_irq_get_byname(np, "macirq");
>> +		if (res.irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
>> +			ret = -ENODEV;
>> +			goto err_disable_msi;
>> +		}
>> +
>> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> +		if (res.wol_irq < 0) {
>> +			dev_info(&pdev->dev,
>> +				 "IRQ eth_wake_irq not found, using macirq\n");
>> +			res.wol_irq = res.irq;
>> +		}
>> +
>> +		res.lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> +		if (res.lpi_irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> +			ret = -ENODEV;
>> +			goto err_disable_msi;
>> +		}
>> +	} else {
>> +		res.irq = pdev->irq;
>> +		res.wol_irq = pdev->irq;
> This seems redundant. If res.wol_irq matches res_irq it won't be used
> (see stmmac_request_irq_multi_msi() and stmmac_request_irq_single()).
> What about dropping it?

Okay, actually, it was removed by subsequent patches.


Thanks,

Yanteng

>
> -Serge(y)
>
>>   	}
>>   
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>> -- 
>> 2.31.4
>>



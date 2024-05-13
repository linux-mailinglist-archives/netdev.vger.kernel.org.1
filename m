Return-Path: <netdev+bounces-95990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA08C3F4A
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF3A1C227B7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254E1487E1;
	Mon, 13 May 2024 10:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B1452F9E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597402; cv=none; b=aA79nneeunPCqzok/iKTAZnA24NB+YWPA/jg1SaorJzscH7gyBrZfwnv5Wq3CjJxmXNkBZiEDs0w43K7kt7W+63HrAA9dDtrsNFUzz+DiMeuNQxui4UgnM87TOp5rxZICpqZ5D12ZD+1FfNdtuDirGTJIadmuptUp/VrjgKcxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597402; c=relaxed/simple;
	bh=EHgIOxYCxAwXf++jZOVRchnqagrz1O0gg6IWM5silJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNWB+6ckQtCnIo5YllSgWMG37eyZuB9kjy2ZIHYc3K2+BMIPp2qIihNx6WdTyPIAK4bZqg3jFX2fD6elIy8WyJDBiVy6GHcQ05hIzfjxrIautFBClg/95wXQs2df5RJHmiTlaUYoaBejfD5uObOXQk1VjI4cvRXmecB7jlCCFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxiPBU8EFm7yQMAA--.29654S3;
	Mon, 13 May 2024 18:49:56 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxTN5S8EFm5tccAA--.52109S3;
	Mon, 13 May 2024 18:49:55 +0800 (CST)
Message-ID: <ab6c1855-59b8-4bc5-bd34-082e48935e5c@loongson.cn>
Date: Mon, 13 May 2024 18:49:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full
 PCI support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d3bad82c41964925f9284ccdd8ec07160cac5519.1714046812.git.siyanteng@loongson.cn>
 <rvz3ebfbxuz4fq34epujowab5tyf4o2uhvrcc2bqzla6odxfnl@aqypyjpr6awj>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <rvz3ebfbxuz4fq34epujowab5tyf4o2uhvrcc2bqzla6odxfnl@aqypyjpr6awj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxTN5S8EFm5tccAA--.52109S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3JFyrKw15tr13uF15Ary7Jwc_yoWfGFWkp3
	yfCasxKrZ7Xry2gw4kXrWUXFyYvrWYy34jkw42ka4xKa90vr1SqFy8KFWUCr97ArWkCw42
	vw1jgr4kWFyqkFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8oGQDUUUUU==


在 2024/5/5 04:46, Serge Semin 写道:
>> [PATCH net-next v12 10/15] net: stmmac: dwmac-loongson: Add full PCI support
> I would have changed the subject to:
>
> net: stmmac: dwmac-loongson: Add DT-less GMAC PCI-device support
OK.
>
> On Thu, Apr 25, 2024 at 09:10:35PM +0800, Yanteng Si wrote:
>> Current dwmac-loongson only support LS2K in the "probed with PCI and
>> configured with DT" manner. Add LS7A support on which the devices are
>> fully PCI (non-DT).
>>
>> Others:
>> LS2K is a SoC and LS7A is a bridge chip.
> The text seems like misleading or just wrong. I see both of these
> platforms having the GMAC defined in the DT source:
>
> arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
> arch/mips/boot/dts/loongson/ls7a-pch.dtsi
>
> What do I miss in your description?
You are right.
>
> If nothing has been missed and it's just wrong I suggest to convert
> the commit log to something like this:
>
> "The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> Let's extend the driver functionality with the case of having the
> Loongson GMAC probed on the PCI bus with no device tree node defined
> for it. That requires to make the device DT-node optional, to rely on
> the IRQ line detected by the PCI core and to have the MDIO bus ID
> calculated using the PCIe Domain+BDF numbers."

OK, Thanks!

>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 113 ++++++++++--------
>>   1 file changed, 65 insertions(+), 48 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index e989cb835340..1022bceaa680 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -11,8 +11,17 @@
>>   
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>   
>> -static void loongson_default_data(struct plat_stmmacenet_data *plat)
>> +struct stmmac_pci_info {
>> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>> +};
> Please move this and the rest of the setup-callback introduction
> change into a separate patch. It' subject could be something like
> this:
> net: stmmac: dwmac-loongson: Introduce PCI device info data
OK.
>
>> +
>> +static void loongson_default_data(struct pci_dev *pdev,
>> +				  struct plat_stmmacenet_data *plat)
>>   {
>> +	/* Get bus_id, this can be overloaded later */
> s/overloaded/overwritten
OK
>
>> +	plat->bus_id = (pci_domain_nr(pdev->bus) << 16) |
>> +			PCI_DEVID(pdev->bus->number, pdev->devfn);
> Em, so you removed the code from the probe() function:
> -     plat->bus_id = of_alias_get_id(np, "ethernet");
> -     if (plat->bus_id < 0)
> -             plat->bus_id = pci_dev_id(pdev);
> and instead of using the pci_dev_id() method here just opencoded it'
> content. Nice. Why not to use pci_dev_id() instead of PCI_DEVID()?
OK, I will try it!
>
>> +
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>>   	plat->force_sf_dma_mode = 1;
>> @@ -44,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>>   	plat->multicast_filter_bins = 256;
>>   }
>>   
>> -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>> +static int loongson_gmac_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>>   {
>> -	loongson_default_data(plat);
>> +	loongson_default_data(pdev, plat);
>>   
>>   	plat->mdio_bus_data->phy_mask = 0;
>>   	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>> @@ -54,20 +64,20 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>>   	return 0;
>>   }
>>   
>> +static struct stmmac_pci_info loongson_gmac_pci_info = {
>> +	.setup = loongson_gmac_data,
>> +};
>> +
> To the separate patch please.
OK.
>
>>   static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct plat_stmmacenet_data *plat;
>> +	int ret, i, bus_id, phy_mode;
>> +	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>> -	int ret, i, phy_mode;
> You can drop the bus_id and phy_mode variables, and use ret in the
> respective statements instead.
OK, I will try it.
>
>>   
>>   	np = dev_of_node(&pdev->dev);
>>   
>> -	if (!np) {
>> -		pr_info("dwmac_loongson_pci: No OF node\n");
>> -		return -ENODEV;
>> -	}
>> -
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>>   	if (!plat)
>>   		return -ENOMEM;
>> @@ -78,12 +88,6 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (!plat->mdio_bus_data)
>>   		return -ENOMEM;
>>   
>> -	plat->mdio_node = of_get_child_by_name(np, "mdio");
>> -	if (plat->mdio_node) {
>> -		dev_info(&pdev->dev, "Found MDIO subnode\n");
>> -		plat->mdio_bus_data->needs_reset = true;
>> -	}
>> -
>>   	plat->dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*plat->dma_cfg), GFP_KERNEL);
>>   	if (!plat->dma_cfg) {
>>   		ret = -ENOMEM;
>> @@ -107,46 +111,59 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   		break;
>>   	}
>>   
>> -	plat->bus_id = of_alias_get_id(np, "ethernet");
>> -	if (plat->bus_id < 0)
>> -		plat->bus_id = pci_dev_id(pdev);
>> +	pci_set_master(pdev);
>>   
>> -	phy_mode = device_get_phy_mode(&pdev->dev);
>> -	if (phy_mode < 0) {
>> -		dev_err(&pdev->dev, "phy_mode not found\n");
>> -		ret = phy_mode;
>> +	info = (struct stmmac_pci_info *)id->driver_data;
>> +	ret = info->setup(pdev, plat);
>> +	if (ret)
>>   		goto err_disable_device;
> To the separate patch please.
OK.
>
>> -	}
>>   
>> -	plat->phy_interface = phy_mode;
>> -
>> -	pci_set_master(pdev);
>> +	if (np) {
>> +		plat->mdio_node = of_get_child_by_name(np, "mdio");
>> +		if (plat->mdio_node) {
>> +			dev_info(&pdev->dev, "Found MDIO subnode\n");
>> +			plat->mdio_bus_data->needs_reset = true;
>> +		}
>> +
>> +		bus_id = of_alias_get_id(np, "ethernet");
>> +		if (bus_id >= 0)
>> +			plat->bus_id = bus_id;
> 		ret = of_alias_get_id(np, "ethernet");
> 		if (ret >= 0)
> 			plat->bus_id = ret;
>
>> +
>> +		phy_mode = device_get_phy_mode(&pdev->dev);
>> +		if (phy_mode < 0) {
>> +			dev_err(&pdev->dev, "phy_mode not found\n");
>> +			ret = phy_mode;
>> +			goto err_disable_device;
>> +		}
>> +		plat->phy_interface = phy_mode;
> 		ret = device_get_phy_mode(&pdev->dev);
> 		if (ret < 0) {
> 			dev_err(&pdev->dev, "phy_mode not found\n");
> 			goto err_disable_device;
> 		}
> 		
> 		plat->phy_interface = ret;
>
> * note empty line between the if-clause and the last statement.
OK.
>
>> +
>> +		res.irq = of_irq_get_byname(np, "macirq");
>> +		if (res.irq < 0) {
>> +			dev_err(&pdev->dev, "IRQ macirq not found\n");
>> +			ret = -ENODEV;
>> +			goto err_disable_msi;
>> +		}
>> +
>> +		res.wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> +		if (res.wol_irq < 0) {
>> +			dev_info(&pdev->dev, "IRQ eth_wake_irq not found, using macirq\n");
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
>> +	}
>>   
>> -	loongson_gmac_data(plat);
> To the separate patch please.
OK.
>
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
>> -	}
>> -
>>   	plat->tx_queues_to_use = 1;
>>   	plat->rx_queues_to_use = 1;
>>   
>> @@ -224,7 +241,7 @@ static SIMPLE_DEV_PM_OPS(loongson_dwmac_pm_ops, loongson_dwmac_suspend,
>>   			 loongson_dwmac_resume);
>>   
>>   static const struct pci_device_id loongson_dwmac_id_table[] = {
>> -	{ PCI_DEVICE_DATA(LOONGSON, GMAC, NULL) },
>> +	{ PCI_DEVICE_DATA(LOONGSON, GMAC, &loongson_gmac_pci_info) },
> To the separate patch please.
OK.



Thanks,

Yanteng



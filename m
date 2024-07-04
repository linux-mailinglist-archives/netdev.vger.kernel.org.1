Return-Path: <netdev+bounces-109159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18309272C9
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43CD1C222CF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5411A2569;
	Thu,  4 Jul 2024 09:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015A19AD70
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084650; cv=none; b=UgdWJ11ecW7A869hjqX2Q75cKuKvBaImekzs76vpQ9M4iw2ZSIh6VYcKwxJyFHJeb4qi8qizijzI+lERodTmVh/NywnANxqzaDs6YVcC1UIKU/FhctFrjWY0F9VJpTzJFuXpndHBU4BYkvkageFDeFEfqnSTGeYIQVf7TdhoFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084650; c=relaxed/simple;
	bh=QPRfiOCr7xju/P1NwJi8SIyFd+ux3dFb89YujoRxw2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iR5n1uLoCHgvui89UztJh7wmbMxb1muT+4m9hEJcBOtUShCjmVRFtxG5jKmmjL6RS04tz+JtQoRTxjktATl3JgUjTJzsiNqsgFUI5n0X6jT3ZIGI5A0oxcnWtvjwaLXAQ/+cHjejifzIvoT7qbziaSGF9K958yL83LkeEB5V+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8CxruulaIZmPuEAAA--.2688S3;
	Thu, 04 Jul 2024 17:17:25 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPMeiaIZms+I6AA--.6833S3;
	Thu, 04 Jul 2024 17:17:23 +0800 (CST)
Message-ID: <30267ebd-ed49-4dd4-a676-aef9406f99e9@loongson.cn>
Date: Thu, 4 Jul 2024 17:17:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 10/15] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <fa22df795219256b093659195c4609445a175a1d.1716973237.git.siyanteng@loongson.cn>
 <glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <glm3jfqf36t5vnkmk4gsdqfx53ga7ohs3pxnsizqlogkbim7gg@a3dxav5siczn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPMeiaIZms+I6AA--.6833S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKFWDCw1fJr15AFW8JFykXrc_yoWxKF13pr
	WfCa4akrZrtry7Ka1kZrWUZFyYyrWYv34jkw42ka4xKas0kF1SqFyjgr4UAF97ArWkuw12
	vr1jgr48WF1DKFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2024/7/2 17:35, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:20:26PM +0800, Yanteng Si wrote:
>> The Loongson GMAC driver currently supports the network controllers
>> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
>> devices are required to be defined in the platform device tree source.
>> Let's extend the driver functionality with the case of having the
>> Loongson GMAC probed on the PCI bus with no device tree node defined
>> for it. That requires to make the device DT-node optional, to rely on
>> the IRQ line detected by the PCI core and to have the MDIO bus ID
>> calculated using the PCIe Domain+BDF numbers.
> We need to mention the ACPI-part here. Like this:
>
> "The Loongson GMAC driver currently supports the network controllers
> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
> devices are required to be defined in the platform device tree source.
> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
> (implies FDT) as the system bootloaders. In order to have both system
> configurations support let's extend the driver functionality with the
> case of having the Loongson GMAC probed on the PCI bus with no device
> tree node defined for it. That requires to make the device DT-node
> optional, to rely on the IRQ line detected by the PCI core and to
> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers."
>
> This shall well justify the change introduced in this patch and in the
> patch "net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config"
> which content I suggest to merge in into this one.
OK, Thanks!
>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 105 +++++++++---------
>>   1 file changed, 53 insertions(+), 52 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index fec2aa0607d4..8bcf9d522781 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> @@ -12,11 +12,15 @@
>>   #define PCI_DEVICE_ID_LOONGSON_GMAC	0x7a03
>>   
>>   struct stmmac_pci_info {
>> -	int (*setup)(struct plat_stmmacenet_data *plat);
>> +	int (*setup)(struct pci_dev *pdev, struct plat_stmmacenet_data *plat);
>>   };
>>   
>> -static void loongson_default_data(struct plat_stmmacenet_data *plat)
>> +static void loongson_default_data(struct pci_dev *pdev,
>> +				  struct plat_stmmacenet_data *plat)
>>   {
>> +	/* Get bus_id, this can be overwritten later */
>> +	plat->bus_id = pci_dev_id(pdev);
>> +
>>   	plat->clk_csr = 2;	/* clk_csr_i = 20-35MHz & MDC = clk_csr_i/16 */
>>   	plat->has_gmac = 1;
>>   	plat->force_sf_dma_mode = 1;
>> @@ -49,9 +53,10 @@ static void loongson_default_data(struct plat_stmmacenet_data *plat)
>>   	plat->dma_cfg->pblx8 = true;
>>   }
>>   
>> -static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
>> +static int loongson_gmac_data(struct pci_dev *pdev,
>> +			      struct plat_stmmacenet_data *plat)
>>   {
>> -	loongson_default_data(plat);
>> +	loongson_default_data(pdev, plat);
>>   
>>   	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
>>   
>> @@ -68,15 +73,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>>   	struct device_node *np;
>> -	int ret, i, phy_mode;
>> +	int ret, i;
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
>> @@ -87,17 +87,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
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
>> -	if (!plat->dma_cfg) {
>> -		ret = -ENOMEM;
>> -		goto err_put_node;
>> -	}
>> +	if (!plat->dma_cfg)
>> +		return -ENOMEM;
>>   
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>> @@ -117,49 +109,58 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	}
>>   
>>   	info = (struct stmmac_pci_info *)id->driver_data;
>> -	ret = info->setup(plat);
>> +	ret = info->setup(pdev, plat);
>>   	if (ret)
>>   		goto err_disable_device;
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
>> -		goto err_disable_device;
>> -	}
>> +	if (np) {
>> +		plat->mdio_node = of_get_child_by_name(np, "mdio");
>> +		if (plat->mdio_node) {
>> +			dev_info(&pdev->dev, "Found MDIO subnode\n");
>> +			plat->mdio_bus_data->needs_reset = true;
>> +		}
>>   
>> -	plat->phy_interface = phy_mode;
>> +		ret = of_alias_get_id(np, "ethernet");
>> +		if (ret >= 0)
>> +			plat->bus_id = ret;
>>   
>> -	pci_set_master(pdev);
>> +		ret = device_get_phy_mode(&pdev->dev);
>> +		if (ret < 0) {
>> +			dev_err(&pdev->dev, "phy_mode not found\n");
>> +			goto err_disable_device;
>> +		}
>> +
>> +		plat->phy_interface = ret;
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
> Please merge in the patch:
> [PATCH net-next v13 11/15] net: stmmac: dwmac-loongson: Add loongson_dwmac_dt_config
> content into this one and introduce the method:
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
> just below the loongson_dwmac_dt_config() function. Thus the only code
> left in the probe() method would be:
>
> 	if (dev_of_node(&pdev->dev))
> 		ret = loongson_dwmac_dt_config(pdev, plat, &res);
> 	else
> 		ret = loongson_dwmac_acpi_config(pdev, plat, &res);
>
> 	if (ret)
> 		goto err_disable_device;
>
> As a result this patch will look simpler and more coherent. So will
> the probe() method with no additional change required for that.

OK!


Thanks,

Yanteng




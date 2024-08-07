Return-Path: <netdev+bounces-116351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516494A189
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B900BB291B7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081541C688B;
	Wed,  7 Aug 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMSw7Bu0"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9781C57BE
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015183; cv=none; b=YabxSOPuL/SOL34DSZyokdtR/0XeN/MTxGR55SrdFTVyG2jlaWFFK851SrDU/N8dDMAjycO0Hj19abHbgfflBh/u5hv/dgOU/H31eYzw6chC4FSS85vL1rgWvfkOFeJYFSxSBPhZW/4VwiCflP7Ls65nGbLT2V0IeEAFRg94x2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015183; c=relaxed/simple;
	bh=EzImKoe21Ny1DDgPdqcuVO3tYiGY+dxQJ78CvqoJcto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIHaHsKvPw3bOkXk6x5LlidAzi/UyK2U1J976NFKxrDV5sdKsf1NYLSOEnvk2EAz86BAWYLU59DOFgcWv4IVZ7obgCyPIxsvprLhoubPL5ycPC5g2FJUwtVc7Bui+hW8HiXuqQe0M6ZKi1ULP3uEW4CCZzg0DmM484H1EHlUr3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMSw7Bu0; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0de379e4-7a7b-45cb-9f6c-8f404fc79a06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723015179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HspFRL46w34db6jptrt0Olyvx8vdOBhNMjiKL9yu4Q0=;
	b=CMSw7Bu0aHnVjkQ5UjASQPlrDyUQFdXFR/u6F2yoEiS9y2nrtr+Zi5b6UqZEQNdHvvaKXy
	26wf+Mwg8rCWGqm2gPF+NFocOCfEvtkgI78Wik23/XxV4ifJNiQN6IPJUMxl6+Ug4myB/F
	lNXeIaEaliQFn0qRgaI+YK0G1mvm1M4=
Date: Wed, 7 Aug 2024 15:19:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v16 11/14] net: stmmac: dwmac-loongson: Add
 DT-less GMAC PCI-device support
To: Serge Semin <fancer.lancer@gmail.com>, Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 Huacai Chen <chenhuacai@loongson.cn>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <5f5875eb510e03acd25aa5adbc4f55b370a9762e.1722924540.git.siyanteng@loongson.cn>
 <6tr4gaybcurhdgoyhbm5xbq46l6gbci2ytbzogu37aln4kivmq@kwm6m6b4bvzs>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <6tr4gaybcurhdgoyhbm5xbq46l6gbci2ytbzogu37aln4kivmq@kwm6m6b4bvzs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/7 3:10, Serge Semin 写道:
> On Tue, Aug 06, 2024 at 06:59:44PM +0800, Yanteng Si wrote:
>> The Loongson GMAC driver currently supports the network controllers
>> installed on the LS2K1000 SoC and LS7A1000 chipset, for which the GMAC
>> devices are required to be defined in the platform device tree source.
>> But Loongson machines may have UEFI (implies ACPI) or PMON/UBOOT
>> (implies FDT) as the system bootloaders. In order to have both system
>> configurations support let's extend the driver functionality with the
>> case of having the Loongson GMAC probed on the PCI bus with no device
>> tree node defined for it. That requires to make the device DT-node
>> optional, to rely on the IRQ line detected by the PCI core and to
>> have the MDIO bus ID calculated using the PCIe Domain+BDF numbers.
>>
>> In order to have the device probe() and remove() methods less
>> complicated let's move the DT- and ACPI-specific code to the
>> respective sub-functions.
>>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>   .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 163 +++++++++++-------
>>   1 file changed, 100 insertions(+), 63 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
>> index 10b49bea8e3c..6ba4674bc076 100644
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
>>   	plat->tx_queues_to_use = 1;
>>   	plat->rx_queues_to_use = 1;
>> @@ -65,20 +70,83 @@ static struct stmmac_pci_info loongson_gmac_pci_info = {
>>   	.setup = loongson_gmac_data,
>>   };
>>   
>> +static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>> +				    struct plat_stmmacenet_data *plat,
>> +				    struct stmmac_resources *res)
>> +{
>> +	struct device_node *np = dev_of_node(&pdev->dev);
>> +	int ret;
>> +
>> +	plat->mdio_node = of_get_child_by_name(np, "mdio");
>> +	if (plat->mdio_node) {
>> +		dev_info(&pdev->dev, "Found MDIO subnode\n");
>> +		plat->mdio_bus_data->needs_reset = true;
>> +	}
>> +
>> +	ret = of_alias_get_id(np, "ethernet");
>> +	if (ret >= 0)
>> +		plat->bus_id = ret;
>> +
>> +	res->irq = of_irq_get_byname(np, "macirq");
>> +	if (res->irq < 0) {
>> +		dev_err(&pdev->dev, "IRQ macirq not found\n");
>> +		ret = -ENODEV;
>> +		goto err_put_node;
>> +	}
>> +
>> +	res->wol_irq = of_irq_get_byname(np, "eth_wake_irq");
>> +	if (res->wol_irq < 0) {
>> +		dev_info(&pdev->dev,
>> +			 "IRQ eth_wake_irq not found, using macirq\n");
>> +		res->wol_irq = res->irq;
>> +	}
>> +
>> +	res->lpi_irq = of_irq_get_byname(np, "eth_lpi");
>> +	if (res->lpi_irq < 0) {
>> +		dev_err(&pdev->dev, "IRQ eth_lpi not found\n");
>> +		ret = -ENODEV;
>> +		goto err_put_node;
>> +	}
>> +
>> +	ret = device_get_phy_mode(&pdev->dev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "phy_mode not found\n");
>> +		ret = -ENODEV;
>> +		goto err_put_node;
>> +	}
>> +
>> +	plat->phy_interface = ret;
> +
> +	return 0;
>
> Arggg. Alas I missed this part in v15.(
>
> The rest of changes looks good. Thanks!

OK, Thanks!


Thanks,

Yanteng

>
> -Serge(y)
>
>> +
>> +err_put_node:
>> +	of_node_put(plat->mdio_node);
>> +
>> +	return ret;
>> +}
>> +
>>
>> ...


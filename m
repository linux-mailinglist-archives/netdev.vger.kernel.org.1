Return-Path: <netdev+bounces-116347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5F94A171
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D7A72830C8
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C5198A21;
	Wed,  7 Aug 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmhUtXZJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712E745CB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723014944; cv=none; b=u8AhuwyjBw48BJ8+l1rb9vuLgzB4gQHJ5RCWbnZSQ/KqFssUNx1YJgzdb30uCDxRleYc6nGS3Rdq6cYe2DY+Sa8fR7t8kmjXqo3lYcUvWq1yee7LW8fU4yvAXvZT/w232OxI7d0RpQI799ERveeo6qSQbxO6ihdoAhtqUjfRxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723014944; c=relaxed/simple;
	bh=pLe7E9aaNY0TWy69yuvvKq6Qq1S+odBH/Mgkx5n42mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fe62wouAeGk0O2MSw3fCCZu5wJyzWb2XZr8dgcNQcd27/80FgmyHVmec3zyhLAqSFFUzADsAJ1N+q4zYtdQBsPecebYG8fCjufXcPxyjVxZTIK9xYKXqyWNi9a6gnvy2M5X80gDX9pzbRt2D1UjsPm/qV74hZa0QCFbZ+yLM7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmhUtXZJ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35e9ba13-cbd6-4ecd-a8e4-5f4acb40d9b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723014939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C5kjWz+KJm/pCpzpaTO1D6hGWXgahTZ/5aDEaomL05Y=;
	b=PmhUtXZJuZ+C7wSYmQt0QNJ876VN7RLJ5SWDeOWtIBf2TeIeFIR6HNcmTXeTfu72cC6UOo
	6TCgxdFex4g/9y77C5MHGs8CJchyum2684MVtG4DQhWYmtacJgZDEAU6yfGfDu/owzBBLc
	G5Egi2RbrOIJj0AqamRMuamdnc6JFHY=
Date: Wed, 7 Aug 2024 15:15:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v16 12/14] net: stmmac: dwmac-loongson: Add
 Loongson Multi-channels GMAC support
To: Serge Semin <fancer.lancer@gmail.com>, Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, diasyzhang@tencent.com,
 Jose.Abreu@synopsys.com, chenhuacai@kernel.org, linux@armlinux.org.uk,
 guyinggang@loongson.cn, netdev@vger.kernel.org, chris.chenfeiyang@gmail.com,
 Huacai Chen <chenhuacai@loongson.cn>
References: <cover.1722924540.git.siyanteng@loongson.cn>
 <bd73bc86c1387f9786c610ab55b3c4dd47b907c2.1722924540.git.siyanteng@loongson.cn>
 <4hqv526s32ldakdd3f6ue26q2sajdreyfdrivlwpmhpovwcjns@n7t7u2yqceaw>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: YanTeng Si <si.yanteng@linux.dev>
In-Reply-To: <4hqv526s32ldakdd3f6ue26q2sajdreyfdrivlwpmhpovwcjns@n7t7u2yqceaw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/7 3:17, Serge Semin 写道:
> On Tue, Aug 06, 2024 at 07:00:22PM +0800, Yanteng Si wrote:
>> The Loongson DWMAC driver currently supports the Loongson GMAC
>> devices (based on the DW GMAC v3.50a/v3.73a IP-core) installed to the
>> LS2K1000 SoC and LS7A1000 chipset. But recently a new generation
>> LS2K2000 SoC was released with the new version of the Loongson GMAC
>> synthesized in. The new controller is based on the DW GMAC v3.73a
>> IP-core with the AV-feature enabled, which implies the multi
>> DMA-channels support. The multi DMA-channels feature has the next
>> vendor-specific peculiarities:
>>
>> 1. Split up Tx and Rx DMA IRQ status/mask bits:
>>         Name              Tx          Rx
>>    DMA_INTR_ENA_NIE = 0x00040000 | 0x00020000;
>>    DMA_INTR_ENA_AIE = 0x00010000 | 0x00008000;
>>    DMA_STATUS_NIS   = 0x00040000 | 0x00020000;
>>    DMA_STATUS_AIS   = 0x00010000 | 0x00008000;
>>    DMA_STATUS_FBI   = 0x00002000 | 0x00001000;
>> 2. Custom Synopsys ID hardwired into the GMAC_VERSION.SNPSVER register
>> field. It's 0x10 while it should have been 0x37 in accordance with
>> the actual DW GMAC IP-core version.
>> 3. There are eight DMA-channels available meanwhile the Synopsys DW
>> GMAC IP-core supports up to three DMA-channels.
>> 4. It's possible to have each DMA-channel IRQ independently delivered.
>> The MSI IRQs must be utilized for that.
>>
>> Thus in order to have the multi-channels Loongson GMAC controllers
>> supported let's modify the Loongson DWMAC driver in accordance with
>> all the peculiarities described above:
>>
>> 1. Create the multi-channels Loongson GMAC-specific
>>     stmmac_dma_ops::dma_interrupt()
>>     stmmac_dma_ops::init_chan()
>>     callbacks due to the non-standard DMA IRQ CSR flags layout.
>> 2. Create the Loongson DWMAC-specific platform setup() method
>> which gets to initialize the DMA-ops with the dwmac1000_dma_ops
>> instance and overrides the callbacks described in 1. The method also
>> overrides the custom Synopsys ID with the real one in order to have
>> the rest of the HW-specific callbacks correctly detected by the driver
>> core.
>> 3. Make sure the platform setup() method enables the flow control and
>> duplex modes supported by the controller.
>>
>> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Acked-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
>> ---
>>
>> ...
>>
>> +
>> +static int loongson_dwmac_msi_config(struct pci_dev *pdev,
>> +				     struct plat_stmmacenet_data *plat,
>> +				     struct stmmac_resources *res)
>> +{
>> +	int i, ret, vecs;
>> +
>> +	vecs = roundup_pow_of_two(CHANNEL_NUM * 2 + 1);
>> +	ret = pci_alloc_irq_vectors(pdev, vecs, vecs, PCI_IRQ_MSI);
>> +	if (ret < 0) {
>> +		dev_warn(&pdev->dev, "Failed to allocate MSI IRQs\n");
>> +		return ret;
>> +	}
>> +
>> +	res->irq = pci_irq_vector(pdev, 0);
>> +
>> +	for (i = 0; i < plat->rx_queues_to_use; i++) {
>> +		res->rx_irq[CHANNEL_NUM - 1 - i] =
>> +			pci_irq_vector(pdev, 1 + i * 2);
>> +	}
>> +
>> +	for (i = 0; i < plat->tx_queues_to_use; i++) {
>> +		res->tx_irq[CHANNEL_NUM - 1 - i] =
>> +			pci_irq_vector(pdev, 2 + i * 2);
>> +	}
>> +
>> +	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
>> +
>> +	return 0;
>> +}
>> +
>> +static void loongson_dwmac_msi_clear(struct pci_dev *pdev)
>> +{
>> +	pci_free_irq_vectors(pdev);
>> +}
>> +
>>   static int loongson_dwmac_dt_config(struct pci_dev *pdev,
>>   				    struct plat_stmmacenet_data *plat,
>>   				    struct stmmac_resources *res)
>> @@ -146,6 +450,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	struct plat_stmmacenet_data *plat;
>>   	struct stmmac_pci_info *info;
>>   	struct stmmac_resources res;
>> +	struct loongson_data *ld;
>>   	int ret, i;
>>   
>>   	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
>> @@ -162,6 +467,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (!plat->dma_cfg)
>>   		return -ENOMEM;
>>   
>> +	ld = devm_kzalloc(&pdev->dev, sizeof(*ld), GFP_KERNEL);
>> +	if (!ld)
>> +		return -ENOMEM;
>> +
>>   	/* Enable pci device */
>>   	ret = pci_enable_device(pdev);
>>   	if (ret) {
>> @@ -184,6 +493,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	memset(&res, 0, sizeof(res));
>>   	res.addr = pcim_iomap_table(pdev)[0];
>>   
>> +	plat->bsp_priv = ld;
>> +	plat->setup = loongson_dwmac_setup;
>> +	ld->loongson_id = readl(res.addr + GMAC_VERSION) & 0xff;
>> +
>>   	info = (struct stmmac_pci_info *)id->driver_data;
>>   	ret = info->setup(pdev, plat);
>>   	if (ret)
>> @@ -196,6 +509,10 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   	if (ret)
>>   		goto err_disable_device;
>>   
>> +	/* Use the common MAC IRQ if per-channel MSIs allocation failed */
>> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
>> +		loongson_dwmac_msi_config(pdev, plat, &res);
>> +
>>   	ret = stmmac_dvr_probe(&pdev->dev, plat, &res);
>>   	if (ret)
>>   		goto err_plat_clear;
>> @@ -205,6 +522,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
>>   err_plat_clear:
>>   	if (dev_of_node(&pdev->dev))
>>   		loongson_dwmac_dt_clear(pdev, plat);
>> +	loongson_dwmac_msi_clear(pdev);
> Em, why have you dropped the if-statement here? That has caused the
> Simon note to be posted. Please get it back:
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);
OK.
>
>>   err_disable_device:
>>   	pci_disable_device(pdev);
>>   	return ret;
>> @@ -214,12 +532,15 @@ static void loongson_dwmac_remove(struct pci_dev *pdev)
>>   {
>>   	struct net_device *ndev = dev_get_drvdata(&pdev->dev);
>>   	struct stmmac_priv *priv = netdev_priv(ndev);
>> +	struct loongson_data *ld;
>>   	int i;
>>   
>> +	ld = priv->plat->bsp_priv;
>>   	stmmac_dvr_remove(&pdev->dev);
>>   
>>   	if (dev_of_node(&pdev->dev))
>>   		loongson_dwmac_dt_clear(pdev, priv->plat);
>> +	loongson_dwmac_msi_clear(pdev);
> Ditto. Please get back the conditional MSI-clear method execution:
> +
> +	if (ld->loongson_id == DWMAC_CORE_LS_MULTICHAN)
> +		loongson_dwmac_msi_clear(pdev);
>
> * Note the empty line above the if-statement.

OK, Thanks!


Thanks,

Yanteng

>
> -Serge(y)
>
>>   
>>   	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>>   		if (pci_resource_len(pdev, i) == 0)
>> -- 
>> 2.31.4
>>


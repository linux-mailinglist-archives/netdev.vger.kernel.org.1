Return-Path: <netdev+bounces-134281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA8B99897F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7270281DAB
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C01CCEE9;
	Thu, 10 Oct 2024 14:24:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C21CB527;
	Thu, 10 Oct 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570261; cv=none; b=i97XTm91mcKhuHhQjGHpYbjqy46sbC82czPdyUKH139814KQgKjrdQ9UgmBs0IC+SBfp/RIz5K3yvTEK0NrKb6B9RatMFAKjAxBhBTRzbLcd9Han1BAnPtv/XJ1fpBzcJ3jJgQVeVosLqf33MsWxb5NMhuTcqe9oCo+DUwS3OA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570261; c=relaxed/simple;
	bh=AVk0rOcfLhGJPiyPs34UfJ4+w3gZGPNHVE7VgsbwGds=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dc+50gz4plVjTeXhFFE9HpJgaXSw0dXwTVaaQ9tHhKwIvk0TVm8B4547vk+OBnlxg+CYwHNrgnGlj2KowVuNQvANKmNw/ZYECbBIvej+8U4M4OK7znnnr5zv9VoLD5No8ry3fZEaP982PzpEAvMlWskp04Twcnolt2HGfzo69KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPX6C1KPzzySYV;
	Thu, 10 Oct 2024 22:22:59 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id B538F140157;
	Thu, 10 Oct 2024 22:24:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:24:15 +0800
Message-ID: <b66e0400-a95b-476d-b571-4e595127ef80@huawei.com>
Date: Thu, 10 Oct 2024 22:24:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V11 net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
To: Simon Horman <horms@kernel.org>
References: <20241008022358.863393-1-shaojijie@huawei.com>
 <20241008022358.863393-5-shaojijie@huawei.com>
 <20241010102201.GG1098236@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241010102201.GG1098236@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/10 18:22, Simon Horman wrote:
> On Tue, Oct 08, 2024 at 10:23:52AM +0800, Jijie Shao wrote:
>> The driver supports four interrupts: TX interrupt, RX interrupt,
>> mdio interrupt, and error interrupt.
>>
>> Actually, the driver does not use the mdio interrupt.
>> Therefore, the driver does not request the mdio interrupt.
>>
>> The error interrupt distinguishes different error information
>> by using different masks. To distinguish different errors,
>> the statistics count is added for each error.
>>
>> To ensure the consistency of the code process, masks are added for the
>> TX interrupt and RX interrupt.
>>
>> This patch implements interrupt request, and provides a
>> unified entry for the interrupt handler function. However,
>> the specific interrupt handler function of each interrupt
>> is not implemented currently.
>>
>> Because of pcim_enable_device(), the interrupt vector
>> is already device managed and does not need to be free actively.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ...
>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> ...
>
>> +static const char *irq_names_map[HBG_VECTOR_NUM] = { "tx", "rx", "err", "mdio" };
>> +
>> +int hbg_irq_init(struct hbg_priv *priv)
>> +{
>> +	struct hbg_vector *vectors = &priv->vectors;
>> +	struct device *dev = &priv->pdev->dev;
>> +	int ret, id;
>> +	u32 i;
>> +
>> +	/* used pcim_enable_device(),  so the vectors become device managed */
>> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
>> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to allocate MSI vectors\n");
>> +
>> +	if (ret != HBG_VECTOR_NUM)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "requested %u MSI, but allocated %d MSI\n",
>> +				     HBG_VECTOR_NUM, ret);
>> +
>> +	/* mdio irq not requested, so the number of requested interrupts
>> +	 * is HBG_VECTOR_NUM - 1.
>> +	 */
>> +	for (i = 0; i < HBG_VECTOR_NUM - 1; i++) {
>> +		id = pci_irq_vector(priv->pdev, i);
>> +		if (id < 0)
>> +			return dev_err_probe(dev, id, "failed to get irq number\n");
>> +
>> +		snprintf(vectors->name[i], sizeof(vectors->name[i]), "%s-%s-%s",
>> +			 dev_driver_string(dev), pci_name(priv->pdev),
>> +			 irq_names_map[i]);
>> +
>> +		ret = devm_request_irq(dev, id, hbg_irq_handle, 0,
>> +				       vectors->name[i], priv);
>> +		if (ret)
>> +			return dev_err_probe(dev, ret,
>> +					     "failed to requset irq: %s\n",
> nit: request
>
ok，I will fix all misspellings  detected by checkpatch.
   ./scripts/checkpatch.pl --strict --codespell --max-line-length=80

Thanks,
   Jijie Shao



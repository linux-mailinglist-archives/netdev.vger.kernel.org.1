Return-Path: <netdev+bounces-115764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61654947BD5
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927821C21BAB
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0128639879;
	Mon,  5 Aug 2024 13:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439DE155C8D;
	Mon,  5 Aug 2024 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864602; cv=none; b=H/T9m4V3hxsY0prNglN5dc8qeNZH8a5ZI/h+QZZ4ugews33Vj5xbEQ4QaaIMr/1LNtK4SxxXR88dkH7/Psl9WfURiwy3Uk+NJ56CA9oltDL3C0avg7BjDU/TY6QEQe3Di4P+rn4+l2RwyFl8u0AEBWC2XaVAn0iEQFv0HOpUOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864602; c=relaxed/simple;
	bh=YnpMyDaNkbOsHoUswBRJZQMkWcE/xomjVPw6Y0FEUMI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pbLMxR8/t9a4cw00WPlpFmY2VPzSr4YvNpjnFFCLnbPpGlTumrPKhX3ilK6XXcUlBXKVjXxC+pct9EWZc5n/EGBou1C4mcz1Xb8Vr25tALkqa/0pHSZ5CxvV5RNLvkUAfTPj3EquN+KfTeaGi8uxEdYbTwVOEw/Lb/7s6k8u27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wcy3K5Q99zyQ0M;
	Mon,  5 Aug 2024 21:29:49 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E231B140109;
	Mon,  5 Aug 2024 21:29:54 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 21:29:54 +0800
Message-ID: <e56e1fca-90f1-414a-9ed3-5bd7b61ea8b3@huawei.com>
Date: Mon, 5 Aug 2024 21:29:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
To: Simon Horman <horms@kernel.org>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-5-shaojijie@huawei.com>
 <20240805125743.GB2633937@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240805125743.GB2633937@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/5 20:57, Simon Horman wrote:
> On Wed, Jul 31, 2024 at 05:42:39PM +0800, Jijie Shao wrote:
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
>> This patch implements interrupt request and free, and provides a
>> unified entry for the interrupt handler function. However,
>> the specific interrupt handler function of each interrupt
>> is not implemented currently.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ...
>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
> ...
>
>> +int hbg_irq_init(struct hbg_priv *priv)
>> +{
>> +	struct hbg_vector *vectors = &priv->vectors;
>> +	struct hbg_irq *irq;
>> +	int ret;
>> +	int i;
>> +
>> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
>> +				    PCI_IRQ_MSI);
>> +	if (ret < 0) {
>> +		dev_err(&priv->pdev->dev,
>> +			"failed to allocate MSI vectors, vectors = %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (ret != HBG_VECTOR_NUM) {
>> +		dev_err(&priv->pdev->dev,
>> +			"requested %u MSI, but allocated %d MSI\n",
>> +			HBG_VECTOR_NUM, ret);
>> +		ret = -EINVAL;
>> +		goto free_vectors;
>> +	}
>> +
>> +	vectors->irqs = devm_kcalloc(&priv->pdev->dev, HBG_VECTOR_NUM,
>> +				     sizeof(struct hbg_irq), GFP_KERNEL);
>> +	if (!vectors->irqs) {
>> +		ret = -ENOMEM;
>> +		goto free_vectors;
>> +	}
>> +
>> +	/* mdio irq not request */
>> +	vectors->irq_count = HBG_VECTOR_NUM - 1;
>> +	for (i = 0; i < vectors->irq_count; i++) {
>> +		irq = &vectors->irqs[i];
>> +		snprintf(irq->name, sizeof(irq->name) - 1, "%s-%s-%s",
>> +			 HBG_DEV_NAME, pci_name(priv->pdev), irq_names_map[i]);
>> +
>> +		irq->id = pci_irq_vector(priv->pdev, i);
>> +		irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
> I think that you <linux/irq.h> needs to be included.
> Else allmodconfig builds - on x86_64 but curiously not ARM64 - fail.

Thank you, this is very confusing. I built successfully on both ARM and x86.
I will rebuild it according to your Clang version to fix this error

Jijie Shao

>
>    CC      drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.o
> drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c: In function 'hbg_irq_init':
> drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c:150:17: error: implicit declaration of function 'irq_set_status_flags' [-Wimplicit-function-declaration]
>    150 |                 irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
>        |                 ^~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c:150:47: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
>    150 |                 irq_set_status_flags(irq->id, IRQ_NOAUTOEN);
>        |                                               ^~~~~~~~~~~~
>        |                                               IRQF_NO_AUTOEN
>
> ...


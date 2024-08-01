Return-Path: <netdev+bounces-114904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38A944A6E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FFB1C233C6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABCA18B48E;
	Thu,  1 Aug 2024 11:32:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C67406D;
	Thu,  1 Aug 2024 11:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511926; cv=none; b=K+Q+n7zvG5w0frsLLzlj+N8FumfkJFy7g410zgH8HAjbOYOjGR/68Mor+Q/AfY8QpTsvvErUqBptNjb5fY4uM29yUPo6qsM30MVLJ7nkhdRq0/23pncnkPFEVSibqFchfVYveJYjJSPOaXkigGOnxMFEDdaB/oLymUaz8APO8A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511926; c=relaxed/simple;
	bh=1tFBMpBuaz4D1xd4zx5KEXv274bi6VF574KwmepU3MM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VYHGsb6/UElC6hxSU5Y3lI7m1Eovte3BAbPrc10q/NwTNMn9TTPe5OJxtjD4gI/2ZmryP2UOdAjBmp9tY4HjN7VN6L1GrQil0HjGgyzyiECGKEFIozPDvZ3Q6qCzzWAayZ8e08hWJtNkTr2cFL63VDbmZRAFThGM7bDiMNsvBZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZRWR1yvNzyPKF;
	Thu,  1 Aug 2024 19:26:59 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id B788014041B;
	Thu,  1 Aug 2024 19:31:58 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 19:31:57 +0800
Message-ID: <c99f9d0b-876b-478b-9acc-7961d442497c@huawei.com>
Date: Thu, 1 Aug 2024 19:31:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>
Subject: Re: [RFC PATCH net-next 04/10] net: hibmcge: Add interrupt supported
 in this module
To: Joe Damato <jdamato@fastly.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-5-shaojijie@huawei.com> <Zqo4mGq88BajjLk_@LQ3V64L9R2>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <Zqo4mGq88BajjLk_@LQ3V64L9R2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/7/31 21:14, Joe Damato wrote:
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
> Here the comment says mdio is not requested? But it does seem like
> the IRQ is allocated above, it's just unused?

Yes, not request_irq only alloc

>
> Maybe above you should remove mdio completely if its not in use?
>
> Or is it used later in some other patch or something?

MDIO is required because the PHY is used.

However, the mdio interrupt provided by the hardware is not used.


If only 3 interrupts are alloc, an error is reported
when the driver is loaded and unloaded again,

log:
     insmod hibmcge.ko
     Generic PHY mii-0000:83:00.1:02: attached PHY driver (mii_bus:phy_addr=mii-0000:83:00.1:02, irq=POLL)
     hibmcge 0000:83:00.1 enp131s0f1: renamed from eth0
     IPv6: ADDRCONF(NETDEV_CHANGE): enp131s0f1: link becomes ready
     hibmcge 0000:83:00.1: link up!

     rmmod hibmcge.ko
     insmod hibmcge.ko
     hibmcge 0000:83:00.1: failed to allocate MSI vectors, vectors = -28
     hibmcge: probe of 0000:83:00.1 failed with error -28

>
>> +	for (i = 0; i < vectors->irq_count; i++) {

Therefore, only three interrupts are requested by request_irq
because "vectors->irq_count = HBG_VECTOR_NUM - 1"


Thanks,

Jijie Shao



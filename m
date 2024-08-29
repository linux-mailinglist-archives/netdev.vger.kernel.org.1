Return-Path: <netdev+bounces-123274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69829645AD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 15:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C751C22AC5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470D019047F;
	Thu, 29 Aug 2024 13:02:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73F9474;
	Thu, 29 Aug 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724936573; cv=none; b=CcyxoiJB7PdkD670rR5S9+XIFNLJihHSfS4ost8vMxr9kI+QhcDffoXc35Q7HFR32kZJlwc1nlrneMh5krmrT5b/0P23Q2CXmWoPrPXTYtyrh3bPqpTVLl0nueLo5eTN2H0S+aM3mJK4QQuJf1R9EeXUWVNwC6yN4xIJIeXcGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724936573; c=relaxed/simple;
	bh=MJAsT1I9Kx7E5vFyDWVe9EMwDu6x6jM4Wdm1lX8dmM0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=peRzac9sYRjBdyNFgPCC7gUkzMKUco8SK4laESxi37P5K2G8+v+SSEop8N7i1+/QA+TOmounw2YS5S0aT5qldayfas5XbuR+4wiw2wOLUWEVxHHtpVS6KlfXyRgmKoBGNJ7wRVkMZ06ctvwSF7/gjCMOe2VYeLrhCjAYCE9CO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvhJr2LMjz2DbYx;
	Thu, 29 Aug 2024 21:02:36 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E822140153;
	Thu, 29 Aug 2024 21:02:49 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 21:02:48 +0800
Message-ID: <383f26a1-aa8f-4fd2-a00a-86abce5942ad@huawei.com>
Date: Thu, 29 Aug 2024 21:02:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 04/11] net: hibmcge: Add interrupt supported
 in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-5-shaojijie@huawei.com>
 <20240828183536.130df0fa@kernel.org>
 <6c7d1538-5a94-466a-bd4b-022b5570b287@huawei.com>
 <20240828191213.3237eaaa@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240828191213.3237eaaa@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 10:12, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 09:54:00 +0800 Jijie Shao wrote:
>> on 2024/8/29 9:35, Jakub Kicinski wrote:
>>> On Tue, 27 Aug 2024 21:14:48 +0800 Jijie Shao wrote:
>>>> +	ret = pci_alloc_irq_vectors(priv->pdev, HBG_VECTOR_NUM, HBG_VECTOR_NUM,
>>>> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
>>> These are not devm_ -managed, don't you have to free them?
>>> On remove and errors during probe?
>>>   
>> Jonathan Cameron told me:
>> 	I have used pcim_enable(),  so, the irq vectors become device managed.
>> Look for where those paths call pci_setup_msi_context() / pcim_setup_msi_release()
>>
>> So there should be no need to free the vectors on remove()
> Please include change logs in individual patches, going forward.
> Please add this information to the commit message, and remove
> the existing mention of freeing there which is now out of date.

Ok, I'll add a note to that as well.
	Thanks,
	Jijie Shao



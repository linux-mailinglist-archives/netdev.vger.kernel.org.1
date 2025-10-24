Return-Path: <netdev+bounces-232368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4AC04B4E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E64E4E62
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98F2C17B2;
	Fri, 24 Oct 2025 07:24:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B9423E35E;
	Fri, 24 Oct 2025 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290699; cv=none; b=VCGWydMhXDb8tXOj2YVzzyTBPNPtt7LBTIl97RtUGk3baMI3HeexMrQxR4mghNj0vzcvbFNXPcZMz+pgqSAsjxW7bfke+8hFCLEOYNvU1PDv0Wt9yeZZAsBo01OHqK+GquQw9lWB9jXRDquy6l89YOmyLYi+omRrz0ADjFcCRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290699; c=relaxed/simple;
	bh=fwedoOSehN9OYgxnwRWiJB7Z7malJPodTXNiVHLi9TI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D4Gkh8UTsz8ZUrUQlVlj+q7JwuPQsxB+tJqDSZFUq8Sk6gJ59PaBQgI83vlKizGmDDxvcA5XDxhdezTircWiAlYOZ+50e0p7KsfAuurIDqWvgpp8wV8dZofHhiovqv8fjiO0v1niEkm5fj/yVIpJMzDFqFAb5jLIYwU3y7jLu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ctDsz0vXmznffp;
	Fri, 24 Oct 2025 15:24:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 01FAD1401F3;
	Fri, 24 Oct 2025 15:24:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Oct 2025 15:24:53 +0800
Message-ID: <f99d878c-abf3-41ae-ae7f-b1db4f205561@huawei.com>
Date: Fri, 24 Oct 2025 15:24:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 0/3] There are some bugfix for hibmcge ethernet driver
To: Jacob Keller <jacob.e.keller@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>
References: <20251021140016.3020739-1-shaojijie@huawei.com>
 <49a1be1b-36c2-463e-8684-8781d4654da8@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <49a1be1b-36c2-463e-8684-8781d4654da8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/10/24 9:08, Jacob Keller wrote:
>
> On 10/21/2025 7:00 AM, Jijie Shao wrote:
>> This patch set is intended to fix several issues for hibmcge driver:
>> 1. Patch1 fixes the issue where buf avl irq is disabled after irq_handle.
>> 2. Patch2 eliminates the error logs in scenarios without phy.
>> 3. Patch3 fixes the issue where the network port becomes unusable
>>     after a PCIe RAS event.
>>
>>
> We typically suggest using imperative wording for the subject such as
> "bug fixes for the hibmcge ethernet driver".

Ok, I will change in V2

Thanks,
Jijie Shao

>> Jijie Shao (3):
>>    net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
>>    net: hibmcge: remove unnecessary check for np_link_fail in scenarios
>>      without phy.
>>    net: hibmcge: fix the inappropriate netif_device_detach()
>>
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h |  1 +
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c    | 10 ++++++----
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     |  3 +++
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c    |  1 +
>>   drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   |  1 -
>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>


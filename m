Return-Path: <netdev+bounces-204907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD7AFC740
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AAE3A6EA4
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B482356A4;
	Tue,  8 Jul 2025 09:41:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EF67E107;
	Tue,  8 Jul 2025 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967704; cv=none; b=n3zL9M9MSC5xmfEVZeXSmAllFGuS8+rXiH2VBBgAGQvXeEC0LJ8syMaFz/DmffFrZwaDND7U5muUT6a5plZ2udTdJCpLt7RICmWbZfNR8LRLBqoEatBQhwid3RVqoS5UitSraZdwjuIba212YbiMGRgviCQovckXh6y+jZKgCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967704; c=relaxed/simple;
	bh=iLKKuMSbrdpAwaqDezZ+Txnb1DoBrR3Dp54ZYQAXPbA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d1kv3jy+MQOITMuIc81NLW+tHUsMowrsWlDevZ3NhbhmeaRDsfBjZ7Rv8M84NgaLAJ9Qpw8/4o6FtIBqaurc5Xjb4W8bBpLUqNSGoqgYE2ednC6vRJFuawnl/zOnvJ3ELWm+jqc4LzE1mD78BB6KsBWvqd0UAAQBkWdKSL/3JCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bbx1B5KjcztSjJ;
	Tue,  8 Jul 2025 17:40:30 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7339E180482;
	Tue,  8 Jul 2025 17:41:37 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 17:41:36 +0800
Message-ID: <21993e23-9ac6-4108-94e6-752fe32a11d2@huawei.com>
Date: Tue, 8 Jul 2025 17:41:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 4/4] net: hns3: default enable tx bounce buffer when
 smmu enabled
To: Simon Horman <horms@kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-5-shaojijie@huawei.com>
 <20250704163149.GJ41770@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250704163149.GJ41770@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/5 0:31, Simon Horman wrote:
> On Wed, Jul 02, 2025 at 09:09:01PM +0800, Jijie Shao wrote:
>> The SMMU engine on HIP09 chip has a hardware issue.
>> SMMU pagetable prefetch features may prefetch and use a invalid PTE
>> even the PTE is valid at that time. This will cause the device trigger
>> fake pagefaults. The solution is to avoid prefetching by adding a
>> SYNC command when smmu mapping a iova. But the performance of nic has a
>> sharp drop. Then we do this workaround, always enable tx bounce buffer,
>> avoid mapping/unmapping on TX path.
>>
>> This issue only affects HNS3, so we always enable
>> tx bounce buffer when smmu enabled to improve performance.
>>
>> Fixes: 295ba232a8c3 ("net: hns3: add device version to replace pci revision")
> The cited commit may be a pre-requisite for this patch
> to check HNAE3_DEVICE_VERSION_V3. But it seems to me that the problem
> being addressed existed before the cited commit. If so, I think a different
> Fixes tag is appropriate.
>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 +++++++++++++++++
>>   .../net/ethernet/hisilicon/hns3/hns3_enet.h   |  2 ++
>>   .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
> It seems to me that the hns3_ethtool.c changes a) are not a requirement
> for the work-around introduced by this patch and b) may introduce
> complex behaviour between the effect of ethtool copybreak settings
> and the enablement/non-enablement of the work-around.
>
> Would it be possible to make a more minimal fix for net, that
> omits the ethtool changes. And then follow-up with them for net-next
> once the fix is present there?

I will discuss your suggestion with my team.

Thanks
Jijie Shao



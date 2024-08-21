Return-Path: <netdev+bounces-120426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7999959458
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A37B1F224E4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E30A1684AB;
	Wed, 21 Aug 2024 06:04:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22D16B38E;
	Wed, 21 Aug 2024 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220249; cv=none; b=Urpti6wrxppualtFvxwPQR8f89aeHOwvBmhI7nsmS8QNiLhfVYw9j7myKf6y0GTV9opLVf7HbmYCJSVm5Q7tLYJ8NALu39CSmIf/ibw22PBojbF+WeetRT1ZlKxLRWd+X0B61TgXIYgLXi9D33+Atkx/+CRzMNxTzBWBFMfV9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220249; c=relaxed/simple;
	bh=CFPBUP/YQXMgNy2dHHxRPZWn5DP7GNDcKs3a2Tde750=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SgnzzkhcKN9YMqZi28HM3hxk0cPLGcpXDsTcNJ6YGEEgeg5zGeB7J2ypzsdeo2PRpJ7pi2TX1PCgCYYnc+4HAS2znnkOFu2VF9lPtVZ/kzCpq+PtzNL44+GuZ2hDkWnDaGJ2x6FaWrCS8LsElHLB7RZVOfuGZKge9mx0ltt0s/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpbJB1x5tz20m5x;
	Wed, 21 Aug 2024 13:59:22 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id AE8431401F3;
	Wed, 21 Aug 2024 14:04:03 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:04:02 +0800
Message-ID: <7bc7a054-f180-444a-aac0-61997b43e5d6@huawei.com>
Date: Wed, 21 Aug 2024 14:04:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 11/11] net: add is_valid_ether_addr check in
 dev_set_mac_address
To: Jakub Kicinski <kuba@kernel.org>
References: <20240820140154.137876-1-shaojijie@huawei.com>
 <20240820140154.137876-12-shaojijie@huawei.com>
 <20240820185507.4ee83dcc@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240820185507.4ee83dcc@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/21 9:55, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 22:01:54 +0800 Jijie Shao wrote:
>> core need test the mac_addr not every driver need to do.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   net/core/dev.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index e7260889d4cb..2e19712184bc 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -9087,6 +9087,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>>   		return -EOPNOTSUPP;
>>   	if (sa->sa_family != dev->type)
>>   		return -EINVAL;
>> +	if (!is_valid_ether_addr(sa->sa_data))
>> +		return -EADDRNOTAVAIL;
> not every netdev is for an Ethernet device

ok， this patch will be removed in v3.
and the check will move to hibmcge driver.
Thanks a lot.
	
	Jijie Shao




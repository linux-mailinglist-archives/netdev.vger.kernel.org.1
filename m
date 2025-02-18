Return-Path: <netdev+bounces-167189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4EA390CC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 03:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5ED1891E3A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEF77111;
	Tue, 18 Feb 2025 02:16:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412B29D05;
	Tue, 18 Feb 2025 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739845004; cv=none; b=ARU6/ylvr5MQkntcHxHb0DSRC7LzV8RzUhz2gcEbwopAOdTEQorQ6ZzXihOxjgWbBtbuEMLVQIP6c6yhj5eiz3zDnnY90BVgYj5/rSBZkNkjUWJfGOmFpaDFpoefFQDpeXM8z3rueuO6lcNHfoSSNSZFUlDz9Cjg2NSGagjgxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739845004; c=relaxed/simple;
	bh=KSIKrqgUfcQc3XIwuDOIL69wUlOQnzOwboxFHLMyJUc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cdheoJgYbFqnvIduMNEJRSFbL2QRvyrj5fr1QxVQG4q7RASPNu22lsUTX66A8QcMpvzFS/BhdGMFhl5T+c0qdVyJzpMdDZHpA6SuaSHCheM8KPIqWEg6M40He3b/je02L6GEg0jXCvYwa1+tTb/1N1So1bR22uxdVEI6CBNADo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yxjp83fwlz17LYC;
	Tue, 18 Feb 2025 10:17:04 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E75AE1A016C;
	Tue, 18 Feb 2025 10:16:33 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 10:16:32 +0800
Message-ID: <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
Date: Tue, 18 Feb 2025 10:16:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload
 supported in this module
To: Simon Horman <horms@kernel.org>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com>
 <20250217154028.GM1615191@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250217154028.GM1615191@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/17 23:40, Simon Horman wrote:
> On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
>> This patch implements the rx checksum offload feature
>> including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ...
>
>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>> index 8c631a9bcb6b..aa1d128a863b 100644
>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>> @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
>>   }
>>   
>>   static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
>> -				    struct hbg_rx_desc *desc)
>> +				    struct hbg_rx_desc *desc,
>> +				    struct sk_buff *skb)
>>   {
>> +	bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;
> nit: I think this would be better expressed in a way that
>       rx_checksum_offload is assigned a boolean value (completely untested).
>
> 	bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);

Okay, I'll modify it in v2.

Thanks
Jijie Shao

>
>> +
>>   	if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
>>   		   !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
>>   		return true;


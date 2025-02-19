Return-Path: <netdev+bounces-167561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C67F7A3AEC1
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D330165BB4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373F335953;
	Wed, 19 Feb 2025 01:16:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1582620B22;
	Wed, 19 Feb 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927769; cv=none; b=gk4Fm2JT9PMvAjpVsWfHmhsSTinJXYsGQJSAbjPsz1gDUW9WPsmfVx2xrOr+jn5vmRWBIcMJFhOW8kdogOC/k9yZCGGqBAzpYB9MyF2I94EO9OB0sIYdEXaWB9gpsmxLP+SlxyCK23S/UBDpOnO5l9ZoGjoGMhzwfE5q93fGM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927769; c=relaxed/simple;
	bh=VA3PzZokyA+t9wlNxEe2RTywxMNWG4864YQjFM2ElAE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bSP7PeWZONxVuo024iioEEmtspK5x7xw4X5GHii543N+QDk14gcNYhQZPDHeAP+QH1FgXUa3Mi4m+EtpmA3rvmeVe7uzxBIE78YkIsFlE2/V5Db+iJsVCB77RWnyL1vxR8U8Cc5i5LsZFq2F75ytx49xy/CH+PEIcIXnS6fDmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YyJHs6VNKz1Y1qY;
	Wed, 19 Feb 2025 09:11:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C2E01800DB;
	Wed, 19 Feb 2025 09:15:57 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Feb 2025 09:15:56 +0800
Message-ID: <810b96bb-205a-4e21-88a6-c1fb1edd846d@huawei.com>
Date: Wed, 19 Feb 2025 09:15:54 +0800
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
To: Simon Horman <horms@kernel.org>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com>
 <20250217154028.GM1615191@kernel.org>
 <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
 <CAH-L+nM0axD3QWXixe6p7U4dyVx=qn9zh5crOXLTxTH9Gpd9dQ@mail.gmail.com>
 <9d55d0a8-7a85-4caf-8358-7e04621813cc@huawei.com>
 <20250218134214.GY1615191@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250218134214.GY1615191@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/18 21:42, Simon Horman wrote:
> On Tue, Feb 18, 2025 at 04:27:28PM +0800, Jijie Shao wrote:
>> on 2025/2/18 10:46, Kalesh Anakkur Purayil wrote:
>>> On Tue, Feb 18, 2025 at 7:47 AM Jijie Shao <shaojijie@huawei.com> wrote:
>>>> on 2025/2/17 23:40, Simon Horman wrote:
>>>>> On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
>>>>>> This patch implements the rx checksum offload feature
>>>>>> including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
>>>>>>
>>>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>>>> ...
>>>>>
>>>>>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>>>> index 8c631a9bcb6b..aa1d128a863b 100644
>>>>>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>>>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>>>> @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
>>>>>>     }
>>>>>>
>>>>>>     static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
>>>>>> -                                struct hbg_rx_desc *desc)
>>>>>> +                                struct hbg_rx_desc *desc,
>>>>>> +                                struct sk_buff *skb)
>>>>>>     {
>>>>>> +    bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;
>>>>> nit: I think this would be better expressed in a way that
>>>>>         rx_checksum_offload is assigned a boolean value (completely untested).
>>>>>
>>>>>         bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);
>>>> Okay, I'll modify it in v2.
>>> Maybe you can remove " in this module" from the patch title as it is
>>> implicit. This comment/suggestion applies to all patches in this
>>> series.
>> Sorry this may not have any bad effect,
>> so I don't plan to change it in V2.
>> If anyone else thinks it should be modified,
>> I will modify it.
> I agree that a shorter subject would be better.

ok,
v2 has been sent, I'll modify it if need to send v3.

Thanks,
Jijie Shao





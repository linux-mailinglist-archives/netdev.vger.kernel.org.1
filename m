Return-Path: <netdev+bounces-167238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47032A39578
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 09:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE713ACC3E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7666E1D90DB;
	Tue, 18 Feb 2025 08:27:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6961B4250;
	Tue, 18 Feb 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739867260; cv=none; b=DRqcKtoZIYZ3jaTKsNF4Up6wqCxaySQhnTXf4uMlU+9Hho9MhIHOyCI6sB3odlYwIxB4R/i9+0SIihUn01R2s/9swdbYfd0YJV/PMu93wBIzGl8I8VU0cOHLjX6BousiNGeQZNtzFYR4yqZ0MtIQjm3cbmzOefveZjecDdT2Ahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739867260; c=relaxed/simple;
	bh=1soCMC1mDzlUguPyqOBPKxSSzf+ZHtXkwqiV35e1GYA=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ANKerQZPtFJV3tZNasQtM7oFUfjA8w32aqFgBxdNfTW3GxOXjjnbbWqOyAaW1rSN3xdb/PLNJytCwVMxdq3OIJEsH7uXDl0c+nI+mLOujeCjDwGPJQCxGdY2H9NiCUYnIFJC/oKuGcFracZiossvrbjUEj8MV+OXQtTBH32y8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Yxsx40sHkz1wn5P;
	Tue, 18 Feb 2025 16:23:36 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 179661A0188;
	Tue, 18 Feb 2025 16:27:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 16:27:29 +0800
Message-ID: <9d55d0a8-7a85-4caf-8358-7e04621813cc@huawei.com>
Date: Tue, 18 Feb 2025 16:27:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload
 supported in this module
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com>
 <20250217154028.GM1615191@kernel.org>
 <14b562d6-7006-4fe0-be61-48fe1abebe49@huawei.com>
 <CAH-L+nM0axD3QWXixe6p7U4dyVx=qn9zh5crOXLTxTH9Gpd9dQ@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAH-L+nM0axD3QWXixe6p7U4dyVx=qn9zh5crOXLTxTH9Gpd9dQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/18 10:46, Kalesh Anakkur Purayil wrote:
> On Tue, Feb 18, 2025 at 7:47 AM Jijie Shao <shaojijie@huawei.com> wrote:
>>
>> on 2025/2/17 23:40, Simon Horman wrote:
>>> On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
>>>> This patch implements the rx checksum offload feature
>>>> including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
>>>>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>> ...
>>>
>>>> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>> index 8c631a9bcb6b..aa1d128a863b 100644
>>>> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
>>>> @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
>>>>    }
>>>>
>>>>    static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
>>>> -                                struct hbg_rx_desc *desc)
>>>> +                                struct hbg_rx_desc *desc,
>>>> +                                struct sk_buff *skb)
>>>>    {
>>>> +    bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;
>>> nit: I think this would be better expressed in a way that
>>>        rx_checksum_offload is assigned a boolean value (completely untested).
>>>
>>>        bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);
>> Okay, I'll modify it in v2.
> Maybe you can remove " in this module" from the patch title as it is
> implicit. This comment/suggestion applies to all patches in this
> series.

Sorry this may not have any bad effect,
so I don't plan to change it in V2.
If anyone else thinks it should be modified,
I will modify it.

Thanks a lot
Jijie Shao

>> Thanks
>> Jijie Shao
>>
>>>> +
>>>>       if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
>>>>                  !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
>>>>               return true;
>


Return-Path: <netdev+bounces-204905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C217AFC72F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432291BC30D9
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C1125A33F;
	Tue,  8 Jul 2025 09:37:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2522A7FC;
	Tue,  8 Jul 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751967439; cv=none; b=dcs6SjhtA/yS/OeDf4Tnc9ax3f09DgEChn0oLL++lL/clk2JZMdbxF/6pwCq0AHJmYj7VG8cPbi6CqC7oJn62MA8sfUsDtg0YbCqBTfZbiepPb/kg0UmQk9SPNrQiXki8fyZyi0Xh4nZSN+Jsd+AGCX+axKDnLnmHcx8fIeSv8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751967439; c=relaxed/simple;
	bh=evtmkYzSURwlDdyln3pMRkT7yEZxIb4OXTL2FLRXHGc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aw0zrEmQIRN9SGQYIsk9pFVvR+r2T3POl4sB+HANOD8XedmjfkqK7qHtRtMzqjVAHEFqj4bFpfSUtB389zrxFgms7kwh2jVOqwkzfd5VIggPyenBUf60iS6CPfsALAeD9pXIkUwIuRIgWzzpx6ovFzFVr86BIocf23cBv3upuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bbwrH4bw3zWfwb;
	Tue,  8 Jul 2025 17:32:47 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EDD9A180B63;
	Tue,  8 Jul 2025 17:37:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 17:37:12 +0800
Message-ID: <9f4b5409-79a5-481b-9ce1-8ca3ef37b65d@huawei.com>
Date: Tue, 8 Jul 2025 17:37:11 +0800
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
Subject: Re: [PATCH net 3/4] net: hns3: fixed vf get max channels bug
To: David Laight <david.laight.linux@gmail.com>, Simon Horman
	<horms@kernel.org>
References: <20250702130901.2879031-1-shaojijie@huawei.com>
 <20250702130901.2879031-4-shaojijie@huawei.com>
 <20250704160537.GH41770@horms.kernel.org> <20250705082403.0ba474f4@pumpkin>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250705082403.0ba474f4@pumpkin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/5 15:24, David Laight wrote:
> On Fri, 4 Jul 2025 17:05:37 +0100
> Simon Horman <horms@kernel.org> wrote:
>
>> + David Laight
>>
>> On Wed, Jul 02, 2025 at 09:09:00PM +0800, Jijie Shao wrote:
>>> From: Hao Lan <lanhao@huawei.com>
>>>
>>> Currently, the queried maximum of vf channels is the maximum of channels
>>> supported by each TC. However, the actual maximum of channels is
>>> the maximum of channels supported by the device.
>>>
>>> Fixes: 849e46077689 ("net: hns3: add ethtool_ops.get_channels support for VF")
>>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>>> Signed-off-by: Hao Lan <lanhao@huawei.com>
>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>>> ---
>>>   drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 6 +-----
>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> index 33136a1e02cf..626f5419fd7d 100644
>>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
>>> @@ -3094,11 +3094,7 @@ static void hclgevf_uninit_ae_dev(struct hnae3_ae_dev *ae_dev)
>>>   
>>>   static u32 hclgevf_get_max_channels(struct hclgevf_dev *hdev)
>>>   {
>>> -	struct hnae3_handle *nic = &hdev->nic;
>>> -	struct hnae3_knic_private_info *kinfo = &nic->kinfo;
>>> -
>>> -	return min_t(u32, hdev->rss_size_max,
>>> -		     hdev->num_tqps / kinfo->tc_info.num_tc);
>>> +	return min_t(u32, hdev->rss_size_max, hdev->num_tqps);
>> min_t() wasn't needed before and it certainly doesn't seem to be needed
>> now, as both .rss_size_max, and .num_tqps are u16.
> It (well something) would have been needed before the min_t() changes.
> The u16 values get promoted to 'signed int' prior to the division.
>
>> As a follow-up, once this change hits net-next, please update to use min()
>> instead. Likely elsewhere too.
> Especially any min_t(u16, ...) or u8 ones.
> They are just so wrong and have caused bugs.
>
> 	David


Does this mean that min_t() will be deprecated?
If so, I will replace all instances of min_t() with min() in the hns3 driver.

Thanks
Jijie Shao





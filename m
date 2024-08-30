Return-Path: <netdev+bounces-123683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5641F96619E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D611C2206A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFFB17DFF3;
	Fri, 30 Aug 2024 12:27:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109FF192D79
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020865; cv=none; b=X3KlgbMl/M3RKc7ANJ5bXcQPVEJtkrtrXp1IUDVElD+A5hetu6kQ0GuIGpTEBAWPQVUicTiJmcm/hj4LD9/m1oERqjGYoIdJWsxK9QNWtMdgPIUkfk+GeH764/CWf8vDObDxlUVtVMQD+lQxp+qoZM+Rvf22++iiGAbcsojttmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020865; c=relaxed/simple;
	bh=RBHd8Fg9TNBcv782mw1hOgdfbgyt1+Kwv5wIbeq8CIY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F6lH2cG1g5QveOB+jokgCsGBL7iPKIukDQQiveCxpEhHNtLjZUBkymjbDzTgZyPnRipk1+IeUDSy193U84jv0nekxQD29y+n086RejHTNg3DN+7NKn1o6mDmsec+ddFqVayvmAvI7CXctTowOXPyYSKtVUYuWrOxk5NnxrBVtrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwHQB3mhhz1HHdx
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 20:24:18 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D8661A016C
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 20:27:40 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 20:27:40 +0800
Message-ID: <00c291f9-4d41-464a-a583-a24aeabfef85@huawei.com>
Date: Fri, 30 Aug 2024 20:27:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 06/11] net: hibmcge: Implement .ndo_start_xmit
 function
To: Andrew Lunn <andrew@lunn.ch>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-7-shaojijie@huawei.com>
 <20240828184120.07102a2f@kernel.org>
 <df861206-0a7a-4744-98f6-6335303d29ef@huawei.com>
 <83dce3bb-28c6-4021-a343-cff2410a463f@lunn.ch>
 <f64c04a6-8c3d-46f5-a2dd-a9864de12169@huawei.com>
 <7822930d-1331-4631-9d7e-bd37a40f44bd@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7822930d-1331-4631-9d7e-bd37a40f44bd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 21:16, Andrew Lunn wrote:
> On Thu, Aug 29, 2024 at 08:55:35PM +0800, Jijie Shao wrote:
>> on 2024/8/29 11:02, Andrew Lunn wrote:
>>> On Thu, Aug 29, 2024 at 10:32:33AM +0800, Jijie Shao wrote:
>>>> on 2024/8/29 9:41, Jakub Kicinski wrote:
>>>>> On Tue, 27 Aug 2024 21:14:50 +0800 Jijie Shao wrote:
>>>>>> @@ -111,6 +135,14 @@ static int hbg_init(struct hbg_priv *priv)
>>>>>>     	if (ret)
>>>>>>     		return ret;
>>>>>> +	ret = hbg_txrx_init(priv);
>>>>>> +	if (ret)
>>>>>> +		return ret;
>>>>> You allocate buffers on the probe path?
>>>>> The queues and all the memory will be sitting allocated but unused if
>>>>> admin does ip link set dev $eth0 down?
>>>> The network port has only one queue and
>>>> the TX queue depth is 64, RX queue depth is 127.
>>>> so it doesn't take up much memory.
>>>>
>>>> Also, I plan to add the self_test feature in a future patch.
>>>> If I don't allocate buffers on the probe path,
>>>> I won't be able to do a loopback test if the network port goes down unexpectedly.
>>> When you come to implement ethtool --set-ring, you will need to
>>> allocate and free the ring buffers outside of probe.
>>>
>>> 	Andrew
>> We discussed this internally, and now we have a problem that we can't solve:
>>
>> After allocate ring buffers, the driver will writes the address to the hardware FIFO
>> for receiving packets.
>>
>> However, FIFO does not have a separate interface to clear ring buffers address.
>>
>> If ring buffers can be allocated and released on other paths,
>> the driver buffer address is inconsistent with the hardware buffer address.
>> As a result, packet receiving is abnormal. The fault is rectified only
>> after the buffers of a queue depth are used up and new buffers are allocated for.
> If the hardware is designed correctly, there should be away to tell
> the hardware to stop receiving packets. Often there is then a way to
> know it has actually stopped, and all in flight DMA transfers are
> complete. Otherwise, you can make a guess at how long the worse case
> DMA transfer takes, maybe a jumbo packet at 10Mbps, and simply sleep
> that long. It is then safe to allocate new ring buffers, swap the
> pointer, and then free the old.
>
> You probably even have this code already in u-boot. You cannot jump
> into the kernel without first ensuring the device has stopped DMAing
> packets.
>
>> Actually, the buffer will be released during FLR reset and are allocated again after reset.
>> In this case, the FIFO are cleared. Therefore, driver writes the ring buffer address
>> to the hardware again to ensure that the driver address is the same as the hardware address.
>>
>> If we do an FLR every time we allocate ring buffers on other path, It is expensive.
> It does not matter if it is expensive. This is not hot path. ethtool
> --set-ring is only going to be called once, maybe twice before the
> machine is shut down. So we generally don't care about the cost.
>
> 	Andrew

I have removed the alloc ring buffer from the probe path in v6.
After the test, the network port can work normally after being repeatedly down and up.

	Thanks，
	Jijie Shao



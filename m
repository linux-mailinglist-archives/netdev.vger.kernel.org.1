Return-Path: <netdev+bounces-114954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFE2944CD8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08B12898CC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154C1A0719;
	Thu,  1 Aug 2024 13:09:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887541946C7;
	Thu,  1 Aug 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517740; cv=none; b=TAHrNpUS5UwB0pZlnxzAGBLR68uA1rkWkYKbPsgXxcxMcmHdmae8OdTUCIumCS2koQi8URackYqGzPeavxm2N5bF+s6ZdM616iCzKPU5VUOJPtvITro8j9nZHwkXkUpxjn/BF7Fbn9J+0okgkpxVv6d0AVfpDzl/f1DcEh3owIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517740; c=relaxed/simple;
	bh=um34ECxnIZ9riGOj26DqiFuzPJczktCd+BdMvHVDKNg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lF1UnbV7J+vGkdfaFVZ0qTjutOnI9EkBAeLrnUjZe6UfubU0OTxJLi4D/3qtoWu2fpserOJG6Fn22uZfNl73xTVLGoJzKVpeB5gjR0UHleZrhZamsFsqZKImimRL9VDLdbG5FeDFlLcjyHixXnJ7/9MK3HS+fmGQNd/VTKtMu6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZTgH6n2QzyPFW;
	Thu,  1 Aug 2024 21:03:55 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B378180101;
	Thu,  1 Aug 2024 21:08:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 21:08:54 +0800
Message-ID: <ec6dce47-0e6f-46b3-85ab-075851385f75@huawei.com>
Date: Thu, 1 Aug 2024 21:08:54 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 05/10] net: hibmcge: Implement some .ndo
 functions
To: Andrew Lunn <andrew@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-6-shaojijie@huawei.com>
 <0e497b6f-7ab0-4a43-afc6-c5ad205aa624@lunn.ch>
 <e8a56b1f-f3f3-4081-8c0d-4b829e659780@huawei.com>
 <ffd2d708-60fb-4049-8c1b-fcfe43a78d57@lunn.ch>
 <d5e9f50a-c3bd-4071-9de8-cc22cd0f5cfc@huawei.com>
 <e57e3748-6ee5-42d5-8715-ec652fc6310f@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <e57e3748-6ee5-42d5-8715-ec652fc6310f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/1 20:36, Andrew Lunn wrote:
> On Thu, Aug 01, 2024 at 08:33:38PM +0800, Jijie Shao wrote:
>> on 2024/8/1 20:18, Andrew Lunn wrote:
>>> On Thu, Aug 01, 2024 at 05:13:33PM +0800, Jijie Shao wrote:
>>>> on 2024/8/1 8:51, Andrew Lunn wrote:
>>>>>> +static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
>>>>>> +{
>>>>>> +	struct hbg_priv *priv = netdev_priv(dev);
>>>>>> +	u8 *mac_addr;
>>>>>> +
>>>>>> +	mac_addr = ((struct sockaddr *)addr)->sa_data;
>>>>>> +	if (ether_addr_equal(dev->dev_addr, mac_addr))
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	if (!is_valid_ether_addr(mac_addr))
>>>>>> +		return -EADDRNOTAVAIL;
>>>>> How does the core pass you an invalid MAC address?
>>>> According to my test,
>>>> in the 6.4 rc4 kernel version, invalid mac address is allowed to be configured.
>>>> An error is reported only when ifconfig ethx up.
>>> Ah, interesting.
>>>
>>> I see a test in __dev_open(), which is what you are saying here. But i
>>> would also expect a test in rtnetlink, or maybe dev_set_mac_address().
>>> We don't want every driver having to repeat this test in their
>>> .ndo_set_mac_address, when it could be done once in the core.
>>>
>>> 	Andrew
>> Hi:
>> I did the following test on my device:
>>
>> insmod hibmcge.ko
>> hibmcge: no symbol version for module_layout
>> hibmcge: loading out-of-tree module taints kernel.
>> hibmcge: module verification failed: signature and/or required key missing - tainting kernel
>> hibmcge 0000:83:00.1: enabling device (0140 -> 0142)
>> Generic PHY mii-0000:83:00.1:02: attached PHY driver (mii_bus:phy_addr=mii-0000:83:00.1:02, irq=POLL)
>> hibmcge 0000:83:00.1 enp131s0f1: renamed from eth0
>> IPv6: ADDRCONF(NETDEV_CHANGE): enp131s0f1: link becomes ready
>> hibmcge 0000:83:00.1: link up!
>>
>> ifconfig enp131s0f1 hw ether FF:FF:FF:FF:FF:FF
>>
>> ip a
>> 6: enp131s0f1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
>>      link/ether ff:ff:ff:ff:ff:ff brd ff:ff:ff:ff:ff:ff permaddr 08:02:00:00:08:08
>> ifconfig enp131s0f1 up
>> ifconfig enp131s0f1 down up
>> SIOCSIFFLAGS: Cannot assign requested address
>> hibmcge 0000:83:00.1: link down!
>>
>> uname -a
>> Linux localhost.localdomain 6.4.0+ #1 SMP Fri Mar 15 14:44:20 CST 2024 aarch64 aarch64 aarch64 GNU/Linux
>>
>>
>>
>> So I'm not sure what's wrong. I also implemented ndo_validate_addr by eth_validate_addr.
> I agree. I don't see a test. Please could you include a patch to
> dev_set_mac_address() to validate the address there before calling
> into the driver. It might also be worth a search to see if anybody
> else has tried this before, and failed. There might be a good reason
> you cannot validate it.
>
> 	Andrew

sure, I will include that in V2

Thanks，

Jijie Shao



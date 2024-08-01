Return-Path: <netdev+bounces-114870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D462A9447F8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B97DB26CBC
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8C1A2564;
	Thu,  1 Aug 2024 09:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3001A0B12;
	Thu,  1 Aug 2024 09:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503619; cv=none; b=FgyYqb7jT3fQF0GQ6lMfANzO75qvCdzR2jhLUiZzN+HFmAtpPksnPfwFJRTdpWlnP1MYRDUpPx2yf7ZReiJZDSdQR6tsX/2bc78j93T0O3S0GM/tQ7njTX2Jv1onbyhIvJcifTQIMJcJoYZNiYCYzTGSyJXMhqfDjb70Eo/6mLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503619; c=relaxed/simple;
	bh=tPidg2/aE3kkju9l04+4SSW5PlwDWDWtQnh4jZnd8Zc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rSQZ/qrFgt/G7zpPQ1ZXem6Gnk5WgBJMHQOA848IjyoK8U5IURH2EIc3/FP/PVxp2k9lG/Hvh2iyncyAf8/IOsXz8VSLSD5Gem5F70x3TXRzHlRKcklSrNao11+3OmsVZDk3xFVkymQgQBZ9QoRwAIE7YOdHeuoArVxr4HbJEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZNRl15wNzyPSb;
	Thu,  1 Aug 2024 17:08:35 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 8216D140336;
	Thu,  1 Aug 2024 17:13:34 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 17:13:33 +0800
Message-ID: <e8a56b1f-f3f3-4081-8c0d-4b829e659780@huawei.com>
Date: Thu, 1 Aug 2024 17:13:33 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <0e497b6f-7ab0-4a43-afc6-c5ad205aa624@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/1 8:51, Andrew Lunn wrote:
>> +static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(dev);
>> +	u8 *mac_addr;
>> +
>> +	mac_addr = ((struct sockaddr *)addr)->sa_data;
>> +	if (ether_addr_equal(dev->dev_addr, mac_addr))
>> +		return 0;
>> +
>> +	if (!is_valid_ether_addr(mac_addr))
>> +		return -EADDRNOTAVAIL;
> How does the core pass you an invalid MAC address?

According to my test,
in the 6.4 rc4 kernel version, invalid mac address is allowed to be configured.
An error is reported only when ifconfig ethx up.

>
>> +static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(dev);
>> +	bool is_opened = hbg_nic_is_open(priv);
>> +	u32 frame_len;
>> +
>> +	if (new_mtu == dev->mtu)
>> +		return 0;
>> +
>> +	if (new_mtu < priv->dev_specs.min_mtu || new_mtu > priv->dev_specs.max_mtu)
>> +		return -EINVAL;
> You just need to set dev->min_mtu and dev->max_mtu, and the core will
> do this validation for you.

Thanks, I'll test it，and if it works I'll remove the judgement

>
>> +	dev_info(&priv->pdev->dev,
>> +		 "change mtu from %u to %u\n", dev->mtu, new_mtu);
> dev_dbg() Don't spam the log for normal operations.

okay, Thanks!



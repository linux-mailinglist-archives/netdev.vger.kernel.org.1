Return-Path: <netdev+bounces-123043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFD963847
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 04:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D43285024
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 02:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4518030;
	Thu, 29 Aug 2024 02:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6F481B1;
	Thu, 29 Aug 2024 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724899215; cv=none; b=W+4TqbEmmjEqmlGDewW5+e7gNR2gVuW4sRB2P6u/DaKkcsg3ZqTk9RoPjMWoQw788oy4bvV1zhuzTj9o8RCqZB24YS7ZPcUjBXA2fCdif8J+Csh+0KQWzx9Jb1jy6ISsza1EkAKPHeJ7exR23OTrt5t+k7Me0WNbKV7BWY/5kuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724899215; c=relaxed/simple;
	bh=D4ZvmeeU1FOPRboWQswrh5spc8/PYtigkM6ItBUeReg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qGhmYxrbmqgNsz/tuLkikCqMPhHE4DvQ2+u5FroCx23X21cJA3BeP5sPA7Du1wY6ED0XLP65IKxpcqeJUgwcAbgInDsP7lar7NfoTUeB0s6vXxKo4DrOCEvjYPwYjfZagTjGI66EcCO7nyIMxvzkDBaEDtm0bTPMd/dPut86YOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvQQn0fh4z1HHlc;
	Thu, 29 Aug 2024 10:36:49 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 902451A0188;
	Thu, 29 Aug 2024 10:40:09 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 10:40:08 +0800
Message-ID: <b3d6030e-14a3-4d5f-815c-2f105f49ea6a@huawei.com>
Date: Thu, 29 Aug 2024 10:40:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
To: Jakub Kicinski <kuba@kernel.org>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-6-shaojijie@huawei.com>
 <20240828183954.39ea827f@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240828183954.39ea827f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 9:39, Jakub Kicinski wrote:
> On Tue, 27 Aug 2024 21:14:49 +0800 Jijie Shao wrote:
>> +static int hbg_net_open(struct net_device *dev)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(dev);
>> +
>> +	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
>> +		return 0;
>> +
>> +	netif_carrier_off(dev);
> Why clear the carrier during open? You should probably clear it once on
> the probe path and then on stop.

In net_open(), the GMAC is not ready to receive or transmit packets.
Therefore, netif_carrier_off() is called.

Packets can be received or transmitted only after the PHY is linked.
Therefore, netif_carrier_on() should be called in adjust_link.

In net_stop() we also call netif_carrier_off()
	
	Thanks,
	Jijie Shao



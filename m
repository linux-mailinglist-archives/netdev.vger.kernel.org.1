Return-Path: <netdev+bounces-123571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAD96553B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AEF2849A5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701608121B;
	Fri, 30 Aug 2024 02:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C185624B28;
	Fri, 30 Aug 2024 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724984876; cv=none; b=AZtgbPxji1NdvzxLD8NvuTA5R6a3CSncxBJ76WO/PWOUSTTPmZ+HerumoNOPCtZELqNcI3dbALHJnM8YLTEU4Vgpr/wSRTXRRTnG0SLSyExiCB1lYkuXf1+Ko4i4kk+jmY7xf21ksL4MWT2HEsNSTn4pv/8q4k8wnGy9WaIlzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724984876; c=relaxed/simple;
	bh=IjdWAzZxwQl6T8pGIq251x+A4h99Wun0feQd6DlJtDY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NQleHUd9RFyRiZd5vI7p8k5dOFZKQSbdLFWSm9FK3JrPIZRZ/Ei4+EEJubg+sZCjxjqeqEko1MkUkC6xC3aRhBSQwQykpYMfPM2BhMHGV2VwY2HnUFOy2YS6XhM15xxtjA+ujUNM7HUS2Ckjx4ylQTVpI2JZkWHqfd3RWRO7y1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ww2911MZNzyQZY;
	Fri, 30 Aug 2024 10:27:01 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id CA9D318007C;
	Fri, 30 Aug 2024 10:27:51 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 10:27:50 +0800
Message-ID: <853edbd1-1fca-4830-9969-e071860de2be@huawei.com>
Date: Fri, 30 Aug 2024 10:27:49 +0800
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
	<jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>
References: <20240827131455.2919051-1-shaojijie@huawei.com>
 <20240827131455.2919051-6-shaojijie@huawei.com>
 <20240828183954.39ea827f@kernel.org>
 <b3d6030e-14a3-4d5f-815c-2f105f49ea6a@huawei.com>
 <20240829074339.426e298b@kernel.org>
 <f8978a4a-aa9d-4f36-ab40-5068f859bfec@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <f8978a4a-aa9d-4f36-ab40-5068f859bfec@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/29 22:59, Andrew Lunn wrote:
> On Thu, Aug 29, 2024 at 07:43:39AM -0700, Jakub Kicinski wrote:
>> On Thu, 29 Aug 2024 10:40:07 +0800 Jijie Shao wrote:
>>> on 2024/8/29 9:39, Jakub Kicinski wrote:
>>>> On Tue, 27 Aug 2024 21:14:49 +0800 Jijie Shao wrote:
>>>>> +static int hbg_net_open(struct net_device *dev)
>>>>> +{
>>>>> +	struct hbg_priv *priv = netdev_priv(dev);
>>>>> +
>>>>> +	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
>>>>> +		return 0;
>>>>> +
>>>>> +	netif_carrier_off(dev);
>>>> Why clear the carrier during open? You should probably clear it once on
>>>> the probe path and then on stop.
>>> In net_open(), the GMAC is not ready to receive or transmit packets.
>>> Therefore, netif_carrier_off() is called.
>>>
>>> Packets can be received or transmitted only after the PHY is linked.
>>> Therefore, netif_carrier_on() should be called in adjust_link.
>> But why are you calling _off() during .ndo_open() ?
>> Surely the link is also off before ndo_open is called?
> I wounder what driver they copied?
>
> The general trend is .probe() calls netif_carrier_off(). After than,
> phylib/phylink is in control of the carrier and the MAC driver does
> not touch it. in fact, when using phylink, if you try to change the
> carrier, you will get SHOUTED at from Russell.
>
> 	Andrew

Read the PHY driver code:
netif_carrier_on() or netif_carrier_off()
has been called in phy_link_change() based on the link status.
Therefore, the driver does not need to process it.

static void phy_link_change(struct phy_device *phydev, bool up)
{
	struct net_device *netdev = phydev->attached_dev;

	if (up)
		netif_carrier_on(netdev);
	else
		netif_carrier_off(netdev);
	phydev->adjust_link(netdev);
	if (phydev->mii_ts && phydev->mii_ts->link_state)
		phydev->mii_ts->link_state(phydev->mii_ts, phydev);
}

Thank you. I'll delete it in v6.
	Jijie Shao



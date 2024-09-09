Return-Path: <netdev+bounces-126347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C858970C9C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 06:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2188A1F22478
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BF02AF06;
	Mon,  9 Sep 2024 04:05:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918911ACDE1;
	Mon,  9 Sep 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725854703; cv=none; b=LNMxPfc1AI/+N7AUdIuv3auJMfKyh+YMbc8h/mmOG3MTKpB0D4gueO+EZSLUT/xYvHuETqcE25KoH3y+3QZqr7Y1/HRZsee8+6Hn5CWqRECp0x6Lpg9CpPB4SWydoQFSakWm08ga6DOqPC+9GqULQ2533+XzIx3W0G/q3VdbGd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725854703; c=relaxed/simple;
	bh=ZVq/OWN7zngj/WMXjZcJmHI6PiiYu7UlHGamy3OMBuo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jq3FRmTX3djYznLE3c302YngJP4+zV1nmvMq/nLYjH1hSnjPcFW0VdMduAJzsD+MNj7Heak2NAUZ+BhNGrrNjkxAveKHynr30DU3fJuBfq3NIcwotYe+l6JYPut4wOi2bUA9PiI7TC8Hixti/BBEXZpEMEVAznuMSnQPYteqV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X2Crs4vS2z1j8Kf;
	Mon,  9 Sep 2024 12:04:29 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id DDEC41A0188;
	Mon,  9 Sep 2024 12:04:55 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 12:04:54 +0800
Message-ID: <116bff77-f12f-43f0-8325-b513a6779a55@huawei.com>
Date: Mon, 9 Sep 2024 12:04:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <zhuyuan@huawei.com>, <forest.zhouchang@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 net-next 05/11] net: hibmcge: Implement some .ndo
 functions
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
References: <20240909023141.3234567-1-shaojijie@huawei.com>
 <20240909023141.3234567-6-shaojijie@huawei.com>
 <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAH-L+nOxj1_wHdSacC5R9WG5GeMswEQDXa4xgVFxyLHM7xjycg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/9/9 11:05, Kalesh Anakkur Purayil wrote:
> On Mon, Sep 9, 2024 at 8:11 AM Jijie Shao <shaojijie@huawei.com> wrote:
>> +}
>> +
>> +static int hbg_net_open(struct net_device *netdev)
>> +{
>> +       struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +       if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
>> +               return 0;
> [Kalesh] Is there a possibility that dev_open() can be invoked twice?

We want stop NIC when chang_mtu 、self_test or FLR.
So, driver will directly invoke hbg_net_stop() not dev_open() if need.
Therefore, driver must ensure that hbg_net_open() or hbg_net_stop() can not be invoked twice.

>> +
>> +       hbg_all_irq_enable(priv, true);
>> +       hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
>> +       netif_start_queue(netdev);
>> +       hbg_phy_start(priv);
>> +
>> +       return 0;
>> +}
>> +
>> +static int hbg_net_stop(struct net_device *netdev)
>> +{
>> +       struct hbg_priv *priv = netdev_priv(netdev);
>> +
>> +       if (!hbg_nic_is_open(priv))
>> +               return 0;
> [Kalesh] Is there any reason to not check HBG_NIC_STATE_OPEN here?

Actually, hbg_nic_is_open() is used to check HBG_NIC_STATE_OPEN.
:
#define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->state)

>> +
>> +       clear_bit(HBG_NIC_STATE_OPEN, &priv->state);
>> +
>> +       hbg_phy_stop(priv);
>> +       netif_stop_queue(netdev);
>> +       hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
>> +       hbg_all_irq_enable(priv, false);
>> +
>> +       return 0;
>> +}
>> +
>> +static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
>> +{
>> +       struct hbg_priv *priv = netdev_priv(netdev);
>> +       bool is_opened = hbg_nic_is_open(priv);
>> +
>> +       hbg_net_stop(netdev);
> [Kalesh] Do you still need to call stop when NIC is not opened yet?
> Instead of a new variable, I think you can check netif_running here.

hbg_net_stop() will check HBG_NIC_STATE_OPEN by hbg_nic_is_open(),
So, if  NIC is not opened, hbg_net_stop() will do nothing

Thanks!
	Jijie Shao



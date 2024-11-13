Return-Path: <netdev+bounces-144296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F89C67BF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 04:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65041F25F79
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032AA16C695;
	Wed, 13 Nov 2024 03:20:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF9A165F08;
	Wed, 13 Nov 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731468009; cv=none; b=lSX4GbTXMff7HlzWLDxugvPqe852v7kF0TbbEN1de20eYL9m7CL6zxtxJmYuivUgb3KGgMALto4DWTZJf5YChNhhJnUFCkc6LRjRtktpRc49KRsCe8llFRuQP1ysOb0fFnhJe4R04tTBBicITtVuLxTUQWRUD4u0dVKikEPjcHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731468009; c=relaxed/simple;
	bh=L91+IDuQiJPtW7BBMUNadu7eH7UMMLEm1kX1qbeYT3o=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kNrcmgZJLqutSrQxLEiNeU4EzgjkbmvHNe+srePHfKYVP8vg0WtZ2wOKpoz1+hAyBu9fkSENdog0uetZGzcAIqPCHanLPxGuDzO3/2SvnA8aVd71kgzOTownVhl78pYHKQxhCIBKQAKytcDCqUGF0UNOeB1A8vyjVS3BxV0d86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Xp7lW1hd4z1jy7S;
	Wed, 13 Nov 2024 11:18:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A3E2D1401F2;
	Wed, 13 Nov 2024 11:20:04 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 11:20:03 +0800
Message-ID: <2d8e467d-b8e0-4728-ac2c-fba70a53bd9f@huawei.com>
Date: Wed, 13 Nov 2024 11:20:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 5/7] net: hibmcge: Add pauseparam supported in
 this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
 <20241111145558.1965325-6-shaojijie@huawei.com>
 <efd481a8-d020-452b-b29b-dfa373017f1f@lunn.ch>
 <98187fe7-23f1-4c52-a62f-c96e720cb491@huawei.com>
 <d22285c6-8286-4db0-86ca-90fff08e3a42@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <d22285c6-8286-4db0-86ca-90fff08e3a42@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/13 0:32, Andrew Lunn wrote:
> On Tue, Nov 12, 2024 at 10:37:27PM +0800, Jijie Shao wrote:
>> on 2024/11/12 1:58, Andrew Lunn wrote:
>>> On Mon, Nov 11, 2024 at 10:55:56PM +0800, Jijie Shao wrote:
>>>> The MAC can automatically send or respond to pause frames.
>>>> This patch supports the function of enabling pause frames
>>>> by using ethtool.
>>>>
>>>> Pause auto-negotiation is not supported currently.
>>> What is actually missing to support auto-neg pause? You are using
>>> phylib, so it will do most of the work. You just need your adjust_link
>>> callback to configure the hardware to the result of the negotiation.
>>> And call phy_support_asym_pause() to let phylib know what the MAC
>>> supports.
>>>
>>> 	Andrew
>> Thanks for your guidance,
>>
>> I haven't really figured out the difference between phy_support_sym_pause()
>> and phy_support_asym_paus().
> sym_pause means that when the MAC pauses, it does it in both
> directions, receive and transmit. Asymmetric pause means it can pause
> just receive, or just transmit.
>
> Since you have both tx_pause and rx_pause, you can do both.
>
>> +static void hbg_ethtool_get_pauseparam(struct net_device *net_dev,
>> +				       struct ethtool_pauseparam *param)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(net_dev);
>> +
>> +	param->autoneg = priv->mac.pause_autoneg;
>> +	hbg_hw_get_pause_enable(priv, &param->tx_pause, &param->rx_pause);
>> +}
>> +
>> +static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
>> +				      struct ethtool_pauseparam *param)
>> +{
>> +	struct hbg_priv *priv = netdev_priv(net_dev);
>> +	struct phy_device *phydev = priv->mac.phydev;
>> +
>> +	phy_set_asym_pause(phydev, param->rx_pause, param->tx_pause);
> Not needed. This just tells phylib what the MAC is capable of. The
> capabilities does not change, so telling it once in hbg_phy_connect()
> is sufficient.
>
> 	Andrew


Maybe there is an error in this code.
If I want to disable auto-neg pause, do I need to set phy_set_asym_pause(phydev, 0, 0)?

Thanks
Jijie Shao




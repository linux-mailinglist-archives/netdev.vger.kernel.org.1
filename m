Return-Path: <netdev+bounces-212918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367BDB2283C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CC61BC0738
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18DF26B2C8;
	Tue, 12 Aug 2025 13:13:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F925F796;
	Tue, 12 Aug 2025 13:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004421; cv=none; b=lXhVPC1dlReGS/dsFLT+08enPcz/0b1i9g5t0ovhPED1S+IKabaB71H3p/IqvokoANN00mnivSASGwDD9SQ3/4Fe/yvK1k0FIMBsqqzpY+YkBT39tGRU826AnJc7P1mUnEvPv303Og+CGLK4qkwwZkRrftQCuY6u13r2SjRxqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004421; c=relaxed/simple;
	bh=rELXGmjflE8L3p+Badd/4TCPAi/HVFvdh3j8iNXmqyw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c7i++W7fyj2WuNc2Z2xjnubdwVuYnVebAqgAGgkUhbl2B+DMy0VEunDSzCWIlCF2Jg0gRuZ7O6gGewTCvt54iC1bh4iy56oHbsgWJYQdJnzapNKgiJivMO4iGywGLQ2CcaOwzEJWrQk2vkXMKbRjXs973fI58yGT62J6n72Ouj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c1X1n5s7hz23jg6;
	Tue, 12 Aug 2025 21:10:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B2DC1800B2;
	Tue, 12 Aug 2025 21:13:32 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Aug 2025 21:13:31 +0800
Message-ID: <c0fa9fe2-7a98-4682-9ecf-aab36ec8e9ed@huawei.com>
Date: Tue, 12 Aug 2025 21:13:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <shenjian15@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: motorcomm: Add support for PHY
 LEDs on YT8521
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-2-shaojijie@huawei.com> <7978337.lvqk35OSZv@diego>
 <aJoFvcICOXhuZ8-q@shell.armlinux.org.uk>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aJoFvcICOXhuZ8-q@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/8/11 23:01, Russell King (Oracle) wrote:
> On Thu, Aug 07, 2025 at 11:50:06AM +0200, Heiko Stübner wrote:
>>> +static int yt8521_led_hw_control_get(struct phy_device *phydev, u8 index,
>>> +				     unsigned long *rules)
>>> +{
>>> +	int val;
>>> +
>>> +	if (index >= YT8521_MAX_LEDS)
>>> +		return -EINVAL;
>>> +
>>> +	val = ytphy_read_ext(phydev, YT8521_LED0_CFG_REG + index);
>>> +	if (val < 0)
>>> +		return val;
>>> +
>>> +	if (val & YT8521_LED_TXACT_BLK_EN)
>>> +		set_bit(TRIGGER_NETDEV_TX, rules);
>>> +
>>> +	if (val & YT8521_LED_RXACT_BLK_EN)
>>> +		set_bit(TRIGGER_NETDEV_RX, rules);
>>> +
>>> +	if (val & YT8521_LED_FDX_ON_EN)
>>> +		set_bit(TRIGGER_NETDEV_FULL_DUPLEX, rules);
>>> +
>>> +	if (val & YT8521_LED_HDX_ON_EN)
>>> +		set_bit(TRIGGER_NETDEV_HALF_DUPLEX, rules);
>>> +
>>> +	if (val & YT8521_LED_GT_ON_EN)
>>> +		set_bit(TRIGGER_NETDEV_LINK_1000, rules);
>>> +
>>> +	if (val & YT8521_LED_HT_ON_EN)
>>> +		set_bit(TRIGGER_NETDEV_LINK_100, rules);
>>> +
>>> +	if (val & YT8521_LED_BT_ON_EN)
>>> +		set_bit(TRIGGER_NETDEV_LINK_10, rules);
> Sorry, I don't have the original to hand.
>
> Please use __set_bit() where the more expensive atomic operation that
> set_bit() gives is not necessary.

Okay, got it.



Return-Path: <netdev+bounces-245141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA43CC7F75
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F24E307644B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F168334D38A;
	Wed, 17 Dec 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="25p97wh6"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F233F383;
	Wed, 17 Dec 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976275; cv=none; b=Dt/x49s8VHO32EI8TGUWB42WlKzHdrrTuv289XkCGoF5KHpO0YDZA4/Rdqcgt0oVlKjkbOn1rbjN5jze94JKWVPk89B6RdzPlyMABVjrCEacTwDztGQzATjc9lH6UTKC16uI3GJH0IPo3uoeuXZ3KBNrG3hOuplXi8Nj+Q4fd2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976275; c=relaxed/simple;
	bh=R2WQXy0HlYWZT5WgbTNL4ElDqundmQ18DzVyCX6CaOg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NFTgacGCyGqVkdmyK6Zi7tW+8joykctD075Mtj58V0qUrY8fF0jl2YVyjed8TC/wtbTkbbfRXfLL9LtZrsDkuQzlAanVXFheLlkMyYYhX8yKbnMIHFW1mQ492RxaSweYP5zsiSvaDKLj4378Qw7h1IvcJovcskXffCkkzr4FEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=25p97wh6; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9uTeC33HWrE/FGLHxrN1UCj58rBsGBt6Q2oc2HoVVsQ=;
	b=25p97wh6wmwPnSh7UT5D8bRRCyerWnHFCXK3QDY3St2YmxpTmyB/XYjS6JBfGop2BXKbN9mJn
	/kbvKBc35R8fEEerSFqDrby9oq3R259Gslb8wWh5BpLHijfySUOC/i40U61GL4nHOdnUuYXTMNY
	1WiVtaPM13U9fcABZWe+HbI=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dWYfc69SGz1K968;
	Wed, 17 Dec 2025 20:54:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D6931800B2;
	Wed, 17 Dec 2025 20:57:49 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 20:57:48 +0800
Message-ID: <41fb1824-7576-46c4-ba1b-ab7f9680c562@huawei.com>
Date: Wed, 17 Dec 2025 20:57:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 3/6] net: hibmcge: create a software node for
 phy_led
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-4-shaojijie@huawei.com>
 <543efb90-da56-4190-afa7-665d32303c8c@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <543efb90-da56-4190-afa7-665d32303c8c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/16 15:17, Andrew Lunn wrote:
> On Mon, Dec 15, 2025 at 08:57:02PM +0800, Jijie Shao wrote:
>> +int hbg_mdio_init(struct hbg_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct hbg_mac *mac = &priv->mac;
>>   	struct mii_bus *mdio_bus;
>>   	int ret;
>>   
>> @@ -281,7 +389,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
>>   
>>   	mdio_bus->parent = dev;
>>   	mdio_bus->priv = priv;
>> -	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
>> +	mdio_bus->phy_mask = 0xFFFFFFFF; /* not scan phy device */
>>   	mdio_bus->name = "hibmcge mii bus";
>>   	mac->mdio_bus = mdio_bus;
> I think you are taking the wrong approach.
>
> Please consider trying to use of_mdiobus_register(). Either load a DT
> overlay, or see if you can construct a tree of properties as you have
> been doing, and pass it to of_mdiobus_register(). You then don't need
> to destroy and create PHY devices.
>
> 	Andrew


Ok， I will try like this

Thanks
Jijie Shao



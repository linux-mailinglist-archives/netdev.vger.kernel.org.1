Return-Path: <netdev+bounces-247977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E0CD01545
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 08:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73708303C808
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 06:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13728304BA3;
	Thu,  8 Jan 2026 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jwOnT7nh"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C034A29B8E5;
	Thu,  8 Jan 2026 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855430; cv=none; b=uMSS0hhLP8RfBlu72BbXSvqZIeTLCg6I9DOvs1Vt3n8slOCuk7t95H1yYxa7BK0zOzJQ4A0uUWcKCyIQN+jWzbQ77+CMUj16mLK2uRQxKHuK726UGgtWJa5gwS76GWDW0zgtSR9KJT5ilY1Mu1SYDF9cwluPus5uHpakwHp6YBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855430; c=relaxed/simple;
	bh=0/53AYXPU/ljQ2VErhTnsqWIBK4GBo+ChbMdbPQqWPo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Eq6clo+farogrMWaCU3mYsEpBlrASGh5BIC/uTQSbLxG7xcBNEWE1j6essh2ARkBl0ayev0FhX4D7T/vjSkZEu1ldGhT7mdKQZYL6S3KFdV+q4I483SvHfRwQMDZQtnDUS+8+jV2OPZXs5sRqdQMgR4UA3uFTdsGKq8FJi0BH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jwOnT7nh; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9f6QRfbVHKPNhRxfAw5V7wbXBtfNx6qkp1YiCI6M9B8=;
	b=jwOnT7nh4NGY/reHl8tyRR7BTqlnK2AixMx8407GPmsFc2CLXboqvdXkuvu9lskJB0mjcRsxf
	cfdLHVyPYlnWb1b9Hon0APjvXp8+qdK6Fh+tTK7UqhE2l9tYHY6y3sLz64b80JukE3LoYS7ctgH
	8S/nFgn3pfklInuHiHxouYI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dmwbb0MwKzcb1N;
	Thu,  8 Jan 2026 14:53:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1A440569;
	Thu,  8 Jan 2026 14:57:04 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 8 Jan 2026 14:57:03 +0800
Message-ID: <e403251c-c874-46ff-a7e2-442b18bc2c92@huawei.com>
Date: Thu, 8 Jan 2026 14:57:03 +0800
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
 <fd6f70bc-b563-4eff-97c3-1b7ad79ca093@huawei.com>
 <eaf25bd7-4211-45ca-a747-5039d69bd57c@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <eaf25bd7-4211-45ca-a747-5039d69bd57c@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/7 21:04, Andrew Lunn wrote:
> On Wed, Jan 07, 2026 at 06:09:28PM +0800, Jijie Shao wrote:
>> on 2025/12/16 15:17, Andrew Lunn wrote:
>>> On Mon, Dec 15, 2025 at 08:57:02PM +0800, Jijie Shao wrote:
>>>
>>>> +int hbg_mdio_init(struct hbg_priv *priv)
>>>> +{
>>>> +	struct device *dev = &priv->pdev->dev;
>>>> +	struct hbg_mac *mac = &priv->mac;
>>>>    	struct mii_bus *mdio_bus;
>>>>    	int ret;
>>>> @@ -281,7 +389,7 @@ int hbg_mdio_init(struct hbg_priv *priv)
>>>>    	mdio_bus->parent = dev;
>>>>    	mdio_bus->priv = priv;
>>>> -	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
>>>> +	mdio_bus->phy_mask = 0xFFFFFFFF; /* not scan phy device */
>>>>    	mdio_bus->name = "hibmcge mii bus";
>>>>    	mac->mdio_bus = mdio_bus;
>>> I think you are taking the wrong approach.
>>>
>>> Please consider trying to use of_mdiobus_register(). Either load a DT
>>> overlay, or see if you can construct a tree of properties as you have
>>> been doing, and pass it to of_mdiobus_register(). You then don't need
>>> to destroy and create PHY devices.
>> This is not easy.
>> `of_mdiobus_register()` requires a device_node, but I currently don't have one.
>> It is precisely because there is no DT or ACPI node that I am using a software node as a substitute.
> Which is why i suggested DT overlay.
>
> drivers/misc/lan966x_pci.dtso
>
> 	Andrew

Thank you for the guidance.

I did some research, and it seems that our board uses ACPI,
so it might not be possible to use this method.

If we rely on ACPI, we would need to ask the BIOS team to add ACPI entries.
I need to communicate with the customer's BIOS team, which may not be easy.

Personally, I think that using software node is more efficient when OF cannot be used.

Note: Patches with questions will continue to be discussed.
I will sent the patches that currently have no issues to net-next for acceptance.

Thanks,
Jijie Shao





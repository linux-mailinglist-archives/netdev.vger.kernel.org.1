Return-Path: <netdev+bounces-247668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C268FCFD1D9
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353BC3009744
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EB30E856;
	Wed,  7 Jan 2026 10:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="4dXLCdqK"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F7730DEB2;
	Wed,  7 Jan 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780576; cv=none; b=VUwp7v/SBnXE6W7UrLHwbUJQed3Myox0uvlUvxMzdUD8uKL+2N+P79RvCnpffDnuUQIIoPMZAbmYQC8MsqzXW88Gnv7MR69VyObzD+OfCjh+/D3jkawd/5OVn6sLwM0VRSjG9BhKHNUTF2ItghO0BuDgfjAXX/gSvaZmUUZJTmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780576; c=relaxed/simple;
	bh=PCdE03YpiIhbzlDE4xvVF7vWbug2oCOVXu63aTMze7M=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LHglOZmwf8iqco1ipgIZ0e0je+yTpK7VgaH/ZsxyPnG6u9ln1mOPF6WSbunSpEC495nxf8XVf8wQdV0tj7ziIBboSERXXx+ycIS4TFLIucXCj4yXsA7gfFagZNfCGHxKHrlZsGvTeqZ/ZloOxKb9FIXr03HGyrQBantwTs4JyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=4dXLCdqK; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nL2Oh5ovHtDnHW83D8qBPg/kXEoObrs4kmjdN7D5tws=;
	b=4dXLCdqK3PjK2bYHcAYXuQPHX1Qwkv37Q2sZsZJAqpsMtbrD455fF8nyvh1Vso9lZ7KCd7Naw
	+sPptpFJPiaDL6YqVvJJbTdA1cTP/BwJYWFlZWFNfRpIfByEDyHUH1gcimz+fJKGsOZVA89YK7E
	AIQ6I/wLx19iUGXPzkfz2FY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dmNwN6gtJz1prlQ;
	Wed,  7 Jan 2026 18:06:12 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 50AAA4036C;
	Wed,  7 Jan 2026 18:09:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 18:09:29 +0800
Message-ID: <fd6f70bc-b563-4eff-97c3-1b7ad79ca093@huawei.com>
Date: Wed, 7 Jan 2026 18:09:28 +0800
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/16 15:17, Andrew Lunn wrote:
> On Mon, Dec 15, 2025 at 08:57:02PM +0800, Jijie Shao wrote:
>
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

This is not easy.
`of_mdiobus_register()` requires a device_node, but I currently don't have one.
It is precisely because there is no DT or ACPI node that I am using a software node as a substitute.

In fact, this patch does not destroy and recreate the phydev.
It only delays the timing of phy registration:
first, register the MDIO (without scanning and registering the PHY devices),
then obtain the PHY device, register the software node, and finally register the PHY device.

Thanks,
Jijie Shao



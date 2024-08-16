Return-Path: <netdev+bounces-119088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9EA953FF7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2B01C20F03
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB16535D4;
	Fri, 16 Aug 2024 03:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F726AC3;
	Fri, 16 Aug 2024 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777676; cv=none; b=eOdf9I4AkEhguaQey9Mdswn2Bs7/Pt8vl8PVCBJsZepNmAebEfmkHivc4YodiMKKURbrRJlIr94tDn98H2Fz5yyS2zCqk5/nQ3+z7Qtg1wacyPUNZVRCy8oDKNcrpWmxtecyz8yOv3uaAPQdOjSQNO+XTwPxC7u1oPG1xwlYKrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777676; c=relaxed/simple;
	bh=42Ex2w0YjMRF4l9wkWayqm3p5gVhG1sDc7q+lu+PB0w=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2mNlw3UrcsIWi1DwECuZzyRwaasIa6usc5OJuhnjcdAGzhZSSUpVghWh6OowTZOW4B59mdrWNJKAWrLNfDcQ/Uo77mPJ2IengaPioubSTJmiEYmWXdz/fVDCocHmL7l8eckEzk0Dp/sXr1V/kUgDpAANvHTelO4qtn7ydDTNAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WlRct29X3z2CmgC;
	Fri, 16 Aug 2024 11:02:54 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 7299C14010C;
	Fri, 16 Aug 2024 11:07:48 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 11:07:45 +0800
Message-ID: <e2f0e003-b5a4-4068-b923-eda6f7accd63@huawei.com>
Date: Fri, 16 Aug 2024 11:07:45 +0800
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
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH V2 net-next 03/11] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
 <20240813135640.1694993-4-shaojijie@huawei.com>
 <23628b1a-d3ea-47ed-8289-60e455a90b72@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <23628b1a-d3ea-47ed-8289-60e455a90b72@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/16 10:14, Andrew Lunn wrote:
>> +int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
>> +{
>> +	if (speed != HBG_PORT_MODE_SGMII_10M &&
>> +	    speed != HBG_PORT_MODE_SGMII_100M &&
>> +	    speed != HBG_PORT_MODE_SGMII_1000M)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (duplex != DUPLEX_FULL && duplex != DUPLEX_HALF)
>> +		return -EOPNOTSUPP;
>
> Can this happen? We try to avoid defensive code, preferring to ensure
> it can never happen. So long as you have told phylib the limits of
> your hardware, it should enforce these.

Ok, I'll delete these.

>
>> @@ -26,11 +27,11 @@ static int hbg_init(struct hbg_priv *priv)
>>   		return dev_err_probe(dev, PTR_ERR(regmap), "failed to init regmap\n");
>>   
>>   	priv->regmap = regmap;
>> -	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
>> +	ret = hbg_hw_init(priv);
>>   	if (ret)
>>   		return ret;
>>   
>> -	return hbg_hw_dev_specs_init(priv);
>> +	return hbg_mdio_init(priv);
> I've not read the previous patches, but that looks odd. Why is code
> you just added in previous patches getting replaced?

In previous patch, we did not introduce the hbg_hw_init().
In this patch, the hbg_hw_init() is introduced,
and the hbg_hw_event_notify() and hbg_hw_dev_specs_init() functions are moved to hbg_hw_init().


hbg_hw_init() can be moved to the previous patch.

>
>> +static int hbg_phy_connect(struct hbg_priv *priv)
>> +{
>> +	struct phy_device *phydev = priv->mac.phydev;
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct hbg_mac *mac = &priv->mac;
>> +	int ret;
>> +
>> +	ret = phy_connect_direct(priv->netdev, mac->phydev, hbg_phy_adjust_link,
>> +				 PHY_INTERFACE_MODE_SGMII);
>> +	if (ret)
>> +		return dev_err_probe(dev, -ENOMEM, "failed to connect phy\n");
> Don't replace the error code. Doing so actually makes dev_err_probe()
> pointless because it is not going to see the EPROBE_DEFER.
>
Sorry, It is a mistake.
I'll fix it in the next version.

>> +int hbg_mdio_init(struct hbg_priv *priv)
>> +{
>> +	struct device *dev = &priv->pdev->dev;
>> +	struct hbg_mac *mac = &priv->mac;
>> +	struct phy_device *phydev;
>> +	struct mii_bus *mdio_bus;
>> +	int ret;
>> +
>> +	mac->phy_addr = priv->dev_specs.phy_addr;
>> +	mdio_bus = devm_mdiobus_alloc(dev);
>> +	if (!mdio_bus)
>> +		return dev_err_probe(dev, -ENOMEM, "failed to alloc MDIO bus\n");
>> +
>> +	mdio_bus->parent = dev;
>> +	mdio_bus->priv = priv;
>> +	mdio_bus->phy_mask = ~(1 << mac->phy_addr);
>> +	mdio_bus->name = "hibmcge mii bus";
>> +	mac->mdio_bus = mdio_bus;
>> +
>> +	mdio_bus->read = hbg_mdio_read22;
>> +	mdio_bus->write = hbg_mdio_write22;
>> +	snprintf(mdio_bus->id, MII_BUS_ID_SIZE, "%s-%s", "mii", dev_name(dev));
>> +
>> +	ret = devm_mdiobus_register(dev, mdio_bus);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to register MDIO bus\n");
>> +
>> +	phydev = mdiobus_get_phy(mdio_bus, mac->phy_addr);
>> +	if (!phydev)
>> +		return dev_err_probe(dev, -EIO, "failed to get phy device\n");
> ENODEV is probably better, since the device does not exist.
>
> 	Andrew

Thanks a lot!

	Jijie Shao



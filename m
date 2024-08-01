Return-Path: <netdev+bounces-114865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC794476B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 11:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4561F26206
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 09:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F031130AF6;
	Thu,  1 Aug 2024 09:05:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06C03D97F;
	Thu,  1 Aug 2024 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503136; cv=none; b=bCabkA7NPmxLgKHXdlLEfvGrLyWKzWykXpjs48RnrkjlNWQGtAdrNu7VvEdsQ89tbZFtzscr6iPZx0Uq9RQXbiUJcz4BVpV4z+otu/C4rBwYYN7N5fZNhJuayZPvUvgCd6P9q4SJeXW1DHNaTHg+uNtaCrknJiqop7StJ+qYDC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503136; c=relaxed/simple;
	bh=MgekXSOV33uwcZnygUQD9uUFA/ojL3D04dsV2DL5OZY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kfazttK+W7N8dgjWbH++xS46loAKBVZD3tEc4f+EVUbdPnOg7ss8j0Q/noCU4SE9WxXj8Lu+dQfyC8Rs9jzY9YEv+wHQ7DOKWdV+rfZnaH6CFReaCsmcJZgvj+io88WJ6pNz+Z9N5zIbEO6bGbOa8lr8YmjFCmv4t6m8+WnpDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WZNJ434XVz1HFmL;
	Thu,  1 Aug 2024 17:01:56 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 63AB11A016C;
	Thu,  1 Aug 2024 17:04:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 17:04:45 +0800
Message-ID: <746dfc27-f880-4bbe-b9bd-c8bb82303ffe@huawei.com>
Date: Thu, 1 Aug 2024 17:04:44 +0800
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
Subject: Re: [RFC PATCH net-next 03/10] net: hibmcge: Add mdio and hardware
 configuration supported in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-4-shaojijie@huawei.com>
 <ba5b8b48-64b7-417d-a000-2e82e242c399@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ba5b8b48-64b7-417d-a000-2e82e242c399@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Thanks for reviewing

on 2024/8/1 8:42, Andrew Lunn wrote:
>> +int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
>> +{
>> +	if (speed != HBG_PORT_MODE_SGMII_10M &&
>> +	    speed != HBG_PORT_MODE_SGMII_100M &&
>> +	    speed != HBG_PORT_MODE_SGMII_1000M)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (duplex != DUPLEX_FULL && duplex != DUPLEX_HALF)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (speed == HBG_PORT_MODE_SGMII_1000M && duplex == DUPLEX_HALF)
>> +		return -EOPNOTSUPP;
> If you tell phylib you don't support 1G/Half, this will not happen.

ok, I will delete it in V2

>
>> +/* sgmii autoneg always enable */
>> +int hbg_hw_sgmii_autoneg(struct hbg_priv *priv)
>> +{
>> +	wait_time = 0;
>> +	do {
>> +		msleep(HBG_HW_AUTONEG_TIMEOUT_STEP);
>> +		wait_time += HBG_HW_AUTONEG_TIMEOUT_STEP;
>> +
>> +		an_state.bits = hbg_reg_read(priv, HBG_REG_AN_NEG_STATE_ADDR);
>> +		if (an_state.an_done)
>> +			break;
>> +	} while (wait_time < HBG_HW_AUTONEG_TIMEOUT_MS);
> include/linux/iopoll.h

Thanks for the guide. These macros will simplify the code.

>
>> +static const u32 hbg_mode_ability[] = {
>> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
>> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
>> +	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
>> +	ETHTOOL_LINK_MODE_Autoneg_BIT,
>> +	ETHTOOL_LINK_MODE_TP_BIT,
>> +};
>> +
>> +static int hbg_mac_init(struct hbg_priv *priv)
>> +{
>> +	struct hbg_mac *mac = &priv->mac;
>> +	u32 i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(hbg_mode_ability); i++)
>> +		linkmode_set_bit(hbg_mode_ability[i], mac->supported);
> Humm, odd. Where is this leading...
>
>> +#define HBG_MDIO_FREQUENCE_2_5M		0x1
> I assume it supports other frequencies. You might want to implement
> the DT property 'clock-frequency'. Many modern PHY will work faster
> than 2.5Mhz.

it's a good idea,

>
>> +static int hbg_phy_connect(struct hbg_priv *priv)
>> +{
>> +	struct phy_device *phydev = priv->mac.phydev;
>> +	struct hbg_mac *mac = &priv->mac;
>> +	int ret;
>> +
>> +	linkmode_copy(phydev->supported, mac->supported);
>> +	linkmode_copy(phydev->advertising, mac->supported);
> And here it is. Why? Do you see any other MAC driver doing this?
>
> What you probably want is:
>
> phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
>
> which is what other MAC drivers do.

Yeah， using phy_remove_link_mode, the hbg_mode_ability[] and linkmode_set_bit
of the previous code can be removed together.

Thank you.

>
>> +
>> +	phy_connect_direct(priv->netdev, mac->phydev, hbg_phy_adjust_link,
>> +			   PHY_INTERFACE_MODE_SGMII);
>> +	ret = devm_add_action_or_reset(&priv->pdev->dev,
>> +				       hbg_phy_disconnect, mac->phydev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	phy_attached_info(phydev);
>> +	return 0;
>> +}
>> +
>> +/* include phy link and mac link */
>> +u32 hbg_get_link_status(struct hbg_priv *priv)
>> +{
>> +	struct phy_device *phydev = priv->mac.phydev;
>> +	int ret;
>> +
>> +	if (!phydev)
>> +		return HBG_LINK_DOWN;
>> +
>> +	phy_read_status(phydev);
>> +	if ((phydev->state != PHY_UP && phydev->state != PHY_RUNNING) ||
>> +	    !phydev->link)
>> +		return HBG_LINK_DOWN;
>> +
>> +	ret = hbg_hw_sgmii_autoneg(priv);
>> +	if (ret)
>> +		return HBG_LINK_DOWN;
>> +
>> +	return HBG_LINK_UP;
>> +}
> There should not be any need for this. So why do you have it?

I'll move this to another patch where it's more appropriate.

>
> 	Andrew

Thanks, Jijie



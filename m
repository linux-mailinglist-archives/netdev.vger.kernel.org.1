Return-Path: <netdev+bounces-144124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936679C5E6A
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44551B66125
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6551FEFD5;
	Tue, 12 Nov 2024 14:37:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D441FCC4F;
	Tue, 12 Nov 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422255; cv=none; b=Fh3v4AmRzThQzjU6z+U8l90agw7esFpSVdlnatg+4IfYgxdUYTUcaBPQvc+hvLe5SEtJizy+Jqu9tfRUo6zrXtTpC2T57vXpFzpB8t+k73bocMNcr7EaaMoC06BdyTD77QVTRfCPIml60W80PIrlzJZhxqHgUxc+pnMkPuDi/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422255; c=relaxed/simple;
	bh=pcsB3HxBUO3zjYSRuVYOVBKwnqHHUka3qTp7aYKNFtc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=axC2oXKjaqLAcINj4lHoiJTwHYmbtt5YNWD+bWP2Yr3MleWqVCiwDmPE0r+BKxQh/he9PiKcUatrRrKVXyOUjyZzbevwmt6LNzRH26C8A448gRIojHnMklRAF8vDNx2IxY/fp/V+n0m0xU4mOaVujHrqkQ1wdx6LzbRROWR6j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xnpps4X0lz10Qlw;
	Tue, 12 Nov 2024 22:35:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E597B180104;
	Tue, 12 Nov 2024 22:37:29 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 12 Nov 2024 22:37:28 +0800
Message-ID: <98187fe7-23f1-4c52-a62f-c96e720cb491@huawei.com>
Date: Tue, 12 Nov 2024 22:37:27 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <efd481a8-d020-452b-b29b-dfa373017f1f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/12 1:58, Andrew Lunn wrote:
> On Mon, Nov 11, 2024 at 10:55:56PM +0800, Jijie Shao wrote:
>> The MAC can automatically send or respond to pause frames.
>> This patch supports the function of enabling pause frames
>> by using ethtool.
>>
>> Pause auto-negotiation is not supported currently.
> What is actually missing to support auto-neg pause? You are using
> phylib, so it will do most of the work. You just need your adjust_link
> callback to configure the hardware to the result of the negotiation.
> And call phy_support_asym_pause() to let phylib know what the MAC
> supports.
>
> 	Andrew

Thanks for your guidance,

I haven't really figured out the difference between phy_support_sym_pause()
and phy_support_asym_paus(). However, according to your guidance
and referring to the phylib interface and other drivers code,
I implemented the auto-neg pause function:


+static void hbg_ethtool_get_pauseparam(struct net_device *net_dev,
+				       struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+
+	param->autoneg = priv->mac.pause_autoneg;
+	hbg_hw_get_pause_enable(priv, &param->tx_pause, &param->rx_pause);
+}
+
+static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
+				      struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+	struct phy_device *phydev = priv->mac.phydev;
+
+	phy_set_asym_pause(phydev, param->rx_pause, param->tx_pause);
+
+	priv->mac.pause_autoneg = param->autoneg;
+	if (!param->autoneg)
+		hbg_hw_set_pause_enable(priv, param->tx_pause, param->rx_pause);
+
+	return 0;
+}

......

+static void hbg_flowctrl_cfg(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+	bool rx_pause;
+	bool tx_pause;
+
+	if (!priv->mac.pause_autoneg)
+		return;
+
+	phy_get_pause(phydev, &tx_pause, &rx_pause);
+	hbg_hw_set_pause_enable(priv, tx_pause, rx_pause);
+}
+
  static void hbg_phy_adjust_link(struct net_device *netdev)
  {
  	struct hbg_priv *priv = netdev_priv(netdev);
@@ -140,6 +153,7 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
  			priv->mac.duplex = phydev->duplex;
  			priv->mac.autoneg = phydev->autoneg;
  			hbg_hw_adjust_link(priv, speed, phydev->duplex);
+			hbg_flowctrl_cfg(priv);
  		}
  
  		priv->mac.link_status = phydev->link;
@@ -168,6 +182,7 @@ static int hbg_phy_connect(struct hbg_priv *priv)
  		return ret;
  
  	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+	phy_support_asym_pause(phydev);
  	phy_attached_info(phydev);
  
  	return 0;

......

Can the auto-neg pause function be fully supported?
If the code is ok, I'll add it in the next version.

Thanks,
Jijie Shao




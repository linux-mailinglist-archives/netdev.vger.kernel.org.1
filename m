Return-Path: <netdev+bounces-114759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BB943FC6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 03:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B151F21D17
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA413958F;
	Thu,  1 Aug 2024 00:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u4VV1ZfU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F101EB48E;
	Thu,  1 Aug 2024 00:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472968; cv=none; b=bEC11+uCNErBmWn5ytNRrXKUmYUg9Rv4A9T973zwRZfL25fh9Q1WLGy0y5QXCf3GFI5xxVa0moODygWIj4PBsLystvmOKkScycNR2oePkUuyFBAGudx+G9oqz3a9T/ZS1frr5nS7qxYbx65QhKYsDPBJB/pMaRvQ8T4pifC6vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472968; c=relaxed/simple;
	bh=g9JH59jqe6ZJ/Q0Ob3lp9iRrD2iq1QlW1S3e/H2/u/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fre6j36+95q1qbY/5w7XYGxbcM+k3GlWh2Zz9vjrHOZR69UGl/t1kskm66tKJGu54k2Pi22PPubR7nOdxM5tmTeywLd94s6Flt9cI/R03QE21fckGUOgeC25CCYUlF7f7nRB3+IJVt4cAgAfxwSbbRXV51ltkj6NQuc8143amm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u4VV1ZfU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/jd3KZlGOhhh3/tY9fl99zgakKDa85hqjwlNTtlP8KE=; b=u4VV1ZfUx0p9ZjbZ4Tv3Q73j+U
	f4W+CBsFse71lcLp7p6rPvJHdgenlk3OcL/QR5MaTV0MSLwAydYX5ZufgScyQYbjFObF2QD0AR3Fk
	e0zl5nqQ5gC2idemngPsPuFKiN9IyvP2/O3jusD4F4JLWP+7/BeAZK748HhgRFeJmp1Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sZJtt-003izk-6P; Thu, 01 Aug 2024 02:42:37 +0200
Date: Thu, 1 Aug 2024 02:42:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 03/10] net: hibmcge: Add mdio and hardware
 configuration supported in this module
Message-ID: <ba5b8b48-64b7-417d-a000-2e82e242c399@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731094245.1967834-4-shaojijie@huawei.com>

> +int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
> +{
> +	if (speed != HBG_PORT_MODE_SGMII_10M &&
> +	    speed != HBG_PORT_MODE_SGMII_100M &&
> +	    speed != HBG_PORT_MODE_SGMII_1000M)
> +		return -EOPNOTSUPP;
> +
> +	if (duplex != DUPLEX_FULL && duplex != DUPLEX_HALF)
> +		return -EOPNOTSUPP;
> +
> +	if (speed == HBG_PORT_MODE_SGMII_1000M && duplex == DUPLEX_HALF)
> +		return -EOPNOTSUPP;

If you tell phylib you don't support 1G/Half, this will not happen.

> +/* sgmii autoneg always enable */
> +int hbg_hw_sgmii_autoneg(struct hbg_priv *priv)
> +{

> +	wait_time = 0;
> +	do {
> +		msleep(HBG_HW_AUTONEG_TIMEOUT_STEP);
> +		wait_time += HBG_HW_AUTONEG_TIMEOUT_STEP;
> +
> +		an_state.bits = hbg_reg_read(priv, HBG_REG_AN_NEG_STATE_ADDR);
> +		if (an_state.an_done)
> +			break;
> +	} while (wait_time < HBG_HW_AUTONEG_TIMEOUT_MS);

include/linux/iopoll.h

> +static const u32 hbg_mode_ability[] = {
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> +	ETHTOOL_LINK_MODE_Autoneg_BIT,
> +	ETHTOOL_LINK_MODE_TP_BIT,
> +};
> +
> +static int hbg_mac_init(struct hbg_priv *priv)
> +{
> +	struct hbg_mac *mac = &priv->mac;
> +	u32 i;
> +
> +	for (i = 0; i < ARRAY_SIZE(hbg_mode_ability); i++)
> +		linkmode_set_bit(hbg_mode_ability[i], mac->supported);

Humm, odd. Where is this leading...

> +#define HBG_MDIO_FREQUENCE_2_5M		0x1

I assume it supports other frequencies. You might want to implement
the DT property 'clock-frequency'. Many modern PHY will work faster
than 2.5Mhz.

> +static int hbg_phy_connect(struct hbg_priv *priv)
> +{
> +	struct phy_device *phydev = priv->mac.phydev;
> +	struct hbg_mac *mac = &priv->mac;
> +	int ret;
> +
> +	linkmode_copy(phydev->supported, mac->supported);
> +	linkmode_copy(phydev->advertising, mac->supported);

And here it is. Why? Do you see any other MAC driver doing this?

What you probably want is:

phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);

which is what other MAC drivers do.

> +
> +	phy_connect_direct(priv->netdev, mac->phydev, hbg_phy_adjust_link,
> +			   PHY_INTERFACE_MODE_SGMII);
> +	ret = devm_add_action_or_reset(&priv->pdev->dev,
> +				       hbg_phy_disconnect, mac->phydev);
> +	if (ret)
> +		return ret;
> +
> +	phy_attached_info(phydev);
> +	return 0;
> +}
> +
> +/* include phy link and mac link */
> +u32 hbg_get_link_status(struct hbg_priv *priv)
> +{
> +	struct phy_device *phydev = priv->mac.phydev;
> +	int ret;
> +
> +	if (!phydev)
> +		return HBG_LINK_DOWN;
> +
> +	phy_read_status(phydev);
> +	if ((phydev->state != PHY_UP && phydev->state != PHY_RUNNING) ||
> +	    !phydev->link)
> +		return HBG_LINK_DOWN;
> +
> +	ret = hbg_hw_sgmii_autoneg(priv);
> +	if (ret)
> +		return HBG_LINK_DOWN;
> +
> +	return HBG_LINK_UP;
> +}

There should not be any need for this. So why do you have it?

	Andrew


Return-Path: <netdev+bounces-129018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74DB97CED3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DF5B2183C
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AB7149E00;
	Thu, 19 Sep 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JKx7uG8B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B56144D1A
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726782294; cv=none; b=tGcVzl1Oc6CDGpGNQVN2jmQRxuwcUbFg2S8afG3V75HwvjEHm6w69TUUTAdLz3ooz2syR8yg8DBSu6Hq0fsYA56U+DTmjPgzgS5Zgu57hofK9pbuFWWRHc0S6CErLPkUvlUZC/8gV7As7ScJGcey9MDe22SNFfgD3yMkwY96YLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726782294; c=relaxed/simple;
	bh=J+udWigkrMSpVxCjChVJp2IuWynrfh+bTXwIa6RA5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhM5DkycdYZpJ/hrwi5nxPxy5icWBSg1YVIK9VGTeJCd09R1apnpRCPwbwJVgvQVSAaPD21CW6x6okJumU492W3gcaoSuwvPkUlRbIJSDSIZxzjDzvBAz8F+avf5E90mzTEtx8A+Mol3m19XITh4qdj85NIUSzhgCPgnNPwWp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JKx7uG8B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Gxtas6bM1llNen7yKDSGXHxQHdf1EfACXiykn7Do5c=; b=JKx7uG8BfaBlytIgkhyfLRUN8o
	xoGS2P522+XwCzsTKphKoyRD7geBp3ANE7wqcXhOz9R+qFBI+SWTQdf+QVlWt+dMWMltTRZXc/8F1
	pp44Use0zOiE+DdqNzoLK9JWtyYJMlv1QQl3Zfy1c/ybH08AqpVqsj5L1AZ+TujF7kvk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1srOxF-007qvi-IP; Thu, 19 Sep 2024 23:44:49 +0200
Date: Thu, 19 Sep 2024 23:44:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Alvaro (Al-vuh-roe) Reyes" <a-reyes1@ti.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, o.rempel@pengutronix.de,
	spatton@ti.com, r-kommineni@ti.com, e-mayhew@ti.com,
	praneeth@ti.com, p-varis@ti.com, d-qiu@ti.com
Subject: Re: [PATCH 4/5] net: phy: dp83tg720: Added OA script
Message-ID: <741f9487-e7f4-4c6e-b933-18cc2761c2f1@lunn.ch>
References: <cover.1726263095.git.a-reyes1@ti.com>
 <c41bc533471bab570be58bca3eae057554a56389.1726263095.git.a-reyes1@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41bc533471bab570be58bca3eae057554a56389.1726263095.git.a-reyes1@ti.com>

> +struct DP83TG720_init_reg {
> +	int MMD;
> +	int reg;
> +	int val;
> +};
> +
> +/*Refer to SNLA371 for more information*/
> +static const struct DP83TG720_init_reg DP83TG720_cs1_1_master_init[] = {
> +	{0x1F, 0x001F, 0X8000},
> +	{0x1F, 0x0573, 0x0101},
> +	{0x1, 0x0834, 0xC001},

MDIO_MMD_VEND2 etc.

Also 0x834 is BASE-T1 PMA/PMD control. Which is MDIO_PMA_PMD_BT1_CTRL

We also have:
#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000 0x0001 /* Select 1000BASE-T1 */
#define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */

802.3 says bit 15 is read only, so you don't need to set it.

The rest might be magic which nobody outside of TI will understand,
but you can fully document this.

> +static int dp83tg720_reset(struct phy_device *phydev, bool hw_reset)
> +{
> +	int ret;
> +
> +	if (hw_reset)
> +		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
> +				DP83TG720_HW_RESET);
> +	else
> +		ret = phy_write_mmd(phydev, MMD1F, DP83TG720_PHY_RESET_CTRL,
> +				DP83TG720_SW_RESET);
> +	if (ret)
> +		return ret;
> +
> +	mdelay(100);

Does the bit not self clear when it has completed? That would be
common for a reset bit.

> +static int DP83TG720_write_seq(struct phy_device *phydev,
> +			     const struct DP83TG720_init_reg *init_data, int size)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +			ret = phy_write_mmd(phydev, init_data[i].MMD, init_data[i].reg,
> +				init_data[i].val);
> +			if (ret)
> +					return ret;
> +	}

More messed up indentation.

> +static int dp83tg720_chip_init(struct phy_device *phydev)
> +{
> +	struct DP83TG720_private *DP83TG720 = phydev->priv;
> +	int ret;
> +
> +	ret = dp83tg720_reset(phydev, true);
> +	if (ret)
> +		return ret;
> +	
> +	phydev->autoneg = AUTONEG_DISABLE;
> +    phydev->speed = SPEED_1000;
> +	phydev->duplex = DUPLEX_FULL;
> +    linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);

This should not be needed. phylib should be able to figure this out
for itself from the registers. Please check that functions like
genphy_c45_pma_baset1_read_abilities() are doing.

> +
> +	switch (DP83TG720->chip) {
> +	case DP83TG720_CS1_1:
> +		if (DP83TG720->is_master)
> +			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_master_init,
> +						ARRAY_SIZE(DP83TG720_cs1_1_master_init));
> +		else
> +			ret = DP83TG720_write_seq(phydev, DP83TG720_cs1_1_slave_init,
> +						ARRAY_SIZE(DP83TG720_cs1_1_slave_init));
> +
> +		ret = dp83tg720_reset(phydev, false);
> +
> +		return 1;

0 on success, negative error code on error.

	Andrew


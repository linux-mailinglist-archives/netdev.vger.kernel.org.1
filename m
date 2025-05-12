Return-Path: <netdev+bounces-189889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A618AB454F
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C000D19E504E
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E271029712B;
	Mon, 12 May 2025 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s0kJ2rjA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38701F0E26;
	Mon, 12 May 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080167; cv=none; b=pL6lwLZ2gI20MBtemgAQgL6q40yWPe9fPoc7VpnMbm+w01VEY3cr/JfoLMrMez57Xp1nF9owMGNwPh8JRLIGchQ1LPiA10jtxV8DRE/XamQo5W5LnC09OjAwEAlBTsBn+h3Lj0dbXc5mI68DdVd4pvspYxC2zq/B6U8c35CzH5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080167; c=relaxed/simple;
	bh=AsvZJb/QD1AeCP9LIbZIx/AJmCO+MNWeCYEJS9sxmzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tikZqGpTCc5pko59nhVuD/Ggox4M2Uj4Jj4y4MW6LQVG/uu2B0ESbcfdgcLSATrgPgrVziF0kcuzTFVcEECjhSZsqH+BAEmpCnirWGIII72VfLjZJxwcqu/XZX+KKKh6C9oTN4lcV4ytA6ehjT4DxewYvmCSGMxn1Mh4EJsSzf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s0kJ2rjA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8zip9EVKXX9cHuVA/8dYgcLChhsGW6/qlV304hnIDk4=; b=s0kJ2rjAuRGixiFRi3mJkOqQiG
	xm6OoQ80TiUPg8D1HozgfU3yubNv3xzRwnW/mRfGl0PrqEd8RceohXXvjemTzzJhG+HW8EPuUlI0y
	9GuUFSwd1pageMpvJCiF4blBH9VEim+7UJyItxuTA6WqzVm+29f87D1Ur4eWejoElCT4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEZMG-00CNXN-Ff; Mon, 12 May 2025 22:02:40 +0200
Date: Mon, 12 May 2025 22:02:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH] net: phy: mxl-8611: add support for MaxLinear
 MxL86110/MxL86111 PHY
Message-ID: <1a913939-c8d9-4d66-868c-aa0b570b49ba@lunn.ch>
References: <20250512191901.73823-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512191901.73823-1-stefano.radaelli21@gmail.com>

> +config MAXLINEAR_8611X_PHY
> +	tristate "MaxLinear MXL86110 and MXL86111 PHYs"
> +	help
> +	  Support for the MaxLinear MXL86110 and MXL86111 Gigabit Ethernet
> +	  Physical Layer transceivers.
> +	  These PHYs are commonly found in networking equipment like
> +	  routers, switches, and embedded systems, providing the
> +	  physical interface for 10/100/1000 Mbps Ethernet connections
> +	  over copper media. If you are using a board with one of these
> +	  PHYs connected to your Ethernet MAC, you should enable this option.
> +
>  config MAXLINEAR_GPHY
>  	tristate "Maxlinear Ethernet PHYs"

This file is sorted by tristate. So that would put it after Maxlinear
Ethernet.

> +++ b/drivers/net/phy/mxl-8611x.c
> @@ -0,0 +1,2040 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PHY driver for MXL86110 and MXL86111
> + *
> + * V1.0.0

Version numbers are meaningless. Please drop

> + *
> + * Copyright 2023 MaxLinear Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The SPDX line replaces all the boilerplate. Please drop.

> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/etherdevice.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/module.h>
> +#include <linux/bitfield.h>
> +
> +#define MXL8611x_DRIVER_DESC	"MXL86111 and MXL86110 PHY driver"
> +#define MXL8611x_DRIVER_VER		"1.0.0"

Another pointless version.

> +/* ******************************************************** */
> +/* Customer specific configuration START					*/
> +/* Adapt here if other than default values are required!	*/
> +/* ******************************************************** */

Who is the customer? Please spend time to clear out all the unwanted
vendor stuff.

> +static int mxlphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *netdev;
> +	int page_to_restore;
> +	const u8 *mac;
> +	int ret = 0;
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		netdev = phydev->attached_dev;
> +		if (!netdev)
> +			return -ENODEV;
> +
> +		mac = (const u8 *)netdev->dev_addr;
> +		if (!is_valid_ether_addr(mac))
> +			return -EINVAL;

Why would the MAC address on the device be invalid?

> +/**
> + * mxl86110_read_page() - read reg page
> + * @phydev: pointer to the phy_device
> + *
> + * returns current reg space of MxL86110
> + * (only MXL86111_EXT_SMI_SDS_PHYUTP_SPACE supported) or negative errno code
> + */
> +static int mxl86110_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, MXL8611X_EXTD_REG_ADDR_OFFSET);
> +};
> +
> +/**
> + * mxl86110_write_page() - write reg page
> + * @phydev: pointer to the phy_device
> + * @page: The reg page to write
> + *
> + * returns current reg space of MxL86110
> + * (only MXL86111_EXT_SMI_SDS_PHYUTP_SPACE supported) or negative errno code
> + */
> +static int mxl86110_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, MXL8611X_EXTD_REG_ADDR_OFFSET, page);
> +};

It is normal to put read_page and write_page at the beginning.

> +
> +/**
> + * mxl8611x_led_cfg() - applies LED configuration from device tree
> + * @phydev: pointer to the phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int mxl8611x_led_cfg(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +	int i;
> +	char propname[25];
> +	struct device_node *node = phydev->mdio.dev.of_node;
> +	u32 val;
> +
> +	/* Loop through three the LED registers */
> +	for (i = 0; i < 3; i++) {
> +		/* Read property from device tree */
> +		snprintf(propname, 25, "mxl-8611x,led%d_cfg", i);
> +		if (of_property_read_u32(node, propname, &val))
> +			continue;
> +
> +		/* Update PHY LED register */
> +		ret = mxlphy_write_extended_reg(phydev, MXL8611X_LED0_CFG_REG + i, val);
> +		if (ret < 0)
> +			return ret;
> +	}

You need to implement this via /sys/class/leds. Look at other PHY
drivers which support LEDS.


> + * mxl8611x_broadcast_cfg() - applies broadcast configuration
> + * @phydev: pointer to the phy_device
> + *
> + * configures the broadcast setting for the PHY based on the device tree
> + * if the "mxl-8611x,broadcast-enabled" property is present the PHY broadcasts
> + * address 0 on the MDIO bus. This feature enables PHY to always respond to MDIO access
> + * returns 0 or negative errno code
> + */
> +static int mxl8611x_broadcast_cfg(struct phy_device *phydev)
> +{

No device tree property. Please just hard code is disabled.

> +/**
> + * mxl8611x_synce_clk_cfg() - applies syncE/clk output configuration
> + * @phydev: pointer to the phy_device
> + *
> + * Custom settings can be defined in custom config section of the driver
> + * returns 0 or negative errno code
> + */
> +static int mxl8611x_synce_clk_cfg(struct phy_device *phydev)
> +{
> +	u16 mask = 0, value = 0;
> +	int ret;
> +
> +	switch (MXL8611X_EXT_SYNCE_CFG_CLOCK_FREQ_CUSTOM) {

No macro magic please.

> +	case MXL8611X_CLOCK_DISABLE:
> +		mask = MXL8611X_EXT_SYNCE_CFG_EN_SYNC_E;
> +		value = 0;
> +		break;
> +	case MXL8611X_CLOCK_FREQ_25M:
> +		value = MXL8611X_EXT_SYNCE_CFG_EN_SYNC_E |
> +				FIELD_PREP(MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +					   MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> +		mask = MXL8611X_EXT_SYNCE_CFG_EN_SYNC_E |
> +		       MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +		       MXL8611X_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +		break;
> +	case MXL8611X_CLOCK_FREQ_125M:
> +		value = MXL8611X_EXT_SYNCE_CFG_EN_SYNC_E |
> +				MXL8611X_EXT_SYNCE_CFG_CLK_FRE_SEL |
> +				FIELD_PREP(MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +					   MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_125M_PLL);
> +		mask = MXL8611X_EXT_SYNCE_CFG_EN_SYNC_E |
> +		       MXL8611X_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +		       MXL8611X_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +		break;
> +	case MXL8611X_CLOCK_DEFAULT:
> +		phydev_info(phydev, "%s, default clock cfg\n", __func__);
> +		return 0;
> +	default:
> +		phydev_info(phydev, "%s, invalid clock cfg: %d\n", __func__,
> +			    MXL8611X_EXT_SYNCE_CFG_CLOCK_FREQ_CUSTOM);

Driver should only output to the log when something goes wrong. No
phydev_info() messages please. phydev_err(), or maybe phydev_dbg() for
debug messages. This looks like a fatal error, so phydev_err().

> +		return -EINVAL;
> +	}
> +
> +	phydev_info(phydev, "%s, clock cfg mask:%d, value: %d\n", __func__, mask, value);
> +
> +	/* Write clock output configuration */
> +	ret = mxlphy_locked_modify_extended_reg(phydev, MXL8611X_EXT_SYNCE_CFG_REG,
> +						mask, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/**
> + * mxl86110_config_init() - initialize the PHY
> + * @phydev: pointer to the phy_device
> + *
> + * returns 0 or negative errno code
> + */
> +static int mxl86110_config_init(struct phy_device *phydev)
> +{
> +	int page_to_restore, ret = 0;
> +	unsigned int val = 0;
> +	bool disable_rxdly = false;
> +
> +	page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
> +	if (page_to_restore < 0)
> +		goto error;
> +
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		/* no delay, will write 0 */
> +		val = MXL8611X_EXT_RGMII_CFG1_NO_DELAY;
> +		disable_rxdly = true;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		val = MXL8611X_EXT_RGMII_CFG1_RX_DELAY_CUSTOM;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val = MXL8611X_EXT_RGMII_CFG1_TX_1G_DELAY_CUSTOM |
> +				MXL8611X_EXT_RGMII_CFG1_TX_10MB_100MB_CUSTOM;
> +		disable_rxdly = true;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		val = MXL8611X_EXT_RGMII_CFG1_TX_1G_DELAY_CUSTOM |
> +				MXL8611X_EXT_RGMII_CFG1_TX_10MB_100MB_CUSTOM;
> +		val |= MXL8611X_EXT_RGMII_CFG1_RX_DELAY_CUSTOM;
> +		break;

Rather than CUSTOM, use 2NS, or 2000PS. The RGMII specification
indicates the delay should be 2ns.

> +					 MXL8611X_EXT_RGMII_CFG1_FULL_MASK, val);
> +	if (ret < 0)
> +		goto error;
> +
> +	if (ret < 0)
> +		goto error;
> +

One error check is sufficient.

> +	if (MXL8611x_UTP_DISABLE_AUTO_SLEEP_FEATURE_CUSTOM == 1) {

More macro magic.

> +	/* Disable RXDLY (RGMII Rx Clock Delay) */
> +	if (disable_rxdly) {
> +		ret = mxlphy_modify_extended_reg(phydev, MXL86111_EXT_CHIP_CFG_REG,
> +						 MXL86111_EXT_CHIP_CFG_RXDLY_ENABLE, 0);
> +		if (ret < 0)
> +			goto error;
> +	}

What is this doing?

> +struct mxl86111_priv {
> +	/* dual_media_advertising used for Dual Media mode (MXL86111_EXT_SMI_SDS_PHY_AUTO) */
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(dual_media_advertising);
> +
> +	/* MXL86111_MODE_FIBER / MXL86111_MODE_UTP / MXL86111_MODE_AUTO*/
> +	u8 reg_page_mode;
> +	u8 strap_mode; /* 8 working modes  */
> +	/* current reg page of mxl86111 phy:
> +	 * MXL86111_EXT_SMI_SDS_PHYUTP_SPACE
> +	 * MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE
> +	 * MXL86111_EXT_SMI_SDS_PHY_AUTO
> +	 */
> +	u8 reg_page;
> +};
> +
> +/**
> + * mxl86111_read_page() - read reg page
> + * @phydev: pointer to the phy_device
> + *
> + * returns current reg space of mxl86111 (MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE/
> + * MXL86111_EXT_SMI_SDS_PHYUTP_SPACE) or negative errno code
> + */
> +static int mxl86111_read_page(struct phy_device *phydev)
> +{
> +	int old_page;
> +
> +	old_page = mxlphy_read_extended_reg(phydev, MXL86111_EXT_SMI_SDS_PHY_REG);
> +	if (old_page < 0)
> +		return old_page;
> +
> +	if ((old_page & MXL86111_EXT_SMI_SDS_PHYSPACE_MASK) == MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE)
> +		return MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE;
> +
> +	return MXL86111_EXT_SMI_SDS_PHYUTP_SPACE;
> +};
> +
> +/**
> + * mxl86111_locked_read_page() - read reg page
> + * @phydev: pointer to the phy_device
> + *
> + * returns current reg space of mxl86111 (MXL86111_EXT_SMI_SDS_PHYFIBER_SPACE/
> + * MXL86111_EXT_SMI_SDS_PHYUTP_SPACE) or negative errno code
> + */
> +static int mxl86111_locked_read_page(struct phy_device *phydev)
> +{
> +	int old_page;
> +
> +	phy_lock_mdio_bus(phydev);
> +	old_page = mxl86111_read_page(phydev);
> +	phy_unlock_mdio_bus(phydev);

What is the locking here? All this does is read a page register. By
the time you use the value, something might of already changed to a
different page...

There is a lot of "Vendor Crap" in this driver. Please spend some time
to bring it up to mainline standard. You might find the marvell driver
interesting. It also has to deal with fibre and copper. The code is
not great, but it is better than this.

	Andrew


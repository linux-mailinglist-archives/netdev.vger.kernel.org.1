Return-Path: <netdev+bounces-191909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D758ABDDC1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0FB7B71F8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 14:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0124A074;
	Tue, 20 May 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pX8Mi0bU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEC4248F65;
	Tue, 20 May 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752452; cv=none; b=P4lGfrN3A1LkR7M0Rs9XrvZve+8UfG9l5la66w04he7bUkvhRPXxFXPzVhGAnRT8wh16BzhUnmkz6C0GmKHmI4Y3572yMmCLfJeFkB5m00y/FQwjN3NcuEvxn2Yf1nkVtn8y/7kYodwOITSugyaVW0AwgejAS3ZAZ43Gs3fykMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752452; c=relaxed/simple;
	bh=Tx7/FcEU6Bw90Yjwe4KaoxrW48XMQgTlH5CIeNph+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaCpv1YAAx946hh6FPM4ZD4Q57bt+04YbiN4xJlHc9c031+8x19mWrXa+nzAIdlIHw5kZ9sV+g64+0dK1kv/emRbmXQ0il+IlqfTHJZbZxQyLnlfUuDlU45MbH7AzTYV0MZFulNxAAAmGsC1s82EyWNjaFbVSM8eOx6H7rRtOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pX8Mi0bU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9Wxg0bmAoZMwL7DP1FILaNYigKUm5O9FzWzy/QHJHkI=; b=pX8Mi0bUJ6hoQj29r3i0g1OlW+
	F7PCyKksKYZca1wgvyIbC6eoBMDnVf12DNbkZB6iwqXHieeea005dByLCB03jd/wFr+VRkB4dnneC
	mlkMEy1AJRPN9DJ+OwA3nHySQTiRESYuIqxD6ct7MAk5N2IgO6rk8+2M5uoJBt/w+Ba0MlywjRe5S
	WMLHcPWPI7ovYIjtBX+M2r0AB8LQF+C4CWi7GP3S9aUcMTaccA+Xrzjz1idndjIGar2d3H589bZmv
	gXyj6stTXgwskn2NRQ3BwVP/4PAyzQHjUV2rnVbxU9lcGlQ+8CZItLzYVvvNeBAgMgcbF8K46lDbR
	FanQuf/g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37484)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uHOFY-0007Sm-2h;
	Tue, 20 May 2025 15:47:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uHOFW-0002yr-0L;
	Tue, 20 May 2025 15:47:22 +0100
Date: Tue, 20 May 2025 15:47:21 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: stefano.radaelli21@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH net-next v4] net: phy: add driver for MaxLinear MxL86110
 PHY
Message-ID: <aCyV-Zaeg-BLV0Vt@shell.armlinux.org.uk>
References: <20250520124521.440639-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520124521.440639-1-stefano.radaelli21@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 20, 2025 at 02:45:18PM +0200, stefano.radaelli21@gmail.com wrote:
> +/**
> + * mxl86110_write_extended_reg() - write to a PHY's extended register
> + * @phydev: pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative error code
> + */
> +static int mxl86110_write_extended_reg(struct phy_device *phydev,
> +				       u16 regnum, u16 val)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);
> +}
> +
> +/**
> + * mxl86110_read_extended_reg - Read a PHY's extended register
> + * @phydev: Pointer to the PHY device structure
> + * @regnum: Extended register number to read (address written to reg 30)
> + *
> + * Reads the content of a PHY extended register using the MaxLinear
> + * 2-step access mechanism: write the register address to reg 30 (0x1E),
> + * then read the value from reg 31 (0x1F).
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 16-bit register value on success, or negative errno code on failure.
> + */
> +static int mxl86110_read_extended_reg(struct phy_device *phydev, u16 regnum)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_DATA);
> +}
> +
> +/**
> + * mxl86110_modify_extended_reg() - modify bits of a PHY's extended register
> + * @phydev: pointer to the phy_device
> + * @regnum: register number to write
> + * @mask: bit mask of bits to clear
> + * @set: bit mask of bits to set
> + *
> + * Note: register value = (old register value & ~mask) | set.
> + * This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative error code
> + */
> +static int mxl86110_modify_extended_reg(struct phy_device *phydev,
> +					u16 regnum, u16 mask, u16 set)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_modify(phydev, MXL86110_EXTD_REG_ADDR_DATA, mask, set);
> +}

As these are all unlocked variants, I wonder whether they should have
__ prefixes. I'm wondering whether our paged accessors could be re-used
for this phy, even though effectively there is only one "paged" register
at offset 31 with the page index at offset 30.

Also, given the number of single accesses to the registers, I wonder if
it also makes sense to have variants that take the MDIO bus lock, which
would allow simplification of sites such as...

> +
> +/**
> + * mxl86110_get_wol() - report if wake-on-lan is enabled
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + */
> +static void mxl86110_get_wol(struct phy_device *phydev,
> +			     struct ethtool_wolinfo *wol)
> +{
> +	int value;
> +
> +	wol->supported = WAKE_MAGIC;
> +	wol->wolopts = 0;
> +	phy_lock_mdio_bus(phydev);
> +	value = mxl86110_read_extended_reg(phydev, MXL86110_EXT_WOL_CFG_REG);
> +	phy_unlock_mdio_bus(phydev);

... here.

> +	if (value >= 0 && (value & MXL86110_WOL_CFG_WOLE_MASK))
> +		wol->wolopts |= WAKE_MAGIC;
> +}
> +
> +/**
> + * mxl86110_set_wol() - enable/disable wake-on-lan
> + * @phydev: pointer to the phy_device
> + * @wol: a pointer to a &struct ethtool_wolinfo
> + *
> + * Configures the WOL Magic Packet MAC
> + *
> + * Return: 0 or negative errno code
> + */
> +static int mxl86110_set_wol(struct phy_device *phydev,
> +			    struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *netdev;
> +	const u8 *mac;

Use "const unsigned char *mac" - that way you don't need the cast below.

> +	int ret = 0;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		netdev = phydev->attached_dev;
> +		if (!netdev) {
> +			ret = -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Configure the MAC address of the WOL magic packet */
> +		mac = (const u8 *)netdev->dev_addr;
> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG1,
> +						  ((mac[0] << 8) | mac[1]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG2,
> +						  ((mac[2] << 8) | mac[3]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_write_extended_reg(phydev,
> +						  MXL86110_EXT_MAC_ADDR_CFG3,
> +						  ((mac[4] << 8) | mac[5]));
> +		if (ret < 0)
> +			goto out;
> +
> +		ret = mxl86110_modify_extended_reg(phydev,
> +						   MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_WOL_CFG_WOLE_MASK,
> +						   MXL86110_EXT_WOL_CFG_WOLE);
> +		if (ret < 0)
> +			goto out;
> +
> +		/* Enables Wake-on-LAN interrupt in the PHY. */
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG, 0,
> +				   PHY_IRQ_ENABLE_REG_WOL);
> +		if (ret < 0)
> +			goto out;
> +
> +		phydev_dbg(phydev,
> +			   "%s, MAC Addr: %02X:%02X:%02X:%02X:%02X:%02X\n",
> +			   __func__,
> +			   mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> +	} else {
> +		ret = mxl86110_modify_extended_reg(phydev,
> +						   MXL86110_EXT_WOL_CFG_REG,
> +						   MXL86110_WOL_CFG_WOLE_MASK,
> +						   0);
> +		if (ret < 0)
> +			goto out;
> +
> +		/* Disables Wake-on-LAN interrupt in the PHY. */
> +		ret = __phy_modify(phydev, PHY_IRQ_ENABLE_REG,
> +				   PHY_IRQ_ENABLE_REG_WOL, 0);
> +	}
> +
> +out:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +

...
> +static int mxl86110_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				       unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	phy_lock_mdio_bus(phydev);
> +	val = mxl86110_read_extended_reg(phydev,
> +					 MXL86110_LED0_CFG_REG + index);
> +	phy_unlock_mdio_bus(phydev);

This could also be simplified with the locking accessors.

> +	if (val < 0)
> +		return val;
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_TX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_RX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_HALF_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_FULL_DUPLEX);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_10MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_10);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_100MB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_100);
> +
> +	if (val & MXL86110_LEDX_CFG_LINK_UP_1GB_ON)
> +		*rules |= BIT(TRIGGER_NETDEV_LINK_1000);
> +
> +	return 0;
> +};
> +
> +static int mxl86110_led_hw_control_set(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	u16 val = 0;
> +	int ret;
> +
> +	if (index >= MXL86110_MAX_LEDS)
> +		return -EINVAL;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_10))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_10MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_100))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_100MB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_LINK_1000))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_1GB_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_TX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_RX_ACT_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_HALF_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_HALF_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_FULL_DUPLEX))
> +		val |= MXL86110_LEDX_CFG_LINK_UP_FULL_DUPLEX_ON;
> +
> +	if (rules & BIT(TRIGGER_NETDEV_TX) ||
> +	    rules & BIT(TRIGGER_NETDEV_RX))
> +		val |= MXL86110_LEDX_CFG_LAB_BLINK;
> +
> +	phy_lock_mdio_bus(phydev);
> +	ret = mxl86110_write_extended_reg(phydev,
> +					  MXL86110_LED0_CFG_REG + index, val);
> +	phy_unlock_mdio_bus(phydev);

and this... and with the locking accessors it could become simply:

	return mxl86110_write_extended_reg(...);

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +};
> +
> +/**
> + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> + * @phydev: pointer to the phy_device
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 or negative errno code
> + */
> +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> +{
> +	u16 mask = 0, val = 0;
> +	int ret;
> +
> +	/*
> +	 * Configures the clock output to its default
> +	 * setting as per the datasheet.
> +	 * This results in a 25MHz clock output being selected in the
> +	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
> +	 */
> +	val = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> +	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +
> +	/* Write clock output configuration */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> +					   mask, val);
> +
> +	return ret;

No need for "ret":

	return mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
					    mask, val);

> +}
> +
> +/**
> + * mxl86110_broadcast_cfg - Configure MDIO broadcast setting for PHY
> + * @phydev: Pointer to the PHY device structure
> + *
> + * This function configures the MDIO broadcast behavior of the MxL86110 PHY.
> + * Currently, broadcast mode is explicitly disabled by clearing the EPA0 bit
> + * in the RGMII_MDIO_CFG extended register.
> + *
> + * Note: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY.
> + *
> + * Return: 0 on success or a negative errno code on failure.
> + */
> +static int mxl86110_broadcast_cfg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = mxl86110_modify_extended_reg(phydev,
> +					   MXL86110_EXT_RGMII_MDIO_CFG,
> +					   MXL86110_RGMII_MDIO_CFG_EPA0_MASK,
> +					   0);
> +
> +	return ret;

No need for "ret".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


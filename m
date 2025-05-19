Return-Path: <netdev+bounces-191538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AFBABBDF5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84AD7A5F80
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A6278763;
	Mon, 19 May 2025 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bi98E4iu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C027874E;
	Mon, 19 May 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658122; cv=none; b=hQfCa6qusamH/J7iGCpWfiG4P3HBWkjk3eRU/mJozYwPwXZ+DYivwMo9lylgGQh09BG9+EwHLsTGU5BkFTxo+RvdQNBIwGWMOKOq03YJDzjT55Idv6Ve7qQsAbiGh7clKwUKowdArir58y6y4aeVMB/qdpUIX6c5HLnB9gIbBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658122; c=relaxed/simple;
	bh=rdzxM2Ez+OpL9Z4JCGL5QU5vGcivUVrVBFMJHd1PqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut/R1xh1kVwZEnNMK1f0U9cy27y6kyPaW71H+1DB4fViVLK7oelUueIDwshp2qUMPIOtMg7G8BIVBfazGbAhCJ4mr8c8cFJYHBFc1bYF9BjTYdb7JJWKJ7ywUtw+EZheVktvw7x2jLjxfQWAd/YvWD5Qqs0SyxEYOstYvgTJJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bi98E4iu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kRMzGd0CTkhFlejlUnubv81+L+CuV5nEq1Y/WORmQkM=; b=Bi98E4iuRXWgTXbw6ChqdAq/LI
	c+0OQ2GtOnxqQZl6cUhF7W45jc+ZZbDYD75xT4Y2OQwQZ6Dylybq36DvjaCy2wVEBLeQfa/qmJyLX
	RXbqWMAndEzXJRakQAePXhnw3E0Q19COvEN6wtO7XPZAf9Pc8qhIQNf+hxBDG3WbcoqQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGzi7-00D1GN-V5; Mon, 19 May 2025 14:35:15 +0200
Date: Mon, 19 May 2025 14:35:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH net-next v2] net: phy: add driver for MaxLinear MxL86110
 PHY
Message-ID: <de1514f8-7612-4a26-a74e-cf87ce3c8819@lunn.ch>
References: <20250516142707.163457-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516142707.163457-1-stefano.radaelli21@gmail.com>

> +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	struct net_device *netdev;
> +	const u8 *mac;
> +	int ret = 0;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	if (wol->wolopts & WAKE_MAGIC) {
> +		netdev = phydev->attached_dev;
> +		if (!netdev) {
> +			ret = -ENODEV;
> +			goto error;
> +		}

...

> +
> +	phy_unlock_mdio_bus(phydev);
> +	return 0;
> +error:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}

You should be able to simplify this. If you have not had an error, ret
should be 0. So you can also return ret. You have the same pattern in
other places.

> +/**
> + * mxl86110_synce_clk_cfg() - applies syncE/clk output configuration
> + * @phydev: pointer to the phy_device
> + *
> + * Custom settings can be defined in custom config section of the driver
> + * returns 0 or negative errno code
> + */

Maybe add a comment that the bus is expected to be locked.

> +static int mxl86110_synce_clk_cfg(struct phy_device *phydev)
> +{
> +	u16 mask = 0, value = 0;
> +	int ret = 0;
> +
> +	/*
> +	 * Configures the clock output to its default setting as per the datasheet.
> +	 * This results in a 25MHz clock output being selected in the
> +	 * COM_EXT_SYNCE_CFG register for SyncE configuration.
> +	 */
> +	value = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +			FIELD_PREP(MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK,
> +				   MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_25M);
> +	mask = MXL86110_EXT_SYNCE_CFG_EN_SYNC_E |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_SRC_SEL_MASK |
> +	       MXL86110_EXT_SYNCE_CFG_CLK_FRE_SEL;
> +
> +	/* Write clock output configuration */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_SYNCE_CFG_REG,
> +					   mask, value);
> +
> +	return ret;
> +}
> +
> +/**
> + * mxl86110_broadcast_cfg - Configure MDIO broadcast setting for PHY
> + * @phydev: Pointer to the PHY device structure
> + *
> + * This function configures the MDIO broadcast behavior of the MxL86110 PHY.
> + * Currently, broadcast mode is explicitly disabled by clearing the EPA0 bit
> + * in the RGMII_MDIO_CFG extended register.

here as well.

> + *
> + * Return: 0 on success or a negative errno code on failure.
> + */
> +static int mxl86110_broadcast_cfg(struct phy_device *phydev)
> +{
> +	int ret = 0;
> +	u16 val;
> +
> +	val = mxl86110_read_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG);
> +	if (val < 0)
> +		return val;
> +
> +	val &= ~MXL86110_EXT_RGMII_MDIO_CFG_EPA0_MASK;
> +	ret = mxl86110_write_extended_reg(phydev, MXL86110_EXT_RGMII_MDIO_CFG, val);

Could _modify_ be used here?

> +
> +	return ret;
> +}
> +
> +/**
> + * mxl86110_enable_led_activity_blink - Enable LEDs activity blink on PHY
> + * @phydev: Pointer to the PHY device structure
> + *
> + * Configure all PHY LEDs to blink on traffic activity regardless of their
> + * ON or OFF state. This behavior allows each LED to serve as a pure activity
> + * indicator, independently of its use as a link status indicator.
> + *
> + * By default, each LED blinks only when it is also in the ON state. This function
> + * modifies the appropriate registers (LABx fields) to enable blinking even
> + * when the LEDs are OFF, to allow the LED to be used as a traffic indicator
> + * without requiring it to also serve as a link status LED.
> + *
> + * NOTE: Any further LED customization can be performed via the
> + * /sys/class/led interface; the functions led_hw_is_supported, led_hw_control_get, and
> + * led_hw_control_set are used to support this mechanism.
> + *
> + * Return: 0 on success or a negative errno code on failure.
> + */
> +static int mxl86110_enable_led_activity_blink(struct phy_device *phydev)
> +{
> +	int ret, index;
> +	u16 val = 0;
> +
> +	for (index = 0; index < MXL86110_MAX_LEDS; index++) {
> +		val = mxl86110_read_extended_reg(phydev, MXL86110_LED0_CFG_REG + index);
> +		if (val < 0)
> +			return val;
> +
> +		val |= MXL86110_LEDX_CFG_TRAFFIC_ACT_BLINK_IND;
> +		ret = mxl86110_write_extended_reg(phydev, MXL86110_LED0_CFG_REG + index, val);
> +		if (ret < 0)
> +			return ret;

_modify_ ?

Getting pretty close to finished now. Thanks for keeping working on
it.

	Andrew


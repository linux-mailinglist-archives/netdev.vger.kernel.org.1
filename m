Return-Path: <netdev+bounces-190786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A9AB8C85
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F485163F22
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B521ADA4;
	Thu, 15 May 2025 16:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WmW8fGEb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEA1E9B2F;
	Thu, 15 May 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326794; cv=none; b=Nsm7uA0+DNmKX5fVHC4H5d1Km3fVWkSu11sbs+5ul3E2kJ2IaV7yEhMLM+fPE406MnJCjH21Q2Twt2wTkMUeVPYm4U2TCgOUIJ4lsPfl9S2u9QQztDc9pmQu7UphuQE+A6hQgEAaco2epmoeiWyr0GfjwPqTEW8rqLvMCtudaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326794; c=relaxed/simple;
	bh=cAlTLdOnTQlSMWI9py+ZaIg48MiaSEwnK7HNn1m0ZSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQlXCcQKIj3zhRgnjpUVg29iWlfB3s4v8xnaXSD2CaLFfqnHPp3ppAVpjX+2lYoGIlmGn845TR09VuRIgEKQ50cS6EKQUCt4YzIhCU+zEA77PNt/V+W2LFxO0KODPyUrPPSO46GN9TyZilI/i7I9AyLPXqz0byPt4n9mpBHFQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WmW8fGEb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/QeUO2a8NWeRstvM0b/MVvBVRNJC5JX4+Z5IQhDNQlQ=; b=WmW8fGEbBoAAvI1Q2qGznPJZG4
	R+C0srqjRbCmcHCple2UZPwKRZRDdC2wEsVO6EtJC2XU18fzQUcQL1Um/0IYDb54M9d/+OR9gvPV4
	k5XWYYsZD4SNQJQ1mS1Q+YDIwfGfYA6epoDym0567jJlJ1H7O0VDZQwr7s5p8UF+zkHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uFbW8-00CgS8-Id; Thu, 15 May 2025 18:33:08 +0200
Date: Thu, 15 May 2025 18:33:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefano Radaelli <stefano.radaelli21@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xu Liang <lxu@maxlinear.com>
Subject: Re: [PATCH] net: phy: add driver for MaxLinear MxL86110 PHY
Message-ID: <2b2ef0bd-6491-41a0-b2e1-81e2b83167ef@lunn.ch>
References: <20250515152432.77835-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515152432.77835-1-stefano.radaelli21@gmail.com>

> +/* only 1 page for MXL86110 */
> +#define MXL86110_DEFAULT_PAGE	0

> +/**
> + * mxl86110_read_page - Read current page number
> + * @phydev: Pointer to the PHY device
> + *
> + * Return: The currently selected page number, or negative errno on failure.
> + */
> +static int mxl86110_read_page(struct phy_device *phydev)
> +{
> +	return __phy_read(phydev, MXL86110_EXTD_REG_ADDR_OFFSET);
> +};

If there is only one page, does these make any sense?

> +static int mxl86110_write_page(struct phy_device *phydev, int page)
> +{
> +	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, page);
> +};
> +
> +/**
> + * mxl86110_write_extended_reg() - write to a PHY's extended register
> + * @phydev: pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: value to write to @regnum
> + *
> + * NOTE: This function assumes the caller already holds the MDIO bus lock
> + * or otherwise has exclusive access to the PHY. If exclusive access
> + * cannot be guaranteed, please use mxl86110_locked_write_extended_reg()
> + * which handles locking internally.
> + *
> + * returns 0 or negative error code
> + */
> +static int mxl86110_write_extended_reg(struct phy_device *phydev, u16 regnum, u16 val)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, MXL86110_EXTD_REG_ADDR_OFFSET, regnum);

This is confusing. It looks identical to mxl86110_write_page(). So
regnum is actually page?

> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_write(phydev, MXL86110_EXTD_REG_ADDR_DATA, val);

And within that page, there is a single register at address
MXL86110_EXTD_REG_ADDR_DATA?

If you keep the write_page() and read_page(), it looks like you can
replace this with

	return phy_write_paged(phydev, regnum,
	                       MXL86110_EXTD_REG_ADDR_DATA, 
                               val);
			       
> +static int mxl86110_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
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
> +		page_to_restore = phy_select_page(phydev, MXL86110_DEFAULT_PAGE);
> +		if (page_to_restore < 0)
> +			goto error;

If there is only one page, i think this can be removed. And everywhere
else in the driver.

> +	/*
> +	 * RX_CLK delay (RXDLY) enabled via CHIP_CFG register causes a fixed
> +	 * delay of approximately 2 ns at 125 MHz or 8 ns at 25/2.5 MHz.
> +	 * Digital delays in RGMII_CFG1 register are additive
> +	 */
> +	switch (phydev->interface) {
> +	case PHY_INTERFACE_MODE_RGMII:
> +		val = 0;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +		val = MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;

This should be 2000ps, or the nearest you can get to it.

> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
> +			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
> +		break;
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		val = MXL86110_EXT_RGMII_CFG1_TX_1G_DELAY_2250PS |
> +			MXL86110_EXT_RGMII_CFG1_TX_10MB_100MB_DELAY_2250PS;
> +		val |= MXL86110_EXT_RGMII_CFG1_RX_DELAY_150PS;

Same here.

> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err_restore_page;
> +	}
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_RGMII_CFG1_REG,
> +					   MXL86110_EXT_RGMII_CFG1_FULL_MASK, val);
> +	if (ret < 0)
> +		goto err_restore_page;
> +
> +	/* Configure RXDLY (RGMII Rx Clock Delay) to keep the default
> +	 * delay value on RX_CLK (2 ns for 125 MHz, 8 ns for 25 MHz/2.5 MHz)
> +	 */
> +	ret = mxl86110_modify_extended_reg(phydev, MXL86110_EXT_CHIP_CFG_REG,
> +					   MXL86110_EXT_CHIP_CFG_RXDLY_ENABLE, 1);

So does the value 1 here mean 8ns? 0 would be 2ns?

    Andrew

---
pw-bot: cr


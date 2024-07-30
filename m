Return-Path: <netdev+bounces-114199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A99414ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3659F1C22D8A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7A1A2573;
	Tue, 30 Jul 2024 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E/P1HEI4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B41A08BB;
	Tue, 30 Jul 2024 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351421; cv=none; b=mtWvMNMYT4xnky5zwsJY69RfAj0oFdWxGnTGSOkJqVK2nArJ/SgkeymO7SoAz7N4FlQY97o0D3WUCxmBDmFBAhOG0StDSHfk+SnTG5O6FfKAkFcstEENsaXX2dnkYW06u3k/nf+VkSrPAF1+1UxI2LYcTcs7whGyRDhOfm+5wjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351421; c=relaxed/simple;
	bh=ZG2BW7HRwMwlFzbDidMpWOwpAld4L9NCBDh6SnEl9C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn4wmn3XmKbkICoL0QQAh55LQjIiafzD6GKPXdcxmKXw2WenuGxxryuD/ElSVAcDfiymuhfBSpeUR/rC7KSa5SCnYrIG0x1D5nnJ6JT1HMAomwBYde7NGX07cJ8ELhHtTGPtEHb3K+6l+e1VviqQrJX+fpNkIowVK8pmFz83VCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=E/P1HEI4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hIGC36tkkIZG1tDGHIcOcd8U+y/WwlKRJN/j1gjykKo=; b=E/P1HEI4LUxjEnSegF37z23bgE
	bAWngh490Gon4qV3DvV/GC8m0ejWhVAyeSqmoF0xttdRXz+GG7tOGNxT7TZ7gyvFwto2YXTLEQs7d
	klh7Xvs5QCShAxnIPlo4BtJmFxSnjqdU15HrGNrRxwsXkbK9H4AhFJyWrlNcbDKXjgQH9Bx/2b5Mc
	ITtcYOyMxmMfw8w5rIg6EHnxkEijC9qitw7d41alJkWG+vHBNdVUj+OZ1j4vlie+LKtUy0dAiTGZp
	QvIiWqO1p8CvjaLDzMjw7h+LqrUMtGqEzXaNF8es2fMO9v2H5Jd5FckrSGBweDVScKhAZoue2NY8a
	cxdOoLZQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47874)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYoHO-0007At-08;
	Tue, 30 Jul 2024 15:56:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYoHR-0005L5-78; Tue, 30 Jul 2024 15:56:49 +0100
Date: Tue, 30 Jul 2024 15:56:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	andrew@lunn.ch, horms@kernel.org, hkallweit1@gmail.com,
	richardcochran@gmail.com, rdunlap@infradead.org,
	Bryan.Whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 07:36:18PM +0530, Raju Lakkaraju wrote:
> +	default:
> +		__set_bit(PHY_INTERFACE_MODE_RGMII,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_ID,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_RXID,
> +			  adapter->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_TXID,
> +			  adapter->phylink_config.supported_interfaces);

There's a shorter way to write this:

		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);

> +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> +{
> +	struct device_node *dn = adapter->pdev->dev.of_node;
> +	struct net_device *dev = adapter->netdev;
> +	struct fixed_phy_status fphy_status = {
> +		.link = 1,
> +		.speed = SPEED_1000,
> +		.duplex = DUPLEX_FULL,
> +	};
> +	struct phy_device *phydev;
> +	int ret;
> +
> +	if (dn)
> +		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
> +
> +	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
> +		phydev = phy_find_first(adapter->mdiobus);
> +		if (!phydev) {
> +			if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
> +			      ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
> +				phydev = fixed_phy_register(PHY_POLL,
> +							    &fphy_status,
> +							    NULL);

I thought something was going to happen with this?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


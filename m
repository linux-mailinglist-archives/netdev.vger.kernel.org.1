Return-Path: <netdev+bounces-156258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6707A05BD8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABF7163F08
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A181F8F14;
	Wed,  8 Jan 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uDvpDMLF"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6291F7589;
	Wed,  8 Jan 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340224; cv=none; b=E4AZZjGEzHLT6/MaGo3lQqMYLlw1TOTaZR+weaayudG0EW5rvw5rvFIPgG9hWcq6P0JrL7lJpN9P097gDvad/x5cAnj+ux8ChZEdWyBC/tMeL/oXTf1G9lElU9HWkV+Zdh22bWg6j0JjPDP+gy+wKVKm2h23u1nnjtYyBhzyzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340224; c=relaxed/simple;
	bh=vWCs+jTm723AZBxSf005jm1TNBb6NgGISumffZNY77c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE5PEroS48pujaS/kTBl06o+9r0gMFFsnqcfiCV/WZFGeciY5donDWIo+Fcl4eEWPCgU9Ib6ipO8mwWLC/vtvHGqkeFraP732l5ECoKFVfpe4gQg1LqkPjkXb4Yr2CKxzmIvorcBLb34bZKTK6yktzG+Y8uTrS9JVS9x6ndnngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=uDvpDMLF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D+AuAWwzlG3/KL9PcXe30ni+Jn0MyzRe507IB6zEz8k=; b=uDvpDMLFrPPi6FegNmt4Xa0BAH
	9ZC4D8vozM0TsLtKMPV5G9QHqfedpB32MOZdgQzVmSV3gqOMdwG2RjEfJupIKQYyKhNMumfu6MBJT
	tXY2W3AKBt7JrmVXnjuZidRC1oYELhvHLa9UWs+BbTUwIZdNUbUAQFdZjd8Agkcty+ZP9WWgz+7cR
	F0HS/Dpbl9zc3RNqDZXzJ2G3Pa9JtjzOZUg9ul5ImrDyE5iI9wNed5SjWOzdMRvmfqKaJLv4nY001
	hSb6mxDuEN7iH3C2l1GiJlxv5HtJQNkWOltCE8EcwzCNwbf2O13MINZnczY/qPvqq1GWLrblS0GyB
	wz0l8z5g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46968)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVVPJ-0000c5-1k;
	Wed, 08 Jan 2025 12:43:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVVPG-0006Iu-2O;
	Wed, 08 Jan 2025 12:43:30 +0000
Date: Wed, 8 Jan 2025 12:43:30 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z35y8r32QFvZKQLI@shell.armlinux.org.uk>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108121341.2689130-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 08, 2025 at 01:13:35PM +0100, Oleksij Rempel wrote:
> @@ -2508,6 +2369,207 @@ static void lan78xx_remove_irq_domain(struct lan78xx_net *dev)
>  	dev->domain_data.irqdomain = NULL;
>  }
>  
> +static void lan78xx_mac_config(struct phylink_config *config, unsigned int mode,
> +			       const struct phylink_link_state *state)
> +{
> +	struct net_device *net = to_net_dev(config->dev);
> +	struct lan78xx_net *dev = netdev_priv(net);
> +	u32 rgmii_id = 0;
> +	u32 mac_cr = 0;
> +	int ret;
> +
> +	/* Check if the mode is supported */
> +	if (mode != MLO_AN_FIXED && mode != MLO_AN_PHY) {
> +		netdev_err(net, "Unsupported negotiation mode: %u\n", mode);
> +		return;
> +	}
> +
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_INTERNAL:
> +	case PHY_INTERFACE_MODE_GMII:
> +			mac_cr |= MAC_CR_GMII_EN_;
> +		break;

The indentation has gone a bit weird here.

> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +		break;

Normally, a MAC should support all RGMII interface modes, because these
define the RGMII delays at the PHY and have little dependence on the
MAC.

> +static int lan78xx_phylink_setup(struct lan78xx_net *dev)
> +{
> +	phy_interface_t link_interface;
> +	struct phylink *phylink;
> +
> +	dev->phylink_config.dev = &dev->net->dev;
> +	dev->phylink_config.type = PHYLINK_NETDEV;
> +	dev->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
> +		MAC_10 | MAC_100 | MAC_1000FD;
> +	dev->phylink_config.mac_managed_pm = true;
> +
> +	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
> +		__set_bit(PHY_INTERFACE_MODE_RGMII,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_ID,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_RXID,
> +			  dev->phylink_config.supported_interfaces);
> +		__set_bit(PHY_INTERFACE_MODE_RGMII_TXID,
> +			  dev->phylink_config.supported_interfaces);

The mac_config implementation conflicts with this.

> +		link_interface = PHY_INTERFACE_MODE_NA;

This is supposed to be for DSA, not for general use. Is there any reason
you can't pass the real mode that is being used here?

> @@ -2576,7 +2673,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  			return -EIO;
>  		}
>  		phydev->is_internal = true;
> -		dev->interface = PHY_INTERFACE_MODE_GMII;
> +		phydev->interface = PHY_INTERFACE_MODE_INTERNAL;

This needs to be explained.

As for continuing to use fixed-phy, please instead use
phylink_set_fixed_link() instead.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


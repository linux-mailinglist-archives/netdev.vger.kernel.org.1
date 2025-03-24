Return-Path: <netdev+bounces-177119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7BA6DF6A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABCA188D7CF
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B25B26389D;
	Mon, 24 Mar 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KvetgiWQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416DA263883;
	Mon, 24 Mar 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833100; cv=none; b=rYhp0MKVjR3nwLNbnI9/SRSqMe5a4N01FBFwzJAoWrZB9Gpyhnyg2Ax3LsI7BTBYHxmKc3ndiJNeiOyqpmSteSjLhRAv1u01L1SKi3ZDF1GeLOQaJ1vXTa9cdfSyYVUgofQZyl6Gc2jsnNTaWAMmbIdQ1yGAeQVI71L5d7opBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833100; c=relaxed/simple;
	bh=2sHGA/ry/oLbba4j9oOPgiDk3EvtRBfPsp/RiJsDnzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPlDnPoFFM9YvwK6fRQLO/lPwJZb4HtCZ6ZcUU6grxkYXsIsPM2rZIdv6FI8a5TPJ1km6pqeRQKysGU/GIt6Gn9rN0n/Q1TA3tIJrQ0eq5b/pryjwxgMdd7f3tBxITL5mfdYYqjTkANtwYQiS1I1hDq+UxDWqMc/Z6oIJ69rJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=KvetgiWQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=k1rF4AjMxpu/VzA+psONaAHx7bxOfl1oo9aEdd/g99k=; b=KvetgiWQXLxfGdwA9sl33xut1y
	1Kg1qPYjj6k7mF5hy8jix8TjqNtxyc9mEtqAGl69cW+mcuJX2WpNehp1a1C0UlG4YThFzC8M7M8sV
	vfP8rp71DaaDr410zFz2jbkBBkw6eZ+0jBbIW/enHwMm4+n0trqL8RJgj/4nJ58/GeRycMbj3uj6A
	TbII/UX4ZJtHXbUpJ0P1ONeINrR9ReIu29QEyKVIN8MjRCHlQ/yGaGo0J7odgjcisqzMLFtOE4Swy
	2wBvscvi8Di18MryFchMwp4lneesFH4nMaVpkn/fcbJrlEjmllV/5jv0TrbrODMUKhRd1XVA/4+2W
	bq3vMtPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33212)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1twkV4-0003mQ-0L;
	Mon, 24 Mar 2025 16:18:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1twkV0-0002Nn-04;
	Mon, 24 Mar 2025 16:18:02 +0000
Date: Mon, 24 Mar 2025 16:18:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 2/6] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Message-ID: <Z-GFufp4uggxjjNT@shell.armlinux.org.uk>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
 <20250319084952.419051-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319084952.419051-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 09:49:48AM +0100, Oleksij Rempel wrote:
> Convert the LAN78xx driver to use the PHYlink framework for managing
> PHY and MAC interactions.
> 
> Key changes include:
> - Replace direct PHY operations with phylink equivalents (e.g.,
>   phylink_start, phylink_stop).
> - Introduce lan78xx_phylink_setup for phylink initialization and
>   configuration.
> - Add phylink MAC operations (lan78xx_mac_config,
>   lan78xx_mac_link_down, lan78xx_mac_link_up) for managing link
>   settings and flow control.
> - Remove redundant and now phylink-managed functions like
>   `lan78xx_link_status_change`.
> - update lan78xx_get/set_pause to use phylink helpers

I don't think this goes into enough detail - there's some subtle changes
going on in this patch.

>  static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>  {
> -	struct fixed_phy_status fphy_status = {
> -		.link = 1,
> -		.speed = SPEED_1000,
> -		.duplex = DUPLEX_FULL,
> -	};
>  	struct phy_device *phydev;
>  	int ret;
>  
>  	phydev = phy_find_first(dev->mdiobus);
>  	if (!phydev) {
> -		netdev_dbg(dev->net, "PHY Not Found!! Registering Fixed PHY\n");
> -		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> -		if (IS_ERR(phydev)) {
> -			netdev_err(dev->net, "No PHY/fixed_PHY found\n");
> -			return ERR_PTR(-ENODEV);
> -		}
> -		netdev_dbg(dev->net, "Registered FIXED PHY\n");
> -		dev->interface = PHY_INTERFACE_MODE_RGMII;
> +		netdev_dbg(dev->net, "PHY Not Found!! Forcing RGMII configuration\n");

dev->interface is removed.

>  		ret = lan78xx_write_reg(dev, MAC_RGMII_ID,
>  					MAC_RGMII_ID_TXC_DELAY_EN_);
>  		if (ret < 0)
> @@ -2547,7 +2545,7 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
>  			netdev_err(dev->net, "no PHY driver found\n");
>  			return ERR_PTR(-EINVAL);
>  		}
> -		dev->interface = PHY_INTERFACE_MODE_RGMII_ID;

Here too.

> +		phydev->interface = PHY_INTERFACE_MODE_RGMII_ID;

I'm not sure why this is being set here - the PHY has been found, but
hasn't had phy_connect*() or phy_attach*() called on it yet (which will
write this member of phy_device.)

> +static int lan78xx_phylink_setup(struct lan78xx_net *dev)
> +{
> +	struct phylink_config *pc = &dev->phylink_config;
> +	phy_interface_t link_interface;
> +	struct phylink *phylink;
> +
> +	pc->dev = &dev->net->dev;
> +	pc->type = PHYLINK_NETDEV;
> +	pc->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE | MAC_10 |
> +			       MAC_100 | MAC_1000FD;
> +	pc->mac_managed_pm = true;
> +
> +	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
> +		phy_interface_set_rgmii(pc->supported_interfaces);
> +		link_interface = PHY_INTERFACE_MODE_RGMII_ID;
> +	} else {
> +		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> +			  pc->supported_interfaces);
> +		link_interface = PHY_INTERFACE_MODE_INTERNAL;
> +	}

Hmm. This seems to me to be a functional change. lan78xx_phy_init() had
a switch() statement that:

1. for ID_REV_CHIP_ID_7801_, calls lan7801_phy_init().

   For a fixed PHY, sets dev->interface to PHY_INTERFACE_MODE_RGMII for
   a fixed-PHY (and it seems to configure the RGMII interface delays).

   For a normal PHY, sets dev->interface to PHY_INTERFACE_MODE_RGMII_ID
   and apparently disables the MAC-side RGMII delays.

2. for ID_REV_CHIP_ID_7800_ and ID_REV_CHIP_ID_7850_, uses GMII mode
   with an internal PHY. Maybe the internal connection is GMII. Note
   that with PHY_INTERFACE_MODE_INTERNAL, phylink will not restrict
   the speeds, whereas with PHY_INTERFACE_MODE_GMII it will.

So, I think it would make sense to first make this functional change as
a separate patch.

>  		if (IS_ERR(phydev)) {
> -			netdev_err(dev->net, "lan7801: failed to init PHY: %pe\n",
> -				   phydev);
> -			return PTR_ERR(phydev);
> +			struct phylink_link_state state = {
> +				.speed = SPEED_1000,
> +				.duplex = DUPLEX_FULL,
> +				.interface = PHY_INTERFACE_MODE_RGMII,

This member has no effect here. phylink_set_fixed_link() just
reconfigures for a fixed link as if it had been specified by firmware.
It doesn't support changing the interface at this point.

> @@ -2586,7 +2627,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
>  			return -ENODEV;
>  		}
>  		phydev->is_internal = true;
> -		dev->interface = PHY_INTERFACE_MODE_GMII;
> +		phydev->interface = PHY_INTERFACE_MODE_GMII;

Same as the case above with PHY_INTERFACE_MODE_RGMII_ID.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


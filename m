Return-Path: <netdev+bounces-211362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5EEB1831F
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CB31C2382A
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB192475F7;
	Fri,  1 Aug 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LTlvYTEs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A5231856;
	Fri,  1 Aug 2025 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754056950; cv=none; b=OlIznHHVBsd9Sfv1BnR6tnbeclZqLfhoOtgJTYNxf8QA4Okx5daaufjjVLfIjVBmsWYSelWE3BoB8Vpl95Xp9zfqQzO7kNIUVF35p1eFKIXZNnDZuyySH7T9yRoJsb/ihE3nYc08vOoLAtRyqLS2kJKtyB/UfVMgFpKcAK91JTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754056950; c=relaxed/simple;
	bh=QqcvCtixSFFwtYR8+5DVWHSJegt2tDj2u2meJXmV+hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAx4XB0IeQu2DsTMLRSfny8p8EuImwNyREvoCqr6iWYPRjWu6wBDqMFt+VsWQb3p+AuMO6mpY24thhU57QobB3h9PUHMlGpwnyxfkbWDehNzou3mp0AA9LaYP4t3RdVClTpXAU+/K/xDw9YwQwAnw3vxD2uM03aX6XRYLN/g6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LTlvYTEs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=88rh53yLjf3rT2pHHjJ3py+P2tBVYtpsWJEwN7/drwM=; b=LTlvYTEs4y+wV+tXUc3YhldOs3
	qQ0cb564ccK0rqUoao9hfcP0wpoRMDdKYD9BS6OPKGc6S53U0wOo6MEew21Yp7Mw0gib1vd6qYNCb
	Ky7IE7b2fMc+1MEq/J4SCjiciDug9QBzLnRpUWYhuHixABBJCodCpd7kezqXdXh/TOGuc+Sqqz18e
	q44i745bVTxKZi3uXNAUJ0zEIrPegPsgBuMrl3oSz3gEuefxf5Gy1G/JbXoo7pw/myI9J/Q23RMVr
	QqY5LHPoCla3qX1WqdwqKLgU/IO3QJ2u3D3QvzteuZtFxyERbdHwIqvNUiolGlWcrfz6AT0nfu44d
	bslYdFLg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41950)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhqKw-0006bd-0N;
	Fri, 01 Aug 2025 15:02:18 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhqKt-00027t-0Q;
	Fri, 01 Aug 2025 15:02:15 +0100
Date: Fri, 1 Aug 2025 15:02:14 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <aIzI5roBAaRgzXxH@shell.armlinux.org.uk>
References: <aIuEvaSCIQdJWcZx@FUE-ALEWI-WINX>
 <20250731171642.2jxmhvrlb554mejz@skbuf>
 <aIvDcxeBPhHADDik@shell.armlinux.org.uk>
 <20250801110106.ig5n2t5wvzqrsoyj@skbuf>
 <aIyq9Vg8Tqr5z0Zs@FUE-ALEWI-WINX>
 <aIyr33e7BUAep2MI@shell.armlinux.org.uk>
 <aIytuIUN+BSy2Xug@FUE-ALEWI-WINX>
 <aIyx0OLWGw5zKarX@shell.armlinux.org.uk>
 <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801130420.m3fbqlvtzbdo5e5d@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 04:04:20PM +0300, Vladimir Oltean wrote:
> On Fri, Aug 01, 2025 at 01:23:44PM +0100, Russell King (Oracle) wrote:
> > It looks like memac_select_pcs() and memac_prepare() fail to
> > handle 2500BASEX despite memac_initialization() suggesting the
> > SGMII PCS supports 2500BASEX.
> 
> Thanks for pointing this out, it seems to be a regression introduced by
> commit 5d93cfcf7360 ("net: dpaa: Convert to phylink").
> 
> If there are no other volunteers, I can offer to submit a patch if
> Alexander confirms this fixes his setup.
> 
> > It would also be good if the driver can also use
> > pcs->supported_interfaces which states which modes the PCS layer
> > supports as well.
> 
> The current algorithm in lynx_pcs_create() is too optimistic and
> advertises host interfaces which the PCS may not actually support.
> 
> static const phy_interface_t lynx_interfaces[] = {
> 	PHY_INTERFACE_MODE_SGMII,
> 	PHY_INTERFACE_MODE_QSGMII,
> 	PHY_INTERFACE_MODE_1000BASEX,
> 	PHY_INTERFACE_MODE_2500BASEX,
> 	PHY_INTERFACE_MODE_10GBASER,
> 	PHY_INTERFACE_MODE_USXGMII,
> };
> 
> 	for (i = 0; i < ARRAY_SIZE(lynx_interfaces); i++)
> 		__set_bit(lynx_interfaces[i], lynx->pcs.supported_interfaces);
> 
> I am concerned that if we add logic to the MAC driver which does:
> 
> 		phy_interface_or(config->supported_interfaces,
> 				 config->supported_interfaces,
> 				 pcs->supported_interfaces);
> 
> then we depart from the physical reality of the board and may end up
> accepting a host interface which we should have rejected.
> 
> There is downstream code which refines lynx_pcs_create() to this:
> 
> 	/* In case we have access to the SerDes phy/lane, then ask the SerDes
> 	 * driver what interfaces are supported based on the current PLL
> 	 * configuration.
> 	 */
> 	for (int i = 0; i < ARRAY_SIZE(lynx_interfaces); i++) {
> 		phy_interface_t iface = lynx_interfaces[i];
> 
> 		err = phy_validate(lynx->serdes[PRIMARY_LANE],
> 				   PHY_MODE_ETHERNET, iface, NULL);
> 		if (err)
> 			continue;
> 
> 		__set_bit(iface, supported_interfaces);
> 	}
> 
> but the infrastructure (the SerDes driver) is currently lacking upstream.

It looks like the SerDes driver is managed by the MAC (it validates
each mode against the serdes PHY driver's validate function - serdes
being mac_dev->fman_mac->serdes. If this SerDes doesn't exist, then
only mac_dev->phy_if is supported.

So, I don't think there's any need for the Lynx to reach out to the
SerDes in mainline as it currently stands.

As the SerDes also dictates which modes and is managed by fman, I'd
suggest for mainline that the code needs to implement the following
pseudocode:

	config->supported_interfaces = mac_support |
				(pcs->supported_interfaces &
				serdes_supported_interfaces);

rather than the simple "or pcs->supported_interfaces into the
supported bitmap" that we can do in other drivers.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


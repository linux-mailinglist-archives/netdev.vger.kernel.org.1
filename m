Return-Path: <netdev+bounces-178288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52139A76657
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47053A8719
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56C020FA9E;
	Mon, 31 Mar 2025 12:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IlzP0CH4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA51E32B9;
	Mon, 31 Mar 2025 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743425485; cv=none; b=f2G9tnvHaZxoHDXv+yAt1K/wAng/Cgo9J+nYponemOdVfA9Mro1WCxT2ZNGI1NNJ/aLg0PknXoh+RsXOv3NshvKYB6MTSKRazw/jg1zNm2Bobroz5S52urrh8ctqvjHKPKAFQoT0GbLAFHcIizmRIGQnNw40BkEHhb7nbXpUXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743425485; c=relaxed/simple;
	bh=o7BfxZztujt/cO63wRvOavseqgC5ImSFqXNneLm+NqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am4AlFsLpuv6SzUUSAykk9ctBjMOpykEYpVuXA/MJKFCY+xeVeVW07+/B4Tilj9MHJ053lNuzp/1SLhy9GBZitK9GNKzPJkewOdGTzTC/VjeBPRY/uQtNOLZZGnmlsM7AhA53SMo2t7mG+c6wFn4+ZHPJIWjVZehL9lpeXifDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IlzP0CH4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2eMi5/lczQNiBiqshlbN0fbzw9ejRfgeqUAlYl9qpIg=; b=IlzP0CH4jRpFhrxHnDsiF5VoSv
	TEHTcyEhjYgMq81+mdn0a/0q3NmQ/Y6q9+k1h8H99zGPsY/x1csGV3hxdrujioo8ZbqnMZKvJGGkw
	bBWMQH71eKnnTtsa67hVb83aolECGaKaU2ooRJsivkEqZZ4sweufF9HId3jlSbgHC++npXBxrO1pZ
	WVXa4d8tfsdtIEA2WiIgfYRMxsiHJfoAskGXYEcs0Z+iCAgEDTqv+nLCmHFsvnoiLT42YSPdRjx5A
	VTddXBrFHl0ivIoRDR3hiL0uqXZ7xQxb0hNDMLznNSOcPf2Xm3mAZhis/falAlUcHyltw2H9iRdx2
	RfSghQqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51288)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tzEbZ-0003zS-2D;
	Mon, 31 Mar 2025 13:51:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tzEbT-0001gK-2Q;
	Mon, 31 Mar 2025 13:50:59 +0100
Date: Mon, 31 Mar 2025 13:50:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <Z-qPs7y8C09xh5_b@shell.armlinux.org.uk>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
 <20250307173611.129125-10-maxime.chevallier@bootlin.com>
 <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Mar 27, 2025 at 06:16:00PM -0700, Alexander H Duyck wrote:
> On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote:
> > When phylink creates a fixed-link configuration, it finds a matching
> > linkmode to set as the advertised, lp_advertising and supported modes
> > based on the speed and duplex of the fixed link.
> > 
> > Use the newly introduced phy_caps_lookup to get these modes instead of
> > phy_lookup_settings(). This has the side effect that the matched
> > settings and configured linkmodes may now contain several linkmodes (the
> > intersection of supported linkmodes from the phylink settings and the
> > linkmodes that match speed/duplex) instead of the one from
> > phy_lookup_settings().
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++------------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index cf9f019382ad..8e2b7d647a92 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *pl, unsigned long *supported,
> >  	return phylink_validate_mac_and_pcs(pl, supported, state);
> >  }
> >  
> > +static void phylink_fill_fixedlink_supported(unsigned long *supported)
> > +{
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> > +}
> > +
> 
> Any chance we can go with a different route here than just locking
> fixed mode to being only for BaseT configurations?
> 
> I am currently working on getting the fbnic driver up and running and I
> am using fixed-link mode as a crutch until I can finish up enabling
> QSFP module support for phylink and this just knocked out the supported
> link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.
> 
> Seems like this should really be something handled by some sort of
> validation function rather than just forcing all devices using fixed
> link to assume that they are BaseT. I know in our direct attached
> copper case we aren't running autoneg so that plan was to use fixed
> link until we can add more flexibility by getting QSFP support going.

Please look back at phylink's historical behaviour. Phylink used to
use phy_lookup_setting() to locate the linkmode for the speed and
duplex. That is the behaviour that we should be aiming to preserve.

We were getting:

speed	duplex	linkmode
10M	Half	10baseT_Half
10M	Full	10baseT_Full
100M	Half	100baseT_Half
100M	Full	100baseT_Full
1G	Half	1000baseT_Half
1G	Full	1000baseT_Full (this changed over time)
2.5G	Full	2500baseT_Full
5G	Full	5000baseT_Full

At this point, things get weird because of the way linkmodes were
added, as we return the _first_ match. Before commit 3c6b59d6f07c
("net: phy: Add more link modes to the settings table"):

10G	Full	10000baseKR_Full
Faster speeds not supported

After the commit:
10G	Full	10000baseCR_Full
20G	Full	20000baseKR2_Full
25G	Full	25000baseCR_Full
40G	Full	40000baseCR4_Full
50G	Full	50000baseCR2_Full
56G	Full	56000baseCR4_Full
100G	Full	100000baseCR4_Full

It's all a bit random. :(

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


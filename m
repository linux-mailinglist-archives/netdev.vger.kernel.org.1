Return-Path: <netdev+bounces-177105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4EA6DE17
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A552718952C6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BA125DCE5;
	Mon, 24 Mar 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fv9IM38N"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C32A1BA;
	Mon, 24 Mar 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742829382; cv=none; b=hVWhzIPWHEwuZU/tc1qgDtPfc/0NHOvjAjQsiNi/w08XgKDhGzBxDDiCy9l28aO1x6w83IJpxi6C6w6Up9k1GpLACIT+sc19iPpAIsg09W8BVshRMWx8jkfSaolgglGlxyvUF2FxHFxr7SStcQAsqC4vqEyOvnhv5hqjzwNUpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742829382; c=relaxed/simple;
	bh=+k1cKakkWO+JUrC+4mc8eIf4cH7SWxPIOBVibOCqAt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDoB40j5FJ3f53moK/eG+tcb0r207C7By9Fq+gMWCNlVzYO7n5VTElmK6vtdAqGrjKMtAShHSbob1eCpsnAZ26NgRdJM5802OwptswDaVXyF7+OWGgJrqpTy/Ot8pWjLUgXcgpdtPbM+WpIFh37eV24pdcEWKbqdICxFOqvxDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fv9IM38N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0Dt/GbJFL6z66qSFCfJ9UMYRHuF6cQRIVIsOQs7uzes=; b=fv9IM38NAOZiKUnzpy7iBTXGyb
	yhU2YWQlUybg4PrcpaBygI79FtYTyoWqXctRjyFm8mAcBn1fowdjotI7OtKxD3tex/cJOrW8ek/ar
	39Gx7hgjy7D+RlrKpsjp8sa6c/1RerlZIebLkKw1WqQpXui31wl5CSAqJrDiPw0rA8Z0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1twjX7-006wrQ-20; Mon, 24 Mar 2025 16:16:09 +0100
Date: Mon, 24 Mar 2025 16:16:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
 <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e1692c.050a0220.2b4ad0.c073@mx.google.com>

On Mon, Mar 24, 2025 at 03:16:08PM +0100, Christian Marangi wrote:
> On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > > before the firmware is loaded.
> > 
> > Does the value change after the firmware is loaded? Is the same
> > firmware used for all variants?
> >
> 
> Yes It does... Can PHY subsystem react on this? Like probe for the
> generic one and then use the OPs for the real PHY ID?

Multiple thoughts here....

If the firmware is in SPI, i assume by the time the MDIO bus is
probed, the PHY has its 'real' IDs. So you need entries for those as
well as the dummy ID.

I think this is the first PHY which changes its IDs at runtime. So we
don't have a generic solution to this. USB and PCI probably have
support for this, so maybe there is something we can copy. It could be
they support hotplug, so the device disappears and returns. That is
not really something we have in MDIO. So i don't know if we can reuse
ideas from there.

When the firmware is running, do the different variants all share the
same ID? Is there a way to tell them apart. We always have
phy_driver->match_phy_device(). It could look for 0x75007500, download
the firmware, and then match on the real IDs.

> > > +++ b/drivers/net/phy/Kconfig
> > > @@ -121,6 +121,18 @@ config AMCC_QT2025_PHY
> > >  
> > >  source "drivers/net/phy/aquantia/Kconfig"
> > >  
> > > +config AS21XXX_PHY
> > > +	tristate "Aeonsemi AS21xxx PHYs"
> > 
> > The sorting is based on the tristate value, so that when you look at
> > 'make menuconfig' the menu is in alphabetical order. So this goes
> > before aquantia.
> > 
> 
> Tought it was only alphabetical, will move.

Yes, it is not obvious, it should have a comment added at the top.
But the top is so far away, i guess many developers would miss it
anyway.

> > > +static int as21xxx_get_features(struct phy_device *phydev)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = genphy_read_abilities(phydev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
> > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> > > +			   phydev->supported);
> > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > > +			   phydev->supported);
> > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> > > +			   phydev->supported);
> > 
> > Does this mean the registers genphy_read_abilities() reads are broken
> > and report link modes it does not actually support?
> > 
> > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > +			 phydev->supported);
> > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > +			 phydev->supported);
> > 
> > and it is also not reporting modes it does actually support? Is
> > genphy_read_abilities() actually doing anything useful? Some more
> > comments would be good here.
> > 
> > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > > +			 phydev->supported);
> > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> > > +			 phydev->supported);
> > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> > > +			 phydev->supported);
> > 
> > Does this mean genphy_c45_pma_read_abilities() also returns the wrong
> > values?
> > 
> 
> Honestly I followed what the SDK driver did for the get_feature. I will
> check the register making sure correct bits are reported.
> 
> Looking at the get_status It might be conflicting as they map C22 in C45
> vendor regs.

If all the registers used for automatic feature detection are broken,
just comment on it and don't use genphy_read_abilities() etc.

> > > +static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
> > > +{
> > > +	int status;
> > > +
> > > +	*bmcr = phy_read_mmd(phydev, MDIO_MMD_AN,
> > > +			     MDIO_AN_C22 + MII_BMCR);
> > > +	if (*bmcr < 0)
> > > +		return *bmcr;
> > > +
> > > +	/* Autoneg is being started, therefore disregard current
> > > +	 * link status and report link as down.
> > > +	 */
> > > +	if (*bmcr & BMCR_ANRESTART) {
> > > +		phydev->link = 0;
> > > +		return 0;
> > > +	}
> > > +
> > > +	status = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
> > 
> > No MDIO_AN_C22 + here? Maybe add a comment about which C22 registers
> > are mapped into C45 space.
> >
> 
> Nope, not a typo... They took the vendor route for some register but for
> BMSR they used the expected one.
> 
> Just to make it clear, using the AN_C22 wasn't a choice... the C45 BMCR
> reports inconsistent data compared to the vendor C22 one.

Comments would be good.

Is there an open datasheet for this device?

	 Andrew


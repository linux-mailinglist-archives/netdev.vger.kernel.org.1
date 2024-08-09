Return-Path: <netdev+bounces-117204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDB194D11B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706E61F2145F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F2C194C8D;
	Fri,  9 Aug 2024 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="48teUsHm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87751957FF;
	Fri,  9 Aug 2024 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209694; cv=none; b=LUeJfm30Bp752LKYIiscPj4c3bnLezIjRaEMkwqJiHexwfdjwrl1Q1ffFZGyb1PY6FIqunPwN2djGN2OqPjBLeDKp2rmosEh52JM1osm7h9RLl96us3SC7PNYw2wFYI+M0FNzg1VRem+qiGGGX+f1px9cjLiWAjuG3Lp0bG57QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209694; c=relaxed/simple;
	bh=uaWrmKfdlp08h4LImLDnqKG4lh1zZEe9v6J8JQG8DWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkitb6MNriqFu18FXc6kIQ0JwVB2Kbxslko2d5r5cMnMo7Dww0Aq1l8Lw4VuS/6AhIANsYOSL85anIym0+/m5B7IxR4SbMD6y4bIGw3JL3tIM4Dj17KrzE303/LXmZZKvTPJgYmjhkzPIXBpSV6cn/7wg1NlHecDsQUzQ/RTVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=48teUsHm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qXJQWKapDAVP5jZSgfm2qajWJklwAeB017mC5jJNkuA=; b=48teUsHmRPeZEGgsZx2SmCpep7
	X7yR8KU6aqTmyyJ32STj6F6X1Fk3uXhyLos6953CtBGXwh661YeANUNIGtrC29TIL2262CbeqyuIp
	39jVrMekTE6JHYuW8oO+nu+c7qlTTeV4bp+TfQEPpKGcAQbgtOSuwr+YGj8AKXuojsns=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scPYU-004NYc-1K; Fri, 09 Aug 2024 15:21:18 +0200
Date: Fri, 9 Aug 2024 15:21:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya.Koppera@microchip.com
Cc: linux@armlinux.org.uk, Arun.Ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: microchip_t1: Adds support for
 LAN887x phy
Message-ID: <ff514ba1-61c1-45ff-a3bd-c5ca1f8b744d@lunn.ch>
References: <20240808145916.26006-1-Divya.Koppera@microchip.com>
 <ZrS3m/Ah8Rx7tT6H@shell.armlinux.org.uk>
 <CO1PR11MB4771395A5D050DC1662E3C08E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB4771395A5D050DC1662E3C08E2BA2@CO1PR11MB4771.namprd11.prod.outlook.com>

> > On Thu, Aug 08, 2024 at 08:29:16PM +0530, Divya Koppera wrote:
> > > +static int lan887x_config_init(struct phy_device *phydev) {
> > > +     /* Disable pause frames */
> > > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev-
> > >supported);
> > > +     /* Disable asym pause */
> > > +     linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> > > +phydev->supported);
> > 
> > Why is this here? Pause frames are just like normal ethernet frames, they only
> > have meaning to the MAC, not to the PHY.
> > 
> > In any case, by the time the config_init() method has been called, the higher
> > levels have already looked at phydev->supported and made decisions on
> > what's there.
> > 
> 
> We tried to disable this in get_features.
> These are set again in phy_probe API.
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/phy/phy_device.c#n3544
> 
> We will re-look into these settings while submitting auto-negotiation patch in future series.

Let me see if i understand this correctly. You don't have autoneg at
the moment. Hence you cannot negotiate pause. PHYLIB is setting pause
is supported by default. Ethtool then probably suggests pause is
supported, if the MAC you are using is not masking it out.

Since pause frames are just regular frames, the PHY should just be
passing them through. So you should be able to forced pause, rather
than autoneg pause:

ethtool --pause eth42 autoneg off] rx on tx on

assuming the MAC supports pause.

Does this still work if you clear the PUASE bits from supported as you
are doing? Ideally we want to offer force paused configuration if the
MAC supports it.

> > > +static int lan887x_config_aneg(struct phy_device *phydev) {
> > > +     int ret;
> > > +
> > > +     /* First patch only supports 100Mbps and 1000Mbps force-mode.
> > > +      * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
> > > +      */
> > > +     if (phydev->autoneg != AUTONEG_DISABLE) {
> > > +             /* PHY state is inconsistent due to ANEG Enable set
> > > +              * so we need to assign ANEG Disable for consistent behavior
> > > +              */
> > > +             phydev->autoneg = AUTONEG_DISABLE;
> > 
> > If you clear phydev->supported's autoneg bit, then phylib ought to enforce
> > this for you. Please check this rather than adding code to drivers.
> 
> Phylib is checking if advertisement is empty or not, but the feature is not verified against supported parameter.
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/phy/phy.c#n1092
> 
> But in the following statement phylib is updating advertising parameter.
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/phy/phy.c#n1113
> 
> This is making the feature enabled in driver, the right thing is to fix the library.
> We will fix the phylib in next series.

I'm not too surprised you are hitting such issues. Not actually
supporting autoneg is pretty uncommon, and is not well tested. Thanks
for offering to fix this up.

    Andrew


Return-Path: <netdev+bounces-134307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CB998ADC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F11F23B77
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236E31E503C;
	Thu, 10 Oct 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rKRYErHl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D51CCB28;
	Thu, 10 Oct 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572330; cv=none; b=TqI0+nmZDyvNRLO12FwT5sDzSMzSQPHak+E1XRRbHY9b1Ut3C8/WE9wNpBI0QTVcBxLPIE/Nameu+/YHrGyCPkABgsCXriKbl3IH9jJNVfZO45JWMG5DUIfuSMUdvmlx7yFvZFrP/qKYehJ4Yan19wV+aFw2bXTLcq++Tz0b070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572330; c=relaxed/simple;
	bh=LkNreuEKrfO5yCLRU/1inabR73pxcdc1n6qjTmelvzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwW3jFYj9mw+m7fIb7Q01nS8Imf5jyT7SNNgbz6Sse2HKpliH9ZarsjyI8m14qj8//aTCf/r/sA4tlBeAXFzt1+vGG7oXvnG2rbOxU1mvbeFJS9Xf8oZCE3NGcrhEywAsquciKm43B0al5BaVEJ9WeBzoMplsDVfoYCwxqNHOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rKRYErHl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=d/u9bBb4C5ou7VYQcm4wbZNXsFv//k6s5ihYRORmie8=; b=rKRYErHliWOIPaur8xI8raT+Rt
	A/YDZ6liqoP/+nUl2NGxD3qOHM6Dx3xgNCWkOvrQgvAjjmrxNUfzzG2teK6YzvD9nLkG3y18EKI5e
	byDhF745Bk6DYlOdNQNRa0Txe82eeLf0lMZKETHcHjexifamNrT7TXezJ8cZxp2p3UoBVu5sx3Fme
	gv5CQl8Clm9LEWsUcqZJPFQxXSO3EuXtB9lHLbnniKSWLu+PXhu+3s72pGpditOExR/qOnzWp9rFb
	o9LGX1l3zftj3hM+WTGcMGpS9a1CUMy//9eqPMQET4icCBmPZR45ZCmbk/ZoHIEniAT4eERfAaiAb
	e+ZTXuog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39492)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syuch-0002aZ-0p;
	Thu, 10 Oct 2024 15:58:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syuce-0007PQ-34;
	Thu, 10 Oct 2024 15:58:36 +0100
Date: Thu, 10 Oct 2024 15:58:36 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwfrnFpqTlt0GnMn@shell.armlinux.org.uk>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
 <ZwbQ-thwDxPfqGnW@makrotopia.org>
 <Zwbjlln3X5RXTt8x@shell.armlinux.org.uk>
 <Zwb2RzOQXd2Wfd6O@makrotopia.org>
 <ZwcQZmR0Q40ugXI7@shell.armlinux.org.uk>
 <ZwffopLK0x26n206@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwffopLK0x26n206@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Oct 10, 2024 at 03:07:30PM +0100, Daniel Golle wrote:
> > Note that this interface switching mechanism was introduced early on
> > with the 88x3310 PHY, before any documentation on it was available,
> > and all that was known at the time is that the PHY switched between
> > different MAC facing interface modes depending on the negotiated
> > speed. It needed to be supported, and what we have came out of that.
> > Legacy is important, due to the "no regressions" rule that we have
> > in kernel development - we can't go breaking already working setups.
> 
> What about marking Ethernet drivers which are capable of interface
> mode switching? Right now there isn't one "correct" thing to do for
> PHY drivers, which is bad, as people may look into any driver as
> a reference for the development of future drivers.
> 
> So why not introduce a MAC capability bit? Even dedicated for switching
> between two specific modes (SGMII and 2500Base-X), to avoid any
> ambiguitities or unnecessary feature-creep.

They already have a perfectly good way to do this today. They can look
at DT and set just one mode in the ->supported_interfaces bitmap if
they don't support interface switching! The MAC drivers are already
responsible for parsing the phy-mode from firmware, and it's that
driver that also knows whether it knows if it supports interface
switching or not. So I don't see any need for additional capability
bits.

> Typically switching between modes within the same PCS is more easy to
> support, switching from 10:8 to 66:64 coding can be more involved,
> and require resets which affect other links, so that's something
> worth avoiding unless we really need it (in case the users inserts
> a different SFP module it would be really needed, in case the external
> link goes from 5 Gbit/s to 2.5 Gbit/s it might be worth avoiding
> having to switch from 5GBase-R to 2500Base-X)
> 
> It wouldn't be the first time something like that would be done, however
> I have full understanding that any reminder of that whole
> legacy_pre_march2020 episode may trigger post-traumatic stress in netdev
> maintainers.

Yes, and it's still continuing to cause problems today. I've just
replied to someone working on the macb driver who was proposing to
make use state->speed in his mac_config() method, despite modern
phylink always passing SPEED_UNKNOWN for that. I guess if I didn't
reply, he'd find out the hard way (which is why I made the change
to phylink_mac_config() to cause testing failures if people try
that.)

> > > The SFP case is clear, it's using host_interfaces. But in the built-in
> > > case, as of today, it always ends up in fixed interface mode with
> > > rate matching.
> > 
> > "always rate matching" no. Fixed interface mode, yes. If
> > rtl822xb_config_init() sees phydev->interface is set to SGMII, then
> > it uses 2500BASEX_SGMII mode without rate matching - and the
> > advertisement will be limited to 1G and below which will effectively
> > prevent the PHY using 2.5G mode - which is fine in that case.
> 
> While that case might be relevant for SFP modules, in pracise, why would
> anyone use a more expensive 2.5Gbit/s PHY on a board which only supports
> up to 1Gbit/s -- that doesn't happen in the real world, because 1Gbit/s
> SGMII PHYs are ubiquitous and much cheaper than faster ones.

I'm merely stating the logic that is there today.

> > > Let me summarize:
> > >  - We can't just assume that every MAC which supports 2500Base-X also
> > >    supports SGMII. It might support only 2500Base-X, or 2500Base-X and
> > >    1000Base-X, or the driver might not support switching between
> > >    interface modes.
> > >  - We can't rely on the PHY being pre-configured by the bootloader to
> > >    either rate maching or interface-switching mode.
> > >  - There are no strapping options for this, the only thing which is
> > >    configured by strapping is the address.
> > 
> > Right, so the only _safe_ thing to do is to assume that:
> > 
> > 1. On existing PHY drivers which do not do any kind of interface
> > switching, retrofitting interface switching of any kind is unsafe.
> 
> It's important to note that for the RealTek driver specifically we
> have done that in OpenWrt from day 1 -- simply because the rate-matching
> performed, especially by early versions of the PHY, is too bad. So we
> always made the driver switch interface to SGMII in case of link speeds
> slower than 2500M.
> Now, with the backport of upstream commits replacing our downstream
> patches, users started to complain that the issue of bad PHY performance
> in 1 Gbit/s mode has returned, which is the whole reason why I started
> to work on this issue.
> 
> I understand, however, there may of course be other users of those
> RealTek 2.5G PHYs, even Rockchip with stmmac maybe, and that would
> break if we assume the MAC can support switching between 2500Base-X
> and SGMII, so users of those boards will have to live with the bad
> performance of the rate-matching performed by the PHY unless someone
> fixes the stmmac driver...

If OpenWRT's switching predates July 2017, then maybe they should've
been more pro-active at getting their patches upstream?

Unfortunately, in July 2017, there was nothing in mainline supporting
2500base*, and nothing doing any interface switching until I added
the Marvell 88x3310 driver which was where _I_ proposed interface
switching being added to phylib.

> > 2. On brand new PHY drivers which have no prior history, there can
> > not be any regressions, so implementing interface switching from
> > the very start is safe.
> > 
> > The only way out of this is by inventing something new for existing
> > drivers that says "you can adopt a different behaviour" and that
> > must be a per-platform switch - in other words, coming from the
> > platform's firmware definition in some way.
> 
> Why would it not just be the MAC driver which indicates that it can
> support switching to lower-speed interface modes it also supports?
> Do you really believe there are boards which are electrically
> unfit for performing SGMII on the traces intended for 2500Base-X?

For a single-lane serdes, what you say is true. However, it is not
universal across all interface modes.

As I stated in a previous discussion, if we have e.g. four lanes of
XAUI between a PHY and MAC, and both ends support XAUI, RXAUI,
10GBASE-R, 5GBASE-R, 2500BASE-X, and SGMII, it does not necessarily
follow that the platform can support 10GBASE-R and 5GBASE-R over
a single lane because the signalling rate is so much higher. Just
because the overall speed is the same or lower does not automatically
mean that it can be used.

> If by 'firmware' you mean 'device tree' then we are back on square
> one, and we would need several phy-connection-type aka. phy-mode
> listed there.
> 
> After having read all the threads from 2021 you have provided links for,
> I believe that maybe an additional property which lists the interface
> modes to be used *optionally* and in addition to the primary (ie.
> fastest) mode stated in phy-mode or phy-connection-type could be a way
> out of this. It would still end up being potentially a longer list of
> interface modes, but reality is complex! Looking at other corners of DT
> it would still be rather simple and human readable (in contrast: take a
> look at inhumanly long arrays of gpio-line-names where even the order
> matters, for example...)
> 
> Yet, it would still be a partial violation of Device Tree rules because
> we are (also) describing driver capabilities there then. What if, let's
> say one day stmmac *will* support interface mode switching? Should we
> update each and every board's device tree?

Well, I guess we need people that adopt phylink to actually implement
it properly rather than just slapping it into their driver in a way
that "works for them". :)

This is a battle that I've been trying for years with, but programmers
are lazy individuals who don't want to (a) read API documentation, (b)
implement things properly.

Anyway, I'm out of time right now to continue replying to this
conversation (it's taken over an hour so far to put what I've said
together, and I now have a meeting... so reached the end of what I can
do right now... so close to the end of your email too! Alas...

> 
> Hence, unless there is a really good reason to believe that a board which
> works fine with 2500Base-X would not work equally well with SGMII, given
> that both the MAC (-driver) and PHY (-driver) support both modes, I don't
> see a need to burden firmware with having to list additional phy-modes.
> 
> Of course, I'm always only talking about allowing switching to slower
> interface modes, and always only about modes which use a single pair
> differential lanes (ie. sgmii, 1000base-x, 2500base-x, 5gbase-r,
> 10gbase-r, ...). 
> 
> > > > > Afaik, practially all rate-matching PHYs which do support half-duplex
> > > > > modes on the TP interface can perform duplex-matching as well.
> > > > 
> > > > So we should remove that restriction!
> > > 
> > > Absolutely. That will solve at least half of the problem. It still
> > > leaves us with a SerDes clock running 2.5x faster than it would have to,
> > > PHY and MAC consuming more energy than they would have to and TX
> > > performance being slightly worse (visible with iperf3 --bidir at least
> > > with some PHYs). But at least the link would come up.
> > 
> > It also means we move forward!
> 
> ACK. Patch posted.
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


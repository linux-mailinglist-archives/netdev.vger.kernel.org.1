Return-Path: <netdev+bounces-146615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCA69D492E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662B0B2399F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 08:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F51CEAA7;
	Thu, 21 Nov 2024 08:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8891CD20B
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178864; cv=none; b=e8WtSnZ512kSg4/GEoZ3sEHcIuDhuTWocJRxeE2kgKLH+M8X+sQx5q2oPHObJgR4K23MfI+zUwFWplnSCayN8MjHvQw1/vlZoXNhI32h/9kuT55sJef+sBiIPIIIqZudmH3joifJKeDHGD1p7ZoJZrUHlru81cuRIDJGVBYCeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178864; c=relaxed/simple;
	bh=pKEsHqJJ7aaw2tPZIhiHso+cyco0KW5Z1F1FUBWFoC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtarG7gUardah5udIT/uRHe0554ha0r+zVWI8AWD78FAj1UKwe7+g2r6OoaJgvDF/+MrHTOjaxujI5B/CDtxN4yFuDrjlZ/N4rpDZ4bTb8C+B2FbRfJ8faB9N3PizlvleMbc3Sp1tz2ukC8ap3C2SHeVAR7qYNOOiGcMdA45/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tE2qi-00026n-RD; Thu, 21 Nov 2024 09:47:40 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tE2qh-001sKs-0v;
	Thu, 21 Nov 2024 09:47:39 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tE2qh-00734Z-0a;
	Thu, 21 Nov 2024 09:47:39 +0100
Date: Thu, 21 Nov 2024 09:47:39 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Moving forward with stacked PHYs
Message-ID: <Zz7zqzlDG40IYxC-@pengutronix.de>
References: <20241119115136.74297db7@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241119115136.74297db7@fedora.home>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Maxime,

On Tue, Nov 19, 2024 at 11:51:36AM +0100, Maxime Chevallier wrote:
> Hi Netdev,
> 
> With Romain, we're currently trying to work on the stacked PHY problem,
> where we'd like to get a proper support for Copper SFPs that are driven
> by a media converter :
> 
>      RGMII       SGMII  +sfp----+
> MAC ------- PHY ------- | PHY   |
>                         +-------+
> 
> This is one of the cases where we have multiple PHYs on the link, on my
> side I've been working on PHY muxes with parallel PHYs on the link :
> 
> 
>        +-- PHY
> MAC ---|
>        +-- PHY
>        
> Both of these use-cases share one common issue, which is that some parts
> of the kernel will try to directly access netdev->phydev, assuming there's
> one and only PHY device that sits behind a MAC.
> 
> In the past months, I've worked on introducing the phy_link_topology, that
> keeps track of all the PHYs that are sitting behind a netdev, and I've
> used that infrastructure for some netlink commands that would access
> the netdev->phydev field and replace that with :
>   - A way to list the PHYs behind a netdev
>   - Allowing netlink commands to target a specific PHY, and not "just"
>     the netdev->phydev PHY.
>     
> On that front, there's more work coming to improve on that :
>   - It would be good if the stats reported through ethtool would account
>     for all the PHYs on the link, so that we would get a full overview
>     of all stats from all components of the link

Ack, i'm working right now on the standardized PHY stats. With some work on
kernel side it would be possible to get with something like this:
ethtool -S eth1 --all-groups

>   - A netlink notification to indicate that a new PHY was found on the
>     link is also in the plans.

This will be cool. I was thinking about netlink notification for some
health issues, to avoid polling on the user side.

> There's a lot more work to do however, as these user-facing commands aren't
> the only place where netdev->phydev is used.
> 
> The first place are the MAC drivers. For this, there seems to be 2 options :
> 
>  - move to phylink. The phylink API is pretty well designed as it makes
>    the phydev totally irrelevant for the MAC driver. The MAC driver doesn't
>    even need to know if it's connected to a PHY or something else (and SFP
>    cage for example). That's nice, but there are still plenty of drivers
>    that don't use phylink.

This would be nice, but this is too much work. Last week I was porting lan78xx
to PHYlink. Plain porting is some hours of work, the 80% of time is
testing and fixing different issues. I do no think there are enough
resources to port all of drivers.

>  - Introduce a new set of helpers that would abstact away the phydev from
>    the netdev, but in a more straightforward way. MAC drivers that directly
>    access netdev->phydev to configure the PHY's internal state or get some
>    PHY info would instead be converted to using a set of helpers that will
>    take the netdev as a parameter :
>    
>  static void ftgmac100_adjust_link(struct net_device *netdev)
>  {

> +	int phy_link, phy_speed, phy_duplex;
>  	struct ftgmac100 *priv = netdev_priv(netdev);
>  	struct phy_device *phydev = netdev->phydev;
>  	bool tx_pause, rx_pause;
>  	int new_speed;
>  
> +	netdev_phy_link_settings(netdev, &phy_link, &phy_speed, &phy_duplex);
> +
>  	/* We store "no link" as speed 0 */
> -	if (!phydev->link)
> +	if (!phy_link)
>  		new_speed = 0;
>  	else
> -		new_speed = phydev->speed;
> +		new_speed = phy_speed;
> [...]
> 
>    The above is just an example of such helpers, Romain is currently
>    investigating this and going over all the MAC drivers out there to
>    assess to what extent they are directly accessing the netdev->phydev,
>    and wrapping that with phydev-independent helpers.
> 
>    The idea here is to avoid accessing phydev directly from the MAC
>    driver, and have a helper query the parameters for us. This helper
>    could make use of netdev->phydev, but also use phy_link_topology
>    to get an aggregated version of these parameters, if there are chained
>    PHYs for example.

Sounds good, introduce the helper and rename net->phydev to something
different. This should explode everything what is using net->phydev
directly.

> There are other parts of the kernel that accesses the netdev->phydev. There
> are a few places in DSA where this is done, but the same helpers as the ones
> introduced for MAC drivers could be used. The other remaining part would
> be the Timestamping code, but Köry Maincent is currently working on an
> series to help deal with the various timestamping sources, that will also
> help on removing this strong netdev->phydev dependency.
>    
> Finally, there's the whole work of actually configuring the PHY themselves
> correctly when they are chained to one another, and getting the logic right
> for the link-up/down detection, getting the ksettings values aggregated
> correctly, etc.
> 
> We have some local patches as well for that, to handle the stacked PHY
> state-machine synchronisation, link-reporting and negociation but
> it's still WIP to cover all the corner-cases and hard-to-test features, for
> example how to deal with WoL or EEE in these situations.

I assume, even with stacked PHYs, some kind of power management would
be needed. The WoL is probably less interesting, since all attached PHYs are
under linux control, so we can suspend or resume them.

The EEE on other hand, may help to reduce run time power consumption.
Still, it the user space should know about it, since it may be critical
for time critical tasks.

I guess, we would need some kind of PHY related metadata. For example,
MAC triggered EEE, would add some latency, but should work fine with
PTP. PHY backed EEE (like SmartEEE, etc) would add latency and affect
PTP if time stamps are made by the MAC and not by the PHY. All of this
information is HW specific. But, I assume, it is not withing the scope
of your current work.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


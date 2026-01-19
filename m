Return-Path: <netdev+bounces-251045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE05D3A5D8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2777C300CCCE
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B933DEF3;
	Mon, 19 Jan 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wk1nGg+b"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE03090E4;
	Mon, 19 Jan 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768819945; cv=none; b=es5p1ff6PuPxqt2gfB6E0d9AzUpBfsomsEmvpwku2DAM0A76cyC6NXnB1K/7q1EV0rKZe8qqkLx7p6SsaAao+GCRnPPui5brl6HtW1h0qLt+GgZFVo9L52jnn3nfDwng7ZArlIFVVkr7B2b+aYuPCWxIytWAWIaNB6EpvHhs6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768819945; c=relaxed/simple;
	bh=KTk7rBsdF55q5dIDdnFErwwiNSSTQc6Ru37W5lcxSpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGmqQBkoL4LvvEBCurK4S1AZI8HJ7YKMmg8Cgfn2o3JtlCulxWmrGKeD2QgkHUXsJmVXVhCr28eUs82jy/Twg6DeKOAp3+W/Us76Byl32SrmHeQ90fr3Y7wxp4+6okhSM0Btg4yGz13VzjFYxPsLgfmRvsHuIbGYyYer9xn6p24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wk1nGg+b; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jkfog8orQPAtXcrla4R7RaKKejAgfkvHzC7VCvoMVmw=; b=wk1nGg+bvub1hSX+niZ5Zw1nFO
	DuMBxTDq17WtgjC22tWprZw3Wli6Tn1nWTrX6NzMsr/wuL0WDVXh4VBKMNA8KrZz/la/hkY2c/y8h
	Iboor2mHlrjdcOW1fen0QTvx86aygSXOpEYw6TnDQnIkxLDi0o9cYiNBhdBGh1w5OyPuohZtP7B16
	VtgfUV6NjjQbR4KucjRw4HoTZxLmutpd64Z1cRku0oCmxoPilSwjv/v3bqjZn9b6+9uZxa8C/3J+k
	8jCHpc6CqG6FIMaOFfLIwsmut6cmp8tP/IIz/VOjl+bNPCNiiBehBEdcTq/uSuVU7979jwb5o0OnT
	cv/7jIoQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vhmrq-000000004tb-3vX5;
	Mon, 19 Jan 2026 10:52:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vhmrp-000000006Uc-2khF;
	Mon, 19 Jan 2026 10:52:17 +0000
Date: Mon, 19 Jan 2026 10:52:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Message-ID: <aW4M4TqdHtEH10U1@shell.armlinux.org.uk>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
 <aVfOW3y0LTcwQncB@shell.armlinux.org.uk>
 <c2b6af56-57f7-4658-9e6f-e671be19e300@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2b6af56-57f7-4658-9e6f-e671be19e300@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 19, 2026 at 08:30:12AM +0000, Josua Mayer wrote:
> Hi Russell,
> 
> Thank you for the extensive feedback!
> 
> On 02/01/2026 15:55, Russell King (Oracle) wrote:
> > On Fri, Jan 02, 2026 at 12:47:06PM +0000, Russell King (Oracle) wrote:
> >> I do have patches that add phydev->supported_interfaces which are
> >> populated at probe time to inform phylink which host interface modes
> >> that the PHY can be reconfigured between - and this overrides the
> >> linkmode-derivation of that information - it basically becomes:
> >>
> >>          phy_interface_and(interfaces, phy->supported_interfaces,
> >>                            pl->config->supported_interfaces);
> >>          interface = phylink_choose_sfp_interface(pl, interfaces);
> >>          if (interface == PHY_INTERFACE_MODE_NA) {
> >>                  phylink_err(pl, "selection of interface for PHY failed\n");
> >>                  return -EINVAL;
> >>          }
> >>
> >>          phylink_dbg(pl, "copper SFP: chosen %s interface\n",
> >>                      phy_modes(interface));
> >>
> >>          ret = phylink_attach_phy(pl, phy, interface);
> >>
> >> and phylink_attach_phy() will result in the PHY driver's config_init
> >> being called, configuring the appropriate operating mode for the
> >> PHY, which can then be used to update phydev->supported as appropriate.
> >>
> >> phylink will then look at phydev->supported once the above has
> >> completed when it will do so in phylink_bringup_phy().
> >>
> >> Deriving the host side PHY interface mode from the link modes has
> >> always been rather sketchy.
> > These patches can be found at:
> >
> > http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue
> >
> > See:
> >
> > net: phylink: use phy interface mode bitmaps for SFP PHYs
> > net: phy: add supported_interfaces to Aquantia AQR113C
> > net: phy: add supported_interfaces to marvell10g PHYs
> > net: phy: add supported_interfaces to marvell PHYs
> > net: phy: add supported_interfaces to bcm84881
> > net: phy: add supported_interfaces to phylib
> >
> > The reason I didn't end up pushing them (they're almost six years old)
> > is because I decided that the host_interfaces approach wasn't a good
> > idea, and dropped those patches. Marek Behún took my patches for
> > host_interfaces and they were merged in 2022. I had already junked
> > the host_interfaces approach.
> >
> > The problem is that we now have two ways that PHY drivers configure
> > their interface mode - one where config_init() decides on its own
> > based on the host_interfaces supplied to it, and this approach above
> > where phylink attempts to choose the interface based on what the
> > PHY and host (and datapath) can support. These two approaches are
> > mutually incompatible if we get both phylink _and_ the PHY driver
> > attempting to do the same thing.
> 
> All this left me puzzled.
> 
> I understand that .features / get_features happens too early
> and doesn't account for different host interfaces.
> 
> Further populating supported bitmask before config_init is wrong
> at least for this module where supported link-modes are different
> per host interface.
> 
> The marvell10g.c driver which now uses the host_interfaces bitmask
> is now extending the supported_interfaces bitmask in config_init.
> Yet I didn't understand what it means.
> 
>  From phy.h:
> 
>   * @possible_interfaces: bitmap if interface modes that the attached PHY
>   *             will switch between depending on media speed.

Note, I said *supported* not *possible*. They're two different things.

The supported mask is the list of interfaces that the PHY has support
for e.g. 88x3310 can support 10GBASE-R, 5GBASE-R, 2500BASE-X, SGMII,
USXGMII, and a few others that I can't recall off the top of my head.
This needs to be known before attaching to the PHY to allow the
operating mode to be chosen.

The possible mask is "we've configured it for this operating mode,
now which of those interfaces will we switch between depending on the
media"

Both are the host side.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-155009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB3CA00A3A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8DE3A050B
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3A190486;
	Fri,  3 Jan 2025 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="16zOfslP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B90188904
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735913033; cv=none; b=Pt6hmqqrUgIF6bjaiZShgHNZCFci0zqY1h/2ZCr6UdSAF2DduBAApR3OilkqE/QPkGmCoONhzuOAiBn23yQT0N6FgLDxIy+l3x8Aa88yRB1unbRdMLx4jI5LRMXrGKkNZ0SyXvZ0X9HHZ7QyNdrX6/o+PTpxNlNByaWFkQ79ZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735913033; c=relaxed/simple;
	bh=W1110qGY6v+84NcyJpli+ou8dyQCBL6kPllMLiWlc7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEMYHvbHLI5B3KFZkCqnvnpm6uLovjQpkx2vUoogjlKTmvc9D7LdZsPKjjz/KmHNXvQcWtRKvy25zpepZqQt6SXhMUoieD4/V6wAb7Z/7prIclW95d37WHAeQZzzzjQtVLCTQca66NYSBOCAATsZ/xrLb6D4OmgoYqQnK2Deq8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=16zOfslP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xfbXeZPTZZm9aKRQUep/3yXEGH2y6ajHtpdCKuQzEcM=; b=16zOfslPRv9KW6AlwS4fe1bO4K
	kpuunXazq/tN/Cg4p4UhQNAfcdsSb9QQ8054VoZQGAQPzYfddVW7S2Iem03DVGwrua51qENxvTTv8
	BiMUz+xpRIg/w9e9leeZjviyzMDNP4TY390eZ4ZK083Meb/FAe+QOrqJMHi8itTKS5/KPvyH4RKF/
	rev2dDnFnE9sL2ZWKiZXpRcnq8zoWQ/mJpPu17T1we3Hu3Pyvx6uT9DG8Db3zzz6MrWxO4aG4+ybf
	Fy6zEvMVV1JvDmc86KMuHL8L7bcMWFouMXWkZTwqipwKfBAkvA9XWwyZzaryYt54I51IWzD5M9UiX
	s6OEYrpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56164)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTiHA-00039K-2L;
	Fri, 03 Jan 2025 14:03:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTiH9-0001Mu-0Z;
	Fri, 03 Jan 2025 14:03:43 +0000
Date: Fri, 3 Jan 2025 14:03:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Niklas Cassel <cassel@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3fuP47lueQpzMst@shell.armlinux.org.uk>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
 <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
 <Z3fc2jiJJDzbCHLu@ryzen>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3fc2jiJJDzbCHLu@ryzen>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 03, 2025 at 01:49:30PM +0100, Niklas Cassel wrote:
> On Fri, Jan 03, 2025 at 12:08:43PM +0000, Russell King (Oracle) wrote:
> > On Fri, Jan 03, 2025 at 12:25:52PM +0100, Niklas Cassel wrote:
> > > I'm trying to enable async probe for my PCIe controller (pcie-dw-rockchip),
> > > which on the radxa rock5b has a RTL8125 NIC connected to it.
> > > 
> > > By enabling async probe for the PCIe driver I get the same splat as Francesco.
> > > 
> > > Looking at the prints, it is trying to load a module for PHY ID: 0x1cc840
> > > This PHY ID is defined in: drivers/net/phy/realtek.c.
> > > 
> > > Looking at my .config I have:
> > > CONFIG_REALTEK_PHY=y
> > > 
> > > So this is not built as a module, so I am a bit surprised to see this
> > > splat (since the driver is built as built-in).
> > > 
> > > 
> > > I think it would be nice if the phylib core could be fixed so that
> > > it does not try to load modules for drivers which are built as built-in.
> > > 
> > > 
> > > Also see this old thread that tries to enable async probe by default on
> > > DT systems:
> > > https://lore.kernel.org/linux-kernel//d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com/T/#u
> > > 
> > > AFAICT, it seems that the phylib core is one of the biggest blockers from
> > > being able to enable async probe by default on DT systems.
> > 
> > Yes, we accept that phylib is incompatible with async probing. I don't
> > think that's going to change, because it's fundamentally baked in with
> > the way the whole fallback driver stuff works.
> > 
> > We *certainly* don't want to move the request_module() into
> > phy_attach*() (which is the point where we require the driver to be
> > bound or we fallback to the generic feature-reduced driver). First,
> > that *will* break SFP modules, no ifs or buts.
> > 
> > Second, moving it there would mean calling request_module() in many
> > cases with the RTNL held, which blocks things like new connections
> > network establishing while the module is requested (I've run into this
> > problem when the TI Wilink driver locks up holding the RTNL lock making
> > the platform impossible to remotely resolve if there isn't an already
> > open SSH connection.) We certainly don't want userspace to be doing
> > stuff while holding the "big" RTNL that affects much of networking.
> > 
> > Third, I suspect phylib already has a race between the PHY driver /
> > driver core binding the appropriate driver and phy_attach_direct()
> > attaching the fallback generic driver to the driverless PHY device,
> > and making this more "async" is going to open that race possibly to
> > the point where it becomes a problem. (At the moment, it doesn't
> > seem to cause any issue, so is theoretical right now - but if one
> > reads the code, it's obvious that there is no locking that prevents
> > a race there.)
> > 
> > What saves phylib right now is that by issueing the request_module(),
> > that will wait for the module to be loaded and initialised. The
> > initialisation function will register the PHY drivers in this module.
> > As this is synchronous, it will happen before request_module() returns,
> > and thus before phy_device_create() returns. Thus, if there is a module
> > available for the PHY, it will be loaded and available to be bound
> > to the PHY device by the time phy_device_register() is called. This
> > ensures that - in the case of an auto-loaded module, the race will
> > never happen.
> > 
> > Yes, it's weak. A scenario that could trigger this is loading PHY
> > driver modules in parallel with a call to the phy_attach*() functions,
> > e.g. when bringing up a network interface where the network driver
> > calls through to phy_attach*() from its .ndo_open() method. If we
> > simply make phylib's request_module() async, then this race will be
> > opened for auto-loaded modules as well.
> > 
> > Closing this race to give consistent results is impossible, even if
> > we add locking. If phy_attach*() were to complete first, the generic
> > driver would be used despite the PHY specific driver module being
> > loaded. Alternatively, if the PHY specific driver module finishes
> > being loaded before phy_attach*() is called, then the PHY specific
> > driver will be used for the device. So... it needs to be synchronous.
> > 
> > I also don't think "make a list of built-in drivers and omit the
> > request module" is an acceptable workaround - it's a sticky plaster
> > for the problem. If the PHY driver isn't built-in, then you have the
> > same problem with request_module() being issued. You could work around
> > that by ensuring that the PHY driver is built-in, but then we're
> > relying on multiple different things all being correct in diverse
> > areas, which is fragile.
> 
> FWIW, the patch in $subject does make the splat go away for me.
> (I have the PHY driver built as built-in).

This is not about "making the splat go away". Making something go away
is not solving the problem if it's a fragile sticky plaster. Such things
come back to bite.

> The patch in $subject does "Add a list of registered drivers and check
> if one is already available before resorting to call request_module();
> in this way, if the PHY driver is already there, the MDIO bus can perform
> the async probe."

This is the sticky plaster. I covered that in my message to which you're
replying. See the last paragraph from my reply quoted above.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


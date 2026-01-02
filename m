Return-Path: <netdev+bounces-246587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1DCEEB45
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E01F3000B42
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386083126BC;
	Fri,  2 Jan 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g0/KqriM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E302E62A8;
	Fri,  2 Jan 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362152; cv=none; b=n72RK6ERIrIx37G/0VanRtiGFyrThH3a7AiwQvIc2QshY8w17kAlUvgOIGyMqGJbsyQhIQ/RzVr1wA7XbbblfrSQiml+tyN1P1AjUE1BSa5rT71FdkbtyRQNI+pnL6N6bAaTvTpHhnLngvB+kknzEzd6TdjqN3eFN/5o6Emacrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362152; c=relaxed/simple;
	bh=+PPX2QYeqcyNz/7lFT9g242GDVChRlFtN2xR2XoWCck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmsgt5DZ72lBabKvZe5aV1P3nUe8qEm0Wwcyay2YoBYDwhuK+IScFJKwnEaJQSTZ54IxZqMcqfgGk0Y6Q+UHG29PGOuZ51YS03/ML7dnQ9CsHrZqXQsAnz+vDOZOWlegs7OcP5JoqXQMioPEmsi0UdQ4cYGevLpmV0Jth9Z0c+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=g0/KqriM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8py2WJDoyq/KnDzBegVDn8YyDVEJRrfxPuzzHEASs9o=; b=g0/KqriMA+s1PIZL0dtuML3Aob
	wnq5xosgbYY8Y8ChPZz8CNvd3D+RGL4qrIQ+QVKvW+5zgjKs1j9Y2ZvOJt/mY2wj/0xMmiPpb3QXK
	AQy2CMo42Vltuli6obsd5V9AlkQB8RQQNVwk7POYHehmZXl4fczYzr5RVFd2mQNBoVedPKpJsSkOz
	RPkWtF8nTPg+V0dFTdDa7MEHZK4yusmNS4kyk0Jrmx/sWOeI+kzufrhbMNXt3G/hck6hIpihpPIRT
	PUiggqKeY6I5SlYYa5YfmCYavLeZC5WPtQe4Fg4YxMbIQ9HD/T22J0zv/2HIqP1IY2CJ97qpVltLs
	kzIxkw9A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34010)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbfd0-0000000063I-1uFW;
	Fri, 02 Jan 2026 13:55:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbfcx-0000000055x-3TvW;
	Fri, 02 Jan 2026 13:55:39 +0000
Date: Fri, 2 Jan 2026 13:55:39 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Message-ID: <aVfOW3y0LTcwQncB@shell.armlinux.org.uk>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
 <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 02, 2026 at 12:47:06PM +0000, Russell King (Oracle) wrote:
> I do have patches that add phydev->supported_interfaces which are
> populated at probe time to inform phylink which host interface modes
> that the PHY can be reconfigured between - and this overrides the
> linkmode-derivation of that information - it basically becomes:
> 
>         phy_interface_and(interfaces, phy->supported_interfaces,
>                           pl->config->supported_interfaces);
>         interface = phylink_choose_sfp_interface(pl, interfaces);
>         if (interface == PHY_INTERFACE_MODE_NA) {
>                 phylink_err(pl, "selection of interface for PHY failed\n");
>                 return -EINVAL;
>         }
> 
>         phylink_dbg(pl, "copper SFP: chosen %s interface\n",
>                     phy_modes(interface));
> 
>         ret = phylink_attach_phy(pl, phy, interface);
> 
> and phylink_attach_phy() will result in the PHY driver's config_init
> being called, configuring the appropriate operating mode for the
> PHY, which can then be used to update phydev->supported as appropriate.
> 
> phylink will then look at phydev->supported once the above has
> completed when it will do so in phylink_bringup_phy().
> 
> Deriving the host side PHY interface mode from the link modes has
> always been rather sketchy.

These patches can be found at:

http://git.armlinux.org.uk/cgit/linux-arm.git/log/?h=net-queue

See:

net: phylink: use phy interface mode bitmaps for SFP PHYs
net: phy: add supported_interfaces to Aquantia AQR113C
net: phy: add supported_interfaces to marvell10g PHYs
net: phy: add supported_interfaces to marvell PHYs
net: phy: add supported_interfaces to bcm84881
net: phy: add supported_interfaces to phylib

The reason I didn't end up pushing them (they're almost six years old)
is because I decided that the host_interfaces approach wasn't a good
idea, and dropped those patches. Marek Behún took my patches for
host_interfaces and they were merged in 2022. I had already junked
the host_interfaces approach.

The problem is that we now have two ways that PHY drivers configure
their interface mode - one where config_init() decides on its own
based on the host_interfaces supplied to it, and this approach above
where phylink attempts to choose the interface based on what the
PHY and host (and datapath) can support. These two approaches are
mutually incompatible if we get both phylink _and_ the PHY driver
attempting to do the same thing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


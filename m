Return-Path: <netdev+bounces-172450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5581EA54B2B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D601894FD5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A471E52D;
	Thu,  6 Mar 2025 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CxxAsc2m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67472040BD;
	Thu,  6 Mar 2025 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265309; cv=none; b=btUnTHwDiujNjI+QxMPgPX1jJFcEoRSPcKOHdXHiLohVuXjvUeexiNFiz3UDNo+SKIOfk5SmFdnh2p9cXD4rpVreJMidMHjI56Xwj3X9RiAsf4cMEnq/6TXsD/nryibxkzrr0tO+QWb3zDON3K1hVA4WC6CMd+ACkmBLWRjcKqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265309; c=relaxed/simple;
	bh=ViLXaYDDh1JWsyMIsFtFXeNpOns6R2CWpAsph1iAvMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQN2EKPWXMTgHCvG89V9exKXcywk4D150l3eiMD9gk9+2yDhgWjrhA/KvTxav8vHktSXEfNrOf79HphGePsuCSo+NUs+2iE7UefAXHbgKtqUhF7XteGYGtIhNhmkARY0SjLiFiopa3XTxsQIU6r0Kf6UJiYAKkFzL29Q6fbMFlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CxxAsc2m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+DzXmk4dFbeO+m8INiuwLYdFt5umLSVckqHmHFprSKg=; b=CxxAsc2me4QVCsLdkb0TVQu/h+
	R9lAsFcYFiT7hXeI1jTEY5Uu58JXIQjI3gtjpM+pgssnH97R7qM9eahOg2aZPqHkH8tWttXmwvKmt
	12Tc0Fgpt8cCB9suT7loDaMO3O3+7xHS/UIW72QUAE2quCTqsvRmgGoaLrOzD0WFxvtumRDY5+5OA
	+p+q99J6JRgZ0nngzpfFEIHB3pXGInsxjScLQd02zDVYMpSh0wK/yon0/5m8+/w7E7nLIMCt28zMA
	ghSe+sBkFss3w2hxOhxiJSePMHyU5+ma38K79kcOC8t/GszICm62dUH2h3oQtVG3PxuK07YK+Cwt2
	1adcMuyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40594)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tqAeA-0005rj-0H;
	Thu, 06 Mar 2025 12:48:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tqAe5-0006no-2J;
	Thu, 06 Mar 2025 12:48:13 +0000
Date: Thu, 6 Mar 2025 12:48:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <Z8mZjabeITVg1Khg@shell.armlinux.org.uk>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
 <20250303090321.805785-10-maxime.chevallier@bootlin.com>
 <20250304154330.6e00961b@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304154330.6e00961b@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 04, 2025 at 03:43:30PM +0100, Maxime Chevallier wrote:
> On Mon,  3 Mar 2025 10:03:15 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> 
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
> 
> Maybe before anything goes further with this patch, I'd like to get
> some feedback from it on a particular point. This changes the linkmodes
> that are reported on fixed-link interfaces. Instead of reporting one
> single mode, we report all modes supported by the fixed-link' speed and
> duplex settings.

This is a good question. We have historically only used the baseT link
modes because the software PHY implementation was based around clause
22 baseT PHYs (although that doesn't support >1G of course.)

The real question is... does it matter, to which I'd say I don't know.
One can argue that it shouldn't matter, and I think userspace would be
unlikely to break, but userspace tends to do weird stuff all the time
so there's never any guarantee.

> The fixed-link in question is for the CPU port of a DSA switch.
> 
> In my opinion, this is OK as the linkmodes expressed here don't match
> physical linkmodes on an actual wire, but as this is a user visible
> change, I'd like to make sure this is OK. Any comment here is more than
> welcome.

Maybe Andrew has an opinion, but I suspect like me, it's really a case
that "we don't know".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


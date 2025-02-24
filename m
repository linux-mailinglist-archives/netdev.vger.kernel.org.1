Return-Path: <netdev+bounces-169027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10933A42237
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A15617DAEC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF482561D2;
	Mon, 24 Feb 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IFDXK8ML"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD82561A0;
	Mon, 24 Feb 2025 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405222; cv=none; b=uO3zUpdq2LJ9yfFbyUi8GOrZI51dPy+3g565HMFKdW8G6UUdMJMIKwt+u371GQYHyFYfz0TrH4U+idAvOe9XspMZuq+2IE+mRlbVm/K25E/VQhEcD7qTFgFgyYErCBNQFvGsR3RjYsKzSwG+TYVFYkMaFkPXDuBtRJuUq9hoKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405222; c=relaxed/simple;
	bh=PRg0JhKmJjiExJkYVCCygq4oygc4hYcM1lk7x5cwHVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0WNHuK8pmvK3zHM/7dfEA7qlWqZtewlRe60k+CKUFrQvXUgGaxv7KxSYg9UBi00ZvMKev1el0r1gXQO1Gv/CoeCO7J3smIgPAwTFoxJuBFNn0DOPDfA4z9qHTxUyFi9NODeXDLpEgU4jWJVyANpBw9FmwXq1T8AzdDozMjuBIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IFDXK8ML; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Lp4/LaCOxhgTD9ld3zM3tC7T8uIic+jBJ97jkYwzPPM=; b=IFDXK8ML/4e5xZmJuFegO5PCVw
	vEPdtsztGy5uQFW+6doHgWRr6UChPFlNs/0JLPzF2N9d7gjKpJpMq88IuRmFhMAc4kXVQciyYytSB
	lLm3fC5bPW1Cq/cXDowLG11ASeR3wtkjvFSNjl3tL/CGGwhiRTvJa6hOoZVD7P4TGOU1UCke6OLAT
	jJG/kav21ybLkc2W7RyYycfsIR9gefq9Cz6AmkdlIpLiCANAq0EMELHcC232tCKls/08wLbobPYfL
	Cd7H6wJ+WLlVkmSOo7yCHEOLiyJjXa/uFOfJwFUFmdpYH77oz5VVQcwxZgvTanjxRPfbEQRHfrsxs
	pja2YzGw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50418)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tmYtn-0006TQ-2U;
	Mon, 24 Feb 2025 13:53:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tmYtk-00052t-1u;
	Mon, 24 Feb 2025 13:53:28 +0000
Date: Mon, 24 Feb 2025 13:53:28 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
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
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 12/13] net: phy: phylink: Use phy_caps_lookup
 for fixed-link configuration
Message-ID: <Z7x52C5dE3eXWomq@shell.armlinux.org.uk>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
 <20250222142727.894124-13-maxime.chevallier@bootlin.com>
 <20250224144431.2dca9d19@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224144431.2dca9d19@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 24, 2025 at 02:44:31PM +0100, Kory Maincent wrote:
> On Sat, 22 Feb 2025 15:27:24 +0100
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
> 
> ...
> 
> >  
> >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
> >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> > @@ -588,9 +591,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> >  
> >  	phylink_set(pl->supported, MII);
> >  
> > -	if (s) {
> > -		__set_bit(s->bit, pl->supported);
> > -		__set_bit(s->bit, pl->link_config.lp_advertising);
> > +	if (c) {
> > +		linkmode_or(pl->supported, pl->supported, match);
> > +		linkmode_or(pl->link_config.lp_advertising,
> > pl->supported, match);
> 
> You are doing the OR twice. You should use linkmode_copy() instead.

No, we don't want to copy pl->supported to
pl->link_config.lp_advertising. We just want to set the linkmode bit
that corresponds to the speed/duplex in each mask.

That will result in e.g. the pause mode bits will be overwritten despite
being appropriately set in the advertising mask in the code above this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


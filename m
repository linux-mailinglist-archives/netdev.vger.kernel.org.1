Return-Path: <netdev+bounces-205474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A651AFEE08
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B7B188BCF4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFC2D2380;
	Wed,  9 Jul 2025 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="q7xllo+4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD411DFE1
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076165; cv=none; b=MKpNopPoMV6SS3EQaOsoVHqtVYxfpWtGOMZBTvFdD4ngv/ixsUXWFRwo9OE17mBOA0QhEWsScEhcUaun3GWx5Q5P0K4z6m3a/1fEWKQqO5nu9UoeSNIbLiz1pyyR1jYroOZvNei2mjX/vo5ptFn5UFMyEESEAQh9ipZi75fCehA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076165; c=relaxed/simple;
	bh=2FU73jQAQ/Yyh3PfjZVhjs+5X7IFgf60uZB2E71HBuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWQ9bVkDdqRgOdDDdQ5kK6/Iit9Q+cUdDxtrZ11fNW4ytWDbDHV+TKx7gHjvdAzJQgLd53t24l7FSgUzHqjqcr62hd00cl7ptNuoPmthLOpqEyFAcAl2AOJeZMmuaKlAUBDDWYeZSSwAOYaLrWor8/CBJ6s4h6k6kxG6AOFHNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=q7xllo+4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5WXaO4RBFVq1e9mNmgETycwkDMzSV77rn3wTXsftNrU=; b=q7xllo+4Nl/p6xqZ/G9/1uiWvk
	e/AGL+B9iCnItwqlPCJxZANrsiYWoN2UFIKpgUZAlEb676JDYXJ9HDGKbNpfRrT+sJePdtugT5SQ9
	92NYEMe3Wbh8z3+a3VW5wgRdQ2MfJXTEZfPlsdXAon3c86tRBvT61mJoQGxP6CB/WBxnGhedMJGcy
	kiB/4/cGnIAthLwWpXvbAszrMTQRAeYaRANwoiV8e6bzv9CyQetyJ+7ne79rdvgO0NFPXaysioPWL
	pdJCh+7sQHazgxy27LPgTkpJ1VysdlYXBZXpNji50o/24fWNE38A375Q0wBwAqhXCKPzhw8U5rkEx
	ysOMyn9w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49424)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uZX2p-0008CQ-1g;
	Wed, 09 Jul 2025 16:49:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uZX2l-0002lD-2j;
	Wed, 09 Jul 2025 16:49:11 +0100
Date: Wed, 9 Jul 2025 16:49:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <aG6Pd8sqgL5rILm-@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
 <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home>
 <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
 <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
 <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 09, 2025 at 08:37:51AM -0700, Alexander Duyck wrote:
> On Wed, Jul 2, 2025 at 12:18 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Jul 02, 2025 at 11:07:52AM -0700, Alexander Duyck wrote:
> > > On Wed, Jul 2, 2025 at 6:37 AM Russell King (Oracle)
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Wed, Jul 02, 2025 at 03:14:26PM +0200, Maxime Chevallier wrote:
> > > > > On Wed, 02 Jul 2025 10:44:34 +0100
> > > > > "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> > > > >
> > > > > > Add phylink_sfp_select_interface_speed() which attempts to select the
> > > > > > SFP interface based on the ethtool speed when autoneg is turned off.
> > > > > > This allows users to turn off autoneg for SFPs that support multiple
> > > > > > interface modes, and have an appropriate interface mode selected.
> > > > > >
> > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > > >
> > > > > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > > >
> > > > > I don't have any hardware to perform relevant tests on this :(
> > > >
> > > > Me neither, I should've said. I'd like to see a t-b from
> > > > Alexander Duyck who originally had the problem before this is
> > > > merged.
> > >
> > > It will probably be several days before I can get around to testing it
> > > since I am slammed with meetings most of the next two days, then have
> > > a holiday weekend coming up.
> >
> > I, too, have a vacation - from tomorrow for three weeks. I may dip in
> > and out of kernel emails during that period, but it depends what
> > happens each day.
> 
> So I was able to go in and test it. I ended up just running the
> testing in QEMU w/ my patch set that currently enables QSFP support.
> From what I can tell it appears to be mostly working. Before when I
> tried to alter the speed to go from 100G to 50G it wouldn't change.
> After your patch set it appears to change, although I am noticing a
> slight difference from the default config.
> 
> So by default we come up in the 100G w/ the QSFP configuration:
> [root@localhost fbnic]# ethtool enp1s0
> Settings for enp1s0:
>         Supported ports: [  ]
>         Supported link modes:   50000baseCR/Full
>                                 100000baseCR2/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: No
>         Supported FEC modes: RS
>         Advertised link modes:  100000baseCR2/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: RS
>         Link partner advertised link modes:  100000baseCR2/Full
>         Link partner advertised pause frame use: No
>         Link partner advertised auto-negotiation: No
>         Link partner advertised FEC modes: RS
>         Speed: 100000Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Other
>         PHYAD: 0
>         Transceiver: internal
>         Link detected: yes
> 
> I then change the speed to 50G and it links back up after a few
> seconds, however the "Advertised link modes" goes from
> "100000baseCR2/Full" to "Not reported" as shown here:
> [root@localhost fbnic]# ethtool -s enp1s0 speed 50000
> [root@localhost fbnic]# ethtool enp1s0
> Settings for enp1s0:
>         Supported ports: [  ]
>         Supported link modes:   50000baseCR/Full
>                                 100000baseCR2/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: No
>         Supported FEC modes: RS
>         Advertised link modes:  Not reported
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: RS
>         Link partner advertised link modes:  100000baseCR2/Full
>         Link partner advertised pause frame use: No
>         Link partner advertised auto-negotiation: No
>         Link partner advertised FEC modes: RS
>         Speed: 50000Mb/s
>         Duplex: Full
>         Auto-negotiation: off
>         Port: Other
>         PHYAD: 0
>         Transceiver: internal
>         Link detected: yes
> 
> So all-in-all it is an improvement over the previous behavior although
> there may still need to be some work done to improve the consistency
> so that it more closely matches up with what happens when you
> initially configure the interface.

Likely, it's ethtool doing that. Autoneg-off (fixed speed) modes
generally don't have an advertisement. I suggest you debug at UAPI
level.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


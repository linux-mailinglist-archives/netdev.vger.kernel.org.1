Return-Path: <netdev+bounces-148145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901379E07DB
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F42281CEA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394013AA2D;
	Mon,  2 Dec 2024 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H0KVIcoM"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6BB13B2A8;
	Mon,  2 Dec 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155411; cv=none; b=L872Eie1gW0uHTIn06ELYSkk2Ca79XMTAosX0lJ40qx2MB6PQMUm/H0kjAu1yFGow1didbIrJt4iZnzX3DjyTpD+hF1sVPyhm7eWcinGQatlLjQSc9fE2Vzt0BptaQcX2aihnikZbmxrvZpsNgVTPRGkSsA3R63jR8Y9/VYdpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155411; c=relaxed/simple;
	bh=STrMM8KN1Ec1+CaLg2m1Kx1Cvn7Z7/lLGkELIAy4GdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmBTpD9l6+dJeKHGPEBBU77e8LmwYM2UWNeZFrT+0uhu2EDON+hFxAL8PDiVCA9+Q7uQ0Cq189lfdO/ycNtmKqwIk+IVDgFSFW/RTQZxdyrSNbXYCYuRy6/NqR8A+kh+ijKuJ7u1DHnsIzCEY2YcZQhYkYSzrwdpf22upiuh1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=H0KVIcoM; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J/zMQiaN6dYZzz32+DhTjsqFEPVQYfpeCe+pJ1zng0Q=; b=H0KVIcoMoaicbifVZYQRwnauuq
	edwE5y3U9lvcgfYQ5wh0G0OPStj2afnd5LHO0DiRpSKotlO03/WvHWoERT5WD80vd/AW+IWqPn991
	5vwfJaDTuoMVaLbi8Zi0VsTx0JB/42iwgt6IW6hdJncPgdOYSTTmdZ9rv+0bFLLUPGeyqvm+9V+fa
	nYfJA+lDxtNTio+3QvnmpQNrjpJb/GtGL4yrJY4b3PU+t9g5k4MifIxJderUpqycdG8L6R4Z2xdu+
	EUgq8o9JEVIC0XZFaAS899kXtHa0Y6+uHmu4U2cv8+8Mdq67sipEPAgOe/G/gVWfwNatOpfd4oeVP
	OO0/PF+A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35862)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tI8tG-0000LE-1Q;
	Mon, 02 Dec 2024 16:03:15 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tI8tD-0003hN-0v;
	Mon, 02 Dec 2024 16:03:11 +0000
Date: Mon, 2 Dec 2024 16:03:11 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <20241202100334.454599a7@fedora.home>
 <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 02, 2024 at 08:51:44PM +0500, Nikita Yushchenko wrote:
> > > root@vc4-033:~# ethtool tsn0
> > > Settings for tsn0:
> > >          Supported ports: [ MII ]
> > >          Supported link modes:   2500baseT/Full
> > >          Supported pause frame use: Symmetric Receive-only
> > >          Supports auto-negotiation: No
> > 
> > Okay, the PHY can apparently only operate in fixed mode, although I
> > would suggest checking that is actually the case. I suspect that may
> > be a driver bug, especially as...
> 
> My contacts from Renesas say that this PHY chip is an engineering sample.
> 
> I'm not sure about the origin of "driver" for this. I did not look inside
> before, but now I did, and it is almost completely a stub. Even no init
> sequence. The only hw operations that this stub does are
> (1) reading bit 0 of register 1.0901 and returning it as link status (phydev->link),
> (2) reading bit 0 of register 1.0000 and returning it as master/slave
> setting (phydev->master_slave_get / phydev->master_slave_state)
> (3) applying phydev->master_slave_set via writing to bit 0 of register
> 1.0000 and then writing 0x200 to register 7.0200
> 
> Per standard, writing 0x200 to 7.0200 is autoneg restart, however bit 0 of
> 1.0000 has nothing to do with master/slave. So what device actually does is
> unclear. Just a black box that provides 2.5G Base-T1 signalling, and
> software-wise can only report link and accept master-slave configuration.
> 
> Not sure if supporting this sort of black box worths kernel changes.
> 
> 
> > it changes phydev->duplex, which is _not_ supposed to happen if
> > negotiation has been disabled.
> 
> There are no writes to phydev->duplex inside the "driver".
> Something in the phy core is changing it.

Maybe it's calling phylib functions? Shrug, I'm losing interest in this
problem without seeing the driver code. There's just too much unknown
here.

It's not so much about what the driver does with the hardware. We have
some T1 library functions. We don't know which are being used (if any).

Phylib won't randomly change phydev->duplex unless a library function
that e.g. reads status from the PHY does it.

As I say, need to see the code. Otherwise... sorry, I'm no longer
interested in your problem.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-254485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAIhOw+KemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:13:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A5A96F6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2CAC3021702
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A364342C92;
	Wed, 28 Jan 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VybPBeDr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7942E342528;
	Wed, 28 Jan 2026 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638413; cv=none; b=Y2qAPNt244wxQZciJSdfHbZ07EMVTKMMmgCA4i3CGqaB7ma2nWM2dKFZ74bTV7HTkBDy8vX0vsOglyjQHixfqYXpsOqYLjZLmM4GYZJfngS7cD1+1Vf0qIpW4BlrqQ88V7ZCWCOaTzXwr24J6wX3RDjgSd9M6v0uonVWLfg+1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638413; c=relaxed/simple;
	bh=AQitCxQ8sjP4vMXUli2vM6/WRsuXjEFDD2ZDl63WmQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyeCrTisGLL+zJ08T0lNZ9iJxon7Mdy/OVehLeM4IgP4GSraSaEHG7UWD0aIVgSOTCw3+mpMbn7R7MD7jfdCIvTI96XQUzRInRsAiTYULMWg6LQJzg7UiCj3Vhfj1CYm3Q8DhtNS+0cgjZizuBMAzdw0G8BZkbMXUi/FEWqFD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VybPBeDr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XqWRoXqt04FoYQB/iClN0Gc0AhfEb0XiuNwfYuRpNQg=; b=VybPBeDr1/2JBC0C5asMKrcF1X
	nxtyPYwFjpawgOTfb8HNAWAu9bDOk+t/WaOTRIakYIRB6SotdOSLacDanVb0/PVgMUNFIcpCmiNNa
	Lvjk8BzBH6lf4j9XznluxWkbQORG0ypepWUaQOk+l7pWLFTUhokiLfSKJAGEkYdsDBBYdVTXq8/XH
	P9BeOEe7KVFVl4d0phS0y/2wrC4PYhVLfhebFpEJluPWvU+xaSmvre2//iydA4YqQVeCzDZTAoJsy
	k8xg6tD5+1lsOPgGu4xOYUNrGnu4fZAlELlfjNLwe1cdO+5ZTy1vvffEVQSV7EMsNYy/BdcdiHihf
	iynywZBA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59576)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlDmr-000000007wt-0TTc;
	Wed, 28 Jan 2026 22:13:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlDmo-000000007LX-05sM;
	Wed, 28 Jan 2026 22:13:18 +0000
Date: Wed, 28 Jan 2026 22:13:17 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url,shell.armlinux.org.uk:mid]
X-Rspamd-Queue-Id: 545A5A96F6
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:26:34PM +0100, Marco Felsch wrote:
> |   Some PHYs need the refclk to be a continuous clock. Therefore they don't
> |   allow turning it off and on again during operation. Nonetheless such a
> |   clock switching is performed by some ETH drivers (namely FEC [1]) for
> |   power saving reasons. An example for an affected PHY is the
> |   SMSC/Microchip LAN8720 in "REF_CLK In Mode".
> 
> This can be achieved with commit
> bedd8d78aba300860cec3f85d6ff549b3b7f2679 if specified accordingly.

I don't think this is unusual. I've just checked the 88E151x
documentation, and that also requires: 10ms after power and 10 clock
cycles on XTAL_IN before deasserting reset. The timing diagram indicates
that subsequent hardware resets must be 10ms in duration, and show the
XTAL_IN clock running during the reset.

Looking at AR8035, it is similar - the clock must be running before
releasing reset and while reset is asserted.

So, to say that LAN8710 is somehow special seems wrong to me - it isn't
just these PHYs that have the requirement to be clocked before reset is
released nor while reset is asserted.

I'm guessing the problem here is that, most cases the clock is provided
by a crystal, in these cases it's being sourced from the SoC, and that
puts the responsibility on the SoC parts to guarantee the reset timing
required for the PHY in some way.

In other words, by sourcing it from the SoC, it's not phylib nor the
PHY driver's problem (the PHY driver comes along way too late) but the
responsibility for the boot firmware / DT description / network driver
to detect this situation and give the PHY what it requires to reset
properly before registering the MDIO bus.

The boot firmware route is how this is handled with SolidRun i.MX6
based boards - the PHY reset is a GPIO, but that GPIO is *not* told to
the kernel except as a hog. u-boot takes care of setting up the 25MHz
clock for the PHY and releasing its reset - it actually does two
resets due to running off the ANATOP provided clock. This is an AR8035
PHY, which as I've mentioned above, requires the clock running before
releasing reset, just like the LAN8710-like PHY that you're discussing
here.

Given all the complexity we've had with systems with two FECs, where
the PHY for one is connected via the MDIO bus on the other FEC, it
seems to me that pushing the clocking and reset handling into the
kernel is just asking for lots of pain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


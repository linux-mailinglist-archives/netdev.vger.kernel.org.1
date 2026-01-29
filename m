Return-Path: <netdev+bounces-254737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIlJFno8e2mNCgIAu9opvQ
	(envelope-from <netdev+bounces-254737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:54:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB397AF33D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F1C305EF70
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6637AA99;
	Thu, 29 Jan 2026 10:41:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2BC37F117
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683295; cv=none; b=PkRDmkMQQKewfTOcQM8vZZZenF/a6m6vbKhdnIa2OcsDR2nmevriuovGkhaDwDLV9b1kjD3Mi5b5c5IsW6lotZMVejTxwDl/2/8vL0sSrecHSRYxfB26uU8L2wgU6J3HnBD6k1rXzlxQuY+nB0o/ss7Ygmoeyn1gU/4j/ytnFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683295; c=relaxed/simple;
	bh=FiZ9X1ZiRAw8pfadpGXOcan82VTROQ4NtEmXU5JRd1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vyme2zOjkO/Q70Zt3+07/b2t/TZIT/kopV6LK3hRZ+dlx5DrPNmJI1QBWx1jhuRIdT6PQmDap8Yc1GQhWUzAPaxKX0SOtd83QklpFA/CDejl2198eh4xMUWYgjat4L/tpktO3/3FQSdGsiDfTSS5RHZgdQyWrsmz2d4cWnw7pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlPSm-00079E-E7; Thu, 29 Jan 2026 11:41:24 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlPSm-0034Mh-1G;
	Thu, 29 Jan 2026 11:41:23 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlPSl-004eYx-1s;
	Thu, 29 Jan 2026 11:41:23 +0100
Date: Thu, 29 Jan 2026 11:41:23 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
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
Message-ID: <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254737-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.felsch@pengutronix.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:url,pengutronix.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: AB397AF33D
X-Rspamd-Action: no action

On 26-01-28, Russell King (Oracle) wrote:
> On Wed, Jan 28, 2026 at 09:26:34PM +0100, Marco Felsch wrote:
> > |   Some PHYs need the refclk to be a continuous clock. Therefore they don't
> > |   allow turning it off and on again during operation. Nonetheless such a
> > |   clock switching is performed by some ETH drivers (namely FEC [1]) for
> > |   power saving reasons. An example for an affected PHY is the
> > |   SMSC/Microchip LAN8720 in "REF_CLK In Mode".
> > 
> > This can be achieved with commit
> > bedd8d78aba300860cec3f85d6ff549b3b7f2679 if specified accordingly.
> 
> I don't think this is unusual. I've just checked the 88E151x
> documentation, and that also requires: 10ms after power and 10 clock
> cycles on XTAL_IN before deasserting reset. The timing diagram indicates
> that subsequent hardware resets must be 10ms in duration, and show the
> XTAL_IN clock running during the reset.
> 
> Looking at AR8035, it is similar - the clock must be running before
> releasing reset and while reset is asserted.

This is like every external IC or internal IP ;) What's special is the
phy generic compatible handling... (please see below)

> So, to say that LAN8710 is somehow special seems wrong to me - it isn't
> just these PHYs that have the requirement to be clocked before reset is
> released nor while reset is asserted.

IIRC the Linux phy framework does have this hard dependency, that a
phy needs to be accessible to make use of the generic phy compatible
probing to read-out the phy-id registers.

This requires that $someone e.g. the bootloader already did the phy
power-up sequencing for us so the phy-id can be read.

Once it comes to the FEC the situation is like this:
 - The FEC can provide the PHY clock via ("enet_out"), no external
   crystal required.
 - If the phy clk is specified the FEC will turn on this clock during
   the probe() and issues the MII bus probe incl. the phy probe().
 - Afterwards the clock is gets disabled

My patch added the support to keep to request the clock during
phy.probe() and keep phy-clock running till the phy.remove() callback
gets called. Therefore no such local quirk like PHY_RST_AFTER_CLK_EN is
required.

> I'm guessing the problem here is that, most cases the clock is provided
> by a crystal, in these cases it's being sourced from the SoC, and that
> puts the responsibility on the SoC parts to guarantee the reset timing
> required for the PHY in some way.

This was exactly my use-case too and it's beeing addressed just fine
with no PHY_RST_AFTER_CLK_EN but the clock and reset specified within
the DTS.

> In other words, by sourcing it from the SoC, it's not phylib nor the
> PHY driver's problem (the PHY driver comes along way too late) but the
> responsibility for the boot firmware / DT description / network driver
> to detect this situation and give the PHY what it requires to reset
> properly before registering the MDIO bus.

Yes but I don't see a problem at all if everything was specified
accordingly.

> The boot firmware route is how this is handled with SolidRun i.MX6
> based boards - the PHY reset is a GPIO, but that GPIO is *not* told to
> the kernel except as a hog. u-boot takes care of setting up the 25MHz
> clock for the PHY and releasing its reset - it actually does two
> resets due to running off the ANATOP provided clock. This is an AR8035
> PHY, which as I've mentioned above, requires the clock running before
> releasing reset, just like the LAN8710-like PHY that you're discussing
> here.

Yes, it's very common that the bootloader does the initial work since
sometimes strapping pins are involved which need to be pulled too for
the reset sequence which are later on re-used for $other purpose.

As said, I don't see a problem with the LAN8710. But while checking the
Linux source code, I saw commit
57ec5a8735dc5dccd1ee68afdb1114956a3fce0d which re-introduced the reset
handling :-/

> Given all the complexity we've had with systems with two FECs, where
> the PHY for one is connected via the MDIO bus on the other FEC, it
> seems to me that pushing the clocking and reset handling into the
> kernel is just asking for lots of pain.

I wouldn't recommend such setups at all. It's like asking for troubles
;)

Regards,
  Marco

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


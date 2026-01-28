Return-Path: <netdev+bounces-254434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNuaDyRxemlI6QEAu9opvQ
	(envelope-from <netdev+bounces-254434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:27:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7CA87AE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60D430488FC
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE51B35FF67;
	Wed, 28 Jan 2026 20:26:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923733031E
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632011; cv=none; b=POjuNGoNnAEyguvezekmC6NBKkKUJFk5aSLboG7zQLa1Ef/jIf2plxK/WnJP4Sxl08WW/ZQDrlOmwaGBT2AqnwX+CKEcwxKglMtYWpskip3DuE8qH4kMk4OaJn34iIL6Py/pPeY2aR54VlcV5kZnkf7SN03gLdRqu4xIftNsJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632011; c=relaxed/simple;
	bh=HZa5ht60kTuZ5mPivPN4oV1/ntHz7uBm3f9ivO1VrjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nk4UmzrD0XbC2UBxkoROTkPxxh9K0hxHxL3/x1n2C/5DwguZD7gpvttdb9gu7/y0BIpsJGR2QHSNoKVDhXz+8YYiW8ex1TlIWZKadFNvooNyOYSxRr/1RYJe1+5DqITaqb6O1//fADRcB8ELii3FVpHlSBOYX/QrQno28hUI4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlC7Z-0002t1-3M; Wed, 28 Jan 2026 21:26:37 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlC7X-002yRW-06;
	Wed, 28 Jan 2026 21:26:34 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlC7W-002trp-0b;
	Wed, 28 Jan 2026 21:26:34 +0100
Date: Wed, 28 Jan 2026 21:26:34 +0100
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
Message-ID: <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,lunn.ch,nxp.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254434-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1C7CA87AE
X-Rspamd-Action: no action

On 26-01-28, Russell King (Oracle) wrote:
> On Wed, Jan 28, 2026 at 02:33:24PM +0100, Michael Nazzareno Trimarchi wrote:
> > Hi Andrew
> > 
> > On Wed, Jan 28, 2026 at 2:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 10:46:41AM +0100, Michael Trimarchi wrote:
> > > > The current implementation of phy_reset_after_clk_enable requires MAC drivers
> > > > (like fec_main.c) to manually track PHY probing states and trigger resets
> > > > at specific points in their clock management flow and was created just for a SoC
> > > > vendor.
> > >
> > > We try to keep workarounds for specific SoC vendors out of the core,
> > > when possible. It just makes the core more complex for an edge case
> > > which most people don't care about. It is better to hide the
> > > complexity away in the driver which needs it.
> > 
> > We should not merge things in the core that are for one Soc and
> > after d65af21842f8a7821fc3b28dc043c2f92b2b312c, I need to anyway to do:
> > 
> > net: phy: smsc: Fix functionality of lan8710 in combination with NXP fec
> > 
> > Revert "net: phy: smsc: LAN8710/20: remove PHY_RST_AFTER_CLK_EN flag"
> > d65af21842
> 
> That commit is an example of a poor commit description. It doesn't
> describe the problem, nor which hardware this affects, so when we end
> up with this kind of situation, we're lacking the context behind why
> the change was made.

I need to say that this commit lacks a bit of context which is part of
my previous commit. I thought, that I made that clear with:

|   The same behaviour can be archived now by specifying the refclk.

To be honest, I should have made it more clear.

> So, how do we know that reverting that commit is not going to cause a
> regression for whatever platform the patch was proposed for?

If I get the Michael's patch correct, he tries to move the quirk
handling into the core. I really don't know why Michael requires the
speical reset handling at all. The commit adding the
PHY_RST_AFTER_CLK_EN flag says:

|    phylib: add reset after clk enable support
|
|   Some PHYs need the refclk to be a continuous clock. Therefore they don't
|   allow turning it off and on again during operation. Nonetheless such a
|   clock switching is performed by some ETH drivers (namely FEC [1]) for
|   power saving reasons. An example for an affected PHY is the
|   SMSC/Microchip LAN8720 in "REF_CLK In Mode".

This can be achieved with commit
bedd8d78aba300860cec3f85d6ff549b3b7f2679 if specified accordingly.

> If you read the preceeding commit (which is referenced by the commit
> you intend to revert) itgives more information about the problem, and
> I would expect that reverting it will cause a regression with
> interrupts.

Yes, my bad I thought this reference is enough.

> Adding Marco to this thread for comment.

Thanks.

The issue was with the out-of-band reset coming from the FEC driver
which doesn't honor the phy state-machine. It shouldn't cause a
regression (TM) if it would be part of the state-machine (aka this RFC
patch) but it needs to be tested!

As said above, I'm not sure why PHY_RST_AFTER_CLK_EN is required in the
first place.

> Also, maybe you could clearly state what the issue that you are trying
> to address - why do you need special reset handling for the combination
> of FEC + this PHY. Consider including that description in the commit
> message for any proposed solution so that - as is the case here looking
> back at Macro's commit - we can see _why_ the change is being made.

With the context of the previous commit it should be clear.

Regards,
  Marco

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |


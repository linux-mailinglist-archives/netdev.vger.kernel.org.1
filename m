Return-Path: <netdev+bounces-254486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FyVIhKLemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:17:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF4A97DB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F32CB300F162
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DE2BE7BA;
	Wed, 28 Jan 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dHc8cigp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC2266B67;
	Wed, 28 Jan 2026 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638672; cv=none; b=PZiCVTsV2TlyYQxSsG7AeIwLS/GONnAMMfSqyWaIl/5aKzK4cDrpmzQfkYoy2ICFxyvoy+fF84hc1Tyz3fRoxueaZ5S9oT2VuQOhMGpq5Xv5apZeYWqmjTAGiqd42G8lTrh+j+BjzS0p9A1qCPHsvYodtFj/sv0ErcppkBmE3Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638672; c=relaxed/simple;
	bh=gWythbY87SF01rE6BMcocT8lNrdJqmdoc+pmfTB4Th8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/wjWpi5ziZyReE0UMsK7lqg95bhJrlXtQ/ebtXHWR9dpkvVHnTVpqfjgC6luGpvn8FU4FSHrboHXb755crc6k1JTHeMf15GO7/lxum4K4n0O+bIUxDhgrdnkeN14hnh/lSdJY4eS3JCS4pKWZdLP4v1UKQBbIG6tqhwgAJAma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dHc8cigp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/49mFnW8EdRgXSubu0DebZpzEOyO6SnO6tydxasgyv0=; b=dHc8cigp821YApbTxEdiazEDJR
	3ElgX/ajxUHtFOX374pxlYHgeTEFMEJb0JnaUy5v6B634dNoouQuUR/Czi1lU4xuKv9wY5TKnr8bn
	koKgH5sUmBVCrKMzWropmVJZ2bz2h0uDbkzjNxbRFNW7fr2ZADt47KEMXSVVEqnSg3H8O3E0BucUm
	raeWkdOfnl2FfnbBTactz4JCjuUrQNEUCA67nylDUuSBSudDQbpL1TRLmusBGfzUZfnfdSqHYwKyh
	E+888ATOY76Lxg6jWJzlE8/QakV748jiQAlmSSVFLU75OQk+xLYR6Hw/HF3zYTqAuJGYSaBU25QxS
	sdLNLsig==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58560)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlDr5-000000007xS-0N2k;
	Wed, 28 Jan 2026 22:17:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlDr3-000000007Lk-3JEL;
	Wed, 28 Jan 2026 22:17:41 +0000
Date: Wed, 28 Jan 2026 22:17:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
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
Message-ID: <aXqLBXs0fUIVkQg_@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch>
 <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
 <9f6b520c-203d-48cc-8bef-18959672052c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f6b520c-203d-48cc-8bef-18959672052c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254486-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[amarulasolutions.com,pengutronix.de,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lists.linux.dev,vger.kernel.org];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email,shell.armlinux.org.uk:mid,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 05CF4A97DB
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:45:32PM +0100, Andrew Lunn wrote:
> On Wed, Jan 28, 2026 at 10:04:03PM +0100, Michael Nazzareno Trimarchi wrote:
> > Hi
> > 
> > On Wed, Jan 28, 2026 at 9:51 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > The issue was with the out-of-band reset coming from the FEC driver
> > > > which doesn't honor the phy state-machine.
> > >
> > > Could you explain this is more details. Is the FEC doing something
> > > wrong?
> > 
> > The fact that the phy should be reset when the clk is provided to it, is not
> > connected at all with the fec. I think that fec_main does not register itself
> > as clock provider, You "should" define the phy to have a clock if this is needed
> > during the restoration and we should not give any "magic" at controller level.
> 
> Do we know which clock the PHY is consuming?
> 
> The FEC has code for the clock "enet_out" which it enables and
> disables. If the PHY is also consuming this clock, we could also make
> it a consumer. The CCF reference counts enables/disables of clocks, so
> if the PHY enables it, the MAC won't be able to disable it.

As I've just mentioned earlier in this thread, there seems to be nothing
special about the LAN8710-like PHYs requiring their XTAL clock to be
running for reset to be functional. The same is true of AR8035 used
on i.MX6 SolidRun platforms, and Marvell 88E151x PHYs that I've looked
at. I would suggest that, in general, _all_ PHYs require their XTAL
clock to be running.

Therefore, this is not a work of the PHY at all.

It is a quirk of the board design to provide the PHY's XTAL clock from
the SoC, and this _seems_ to be common with FEC based systems, probably
because there's an easy way to get the clock from the FEC, thus saving
the cost of a crystal.

I stated how SolidRun handles this quirk entirely in uboot so the kernel
doesn't have to care about this at all, and the kernel doesn't get to
even know that the PHY has a reset GPIO.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-254766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGK1KdZBe2n6CwIAu9opvQ
	(envelope-from <netdev+bounces-254766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:17:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A16AF875
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8F7300B117
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239872EAB61;
	Thu, 29 Jan 2026 11:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5AE327C0F
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685460; cv=none; b=Bbj7P+dADcvBzQPHjbE8OF352twrf7YsRCxXaNYBQviK3jXCJTIHq8xtVw3q5AZ/PLtUABUiY3b3vpqiJ6hG+/FuFPFbKittVbyvYhaFy8KjkxsF4IU49dnhPZAU1scb/RKGHJoeXmy3ij2lfkq3mATBJSJjWXviGk1Dpj/Uijc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685460; c=relaxed/simple;
	bh=zj84EtgCbu4++Eo7Wq/IxAONMKAi2gpxcTZyU2kKteE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlWBOVFlVIdC/gIHvtk5AsRSZxDUfI0RNvW0BGi5sS76JgboWUBCR7SN2ZPv78Oo3SpwuyFWe968by+6/hZ/snZWBB8ilHkYimxB0by6LoyZPHa5AeZ4XhPiYYwCE5D0rfZHlwf5QmxMJR498UzYB4lCZAhx+pixTFtYkyLrJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlQ1f-0004Hp-VC; Thu, 29 Jan 2026 12:17:27 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlQ1e-0034hH-2k;
	Thu, 29 Jan 2026 12:17:26 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vlQ1e-004f9L-09;
	Thu, 29 Jan 2026 12:17:26 +0100
Date: Thu, 29 Jan 2026 12:17:26 +0100
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
Message-ID: <20260129111726.jjkcq46dpghuorco@pengutronix.de>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
 <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
 <aXs8m8UodO4griTY@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXs8m8UodO4griTY@shell.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-254766-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09A16AF875
X-Rspamd-Action: no action

On 26-01-29, Russell King (Oracle) wrote:
> On Thu, Jan 29, 2026 at 11:41:23AM +0100, Marco Felsch wrote:
> > As said, I don't see a problem with the LAN8710. But while checking the
> > Linux source code, I saw commit
> > 57ec5a8735dc5dccd1ee68afdb1114956a3fce0d which re-introduced the reset
> > handling :-/
> 
> So now we get to the bottom of it. This is a regression, right? The
> addition of that patch has caused previously working boards to stop
> working, correct?

The commit is part of 6.17 and the system I've added the support for the
clk handling is currently running on 6.14. I have to ask a colleague of
mine to very this.

But yes, it seems like a regression.

> That means it needs to be reverted.

Yes.

> We also need to get out of our heads the idea that LAN8710A is somehow
> special in needing this. It isn't. Thus, there should be no special
> flags to "work around" this "problem".

IMHO this flag should be removed completely because it makes the
phy-driver mac-driver dependent. Since the FEC is the only driver
checking this flag.

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


Return-Path: <netdev+bounces-215250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B15B2DC65
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A461E1C47BA8
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 12:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2A1305057;
	Wed, 20 Aug 2025 12:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F582E3AF6
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692801; cv=none; b=dRhXqzTch80tynj7YGuIkyVeilXTSJQWzwBAI45RAFK0M2/eSrStMJTOUWPWYwQJzp5+16vBYjQj2G1Ic+857Vgr+KY7lFDHWGW7rwO7wWoTYSByABGGMY3QNRFyRjTuIcU3v61bGD6HOcndpf86NQQdWrtwrmLbxrW8d1bx+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692801; c=relaxed/simple;
	bh=ZUckhx0b1FZYrbO+0sEf2kPmwrX8tp3wUpLQSDeGdp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW0me1QnLJ/HuFgmgm8eE1SH4/5ySX8tHmaeExDhkMf/0Sk2ymnCYbDyNpAT1Z0nm6KSk7sMemj7QXJMsAwpj3intvaFIkzSDStW4qtEqIgz5IEetGOYErEBHAkI1866+dqIM7B/yH7oZnZE0SHYSt1oyHhkAh8O/hUzmT6igsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uohtJ-0000bE-Ig; Wed, 20 Aug 2025 14:26:09 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uohtH-001FD8-0H;
	Wed, 20 Aug 2025 14:26:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uohtG-005wUD-36;
	Wed, 20 Aug 2025 14:26:06 +0200
Date: Wed, 20 Aug 2025 14:26:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Nishanth Menon <nm@ti.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk <roan@protonic.nl>
Subject: Re: [PATCH net-next v2 5/5] net: phy: dp83td510: add MSE interface
 support for 10BASE-T1L
Message-ID: <aKW-3sF2g2QrKDpG@pengutronix.de>
References: <20250815063509.743796-1-o.rempel@pengutronix.de>
 <20250815063509.743796-6-o.rempel@pengutronix.de>
 <1df-68a2e100-1-20bf1840@149731379>
 <aKLwdrqn-_9KqMaA@pengutronix.de>
 <94745663-b68c-4a4c-95d8-36933c305e34@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94745663-b68c-4a4c-95d8-36933c305e34@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Aug 20, 2025 at 02:11:57PM +0200, Andrew Lunn wrote:
> > > The doc in patch 1 says :
> > > 
> > >   > + * Link-wide mode:
> > >   > + *  - Some PHYs only expose a link-wide aggregate MSE, or cannot map their
> > >   > + *    measurement to a specific channel/pair (e.g. 100BASE-TX when MDI/MDI-X
> > >   > + *    resolution is unknown). In that case, callers must use the LINK selector.
> > > 
> > > The way I understand that is that PHYs will report either channel-specific values or
> > > link-wide values. Is that correct or are both valid ? In BaseT1 this is the same thing,
> > > but maybe for consistency, we should report either channel values or link-wide values ?
> > 
> > for 100Base-T1 the LINK and channel-A selectors are effectively the
> > same, since the PHY only has a single channel. In this case both are
> > valid, and the driver will return the same answer for either request.
> > 
> > I decided to expose both for consistency:
> > - on one side, the driver already reports pair_A information for the
> >   cable test, so it makes sense to allow channel-A here as well;
> > - on the other side, if a caller such as a generic link-status/health
> >   request asks for LINK, we can also provide that without special
> >   casing.
> > 
> > So the driver just answers what it can. For this PHY, LINK and
> > channel-A map to the same hardware register, and all other selectors
> > return -EOPNOTSUPP.
> 
> The document you referenced explicitly says it is for 100BASE-T1.  Are
> there other Open Alliance documents which extend the concept to -T2
> and -T4 links? Do you have access to -T2 or -T4 PHYs which implement
> the concept for multiple pairs?

So far I know, following T2/T4 PHYs support MSE:
LAN8830, KSZ9131, LAN8831, LAN8840, LAN8841
DP83826*, DP83640, DP83867*, DP83869HM

I have access at least to LAN8841.

> I think it is good you are thinking about the API, how it could work
> with -T2 and -T4, but do we need this complexity now?

Hm.. I just fear to make same mistake as I did with SQI. So, I analyzed
as many datasheets as possible.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-275608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEK+Cnq/02n6lQcAu9opvQ
	(envelope-from <netdev+bounces-275608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:13:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6113A3D06
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE8103006B6A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8084371D0D;
	Mon,  6 Apr 2026 14:13:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C43637E2F7
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484791; cv=none; b=npbk1KmfjFFHJDl7Lvm86G7Hos6lUJC7usOLMroJ3WRK7MmTckI1Feeb0DK6esajRq0QHl8IZhbs7aBGQ/Dbr9nPHfN2qYzbpGG1qXMxfQ2h9t6zaYTACX69t1XJcbPLqLwz3VZnPlMElZjFzkB8hR7pK+NNYczSPOQ2mehbCno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484791; c=relaxed/simple;
	bh=1JsMDjMGSWHym8yj04RdSWUfoHm/5ptMjRJYrRDKQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiCP8SEy1gP/HpyMbEhXhg2QI9mIaIhmd+cXcHPD4IjunfwKmiC0c3Tr0N/a31kjnllFqqh7LVDjwAz9gxTerwRuUz7gRVoEThvK02EvEFvzSz6G0uieCdMaRQQxFCDD3vn1ppDe5JO623din3cLO3yRNPmpgH9cVXEhVBV5/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w9khC-0004yD-Fe; Mon, 06 Apr 2026 16:12:54 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w9khB-0041iE-1Z;
	Mon, 06 Apr 2026 16:12:53 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w9khB-0000000B4gG-1Ul0;
	Mon, 06 Apr 2026 16:12:53 +0200
Date: Mon, 6 Apr 2026 16:12:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Carlo Szelinsky <github@szelinsky.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <adO_Za-X1cMjCEEa@pengutronix.de>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
 <20260405185730.3937952-1-github@szelinsky.de>
 <adN9Ha5FgJ8sp6gj@pengutronix.de>
 <1df8b470-2449-418d-a4a8-9cd929ced463@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1df8b470-2449-418d-a4a8-9cd929ced463@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-275608-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[szelinsky.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.624];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:mid,pengutronix.de:url]
X-Rspamd-Queue-Id: 5E6113A3D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 02:22:16PM +0200, Andrew Lunn wrote:
> > The core question, do we need PSE for PHY functionality?
> 
> I don't think the PHY should require PSE in order to send/receive
> frames. If the PSE is not supplying power, the link peer is probably
> off, but that is not so different from the cable being unplugged.
> 
> > We can make a step back and re-evaluate - what functionality and what
> > order is actually required to find potentially better implementation.
> > 
> > We have a lot of current flowing over wires, budget and port
> > prioritization issues, things which may damage HW if done not correctly.
> > With other word, if we do not have properly operational environment
> > providing system specific policies, it is better to run safe
> > configuration - all ports/regulators are off.
> > 
> > This means:
> > - PSE controller driver should be registered as early as possible,
> >   without caring about existence of PHYs, ports or network interfaces.
> >   And configure ports in to default safe operation - off. Accept we
> >   have some controller/firmware which would care about safety.
> 
> Don't most PSE have I2C or SPI interfaces? So they have a different
> life cycle to PHYs, ports or netdevs. Only PSEs which are embedded
> within a PHY, on an MDIO bus, will have a closely linked life
> cycle. But do such devices exist?

i'm not aware of any.

> As soon as the PSE probes with all the resources it needs, and can
> impose a safe default setting. And that can be independent of PHY and
> netdev. I _think_ we only need the netdev for configuration, since
> ethtool addresses netdev's.  There would only be issues with user
> space listening to udev creation events, it knows the PSE exists, but
> it has no way to access it until the netdev is created.

Ack. netdev is for configuration as virtual representation of PSE PI. And it
is easier to assign corresponding interface for the LLDP.
We do not really care about the PHY; it just happens to represent the
port at the farthest end described in the Device Tree.

> > - as soon as we have all needed components, we can start provide
> >   controllable interfaces to serve external consumers.
> 
> Yep.
> 
> > If we decouple PSE and PHY registration (and we probably will need to do
> > it some day), we would need to have own implementation of deferred
> > probing in the PSE core.  Event driven or by polling - which sounds not
> > like very good idea. Pick your poison...
> 
> I don't see why. Maybe i'm missing something. We have two cases:
> 
> 1) PSE probes first. When the PHY looks up the PSE, it exists, and it
> is passed a handle to the PSE.
> 
> 2) PHY probes first. The PSE core returns EPROBE_DEFFER, and the PHY
> will try again later.
> 
> I don't think there is any chicken/egg problems.

Ack, i guess it is optimization problem.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


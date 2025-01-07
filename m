Return-Path: <netdev+bounces-155972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B0AA0470E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EB3165C57
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10D19067C;
	Tue,  7 Jan 2025 16:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF2C1E52D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268562; cv=none; b=d8hZy6+wtYGXfaCZ2eRAn1xU6Qx1NGHowkmhx6YVca7Tg//UtMmmurFnq8yHSzwyUsXbXTeqofLzve8LsLkPGWJkt5U73Z6j3qUBXUmMAVLNVjbGCtDX3i+YgkNqDJ0U4ivSN5X96ndN1Qz0y155G6WPMloUUSO3ZNOq0Yq25Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268562; c=relaxed/simple;
	bh=EQ8axY4N0S7/v8XSQLvKRG4Y6LPtoUzKjf/MZxFZ4C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqJrKodOBE7muRUj09zpSVt8xVdrboJ8NPIevIXo+mU6TFYbfRbsOOBz7WXUo+WKvEQEfywClRTv121ljC4Yj6U8Turtx8XBXDmluvlkiMwM2Z4R1z84cYLTzWcKQiWN5gex5Rt2U1nx9i8Jyr47oX/SqErvBxQHVHE7jqen0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVClY-0003IO-68; Tue, 07 Jan 2025 17:49:16 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVClW-007NNg-2N;
	Tue, 07 Jan 2025 17:49:15 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVClX-009ceo-1D;
	Tue, 07 Jan 2025 17:49:15 +0100
Date: Tue, 7 Jan 2025 17:49:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <Z31bC6ymkKBHdYVR@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
 <20250107171507.06908d71@fedora.home>
 <601067b3-2f8a-4080-9141-84a069db276e@lunn.ch>
 <Z31ZOjLcE34CNj0S@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z31ZOjLcE34CNj0S@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 05:41:30PM +0100, Oleksij Rempel wrote:
> On Tue, Jan 07, 2025 at 05:22:51PM +0100, Andrew Lunn wrote:
> > >   I have however seen devices that have a 1G PHY connected to a RJ45
> > > port with 2 lanes only, thus limiting the max achievable speed to 100M.
> > > Here, we would explicietly describe the port has having 2 lanes. 
> 
> I can confirm existence of this kind of designs. One industrial real life
> example: a SoC connected to 3 port Gigabit KSZ switch. One port is
> typical RJ45 connector. Other port is RJ11 connector.
> 
> The speed can be reduced by using max-speed property. But i can't
> provide any user usable diagnostic information just by saying pair A or
> B is broken.
> 
> This is one of the reasons why i propose detailed description.

Here is one example:
https://www.balluff.com/de-de/products/BNI004F?gad_source=1&gclid=Cj0KCQiAvvO7BhC-ARIsAGFyToUmOy6VpSZUszHQ9X4tuUlyLdtAZqkk3tKxggF5z7D1pk3CgH5IOvwaAhhUEALw_wcB

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


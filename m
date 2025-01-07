Return-Path: <netdev+bounces-155913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1B8A04534
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F103A35FD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAE71F2C41;
	Tue,  7 Jan 2025 15:54:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E921EE006
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265254; cv=none; b=KmVzhWz6qJLrfvjtBBYGAb6MjlCLw8vJtrtWki69ZZYq+78J1wDnI0QEmQietuLteL/jffmbZHglHpY/zD7bnrxefTGAMrTb/U+05+f0mVHOrcy+VwkDN+19fyQyZ7XG+/fCdBY91UWsKZNWHHhpwZj1uCyDcp1wPt/sU9ReYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265254; c=relaxed/simple;
	bh=NZKrdXX7Nslq9MVCszlZQlEHWf2q5r0Mtn8YhyINxcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0JzBbEuoUst9f9Z0f23VRVv7Lf/RieXR19vsC0KaVfNFGSCOOOPxxRZ2Tem0ErK8+R+RxPqNrEvuXRJi+BMhzVwQ0GWO3eVtI13kxJGjIw5+eyRN0Xa8KVAnUVmIANivnDj8ccQM3f8SXTeVwjuvc6lNTeCHsaIlPMdv00v7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVBuB-00085a-1F; Tue, 07 Jan 2025 16:54:07 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVBu8-007MxW-1M;
	Tue, 07 Jan 2025 16:54:05 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVBu9-009bxi-0E;
	Tue, 07 Jan 2025 16:54:05 +0100
Date: Tue, 7 Jan 2025 16:54:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Z31OHYsfZc8fT--Z@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z300BuATJoVDc_4S@pengutronix.de>
 <Z31E4_oWPmFgvfxl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z31E4_oWPmFgvfxl@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 03:14:43PM +0000, Russell King (Oracle) wrote:
> On Tue, Jan 07, 2025 at 03:02:46PM +0100, Oleksij Rempel wrote:
> > On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> > > On Thu, 2 Jan 2025 18:03:52 +0100
> > > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > The IEEE 802.3 - 2022 has following variants:
> > 14.5.2 Crossover function - only A<>B swap is supported
> > 40.4.4 Automatic MDI/MDI-X Configuration - only A<>B swap is supported?
> > 55.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> > 113.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> > 126.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> > 
> > This was only the pair swap. How to reflect the polarity swap withing
> > the pairs?
> 
> 802.3 supports this because of the problems caused by miswired cables,
> which are typically a user thing. It's not really there to give freedom
> to designers to wire their sockets incorrectly.
> 
> Do we have any real cases where a socket has been wired incorrectly?

Yes. I tested some low cost adapter using same driver but reporting
incorrect results, depending on board. I can explain it only by
incorrect PCB design.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


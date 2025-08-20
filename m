Return-Path: <netdev+bounces-215171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEFB2D5A4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5487517CC69
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0B52D7818;
	Wed, 20 Aug 2025 08:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45882D8DC3
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677194; cv=none; b=XWk6YgVwsI5/JIiYHyAb0jZzPkseZ7nX23flcaAmJBxPjsZUiJKM4ZvnDA59ATPwAAWelMocgmtOwQA0BLgDIq2LyHRprfaVbzi3pi6wqDQnVJyXjgPPfyaLIVCGk9GuA+wSikQHOJoCguVOaeh6DAhuSANGeoGoAkoLoqbdb50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677194; c=relaxed/simple;
	bh=TSEWfehoPdM3gmaj9QZJ0UPUmwRx/M938OT2evtPpS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C78JuR4eOgE8PQNbwTc6AA1/4RBS4FQY+8MKV4a5O/hvmOZuVFvfZ6NZtNmSfgI4wOlqZfl5gklyTt9UeGxY48q4axIygfTQ2kZyj20nYS+sBYRR2mueNUngy2X5P2GXwNkA9ce64JD25KFLClCVeVTvC08mekWeVPKa2U5dAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uodpj-0007v7-DH; Wed, 20 Aug 2025 10:06:11 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uodpi-001DLk-0F;
	Wed, 20 Aug 2025 10:06:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uodph-005rZz-36;
	Wed, 20 Aug 2025 10:06:09 +0200
Date: Wed, 20 Aug 2025 10:06:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com
Subject: Re: [PATCH net-next v2 1/1] Documentation: networking: add detailed
 guide on Ethernet flow control configuration
Message-ID: <aKWB8QA8fTwrZhFb@pengutronix.de>
References: <20250814075342.212732-1-o.rempel@pengutronix.de>
 <36bdd275-25bb-4b53-a14d-39677da468cc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36bdd275-25bb-4b53-a14d-39677da468cc@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Aug 19, 2025 at 02:48:22PM +0200, Andrew Lunn wrote:
> > +2. Half-Duplex: Collision-Based Flow Control
> > +--------------------------------------------
> > +On half-duplex links, a device cannot send and receive simultaneously, so PAUSE
> > +frames are not used. Flow control is achieved by leveraging the CSMA/CD
> > +(Carrier Sense Multiple Access with Collision Detection) protocol itself.
> > +
> > +* **How it works**: To inhibit incoming data, a receiving device can force a
> > +    collision on the line. When the sending station detects this collision, it
> > +    terminates its transmission, sends a "jam" signal, and then executes the
> > +    "Collision backoff and retransmission" procedure as defined in IEEE 802.3,
> > +    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> > +    period before attempting to retransmit. By repeatedly forcing collisions,
> > +    the receiver can effectively throttle the sender's transmission rate.
> > +
> > +.. note::
> > +    While this mechanism is part of the IEEE standard, there is currently no
> > +    generic kernel API to configure or control it. Drivers should not enable
> > +    this feature until a standardized interface is available.
> 
> Interesting. I did not know about this.
> 
> I wounder if we want phylib and phylink to return -EOPNOTSUPP in the
> general code, if the current link is 1/2 duplex?

Rejecting ethtool -A calls in half-duplex mode would cause problems. At
request time we often don’t know what the final link will be (autoneg,
fixed link, link flapping, etc.). On top of that, PAUSE conflicts not
only with half-duplex, but also with PFC.

A cleaner model is to treat ethtool pause config as a wish specifically
for 802.3x PAUSE. Phylib/phylink store this wish and apply it
automatically when the negotiated link is compatible (full-duplex
without PFC). If the link is not compatible (half-duplex, PFC), the wish
is ignored.

So the user always sets their preference once, the kernel enforces it
when possible, and status queries (ethtool -a) show the actual active
state. This avoids races and keeps semantics simple and predictable.

> > +Additionally, some MACs provide a way to configure the `pause_time` value
> > +(quanta) sent in PAUSE frames. This value's duration depends on the link
> > +speed. As there is currently no generic kernel interface to configure this,
> > +drivers often set it to a default or maximum value, which may not be optimal
> > +for all use cases.
> 
> The Mellanox driver has something in this space. It is a long time ago
> that i reviewed the patches. I don't remember if it is a pause_time
> you can configure, or the maximum number of pause frames you can send
> before giving up and just letting the buffers overflow. I also don't
> remember what API is used, if it is something custom, or generic. It
> is a bit of a niche thing, so maybe it is not worth researching and
> mentioning.

I did some digging. A number of drivers simply hard-code the pause
quanta to the maximum value for all link modes:

stmmac: #define PAUSE_TIME 0xffff
lan78xx: pause_time_quanta = 65535
smsc95xx / smsc75xx: flow = 0xFFFF0002
FEC: FEC_ENET_OPD_V  = 0xFFF0

If we translate quanta into real time:
1 Gbps -> 1 quanta = 512 ns -> max val ~ 33.6 ms
100 Mbps -> 1 quanta = 5.12 µs -> max val ~ 335 ms
10 Mbps -> 1 quanta = 51.2 µs -> max val ~ 3.3 s

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


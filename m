Return-Path: <netdev+bounces-201545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C2AE9D5C
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9EB5A023E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A37218ABA;
	Thu, 26 Jun 2025 12:21:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0971E9B04
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940463; cv=none; b=uJTXI5QxmXWKWm6zwutvWZeSrr7kUDqTbVhe1pHAgI9/m8KwAfShGfgeEG0d8gDnv/mwaIX759Sqr/juq57sn2hJe/LMJV9Gl1EL1aaSQN/w78iKEi2vGVZY2oL8Pmz9WWXgpaFMjou5cNHzQwT0h4m/yBKH14vyTmYO1F/BfoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940463; c=relaxed/simple;
	bh=UfIaVjPR+dlZRMg3kV5PE/TLrn4vs2+ACMaK/AXQ0f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzXZAJ/t29XQrTzdnPnYObNEYhjO8HG3GplC2SrCve8zLWqHRzwu2kxcnJwWte67P657RI92K7w0zMb08my8Q5/0vIoTqD50t9WD0m1LjKYfyATl/LWe3M0/8O3rpGgDPHIlCToE27LLP8JHo3ueoi4S4dMENUvCJvsmO9mFx6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uUlb3-0008Io-1q; Thu, 26 Jun 2025 14:20:53 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUlb1-005RgD-2A;
	Thu, 26 Jun 2025 14:20:51 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uUlb1-001Zfo-1l;
	Thu, 26 Jun 2025 14:20:51 +0200
Date: Thu, 26 Jun 2025 14:20:51 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 1/1] phy: micrel: add Signal Quality
 Indicator (SQI) support for KSZ9477 switch PHYs
Message-ID: <aF07I-QtyH8hbupf@pengutronix.de>
References: <20250625124127.4176960-1-o.rempel@pengutronix.de>
 <5a094e3b95f1219435056d87ca4f643398bcb1d3.camel@pengutronix.de>
 <aFzWiZ9ohbE_Unuz@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFzWiZ9ohbE_Unuz@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Thu, Jun 26, 2025 at 07:11:38AM +0200, Oleksij Rempel wrote:
> On Wed, Jun 25, 2025 at 08:06:32PM +0200, Lucas Stach wrote:
> > Hi Oleksij,
> > 
> > Am Mittwoch, dem 25.06.2025 um 14:41 +0200 schrieb Oleksij Rempel:
> > > Add support for the Signal Quality Index (SQI) feature on KSZ9477 family
> > > switches. This feature provides a relative measure of receive signal
> > > quality.
> > > 
> > > The KSZ9477 PHY provides four separate SQI values for a 1000BASE-T link,
> > > one for each differential pair (Channel A-D). Since the current get_sqi
> > > UAPI only supports returning a single value per port, this
> > > implementation reads the SQI from Channel A as a representative metric.
> > 
> > I wonder if it wouldn't be more useful to report the worst SQI from all
> > the channels instead.
> 
> It was my first idea too, just to report the worst SQI from all
> channels. But this makes it impossible to report SQI for each pair
> later. If we ever want to support SQI per pair, the current code would
> suddenly start to show only SQI for pair A, not the worst one, so the
> SQI interface would change meaning without warning.
> 
> There is another problem if we want to extend the SQI UAPI for per-pair
> support: with 100Mbit/s links, we can't know which pair is used. The PHY
> reports SQI only for the RX pair, which can change depending on MDI-X
> resolution, and with auto MDI-X mode, this PHY doesn't tell us which
> pair it is.
> 
> That means, at this point, we have hardware which in some modes can't
> provide pair-related information. So, it is better to keep the already
> existing UAPI explicitly per link instead of per pair. This matches the
> current hardware limits and avoids confusion for users and developers.
> If we want per-pair SQI in the future, the API must handle these cases
> clearly.

...

> > This ends up spending a sizable amount of time just spinning the CPU to
> > collect the samples for the averaging. Given that only very low values
> > seem to indicate a working link, I wonder how significant the
> > fluctuations in reported link quality are in reality. Is it really
> > worth spending 120us of CPU time to average those values?
> > 
> > Maybe a running average updated with a new sample each time this
> > function is called would be sufficient?
> 
> Hm. Good point. I'l try it. We already have proper interface for this
> case :)

After some more testing with a signal generator, I started to doubt the
usability of our SQI hardware implementation in this case.

The problem is: the signal issue can only be detected if data transfer is
ongoing - more specifically, if data is being received (for example, when
running iperf). The SQI register on this hardware is updated every 3 µs. This
means if any data is received within this window, we can detect noise on the
wire. But if there is no transfer, the SQI register always shows perfect link
quality.

On the other hand, as long as noise or a sine wave is injected into the twisted
pair, it is possible to see bandwidth drops in iperf, but no other error
counters indicate problems. Even the RxErr counter on the PHY side stays silent
(it seems to detect only other kinds of errors). If SQI is actively polled
during this time, it will show a worse value - so in general, SQI seems to be
usable.

At an early stage of the SQI implementation, I didn’t have a strong opinion
about the need to differentiate these interfaces. But now, based on practical
experience, I see that the difference is very important.

It looks like we have two types of SQI hardware implementations:

- Hardware which provides the worst value since last read

- Hardware which automatically updates the value every N microseconds

- Hardware which provides both values

Both types are recommended by the Open Alliance as:

- "worst case SQI value since last read"

- "current SQI value"

My question is: do we really need both interfaces? The "current SQI value"
seems impractical if it only reflects quality during active data transfer.

What do you think?

Best Regards,
Oleksij
--- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


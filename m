Return-Path: <netdev+bounces-196071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B4AD3716
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF843BCAE1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259942989A3;
	Tue, 10 Jun 2025 12:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26952BD585
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749559028; cv=none; b=NnVuFXh6PlVhaNvp0BMovoppr+sTqQvmVCrRa+IVdbx8CdCHb1k0+HL0Yq3vTarTRJS0C83qt3YbAHBXiK8VkAZxhYU8E/REzD5YYp/XnYbyezNSfM+QN/suoy1jpL/g92d1rQJzGuQr0pZTyZDDHQSxS9fAFYQ+UIujK8iODgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749559028; c=relaxed/simple;
	bh=Y2+mkO42/awpZM2bLETZj0n6m3//E5rkkcfN2qCdTaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3grU1GtavOrJK985UFZPsD1zWSNY3+1zibwOWGb8KQod0KSVnGOm42j5PpHfY6CF/GrYYR/Vs1yzwA/2yMEnrE3qlZStQvlm4wrF9qc4y7XGJvMh20HL2NEICjciYS4BFv2k4m5YyMz3T6Hu1BID7Pk0zdMkvfz8Tec94eUgbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyDd-0004QT-5V; Tue, 10 Jun 2025 14:36:45 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyDb-002mF7-2Q;
	Tue, 10 Jun 2025 14:36:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOyDb-004pqg-1x;
	Tue, 10 Jun 2025 14:36:43 +0200
Date: Tue, 10 Jun 2025 14:36:43 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: dp83tg720: implement soft
 reset with asymmetric delay
Message-ID: <aEgm25HcomOxE8oX@pengutronix.de>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
 <20250610081059.3842459-2-o.rempel@pengutronix.de>
 <534b3aed-bef5-410e-b970-495b62534d96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <534b3aed-bef5-410e-b970-495b62534d96@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jun 10, 2025 at 02:16:39PM +0200, Andrew Lunn wrote:
> On Tue, Jun 10, 2025 at 10:10:57AM +0200, Oleksij Rempel wrote:
> > From: David Jander <david@protonic.nl>
> > 
> > Add a .soft_reset callback for the DP83TG720 PHY that issues a hardware
> > reset followed by an asymmetric post-reset delay. The delay differs
> > based on the PHY's master/slave role to avoid synchronized reset
> > deadlocks, which are known to occur when both link partners use
> > identical reset intervals.
> > 
> > The delay includes:
> > - a fixed 1ms wait to satisfy MDC access timing per datasheet, and
> > - an empirically chosen extra delay (97ms for master, 149ms for slave).
> > 
> > Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Signed-off-by: David Jander <david@protonic.nl>
> 
> Hi Oleksij
> 
> Since you are submitting it, your Signed-off-by should come last. The
> order signifies the developers who passed it along towards merging.

Ack. checkpatch blamed it, so i changed the order.

> > ---
> >  drivers/net/phy/dp83tg720.c | 75 ++++++++++++++++++++++++++++++++-----
> >  1 file changed, 65 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
> > index 7e76323409c4..2c86d05bf857 100644
> > --- a/drivers/net/phy/dp83tg720.c
> > +++ b/drivers/net/phy/dp83tg720.c
> > @@ -12,6 +12,42 @@
> >  
> >  #include "open_alliance_helpers.h"
> >  
> > +/*
> > + * DP83TG720 PHY Limitations and Workarounds
> > + *
> > + * The DP83TG720 1000BASE-T1 PHY has several limitations that require
> > + * software-side mitigations. These workarounds are implemented throughout
> > + * this driver. This section documents the known issues and their corresponding
> > + * mitigation strategies.
> 
> Is there a public errata you can reference?

The PHY Reset Sequence on polling is described in the "DP83TC81x,
DP83TG72x Software Implementation Guide", A Appendix:
https://www.ti.com/lit/an/snla404/snla404.pdf

I do not have access to the errata sheet.

> > + *
> > + * 1. Unreliable Link Detection and Synchronized Reset Deadlock
> > + * ------------------------------------------------------------
> > + * After a link loss or during link establishment, the DP83TG720 PHY may fail
> > + * to detect or report link status correctly. To work around this, the PHY must
> > + * be reset periodically when no link is detected.
> > + *
> > + * However, in point-to-point setups where both link partners use the same
> > + * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
> > + * This leads to a deadlock, where both PHYs reset at the same time and
> > + * continuously miss each other during auto-negotiation.
> > + *
> > + * To address this, the reset procedure includes two components:
> > + *
> > + * - A **fixed minimum delay of 1ms** after issuing a hardware reset, as
> > + *   required by the "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with
> > + *   SGMII and RGMII" datasheet. This ensures MDC access timing is respected
> > + *   before any further MDIO operations.
> > + *
> > + * - An **additional asymmetric delay**, empirically chosen based on
> > + *   master/slave role. This reduces the risk of synchronized resets on both
> > + *   link partners. Values are selected to avoid periodic overlap and ensure
> > + *   the link is re-established within a few cycles.
> 
> Maybe there is more about this in the following patches, i've not read
> them yet. Does autoneg get as far as determining master/slave role? Or
> are you assuming the link partners are somehow set as
> prefer_master/prefer_slave?

This PHY do not support autoneg (as required for automotive PHYs),
master/slave roles should be assigned by strapping or from software to
make the link functional.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


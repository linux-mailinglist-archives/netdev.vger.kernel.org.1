Return-Path: <netdev+bounces-155574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C241A02FA2
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93A007A03A4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC471DE3AB;
	Mon,  6 Jan 2025 18:17:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFE1547F3
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187463; cv=none; b=nq8S/fOf7dfOY6fx9uSmEwTV++VfUv2ZWtzD/ns6989pDTi1VeDfObb7cuTSPxTsLx/BpRvqGT/kg/DLA0zOW2lV8gRhel4hRxtvzHGRPAEMbPmLq6ZmpFY8otKenEbPnHIiVXKsLQG50ML9xpAGHX+9ZosG1IzbhBtuctdd1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187463; c=relaxed/simple;
	bh=3Jl/fmwpPMiDYEOna2UqWRpaKkMP1JR0ZRB5vNlNUKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3znHwG4Vc++cTm7SgiPVYqCUnNtczg6oDCqHSPSxot1doRT47OY90Bonz42YKn6GC5SSSKIv/NKwmdRRD2xLrnD9DpM4ipVgElUs9Jmf0xZaryvcLdptGFi2J1EtAb3bMxmgJ8gA1XWVQEabb1QRuho2b+O7uHEB7ki3sinuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tUrfV-00070y-Fp; Mon, 06 Jan 2025 19:17:37 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tUrfS-007DDy-2w;
	Mon, 06 Jan 2025 19:17:35 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tUrfT-007iFk-1m;
	Mon, 06 Jan 2025 19:17:35 +0100
Date: Mon, 6 Jan 2025 19:17:35 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
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
Message-ID: <Z3weP2JpURuRgHnb@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <20250104232359.2c7a7090@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104232359.2c7a7090@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jan 04, 2025 at 11:23:59PM +0100, Kory Maincent wrote:
> On Sun, 22 Dec 2024 19:54:37 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >         pse = <&pse1>; /* Reference to the attached PSE controller */
> 
> The PSE pairset and polarity are already described in the PSE bindings.
> https://elixir.bootlin.com/linux/v6.12.6/source/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> 
> I am not sure it is a good idea to have PSE information at two different places.


You are right, the PSE PI node already covers the IEEE specifications. But
there are still some missing pieces. These are not directly tied to the PSE but
are important for port functionality, like LEDs, thermal sensors, and
transformer characteristics.  

### Why Link to the Port Node  

While LEDs, thermal zones, and other components can be described in the Device
Tree, there’s currently no clear way to indicate which ones belong to a
specific port. For single-port devices, this isn’t a big issue, but for devices
like switches with multiple ports, it gets messy very quickly.  

For example:  
- LEDs: Each port may have multiple LEDs for link, activity, and PoE
status. Without linking them to specific ports, the software cannot correctly
map these LEDs to their respective functionalities.
 
- Thermal Sensors: Sensors located near specific ports or magnetics are crucial
for thermal management. If they aren’t linked to a port, it’s unclear which
sensor data applies to which port.  

### Why Transformer Characteristics Matter  

Transformers (magnetics) are critical for Ethernet and affect software in these
ways:  

1. Signal Integrity:  
   - Transformers influence noise and insertion loss.
   - Some PHYs allow analog tuning for the connected transformer. Software
     needs this information to configure PHY registers for optimal performance.  

2. Power Delivery:  
   - Transformers have power and current limits.  
   - Software must ensure the power budget stays within these limits and detect
     overcurrent conditions.  

3. Thermal Management:  
   - Transformers can overheat under load.
   - Software should monitor nearby sensors and reduce power if temperatures
     exceed safe levels.  

This functionality does not need to be added right now. However, I’ve
encountered some of these issues and believe they may impact others sooner or
later. It would be good if newly added specifications avoid conflicting with or
blocking potential solutions to these known issues.

> > In case of PoDL, we will have something like this:
> > 
> > pair@0 {
> >     name = "A"; /* Single pair for 10BaseT1L */
> >     pins = <1 2>; /* Connector pins */
> >     phy-mapping = <PHY_TXRX0_P PHY_TXRX0_N>; /* PHY pin mapping */
> >     podl-mapping = <PODL_OUT0_P PODL_OUT0_N>; /* PoDL mapping: Positive and
> > negative outputs */ };
> 
> We should do the same for PoDL. Put all information in the same place, the PSE
> bindings.

Ack.

Since IEEE does not provide anything beyond pinout and polarity description for
PSE PI specifications (at least for PoE variants), let's keep those details
there. Magnetics, being a shared component, should be described as part of the
port. Thermal sensors located near magnetics or physical ports are port-related
and should also be linked to the port. LEDs, however, fall into different
groups: some are connected to PHYs, others to PSE, and they may be controlled
by PHYs, PSE, or external controllers with software. These LEDs need a clear
linkage to their corresponding port functionality. What would be the best way
to establish this linkage without introducing unnecessary complexity?

Best regards,  
Oleksij  
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


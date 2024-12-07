Return-Path: <netdev+bounces-149889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9309E7ED7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 09:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DEB1886D55
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A713CA9C;
	Sat,  7 Dec 2024 08:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB312C7FD
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558457; cv=none; b=iWMLIB4fvuB91ZDPEjrA9bOzdyiAp013jFXv4OEeXhl4NIF+aKXmIVNxddRSpUEid4be8ME6f77jj5rpeaB+bkpM4tBRyP7s8JVD2A+8lNZIvMpfQYX0bJNR+aSJfyrVEobOmMR3pD0oxjzHAB1BwH+jIB/hJXEfnJYy7UOff68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558457; c=relaxed/simple;
	bh=bulXPnQNHNpWHhSyrqhdpYMUDxHnpSJESZklGOTCKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBEUmSLR2NqHxWrBh54QptfjOdaN/jAKpg/aBE1pdH0miaDP00BTQkvltG10HhOlNXm8A1cMRa+HSJBEIIHFFv55CqTJrMoPFydsfdebsilO/Up47Ul9Ts87TdozL6ynSeb5V3IILjXyYruVBMdgx2YeukIxKdt2/q/7L3gjJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tJpju-00061t-9k; Sat, 07 Dec 2024 09:00:34 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJpjr-0028W7-1K;
	Sat, 07 Dec 2024 09:00:32 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tJpjs-002fei-0E;
	Sat, 07 Dec 2024 09:00:32 +0100
Date: Sat, 7 Dec 2024 09:00:32 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 1/5] dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
Message-ID: <Z1QAoAmXlBoixIS4@pengutronix.de>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-2-o.rempel@pengutronix.de>
 <20241205-immortal-sneak-8c5a348a8563@spud>
 <Z1KxZmRekrYGSdd4@pengutronix.de>
 <20241206-wrought-jailbreak-52cc4a21a713@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206-wrought-jailbreak-52cc4a21a713@spud>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Dec 06, 2024 at 04:57:01PM +0000, Conor Dooley wrote:
> On Fri, Dec 06, 2024 at 09:10:14AM +0100, Oleksij Rempel wrote:
> > On Thu, Dec 05, 2024 at 05:18:59PM +0000, Conor Dooley wrote:
> > > On Thu, Dec 05, 2024 at 01:56:36PM +0100, Oleksij Rempel wrote:
> > > > Introduce devicetree binding for the Texas Instruments DP83TD510
> > > > Ultra Low Power 802.3cg 10Base-T1L Single Pair Ethernet PHY.
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > >  .../devicetree/bindings/net/ti,dp83td510.yaml | 35 +++++++++++++++++++
> > > >  1 file changed, 35 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83td510.yaml b/Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> > > > new file mode 100644
> > > > index 000000000000..cf13e86a4017
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> > > > @@ -0,0 +1,35 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/ti,dp83td510.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: TI DP83TD510 10BaseT1L PHY
> > > > +
> > > > +maintainers:
> > > > +  - Oleksij Rempel <o.rempel@pengutronix.de>
> > > > +
> > > > +description:
> > > > +  DP83TD510E Ultra Low Power 802.3cg 10Base-T1L 10M Single Pair Ethernet PHY
> > > > +
> > > > +allOf:
> > > > +  - $ref: ethernet-phy.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - ethernet-phy-id2000.0181
> > > 
> > > There's nothing specific here, can someone remind me why the generic
> > > binding is not enough?
> > 
> > The missing binding was blamed by checkpatch. Haw should I proceed with this
> > patch?
> 
> Does dtbs_check complain when you use it in a dts? What you have here
> matches against the pattern ^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$
> so I think it won't. checkpatch might be too dumb to evaluate the regex?

dtbs_check didn't complained about it, only checkpatch.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


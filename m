Return-Path: <netdev+bounces-155865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3AA041B9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D2216702A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A61F9410;
	Tue,  7 Jan 2025 14:03:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C961F8AE7
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258582; cv=none; b=iY8K1UjdJjgqL9It590n/bLobfeK0x+rkuU3JqajRsgcAsYJ0Mmn+3mzVpTpm/Zuh5k8Yk9QGYX396Gs9mUHk3TbKHGvfjhb59xTTPqegIQQGdBTB+rFlHqwgNTXvEQ6+09ALMPtqNZ0JNnU51A+per+fh9Hy3ZcWW+npGUYXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258582; c=relaxed/simple;
	bh=/lAC7NXIey1ZuH7WjX/6NB0HEBVim6c3pkzgBWmHeiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usz8PrLdsoUx5bozatD1EZxxw7/dRhxZv5B8F3JFLpOYSBYN1uPqcjJJWzvBNiNzrFsbHvhpeLrqYpv22y+mnAqb5PfF4vabno7iWzAWWd39FtnuOrANXOKOmiYoMPgfJIZnDmFNVz/tYZCcvjW3CKMMDKqUWVDRNJfx6ZTgVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAAR-0007Xm-QU; Tue, 07 Jan 2025 15:02:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAAQ-007M3c-1B;
	Tue, 07 Jan 2025 15:02:47 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVAAQ-009aOe-33;
	Tue, 07 Jan 2025 15:02:47 +0100
Date: Tue, 7 Jan 2025 15:02:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
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
Message-ID: <Z300BuATJoVDc_4S@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> On Thu, 2 Jan 2025 18:03:52 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote:
> > > On Sun, Dec 22, 2024 at 07:54:37PM +0100, Oleksij Rempel wrote:  
> > > > Here is updated version:
> > > > 
> > > > ports {
> > > >     /* 1000BaseT Port with Ethernet and simple PoE */
> > > >     port0: ethernet-port@0 {
> > > >         reg = <0>; /* Port index */
> > > >         label = "ETH0"; /* Physical label on the device */
> > > >         connector = "RJ45"; /* Connector type */
> > > >         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported
> > > > modes */
> > > > 
> > > >         transformer {
> > > >             model = "ABC123"; /* Transformer model number */
> > > >             manufacturer = "TransformerCo"; /* Manufacturer name */
> > > > 
> > > >             pairs {
> > > >                 pair@0 {
> > > >                     name = "A"; /* Pair A */
> > > >                     pins = <1 2>; /* Connector pins */
> > > >                     phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin
> > > > mapping */ center-tap = "CT0"; /* Central tap identifier */
> > > >                     pse-negative = <PSE_GND>; /* CT0 connected to GND */
> > > >                 };
> > > >                 pair@1 {
> > > >                     name = "B"; /* Pair B */
> > > >                     pins = <3 6>; /* Connector pins */
> > > >                     phy-mapping = <PHY_RX0_P PHY_RX0_N>;
> > > >                     center-tap = "CT1"; /* Central tap identifier */
> > > >                     pse-positive = <PSE_OUT0>; /* CT1 connected to
> > > > PSE_OUT0 */ };
> > > >                 pair@2 {
> > > >                     name = "C"; /* Pair C */
> > > >                     pins = <4 5>; /* Connector pins */
> > > >                     phy-mapping = <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY
> > > > connection only */ center-tap = "CT2"; /* Central tap identifier */
> > > >                     /* No power connection to CT2 */
> > > >                 };
> > > >                 pair@3 {
> > > >                     name = "D"; /* Pair D */
> > > >                     pins = <7 8>; /* Connector pins */
> > > >                     phy-mapping = <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY
> > > > connection only */ center-tap = "CT3"; /* Central tap identifier */
> > > >                     /* No power connection to CT3 */
> > > >                 };
> > > >             };
> > > >         };  
> 
> Couldn't we begin with something simple like the following and add all the
> transformers and pairs information as you described later if the community feels
> we need it?
> 
> mdis {
> 
>     /* 1000BaseT Port with Ethernet and PoE */
>     mdi0: ethernet-mdi@0 {
>         reg = <0>; /* Port index */
>         label = "ETH0"; /* Physical label on the device */
>         connector = "RJ45"; /* Connector type */
>         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes */
>         lanes = <2>;
>         variant = "MDI-X"; /* MDI or MDI-X */
>         pse = <&pse1>;
>     };
> };

The problematic properties are lanes and variants.

Lanes seems to not provide any additional information which is not
provided by the supported-modes.

We have at least following working variants, which are supported by (some?)
microchip PHYs:
https://microchip.my.site.com/s/article/1000Base-T-Differential-Pair-Swapping
For swapping A and B pairs, we may use MDI/MDI-X. What is about swapped
C and D pairs?

The IEEE 802.3 - 2022 has following variants:
14.5.2 Crossover function - only A<>B swap is supported
40.4.4 Automatic MDI/MDI-X Configuration - only A<>B swap is supported?
55.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
113.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
126.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported

This was only the pair swap. How to reflect the polarity swap withing
the pairs?

> We can also add led, thermal and fuse subnodes later.
> Let's begin with something simple for the initial support, considering
> that it has places for additional details in the future.

Yes :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


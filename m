Return-Path: <netdev+bounces-155899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943CAA043F0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0426C18871C8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C601F239E;
	Tue,  7 Jan 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vhJbGUgW"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945AD1F239C;
	Tue,  7 Jan 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262892; cv=none; b=qyuyDKoYAhfCrzOrW+9s5k14nB7vcE+Br/qaDeCGPH/mqNyNuypTYG9nXN9Ts/1ppIm+ZnYKHkHflVXuwhoN3sCUN7O2huyIkcDseLp0OZuxZbDRKoH07IpVtlV3gUdT5uLw7C5CUB7ZO4ZyEOprIn2xm0tLsh02FQ6Hb9Cwbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262892; c=relaxed/simple;
	bh=1XWrmZu5Z7kkKKjFE5izCSehXnTf69c8dHgf9xiWnCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEgc2Wm0Q47WS7QOdgQfTQpEhYzvPaHdZKtOZXqsjvr6otGmQzoWz7WhLALzW6m6OqYV1p7NGnuAactyiH1Lirr7k6n8HYM1ZgZDUrOQDT2oqlVQLTkYbz0rVwYY2OzPHU4aS6L16iv/MGLobbnqNjea1H5663vgXi4OWmSyX8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vhJbGUgW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=r9RmLQOMfl0rWJpIYvWk4KZnHv3ahfnPTCrPG72CVSU=; b=vhJbGUgWXA5FWGaLKa5wloDXsK
	UGdrPSDKf7OacsPThP1pQikbaFRHW0RXiIowiwPjyaXpZVbisTfrJGY1AFZtZzREdi/lQSZ+xWNo0
	35puHZlNqahsb6gIvivcFHijIjhdF7umOCvt+k04qsrPX9nkjT4Ho8nhl3QHPCnj7gP9Y5s0cD7yO
	7/rRhnwW0mk7a8WRp0xDfoQo0twWf50mwlKf31vp2oyCJM4ns5X6bQN5OKrhkSFuXmSvS9YD4RytP
	qYI3og+KvdgAedcdpyZFUWoP5sfVGSC0eJGiQqBhMcl5GOiZ2J5NTkWQGuhmDvzDGHSqjYV98A+8P
	M2m56bug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48082)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVBI5-0007fG-21;
	Tue, 07 Jan 2025 15:14:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVBI3-0005OL-2x;
	Tue, 07 Jan 2025 15:14:43 +0000
Date: Tue, 7 Jan 2025 15:14:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
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
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <Z31E4_oWPmFgvfxl@shell.armlinux.org.uk>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
 <Z2g3b_t3KwMFozR8@pengutronix.de>
 <Z2hgbdeTXjqWKa14@pengutronix.de>
 <Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
 <Z3bG-B0E2l47znkE@pengutronix.de>
 <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
 <Z300BuATJoVDc_4S@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z300BuATJoVDc_4S@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 07, 2025 at 03:02:46PM +0100, Oleksij Rempel wrote:
> On Tue, Jan 07, 2025 at 02:26:05PM +0100, Kory Maincent wrote:
> > On Thu, 2 Jan 2025 18:03:52 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > On Thu, Jan 02, 2025 at 10:48:05AM +0000, Russell King (Oracle) wrote:
> > > > On Sun, Dec 22, 2024 at 07:54:37PM +0100, Oleksij Rempel wrote:  
> > > > > Here is updated version:
> > > > > 
> > > > > ports {
> > > > >     /* 1000BaseT Port with Ethernet and simple PoE */
> > > > >     port0: ethernet-port@0 {
> > > > >         reg = <0>; /* Port index */
> > > > >         label = "ETH0"; /* Physical label on the device */
> > > > >         connector = "RJ45"; /* Connector type */
> > > > >         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported
> > > > > modes */
> > > > > 
> > > > >         transformer {
> > > > >             model = "ABC123"; /* Transformer model number */
> > > > >             manufacturer = "TransformerCo"; /* Manufacturer name */
> > > > > 
> > > > >             pairs {
> > > > >                 pair@0 {
> > > > >                     name = "A"; /* Pair A */
> > > > >                     pins = <1 2>; /* Connector pins */
> > > > >                     phy-mapping = <PHY_TX0_P PHY_TX0_N>; /* PHY pin
> > > > > mapping */ center-tap = "CT0"; /* Central tap identifier */
> > > > >                     pse-negative = <PSE_GND>; /* CT0 connected to GND */
> > > > >                 };
> > > > >                 pair@1 {
> > > > >                     name = "B"; /* Pair B */
> > > > >                     pins = <3 6>; /* Connector pins */
> > > > >                     phy-mapping = <PHY_RX0_P PHY_RX0_N>;
> > > > >                     center-tap = "CT1"; /* Central tap identifier */
> > > > >                     pse-positive = <PSE_OUT0>; /* CT1 connected to
> > > > > PSE_OUT0 */ };
> > > > >                 pair@2 {
> > > > >                     name = "C"; /* Pair C */
> > > > >                     pins = <4 5>; /* Connector pins */
> > > > >                     phy-mapping = <PHY_TXRX1_P PHY_TXRX1_N>; /* PHY
> > > > > connection only */ center-tap = "CT2"; /* Central tap identifier */
> > > > >                     /* No power connection to CT2 */
> > > > >                 };
> > > > >                 pair@3 {
> > > > >                     name = "D"; /* Pair D */
> > > > >                     pins = <7 8>; /* Connector pins */
> > > > >                     phy-mapping = <PHY_TXRX2_P PHY_TXRX2_N>; /* PHY
> > > > > connection only */ center-tap = "CT3"; /* Central tap identifier */
> > > > >                     /* No power connection to CT3 */
> > > > >                 };
> > > > >             };
> > > > >         };  
> > 
> > Couldn't we begin with something simple like the following and add all the
> > transformers and pairs information as you described later if the community feels
> > we need it?
> > 
> > mdis {
> > 
> >     /* 1000BaseT Port with Ethernet and PoE */
> >     mdi0: ethernet-mdi@0 {
> >         reg = <0>; /* Port index */
> >         label = "ETH0"; /* Physical label on the device */
> >         connector = "RJ45"; /* Connector type */
> >         supported-modes = <10BaseT 100BaseTX 1000BaseT>; /* Supported modes */
> >         lanes = <2>;
> >         variant = "MDI-X"; /* MDI or MDI-X */
> >         pse = <&pse1>;
> >     };
> > };
> 
> The problematic properties are lanes and variants.
> 
> Lanes seems to not provide any additional information which is not
> provided by the supported-modes.
> 
> We have at least following working variants, which are supported by (some?)
> microchip PHYs:
> https://microchip.my.site.com/s/article/1000Base-T-Differential-Pair-Swapping
> For swapping A and B pairs, we may use MDI/MDI-X. What is about swapped
> C and D pairs?
> 
> The IEEE 802.3 - 2022 has following variants:
> 14.5.2 Crossover function - only A<>B swap is supported
> 40.4.4 Automatic MDI/MDI-X Configuration - only A<>B swap is supported?
> 55.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> 113.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> 126.4.4 Automatic MDI/MDI-X configuration - 4 swap variants are supported
> 
> This was only the pair swap. How to reflect the polarity swap withing
> the pairs?

802.3 supports this because of the problems caused by miswired cables,
which are typically a user thing. It's not really there to give freedom
to designers to wire their sockets incorrectly.

Do we have any real cases where a socket has been wired incorrectly?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


Return-Path: <netdev+bounces-155898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E94CA043D5
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7EF21658CD
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2E1F2362;
	Tue,  7 Jan 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OoLAg7Kz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787081F2381;
	Tue,  7 Jan 2025 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262753; cv=none; b=c/TFeubFpUDY5o9wz+Kb7MVcGqnyngMM3bs5fVh+nG+LQE/kAUKHOx9jyk/jw+/7LXBHrK1qJxVkstgReIxtWSVAjyJEUxqdK5ZF1+nfxOsd96FstZU5dRBqBPzV0VZlorWwBRmyriyYwKBcSjQzRuuaIcBuRH+F9ebjoC4p3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262753; c=relaxed/simple;
	bh=sMU6QrUVIzDWoDqeLk5YvKX+WpeehVJ7dANYnKvqzpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmUn2kCJTdf445qARAZ/cktds6ybo/vuYEPwmXNNHLAKAiBwRzAxjtZqbjXaP3zJzTTaallC/Dx13NYUeTIcurXdbySR0bDSRlUVxEAdHXWuChPWtm7kXP8E1ldmq93w8nTMiniCzYSW2uJRwZPvuKsMNQ5O6YTVHNfJx/mT3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OoLAg7Kz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4gSoWQY/eDDpwLtJoE6aiLAjnCc8d40/2W7DJFumW/I=; b=OoLAg7KzDfXcPCgCVhCIwSnKBx
	/SXiH72xU1dmqGQrJcWQAE9z1ltDlAaelJlcXcr1GNYeHqyBv2+3qCufu0SqKzjlDXT6et5/kc2BW
	RnSDv+VJh6DLtmS8+A1OH0keI2BuU6FSStBLTPt4isOvObCVcFk2Ay3p9UhU/om3eeQaZHnQDEsrX
	tZ56HkISeDwBkJIjy4O/kMRC5sFu1QNqZSXZZPkg2pRcCa+du+W4jupPcyJJwsYegLOH8TkE5lsdB
	ZHNO/NvfPaoH1PuQ+48a7qjTAUn/ug6GOrZNF+IsRYE+Xdbuce6+zgL5IYx8sr69svb1YMZ0w9jw4
	aiJp2P9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53354)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tVBFo-0007eg-0H;
	Tue, 07 Jan 2025 15:12:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tVBFk-0005OB-2j;
	Tue, 07 Jan 2025 15:12:20 +0000
Date: Tue, 7 Jan 2025 15:12:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
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
Message-ID: <Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107142605.6c605eaf@kmaincent-XPS-13-7390>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

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

+1.

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

We already manage well enough without anything like this level of
detail of a RJ45 socket, so why don't we start off with something
very simple. I'm thinking that even giving the supported-modes
argument is too much here - have we *ever* had the case where an
ethernet port can't support all the speeds that it's associated
PHY supports?

> We can also add led, thermal and fuse subnodes later.
> Let's begin with something simple for the initial support, considering
> that it has places for additional details in the future.

What I think we both fear is having a complex DT description of a
port that the kernel mostly ignores. While we can come out with the
"but DT describes the hardware" claptrap, it's no good trying to
describe the hardware in a firmware description unless there is some
way to validate that the firmware description is correct - which
means there must be something that depends on it in order to work.

If we describe stuff that doesn't get used, there's no way to know
if it is actually correct. We then end up with a lot of buggy DT
descriptions with properties that can't be relied upon to be
correct, and that makes those properties utterly useless.

I'm sure DT maintainers will disagree due to the "DT describes the
hardware" but... I've said it here, and if we end up with stuff
over-described wrongly creating a mess, I'll be able to point back
at this!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


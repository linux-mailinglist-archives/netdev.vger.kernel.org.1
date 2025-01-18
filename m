Return-Path: <netdev+bounces-159557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDC7A15C66
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 11:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D3B188995E
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ACD1885BE;
	Sat, 18 Jan 2025 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bhgRqKZp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74D012EBEA;
	Sat, 18 Jan 2025 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737196842; cv=none; b=AVEnDFTvFuJSno3/3LHegbosWGtPtf8aSfGenAZD2yU7Y79XUbgETya7Nk+BRqycx9eex2go/L4ZOCkze+/aS078QBPcFiGCRDJuzkq+VEnaXTmPeUoHcA8wWqvg3K1BA5BTzJ+l4zXO5BzsCR8fkQmuwigmL4vySDIJ8EVaQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737196842; c=relaxed/simple;
	bh=je0pw/tWuTTk9tiNN0hd7ET0ERgnxSblRy8mm2gvaio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3wIi71ASInVgksDJHXR6vVoNu5UGLs0lm7RLYH6qxOX+nWwKpslAFKe9kGEMzU/vCVejobOAGLHk+wtog5myMua5+tWZE3ILKB8sb1HKc/X1fRPvvoA/UrEw71kshfZSWcPp23agBYpA7Gc6kGzq8WUoCU8NYG/Krts1Oc8zpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bhgRqKZp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kw9+y3QvUfbuU55eRQMd2J8xJPwrTnjZEzAcdwWwVSc=; b=bhgRqKZpvqHSk3Bq0U5GzjJpaX
	8r0PtSDKsQO2H8f/aJdrfMo79zH6Uwl75O6ovYfUA/W1Ci2LqfqmCwdOfMcfnGPDmSx/LDnRNbb+d
	hH6H75/PWdNYmdrMjZZK1I1eWR/R5SZzEnV8PNhG+RKxwx21MDK7ellIF96HQcHBzuS/Hiv270Xd3
	pEeiVxgfRtPk1F7/oBYADOr/TV8kfGO4DwliO//ICix2/XvWVLFch41KKj/hxNCAXJN1bGfBoG4vQ
	+kHCF3anMAG55D+Yr+4Q5ihFn6iKzXy40JYgutRwHOnT8jbIm9RC/i6lEZtGgxy/etTC20xCgfgmA
	5oGbRnnA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tZ6Fg-0004Um-2x;
	Sat, 18 Jan 2025 10:40:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tZ6Fe-0000o7-0V;
	Sat, 18 Jan 2025 10:40:26 +0000
Date: Sat, 18 Jan 2025 10:40:26 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4uFGgUVvI3VhxXb@shell.armlinux.org.uk>
References: <Z4AJ4bxLePBbbR2u@pengutronix.de>
 <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
 <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
 <Z4tWpxvwDG9u4MwJ@pengutronix.de>
 <Z4tuhzHwiKFIGZ5e@shell.armlinux.org.uk>
 <Z4t78tI0gXWbDhXT@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4t78tI0gXWbDhXT@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jan 18, 2025 at 11:01:22AM +0100, Oleksij Rempel wrote:
> On Sat, Jan 18, 2025 at 09:04:07AM +0000, Russell King (Oracle) wrote:
> > On Sat, Jan 18, 2025 at 08:22:15AM +0100, Oleksij Rempel wrote:
> > > On Fri, Jan 17, 2025 at 04:23:52PM +0000, Russell King (Oracle) wrote:
> > > > I'm unsure about many DSA drivers. mt753x:
> > > > 
> > > >         u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
> > > > 
> > > >         if (e->tx_lpi_timer > 0xFFF)
> > > >                 return -EINVAL;
> > > > 
> > > >         set = LPI_THRESH_SET(e->tx_lpi_timer);
> > > >         if (!e->tx_lpi_enabled)
> > > >                 /* Force LPI Mode without a delay */
> > > >                 set |= LPI_MODE_EN;
> > > >         mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
> > > > 
> > > > Why force LPI *without* a delay if tx_lpi_enabled is false? This
> > > > seems to go against the documented API:
> > > > 
> > > >  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
> > > >  *      that eee was negotiated.
> > > 
> > > According to MT7531 manual, I would say, the code is not correct:
> > > https://repo.librerouter.org/misc/lr2/MT7531_switch_Reference_Manual_for_Development_Board.pdf
> > > 
> > > The LPI_MODE_EN_Px bit has following meaning:
> > > 
> > > When there is no packet to be transmitted, and the idle time is greater
> > > than P2_LPI_THRESHOLD, the TXMAC will automatically enter LPI (Low
> > > Power Idle) mode and send EEE LPI frame to the link partner.
> > > 0: LPI mode depends on the P2_LPI_THRESHOLD.
> > > 1: Let the system enter the LPI mode immediately and send EEE LPI frame
> > >    to the link partner.
> > 
> > Okay, so LPI_MODE_EN_Px causes it to disregard the LPI timer, and enter
> > LPI mode immediately. Thus, the code should never set LPI_MODE_EN_Px.
> > 
> > > This chip seems to not have support for tx_lpi_enabled != eee_enabled
> > > configuration.
> > 
> > Sorry, I don't see your reasoning there - and I think your
> > interpretation is different from the documentation (which is
> > the whole point of having a generic implementation in phylib
> > to avoid these kinds of different interpretation.)
> > 
> >  * @eee_enabled: EEE configured mode (enabled/disabled).
> >  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
> >  *      that eee was negotiated.
> > 
> >            eee on|off
> >                   Enables/disables the device support of EEE.
> > 
> >            tx-lpi on|off
> >                   Determines whether the device should assert its Tx LPI.
> > 
> > The way phylib interprets eee_enabled is whether EEE is advertised
> > to the remote device or not. If EEE is not advertised, then EEE is
> > not negotiated, and thus EEE will not become active. If EEE is not
> > active, then LPI must not be asserted. tx_lpi_enabled defines whether,
> > given that EEE has been negotiated, whether LPI should be signalled
> > after the LPI timer has expired.
> > 
> > phylib deals with all this logic, and its all encoded into the
> > phydev->enable_tx_lpi flag to give consistency of implementation.
> > 
> > Thus, phydev->enable_tx_lpi is only true when eee_enabled && eee
> > negotiated at the specified speed && tx_lpi_enabled. In that state,
> > LPI is expected to be signalled after the LPI timer has expired.
> 
> I mean, the configuration where EEE can be enabled and in active state,
> but TX LPI is disabled: eee_enabled = true; eee_active = true;
> enable_tx_lpi = false. UAPI allows this configuration and it seems to

enable_tx_lpi is the result of phylib's management, and not a uAPI
thing. I think you mean the uAPI tx_lpi_enabled.

> work for 100Mbit/s. Atheros documentation call it asymmetric EEE
> operation - where each link partner enters LPI mode independently. In
> comparison, the same documentation calls 1000Mbit EEE mode, symmetric
> operation - where both link partner must enter the LPI mode
> simulatneously.

I'm not sure you are entirely correct.

FORCE_MODE_EEE100_P2
FORCE_MODE_EEE1G_P2

These bits seem to control whether the MT753x uses the result of polling
the PHY or the two force bits below to determine whether "EEE ability"
is determined.

FORCE_EEE1G_P2
FORCE_EEE100_P2

These bits determine whether, when their respective FORCE_MODE_EEE*_P2
bit is set, "EEE ability" is set or not.

"EEE ability" in this case would seem to basically be what we call
"EEE active" in kernel speak.

So, an implementation that would support our current uAPI fully would
be:

- Set FORCE_MODE_EEE*_P2 bits (thus making the "EEE ability" be
  under software control rather than the result of the PHY polling
  unit.)
- Set/clear FORCE_EEE*_P2 bits depending on phydev->enable_tx_lpi
- Set the timer according to phydev->eee_cfg.tx_lpi_timer

and that will support the user API in the way that its intended to be.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


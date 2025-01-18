Return-Path: <netdev+bounces-159558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB35A15C82
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 12:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D2B167686
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 11:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943E4188CA9;
	Sat, 18 Jan 2025 11:23:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7815CD78
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737199397; cv=none; b=U/75ZhNnFayBvaZ5j+tPJjzqyq871Md8hnHPZshHzf1c4WZNhcP1i2Tmp0UaygCT8DZYLA2VlFLSNU+YbOhE/GDklflonjeejsIi4uQk7ngPaZfI9SnUNpzQkv+RGc5o25zqgITpBb3qvutS4SEufJoaNnri5dOvzPFc5vYytrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737199397; c=relaxed/simple;
	bh=hrfhDayn1a2dKi3kbVl3niKyKQTXQevZu2e+rTloD8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKn0rIheHpFimXJ/cj8PBMTRFcDWU/c5qZclzEKTQ/DvDsTRir4fyfVUH0jjNDRhRxg0fCN4V8TY4y7WY85azF9B/rrCp6ERMtXFB0MD3IsE+16q2uUnDQJ+0wq1hbOZUOdTw+Euit/xneV9Nw5CWhT+hRPWo6cSWz0r/G8FK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ6uw-0002Bx-2z; Sat, 18 Jan 2025 12:23:06 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ6uu-000aWL-1V;
	Sat, 18 Jan 2025 12:23:04 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tZ6uu-00036G-1A;
	Sat, 18 Jan 2025 12:23:04 +0100
Date: Sat, 18 Jan 2025 12:23:04 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z4uPGIKUbHhZTb9o@pengutronix.de>
References: <Z4ARB96M6KDuPvv8@shell.armlinux.org.uk>
 <80925b27-5302-4253-ad6d-221ba8bf45f4@lunn.ch>
 <Z4UKHp0RopBT5gpI@pengutronix.de>
 <Z4UVQRHqk8ND984c@shell.armlinux.org.uk>
 <38ad9a25-a5b9-48ab-b92d-4c9d9f4c7d62@lunn.ch>
 <Z4qEGIRYvSuVR9AK@shell.armlinux.org.uk>
 <Z4tWpxvwDG9u4MwJ@pengutronix.de>
 <Z4tuhzHwiKFIGZ5e@shell.armlinux.org.uk>
 <Z4t78tI0gXWbDhXT@pengutronix.de>
 <Z4uFGgUVvI3VhxXb@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4uFGgUVvI3VhxXb@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sat, Jan 18, 2025 at 10:40:26AM +0000, Russell King (Oracle) wrote:
> On Sat, Jan 18, 2025 at 11:01:22AM +0100, Oleksij Rempel wrote:
> > On Sat, Jan 18, 2025 at 09:04:07AM +0000, Russell King (Oracle) wrote:
> > > On Sat, Jan 18, 2025 at 08:22:15AM +0100, Oleksij Rempel wrote:
> > > > On Fri, Jan 17, 2025 at 04:23:52PM +0000, Russell King (Oracle) wrote:
> > > > > I'm unsure about many DSA drivers. mt753x:
> > > > > 
> > > > >         u32 set, mask = LPI_THRESH_MASK | LPI_MODE_EN;
> > > > > 
> > > > >         if (e->tx_lpi_timer > 0xFFF)
> > > > >                 return -EINVAL;
> > > > > 
> > > > >         set = LPI_THRESH_SET(e->tx_lpi_timer);
> > > > >         if (!e->tx_lpi_enabled)
> > > > >                 /* Force LPI Mode without a delay */
> > > > >                 set |= LPI_MODE_EN;
> > > > >         mt7530_rmw(priv, MT753X_PMEEECR_P(port), mask, set);
> > > > > 
> > > > > Why force LPI *without* a delay if tx_lpi_enabled is false? This
> > > > > seems to go against the documented API:
> > > > > 
> > > > >  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
> > > > >  *      that eee was negotiated.
> > > > 
> > > > According to MT7531 manual, I would say, the code is not correct:
> > > > https://repo.librerouter.org/misc/lr2/MT7531_switch_Reference_Manual_for_Development_Board.pdf
> > > > 
> > > > The LPI_MODE_EN_Px bit has following meaning:
> > > > 
> > > > When there is no packet to be transmitted, and the idle time is greater
> > > > than P2_LPI_THRESHOLD, the TXMAC will automatically enter LPI (Low
> > > > Power Idle) mode and send EEE LPI frame to the link partner.
> > > > 0: LPI mode depends on the P2_LPI_THRESHOLD.
> > > > 1: Let the system enter the LPI mode immediately and send EEE LPI frame
> > > >    to the link partner.
> > > 
> > > Okay, so LPI_MODE_EN_Px causes it to disregard the LPI timer, and enter
> > > LPI mode immediately. Thus, the code should never set LPI_MODE_EN_Px.
> > > 
> > > > This chip seems to not have support for tx_lpi_enabled != eee_enabled
> > > > configuration.
> > > 
> > > Sorry, I don't see your reasoning there - and I think your
> > > interpretation is different from the documentation (which is
> > > the whole point of having a generic implementation in phylib
> > > to avoid these kinds of different interpretation.)
> > > 
> > >  * @eee_enabled: EEE configured mode (enabled/disabled).
> > >  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
> > >  *      that eee was negotiated.
> > > 
> > >            eee on|off
> > >                   Enables/disables the device support of EEE.
> > > 
> > >            tx-lpi on|off
> > >                   Determines whether the device should assert its Tx LPI.
> > > 
> > > The way phylib interprets eee_enabled is whether EEE is advertised
> > > to the remote device or not. If EEE is not advertised, then EEE is
> > > not negotiated, and thus EEE will not become active. If EEE is not
> > > active, then LPI must not be asserted. tx_lpi_enabled defines whether,
> > > given that EEE has been negotiated, whether LPI should be signalled
> > > after the LPI timer has expired.
> > > 
> > > phylib deals with all this logic, and its all encoded into the
> > > phydev->enable_tx_lpi flag to give consistency of implementation.
> > > 
> > > Thus, phydev->enable_tx_lpi is only true when eee_enabled && eee
> > > negotiated at the specified speed && tx_lpi_enabled. In that state,
> > > LPI is expected to be signalled after the LPI timer has expired.
> > 
> > I mean, the configuration where EEE can be enabled and in active state,
> > but TX LPI is disabled: eee_enabled = true; eee_active = true;
> > enable_tx_lpi = false. UAPI allows this configuration and it seems to
> 
> enable_tx_lpi is the result of phylib's management, and not a uAPI
> thing. I think you mean the uAPI tx_lpi_enabled.

yes.

> > work for 100Mbit/s. Atheros documentation call it asymmetric EEE
> > operation - where each link partner enters LPI mode independently. In
> > comparison, the same documentation calls 1000Mbit EEE mode, symmetric
> > operation - where both link partner must enter the LPI mode
> > simulatneously.
> 
> I'm not sure you are entirely correct.
> 
> FORCE_MODE_EEE100_P2
> FORCE_MODE_EEE1G_P2
> 
> These bits seem to control whether the MT753x uses the result of polling
> the PHY or the two force bits below to determine whether "EEE ability"
> is determined.
> 
> FORCE_EEE1G_P2
> FORCE_EEE100_P2
> 
> These bits determine whether, when their respective FORCE_MODE_EEE*_P2
> bit is set, "EEE ability" is set or not.
> 
> "EEE ability" in this case would seem to basically be what we call
> "EEE active" in kernel speak.
> 
> So, an implementation that would support our current uAPI fully would
> be:
> 
> - Set FORCE_MODE_EEE*_P2 bits (thus making the "EEE ability" be
>   under software control rather than the result of the PHY polling
>   unit.)
> - Set/clear FORCE_EEE*_P2 bits depending on phydev->enable_tx_lpi
> - Set the timer according to phydev->eee_cfg.tx_lpi_timer
> 
> and that will support the user API in the way that its intended to be.

Ack, I see. It make sense.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-156290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034BA05E82
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D353A51B2
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8491FCF66;
	Wed,  8 Jan 2025 14:24:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA10F1FCD09
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346240; cv=none; b=IdJw2Qn/q4/Jojbmhq1HeO01kJrU2VvGL1H6zDlA0eiwkl6QOgmztL0uoGU94YvSKuKSDI2DhohdNQB/NHpOfDo5NQxLOHqEGZ3RxiAK0wDYIoLHwWl/qwGLH1EzcjuPLNsYPRWBh89URhBnPQDRjCiKlUawo8Nwkorkzm6edNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346240; c=relaxed/simple;
	bh=xDXsJqUaiLZ9JhLCyp0bcyYKe1J0NmIL35fYxXZhZak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9HG3wFTVMmwu44VR8NHlMYmh04GXfC0c8gOwti8avgbA/9FxhQfWIw6ehAQ74VC7xOXtfE94YxOG1F00pqheoTtyJz1IGMmuuoL7snaGo3TIaDAyDDVqpW1d5jJQ+UUkoNhpcv6GdkL2ViUY3M7y++K6oVZOfBBWKKlXwBDWk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tVWyB-0006pC-0J; Wed, 08 Jan 2025 15:23:39 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVWy8-007XKC-2r;
	Wed, 08 Jan 2025 15:23:37 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tVWy9-00BX9o-1n;
	Wed, 08 Jan 2025 15:23:37 +0100
Date: Wed, 8 Jan 2025 15:23:37 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 7/7] net: usb: lan78xx: Enable EEE support
 with phylink integration
Message-ID: <Z36KacKBd2WaOxfW@pengutronix.de>
References: <20250108121341.2689130-1-o.rempel@pengutronix.de>
 <20250108121341.2689130-8-o.rempel@pengutronix.de>
 <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z35z6ZHspfSZK4U7@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Wed, Jan 08, 2025 at 12:47:37PM +0000, Russell King (Oracle) wrote:
> On Wed, Jan 08, 2025 at 01:13:41PM +0100, Oleksij Rempel wrote:
> > Refactor Energy-Efficient Ethernet (EEE) support in the LAN78xx driver
> > to integrate with phylink. This includes the following changes:
> > 
> > - Use phylink_ethtool_get_eee and phylink_ethtool_set_eee to manage
> >   EEE settings, aligning with the phylink API.
> > - Add a new tx_lpi_timer variable to manage the TX LPI (Low Power Idle)
> >   request delay. Default it to 50 microseconds based on LAN7800 documentation
> >   recommendations.
> 
> phylib maintains tx_lpi_timer for you. Please use that instead.

Just using this variable directly phydev->eee_cfg.tx_lpi_timer ?

> In any case, I've been submitting phylink EEE support which will help
> driver authors get this correct, but I think it needs more feedback.
> Please can you look at my patch set previously posted which is now
> a bit out of date, review, and think about how this driver can make
> use of it.

Ack, will do. It looks like your port of lan743x to the new API
looks exactly like what I need for this driver too.

> In particular, I'd like ideas on what phylink should be doing with
> tx_lpi_timer values that are out of range of the hardware. Should it
> limit the value itself?

Yes, otherwise every MAC driver will need to do it in the
ethtool_set_eee() function.

The other question is, should we allow absolute maximum values, or sane
maximum? At some point will come the question, why the EEE is even
enabled?

The same is about minimal value, too low value will cause strong speed
degradation. Should we allow set insane minimum, but use sane default
value?

> Should set_eee() error out?

Yes, please.

> I asked these  questions in the cover message but I don't think *anyone*
> reads cover messages anymore - as evidenced by my recent patch series that
> made reference to "make it sew" and Singer sewing machines. No one
> noticed. So I think patch series cover messages are now useless on
> netdev.

lol :)

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-140974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9559B8F1B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A5C1F22F72
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9003160783;
	Fri,  1 Nov 2024 10:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EF015C158
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456609; cv=none; b=piAxBmpc5pRZSOLKjGi1HVZ8zIFU6ve9ybe5ulY+Hk41gwh7WhcZMFJ7Q8P0XRcvucZvVqafCpJoKUQRT+XtiSXzSun+mY77Uy16EYJdO+wYOQEvBU++3pnns/dHNda6zRNTd+6PCs0QGE/3et7l7IyjrMFMElW79AneahaCScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456609; c=relaxed/simple;
	bh=8b9a53kp/jr0dPpeCii/tX8yWaa+/nuB5CkfS4qxa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIYs664hQtenvDoO3iO00JneT0lob1Nw8EGU/wXUtFt2kpmDmUMD7LzT2sYCUc6s/kgivXOpNDR9umhlGBz6CPYAn9mXdHJO64KGeCxtR3xl1wRGsrJv/s8+0oWON7dP5EqeNoE3ZvXouh1GSZXUeducJisoiUyoD4LczXUzlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t6oo8-0000H7-S1; Fri, 01 Nov 2024 11:23:08 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6oo6-001Ur2-2x;
	Fri, 01 Nov 2024 11:23:06 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t6oo6-007zJb-2X;
	Fri, 01 Nov 2024 11:23:06 +0100
Date: Fri, 1 Nov 2024 11:23:06 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v2 15/18] net: pse-pd: Add support for
 getting and setting port priority
Message-ID: <ZySsCuOvSnVZnIwq@pengutronix.de>
References: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
 <20241030-feature_poe_port_prio-v2-15-9559622ee47a@bootlin.com>
 <ZyMpkJRHZWYsszh2@pengutronix.de>
 <20241031121104.6f7d669c@kmaincent-XPS-13-7390>
 <ZySR75i3BEzNbjnv@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZySR75i3BEzNbjnv@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Fri, Nov 01, 2024 at 09:31:43AM +0100, Oleksij Rempel wrote:
> On Thu, Oct 31, 2024 at 12:11:04PM +0100, Kory Maincent wrote:
> > On Thu, 31 Oct 2024 07:54:08 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > > diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
> > > > index a1ad257b1ec1..22664b1ea4a2 100644
> > > > --- a/include/uapi/linux/ethtool.h
> > > > +++ b/include/uapi/linux/ethtool.h
> > > > @@ -1002,11 +1002,35 @@ enum ethtool_c33_pse_pw_d_status {
> > > >   * enum ethtool_c33_pse_events - event list of the C33 PSE controller.
> > > >   * @ETHTOOL_C33_PSE_EVENT_OVER_CURRENT: PSE output current is too high.
> > > >   * @ETHTOOL_C33_PSE_EVENT_OVER_TEMP: PSE in over temperature state.
> > > > + * @ETHTOOL_C33_PSE_EVENT_CONNECTED: PD detected on the PSE.
> > > > + * @ETHTOOL_C33_PSE_EVENT_DISCONNECTED: PD has been disconnected on the
> > > > PSE.
> > > > + * @ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR: PSE faced an error in
> > > > static
> > > > + *	port priority management mode.
> > > >   */
> > > >  
> > > >  enum ethtool_c33_pse_events {
> > > > -	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =	1 << 0,
> > > > -	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =	1 << 1,
> > > > +	ETHTOOL_C33_PSE_EVENT_OVER_CURRENT =		1 << 0,
> > > > +	ETHTOOL_C33_PSE_EVENT_OVER_TEMP =		1 << 1,
> > > > +	ETHTOOL_C33_PSE_EVENT_CONNECTED =		1 << 2,
> > > > +	ETHTOOL_C33_PSE_EVENT_DISCONNECTED =		1 << 3,
> > > > +	ETHTOOL_C33_PSE_EVENT_PORT_PRIO_STATIC_ERROR =	1 << 4,
> > > > +};  
> > > 
> > > Same here, priority concept is not part of the spec, so the C33 prefix
> > > should be removed.
> > 
> > Ack. So we assume PoDL could have the same interruption events.
> > 
> > > > +/**
> > > > + * enum pse_port_prio_modes - PSE port priority modes.
> > > > + * @ETHTOOL_PSE_PORT_PRIO_DISABLED: Port priority disabled.
> > > > + * @ETHTOOL_PSE_PORT_PRIO_STATIC: PSE static port priority. Port priority
> > > > + *	based on the power requested during PD classification. This mode
> > > > + *	is managed by the PSE core.
> > > > + * @ETHTOOL_PSE_PORT_PRIO_DYNAMIC: PSE dynamic port priority. Port priority
> > > > + *	based on the current consumption per ports compared to the total
> > > > + *	power budget. This mode is managed by the PSE controller.
> > > > + */  
> 
> After thinking about it more overnight, I wanted to revisit the idea of having
> a priority strategy per port. Right now, if one port is set to static or
> dynamic mode, all disabled ports seem to have to follow it somehow too. This
> makes it feel like we should have a strategy for the whole power domain, not
> just for each port.
> 
> I'm having trouble imagining how a per-port priority strategy would work in
> this setup.
> 
> Another point that came to mind is that we might have two different components
> here, and we need to keep these two parts separate in follow-up discussions:
> 
> - **Budget Evaluation Strategy**: The static approach seems straightforward—if
> a class requests more than available, appropriate actions are taken. However,
> the dynamic approach has more complexity, such as determining the threshold,
> how long violations can be tolerated, and whether a safety margin should be
> maintained before exceeding maximum load.
> 
> - **Disconnection Policy**: Once a budget violation is detected, this decides
> how to react, like which ports should be disconnected and in what order.
> 
> Would it make more sense to have a unified strategy for power domains, where we
> apply the same budget evaluation mode (static or dynamic) and disconnection
> policy to all ports in that domain? This could make the configuration simpler
> and the power management more predictable.

Except of user reports, do we have documented confirmation about dynamic
Budget Evaluation Strategy in PD692x0 firmware?

Do this configuration bits are what I called Budget Evaluation Strategy?
Version 3.55:
Bits [3..0]—BT port PM mode
0x0: The port power that is used for power management purposes is
     dynamic (Iport x Vmain).
0x1: The port power that is used for power management purposes is port
     TPPL_BT.
0x2: The port power that is used for power management purposes is
     dynamic for non LLDP/CDP/Autoclass ports and TPPL_BT for
     LLDP/CDP/Autoclass ports.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


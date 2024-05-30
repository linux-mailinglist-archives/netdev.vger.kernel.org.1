Return-Path: <netdev+bounces-99344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CAF8D495F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 12:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22731C21C18
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67501761AB;
	Thu, 30 May 2024 10:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C106F2E6
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717064043; cv=none; b=r+w6cTT7Nt+sFIY56+mIJMLGUZom8PAiT3pzlvyPm8e6BKTs+gssjkbTi6df/u1uVCgsMBDwJ5WlHzqAjT8zxsHsoEe/JiKNi2jDGqvpYPD14enABZKXjW4x9DN+Iwe5O936Dt2KxW3EsNGmLF73BSJjhoH2Hg3DpVriWimwHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717064043; c=relaxed/simple;
	bh=n62SWmX8IMb2fkF1l+lS53qxQkKvTK7doJvh+owS99Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpJYGbw3cwToiCurVxbJPsfWbV2Xuf3Iwq1LCxVr6NjIeaHqzWwgHelSTyIkhSjeiAiUGZh3aqBWDGC5UYbEtDvx6u4jvfnkJH6QgKjeq/84+ksUI4ECMJjzg9x/c8fHHCYkn2OfAfBG6598ZsigDv5jQmNPdCJtusAlL+4bDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sCcn8-0005Uf-EP; Thu, 30 May 2024 12:13:50 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sCcn6-003aAS-Fz; Thu, 30 May 2024 12:13:48 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sCcn6-0004y6-1E;
	Thu, 30 May 2024 12:13:48 +0200
Date: Thu, 30 May 2024 12:13:48 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH 4/8] net: pse-pd: pd692x0: Expand ethtool status message
Message-ID: <ZlhRXP8mQEdH6fg1@pengutronix.de>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
 <20240529-feature_poe_power_cap-v1-4-0c4b1d5953b8@bootlin.com>
 <d6aab44f-5e9a-4281-8c67-4b890b726337@lunn.ch>
 <20240530113341.36865f09@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530113341.36865f09@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi,

On Thu, May 30, 2024 at 11:33:41AM +0200, Kory Maincent wrote:
> Thanks for the review!
> 
> On Thu, 30 May 2024 01:13:59 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > +static const struct pd692x0_status_msg pd692x0_status_msg_list[] = {
> > > +	{.id = 0x06, .msg = "Port is off: Main supply voltage is high."},
> > > +	{.id = 0x07, .msg = "Port is off: Main supply voltage is low."},
> > > +	{.id = 0x08, .msg = "Port is off: Disable all ports pin is
> > > active."},
> > > +	{.id = 0x0C, .msg = "Port is off: Non-existing port number."},
> > > +	{.id = 0x11, .msg = "Port is yet undefined."},
> > > +	{.id = 0x12, .msg = "Port is off: Internal hardware fault."},
> > > +	{.id = 0x1A, .msg = "Port is off: User setting."},
> > > +	{.id = 0x1B, .msg = "Port is off: Detection is in process."},
> > > +	{.id = 0x1C, .msg = "Port is off: Non-802.3AF/AT powered device."},
> > > +	{.id = 0x1E, .msg = "Port is off: Underload state."},
> > > +	{.id = 0x1F, .msg = "Port is off: Overload state."},
> > > +	{.id = 0x20, .msg = "Port is off: Power budget exceeded."},
> > > +	{.id = 0x21, .msg = "Port is off: Internal hardware routing
> > > error."},
> > > +	{.id = 0x22, .msg = "Port is off: Configuration change."},
> > > +	{.id = 0x24, .msg = "Port is off: Voltage injection into the
> > > port."},
> > > +	{.id = 0x25, .msg = "Port is off: Improper Capacitor Detection"},
> > > +	{.id = 0x26, .msg = "Port is off: Discharged load."},  
> > 
> > I don't know of any other driver returning strings like this. Have you
> > seen any other PSE driver with anything similar?
> 
> We would like to be able to return the failure reason but there is nothing
> generic in the IEEE 802.3 standard to be able to add it to the UAPI.
> The TI controller has SUPPLY and FAULT EVENT Register which could report few
> messages. I am not aware of other PoE controller and how they deal with it.
> We could add sysfs for reporting the status messages for all the ports but I
> don't think it is a better idea.

We have ETHTOOL_LINK_EXT_STATE* and THTOOL_LINK_EXT_SUBSTATE_ for
different kind of link fail diagnostic. I think it would be good to make
the same for PSE ports. Not all of them will overlap with other PSE
controllers, but we will have one unified diagnostic interface. It will
be easier for user space application to parse and react on it.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


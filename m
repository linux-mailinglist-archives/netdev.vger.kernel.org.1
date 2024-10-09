Return-Path: <netdev+bounces-133467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB5499607D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 09:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C132827C7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03A42070;
	Wed,  9 Oct 2024 07:17:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95117C7CE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458228; cv=none; b=ANA6+DGjxZiodZQB/jutR2MEMc3h3ofm3aAarL1m/dCvRkl7lOkS6pyN80KRN6xARpr1p/ySLFPCZ92qIKMP66sKMydPfblXXKjjIgSx8EkSgcpEr8T5VBi4R0zTg3CGKpkYj7swmnmlx6Upk2iAgqXrb/rzG7EUdorHeIGGuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458228; c=relaxed/simple;
	bh=np+BwCZZY3k0G+CBznbfSMezUMPRfGaDPUyW4ghdgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sN4h6hK+NW7fpUb9SpK+FGZ7QOijrRQz/JAuzQHLJa1Zal5d7oJz97Af4GdVNAYj3onVYeyecVBGDZq2GG8cuXOrihYz9dFRUz0kGTay3zbxpMoWRMM/97lo9Z45ezGzivLoUxS12t51YEbdplIUDQ4hiDipFVIWR0XtU5bpD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1syQvy-0002Hf-RC; Wed, 09 Oct 2024 09:16:34 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1syQvx-000YH4-By; Wed, 09 Oct 2024 09:16:33 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1syQvx-0022qQ-0o;
	Wed, 09 Oct 2024 09:16:33 +0200
Date: Wed, 9 Oct 2024 09:16:33 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for PSE
 PI priority feature
Message-ID: <ZwYt0WT-tdOM0Abj@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
 <1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
 <ZwU6QuGSbWF36hhF@pengutronix.de>
 <9c77d97e-6494-4f86-9510-498d93156788@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c77d97e-6494-4f86-9510-498d93156788@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Andrew,

On Tue, Oct 08, 2024 at 06:50:25PM +0200, Andrew Lunn wrote:
> On Tue, Oct 08, 2024 at 03:57:22PM +0200, Oleksij Rempel wrote:
> > On Thu, Oct 03, 2024 at 01:41:02AM +0200, Andrew Lunn wrote:
> > > > +	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > > > +	msg.sub[2] = id;
> > > > +	/* Controller priority from 1 to 3 */
> > > > +	msg.data[4] = prio + 1;
> > > 
> > > Does 0 have a meaning? It just seems an odd design if it does not.
> > 
> > 0 is not documented. But there are sub-priority which are not directly
> > configured by user, but affect the system behavior.
> > 
> > Priority#: Critical – 1; high – 2; low – 3
> >  For ports with the same priority, the PoE Controller sets the
> >  sub-priority according to the logic port number. (Lower number gets
> >  higher priority).
> 
> With less priorities than ports, there is always going to be something
> like this.
> 
> > 
> > Port priority affects:
> > 1. Power-up order: After a reset, the ports are powered up according to
> >  their priority, highest to lowest, highest priority will power up first.
> > 2. Shutdown order: When exceeding the power budget, lowest priority
> >  ports will turn off first.
> > 
> > Should we return sub priorities on the prio get request?
> 
> I should be optional, since we might not actually know what a
> particular device is doing. It could pick at random, it could pick a
> port which is consuming just enough to cover the shortfall if it was
> turned off, it could pick the highest consumer of the lowest priority
> etc. Some of these conditions are not going to be easy to describe
> even if we do know it.

After reviewing the manuals for LTC4266 and TPS2388x, I realized that these
controllers expose interfaces, but they don't implement prioritization concepts
themselves.

The LTC4266 and TPS2388x controllers provide only interfaces that allow the
kernel to manage shutdown and prioritization policies. For TPS2388x, fast
shutdown is implemented as a port bitmask with only two priorities, handled via
the OSS pin. Fast shutdown is triggered by the kernel on request by toggling
the corresponding pin, and the policy - when and why this pin is toggled - is
defined by the kernel or user space. Slow shutdown, on the other hand, is
managed via the I2C bus and allows for more refined control, enabling a wider
range of priorities and more granular policies.

I'll tend to hope we can reuse the proposed ETHTOOL_A_C33_PSE_PRIO interface
across different PSE controllers. However, it is already being mapped to
different shutdown concepts: PD692x0 firmware seems to rely on a slow shutdown
backed by internal policies, while TPS2388x maps it to fast shutdown with
driver specific policy. This inconsistency could force us to either break the
UAPI or introduce a new, inconsistent one once we realize TPS2388x fast
shutdown isn't what we actually need.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


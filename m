Return-Path: <netdev+bounces-92169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B87C8B5B48
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 16:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D23F1F224C0
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 14:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEF47D3F4;
	Mon, 29 Apr 2024 14:32:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA27D074
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401171; cv=none; b=nvjElILcrm0KbVMV+pdotgTjtZIHofCGb2GwNZCP2HlYFb61H9R6XoTlHYLGOlFhhnYr/jSXvYXNIIG/ri76aqP16yx9SifPvQ2gAwPFEjtO+Sg92tETxXDecG6PYAFA/+xHynZY4nTST/W6yDZntU+md3s/fDrwlRDcjlGI9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401171; c=relaxed/simple;
	bh=cM+Kb+vHhPrqgKGWsTrNu6wlDlv/A4zfnq6HEVnW+W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyD5olSff89u7WtF1MGK6iThfhx2+JsTA+kiI8i/NcgCjNTgwEGc+VLxdCKQGXyxKlrcT/C8zT/xgLcBJ7pE+DEVPkM7Wgg6So7q/6XHuwwGRbX3m3ddEF7ZBDQSnenvLRv68tilFO4o8D1jJfo12MCnxXi1DmKvRTtYIjEPFk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s1S3a-0001g1-EV; Mon, 29 Apr 2024 16:32:38 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s1S3Y-00EzuG-OO; Mon, 29 Apr 2024 16:32:36 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s1S3Y-002Ue8-2A;
	Mon, 29 Apr 2024 16:32:36 +0200
Date: Mon, 29 Apr 2024 16:32:36 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: PoE complex usage of regulator API
Message-ID: <Zi-vhKx-WlYPQe3c@pengutronix.de>
References: <20240426124253.56fd0933@kmaincent-XPS-13-7390>
 <57a79abd-722c-4907-b0e7-2396392ae675@lunn.ch>
 <20240429145203.219bee06@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429145203.219bee06@kmaincent-XPS-13-7390>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Hi Kory,

On Mon, Apr 29, 2024 at 02:52:03PM +0200, Kory Maincent wrote:
> On Sat, 27 Apr 2024 00:41:19 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > Let's begin simple, in PSE world we are more talking about power.
> > > Would it be ok to add a regulator_get/set_power_limit() and
> > > regulator_get_power() callback to regulator API. Would regulator API have
> > > interest to such callbacks?  
> > 
> > Could you define this API in more details.
> 
> The first new PoE features targeted by this API was to read the consumed power
> and get set the power limit for each ports. Yes mainly book keeping.
> Few drivers callbacks that will be called by ethtool and maybe the read of power
> limit and consumed power could be add to read-only sysfs regulator.

regulator framework already supports operations with current (I):
regulator_set_current_limit()
regulator_get_current_limit()

The power P = I * V. On one side you can calculate needed current value:
I = P/V. On other side, may be regulator framework can be extended to do
it to. In case of PoE/PoDL we have adjustable voltage, depending on the
Class of the device, we will probably interact with PSE controller by
using Power instate of Current.

> > I'm assuming this is mostly about book keeping? When a regulator is
> > created, we want to say is can deliver up to X Kilowatts. We then want
> > to allocate power to ports. So there needs to be a call asking it to
> > allocate part of X to a consumer, which could fail if there is not
> > sufficient power budget left. And there needs to be a call to release
> > such an allocation.
> 
> This is more the aim of the second point I have raised, power priority and
> parent power budget. And how the core can manage it.

Since there is already support to work with current (I) values, there
are is also overcurrent protection. If a device is beyond the power
budget limit, it is practically an over current event. Regulator
framework already capable on handling some of this events, what we need
for PoE is prioritization. If we detect overcurrent on supply root/node
we need to shutdown enough low prio consumers to provide enough power
for the high prio consumers.

In reality, this will be done by the PoE controller in HW. Usually we
will get 

> > We are probably not so much interested in what the actual current
> > power draw is, assuming there is no wish to over provision?
> > 
> > There is in theory a potential second user of this. Intel have been
> > looking at power control for SFPs. Typically they are guaranteed a
> > minimum of 1.5W. However, they can operate at higher power
> > classes. You can have boards with multiple SFPs, with a theoretical
> > maximum power draw more than what the supply can supply. So you need
> > similar sort of power budget book keeping to allocate power to an SFP
> > cage before telling the SFP module it can swap to a higher power
> > class. I say this is theoretical, because the device Intel is working
> > on has this hidden away in firmware. But maybe sometime in the future
> > somebody will want Linux doing this.
> 
> So there is a potential second user, that's great to hear it! Could the
> priority stuff be also interesting? Like to allow only high priority SFP to use
> higher power class in case of a limiting power budget.

There are even more use cases. For example on power loss with some
limited backup power source, you wont to shut all low prio consumers
and provided needed power and time for some device which may fail. For
example storage devices.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


Return-Path: <netdev+bounces-219575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B44B42026
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B56F3A509F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AD2ED852;
	Wed,  3 Sep 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OhXmJNCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDE78F58;
	Wed,  3 Sep 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904173; cv=none; b=pr6MXml1hbl8Ev3OCtyRfLHTh7HhZqf2TkIakoHc7zq1HV+Jj9GCfHw/XVJhr31ZuO/XNPnAlsGLGaHp58OagA5YFwHEBNwX0FAOU8cc6MyObSMJnyGIPXSPMPmAGwXCK3P08bXEcU28JSN/8CAgMjbxqlsTcbGrXchTn62wTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904173; c=relaxed/simple;
	bh=cFl7v/Od1WF2E44Ws5NjC6oJfu0N7AJr7z9hkri9DSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjYJIp61n3bAQhl4JXEXa0w86tGcSYQiC/UY/LWlJwuRZp1b7W+mByTvlfRbIoIkBVBcsYGng9p9CSPNmAYGTCX4mKgtZ6IhHaOiNpIkf0F1jPWdqA0nm4qGpQOL/IIdkcbel+pMR254Z8WnrpFdLo0+h61jpMt1/cP0rQpmJbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OhXmJNCe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 667B31A09D3;
	Wed,  3 Sep 2025 12:56:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 35205606C3;
	Wed,  3 Sep 2025 12:56:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B7251C22DCD8;
	Wed,  3 Sep 2025 14:55:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756904167; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YIkwojBqy8n0cVDe2AbkmteHLxDMpJyJFz+LMRkFAIM=;
	b=OhXmJNCe9sayTxhCPu+7cQ3pgibKT0OxyDgFyamrfAVKiG6BaUNwZOy8yxgIsKZEhSHjDT
	JNy/AnXXtnw5LkfQeyDNo+OT00UZEuuzpDFwQInl0Y3DQSnJiMtgYdIrOFmn6h93dTl96N
	lttO6/2Bs7ddIW1mPyr24VSvcM93r/wewz/UeVR6F0FBNAQtwZObCc05iCHGAVZe7Gq8y0
	h7HXmPOcOT3zFTs+RsNmkN94THI8oXw8WLUT3NrN6RDcv7KujZvg4ayC8YxMAUk9WNS2+H
	hP/bki2jCOwR4cPIfFOLabVzE3p4hGtMFaT1qy7OSZ1XZxZo88QavV/mjviTfw==
Date: Wed, 3 Sep 2025 14:55:40 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, kernel@pengutronix.de, Dent Project
 <dentproject@linuxfoundation.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>
Subject: Re: [PATCH net-next v2 4/4] net: pse-pd: pd692x0: Add devlink
 interface for configuration save/reset
Message-ID: <20250903145540.42c51417@kmaincent-XPS-13-7390>
In-Reply-To: <aLgfnia_ZlclCrdy@pengutronix.de>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
	<20250901133100.3108c817@kernel.org>
	<20250902164314.12ce43b4@kmaincent-XPS-13-7390>
	<20250902134212.4ceb5bc3@kernel.org>
	<20250902134844.7e3593b9@kernel.org>
	<aLfp5H5CTa24wA7H@pengutronix.de>
	<20250903111025.4642efb7@kmaincent-XPS-13-7390>
	<aLgfnia_ZlclCrdy@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 3 Sep 2025 12:59:42 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Wed, Sep 03, 2025 at 11:10:25AM +0200, Kory Maincent wrote:
> > On Wed, 3 Sep 2025 09:10:28 +0200
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Tue, Sep 02, 2025 at 01:48:44PM -0700, Jakub Kicinski wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > I think the main use case question is: what happens if the application
> > > CPU reboots?
> > > Do we go back to =E2=80=9Csafe defaults=E2=80=9D? But what are safe d=
efaults - that can
> > > vary a lot between systems. =20
> >=20
> > In case of CPU reboot, the port matrix will be flashed, which means the
> > controller is restarted and the ports get disconnected.
> > Therefore indeed we will go back to default settings.
> >   =20
> > > In many setups, if the CPU reboots it also means the bridge is down, =
so
> > > there is no packet forwarding. In that case, does it even make sense =
to
> > > keep providing PoE power if the networking part is non-functional? =20
> >=20
> > It depends, we might not want to reboot the Powered Devices if the swit=
ch
> > reboot. I don't currently have specific case in mind which could need t=
his
> > behavior.
> > Mainly, the Dent Project final aim was to support mainline all the feat=
ures
> > supported in their poed tool.
> > https://github.com/dentproject/poed/blob/main/dentos-poe-agent/opt/poea=
gent/docs/Userguide
> >  =20
> > > Another angle: does it make sense to overwrite the hardware power-on
> > > defaults each time the system starts? Or should we rather be able to
> > > read back the stored defaults from the hardware into the driver and w=
ork
> > > with them? =20
> >=20
> > Yes that is one of the design proposition, but we will still need a way=
 to
> > reset the conf as said before.
> >  =20
> > > Does anyone here have field experience with similar devices? How are
> > > these topics usually handled outside of my bubble? =20
> >=20
> > Kyle any field experience on this? =20
>=20
> I can confirm a field case from industrial/medical gear. Closed system,
> several modules on SPE, PoDL for power. Requirement: power the PDs as
> early as possible, even before Linux. The box boots faster if power-up
> and Linux init run in parallel. In this setup the power-on state is
> pre-designed by the product team and should not be changed by Linux at
> runtime.
>=20
> So the question is how to communicate and control this:
>=20
> Option A - Vendor tool writes a fixed config to NVM (EEPROM)
> Pro: matches "pre-designed, don't touch" model; PDs come up early
> without Linux.
> Con: needs extra vendor tooling; hard to keep in sync with what
> userspace shows; Linux may not know what is in NVM unless we
> read/reflect it.
>=20
> Option B - Do all changes in RAM, then one explicit "commit to NVM"
> Pro: one write; predictable latency hit only on commit; maps to a
> "transaction/commit" model.
> Con: what if the controller discarded some changes during the session?
> We would need a clear commit status and a way to report which settings
> actually stuck.
>=20
> Option C - Write-through: every change also goes to NVM
> Pro: if the system resets, config is always up to date.
> Con: adds about 50-110 ms per change on this hardware; may be too slow
> for interactive tools or batch reconfig.
>=20
> From API side, if write-through is possible on this hardware, we can
> likely make this per-port and per-setting:
>=20
> ethtool per-port setters can take a "persist=3D1" flag. Driver applies the
> change and also writes it to NVM for that port.

The thing is, as it is not per port save if we use one time this ethtool fl=
ag
all the other ports configurations will also be saved. This could mislead u=
sers
by letting them believe they can save configuration for one specific port
without saving all the other ports config.
I think saving the config to NVM globally on each config change is a better
idea.

> If a particular setting (bit/field) cannot be persisted by the
> controller/NVM, the driver returns an error for the whole request. Usersp=
ace
> then knows persistence is not supported for that item.
>
> Factory reset:
> If hardware supports per-port defaults in NVM, provide a per-port
> factory_reset op.
>
> Do PD692x0 supports per-port save/restore functionality?

No it is not per port but at the PSE controller level for both.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


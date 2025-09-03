Return-Path: <netdev+bounces-219497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40249B4199E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA1317242F
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262642ECE9E;
	Wed,  3 Sep 2025 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j8+LcGFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866D258CDF;
	Wed,  3 Sep 2025 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756890664; cv=none; b=iy5TOY3umR9vdaMHJq6rQTOBlEZX78u1cXqqYAQbyHg/neWtm3pTfoO25NEjqe9PnGCjRXfwK7AQio3MT6XHMGvfpmgtWcMOVv3w1c1Zp84RYInRM0UiGPNTyBNfYUObuBVIyOoF5qGFf/GBEZUiRZT3iSbDl+bzfesjCDXi15k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756890664; c=relaxed/simple;
	bh=obY43WZ36Ui+bl12bWl48e1L9yiSSKaPY6THe3nPNm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjs9ittPMjwqrMmh7OxF7dJvyfsXV30p+JI62Ig1YSfSQ/rsiiroOOEDc+a1VfPhdPw+9AFULTxBpVBiHhUZgQsFO00k2JrkTrPsGivg9L+Dvfm5/4j05mzeagVDdZnD1iG0K7QzDV+vstajzZjVMnKJxM03hqNbttKcPC9FHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j8+LcGFv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50C224E40BBC;
	Wed,  3 Sep 2025 09:10:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BF37606C3;
	Wed,  3 Sep 2025 09:10:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2F4A1C22DB60;
	Wed,  3 Sep 2025 11:10:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756890652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3qfmCT2IJRj9E7bccRvk2rX7BuXxyaqOfnAhEGgrxro=;
	b=j8+LcGFvEoytc8+gnOIPE0orhclkJo48lN0sjoHZyVo/GAsKJUOmV9gbSlKLcvbLvoEiB6
	/kN+ZmtvppXoUKxlLkPiRYlXNp5T5t2p5qjFhxLMBaDDJ++eeJa16+E+3v/XkcCtMxMGqf
	SoD/H1RBHBwm5izhAuP/iEQPs6HxM/SBN0Pej2Q4HlXaxfPCM8DPEuvKl6+8+9OQkrAr6B
	cdvSp1oWygbpyYdNClXt4mKUlWrSR/uPTIzN5XgMNeQvxaaDZgemlPGFNOFPYWn0I52hYy
	DwJnFj+jxtQ3sRgXz5spKFaO3VMG9zLIJtuLeYOlwGEQxQZk+EdBHL/LBFjt3g==
Date: Wed, 3 Sep 2025 11:10:25 +0200
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
Message-ID: <20250903111025.4642efb7@kmaincent-XPS-13-7390>
In-Reply-To: <aLfp5H5CTa24wA7H@pengutronix.de>
References: <20250829-feature_poe_permanent_conf-v2-0-8bb6f073ec23@bootlin.com>
	<20250829-feature_poe_permanent_conf-v2-4-8bb6f073ec23@bootlin.com>
	<20250901133100.3108c817@kernel.org>
	<20250902164314.12ce43b4@kmaincent-XPS-13-7390>
	<20250902134212.4ceb5bc3@kernel.org>
	<20250902134844.7e3593b9@kernel.org>
	<aLfp5H5CTa24wA7H@pengutronix.de>
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

On Wed, 3 Sep 2025 09:10:28 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Sep 02, 2025 at 01:48:44PM -0700, Jakub Kicinski wrote:
> > On Tue, 2 Sep 2025 13:42:12 -0700 Jakub Kicinski wrote: =20
> > > On Tue, 2 Sep 2025 16:43:14 +0200 Kory Maincent wrote: =20
> > > > > Sorry for not offering a clear alternative, but I'm not aware of =
any
> > > > > precedent for treating devlink params as action triggers. devlink
> > > > > params should be values that can be set and read, which is clearl=
y not
> > > > > the case here:     =20
> > > >=20
> > > > Ok.
> > > > We could save the configuration for every config change and add a
> > > > reset-conf action to devlink reload uAPI? The drawback it that it w=
ill
> > > > bring a bit of latency (about 110ms) for every config change.
> > > >=20
> > > > Or adding a new devlink uAPI like a devlink conf but maybe we don't
> > > > have enough cases to add such generic new uAPI.
> > > > Or get back to the first proposition to use sysfs.=20
> > > >=20
> > > > What do you think?   =20
> > >=20
> > > If you are asking for my real preference, abstracting away whether it=
's
> > > doable and justifiable amount of effort for you -- I'd explore using
> > > flags in the ethtool header to control whether setting is written to
> > > the flash. =20
> >=20
> > PS. failing that the less uAPI the better. Tho, given that the whole
> > point here is giving user the ability to write the flash -- asking for
> > uAPI-light approach feels contradictory.
> >=20
> > Taking a step back -- the "save to flash" is something that OEM FW
> > often supports. But for Linux-based control the "save to flash" should
> > really be equivalent to updating some user space config. When user
> > configures interfaces in OpenWRT we're not flashing them into the
> > device tree... Could you perhaps explain what makes updating the
> > in-flash config a high-priority requirement for PoE?
> >  =20
>=20
> I think the main use case question is: what happens if the application
> CPU reboots?
> Do we go back to =E2=80=9Csafe defaults=E2=80=9D? But what are safe defau=
lts - that can
> vary a lot between systems.

In case of CPU reboot, the port matrix will be flashed, which means the
controller is restarted and the ports get disconnected.
Therefore indeed we will go back to default settings.
=20
> In many setups, if the CPU reboots it also means the bridge is down, so
> there is no packet forwarding. In that case, does it even make sense to
> keep providing PoE power if the networking part is non-functional?

It depends, we might not want to reboot the Powered Devices if the switch
reboot. I don't currently have specific case in mind which could need this
behavior.
Mainly, the Dent Project final aim was to support mainline all the features
supported in their poed tool.
https://github.com/dentproject/poed/blob/main/dentos-poe-agent/opt/poeagent=
/docs/Userguide

> Another angle: does it make sense to overwrite the hardware power-on
> defaults each time the system starts? Or should we rather be able to
> read back the stored defaults from the hardware into the driver and work
> with them?

Yes that is one of the design proposition, but we will still need a way to
reset the conf as said before.

> Does anyone here have field experience with similar devices? How are
> these topics usually handled outside of my bubble?

Kyle any field experience on this?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


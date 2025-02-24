Return-Path: <netdev+bounces-168953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DA9A41C15
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCF3AA711
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE912586CA;
	Mon, 24 Feb 2025 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jNPKYatd"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86F2586C8;
	Mon, 24 Feb 2025 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394956; cv=none; b=aZeZcsoBMqE1Ayzxpk73EtjZUmSDklnqziQCMHWMHIMC0GUxS+KpiWL76nWLTzKnw2XG3LRyjvr+zE0NK4uuOLSDGo5Hw2LRoANf4dXFHWcwIr35IbpZC46ZiY0uyzlm55gKaI0qk2IkgWrglsN+XvjWZQNGq+hP5SHyMQ9/90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394956; c=relaxed/simple;
	bh=4h5Vn63f6Fe+g51YvuC9s4LnHdlrSh7w3OTHz6xuoCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6zvFlWi5BRHwCsbSSE/l9K2UdChh4zgvAtmwy2D/6BojCMKMxZChZy/3f1N1nPGGJsYYlm/Dec6BAXHQUiAF+1BPxuXiXD5Xvfw5cjdgjwkxT0RFuEQ3XmruTmzmzI4w1p1kRZcAtEUbBx0hC2gxEf6/Yo40HbPGPaVGcNomIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jNPKYatd; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6145B441B0;
	Mon, 24 Feb 2025 11:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740394951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlMYiWhNWjllG+4m2VbMgy0URpmB5UKN6+mVfUuELF4=;
	b=jNPKYatdKYpX0w8cf1KMzvCyrMN2jGJjZW20cKTgfAZXnYnbSg8juSaOz2mATMrwIuGO5t
	StH/bCTj3skEjD6go/TDhCzm48sElq9Zt87aCZGBuEQs6rbG+G2ZMrXAm3I30RHy1hRmXB
	KE9Wv2aXceEmLGMnaFGEZomY3BABKdXPw3/7a0BSGa0bTw1bHn3fEN7t5AE1NnDFWN2H6C
	Yh496qsvn4uBHEbJwLBacumVEhQ3fQfR7SngbNb2LrfjDFbCswGLP/0Wi0gFbu6RAdooSl
	h4jbfmFzTj8cEucPRzZqN2sVMyc+QMqkE7vcU7vjk12DZUt86QI14O+AaHiNQg==
Date: Mon, 24 Feb 2025 12:02:28 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250224120228.62531319@kmaincent-XPS-13-7390>
In-Reply-To: <Z7g-WYQNpVp5w7my@pengutronix.de>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
	<Z7g-WYQNpVp5w7my@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqfedtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeevfeeggeeghffgudfhhedvvedvueekleevjeduvddutefhvddugedtfeeludenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhus
 ggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleksij,

On Fri, 21 Feb 2025 09:50:33 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> On Tue, Feb 18, 2025 at 05:19:06PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for devm_pse_irq_helper() to register PSE interrupts. This =
aims
> > to report events such as over-current or over-temperature conditions
> > similarly to how the regulator API handles them but using a specific PSE
> > ethtool netlink socket. =20
>=20
> Thank you for your work. Here some comments.
>=20
> ...
>=20
> > --- a/drivers/net/mdio/fwnode_mdio.c
> > +++ b/drivers/net/mdio/fwnode_mdio.c
> > @@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
> > =20
> >  static struct pse_control *
> > -fwnode_find_pse_control(struct fwnode_handle *fwnode)
> > +fwnode_find_pse_control(struct fwnode_handle *fwnode,
> > +			struct phy_device *phydev)
> >  { =20
>=20
> This change seems to be not directly related to the commit message.
> Is it the preparation for the multi-phy support?

I need to save the phy_device related to PSE control to use the right netwo=
rk
interface for the ethtool notification. (ethnl_pse_send_ntf())
Indeed I have not described this in the commit message.

> ...
>=20
> > +/**
> > + * pse_to_regulator_notifs - Convert PSE notifications to Regulator
> > + *			     notifications
> > + * @notifs: PSE notifications
> > + *
> > + * Return: Regulator notifications
> > + */
> > +static unsigned long pse_to_regulator_notifs(unsigned long notifs) =20
>=20
> I prefer converting it the other way around to make it reusable for
> plain regulator-based PSEs. For example, the podl-pse-regulator driver
> won=E2=80=99t have its own interrupt handler but will instead use
> devm_regulator_register_notifier().

The driver PIs part send PSE notifications which will be converted to regul=
ator
events from the core. It is posting events.
If you use devm_regulator_register_notifier() you will registers a listener=
 for
the regulator events. It is two distinct things.

> Even full-fledged PSE controllers like the PD692x0 are just one part of
> a larger chain of regulators. An overcurrent event may originate from a
> downstream regulator that is not part of the PD692x0 itself. In this
> case, we need to process the event from the downstream regulator,
> convert it into an ethtool event, and forward it to the user.

If you want to do something in case of downstream regulator events you will=
 deal
with regulator events not PSE events. I think you want to disable PIs in ca=
se of
event like downstream regulator over current.
What policy should we use? Should we disable all the PIs or only disabled t=
he
low priority like the budget evaluation strategy of this series? As it is o=
ver
current event not related to budget we don't know how many PIs we should
disable.

Still as said before it is a distinct development that could be tackled lat=
er.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


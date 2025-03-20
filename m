Return-Path: <netdev+bounces-176519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41678A6AA33
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D76B7A2C0E
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10B41E9B23;
	Thu, 20 Mar 2025 15:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Equ8aWXW"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A91C5D61;
	Thu, 20 Mar 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485591; cv=none; b=Oiz3UPTc3KUduhDlLywUPmCb0aweG9QOvpfp3eeYXyFW8D7QwwYjTAcaPMuCKvQZtkjqhDbBS/3s6TH7EtjoogIK5Sh5EmbVnZkStLW5csGL6WQrpb7RK0cRTSg0ho5ZbZboDYhxhu+kjgwZcHpprb9dj1y7fEjHgHqcwdJ6vrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485591; c=relaxed/simple;
	bh=2I/zwPnTTSLRGKhjAdRBYyTgmfnE2Vsqk9k9mw3uysQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TB3HmF2aTr8uQ1P2wZjrNKaONM9agHt996TSGqzdh+EP2Qh8AyqwJhpcyYhonCi2pD3ALmramzIRYrldKOfs51vip5xFIDBMiP2OG8DMAqaVxfGpXJxrrn9HhMgzSKR7OiJ9/j6DJJUr3F5K3n1YRY3H5in45EMupvWxcFLfsz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Equ8aWXW; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECB0D44141;
	Thu, 20 Mar 2025 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742485587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5IuyoJwF/rxSg5TGjcnbKQqCCjJToYQf2q0zX50cUE=;
	b=Equ8aWXWtmVZdt8l7rlL+90B16Wu4l8jyPtOV71OC5ASl0tTe2CPTYWVnKEFbCH+DmoFNx
	m6vdVByP6zKgbtqq4UtwZL0kLZ8wpgE2cAUlpow5V4i49t0NukW9n2fxaonPlAbanG4Fxj
	RSAo0XgfsnRKlmTyFX/7+mMqdd7yrg40iv9DkUFvZo7I8d6nzgDOpdMNIA54+FdmHhvafn
	WGo8AeskmuCmkMQnmLrc52FWRYePbAVskEDPE3myYiF8TdfP11soX+1ce8JVueK1sYB5qY
	jhcn0qgBowRvtzG+M0Ya9BbD5JFMw/HvHio59jq+Kx5ervqQhbDD2c6sbQSTzQ==
Date: Thu, 20 Mar 2025 16:46:23 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 04/12] net: pse-pd: Add support for PSE
 power domains
Message-ID: <20250320164623.4007e7bc@kmaincent-XPS-13-7390>
In-Reply-To: <Z9fyZkAOB602cFJY@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-4-3dc0c5ebaf32@bootlin.com>
	<Z9fyZkAOB602cFJY@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekieduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Mar 2025 10:59:02 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Mar 04, 2025 at 11:18:53AM +0100, Kory Maincent wrote:

> > +static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < pcdev->nr_lines; i++) {
> > +		struct regulator_dev *rdev =3D pcdev->pi[i].rdev;
> > +		struct pse_power_domain *pw_d;
> > +		struct regulator *supply;
> > +		bool present =3D false;
> > +		unsigned long index;
> > +
> > +		/* No regulator or regulator parent supply registered.
> > +		 * We need a regulator parent to register a PSE power
> > domain
> > +		 */
> > +		if (!rdev || !rdev->supply)
> > +			continue;
> > + =20
>=20
> Should we use xa_lock() before iteration over the map?

I am scratching my head to find out the case where it may be needed.
The only case I think of is two PSE controller with PSE PI using the same p=
ower
supply. Which is not a good idea for well distributing power.
In this case we could have two pse_register_pw_ds running concurrently and =
we
could have issues. Not only the iteration over the map should be protected =
but
also the content of the pw_d entry. Also when we unbind one of the PSE
controller it will remove all the PSE power domains event if they are used
by another PSE. :/
I need to add refcount and lock on the PSE power domains to fix this case!=
=20

> > +		xa_for_each(&pse_pw_d_map, index, pw_d) {
> > +			/* Power supply already registered as a PSE power
> > +			 * domain.
> > +			 */
> > +			if (regulator_is_equal(pw_d->supply,
> > rdev->supply)) {
> > +				present =3D true;
> > +				pcdev->pi[i].pw_d =3D pw_d;
> > +				break;
> > +			}
> > +		}
> > +		if (present)
> > +			continue;
> > +
> > +		pw_d =3D devm_pse_alloc_pw_d(pcdev->dev);
> > +		if (IS_ERR_OR_NULL(pw_d))
> > +			return PTR_ERR(pw_d); =20
>=20
> It is better to break the loop and roll back previous allocations.

This will be done by pse_flush_pw_ds called by devm_pse_controller_release =
as
the pse_controller_register failed.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


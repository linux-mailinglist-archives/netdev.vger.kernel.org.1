Return-Path: <netdev+bounces-198043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B9ADB05A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A751D16827C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6B6292B22;
	Mon, 16 Jun 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mQZcCmKq"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33071285C88;
	Mon, 16 Jun 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077433; cv=none; b=CAsNOKNqikIpwkgMyqhHbZOmwuCIjiFIDxHFpIq/q9MEcamze5aTiWKLw02z1WKA/h6Ott/lZN8kf7MsKmCoJSeY0AQSoFwh2wDV6++bfwMJJ7ni4M3XtAxhmitkx1MSS7VvCBo6I/a79eTuLkrCML9hDfwjWghoICuOycpx+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077433; c=relaxed/simple;
	bh=ZeP7tjC/ZhNCZ3i6ehT8hX7C0+VGcUECL26rGy8Kgm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umXIfXGaSPPLlZBRP2G4yBw2YMrwxpWD1y93KzXvajW5vIdNXVm29PbOxeOQ0jIEqUrmqyPfm4TYk5HQxTyuqAe51QNnTIkXNYjWHDy1hi01dqFI/bJ3ppi+Kfg8ZO/nao08DcN8CkNCxnjQElJpmCm335pmEt+rdxo/tD2l8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mQZcCmKq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6114F443D2;
	Mon, 16 Jun 2025 12:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750077423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kG3QipumXVsgRC4HVgkiBiGQuTdDWQuhKnssOVQC3/Y=;
	b=mQZcCmKq8vupYDAfa3gPiIL9kiqYFRpFCvdRUHZ/B+32xQJa/gwrTMGv8oSnkwr3k86MPC
	XkGEapMDGYuj+hMt2t4YusO7Xx2llW+Ct3eHDvGylDNPjT5kcTLk42bM+lbfY70arP8Z92
	l1jxM1yfdrYqvEW9p8hfXVNCpvK26hG3dA1gREmUae9II6ug2VAhykDTB0toYrXcoGhWcr
	Tm86JSNlKIprxGN2pWxxCypMxRvmkrLYucTfzaT1fm1ilBjWun7XsI2IGhaCyRdRB4MEeY
	j+06koYoplIyAQNXGOAuj/WXq9UC6V3EYaQNstnlWsiRb5pSoe6zGNRnRHaVzw==
Date: Mon, 16 Jun 2025 14:37:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v13 04/13] net: pse-pd: Add support for PSE
 power domains
Message-ID: <20250616143700.6740fa59@kmaincent-XPS-13-7390>
In-Reply-To: <20250614121329.7720ff33@kernel.org>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-4-c5edc16b9ee2@bootlin.com>
	<20250614121329.7720ff33@kernel.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Sat, 14 Jun 2025 12:13:29 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Tue, 10 Jun 2025 10:11:38 +0200 Kory Maincent wrote:
> > +static void __pse_pw_d_release(struct kref *kref)
> > +{
> > +	struct pse_power_domain *pw_d =3D container_of(kref,
> > +						     struct
> > pse_power_domain,
> > +						     refcnt);
> > +
> > +	regulator_put(pw_d->supply);
> > +	xa_erase(&pse_pw_d_map, pw_d->id);
> > +}
> > +
> > +/**
> > + * pse_flush_pw_ds - flush all PSE power domains of a PSE
> > + * @pcdev: a pointer to the initialized PSE controller device
> > + */
> > +static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
> > +{
> > +	struct pse_power_domain *pw_d;
> > +	int i;
> > +
> > +	for (i =3D 0; i < pcdev->nr_lines; i++) {
> > +		if (!pcdev->pi[i].pw_d)
> > +			continue;
> > +
> > +		pw_d =3D xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> > +		if (!pw_d)
> > +			continue;
> > +
> > +		kref_put_mutex(&pw_d->refcnt, __pse_pw_d_release,
> > +			       &pse_pw_d_mutex);
> > +	}
> > +} =20
>=20
> AFAIU the release function (__pse_pw_d_release) is supposed to release
> the mutex.=20

Yes indeed thanks!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


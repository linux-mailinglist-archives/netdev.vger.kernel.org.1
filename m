Return-Path: <netdev+bounces-176536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C51AA6AB27
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7F18A5B90
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703841EDA18;
	Thu, 20 Mar 2025 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="onmJiJ6B"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71501C3C18;
	Thu, 20 Mar 2025 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488548; cv=none; b=bnqWEFt0beoEGlhtSfKy8jXDK1JzLUMdNaw/oIcdlAF6IfGWC22XIunRkRhfVe66ujudF42+kdhng45Rys/hcFxrptTKL2XPxB6/mhNnWDKPDMz0BIr0zyepj61ebOSLrXsn6j3D1RmNgDkX4CQBlDdteXqaouM4OjcTHYyDdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488548; c=relaxed/simple;
	bh=wlu4sa9Hj+H3sQPG7llnh87jaaY4X3w5U4AdeiRKm9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T5LiHXsiAkdgRvSMLTDt3cS/X/0xmcOglFt+Y0+mMyAHXlPE+47dV00Vykj0FiDT9/GI3zC7PzZ5VduX68UfQ9ZtkHaWNz+ZUPoZ+DwKUqqTgf+y1qWKGiNJtDp4j8p84bbJew/6tdyqbM4L/2eJvWjvg49sedhfEU1j/hzO1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=onmJiJ6B; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 083CC44332;
	Thu, 20 Mar 2025 16:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742488538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scN5SQcuDlpnHhPAKZLP9DMButGCxfU8wz03ilg3OEw=;
	b=onmJiJ6BRNdbkYSvhiAqNWgxgQdogP1QuF5xSqCeaK3tybA0TKsFpXpWGkgthaYaOV8ep4
	v73GBtVbm+JWgc4jReTVuw8D3HIGobveAtZ0Aa73CWGEUyw5CpxX0YD/B0MQ0mN8r/La6z
	pS2mbTEJuE1KD/33tHo5UeqBIP8QHbed4RQPY+XpfGBemhI2VQ6Nwr6Pqjqaw3Q61Y59uT
	1JQMBIxpCIXO6Fx628AW4oEbbSchifRTuepeLqrQP3Q5MsY4doUlHBEddo42kkQbmmg6Z6
	WJK9H+d2DcKLgCXY5Y4tW7cn/xq0xL/jjatQ7st2NxghWyKIJZZxRt+2OKBMyw==
Date: Thu, 20 Mar 2025 17:35:35 +0100
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
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250320173535.75e6419e@kmaincent-XPS-13-7390>
In-Reply-To: <Z9gYTRgH-b1fXJRQ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
	<Z9gYTRgH-b1fXJRQ@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Mar 2025 13:40:45 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Mar 04, 2025 at 11:18:55AM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > +/**
> > + * pse_disable_pi_prio - Disable all PIs of a given priority inside a =
PSE
> > + *			 power domain
> > + * @pcdev: a pointer to the PSE
> > + * @pw_d: a pointer to the PSE power domain
> > + * @prio: priority
> > + *
> > + * Return: 0 on success and failure value on error
> > + */
> > +static int pse_disable_pi_prio(struct pse_controller_dev *pcdev,
> > +			       struct pse_power_domain *pw_d,
> > +			       int prio)
> > +{
> > +	int i;
> > + =20
>=20
> Should we lock the pi[] array at some level?

Lock the pi array?
pcdev is already locked in the irq thread handler.=20
=20
> > +	for (i =3D 0; i < pcdev->nr_lines; i++) {
> > +		int ret;
> > +
> > +		if (pcdev->pi[i].prio !=3D prio ||
> > +		    pcdev->pi[i].pw_d !=3D pw_d ||
> > +		    !pcdev->pi[i].admin_state_enabled)
> > +			continue;
> > +
> > +		ret =3D pse_disable_pi_pol(pcdev, i); =20
>=20
> If the PSE has many lower-priority ports, the same set of ports could be
> repeatedly shut down while higher-priority ports keep power
> indefinitely.

That is the point of priority. It is not a problem as there is as many prio=
rity
value as ports. Disabling all the ports configured with a specific priority=
 is
understandable.

> This could result in a starvation issue, where lower-priority group of
> ports may never get a chance to stay enabled, even if power briefly
> becomes available.
>=20
> To fix this, we could:
> - Disallow identical priorities in static mode to ensure a clear
> shutdown order.

We can't do this as this imply priority shutdown method is always used and
can't be disabled.
Having all the ports to the same priority means that the priority strategy =
is
not used and if new PD is plugged and exceed the budget it simply won't be
powered.

> > +int pse_ethtool_set_prio(struct pse_control *psec,
> > +			 struct netlink_ext_ack *extack,
> > +			 unsigned int prio)
> > +{
> > +	struct pse_controller_dev *pcdev =3D psec->pcdev;
> > +	const struct pse_controller_ops *ops;
> > +	int ret =3D 0;
> > +
> > +	if (!pcdev->pi[psec->id].pw_d) {
> > +		NL_SET_ERR_MSG(extack, "no power domain attached");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	/* We don't want priority change in the middle of an
> > +	 * enable/disable call or a priority mode change
> > +	 */
> > +	mutex_lock(&pcdev->lock);
> > +	switch (pcdev->pi[psec->id].pw_d->budget_eval_strategy) {
> > +	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC:
> > +		if (prio > pcdev->nr_lines) {
> > +			NL_SET_ERR_MSG_FMT(extack,
> > +					   "priority %d exceed priority
> > max %d",
> > +					   prio, pcdev->nr_lines);
> > +			ret =3D -ERANGE;
> > +			goto out;
> > +		}
> > +
> > +		pcdev->pi[psec->id].prio =3D prio; =20
>=20
> In case we already out of the budget, we will need to re-evaluate the
> prios. New configuration may affect state of ports.
>
> Potentially we may need a bulk interface to assign prios, to speed-up
> reconfiguration. But it is not needed right now.

Oh indeed, I missed that. /o\
I will try to add something but lets keep it not too complex! ^^ Don't add =
me
more work!! ;)

> > +		break;
> > +
> > +	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_DYNAMIC:
> > +		ops =3D psec->pcdev->ops;
> > +		if (!ops->pi_set_prio) {
> > +			NL_SET_ERR_MSG(extack,
> > +				       "pse driver does not support
> > setting port priority");
> > +			ret =3D -EOPNOTSUPP;
> > +			goto out;
> > +		}
> > +
> > +		if (prio > pcdev->pis_prio_max) {
> > +			NL_SET_ERR_MSG_FMT(extack,
> > +					   "priority %d exceed priority
> > max %d",
> > +					   prio, pcdev->pis_prio_max);
> > +			ret =3D -ERANGE;
> > +			goto out;
> > +		}
> > +
> > +		ret =3D ops->pi_set_prio(pcdev, psec->id, prio); =20
>=20
> Here too, but in case of microchip PSE it will happen in the firmware.
> May be add here a comment that currently it is done in firmware and to
> be extended for the kernel based implementation.

Ack, I will add a comment.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


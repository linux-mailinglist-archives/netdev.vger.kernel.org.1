Return-Path: <netdev+bounces-177127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C603EA6DFED
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91BCD1889353
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0680262813;
	Mon, 24 Mar 2025 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bS72eUr3"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7993FBA7;
	Mon, 24 Mar 2025 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834354; cv=none; b=BBQAj4bev+8URjmPQBaoMOjkjxxd9WNrg0mxSs2TaEqj3CVVx6ya8hMpesXQLJdsAd0GEIMYrMhOVqqYfRW/tIVL/1+1zXNf4bdXKwSV/a74vqpdWEMMDICQq5FmjlfOQlqlXpXd3V/9tiAlFXzZrZcldXfZDBVZD6hEkFQSpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834354; c=relaxed/simple;
	bh=pC30NeT45FvNA5LE4RaH+c4FzFm/glTDXwn8/9BQoV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MKrmSqFfZybzYoOcoyN3LacuvRLAUo0Ay6+tTol4xFqSDOD9MiKO29nk9yIKspWjaBqLaVh1N00sTyTXoG2lnm6R+cbw88eEeOU2DQmXvWz36aRHV3unauv27whGkuSJJLpFQdwaUUgOAp9XlvGWnFoGFxsEj1UHwOMsDqzeSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bS72eUr3; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 049F744522;
	Mon, 24 Mar 2025 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742834350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Km2Teq2UiJ9T6r73JTHC/jGo8ahaVTtGZ9g3CgWRt0E=;
	b=bS72eUr3nnbQpQbfzMQBNxFYZccIuCQhDx0EsUxkBzj9+Oe7dKoJnZWibu400zOn1o86pk
	nyqVjjoqcmPjVtRMA45FPNM52z4IBfN8uLf4JJ2+Sqa5AnyaHsiBj+0dsjWsfJdVLNoRJc
	2JaadQAkl5iz8LAgSgrRs/73AWW5y+XGPK400mVCDDP1cp2HSWk4dCu79et/+4f2z9BgMm
	lhzea9bF4ABiBAL6KdP2aFBV4NvJuhKlv0VhZ513S3VYhEyMFj9WflNI45E/SYVJcMqMiw
	IlOsNsw3BnnGwXf1WgMJE8qjnZpEowCj1uWH5YKR0dD2GH1GwSXBcFCl3c206w==
Date: Mon, 24 Mar 2025 17:39:07 +0100
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
Message-ID: <20250324173907.3afa58d2@kmaincent-XPS-13-7390>
In-Reply-To: <20250320173535.75e6419e@kmaincent-XPS-13-7390>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
	<Z9gYTRgH-b1fXJRQ@pengutronix.de>
	<20250320173535.75e6419e@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegvheejsgemudejkeelmeeljeegugemudejheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmegvheejsgemudejkeelmeeljeegugemudejhedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Hello Kyle, Oleksij,

On Thu, 20 Mar 2025 17:35:35 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Mon, 17 Mar 2025 13:40:45 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > On Tue, Mar 04, 2025 at 11:18:55AM +0100, Kory Maincent wrote: =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

> > > +int pse_ethtool_set_prio(struct pse_control *psec,
> > > +			 struct netlink_ext_ack *extack,
> > > +			 unsigned int prio)
> > > +{
> > > +	struct pse_controller_dev *pcdev =3D psec->pcdev;
> > > +	const struct pse_controller_ops *ops;
> > > +	int ret =3D 0;
> > > +
> > > +	if (!pcdev->pi[psec->id].pw_d) {
> > > +		NL_SET_ERR_MSG(extack, "no power domain attached");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	/* We don't want priority change in the middle of an
> > > +	 * enable/disable call or a priority mode change
> > > +	 */
> > > +	mutex_lock(&pcdev->lock);
> > > +	switch (pcdev->pi[psec->id].pw_d->budget_eval_strategy) {
> > > +	case ETHTOOL_PSE_BUDGET_EVAL_STRAT_STATIC:
> > > +		if (prio > pcdev->nr_lines) {
> > > +			NL_SET_ERR_MSG_FMT(extack,
> > > +					   "priority %d exceed priority
> > > max %d",
> > > +					   prio, pcdev->nr_lines);
> > > +			ret =3D -ERANGE;
> > > +			goto out;
> > > +		}
> > > +
> > > +		pcdev->pi[psec->id].prio =3D prio;   =20
> >=20
> > In case we already out of the budget, we will need to re-evaluate the
> > prios. New configuration may affect state of ports.
> >
> > Potentially we may need a bulk interface to assign prios, to speed-up
> > reconfiguration. But it is not needed right now. =20
>=20
> Oh indeed, I missed that. /o\
> I will try to add something but lets keep it not too complex! ^^ Don't ad=
d me
> more work!! ;)

Small question on PSE core behavior for PoE users.

If we want to enable a port but we can't due to over budget.
Should we :
- Report an error (or not) and save the enable action from userspace. On th=
at
  case, if enough budget is available later due to priority change or port
  disconnected the PSE core will try automatically to re enable the PoE por=
t.
  The port will then be enabled without any action from the user.
- Report an error but do nothing. The user will need to rerun the enable
  command later to try to enable the port again.

How is it currently managed in PoE poprietary userspace tools?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


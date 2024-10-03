Return-Path: <netdev+bounces-131514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29F98EB90
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F71B1F22993
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F013A899;
	Thu,  3 Oct 2024 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IgR80h+m"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB830126C04;
	Thu,  3 Oct 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727944093; cv=none; b=uGWrFsXS51XOOQCIprio3nLhhhrYILbPWtmQWTypjf/QJR1nW5+NwB8/zOr0CQ6upKE74YDXt7Tphtx2ufXr/19eFA12xC61i/KL6rfkurePe5NHrgJLApzJq/eXMxBmlr5rRJD2bDxcaA/LXvibSvvCqI+wnWojZNaZ84tAsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727944093; c=relaxed/simple;
	bh=LfbrL0dXCVYAuMGaaYm9E3H/pxeFpOV9d9HVh6Hcuss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfbz7OiXlHcZeIyncHvkF9YucmZV4SLHCobJuYkT0IzmXC2kPXn50OJpjLh83EVXMyi7PNVNudQPZ4Q1wgVm7Kwt2mV3xen37d75LtLZr6M3YJUZl/y0bBF5RTN3EqT38Sz+TCc80gFvepnv9hB7ptXWtdr6wyEtB/aA4yOtj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IgR80h+m; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 70CE020003;
	Thu,  3 Oct 2024 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfLIEmgqUx9QJnUvHidIloMUHZfh1Wn2l5yTpyLBzNY=;
	b=IgR80h+m2d6b6TRKM2eEc1fgp+3qo3nkLPvCtENoOzq1uK1DoTNPqeRWYQ7W+xbIJ0rmMm
	TUTjW3xomgBlZkboKnv6DAAhVjYDs34d0lpum0bP4a8VZQ08IS2J/Uev1XtEMtbe2qqv5T
	cBqhbBSyKTJMbWhkvxwiR9exoXZt19UPn4wFfD0r4M196IUFtFspOpEQpIibXcu1whCE87
	WytF92H+t6rZxW0l1JaR+w8f8su9VBBhwtZd1dD0kIdgHUC6w1leAbv1FYpNrrOAv3SW9a
	MbbzBUY1JCLI4Gqg3sw11nmgOVV2wQisRZhbyHt8FXkARFQBn0FDJp75BQly7w==
Date: Thu, 3 Oct 2024 10:28:06 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Message-ID: <20241003102806.084367ba@kmaincent-XPS-13-7390>
In-Reply-To: <f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
	<f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 3 Oct 2024 01:52:20 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
> > +			int irq_flags, int supported_errs,
> > +			const struct pse_irq_desc *d)
> > +{
> > +	struct regulator_dev **rdevs;
> > +	void *irq_helper;
> > +	int i;
> > +
> > +	rdevs =3D devm_kcalloc(pcdev->dev, pcdev->nr_lines,
> > +			     sizeof(struct regulator_dev *), GFP_KERNEL);
> > +	if (!rdevs)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < pcdev->nr_lines; i++)
> > +		rdevs[i] =3D pcdev->pi[i].rdev;
> > +
> > +	/* Register notifiers - can fail if IRQ is not given */
> > +	irq_helper =3D devm_regulator_irq_helper(pcdev->dev, d, irq,
> > +					       0, supported_errs, NULL,
> > +					       &rdevs[0],
> > pcdev->nr_lines); =20
>=20
> Should irq_flags be passed through? I'm guessing one usage of it will
> be IRQF_SHARED when there is one interrupt shared by a number of
> controllers.

Oh yes, you are right! Thanks for spotting it!

> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for devm_pse_irq_helper(), a wrapper for
> > devm_regulator_irq_helper(). This aims to report events such as
> > over-current or over-temperature conditions similarly to how the regula=
tor
> > API handles them. Additionally, this patch introduces several define
> > wrappers to keep regulator naming conventions out of PSE drivers. =20
>=20
> I'm missing something here, i think.
>=20
> https://docs.kernel.org/power/regulator/consumer.html#regulator-events
>=20
> Suggests these are internal events, using a notification chain. How
> does user space get to know about such events?

When events appears, _notifier_call_chain() is called which can generate ne=
tlink
messages alongside the internal events:
https://elixir.bootlin.com/linux/v6.11.1/source/drivers/regulator/core.c#L4=
898

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


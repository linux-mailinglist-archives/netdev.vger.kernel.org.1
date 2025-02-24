Return-Path: <netdev+bounces-169003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620DBA41F29
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F4A1888736
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BFA233714;
	Mon, 24 Feb 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GYESaaql"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AA1A317A;
	Mon, 24 Feb 2025 12:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400401; cv=none; b=aKjeF1AeTA7EjfjSiQVUA8oduV6Gs4vhbd5/SEI6wIl6jbLf4WMCptSZfXkmXlDR34dvCDA1P+XexXcLW4gyO5NVTT+9ciX96orKI/YFN8rwd76IPkGd+RIsAmJNbsHpbCVJakW4nwm86X/FRAARBQndcbnjBk+aMN8yCQEW/hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400401; c=relaxed/simple;
	bh=6rPFs7hzmUkKaQrVsGuEz1DL+CQFnxE27A0sX3lKafE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ronvZ0PjpNoI20QrLsBwBfQE/Dr9K/OGQpXiV8mIomUtDoj4rdIaQ7GMet8kaAZC4EjxxAWzxDJBznpD6oYjFPyGP4lILtHPuWHraObXi3l2OKdRt6PHFuq7gOqtlKerK+aYZRWZx2zlrCTkShxGylqa0KttR8odLqaCNhjx9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GYESaaql; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E91D744181;
	Mon, 24 Feb 2025 12:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740400396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FnIzeA4pJWQRQR33/yIE0LmlDF+4NGNUEAEh4smthcI=;
	b=GYESaaqlSkjxyaXK6Azd/IDvQ2sQbctDLWXd3q+eh/bblOU4khcJiSwbLRjpahNLnHNShc
	9DrQSKh+vT/LinxLd8n8vIxidgcJsWzai1t6WLBdLx6H2NPamO8EX31h1ycAdonM/ouRzX
	Jmox9KOaTTtiexCUFG8UtlmgIoaNemap0orZwaBS6DuM9EeR90G1z46UlZYS54Wkw8Kc2y
	ytrJRvpsU625KJRP/at8EUsixdcJhkeesdNBfQRfT8RmgB4w9XGysxlKjMYbC0MGLuPC5A
	qV3GM2FYYs83pVv2WNAbgzr0aooywQ0Qchq9SXy1zgIhNlBDDQ3Ozc+a2IuTPA==
Date: Mon, 24 Feb 2025 13:33:12 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250224133312.008291bc@kmaincent-XPS-13-7390>
In-Reply-To: <20250220164201.469fdf6d@kernel.org>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
	<20250220164201.469fdf6d@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Hello Jakub,

On Thu, 20 Feb 2025 16:42:01 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 18 Feb 2025 17:19:06 +0100 Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add support for devm_pse_irq_helper() to register PSE interrupts. This =
aims
> > to report events such as over-current or over-temperature conditions
> > similarly to how the regulator API handles them but using a specific PSE
> > ethtool netlink socket. =20
>=20
> I think you should CC HWMON ML on this.
> Avoid any surprises.

You mean regulator maintainers right?
=20
> > diff --git a/Documentation/netlink/specs/ethtool.yaml
> > b/Documentation/netlink/specs/ethtool.yaml index 655d8d10fe24..da78c5da=
f537
> > 100644 --- a/Documentation/netlink/specs/ethtool.yaml
> > +++ b/Documentation/netlink/specs/ethtool.yaml
> > @@ -1526,6 +1526,22 @@ attribute-sets:
> >          name: hwtstamp-flags
> >          type: nest
> >          nested-attributes: bitset
> > +  -
> > +    name: pse-ntf
> > +    attr-cnt-name: __ethtool-a-pse-ntf-cnt
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0 =20
>=20
> Please don't add the unused entries unless your code actually needs
> them. YNL will id real ones from 1 anyway.

ok.

> > +      -
> > +        name: header
> > +        type: nest
> > +        nested-attributes: header
> > +      -
> > +        name: events
> > +        type: nest
> > +        nested-attributes: bitset =20
>=20
> Do we really need a bitset here? Much more manual work to make a bitset
> than just a uint + enum with the bits. enum is much easier to use with
> YNL based user space, and it's more self-documenting than a list of bits
> buried in the source of the kernel.

Ok will change it in next version.=20

> >  operations:
> >    enum-model: directional
> > @@ -2382,3 +2398,13 @@ operations:
> >            attributes: *tsconfig
> >          reply:
> >            attributes: *tsconfig
> > +    -
> > +      name: pse-ntf
> > +      doc: Notification for pse events. =20
>=20
> s/pse/PSE/

Oh thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


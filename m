Return-Path: <netdev+bounces-163028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10FFA28EE1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0005D7A18CC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC714A088;
	Wed,  5 Feb 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YP3L5Ao7"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D014A28;
	Wed,  5 Feb 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738765115; cv=none; b=gMCes+1+h5LqR4JjYnpnEyjTBvCdUpKxjZfJb9kGc8GHHZVoPCnwD+ogsayKqoXv1EhmQO92cTzLEp99dXud1II/QQgB/sRJ4FhYZLaDpe+07QbCqXWgxnIsZFK9Z0gJMtKvG7LV26Fb8o7cSH7MkdetH8UVcPuqcSYyUSlX+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738765115; c=relaxed/simple;
	bh=aZBMMyaxCDfhJnnHsdLjPCpzBvuSsrTgVOQZffpvq5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucNAP91Up7vvHShqoIW4nF7qRBI6foqiFIl5nP6MXRzedwHsEBTzndaMrKpdOzy7d6VqEBnkFX15/fm6lYhdzY5+oB/IdtuIHYonttBVrrtlXhZljlSVpWUPm+AIo2v97fzN0g+hcryhUcKL8vsy3Pc3ePG6GLvjnI3M6bL23Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YP3L5Ao7; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A812520457;
	Wed,  5 Feb 2025 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1738765105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jcjhIK6Qww9CRS3+S8VD/DtB2JrJ0nIx9XhierQplY=;
	b=YP3L5Ao7Wf+re27gX/s4xqtwPqGfwk0ZmMDq3SrxFJbv8S67S8OyiVelQI1GgnaTwCi8ya
	l9NTD+q/gkOPvaXXcmPExY07nPGGV4HinqGGk0bAl89qrnczltvNOhFhg3iMaFbh6E6Dee
	mF6GzumW2IcsqsWXg2ro3erjxBfabBGSofGcZuJ0DfU4q/wMW9SLz4SYMSgYApjUmTswVf
	BysAd0P1WbsAPXmQ8uEOyAlhDUH9aFB/3fZDPJ+WdmvmYwZM38dLBVaTUD8jb/L/tMr0QJ
	pK+yq+nzyVmVzDt9rybYqejy+8QtH8gQatx4TIYxJpAnmA4NGmMDz94e7wjntg==
Date: Wed, 5 Feb 2025 15:18:22 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 27/27] dt-bindings: net: pse-pd:
 ti,tps23881: Add interrupt description
Message-ID: <20250205151822.06f60e8d@kmaincent-XPS-13-7390>
In-Reply-To: <uv2grnchczucf4vxxzaprfkc6ap56z6uqzaew3qtjqpvmtaqbb@kuv62yntqyfr>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
 <20250103-feature_poe_port_prio-v4-27-dc91a3c0c187@bootlin.com>
 <uv2grnchczucf4vxxzaprfkc6ap56z6uqzaew3qtjqpvmtaqbb@kuv62yntqyfr>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfeeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

Hello Krzysztof,

On Sat, 4 Jan 2025 10:44:49 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Jan 03, 2025 at 10:13:16PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Add an interrupt property to the device tree bindings for the TI TPS238=
81
> > PSE controller. The interrupt is primarily used to detect classification
> > and disconnection events, which are essential for managing the PSE
> > controller in compliance with the PoE standard.
> > =20
> > @@ -62,6 +65,7 @@ unevaluatedProperties: false
> >  required:
> >    - compatible
> >    - reg
> > +  - interrupts =20
>=20
> Why? That's an ABI change. Commit msg mentions something like "essential
> for standard" so are you saying nothing here was working according to
> standard before?

Yes indeed, the disconnection management did not follow the standard. Witho=
ut
this series, the power on the ports of this controller is not shut down aft=
er a
Powered Device disconnection. Unfortunately, I did not noticed this before.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


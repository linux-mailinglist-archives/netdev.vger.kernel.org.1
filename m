Return-Path: <netdev+bounces-198054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D561CADB17C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFF03B72CB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B8C295520;
	Mon, 16 Jun 2025 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i+w6G83w"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EC285C8A;
	Mon, 16 Jun 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079685; cv=none; b=rJNQ+jo1Dt5GLw8EN8x3rnBuNQmk4yC4J0/rw6Ds7uqIl/P45uV7uOEpgoCajHUN/vr7hPiekfr33eC1J6+VQ0gjHV3LH2ePTEoyYDaZUJ3vJq0sLMS6Yf0b/2BsgqLD19xRYOq3gR+4dZT3k9b5X+SvUMLM+ICFdcPHTDSAN+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079685; c=relaxed/simple;
	bh=kb1b6C4yM57+Gn9/9WAtBxL1EdUT2+sgNeDSaVoGKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3ONv2Id+Hy0iXVY2YRdPbpMP8TLJPc0znpYXRDoolhV8JbKmzfl1KLXGyaqA8a7EQR2CrMcBSpTAX/dLFKVMkcoLGcwtx4Ax9KZPfcp9MjQ1mvRn66xBpgw1wvxAXgSdRvN4X5MBqGdY/bwyvdVkrVwnUe8ig9aGadW49hFJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i+w6G83w; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C74F644305;
	Mon, 16 Jun 2025 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750079680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6tGU+j/DGX7Z6zWCQu/tHD8h7NUEb8TaXsJyR3P26k=;
	b=i+w6G83wep4FVd7GHRgZDcLQ4cJPLMYnKlP0oENTWL2kzvp51yNaUPYuTyTTrD6EF+P0KH
	GVNQfz8TAiDhLMVV3skdZqb5DVOK2c1hyjenlZwi0HfmqfRD+gt8aShXYJjjZ2qOpAGvC7
	lB0V/EG34ckQ+sr3I6azKcwJsRDzorxSeQ4ALO5gRR7ZiwnNTFAoVJcrIBLxdbxQmfcE8c
	B8fGmbPfXPiaUUZkGP1C1QTP24FznknLwVBPJTbMAvPvhYdV3XYOih5iECKup+T19XgZdj
	FrbbraKu705iKPnDFeNnW58E42qN8PKgXBgR59SBra/ov6mYm3I1XUDK8tQ4Rg==
Date: Mon, 16 Jun 2025 15:14:37 +0200
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
Subject: Re: [PATCH net-next v13 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250616151437.221a4aef@kmaincent-XPS-13-7390>
In-Reply-To: <20250614123311.49c6bcbf@kernel.org>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-7-c5edc16b9ee2@bootlin.com>
	<20250614123311.49c6bcbf@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Sat, 14 Jun 2025 12:33:11 -0700,
Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :

> On Tue, 10 Jun 2025 10:11:41 +0200 Kory Maincent wrote:
> > +static bool
> > +pse_pi_is_admin_enable_not_applied(struct pse_controller_dev *pcdev,
> > +				   int id) =20
>=20
> the only caller of this function seems to negate the return value:
>=20
> drivers/net/pse-pd/pse_core.c:369:              if
> (!pse_pi_is_admin_enable_not_applied(pcdev, i))
>=20
> let's avoid the double negation ?

I thought it was better for comprehension.
If we inverse the behavior we would have a function name like that:
pse_pi_is_admin_disable_not_detected_or_applied()

Do you have a better proposition?

> > +static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
> > +{
> > +	unsigned long notifs =3D ETHTOOL_PSE_EVENT_OVER_BUDGET;
> > +	struct pse_ntf ntf =3D {};
> > +	int ret;
> > +
> > +	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
> > +
> > +	NL_SET_ERR_MSG_FMT(&ntf.extack,
> > +			   "Disabling PI %d to free power budget", id); =20
>=20
> You so dutifully fill in this extack but it doesn't go anywhere.
> Extacks can only be attached to NLMSG_ERROR and NLMSG_DONE
> control messages. You can use the extack infra for the formatting,
> but you need to add a string attribute to the notification message
> to actually expose it to the user.

Indeed it seems there are useless extacks.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


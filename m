Return-Path: <netdev+bounces-169150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CEA42B03
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 400A87A7939
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348F266187;
	Mon, 24 Feb 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RwbQISGt"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177D265CD4;
	Mon, 24 Feb 2025 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421168; cv=none; b=o4jGpZpxeJSufS2miTrr5q021qEI1Lx8CFE8jPM1KKmCJOP4ELbxXxIxwK/d/dxZkyE1EZNHj6Al0rM+EXq4QgQ+DO1tDjRuEf3X5fOXinkfzYzQNucwb3xkqQPYWLbAkvgoAXMT1o9XwOeGyz19EGeCUhhbtkfZG+x6rGvianY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421168; c=relaxed/simple;
	bh=K8Pt8n3Cjrm4U3ZHDVZarmu2EEqAMXmBS/rpZBzOhuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoA1DxwAh3ZhoIpnjvXiE7IKAxd/PpZez/wWnUgbh+COYC2gxkkdOJNrn3HrSrjBqUkl/iMnLvBOMMzWGVcCP2imbA/YN19kNWEo34t6zKh2nE8Zboy2Y8sNGQ7LAn2znbxVf4qRwiqrsUqSaLNNwaXxpUfs4oV3jP6ga5Fs8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RwbQISGt; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E3619442BD;
	Mon, 24 Feb 2025 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740421160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbO1pVG5xjunhNjVFKdnoAkjHJGfbJL6V7hh0xCFAVM=;
	b=RwbQISGt0vpZPPf+v4In6D7byhkKBz5dM/mIjAmLNip4JfThV1TSFG8F1MrFyZUWjX2KBh
	zh562h3VYgS6WaTU384rYbIHNw7LVagU1QEFvWJtzNFnPTG/nOlqeJPRakkBsAqeMKLVgf
	Ipng/fxyuOx2iW8gGaXtTLjf7T6vDIeu/AoO9mhgKt/HS84VD9A7jFALuKeyiP8WtrYEZg
	krIXm1rTgQU/XHWnPsafcSOAcSWMHEGBde19sbT8Ok2mQZt7aELF5VMRvAWdayjiee0VRO
	DRpWgcApAygb9UCmnJ8T3eK34IPYAOGN252UU1qSFs7B7mXtCJUZA1F9QvqfdQ==
Date: Mon, 24 Feb 2025 19:19:17 +0100
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
Message-ID: <20250224191917.31063062@kmaincent-XPS-13-7390>
In-Reply-To: <20250224120228.62531319@kmaincent-XPS-13-7390>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
	<Z7g-WYQNpVp5w7my@pengutronix.de>
	<20250224120228.62531319@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqfedtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhjeevfeeggeeghffgudfhhedvvedvueekleevjeduvddutefhvddugedtfeeludenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemleehrggvmeelfhdttdemkegrudelmehfvgejtdemvgegtggtmegsfhdugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelhegrvgemlehftddtmeekrgduleemfhgvjedtmegvgegttgemsghfudegpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvm
 hesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Feb 2025 12:02:28 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Hello Oleksij,
>=20
> On Fri, 21 Feb 2025 09:50:33 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>=20
> > Hi Kory,
> >=20
> > On Tue, Feb 18, 2025 at 05:19:06PM +0100, Kory Maincent wrote: =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > Add support for devm_pse_irq_helper() to register PSE interrupts. This
> > > aims to report events such as over-current or over-temperature condit=
ions
> > > similarly to how the regulator API handles them but using a specific =
PSE
> > > ethtool netlink socket.   =20
> >=20
> > Thank you for your work. Here some comments.
> >=20
> > ...
> >  =20
> > > --- a/drivers/net/mdio/fwnode_mdio.c
> > > +++ b/drivers/net/mdio/fwnode_mdio.c
> > > @@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
> > >  MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
> > > =20
> > >  static struct pse_control *
> > > -fwnode_find_pse_control(struct fwnode_handle *fwnode)
> > > +fwnode_find_pse_control(struct fwnode_handle *fwnode,
> > > +			struct phy_device *phydev)
> > >  {   =20
> >=20
> > This change seems to be not directly related to the commit message.
> > Is it the preparation for the multi-phy support? =20
>=20
> I need to save the phy_device related to PSE control to use the right net=
work
> interface for the ethtool notification. (ethnl_pse_send_ntf())
> Indeed I have not described this in the commit message.

In fact, there is another solution. We can go over all the PHYs and look for
the one that matches the psec pointer.

Mmh it is maybe better, it will avoid saving the phy_device pointer into
the newly attached_phydev.

I will go for it in v6.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


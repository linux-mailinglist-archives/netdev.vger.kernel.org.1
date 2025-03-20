Return-Path: <netdev+bounces-176471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39BBA6A777
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C181673CA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7409C21B9E3;
	Thu, 20 Mar 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bU4FwSRs"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3181388;
	Thu, 20 Mar 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478208; cv=none; b=aWpb8z2fTR+4TNa9B1o033brwoTdnCzrvw5HEoEfwOUMAY3oJGJcL1nPdpvQYjSQ/UcEVpkJ2LzbXCjvgxD37KHtsKONaXoqKrEG1jqjTqAudZflEr7Ld6+9G3scoSM6laCHsVpASDZe/90AJ8ppEy6/SdO01fElgS7pNCRM5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478208; c=relaxed/simple;
	bh=S8xFmaSoAAUxEP+0iMp36csjXWoCzGqwU9wTW+UNxUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zg4t9HC6paqZXTmzK472BrU+S4GUB6wCMDRZ8xucOZdC22zpgjD3TLKWfJiGAES4BaVyYaPhdSn7wx8hjXilK/JT68E3RlpgMlmk/jrvT7gsDdS9hH4FieGTAKYmhnrJ3QbRfd+7vG2c75aaFhsm0dAYsprrAalujkJdS2plrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bU4FwSRs; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C69444426C;
	Thu, 20 Mar 2025 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742478204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fE4jrLK05tOs9g4cGw2bhuIrt3u2SO/VLMBHpY94468=;
	b=bU4FwSRsPbBen2d82lw2I5EBF+qivynzAMekfxqHKMfLjUbwX2QAdPTxAB4pltUNGFkIjQ
	piWvMQ6RrhofqAYXPznNmkS7ppbl7Wo5B4DBXL3IHg1yzKWRf8rcLPZBIEsDF2QZKxNmHH
	0qDepOE1+jaZya2sFlLhsC/tY9Cwi+WtI1lsZg5G4ZjxJFSy0UCO5WusW6QxcNb/4gObLd
	u397grA+R4bKJ0N3Db06PkD2HVVD5eIBV9pMhpODL+/foOb0mTFwIK4Ed5fPLMhO0iB5VL
	nZhHr288nJqwyKWEq7vdFLE07YwYmbn1l5mBVF/DbPiPQO8PH16bfcXfpjaPUw==
Date: Thu, 20 Mar 2025 14:43:20 +0100
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
Subject: Re: [PATCH net-next v6 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250320144320.53360553@kmaincent-XPS-13-7390>
In-Reply-To: <Z9frWsKESEaB9GcZ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
	<Z9frWsKESEaB9GcZ@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekfeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfejveefgeeggefhgfduhfehvdevvdeukeelveejuddvudethfdvudegtdefledunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleksij,

On Mon, 17 Mar 2025 10:28:58 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi K=C3=B6ry,
>=20
> sorry for late review.

No worry, thank you for the review! :)
=20
> On Tue, Mar 04, 2025 at 11:18:51AM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com> =20
> ...
> > diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_m=
dio.c
> > index aea0f03575689..9b41d4697a405 100644
> > --- a/drivers/net/mdio/fwnode_mdio.c
> > +++ b/drivers/net/mdio/fwnode_mdio.c
> > @@ -18,7 +18,8 @@ MODULE_LICENSE("GPL");
> >  MODULE_DESCRIPTION("FWNODE MDIO bus (Ethernet PHY) accessors");
> > =20
> >  static struct pse_control *
> > -fwnode_find_pse_control(struct fwnode_handle *fwnode)
> > +fwnode_find_pse_control(struct fwnode_handle *fwnode,
> > +			struct phy_device *phydev)
> >  {
> >  	struct pse_control *psec;
> >  	struct device_node *np;
> > @@ -30,7 +31,7 @@ fwnode_find_pse_control(struct fwnode_handle *fwnode)
> >  	if (!np)
> >  		return NULL;
> > =20
> > -	psec =3D of_pse_control_get(np);
> > +	psec =3D of_pse_control_get(np, phydev);
> >  	if (PTR_ERR(psec) =3D=3D -ENOENT)
> >  		return NULL;
> > =20
> > @@ -128,15 +129,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bu=
s,
> >  	u32 phy_id;
> >  	int rc;
> > =20
> > -	psec =3D fwnode_find_pse_control(child);
> > -	if (IS_ERR(psec))
> > -		return PTR_ERR(psec);
> > -
> >  	mii_ts =3D fwnode_find_mii_timestamper(child);
> > -	if (IS_ERR(mii_ts)) {
> > -		rc =3D PTR_ERR(mii_ts);
> > -		goto clean_pse;
> > -	}
> > +	if (IS_ERR(mii_ts))
> > +		return PTR_ERR(mii_ts);
> > =20
> >  	is_c45 =3D fwnode_device_is_compatible(child,
> > "ethernet-phy-ieee802.3-c45"); if (is_c45 || fwnode_get_phy_id(child,
> > &phy_id)) @@ -169,6 +164,12 @@ int fwnode_mdiobus_register_phy(struct
> > mii_bus *bus, goto clean_phy;
> >  	}
> > =20
> > +	psec =3D fwnode_find_pse_control(child, phy);
> > +	if (IS_ERR(psec)) {
> > +		rc =3D PTR_ERR(psec);
> > +		goto unregister_phy;
> > +	} =20
>=20
> Hm... we are starting to dereference the phydev pointer to a different
> framework without managing the ref-counting.
>=20
> We will need to have some form of get_device(&phydev->mdio.dev).
> Normally it is done by phy_attach_direct().
>=20
> And the counterpart: put_device() or phy_device_free()

The thing is that the pse_control is already related to the PHY. It is crea=
ted
(pse_control_get_internal) when a PHY is
registered (fwnode_mdiobus_register_phy), and removed when the PHY is remov=
ed
(phy_device_remove).

If we add a get_device it will increase the refcount of the PHY device but =
we
won't be able to decrease the refcount as it will never enter the remove
callback due to that refcount.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


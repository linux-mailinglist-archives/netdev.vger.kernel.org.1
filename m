Return-Path: <netdev+bounces-180761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFFA82579
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F42178766
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9773425EFBF;
	Wed,  9 Apr 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UWxbpKE9"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAB22253E4;
	Wed,  9 Apr 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203535; cv=none; b=H9Mfg9WzD1/ZYLQs2KrwNvCBpMKKSlM6pgsunZ094E903CL5bDNhyfi403T8nKBr8T1EBfxkD0aiSFWYi/WS74r3I1EFtqCRU4Q3gSGv3BUBTumRbxcCxLoc/QnDxm2ZPfV1CetdkzUlgRdW9+ztXq9uk4hyWDLX+Do7i9Qn2LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203535; c=relaxed/simple;
	bh=v0E8JwOeSFTseer5b+OWBKz2tkz65IA5DX+mqCrtQ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4uNpX1Sy78gcp0OAezt1CL6s6RjvCApZsrBj+W7WCnUB/COnq94sb87vrymXgg5lyvbgJOCUxcPnxTzxjLGeVQ61mCJkp7ENMe0Y1wdP7LIA1LOnw0494CdejTlaDOoI030IbHEXYdsnS9i6tm3Bi/xETmSGZYmgwU+MdGohbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UWxbpKE9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C70FD433F1;
	Wed,  9 Apr 2025 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744203531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+ga/SibcWPx3fl3n2uJ5iHXkBtS8N9d3kPs8xAyuRw=;
	b=UWxbpKE9/Y7votllY+udYTCtqWxd59BQ978/IVivP+m7tYkDVZzyQBDPeHqyzA0fDrJm6e
	YxReLsbiBUY8UOyKOTbZnF+oBtJfkEWKmm84hbhLsnjapK7dkioCW9rFlCl2oT/UzZHWGi
	Uozc14KbUceUThlAw1yB2mpO6U54S+GH9wKlJ0O/B67QsWIOXPaU2uapeBHK4mWyz/adsl
	HHmZSGkzbKQDHjqPoO8F9dqLFdFN1ZP42KPJO1UuEelon0CoYSbZezlqQd5w4vLymR2JOF
	/Sdz/nSL7QHLk12ykIr8Vxihg/QGOiyiND9RJvsB8e9WHltvsNI3RgvyxXI0XA==
Date: Wed, 9 Apr 2025 14:58:48 +0200
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
Subject: Re: [PATCH net-next v7 04/13] net: pse-pd: Add support for PSE
 power domains
Message-ID: <20250409145848.552fadd2@kmaincent-XPS-13-7390>
In-Reply-To: <Z_VmYMvqfrBPR1l5@pengutronix.de>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
	<20250408-feature_poe_port_prio-v7-4-9f5fc9e329cd@bootlin.com>
	<Z_VmYMvqfrBPR1l5@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeitdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

Hello Oleksij,

On Tue, 8 Apr 2025 20:09:36 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi Kory,
>=20
> here are some points
>=20
> On Tue, Apr 08, 2025 at 04:32:13PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > +static struct pse_power_domain *devm_pse_alloc_pw_d(struct device *dev)
> > +{
> > +	struct pse_power_domain *pw_d;
> > +	int index, ret;
> > +
> > +	pw_d =3D devm_kzalloc(dev, sizeof(*pw_d), GFP_KERNEL);
> > +	if (!pw_d)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret =3D xa_alloc(&pse_pw_d_map, &index, pw_d, XA_LIMIT(1,
> > PSE_PW_D_LIMIT),
> > +		       GFP_KERNEL);
> > +	if (ret)
> > +		return ERR_PTR(ret); =20
>=20
> Missing "kref_init(&pw_d->refcnt);" ?

Oh yes, indeed thanks.

> > +
> > +		pw_d =3D devm_pse_alloc_pw_d(pcdev->dev);
> > +		if (IS_ERR_OR_NULL(pw_d)) { =20
>=20
> s/IS_ERR_OR_NULL/IS_ERR
>=20
> devm_pse_alloc_pw_d() is not returning NULL.
=20
Yes, that's right!

> > +			ret =3D PTR_ERR(pw_d);
> > +			goto out;
> > +		}
> > +
> > +		supply =3D regulator_get(&rdev->dev, rdev->supply_name);
> > +		if (IS_ERR(supply)) {
> > +			xa_erase(&pse_pw_d_map, pw_d->id);
> > +			ret =3D PTR_ERR(supply); =20
>=20
> Here:
> Either we need to ensure pse_flush_pw_ds() handles incomplete setups
> or immediately clean up earlier entries in the loop when an error
> occurs.

The pw_d has not yet been saved to pcdev->pi[i].pw_d so we need to remove t=
he
pw_d from the xarray here. pse_flush_pw_ds will deal with all the pw_d entr=
ies
in pcdev->pi[x].

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


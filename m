Return-Path: <netdev+bounces-198040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476EADAFDF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0EC07A6C99
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574192E425C;
	Mon, 16 Jun 2025 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EEyg/Hp6"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDF02E4241;
	Mon, 16 Jun 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075821; cv=none; b=ROis3f7MOIlJhmAtkFNAayEsqZKs+eXD0gNBjWjrqNzt3nRltssFo9SIjX6iSTtQ1AkfrRIl+CSsXyNajW2grot9EFf2NKzcCbJwxyON6OTkbYQg3z92t8GzkTZWSC0SQPZp4Y9NOX9kP7K/yBOr4GfT8fUWOaI/GCY7lTXd1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075821; c=relaxed/simple;
	bh=ojwhMmVeMqnjZosqlXZruxACtgqBN03bmbQ1B9/E6UI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8C9cYtqz5m9yAOQCPvXID20ipzJPAQfzxxLLK5b1kuY+IHswAwlRE9o82d2tqkyduimfDEANlwQtIEHoYKYws9EauiDjqj3L/r1Hs49+L5C5w0YEg5QhONnQtScjaGBMRxQhbdlhXsZSWxCoushX1W8DO3D5cVq3cetzcH+e8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EEyg/Hp6; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D9D0205B1;
	Mon, 16 Jun 2025 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750075816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAo/rJoPJaVKk6/wqH24mlqd1olNxReIFJb4vfD2uts=;
	b=EEyg/Hp645fFSuxaOy1mGDBN/y7qfmX8LqB/i8dgo50hV3oMUizGP9yaXCwt8Uje6kL6mF
	gaqkgdO7z48gIBDUevCzrzPtYR8MDj1kx7EswQ3jQ2H5ktr1DQc7sgpQeewIdsM7hUlgfp
	7ID3oNq3HthGCYZouA303VyDmFOulN4ytAbGKe81xPFZUl8fj1Ra5xsWoLvZcQTbQxz8c+
	SHJzrT/vPkt/jhCpfo9i8UJg10Gen0Xm3T/fJs0DVnjQXKlyhWNjwsNQYKZw7/UJIkfzDz
	H3e6tKQv5vN3ibI7n13bmW79ZKg/AuleT1HH36zfa7J8HOsWdIdgug9RLxL8Cw==
Date: Mon, 16 Jun 2025 14:10:12 +0200
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
Subject: Re: [PATCH net-next v13 02/13] net: pse-pd: Add support for
 reporting events
Message-ID: <20250616141012.31305f81@kmaincent-XPS-13-7390>
In-Reply-To: <20250616135722.2645177e@kmaincent-XPS-13-7390>
References: <20250610-feature_poe_port_prio-v13-0-c5edc16b9ee2@bootlin.com>
	<20250610-feature_poe_port_prio-v13-2-c5edc16b9ee2@bootlin.com>
	<20250614121843.427cfc42@kernel.org>
	<20250616135722.2645177e@kmaincent-XPS-13-7390>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvieehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvjedprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiiv
 ghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

Le Mon, 16 Jun 2025 13:57:22 +0200,
Kory Maincent <kory.maincent@bootlin.com> a =C3=A9crit :

> Le Sat, 14 Jun 2025 12:18:43 -0700,
> Jakub Kicinski <kuba@kernel.org> a =C3=A9crit :
>=20
> > On Tue, 10 Jun 2025 10:11:36 +0200 Kory Maincent wrote: =20
> > > +static struct net_device *
> > > +pse_control_find_net_by_id(struct pse_controller_dev *pcdev, int id,
> > > +			   netdevice_tracker *tracker)
> > > +{
> > > +	struct pse_control *psec, *next;
> > > +
> > > +	mutex_lock(&pse_list_mutex);
> > > +	list_for_each_entry_safe(psec, next, &pcdev->pse_control_head,
> > > list) {   =20
> >=20
> > nit: _safe is not necessary here, the body of the if always exits after
> > dropping the lock =20
>=20
> Indeed, I will drop it.
>=20
> > Do you plan to add more callers for this function?
> > Maybe it's better if it returns the psec pointer with the refcount
> > elevated. Because it would be pretty neat if we could move the=20
> > ethnl_pse_send_ntf(netdev, notifs, &extack); that  pse_isr() does
> > right after calling this function under the rtnl_lock.
> > I don't think calling ethnl_pse_send_ntf() may crash the kernel as is,
> > but it feels like a little bit of a trap to have ethtool code called
> > outside of any networking lock. =20
>=20
> Ok. My aim was to put the less amount of code inside the rtnl lock but if=
 you
> prefer I will call ethnl_pse_send_ntf() with the lock acquired.

psec pointer is private to pse so we will have something like the following.
Is it ok for you ?

psec =3D pse_control_find_by_id(pcdev, i, &tracker);
rtnl_lock();
if (psec && psec->attached_phydev &&
    psec->attached_phydev->attached_dev)
	ethnl_pse_send_ntf(psec->attached_phydev->attached_dev, notifs,
			   &extack);
rtnl_unlock();
pse_control_put(psec);


--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


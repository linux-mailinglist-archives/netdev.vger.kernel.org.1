Return-Path: <netdev+bounces-170393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B027CA487CB
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FC53B3825
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294321A453;
	Thu, 27 Feb 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UFgVAsAl"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDE1F5824;
	Thu, 27 Feb 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680813; cv=none; b=eDzPG/Gd7ABbxBYQWQ8SUkB67rNqHIvAs2fxz2jrad6cLR27967UPkX35abV8y93Yl04JyezNdBgrCRVG2axcFQT1MqgSwsCVRLvxtA/SWmSotrs6/tr60E7arjBxfJzeyRDUHGp7VoNW1NZ8HAgMLEmR/M9GJLs83iCaLhupEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680813; c=relaxed/simple;
	bh=5sc/J0s6lEdIy2pZt0nxLEL2mjPywISFCV+wJ7uO7gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hog+7m3/gL9IWeqIodxVx6SsGO82Fg/oFKUFDUOn+1kO9UOCH1JY3hIXXkIGr5CSeAXmdTrPRWthUkmR4lrQTRteo5JNGnMWDqSzo2PJJJEdI3mpHgop84ylE7SU1e9RCtp/Cm2x64+m6SW1uWzC3LuXWMdHx9UCwRATKxQyLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UFgVAsAl; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 071E943C67;
	Thu, 27 Feb 2025 18:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740680804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9oO+amqa8DFX9tqfu1bJ3Nj0kZiOGUnRSOidwS8pfc=;
	b=UFgVAsAlx4FDMBuupoAnv0/iymk/kGT6KiQjA23TUVjouMBXRIpUwV9p0GNm1A82soxVNZ
	mPwDVzJLqxWivyjWcb3+Yvpe6/kPQfl8h4BUE+cbwKbNf6ExzZt4rw19dmRQm5sFtFf3QO
	HlvK/hg06wUpR+y+eNLqRUT1aNtjK4s/5gYJ7u6rpWz5weQPW4MbBQQL64d6caR1j6nhUe
	AP7cJfOahS6no0YopMudyQm/LnAAlt+jwfUGX/GHKXC/kvLnaXH9sHJfnA8M46dfCznd6e
	GVsnj1m/h7DaWMX1T92K4b+Abl1WhpdKmBUdX5dv00mU9XAr2KwW2MLcKNmYyQ==
Date: Thu, 27 Feb 2025 19:26:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
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
Subject: Re: [PATCH net-next v5 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250227192640.20df155d@kmaincent-XPS-13-7390>
In-Reply-To: <Z8CVimyMj261wc7w@pengutronix.de>
References: <20250220165129.6f72f51a@kernel.org>
	<20250224141037.1c79122b@kmaincent-XPS-13-7390>
	<20250224134522.1cc36aa3@kernel.org>
	<20250225102558.2cf3d8a5@kmaincent-XPS-13-7390>
	<20250225174752.5dbf65e2@kernel.org>
	<Z76t0VotFL7ji41M@pengutronix.de>
	<Z76vfyv5XoMKmyH_@pengutronix.de>
	<20250226184257.7d2187aa@kernel.org>
	<Z8AW6S2xmzGZ0y9B@pengutronix.de>
	<20250227155727.7bdc069f@kmaincent-XPS-13-7390>
	<Z8CVimyMj261wc7w@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefgudeuudehudekvdehteeuudefudeugfeitdeitdeuuefhudekjefhteevffdtheenucffohhmrghinhepughirghgnhhoshhtihgtshdrtggrthdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemleehrggvmeelfhdttdemfhegtdgumegvvdejleemudejrghfmeegheejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeelhegrvgemlehftddtmehfgedtugemvgdvjeelmedujegrfhemgeehjeelpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 27 Feb 2025 17:40:42 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Feb 27, 2025 at 03:57:27PM +0100, Kory Maincent wrote:
> > On Thu, 27 Feb 2025 08:40:25 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >  =20
> > > On Wed, Feb 26, 2025 at 06:42:57PM -0800, Jakub Kicinski wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > Ok, I see. @K=C3=B6ry, can you please provide regulator_summary with =
some
> > > inlined comments to regulators related to the PSE components and PSE
> > > related outputs of ethtool (or what ever tool you are using).
> > >=20
> > > I wont to use this examples to answer. =20
> >=20
> > On my side, I am not close to using sysfs. As we do all configurations
> > through ethtool I have assumed we should continue with ethtool. =20
>=20
> Yes, I agree. But it won't be possible to do it for all components.
>=20
> > I think we should set the port priority through ethtool. =20
>=20
> ack
>=20
> > but indeed the PSE  power domain method get and set could be moved to
> > sysfs as it is not something  relative to the port but to a group of
> > ports. =20
>=20
> I would prefer to have it in the for of devlink or use regulator netlink
> interface. But, we do not need to do this discussion right now.

If we want to report the method we should discuss it now. We shouldn't add
BUDGET_EVAL_STRAT uAPI to ethtool if we use another way to get and set the
method later.

We could also not report the method for now and assume the user knows it for
the two controllers currently supported.
=20
> > Ethtool should still report the  PSE power domain ID of a port to know
> > which domain the port is. =20
>=20
> Exactly.
>=20
> @Jakub, at current implementation stage, user need to know the domain
> id, because ports (and priorities) are grouped by the top level
> regulators (pse-regX in the regulator_summary), they are our top-level
> bottlenecks.
>=20
> HP and Cisco switch either use different PSE controllers, or just didn't
> exposed this nuance to the user. Let's assume, they have only one
> global power domain.
>=20
> So, in current patch set I would expect (not force :) ) implementation for
> following fields:
> - per port:
>   - priority (valid within the power domain)
>   - power reservation/allocation methods. First of all, because all
>     already supported controllers have different implemented/default
>     methods: microchip - dynamic, TI - static, regulator-pse - fixed (no
>     classification is supported).
>     At same time, in the future, we will need be able switch between
>     (static or dynamic) and fixed for LLPD or manual configuration.
>     Yes, at this point all ports show the same information and it seems
>     to be duplicated.
>   - power domain ID.
>=20
> @Jakub, did I answered you question, or missed the point? :)
>
> > @Oleksij here it is: =20
>=20
> Thank you!
>=20
> I do not expect it to be the primer user interface, but it can provide
> additional diagnostic information. I wonted to see how it is aligns
> with current ethtool UAPI implementation and if it possible to combine
> it for diagnostics.
>=20
> > # cat /sys/kernel/debug/regulator/regulator_summary
> >  regulator                      use open bypass  opmode voltage current
> > min     max
> > -----------------------------------------------------------------------=
----------------
> > regulator-dummy                  5    4      0 unknown     0mV     0mA
> > 0mV     0mV d00e0000.sata-target          1
> > 0mA     0mV     0mV d00e0000.sata-phy             1
> >         0mA     0mV     0mV d00e0000.sata-ahci            1
> >                 0mA     0mV     0mV spi0.0-vcc                    1
> >                         0mA     0mV     0mV pse-reg
> >  1    4      0 unknown     0mV     0mA     0mV     0mV  =20
>=20
> pse-regX should be attached to the main supply regulator for better full
> picture. And use different name to be better identified as PSE power doma=
ins
> with ID?

This is the regulator name set in the devicetree description so we can set
whatever we want.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


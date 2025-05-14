Return-Path: <netdev+bounces-190412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D8CAB6C38
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9DD3ABEFE
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47C276038;
	Wed, 14 May 2025 13:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LzdTj1mU"
X-Original-To: netdev@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933E1C8614;
	Wed, 14 May 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747228219; cv=none; b=o74PC4p1uBq4hXM+zAensV2fZByxOI8ZqPIFF4k03wjZdnf8f14rz7qh6d7KutR/mbrQ7rBMubT8zB/yle828taytKbXOKgCFHAnO4zTAUex3L/6DdNO/6VdYeEKljG3FWQXqG4AH03w/Or0kov0U8O3Cf+wbUlGKJrJHWLxtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747228219; c=relaxed/simple;
	bh=zoQUDV8YwIdtbQF4B50EXzFk7sJmiB4WiMO8xN7MYcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xzb4x3Nlya5r0ggumt5X8JThp+z1nXBjFj3z1lk08/gpUPg1QT2ORAFxF2zGKV5IaDbhzfskn0qsRD0yKZGxL5TPYkYrIwiOECaruRxYsyZO6wS6wtQi10Qkb3lKh5ljKU1Wq2KtHHPbh1sM5phueMsEARImw5A0iKwtNn9pIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LzdTj1mU; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id A23495842D9;
	Wed, 14 May 2025 12:49:06 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E54543904;
	Wed, 14 May 2025 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747226939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHeZE/C0YzOV5d6A2KajzZgZmjXTnKc4hT5nUGWBwno=;
	b=LzdTj1mU43cVIJToqB7YFG83X6KEP1+ZiULli1fpuXaIr67xS1vdXQuhIEdAy6Vjmzxe1Z
	20ORxP7lSM845aA0Zc3HOXlnHOkyNdyMRzN07vnLeFEfpdYzoKCKQpyPlf66XE2888hXR7
	mahMU+Ia3XszYuoS0xhdtgVM09K4ySLkQb39C0zABBpxRhvuS5dJAiCnd5HWGm7etHMqa6
	rQ3w2sBWxfI2cPELNVUQ0hEqHt2JZZ6ImoBbHA23c3PEdVFk2wqGIxU7NFwJN2gHlB2crL
	K28XGdFX91+3lbFW3K4xUb3sD4hRnU1ok5MnWeBjP5VA5VnlPgM/QAr8OjD0Dg==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Antoine Tenart <atenart@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 3/3] net: phy: dp83869: Support 1000Base-X SFP modules
Date: Wed, 14 May 2025 14:48:52 +0200
Message-ID: <9500044.CDJkKcVGEf@fw-rgant>
In-Reply-To: <519e17e0-9739-43bc-b77a-a77fd103d8d7@lunn.ch>
References:
 <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
 <4702428.LvFx2qVVIh@fw-rgant> <519e17e0-9739-43bc-b77a-a77fd103d8d7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3333674.5fSG56mABF";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdejtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhggtgesghdtreertddtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhvdelkeevgfeijedtudeiheefffejhfelgeduuefhleetudeiudektdeiheelgfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifqdhrghgrnhhtrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheprghtvghnrghrtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegur
 ghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart3333674.5fSG56mABF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 14 May 2025 14:48:52 +0200
Message-ID: <9500044.CDJkKcVGEf@fw-rgant>
In-Reply-To: <519e17e0-9739-43bc-b77a-a77fd103d8d7@lunn.ch>
MIME-Version: 1.0

On Wednesday, 14 May 2025 14:32:22 CEST Andrew Lunn wrote:
> > > > +	/* Update advertisement */
> > > > +	if (mutex_trylock(&phydev->lock)) {
> > > > +		ret = dp83869_config_aneg(phydev);
> > > > +		mutex_unlock(&phydev->lock);
> > > > +	}
> > > 
> > > Just skimmed through this quickly and it's not clear to me why aneg is
> > > restarted only if there was no contention on the global phydev lock;
> > > it's not guaranteed a concurrent holder would do the same. If this is
> > > intended, a comment would be welcomed.
> > 
> > The reasoning here is that there are code paths which call
> > dp83869_port_configure_serdes() with phydev->lock already held, for
> > example:
> > 
> > phy_start() -> sfp_upstream_start() -> sfp_start() -> \
> > 
> > 	sfp_sm_event() -> __sfp_sm_event() -> sfp_sm_module() -> \
> > 	sfp_module_insert() -> phy_sfp_module_insert() -> \
> > 	dp83869_port_configure_serdes()
> > 
> > so taking this lock could result in a deadlock.
> > 
> > mutex_trylock() is definitely not a perfect solution though, but I went
> > with it partly because the marvell-88x2222 driver already does it this
> > way, and partly because if phydev->lock() is held, then there's a solid
> > chance that the phy state machine is already taking care of reconfiguring
> > the advertisement. However, I'll admit that this is a bit of a shaky
> > argument.
> > 
> > If someone has a better solution in mind, I'll gladly hear it out, but for
> > now I guess I'll just add a comment explaining why trylock() is being
> > used.
> The marvell10g driver should be the reference to look at.
> 
> As you say, phy_start() will eventually get around to calling
> dp83869_config_aneg(). What is more interesting here are the paths
> which lead to this function which don't result in a call to
> dp83869_config_aneg(). What are those?

Whenever you insert an SFP module, either sfp_irq() or sfp_poll() will will 
detect it and eventually call module_insert() from the SFP state machine. As 
far as I'm aware, this doesn't imply any calls to config_aneg().

Since the DP83869 remaps fiber registers to 0 when we switch it to RGMII-
to-1000Base-X mode, the value in MII_ADVERTISE won't be correct anymore,
which is why we have to reconfigure the advertisement after a module is 
inserted. It doesn't seem like the marvell10g driver does this, and I'm not 
sure why that's the case.

Thanks,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nextPart3333674.5fSG56mABF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEYFZBShRwOvLlRRy+3R9U/FLj284FAmgkkTQACgkQ3R9U/FLj
286nTw/9E5UQrHOfIT3uIQI3QMeqBBkA9iT8YlrYlSZ2hL4v6pNZv2BLx/yHxKfR
JDKc2UHUstgM6rw7/z1YA70BilxrEdyg9csdDrG+Z3lHVTosZk6M4Q5dX1++SnKo
X+l3Z1zjnkvCDyOfMwBryslJE+omgeCQDTLEhxi7BdseKt9Wd6mzIzqMwTdLijCY
2THGLMnOoSvRjijFOHKTiCkFlzHvSVyHqDBDpl2JPXVuJmbO+QOrB8GPMXy9ONbM
IyhOXQP+CQOh3Z9121nEOe+NjEr+/houLs6D+3IpiEo3YN4tCDq3xJyptBgoQI1K
BfMsZIQX0IVtAjfI1bzRc6e7Bk0O/rtauxZnhf5zg77vGqOx4yX0xs/bW/j9D5Ga
ypMZZUd9NzFBCp669Wq6GvujyruczLItB5+iZFHdqzPuO+uZkG+zVkWO8z60tvYV
9qItf/XP1QwfiSPIDdiLeyWAeZTwzWFoy0UIXDCZZPZoerMXF3Mt2WeoHj5tJLiW
iTt2ns+HciPwtnOmC6KlrBef0Hux4GXSncJqr73576VxeWDVZt+8hS7n4PXPIxVP
08X43O67JPc+ODITgguFQRot3XQHg3w7mJLQ1T9i/85mg+177/uON2Cdz8Iw/Pf6
mVc2aPN1hMUlaDfC9a6fpKESCdkM1+owvTtlaQM8pOE1IXg7R3g=
=XgF6
-----END PGP SIGNATURE-----

--nextPart3333674.5fSG56mABF--





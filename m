Return-Path: <netdev+bounces-176544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D811A6ABDF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679073AC1A2
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5A2236F6;
	Thu, 20 Mar 2025 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mGy2gam1"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9A2A1A4;
	Thu, 20 Mar 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491369; cv=none; b=cTu88/HedbRvGzv9hYFKQLt0jhVMS6Egh+ndZGMwHbrKbRHxDx5k/VFKhhADy12s6EzPHEmvJxMGavoYzsDMYf7v1lJFUjhR1MLhM2CnB9h4C2Gf3c2o6F3sZqeEsFB1wcZzv3VT+cZBBTnjkt7EML0CxeipbriXHIHlyS3m15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491369; c=relaxed/simple;
	bh=o2g+aeF0m1ZtGAU6jmcbwumD06kUHya/WZT+ebSfW9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ji6abE3hGhrZNpZnswPhAIpI6II9HF8Q7sBuRV+8SxTemuTr5SLWwlZTyHLY6KiLNLZlFqSAwcCW64lZCU5OeKth0Lach4fUMwBFLqO+a2PpJPwkeBEs/xSFuSVyyVx7+re2JAybYpt9I4KVjXF9KiQ4wCbOHVS6U2jz01nCPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mGy2gam1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ACD8644324;
	Thu, 20 Mar 2025 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742491365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr0LN2ywhctrz98g/ztt7BNk1UlMTcPiWZ2+H7lH0II=;
	b=mGy2gam1GeJJoq6YqMrza7TyScT6M3R5gFR4vqTQxF3aVDSR9yJGzIQgytegJZRpcWJUpk
	zbeab+OfyD+YZ/P8oletSCOWhTpZo3CK7j3MDU5nwj7Rw0sPaNnnPPhAIxr0XNynl5qpdT
	+IFkpOfe+a2ri4Z8I6qYL1K709Rrvv++mMIBpuyz4bV0bDLk5+byvLviSZ7km276DNpQzH
	P5YDvwZtVQgFUiqnGeHWd4UBmEVLrJA0o64p1nTpWCTe5UwJno91TnEcKTjLlzB5kwNB9u
	8FfZFjjercF+XnWUyE2Kd4kTrNG3MX3bRlN3gN6BPrZ61ouGkgjd4bM6M3CznQ==
Date: Thu, 20 Mar 2025 18:22:42 +0100
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
Subject: Re: [PATCH net-next v6 11/12] net: pse-pd: tps23881: Add support
 for static port priority feature
Message-ID: <20250320182242.401fd6af@kmaincent-XPS-13-7390>
In-Reply-To: <Z9gklcNz6wHU9cPC@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-11-3dc0c5ebaf32@bootlin.com>
	<Z9gklcNz6wHU9cPC@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeekkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehku
 hgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 17 Mar 2025 14:33:09 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Mar 04, 2025 at 11:19:00AM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
...
> > @@ -190,7 +201,22 @@ static int tps23881_pi_enable(struct
> > pse_controller_dev *pcdev, int id) BIT(chan % 4));
> >  	}
> > =20
> > -	return i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
> > +	ret =3D i2c_smbus_write_word_data(client, TPS23881_REG_PW_EN, val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Enable DC disconnect*/
> > +	chan =3D priv->port[id].chan[0];
> > +	ret =3D i2c_smbus_read_word_data(client, TPS23881_REG_DISC_EN);
> > +	if (ret < 0)
> > +		return ret; =20
>=20
> Here we have RMW operation without lock on two paths: pi_enable and
> pi_disable.

I don't understand, pi_enable and pi_disable are called with pcdev->lock
acquired thanks to the pse core.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


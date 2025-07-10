Return-Path: <netdev+bounces-205886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E91B00AFB
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA171C48127
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543472FC3B5;
	Thu, 10 Jul 2025 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RQ+EDHBY"
X-Original-To: netdev@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E42253A7;
	Thu, 10 Jul 2025 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752170771; cv=none; b=ndBPJYICQdjBZJrs1tmVLOceTH3piDgAHn4QYCoaAqdt4Yk5iORw/Pu0hMF1kXt45WUUUZ7m7s8WqaXtHpWdjV1WGtpKVwQh5vcBWAoL2BHE5qRE52NL9hjtI3I1THnKJPT5sbj6S8Tvr8dpIvRcls1Alke07xXzzLfyy7LFn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752170771; c=relaxed/simple;
	bh=HkL+8mtxveLz3jrsdzBTs0WKwyDPQI6LrH3txbRDl9I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mn3vL/mc+QePexFVvae6tKAdOVnKwAOdLKwrrmr9VxEv3f6q2sEmFenJ+jr91spqT+T2FXKxI2RFKwAifgacMimp29xO/VPCiDFxGA7TKznL1Kys2xGyV1r22hGBJ8pPFJ3nDFi3N53fqH1ZD0+ZNNC9B+kTkzyZt9sA/1Yog6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RQ+EDHBY; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 723E8442F3;
	Thu, 10 Jul 2025 18:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752170759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4VgBTfdoGBE3UguuDXxy8ArM6zXNvgOqHM/Bk8c6+Tk=;
	b=RQ+EDHBYSfqBPtkaqQlGfU284sB3YKDakJo0kp9TUypQGrIbrGW2XJAXIAP1m2qFhJS5xZ
	JccOya9daiOMzRWpCd+MeO8r4AQ3lglKCas3ykceCkQtFnueCmEwyVZ+5CrYymYfjSdqOU
	hyYsZ1pn+PGIjxzOhWNj7gdUpIbR3w7mpEQpsSgUEZMoqFGTzMS4ctSjCm6uWox5dnmW5W
	3iLSCfcMEaI9q+m9gVw7KejZ6c+qlyHikLccBnOt/cl4z0549q5wrMi7wDDmTe7CYSxsZd
	9mUSwHkA5rmD6ad1Fq3w02OeIdE4ltJm3LQKKwtVB0cUXa7CgjfFMzWi1P4g2g==
Date: Thu, 10 Jul 2025 20:05:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next v4 2/2] net: pse-pd: Add Si3474
 PSE controller driver
Message-ID: <20250710200557.41e5876a@kmaincent-XPS-13-7390>
In-Reply-To: <53c71efc-e29b-482a-bd6a-7a66a2d2d415@adtran.com>
References: <c0c284b8-6438-4163-a627-bbf5f4bcc624@adtran.com>
	<4e55abda-ba02-4bc9-86e6-97c08e4e4a2d@adtran.com>
	<20250707151738.17a276bc@kmaincent-XPS-13-7390>
	<53c71efc-e29b-482a-bd6a-7a66a2d2d415@adtran.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegudduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgduleemkeehkeejmeejuddttdemleegtgeimeefgedvtgemleejfhehmeeijedvvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeelgegtieemfeegvdgtmeeljehfheemieejvdgvpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehpihhothhrrdhkuhgsihhksegrughtrhgrnhdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpt
 hhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhg

Le Thu, 10 Jul 2025 15:32:11 +0000,
Piotr Kubik <piotr.kubik@adtran.com> a =C3=A9crit :

> On 7/7/25 15:17, Kory Maincent wrote:
> > ...
> >=20
> >  =20
> >> +
> >> +static int si3474_pi_enable(struct pse_controller_dev *pcdev, int id)
> >> +{
> >> +	struct si3474_priv *priv =3D to_si3474_priv(pcdev);
> >> +	struct i2c_client *client;
> >> +	u8 chan0, chan1;
> >> +	u8 val =3D 0;
> >> +	s32 ret;
> >> +
> >> +	if (id >=3D SI3474_MAX_CHANS)
> >> +		return -ERANGE;
> >> +
> >> +	si3474_get_channels(priv, id, &chan0, &chan1);
> >> +	client =3D si3474_get_chan_client(priv, chan0);
> >> +
> >> +	/* Release PI from shutdown */
> >> +	ret =3D i2c_smbus_read_byte_data(client, PORT_MODE_REG);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	val =3D (u8)ret;
> >> +	val |=3D CHAN_MASK(chan0);
> >> +	val |=3D CHAN_MASK(chan1);
> >> +
> >> +	ret =3D i2c_smbus_write_byte_data(client, PORT_MODE_REG, val);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* DETECT_CLASS_ENABLE must be set when using AUTO mode,
> >> +	 * otherwise PI does not power up - datasheet section 2.10.2
> >> +	 */ =20
> >=20
> > What happen in a PD disconnection case? According to the datasheet it s=
imply
> > raise a disconnection interrupt and disconnect the power with a
> > DISCONNECT_PCUT_FAULT fault. But it is not clear if it goes back to the
> > detection + classification process. If it is not the case you will face=
 the
> > same issue I did and will need to deal with the interrupt and the
> > disconnection management.
> >=20
> > Could you try to enable a port, plug a PD then disconnect it and plug
> > another PD which belong to another power class. Finally read the class
> > detected to verify that the class detected have changed. =20
>=20
> Yes, I did this test, also with disabling/enabling PI in between PD
> disconnects/connects. Each time class was detected correctly (class4 vs 3=
 in
> my case). I checked also class results when no PD was connected or PI was
> disabled, all OK.

Ok great! It behaves differently than the TPS23881, so there is no need to =
deal
with the disconnection management. That wasn't clear at first sight.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


Return-Path: <netdev+bounces-104162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4F290B79C
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01BB5B36BBD
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8036AB8;
	Mon, 17 Jun 2024 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJZfp6QY"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C901D952C;
	Mon, 17 Jun 2024 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718640866; cv=none; b=Oa3Pbbqz5I5TIrClbY2cmGQsRUZc6KJgnGyrQiAYV9gywg/0I72Ugc2awaZZtp+fyWjKi77pXkTWqNsciGDJtHHllnKSL6ju/ggWQYGVrxfkEO83jksnfXpWJECBD6k8H2rd/9OUPf5Fca+P9V1AT7jNBL2+qxiDG1lCrZKvxUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718640866; c=relaxed/simple;
	bh=cT0AAvEJ5+7GRrwFlT2hy5GZUsUCnO3yJnOeRS4jWGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VePCHm7sIDAGdLpRb+bGkfZmu4L1UzmnXh3vtdcAU4KCC+eH+6gj6QMrF9wxriXXN+RxUgCSsgnYDXMQTvIbiglkP6bS8VX4yNvZPIDKnEM9yvWAEfNpsTlR7iga2rmqi3QpMFmgqmBGclVSN47Mm6c1AumFr2KGuXnJN4YXh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJZfp6QY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D44540005;
	Mon, 17 Jun 2024 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718640856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iz+UjwJJad9LiOiMA4eIoqFfH5EIpqwtGStSs8qGvyY=;
	b=AJZfp6QYD0lCh15kuisT2712c3jXhgUrdKl5zGE/oY8soC1ya+siEAXWpefHTFQa115qLC
	iLc9mZ1OJ0zb+UNP5w/Im108csFG4g3g1hmhn4zoDsB+hb20704Yd3b6wAE9z76arTq3ZE
	Wkb+vwjQxNYNieeBiGD93hi5Uo3PHS/cLryDKcN3RHA2q1auucrIr4xgfKhJflHrTXzMGA
	ShuUu2nswI6Uh9LJ50qehuccPOEbHeEeF3re/BGNiTH0qON6l6FsFXzOHDi4NCcyAu0V/O
	854sKrAQ9RA8yl7W0kCRoiDpO1Cqtz1Ojc2Idj+tJ7rQ0elIIORyVc77ACFFCQ==
Date: Mon, 17 Jun 2024 18:14:13 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next v3 5/7] net: ethtool: Add new power limit get
 and set features
Message-ID: <20240617181413.12178f95@kmaincent-XPS-13-7390>
In-Reply-To: <Zm6BGJxu4bLVszFD@pengutronix.de>
References: <20240614-feature_poe_power_cap-v3-0-a26784e78311@bootlin.com>
 <20240614-feature_poe_power_cap-v3-5-a26784e78311@bootlin.com>
 <Zm26aJaz7Z7LAXNT@pengutronix.de>
 <Zm3dTuXuVEF9MhDS@pengutronix.de>
 <Zm6BGJxu4bLVszFD@pengutronix.de>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Sun, 16 Jun 2024 08:07:20 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Sat, Jun 15, 2024 at 08:28:30PM +0200, Oleksij Rempel wrote:
>  [...] =20
>=20
> Except of current value, we need an interface to return list of supported
> ranges. For example a controller with flexible configuration will have
> one entry=20

Yes, good idea.
=20
> Proposed interface may look like this:
>=20
>   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT``  u32  Get PoE PSE currently
> configured power value limit ``ETHTOOL_A_C33_PSE_PWR_LIMIT_RANGES``
> nested  Supported power limit configuration ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
>  +------------------------------------------+--------+-------------------=
---------+
>  | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGES``   | nested | array of power
> limit ranges|
> +-+----------------------------------------+--------+--------------------=
--------+
> | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_ENTRY`` | nested | one power
> limit range  |
> +-+-+--------------------------------------+--------+--------------------=
--------+
> | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MIN``  | u32    | minimum power v=
alue
> (mW)   |
> +-+-+--------------------------------------+--------+--------------------=
--------+
> | | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MAX``  | u32    | maximum power v=
alue
> (mW)   |
> +-+-+--------------------------------------+--------+--------------------=
--------+

Not sure the ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGE_ENTRY bring anything
interesting.

 +--------------------------------------------+--------+-------------------=
---------+
 | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_RANGES`` | nested | array of power lim=
it ranges|
 +-+------------------------------------------+--------+-------------------=
---------+
 | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MIN``  | u32    | minimum power valu=
e (mW)   |
 +-+------------------------------------------+--------+-------------------=
---------+
 | | ``ETHTOOL_A_C33_PSE_PWR_VAL_LIMIT_MAX``  | u32    | maximum power valu=
e (mW)   |
 +-+------------------------------------------+--------+-------------------=
---------+

> > Huh... i took some more time to investigate it. Looks like there is no
> > simple answer. Some devices seems to write power class on the box. Other
> > client devices write power consumption in watts. IEEE 802.3-2022
> > provides LLDP specification with PowerValue for watts and PowerClass for
> > classes. Different product user interfaces provide class and/or watts.
> > So, let's go with watts then. Please update the name to something like
> > pse_available_power_value or pse_available_power_value_limit and
> > document how it is related to State diagrams in the IEEE spec. =20
>=20
> Here is proposal for documentation:
>=20
>   ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT``  u32  Control PoE PSE availab=
le
> power value limit
>=20
> When set, the optional ``ETHTOOL_A_C33_PSE_AVAIL_PWR_VAL_LIMIT`` attribut=
e is
> used  to control the available power value limit for C33 PSE in milliwatt=
s.
> This attribute corresponds  to the `pse_available_power` variable describ=
ed in
> ``IEEE 802.3-2022`` 33.2.4.4 Variables  and `pse_avail_pwr` in 145.2.5.4
> Variables, which are described in power classes.=20
>=20
> It was decided to use milliwatts for this interface to unify it with other
> power monitoring interfaces, which also use milliwatts, and to align with
> various existing products that document power consumption in watts rather=
 than
> classes. If power limit configuration based on classes is needed, the
> conversion can be done in user space, for example by ethtool.

Thanks for the rephrasing!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


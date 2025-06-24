Return-Path: <netdev+bounces-200835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C019AE7139
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F23F7B205F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37F23909F;
	Tue, 24 Jun 2025 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Wc0nyWpM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FA3074B5;
	Tue, 24 Jun 2025 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799088; cv=none; b=BozRAgXIcHnK9nsRH/RxKoz8gt3VHtAAkivFXcbfIMfpBHIU3cqM6LHov8VLPuJqpUM5QbEZlXxuQHCKy6Xb0+PHv7/2e8UpjnJmIXWj45DTCjHXf/Zcdjqs4RKbHLRq1aDFyMqC1Vi/pXaFraAUzSxbODDY09+tEnSmJjN9RAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799088; c=relaxed/simple;
	bh=6/fK84w0HXJRsQUl54kMy+/q47sIlUEzUHpyiQHauZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8Ej4cDYQRNegMpXo/TxHgOgHIuQNNokbTaBBh7RK9ziWxEkoaIzDtu4p3k0D6ep30wnGnMCTO8HB5JndnCmXFuqsgynlr+3wWdLAg5GkiVZ5exx10LPkGSf18LFHoJaZpMWZgo/1uguY3j5CodwTfaM86xTk076PvmU3qgDTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Wc0nyWpM; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C291F102779C2;
	Tue, 24 Jun 2025 23:04:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750799083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lKbThwTsY1P7KFQMbDvtgsT2FnCwQe8p9lZusqk5xYk=;
	b=Wc0nyWpM9El1+10CWZ74uWfVcdDt0SYtJYSHGHEUpe2tX1dYOoTTvOzgkIaIIzCKKSVq8Y
	lf9S1OrrWOhGJt7x8LQnA3Vp7MopCmav2C8Y0sjQR6g4s0jWq0PPb1X5Y1AMUlI3o/eXke
	LmAZqppYww2wyiM1onpYxD5+3IAAJ/mYrY8S2YfUIqiCvAx3o9aGh56ChulgTPdXlIlT6p
	EZ9+sEvaur5PHc0xbaAbWMGbtqeHLXVWkIsmQrK2NHLU1pf4x4mSEY+fpjBkrvMVnY19rG
	qOzZM+eTOISjJolWT8wL5K1rBYznXr25yP5lesENk5uFVZx7+NF62feHxP+Z/A==
Date: Tue, 24 Jun 2025 23:04:37 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v13 04/11] net: mtip: The L2 switch driver for imx287
Message-ID: <20250624230437.1ede2bcb@wsk>
In-Reply-To: <b31793de-e34f-438c-aa37-d68f3cb42b80@redhat.com>
References: <20250622093756.2895000-1-lukma@denx.de>
	<20250622093756.2895000-5-lukma@denx.de>
	<b31793de-e34f-438c-aa37-d68f3cb42b80@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L9I8TrK5V8LcSsjLhyb23zO";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/L9I8TrK5V8LcSsjLhyb23zO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 6/22/25 11:37 AM, Lukasz Majewski wrote:
> > +static void mtip_aging_timer(struct timer_list *t)
> > +{
> > +	struct switch_enet_private *fep =3D timer_container_of(fep,
> > t,
> > +
> > timer_aging); +
> > +	fep->curr_time =3D mtip_timeincrement(fep->curr_time);
> > +
> > +	mod_timer(&fep->timer_aging,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +} =20
>=20
> It's unclear to me why you decided to maintain this function and timer
> while you could/should have used a macro around jiffies instead.

This is a bit more tricky than just getting value from jiffies.

The current code provides a monotonic, starting from 0 time "base" for
learning and managing entries in internal routing tables for MTIP.

To be more specific - the fep->curr_time is a value incremented after
each ~10ms.

Simple masking of jiffies would not provide such features.

However, I've rewritten relevant portions where GENMASK() could be used
to simplify and make the code more readable.

>=20
> [...]
> > +static int mtip_sw_learning(void *arg)
> > +{
> > +	struct switch_enet_private *fep =3D arg;
> > +
> > +	while (!kthread_should_stop()) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		/* check learning record valid */
> > +		mtip_atable_dynamicms_learn_migration(fep,
> > fep->curr_time,
> > +						      NULL, NULL);
> > +		schedule_timeout(HZ / 100);
> > +	}
> > +
> > +	return 0;
> > +} =20
>=20
> Why are you using a full blown kernel thread here?=20

The MTIP IP block requires the thread for learning. It is a HW based
switching accelerator, but the learning feature must be performed by
SW (by writing values to its registers).

> Here a timer could
> possibly make more sense.

Unfortunately, not - the code (in
mtip_atable_dynamicms_learn_migration() must be called). This function
has another role - it updates internal routing table with timestamps
(provided by timer mentioned above).

> Why are checking the table every 10ms, while
> the learning intervall is 100ms?=20

Yes, this is correct. In 10ms interval the internal routing table is
updated. 100 ms is for learning.

> I guess you could/should align the
> frequency here with such interval.

IMHO learning with 10ms interval would bring a lot of overhead.

Just to mention - the MTIP IP block can generate interrupt for
learning event. However, it has been advised (bu NXP support), that a
thread with 100ms interval shall be used to avoid too many interrupts.

>=20
> Side note: I think you should move the buffer management to a later
> patch: this one is still IMHO too big.

And this is problematic - the most time I've spent for v13 to separate
the code - i.e. I exclude one function, then there are warnings that
other function is unused (and of course WARNINGS in a separate patches
are a legitimate reason to call for another patch set revision).

I've already excluded bridge and mgnt patches. Also moved out some code
from this one.

>=20
> /P
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/L9I8TrK5V8LcSsjLhyb23zO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhbEuUACgkQAR8vZIA0
zr1eeggAn5xkytdRo6m9s2AP7CCf+2DLpUC+BoaHahBz9mSN7/URkVcaHdze2/iF
Js8HdHNNN+MMqzBxg6sKga9RDwGBRv9/kc1LnJz1+BiQGLIGe4sv5DS8ZwdQ2v72
dZ0TDq7rIIMNbGC5jvBXZ+KsuWsjUAMGB4UrnppIMei4fNI4PIZQlWWM6p9bAKtW
f8eqEmwIjW8dfH8fPlv0JwgIw7eGMecjMDbFk1Vcrd9HhLN7MV36CXVIHu4dV9Q/
3SUpxnQpkL6HoPSbROu+MaR/t8W15KN1iSF2fUbBmDvDFHIUu7qsVfXlcLr9SIio
69O3l2adUEiFwSicuYxlrKol0M2bVg==
=bmNZ
-----END PGP SIGNATURE-----

--Sig_/L9I8TrK5V8LcSsjLhyb23zO--


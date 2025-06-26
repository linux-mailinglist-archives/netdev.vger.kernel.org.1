Return-Path: <netdev+bounces-201412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E990AE9643
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 08:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044345A74B2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72746236457;
	Thu, 26 Jun 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JmX9FPpJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DEF22F76C;
	Thu, 26 Jun 2025 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750919292; cv=none; b=dnpCnNp5PW+iZfnrslYG3ePV874tanCciz3NtULPzhKGmQ90vio5KI6kWtkDYXsxP8tX2UxovehcftEXI0YQEq/Co1gG6IInhh8VhilIgARmTJKS59k5kxiyDFvwr5ZZ9OQQNtJEII2b29X9B9SBFEt1k6RIVy05CBN2/yhVMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750919292; c=relaxed/simple;
	bh=N4+EBStamH18yC84cVsW43kn3FrOjyeb1A697dQXwBo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkXriOd1+/DWFFW+DkJrnd6DJtzCvQ/Aju9WKpeHIamFx4JhznmcLGQG7nIFTicSugfKucZId86VldJ0BcpWUFWije+m0MWuxU4uXpuX2aR3Id2Wec9G960OYwku9iGnaXdmYQGxFvr+5MXH+x31xlRUTZdCFBnILHCnHkpFfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JmX9FPpJ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE4E410397285;
	Thu, 26 Jun 2025 08:28:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750919287; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aOywoeS6URIUGte85xuUw45vaQaD6qm7x5c4nv66H4c=;
	b=JmX9FPpJWXh0V6wVKXgTn1rrkOMjdlo3mghi+sU4xfc0lg96Y2zMko9v1SQu7DiAedAPsv
	hHNKZa41SyQks1DP2iTPrQESRjPDxXErLICpQr4fWrp7Gura9dlDBWONhNmGbGpWIBAiz9
	HUqcLh+NzuNLWEs6tT5entH5znqhMtaRyRaAbu/NxfpeZcpYBX1L6XtxlYTDVfxYh99s7X
	gtFkiM3JeUs5kTguNZsKluVbETKbaFOevHmqgj5pqFA+6z/FBnf9gw4AFibJOXh1Ydtjvy
	tpGQ5SxfzKNP2z6Qtv4hvZrjDxj3/cZdgeqWir80bhGiVdd8ZRM91+bfvGTG1w==
Date: Thu, 26 Jun 2025 08:28:00 +0200
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
Message-ID: <20250626082800.5ddca021@wsk>
In-Reply-To: <20159d14-7d6b-4c16-9f00-ae993cc16f90@redhat.com>
References: <20250622093756.2895000-1-lukma@denx.de>
	<20250622093756.2895000-5-lukma@denx.de>
	<b31793de-e34f-438c-aa37-d68f3cb42b80@redhat.com>
	<20250624230437.1ede2bcb@wsk>
	<20159d14-7d6b-4c16-9f00-ae993cc16f90@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fx83fi2=ba.0dUz7yta_/mB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/Fx83fi2=ba.0dUz7yta_/mB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 6/24/25 11:04 PM, Lukasz Majewski wrote:
> >> On 6/22/25 11:37 AM, Lukasz Majewski wrote: =20
> >>> +static void mtip_aging_timer(struct timer_list *t)
> >>> +{
> >>> +	struct switch_enet_private *fep =3D timer_container_of(fep,
> >>> t,
> >>> +
> >>> timer_aging); +
> >>> +	fep->curr_time =3D mtip_timeincrement(fep->curr_time);
> >>> +
> >>> +	mod_timer(&fep->timer_aging,
> >>> +		  jiffies +
> >>> msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +}   =20
> >>
> >> It's unclear to me why you decided to maintain this function and
> >> timer while you could/should have used a macro around jiffies
> >> instead. =20
> >=20
> > This is a bit more tricky than just getting value from jiffies.
> >=20
> > The current code provides a monotonic, starting from 0 time "base"
> > for learning and managing entries in internal routing tables for
> > MTIP.
> >=20
> > To be more specific - the fep->curr_time is a value incremented
> > after each ~10ms.
> >=20
> > Simple masking of jiffies would not provide such features. =20
>=20
> I guess you can get the same effect storing computing the difference
> from an initial jiffies value and using jiffies_to_msecs(<delta>)/10.

With some coding assuring only 10 bit width of the resulting clock
(based on jiffies) I can have a monotonic clock which will not start
from 0.

>=20
> >> [...] =20
> >>> +static int mtip_sw_learning(void *arg)
> >>> +{
> >>> +	struct switch_enet_private *fep =3D arg;
> >>> +
> >>> +	while (!kthread_should_stop()) {
> >>> +		set_current_state(TASK_INTERRUPTIBLE);
> >>> +		/* check learning record valid */
> >>> +		mtip_atable_dynamicms_learn_migration(fep,
> >>> fep->curr_time,
> >>> +						      NULL,
> >>> NULL);
> >>> +		schedule_timeout(HZ / 100);
> >>> +	}
> >>> +
> >>> +	return 0;
> >>> +}   =20
> >>
> >> Why are you using a full blown kernel thread here?  =20
> >=20
> > The MTIP IP block requires the thread for learning. It is a HW based
> > switching accelerator, but the learning feature must be performed by
> > SW (by writing values to its registers).
> >  =20
> >> Here a timer could
> >> possibly make more sense. =20
> >=20
> > Unfortunately, not - the code (in
> > mtip_atable_dynamicms_learn_migration() must be called). This
> > function has another role - it updates internal routing table with
> > timestamps (provided by timer mentioned above). =20
>=20
> Why a periodic timer can't call such function?

Yes, the kthread can be replaced with timer with 100ms period.

Just to explain - the mtip_atable_dynamicms_learn_migration(), which
requires monotonic value incremented once per 10ms, is called at two
places:

1. mtip_switch_rx() -> the dynamic table is examined if required (i.e.
new frame arrives). In this place the counter requires 10ms resolution
(can be extracted from jiffies).

2. The mtip_sw_learning() - which now is run from kthread, but it can
be replaced with timer (100ms resolution).

>=20
> >  =20
> >> Why are checking the table every 10ms, while
> >> the learning intervall is 100ms?  =20
> >=20
> > Yes, this is correct. In 10ms interval the internal routing table is
> > updated. 100 ms is for learning.
> >  =20
> >> I guess you could/should align the
> >> frequency here with such interval. =20
> >=20
> > IMHO learning with 10ms interval would bring a lot of overhead.
> >=20
> > Just to mention - the MTIP IP block can generate interrupt for
> > learning event. However, it has been advised (bu NXP support), that
> > a thread with 100ms interval shall be used to avoid too many
> > interrupts. =20
>=20
> FTR, my suggestion is to increase the
> mtip_atable_dynamicms_learn_migration's call period to 100ms

As mentioned above - it is called in two places. One is in kthread
started at 100ms period, another one is asynchronous when frame arrives.

>=20
> >> Side note: I think you should move the buffer management to a later
> >> patch: this one is still IMHO too big. =20
> >=20
> > And this is problematic - the most time I've spent for v13 to
> > separate the code - i.e. I exclude one function, then there are
> > warnings that other function is unused (and of course WARNINGS in a
> > separate patches are a legitimate reason to call for another patch
> > set revision). =20
>=20
> A trick to break that kind of dependencies chain is to leave a
> function implementation empty.
>=20
> On the same topic, you could have left mtip_rx_napi() implementation
> empty up to patch 6 or you could have introduced napi initialization
> and cleanup only after such patch.
>=20
> In a similar way, you could introduce buffer managements in a later
> patch and add the relevant calls afterwards.

I get your point.

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Fx83fi2=ba.0dUz7yta_/mB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhc6HAACgkQAR8vZIA0
zr0Q6ggAhP76zLQCcS7yPIT4oJTgBppnruWfx1DIYSqVAPc72wii+bwG2zw3wD9P
zWluiinx+cLcfhysEy4jYVBnrJx0lZRwaISWGByo3/DHcjHxKxlYP6dNO0YdcuWS
JuE3k8RXNRImfH74zo7HpbXjClU4htBIwJgKH0YsztnqpjPA6Vjlj6MEQdkAefXv
29Y9mXxloNMt6kmRey8a6i4hoqKUtnQKAK9BjZHYMHecCPhcyDwhF/dIP26yJpS7
mg2kO096B9sosW3w3AN0GC/poDi2OohgoYq4Yf5DmfVosHTtBXnsTGcNql33Uyct
qj4aoXLChq3ztyZMeNecCr3QGG8MQQ==
=Raoa
-----END PGP SIGNATURE-----

--Sig_/Fx83fi2=ba.0dUz7yta_/mB--


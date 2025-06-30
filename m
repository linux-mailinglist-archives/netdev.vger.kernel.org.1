Return-Path: <netdev+bounces-202392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F87AEDB2A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C35189A64F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6C25DD07;
	Mon, 30 Jun 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AQKIf/Ud"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689BD242D83;
	Mon, 30 Jun 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283293; cv=none; b=NJiE6OxQUi49rfplt0uUWtx/aihZRc2HD/GK9F01gH0cWS2xfup8s6+SJurEfHebIRMiPbuYasGHSnEgSzHNcLlNRjEXx0O2lgzFccrV7TjiEVQxNMEXVSXx/RfVnepkRj2FwrJj4qOhjzJ3v3r+WyNbaIu+DhjBwdXpAJ49DHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283293; c=relaxed/simple;
	bh=iw/9MNGT+/hEj/TbjYC3Nc/+P3EMi/fr0CrtpPGl+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLFvhJi7txdGadCneGhm/W8BHiUddrLcfB9+jepn8qwYT0Vc+7HVhHFzMyrYZYmR7E+MFA0NZMqVy/m8JjRXbBiXUsj2IEdKHqi8EY6feim4cbTmdmVp9hVYE3tfW0DpH/3ABflPszEWS/cd+2FVhzb7jNNgfls94bg2G0yYs4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AQKIf/Ud; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8878A10380104;
	Mon, 30 Jun 2025 13:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751283283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=obn1fFptpDWsfOTGxxja0aYNB+v0Pa/lgexMoMKfewU=;
	b=AQKIf/Udw+b5eHV6+NEZhbR5iX7W6bnm9XB4i+kaxnIFF7ccKGLFWIWC5uMO3mJ8qit8Ip
	syY2HMQgXz/9DhT8zh6n3gqlEnCwMxdalNKZL19Gt5E11nFXihxyA9tVQ1ln9KP7QE6Aid
	swuQKBUviYdIb5tD18Ii2WK8aE1RDLUjJz6jKzA4KZNNfcKsqkRf39KQKht9qDteCaiYkk
	1lMb68+r+Yd8p9pXy44vqdcBKerwNy6x7dyMARVmvWFTWu921/6iGCr9nFM/LXTunUVRKp
	jF18ykoSo/sMQUVo7s8rX8Azv5fFl096GpeWJulsTb5gJ1QmdssrG9NCTqk8vw==
Date: Mon, 30 Jun 2025 13:34:36 +0200
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
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, =?UTF-8?B?xYF1a2Fz?=
 =?UTF-8?B?eg==?= Majewski <lukasz.majewski@mailbox.org>
Subject: Re: [net-next v13 06/11] net: mtip: Add mtip_switch_{rx|tx}
 functions to the L2 switch driver
Message-ID: <20250630133436.71238a65@wsk>
In-Reply-To: <0de412ee-c9ce-463b-92ef-58a33fd132d1@redhat.com>
References: <20250622093756.2895000-1-lukma@denx.de>
	<20250622093756.2895000-7-lukma@denx.de>
	<0de412ee-c9ce-463b-92ef-58a33fd132d1@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ft7tAwYwUt/T1YMHVHAewjX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/ft7tAwYwUt/T1YMHVHAewjX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> >  static void mtip_switch_tx(struct net_device *dev)
> >  {
> > +	struct mtip_ndev_priv *priv =3D netdev_priv(dev);
> > +	struct switch_enet_private *fep =3D priv->fep;
> > +	unsigned short status;
> > +	struct sk_buff *skb;
> > +	unsigned long flags;
> > +	struct cbd_t *bdp;
> > +
> > +	spin_lock_irqsave(&fep->hw_lock, flags); =20
>=20
> This is called from napi (bh) context, and every other caller
> is/should be BH, too. You should use
>=20
> 	spin_lock_bh()

I've double check the spin locking in the driver - I've also consult
the fec_main.c.

It looks like the mtip_switch_rx() and fec_enet_rx() are not using
explicit locks and rely on NAPI locking.

On the other hand - the fec_enet_tx (and corresponding MTIP variant)
use spin_lock(), not the _bh() variant.

>=20
> Also please test your patches with CONFIG_LOCKDEP and
> CONFIG_DEBUG_SPINLOCK enabled, thet will help finding this king of
> issues.

This was enabled by default. By changing all locks to _bh() there were
deadlocks observed.

On the MTIP driver (due to this HW IP block) there are some locks which
must disable interrupts:

1. One is when mtip_adjust_link() is called - as it is the same for
both switch ports. Moreover, at some use cases it is required that the
switch IP block is reset.

2. The mtip_atable_dynamicms_learn_migration() - it changes the content
of dynamic switching table. IRQ from switch shall not be possible at
this time as it can be called from mtip_switch_rx() (from NAPI) and
from timer/kthread (at specified period).


To sum up:

I'm going to prepare the v14 with changes around the timer / kthread
running mtip_atable_dynamicms_learn_migration() and use time stamps
extracted from jiffies.

Locks will be optimized and following paradigm used with fec_main.c
driver.

>=20
> /P


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ft7tAwYwUt/T1YMHVHAewjX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhidkwACgkQAR8vZIA0
zr1gIwgA5RFaOOf/zToxgLklld0AgiA7amktt6Vm7D+yrAK4VbOKEnAMTahAU7iE
Z/aSDSy3TmQ6p+k7SOMCK/W7UyAGi4nIffvLFo5N4PGTYmBqVhq+qlpjSm7bnFAU
mUKTz6s/N3KoneKHrKRf6ogC4PubkGH4RqQ4gVbr0YZgwd4XsA6uEFVoPYeUQ25U
EVRkOV9W2ouDS/MpoHsQoFN35ottbyK0i2kVUqywK/QGPuQtLXOEfswnnqQ6B692
nRkf9dcbOPJqCiabDst66cODEgmDJ5brs7f6SZ7nPIB1ASnGmjDaVgIzuT9CuA4G
LfMIlP/XANgIKp/dLSJtVT7sdEdmDA==
=eCtd
-----END PGP SIGNATURE-----

--Sig_/ft7tAwYwUt/T1YMHVHAewjX--


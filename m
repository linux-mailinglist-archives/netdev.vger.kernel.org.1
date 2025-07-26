Return-Path: <netdev+bounces-210325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B72ABB12C29
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 22:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5E57AFE68
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 20:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB04231842;
	Sat, 26 Jul 2025 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WAUpxAve"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935A21885D;
	Sat, 26 Jul 2025 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753560816; cv=none; b=IcWW1zTKkAV3AwHMp+Wvm5PudlwksBXTGwISJirqsSIYXBAVEoeUjmIq7BLr4NXLYbrezd3Xn5faTGU8vSXPlJ0Y/eqq1TSzzHkjZmPhruGfEsEaR/tn4+ZYiCpUukHwmYWvhaFbjgD959G/j5vI47D8Wj42JTktWqiXEov3uik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753560816; c=relaxed/simple;
	bh=eXFBzQMIOgJACkkiirYjWqbaUNq5h419yPTnWlIryIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igi+sNNi+mIV1Hcb81BAMCmn63dLvm4g3CuCb+4G3Q7LRfRzvxGGDn1u/PsHzioaZl5JBMmwVrXQQVQiAN3l6aZs5hlVQEmCn3ZnZW0Vzd4fV2lpuLRxEL0AlK7NhdJ73bt1w1EKECzG6nzrljYXvWjYq7pobyy215MBzucVyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WAUpxAve; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA6010391E80;
	Sat, 26 Jul 2025 22:13:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753560811; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TWGAw9HUc5B0uTkDq7v2wXCo5i2oNA3eTY8zlOASEHM=;
	b=WAUpxAveeRNrvct46TWQ/f5v6/UOhl/3j5bocPV7TalPE7I2Nf7mF1teQT53k6EZ3haj/H
	4Ic4Kv6vhrx3W9oeFSHeDXnuVeaoHVg9bSGO4H63FvtRNM8N33xCIVchxBDi2n4BJvIr7X
	HL+fE0L2uKoRhLm7NmLugowT8OM2yfwgLybhfhGxjrr+sIOMg9H7jZOFw9h+vb2JRAQzML
	5GyaJdICf/g1xecNRK3jgIQ++DuL6KOl6uxa+xU/5gGEpdSuq3Ga78Aeqf3XZ6UnzUS3Sf
	U24HFTBtB2dO54LfmaZDKbQmJNseF43LNIzJDdt7I1sGA6vwzkxQWIQKsRbInQ==
Date: Sat, 26 Jul 2025 22:13:23 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v16 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250726221323.0754f3cd@wsk>
In-Reply-To: <20250725151829.40bd5f4e@kernel.org>
References: <20250724223318.3068984-1-lukma@denx.de>
	<20250724223318.3068984-5-lukma@denx.de>
	<20250725151829.40bd5f4e@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QBKx1stqUcQHszVRzo3MNYj";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/QBKx1stqUcQHszVRzo3MNYj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Fri, 25 Jul 2025 00:33:10 +0200 Lukasz Majewski wrote:
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		fep->ndev[i] =3D alloc_netdev(sizeof(struct
> > mtip_ndev_priv),
> > +					    fep->ndev_name[i],
> > NET_NAME_USER,
> > +					    ether_setup);
> > +		if (!fep->ndev[i]) {
> > +			ret =3D -ENOMEM;
> > +			break;
> > +		}
> > +
> > +		fep->ndev[i]->ethtool_ops =3D &mtip_ethtool_ops;
> > +		fep->ndev[i]->netdev_ops =3D &mtip_netdev_ops;
> > +		SET_NETDEV_DEV(fep->ndev[i], &pdev->dev);
> > +
> > +		priv =3D netdev_priv(fep->ndev[i]);
> > +		priv->dev =3D fep->ndev[i];
> > +		priv->fep =3D fep;
> > +		priv->portnum =3D i + 1;
> > +		fep->ndev[i]->irq =3D fep->irq;
> > +
> > +		mtip_setup_mac(fep->ndev[i]);
> > +
> > +		ret =3D register_netdev(fep->ndev[i]);
> > +		if (ret) {
> > +			dev_err(&fep->ndev[i]->dev,
> > +				"%s: ndev %s register err: %d\n",
> > __func__,
> > +				fep->ndev[i]->name, ret);
> > +			break;
> > +		} =20
>=20
> Error handling in case of register_netdev() still buggy, AFAICT.

I've added the code to set fep->ndev[i] =3D NULL to mtip_ndev_cleanup().
IMHO this is the correct place to add it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/QBKx1stqUcQHszVRzo3MNYj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmiFNuMACgkQAR8vZIA0
zr1nZAgAuEPG2jcxe5x4z5+TI7n7rwPtz3Cgbueuh1wjlJ58IWVvM/Q6XbLQ0Av9
1Fgmn5jR6AY8Zhh/9/rW6jb12GTvFA/fmOgqykhvRFhUbaMfWw6mZqROiGBQZ6lX
Esg9sYHVGwMr3W2efNc3FCw4jfHJMtW7D6wPCFkCXjnppo6lD88tstj4saczatDO
asEz2RqDh8HQFbi542j/iUcCNYVm2K7WNRq0RhZf43a789W4I3ARMDFrxwioK5uJ
8a/Cu/P5ITnAnAIgjgdXBouLIMeSf9iAQy/W9Xu6bGJSk6Ng4i8u9C+TTwUlzJdw
VPWafe7Gb1LENnDxHz07QYeWtVB9AQ==
=27wW
-----END PGP SIGNATURE-----

--Sig_/QBKx1stqUcQHszVRzo3MNYj--


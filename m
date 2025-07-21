Return-Path: <netdev+bounces-208697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8EAB0CC3A
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 23:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC014E75E2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7C23A9A0;
	Mon, 21 Jul 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LDA9mQZe"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6E202F8B;
	Mon, 21 Jul 2025 21:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753131983; cv=none; b=Jt2ft9MA2/ALQ4RFCD5pu5E8Tt4VLUjnY9cBpcRW++5RfasFQ/UFx3ysWkTQnhgOeZp7+4LbbLR6VQFGWZyzjrV0rQ1TdXx3TgeqIVJwpACppxa8l5XPXLLP9uETFcseoPSP1MrZopN/KVzsQWc7Ai6pLtb+XeDr/jvc7N/sq+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753131983; c=relaxed/simple;
	bh=zjLicVkc0C/6IAdAKsOjFSGUc3j3ugV0Pp2+JYkGJ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ae8I63DlPRLssOceqL4GRdFvN/+VumBcphkdPefyGoomS008jzsSo4vAm7zK378nv8oLAj9kVBJV5mfDswrBiSl6f9zJQLF6tfY9UJnzyiFVXrIr+0a+O6HS5nX+hVULZTm6wjMf8oyu2kV/b4RVspuyXElwPzFDWkpqINd4K8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LDA9mQZe; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5E5D1027235A;
	Mon, 21 Jul 2025 23:06:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753131977; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=thKRdw3kXRGji+6JCd7tx86+QfpE7R4ymI26oelJ9l0=;
	b=LDA9mQZeGJ84HzhFTkWldHixuCTUA/2gE47EdutdCG+Queg5IVgKVkacRhbSBE9pi4toBn
	YJd+Q+hW3wat8/0owk0Y66IS3WJaNw5Rwyng+Is6zLxORIdFz5YH8OaN+ULShn7wwQn7+L
	dWPT/cbpL76ZkNS3FINCOYXeQQaI3Szr4cnkhOCpmPDoQtFxWdICD5Ru8Ea4HvdjTig3Q2
	aSoHgioT/8mOJp0+c+Ihr5af1VabgqEYZDZKxuUEZY8/y/Jv90wx4vJG+6+xwE5Co0uTvZ
	3YFyhX1rxpWhfqXtj4o1f0b7WkhYqwQlZPq4y0EcKaQHGRBDGW1inBrF/1GXPA==
Date: Mon, 21 Jul 2025 23:06:11 +0200
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
Subject: Re: [net-next v15 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250721230611.45fb74df@wsk>
In-Reply-To: <20250718181028.00cda754@kernel.org>
References: <20250716214731.3384273-1-lukma@denx.de>
	<20250716214731.3384273-5-lukma@denx.de>
	<20250718181028.00cda754@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yEbJNgP2XSHi9_nucQvhE7B";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/yEbJNgP2XSHi9_nucQvhE7B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

> On Wed, 16 Jul 2025 23:47:23 +0200 Lukasz Majewski wrote:
> > +static void mtip_ndev_cleanup(struct switch_enet_private *fep)
> > +{
> > +	struct mtip_ndev_priv *priv;
> > +	int i;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		if (fep->ndev[i]) { =20
>=20
> this just checks if netdev is NULL
>=20
> > +			priv =3D netdev_priv(fep->ndev[i]);
> > +			cancel_work_sync(&priv->tx_timeout_work);
> > +
> > +			unregister_netdev(fep->ndev[i]); =20
>=20
> and if not unregisters
>=20
> > +			free_netdev(fep->ndev[i]);
> > +		}
> > +	}
> > +}
> > +
> > +static int mtip_ndev_init(struct switch_enet_private *fep,
> > +			  struct platform_device *pdev)
> > +{
> > +	struct mtip_ndev_priv *priv;
> > +	int i, ret =3D 0;
> > +
> > +	for (i =3D 0; i < SWITCH_EPORT_NUMBER; i++) {
> > +		fep->ndev[i] =3D alloc_netdev(sizeof(struct
> > mtip_ndev_priv), =20
>=20
> but we assign the pointer immediatelly
>=20
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
> > +		ret =3D register_netdev(fep->ndev[i]); =20
>=20
> and don't clear it when register fails
>=20
> > +		if (ret) {
> > +			dev_err(&fep->ndev[i]->dev,
> > +				"%s: ndev %s register err: %d\n",
> > __func__,
> > +				fep->ndev[i]->name, ret);
> > +			break;
> > +		}
> > +
> > +		dev_dbg(&fep->ndev[i]->dev, "%s: MTIP eth L2
> > switch %pM\n",
> > +			fep->ndev[i]->name,
> > fep->ndev[i]->dev_addr);
> > +	}
> > +
> > +	if (ret)
> > +		mtip_ndev_cleanup(fep); =20
>=20
> You're probably better off handling the unwind on error separately
> from the full cleanup function, but I guess that's subjective.

Yes, you are right - I shall add:
fep->ndev[i] =3D NULL;

just after free_ndev(fep->ndev[i]); in the
mtip_ndev_cleanup() function.

>=20
> > +	return ret;
> > +} =20
>=20
> > +static int mtip_sw_probe(struct platform_device *pdev)
> > +{ =20
>=20
> > +	ret =3D mtip_ndev_init(fep, pdev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Failed to create virtual
> > ndev (%d)\n",
> > +			__func__, ret);
> > +		goto ndev_init_err;
> > +	}
> > +
> > +	ret =3D mtip_switch_dma_init(fep); =20
>=20
> > +	ret =3D mtip_mii_init(fep, pdev); =20
>=20
> Seems like we're registering the netdevs before fully initializing=20
> the HW? Is it safe if user (or worse, some other kernel subsystem)=20
> tries to open the netdevs before the driver finished the init?
> =20

This needs to be reordered - the ndev registration shall be the last
step.

Thanks for pointing this out.

>=20
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "%s: Cannot init phy bus
> > (%d)!\n", __func__,
> > +			ret);
> > +		goto mii_init_err;
> > +	}
> > +	/* setup timer for learning aging function */
> > +	timer_setup(&fep->timer_mgnt, mtip_mgnt_timer, 0);
> > +	mod_timer(&fep->timer_mgnt,
> > +		  jiffies +
> > msecs_to_jiffies(LEARNING_AGING_INTERVAL)); +
> > +	return 0;
> > +
> > + mii_init_err:
> > + dma_init_err:
> > +	mtip_ndev_cleanup(fep); =20
>=20
> Please name the labels after the action they jump to, not the location
> where they jump from.

Ok.

>=20
> > + ndev_init_err:
> > +
> > +	return ret; =20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/yEbJNgP2XSHi9_nucQvhE7B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmh+q8MACgkQAR8vZIA0
zr0HdggAwco5wjKk7FZTResfk+vt1Mqevf2S3izXGuVnFYMYDXkwS5yUJyI858DL
fafdGgSK3ohngKrEv4OIz35sfT8KxYWCtxMo0hNP8YyJsknOAQSeAvrofp75T/Ej
R9bgz/dJKUls586SPXfLjy37a567H06CJHVk9kGuxDigPKbmv9PgTyS31ng+n9jq
0Ugb4u4zU4/I7Ul4BjnwWC6tckzbtawepEyHEO/pcaVdpI+W7yoOetDfCShbYnL/
VPwticChtJfuOgKiXD9HVcP0QVL0PkCXlKluklqKnHeSPHC8J5W7CnAtOZhi3IHH
+S9Q+H1D5mGWD+M2PeMRZYcn8aZ5sA==
=1O0w
-----END PGP SIGNATURE-----

--Sig_/yEbJNgP2XSHi9_nucQvhE7B--


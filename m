Return-Path: <netdev+bounces-149921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15C9E822D
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 22:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0602819CD
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1141448DF;
	Sat,  7 Dec 2024 21:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC4179A7
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733605657; cv=none; b=Kz5oXuNMjAEtcvegg0UwkhEOG/KzdjqrvzxXeiXSupULSAqyOYGxdlJy5jrLaS1mnomDMhY+LGbBaOTAKyi/RSAYHx/ajWO3ao6aYt/wWHE83Fy3BPzDzw4MtlZDZLMgxM6Dtwqt7xKqvLHL/obxbNclhD/94gMd1HJh2neGqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733605657; c=relaxed/simple;
	bh=yloHb07/tVztyegzbK7Gc91K7mFA2G42AZ2DPMQlADg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+tYw6m96P4hwfaE3R4p/uVBv5I8pv3Tbx4XaeAvl+eAfleA6JStC+kzo6473uMGUfg8Y/zUQqUjbfjRT/Bp5Z7D+u2v0OKr1hRvyQG58VQdl8V/GkWZohbaBLywGJjJLMriWTVEX0btu4kwfS5VynpqFDxU3j82iRDt7pPyiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tK21M-000jUx-0d;
	Sat, 07 Dec 2024 22:07:24 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tK21L-00000000v2l-2OPi;
	Sat, 07 Dec 2024 22:07:23 +0100
Date: Sat, 7 Dec 2024 22:07:23 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Christian Eggers <ceggers@arri.de>
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gmbj3uzmevpz6syt"
Content-Disposition: inline
In-Reply-To: <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>


--gmbj3uzmevpz6syt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Andrew Lunn schrieb am Sa 07. Dez, 21:47 (+0100):
> On Sat, Dec 07, 2024 at 08:53:38AM +0100, J=C3=B6rg Sommer wrote:
> > It tries to initialize the switch before the ethernet of the SoC is rea=
dy.
> >=20
> > Before this commit the kernel returned EPROBE_DEFER instead of EINVAL (=
or
> > ENODEV) as a quick
>=20
> This is often true for DSA switches, that the first probe fails with
> EPROBE_DEFER, because the conduit ethernet is not ready.
>=20
> What i don't understand from your description is why:
>=20
> > +       /* setup spi */
> > +       spi->mode =3D SPI_MODE_3;
> > +       ret =3D spi_setup(spi);
> > +       if (ret)
> > +               return ret;
> > +
>=20
> is causing this issue. Is spi_setup() failing?

I've added another dev_err() after the spi_setup:

[    1.680516] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_setu=
p=3D0
[    1.819194] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-22
[    1.825611] spi_davinci 1f0e000.spi: Controller at 0x(ptrval)
=E2=80=A6
[    1.949668] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_setu=
p=3D0
[    2.090136] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-517
[    2.097438] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_setu=
p=3D0
[    2.230043] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-517
[    2.241625] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    2.255218] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_setu=
p=3D0
=E2=80=A6
[    3.121263] libphy: dsa slave smi: probed
[    3.127206] ksz8795-switch spi0.1 lan-x1 (uninitialized): PHY [dsa-0.0:0=
0] driver [Generic PHY] (irq=3DPOLL)
[    3.142775] ksz8795-switch spi0.1 lan-x2 (uninitialized): PHY [dsa-0.0:0=
1] driver [Generic PHY] (irq=3DPOLL)



--=20
Treffen sich zwei Funktionen.
Sagt die eine: =E2=80=9EVerschwinde oder ich differenzier' dich!=E2=80=9C
Erwidert die andere: =E2=80=9E=C3=84tsch, ich bin exponentiell!=E2=80=9C

--gmbj3uzmevpz6syt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1S5CgAKCRB9LJoj0a6j
dZd9AP4vcEOyEi5oAm8/1EJqW7g0StN5gzrE+u9V2SpWFga7fgD/Y+b85X/wAVum
AaX5hDah+ZKgGxY5KSF4pzkjln2nvJs=
=qG2R
-----END PGP SIGNATURE-----

--gmbj3uzmevpz6syt--


Return-Path: <netdev+bounces-149990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B169E86AC
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 17:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1EE52812D7
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2566A1714C8;
	Sun,  8 Dec 2024 16:45:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC2170A15
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733676300; cv=none; b=EZ1kjo67tOgFSSCahxnUkrhbXDfrvu/QZOBk+ZoQx3DKLJ582te94LuIRAZvlHIihy6yMSSnM04I7g5nVZJImDdMW1ajxpEB17FV4oT4SzTJq+YDApQ2FgTh35iWTiXHu1zilhyS0JPXojkU+b+TO/IDnk/8VA//ZOsM05vfLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733676300; c=relaxed/simple;
	bh=jfmjm3q+zevgUeK5fiLyJHXsMDYr2AHDgEVT6cN9f14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqEt/rc+23sR7uQtDDtl9a1UOC+1xU6tbmwtdSiOzCXLVS6HDB7kVeRSjONOoE4N9bfP2IVHBc8u1svsnBwZA6opcd5WswEO6odWUhKJe3uJRpl8xvgNtStF+jWF8/tB0EabFCXQnV/Yf08sWAglU76jNXvKWb0b7FIuzKDFpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tKKOo-000vlE-0H;
	Sun, 08 Dec 2024 17:44:50 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tKKOn-000000016DP-1uqb;
	Sun, 08 Dec 2024 17:44:49 +0100
Date: Sun, 8 Dec 2024 17:44:49 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
OpenPGP: id=7D2C9A23D1AEA375; url=https://jo-so.de/pgp-key.txt;
 preference=signencrypt
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
 <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
 <7080052.9J7NaK4W3v@n9w6sw14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7agv62ph3h65dp3d"
Content-Disposition: inline
In-Reply-To: <7080052.9J7NaK4W3v@n9w6sw14>


--7agv62ph3h65dp3d
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Hi Christian,

Christian Eggers schrieb am Sa 07. Dez, 23:44 (+0100):
> On Saturday, 7 December 2024, 21:47:31 CET, Andrew Lunn wrote:
> > What i don't understand from your description is why:
> >=20
> > > +       /* setup spi */
> > > +       spi->mode =3D SPI_MODE_3;
> > > +       ret =3D spi_setup(spi);
> > > +       if (ret)
> > > +               return ret;
> > > +
> >=20
> > is causing this issue. Is spi_setup() failing?
>=20
> On Saturday, 7 December 2024, 22:07:23 CET, J=C3=B6rg Sommer wrote:
>=20
> > I've added another dev_err() after the spi_setup:
> >=20
> > [    1.680516] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of spi_=
setup=3D0
> > [    1.819194] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-22#
>=20
> It doesn't look so.
>=20
> @J=C3=B6rg. You didn't explicitly mention which kernel version you are tr=
ying to run.

I've checked out 8c4599f49841dd663402ec52325dc2233add1d32. But I also have
to apply the commits 1aa4ee0ec7fe929bd46ae20d9457f0a242115643
ba6e5af621ab2fb4cd4acb37d4914c832991689c
f19d8dfad67b641af274a9a317a12f31c430e254, because 5.10 doesn't work without
them, too, and they where added somewhere in 5.10.223.

=46rom 5.10 with these additionally changes I started and found 8c4599.


> Maybe the -EINVAL comes from line 414:
>=20
>     if (dev->dev_ops->detect(dev))
>         return -EINVAL;
>=20
> But this is only a guess.

You're right.

[    1.678236] ksz8795-switch spi0.1: ksz8795_spi_probe:53: spi->mode=3D0 b=
efore SPI_MODE_3=3D3
[    1.686754] ksz8795-switch spi0.1: ksz8795_spi_probe:56: spi_setup()=3D0
[    1.817017] ksz8795-switch spi0.1: ksz8795_switch_detect:1151: id1=3D0 <=
> FAMILY_ID=3D135, id2=3D0 <> CHIP_ID_94=3D96 && CHIP_ID_95=3D144
[    1.828812] ksz8795-switch spi0.1: ksz_switch_register:415: dev->dev_ops=
->detect()c037e47c=3D-19
[    1.837609] ksz8795-switch spi0.1: ksz8795_spi_probe:62: ksz8795_switch_=
register()=3D-22
[    1.845909] spi_davinci 1f0e000.spi: Controller at 0x(ptrval)
=E2=80=A6
[    1.969734] ksz8795-switch spi0.1: ksz8795_spi_probe:53: spi->mode=3D3 b=
efore SPI_MODE_3=3D3
[    1.978309] ksz8795-switch spi0.1: ksz8795_spi_probe:56: spi_setup()=3D0
[    2.117906] ksz8795-switch spi0.1: ksz8795_spi_probe:62: ksz8795_switch_=
register()=3D-517
[    2.127235] ksz8795-switch spi0.1: ksz8795_spi_probe:53: spi->mode=3D3 b=
efore SPI_MODE_3=3D3
[    2.135427] ksz8795-switch spi0.1: ksz8795_spi_probe:56: spi_setup()=3D0
[    2.267825] ksz8795-switch spi0.1: ksz8795_spi_probe:62: ksz8795_switch_=
register()=3D-517
[    2.281336] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    2.294928] ksz8795-switch spi0.1: ksz8795_spi_probe:53: spi->mode=3D3 b=
efore SPI_MODE_3=3D3
[    2.305365] ksz8795-switch spi0.1: ksz8795_spi_probe:56: spi_setup()=3D0
[    2.954286] random: crng init done
[    3.174408] libphy: dsa slave smi: probed
[    3.180666] ksz8795-switch spi0.1 lan-x1 (uninitialized): PHY [dsa-0.0:0=
0] driver [Generic PHY] (irq=3DPOLL)

This is my setting:

git reset --hard 8c4599f49841dd663402ec52325dc2233add1d32
git cherry-pick -n \
  1aa4ee0ec7fe929bd46ae20d9457f0a242115643 \
  f365d53c868725c472d515fa1ce4f57d0eaff5ae \
  ba6e5af621ab2fb4cd4acb37d4914c832991689c \
  f19d8dfad67b641af274a9a317a12f31c430e254
git apply -p0 --ignore-whitespace <<__EOF
diff --git drivers/net/dsa/microchip/ksz8795.c drivers/net/dsa/microchip/ks=
z8795.c
index 1e101ab56cea..4c9f27a061c1 100644
--- drivers/net/dsa/microchip/ksz8795.c
+++ drivers/net/dsa/microchip/ksz8795.c
@@ -1147,8 +1147,11 @@ static int ksz8795_switch_detect(struct ksz_device *=
dev)
        id1 =3D id16 >> 8;
        id2 =3D id16 & SW_CHIP_ID_M;
        if (id1 !=3D FAMILY_ID ||
-           (id2 !=3D CHIP_ID_94 && id2 !=3D CHIP_ID_95))
+           (id2 !=3D CHIP_ID_94 && id2 !=3D CHIP_ID_95)) {
+dev_err(dev->dev, "%s:%d: id1=3D%d <> FAMILY_ID=3D%d, id2=3D%d <> CHIP_ID_=
94=3D%d && CHIP_ID_95=3D%d \n",
+        __func__, __LINE__, id1, FAMILY_ID, id2, CHIP_ID_94, CHIP_ID_95);
                return -ENODEV;
+        }

        dev->mib_port_cnt =3D TOTAL_PORT_NUM;
        dev->phy_port_cnt =3D SWITCH_PORT_NUM;
diff --git drivers/net/dsa/microchip/ksz8795_spi.c drivers/net/dsa/microchi=
p/ksz8795_spi.c
index 5dab5d36c675..cb812538ec5b 100644
--- drivers/net/dsa/microchip/ksz8795_spi.c
+++ drivers/net/dsa/microchip/ksz8795_spi.c
@@ -50,13 +50,19 @@ static int ksz8795_spi_probe(struct spi_device *spi)
                dev->pdata =3D spi->dev.platform_data;
 =20
        /* setup spi */
+        dev_err(&spi->dev, "%s:%d: spi->mode=3D%d before SPI_MODE_3=3D%d\n=
", __func__, __LINE__, spi->mode, SPI_MODE_3);
        spi->mode =3D SPI_MODE_3;
        ret =3D spi_setup(spi);
+        dev_err(&spi->dev, "%s:%d: spi_setup()=3D%d\n", __func__, __LINE__=
, ret);
        if (ret)
                return ret;
 =20
        ret =3D ksz8795_switch_register(dev);
 =20
+        dev_err(&spi->dev, "%s:%d: ksz8795_switch_register()=3D%d\n", __fu=
nc__, __LINE__, ret);
+        if (ret =3D=3D -EINVAL || ret =3D=3D -ENODEV)
+            ret =3D -EPROBE_DEFER;
+
        /* Main DSA driver may not be started yet. */
        if (ret)
                return ret;
diff --git drivers/net/dsa/microchip/ksz_common.c drivers/net/dsa/microchip=
/ksz_common.c
index 32836450d62c..44b66951c633 100644
--- drivers/net/dsa/microchip/ksz_common.c
+++ drivers/net/dsa/microchip/ksz_common.c
@@ -410,8 +410,11 @@ int ksz_switch_register(struct ksz_device *dev,
 =20
        dev->dev_ops =3D ops;
 =20
-       if (dev->dev_ops->detect(dev))
+ret =3D dev->dev_ops->detect(dev);
+       if (ret) {
+dev_err(dev->dev, "%s:%d: dev->dev_ops->detect()%lx=3D%d\n", __func__, __L=
INE__, dev->dev_ops->detect, ret);
                return -EINVAL;
+        }
 =20
        ret =3D dev->dev_ops->init(dev);
        if (ret)

> > Andrew Lunn schrieb am Sa 07. Dez, 21:47 (+0100):
> > >=20
> > > What i don't understand from your description is why:
> > >=20
> > > > +       /* setup spi */
> > > > +       spi->mode =3D SPI_MODE_3;
> > > > +       ret =3D spi_setup(spi);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > >=20
> > > is causing this issue. Is spi_setup() failing?
>=20
> Maybe that the configured SPI mode does somehow not work for J=C3=B6rg's =
setup.
> Perhaps SPI mode 3 on his controller is not the same as for my one (NXP i=
=2EMX6).
> This could then cause a mismatch when reading the chip id in ksz8795_swit=
ch_detect().

Or am I missing something in my devicetree to set the SPI to mode=C2=A03?

> @J=C3=B6rg: Can you please check this? If possible, a measurement of the =
SPI
> lines (with an oscilloscope or logic analyzer) would be interesting.

I can check this in the next days. I only have remote access to the device.


Thanks for helping me.

J=C3=B6rg

--=20
Ein Mensch sieht ein und das ist wichtig,
nichts ist ganz falsch und nichts ganz richtig.
                                               (Eugen Roth)

--7agv62ph3h65dp3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1XNAAAKCRB9LJoj0a6j
dRTMAP9Sjc3lAUMM36EhSQH/F4RHV69tMeEvJincn7QzudOs5AEAi1ARRAcfqls0
jJsNwUN+FZwGrYYqbGPjQfL0b1i5Boo=
=F+qV
-----END PGP SIGNATURE-----

--7agv62ph3h65dp3d--


Return-Path: <netdev+bounces-150751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A7D9EB6BF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F28162843
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CDE2080C0;
	Tue, 10 Dec 2024 16:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664931BAED6
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848991; cv=none; b=IrN3mXottk1h/q8ooGdc/PzJEP4dOzV0tzTfshbo96onU5sRM4ol7iTdjO7f6FMkEA946ei7d60Yjf/Szm4rzfutwCBhUgD/ZYgemS+oOhJe7dRJt8CHAAeNYlbBWSp5CQixkr/qX6QDCCo1cbXqzul+xwmZV0N8xO6HxMfahqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848991; c=relaxed/simple;
	bh=SExrzfnPZUft5lVQF9Sc4NX1Ri0gWkekHaJBuHWpshQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVyRXNasuiAnmGzc8Po2cs9p7by770QtQrRHgzb6fvfMJQt2/X+itPnHR6Wcj8anNPZPuPoRhoPxozniEJ0SriOIxFbFw/8q5ugTj8cKmDFzrhcs4GlAQyPWS5avaufCWdZv9V+liiH7IUO0MTTnFpo4WhZHH2PMJaVnU03gGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tL3KA-001aIG-07;
	Tue, 10 Dec 2024 17:43:02 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tL3K9-00000000Nkk-1bIj;
	Tue, 10 Dec 2024 17:43:01 +0100
Date: Tue, 10 Dec 2024 17:43:01 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
 <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
 <7080052.9J7NaK4W3v@n9w6sw14>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3anvsdpyl3stznej"
Content-Disposition: inline
In-Reply-To: <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>


--3anvsdpyl3stznej
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

J=C3=B6rg Sommer schrieb am So 08. Dez, 17:44 (+0100):
> Christian Eggers schrieb am Sa 07. Dez, 23:44 (+0100):
> > On Saturday, 7 December 2024, 21:47:31 CET, Andrew Lunn wrote:
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
> >=20
> > On Saturday, 7 December 2024, 22:07:23 CET, J=C3=B6rg Sommer wrote:
> >=20
> > > I've added another dev_err() after the spi_setup:
> > >=20
> > > [    1.680516] ksz8795-switch spi0.1: ksz8795_spi_probe:55: ret of sp=
i_setup=3D0
> > > [    1.819194] ksz8795-switch spi0.1: ksz8795_spi_probe:61: ret=3D-22#

Hi Christian,

I've changed the code for debugging to this:

        {
            u16 id16;
            ret =3D ksz_read16(dev, 0x00, &id16);
            dev_err(&spi->dev, "%s:%d: ksz_read16(REG_CHIP_ID0, %d) =3D %d\=
n",
                    __func__, __LINE__, id16, ret);
        }

	/* setup spi */
        dev_err(&spi->dev, "Switching SPI mode from %d to spi-cpha,spi-cpol=
\n",
                spi->mode);
        spi->mode =3D SPI_MODE_3;
        ret =3D spi_setup(spi);
        if (ret)
            return ret;

        {
            u16 id16;
            ret =3D ksz_read16(dev, 0x00, &id16);
            dev_err(&spi->dev, "%s:%d: ksz_read16(REG_CHIP_ID0, %d) =3D %d\=
n",
                    __func__, __LINE__, id16, ret);
        }

	ret =3D ksz8_switch_register(dev);

	dev_err(&spi->dev, "ksz8795_spi_probe:%d: ret=3D%d\n", __LINE__, ret);
	if (ret =3D=3D -EINVAL || ret =3D=3D -ENODEV)
		ret =3D -EPROBE_DEFER;

With a devicetree without spi-cpha, spi-cpol I get this:

[    1.751347] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.751445] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cpha=
,spi-cpol
[    1.752226] ksz8795-switch spi0.1: ksz8795_spi_probe:91: ksz_read16(REG_=
CHIP_ID0, 0) =3D 0

[    1.889370] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-517
[    1.891431] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.891525] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    1.892282] ksz8795-switch spi0.1: ksz8795_spi_probe:91: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    2.034994] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-517
[    2.043130] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    2.043217] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    2.043957] ksz8795-switch spi0.1: ksz8795_spi_probe:91: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    2.187793] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-517
[    2.195915] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    2.207703] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    2.207795] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    2.208554] ksz8795-switch spi0.1: ksz8795_spi_probe:91: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    4.212102] ksz8795-switch spi0.1: configuring for fixed/rmii link mode
[    4.219662] ksz8795-switch spi0.1: Link is Up - 100Mbps/Full - flow cont=
rol rx/tx

The immediate read after the spi_setup reports `0` for the chip ID.

If I comment the second block, this brings the -22 which stops further
probing (if not mangled by by EINVAL =E2=86=92 EPROBE_DEFER).

[    1.712445] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.712545] ksz8795-switch spi0.1: Switching SPI mode from 0 to spi-cpha=
,spi-cpol
[    1.851109] ksz8795-switch spi0.1: invalid family id: 0
[    1.851192] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-22
[    1.853241] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.853336] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    1.992243] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-517
[    1.994767] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    1.994860] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    2.128827] ksz8795-switch spi0.1: ksz8795_spi_probe:97: ret=3D-517
[    2.140263] davinci_emac 1e20000.ethernet: incompatible machine/device t=
ype for reading mac address
[    2.148743] ksz8795-switch spi0.1: ksz8795_spi_probe:76: ksz_read16(REG_=
CHIP_ID0, 34705) =3D 0
[    2.148836] ksz8795-switch spi0.1: Switching SPI mode from 3 to spi-cpha=
,spi-cpol
[    4.145963] ksz8795-switch spi0.1: configuring for fixed/rmii link mode
[    4.146161] ksz8795-switch spi0.1: Link is Up - 100Mbps/Full - flow cont=
rol rx/tx

So I think it's a timing problem: the ksz8795 isn't ready after the SPI
reset, when the chip ID gets read, and this causes the probing to stop.

Why is SPI_MODE_3 required? At me, the chip works fine with SPI_MODE_0.


Regards, J=C3=B6rg

--=20
> Ich kenn mich mit OpenBSD kaum aus, was sind denn da so die
> Vorteile gegenueber Linux und iptables?
Der Fuchsschwanzeffekt ist gr=C3=B6=C3=9Fer. :->
Message-ID: <slrnb11064.54g.hschlen@humbert.ddns.org>

--3anvsdpyl3stznej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1hvkwAKCRB9LJoj0a6j
dVb1AP4kHCsLi5qlOuk3Zy6ajseRYl5rbsbWyTzAaqFTeRsGrwD2OXjIntA/UgCW
UG2vU/PFkYGLGV8NjjhNZr0EKSmKSg==
=/QlN
-----END PGP SIGNATURE-----

--3anvsdpyl3stznej--


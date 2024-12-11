Return-Path: <netdev+bounces-151080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A09ECBFB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A86283FCA
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454A225A2A;
	Wed, 11 Dec 2024 12:24:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115611C173F
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919847; cv=none; b=fPmxOvIkJVxhbKJ6WODWfop2U+UOSVJpNrQV/9mMvAy8YtHh8ijk+2kRykFQyVy4ZIR95FXswR58xk5xn/nCYnw/5i/l5ERRswfeIevtV0B9/76ltnne16iFqd1xyDJQpVsO3E46520ziJX7GWCEzlpWg41MgWQrNyxIypbzAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919847; c=relaxed/simple;
	bh=uzuxhtwvN1xpG/I342ummGF9fxqwn1ceIrIpKJyXxPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eil+jfSHx1xtspxaKXG1/mF+oihOPf7bKvUjmaR9ZDbBsBSbIMcWr+vllKvnqnvoLxfLmEqIfB75u/+246kgzhiLyVI1wmO20QB7Vr8Hb/q5rC6xZjQvVrp3Y+zYJtg/Llpobe/E8mrXbEFlbmfDrCN23OXv0DI7czJW+5wcBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tLLkh-001rhL-1R;
	Wed, 11 Dec 2024 13:23:39 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tLLkg-00000000bZs-3SDB;
	Wed, 11 Dec 2024 13:23:38 +0100
Date: Wed, 11 Dec 2024 13:23:38 +0100
From: =?utf-8?B?SsO2cmc=?= Sommer <joerg@jo-so.de>
To: Christian Eggers <ceggers@arri.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <cxe42bethnzs7f46xxyvj6ok6ve7itssdxyh2vuftnfws4aa3z@2o4njdkw3r5i>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
 <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
 <5708326.ZASKD2KPVS@n9w6sw14>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ruj6lnrinrx7yj4z"
Content-Disposition: inline
In-Reply-To: <5708326.ZASKD2KPVS@n9w6sw14>


--ruj6lnrinrx7yj4z
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: KSZ8795 not detected at start to boot from NFS
MIME-Version: 1.0

Christian Eggers schrieb am Mi 11. Dez, 11:18 (+0100):
> Hi J=C3=B6rg,
>=20
> On Tuesday, 10 December 2024, 17:43:01 CET, J=C3=B6rg Sommer wrote:
> >=20
> > So I think it's a timing problem: the ksz8795 isn't ready after the SPI
> > reset, when the chip ID gets read, and this causes the probing to stop.
> >=20
> > Why is SPI_MODE_3 required? At me, the chip works fine with SPI_MODE_0.
>=20
> I tried to reconstruct why I actually did this change (sorry, I am over 4=
0):

Don't worry. Me, too. :)

> 1. I was working on the PTP patches for KSZ956x.
> 2. It was necessary to convert the devicetree bindings to Yaml.
> 3. There where objections against keeping "spi-cpha" and "spi-cpol"
>    in the example code:
>    https://lore.kernel.org/netdev/20201119134801.GB3149565@bogus/

I think for 8795 these are optional. At me, it works with 0 and 3.

I'm not an expert. So, please, double check this: the spec [1] says on
page=C2=A053, table=C2=A04-3, register=C2=A011, bit=C2=A00 =E2=80=9CTrigger=
 on the rising edge of SPI
clock (for higher speed SPI)=E2=80=9D. According to [2] the rising edge is =
cpol=3D0
and mode=C2=A00. So, =E2=80=9Chigher speed SPI=E2=80=9D (I think this is th=
e 25MHz) should use
mode=C2=A00.

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductD=
ocuments/DataSheets/KSZ8795CLX-Data-Sheet-DS00002112.pdf
[2] https://electronics.stackexchange.com/a/455564

> On Thursday, 19 November 2020 07:48:01 -0600, Rob Hering wrote:
> > On Wed, Nov 18, 2020 at 09:30:02PM +0100, Christian Eggers wrote:
> ...
> > > +        ksz9477: switch@0 {
> > > +            compatible =3D "microchip,ksz9477";
> > > +            reg =3D <0>;
> > > +            reset-gpios =3D <&gpio5 0 GPIO_ACTIVE_LOW>;
> > > +
> > > +            spi-max-frequency =3D <44000000>;
> > > +            spi-cpha;
> > > +            spi-cpol;
> >=20
> > Are these 2 optional or required? Being optional is rare as most
> > devices support 1 mode, but not unheard of. In general, you shouldn't
> > need them as the driver should know how to configure the mode if the h/w
> > is fixed.
> ...
>=20
> It seems that I considered the h/w as "fixed". The pre-existing device tr=
ee
> bindings and the diagrams on page 53 suggested that SPI mode 3 is the only
> valid option. Particularly the idle state of the "SCL" signal is high her=
e:
>=20
> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Sheet-DS00=
002419D.pdf
>=20
> But the text description on page 52 says something different:
> > SCL is expected to stay low when SPI operation is idle.=20
>=20
> Especially the timing diagrams on page 206 look more like SPI mode 0.
>=20
> So it is possible that my patch was wrong (due to inconsistent description
> on the data sheet / pre existing device tree binding). As I already menti=
oned,
> I did this only due to the DT conversion, I actually don't use SPI on such
> devices myself.
>=20
> N.B. Which KSZ device do you actually use (I didn't find this in you prev=
ious
> mails)?

I'm using KSZ8795.


J=C3=B6rg.

--=20
>> Kann man da auch ausrutschen?
> Das ist ja das fatale: Im Bett passieren sogar Unf=C3=A4lle, *ohne* da=C3=
=9F man
> ausrutscht.
Du meinst, Safer Sex ist, wenn man die Freundin an der Wand festkettet?
   <news:072bda371fa28679a7c0818a1157fd7e@fitug.de>

--ruj6lnrinrx7yj4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABEIAB0WIQS1pYxd0T/67YejVyF9LJoj0a6jdQUCZ1mESQAKCRB9LJoj0a6j
dWjTAQCzWAdKH95Xo0iGAIPaHorkFo4mvPTu4uKWrdYmmbSeGQD/egiqLQ5Z7gbu
onI4zl2Ub51CVXcOhInsrGtcfeKRNzE=
=K4Nf
-----END PGP SIGNATURE-----

--ruj6lnrinrx7yj4z--


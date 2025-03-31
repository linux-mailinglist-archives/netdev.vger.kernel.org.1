Return-Path: <netdev+bounces-178438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36F9A77043
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD6A1887B11
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BA821C183;
	Mon, 31 Mar 2025 21:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FpFIRWS0"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03498189F56;
	Mon, 31 Mar 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457444; cv=none; b=bPiVgiyzCj4Vro+PPhElmmneDjwUDG1znBYXq7aOXl21Blbjqg84A5ojlYIvMuMMOX20Y/uIaCGlPLQnKG+HiPqeSBY5heFjOcuc1oSMRy/ERtEj2ZXx/KUQFO1v3NEjOEAPFlTORhwss7y3DFYotBmPh9ghzovlMfC8tw0LeAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457444; c=relaxed/simple;
	bh=62bIIU89bJbCBl/MrAuDyx2ZZCZv7YGE9FpT9I4q7ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHbUHjtC4R9U2ZHDHSuQ0/qOsy3XQVWM1TRLaZn+iW6xqKWvUTO/jFQKRLjIXvbVv8r8oPKn3cuNEjF0azmMgWgohId4buo5hmNGKlev0XATQ9H8z5a9DOJsShNLdJPJiWjPNKMx5SCoWJH6PL5Sh3U5qEXR4UDZEhudVQkay+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FpFIRWS0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E6F7110252BE4;
	Mon, 31 Mar 2025 23:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743457439; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=M1kAHr/2LuQvRfK4BWV3MaCLSiNlbrzzetn6/mOgDms=;
	b=FpFIRWS0in2BDlOktoENOy68ru7VF3ykJs8txMirTePb7Q4K1Gtr6XHTCoOSn41RdnWWuy
	K47+YU03mchrcMLsKbJvGKCy6MqTjCBje0bv0udcUuZ5ZBRLTXp/zWEWMM8NtrAz2R6V9Z
	lapLT7i6oUKfGgoQVsV1XVwrfg3o3iZYNJbVsXCeqUKvrkAa8kQ68z05RYashS/aQXcTcK
	QQ3BLhqSfl5wkK1DzU2/V4DL5IvhfRFezk76P5OhPvTJT5Jxr8SivBhXjjo9UtonWtMk7K
	D1Zh72wHWCOjUSuPrUTWTMbmGj+emsVXuoem0/kFEOj9VFmuJaPqZj9wIbfRRA==
Date: Mon, 31 Mar 2025 23:43:54 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
Message-ID: <20250331234354.6032a4c0@wsk>
In-Reply-To: <7fa1b5c7-d5c5-45be-af6d-ae97a76eccae@gmx.net>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331103116.2223899-4-lukma@denx.de>
	<7fa1b5c7-d5c5-45be-af6d-ae97a76eccae@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N4y+i2Yc7WjNKxm/ab1iCGE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/N4y+i2Yc7WjNKxm/ab1iCGE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi,
>=20
> Am 31.03.25 um 12:31 schrieb Lukasz Majewski:
> > The description is similar to the one used with the new CPSW driver.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Remove properties which are common for the imx28(7) SoC
> > - Use mdio properties to perform L2 switch reset (avoid using
> >    deprecated properties)
> >
> > Changes for v3:
> > - Replace IRQ_TYPE_EDGE_FALLING with IRQ_TYPE_LEVEL_LOW
> > - Update comment regarding PHY interrupts s/AND/OR/g
> > ---
> >   arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 54
> > +++++++++++++++++++++++++ 1 file changed, 54 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> > b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts index
> > 6c5e6856648a..8642578fddf3 100644 ---
> > a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts +++
> > b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts @@ -5,6 +5,7 @@
> >    */
> >
> >   /dts-v1/;
> > +#include<dt-bindings/interrupt-controller/irq.h>
> >   #include "imx28-lwe.dtsi"
> >
> >   / {
> > @@ -90,6 +91,59 @@ &reg_usb_5v {
> >   	gpio =3D <&gpio0 2 0>;
> >   };
> >
> > +&eth_switch {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mac0_pins_a>, <&mac1_pins_a>;
> > +	phy-supply =3D <&reg_fec_3v3>;
> > +	status =3D "okay";
> > +
> > +	ethernet-ports {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		mtip_port1: port@1 {
> > +			reg =3D <1>;
> > +			label =3D "lan0";
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			phy-mode =3D "rmii";
> > +			phy-handle =3D <&ethphy0>;
> > +		};
> > +
> > +		mtip_port2: port@2 {
> > +			reg =3D <2>;
> > +			label =3D "lan1";
> > +			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +			phy-mode =3D "rmii";
> > +			phy-handle =3D <&ethphy1>;
> > +		};
> > +	};
> > +
> > +	mdio_sw: mdio {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		reset-gpios =3D <&gpio3 21 0>; =20
> i'm a huge fan of the polarity defines, which makes it easier to
> understand.
>=20

Ok.

> Btw since you introduced the compatible in the DTS of a i.MX28 board,
> it would be nice to also enable the driver in mxs_defconfig.

Yes, thanks for the tip.

>=20
> Regards
> > +		reset-delay-us =3D <25000>;
> > +		reset-post-delay-us =3D <10000>;
> > +
> > +		ethphy0: ethernet-phy@0 {
> > +			reg =3D <0>;
> > +			smsc,disable-energy-detect;
> > +			/* Both PHYs (i.e. 0,1) have the same,
> > single GPIO, */
> > +			/* line to handle both, their interrupts
> > (OR'ed) */
> > +			interrupt-parent =3D <&gpio4>;
> > +			interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> > +		};
> > +
> > +		ethphy1: ethernet-phy@1 {
> > +			reg =3D <1>;
> > +			smsc,disable-energy-detect;
> > +			interrupt-parent =3D <&gpio4>;
> > +			interrupts =3D <13 IRQ_TYPE_LEVEL_LOW>;
> > +		};
> > +	};
> > +};
> > +
> >   &spi2_pins_a {
> >   	fsl,pinmux-ids =3D <
> >   		MX28_PAD_SSP2_SCK__SSP2_SCK =20
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/N4y+i2Yc7WjNKxm/ab1iCGE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfrDJoACgkQAR8vZIA0
zr3UJQgA0HyhfyDsLGObOeUIL/btg74vBxnJ2OTGDfIniD4pupQW+Cn0MwjEK6GX
Fp9QA2fyp0ExoXwOcECHPiTRz5uVeYyQ/mw7rvtTJ+P3mYFhGkyyjiAK2wSJCZ3L
WJZhqR4APlr1nIBc3j8ROlplZ+oOMwXKO4TCHApE+JGHXFWhMnGc8T0asmKV3sx6
exPXHFhNNFqmiBj/ZfIKR3zwGj+8zgZYQaDyU4vTuy69iOMPiq0IN0+rsrFSf2B7
75p2+JhOken4DV/6MK1DhpBqs7eGz0JCC4A2pRAcjCMWLTfE2kD6pf21l+IrmLdD
TKlO2eLMKaTfXEp7FJ8oNwJqUSmfZw==
=X/u9
-----END PGP SIGNATURE-----

--Sig_/N4y+i2Yc7WjNKxm/ab1iCGE--


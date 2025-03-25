Return-Path: <netdev+bounces-177510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F589A70689
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295AD7A194B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF0419EEC2;
	Tue, 25 Mar 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="etuhEHLc"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BA12EBE7;
	Tue, 25 Mar 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919403; cv=none; b=nYOnV17V0IW0sTNRAGThZVTAUwpxFw2ipjaacY3ieTnrPQg6KRquWpm+XbzvzlN7LBUO4vnLN1a8mbd3QdrOZl+LJ0VUx6o0cfkdK2ALAAET5O4rbYmp0OuB90ybNWi8lcNwNgSX8fQn77dSy8cyXIdnPjbawFEXebcQTiS3To4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919403; c=relaxed/simple;
	bh=8aUjtTkLVSkcyr6ieKYqb/IyOv7g99gpoF5vwmnrsKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrCZ8qBLa2AA4gJ/YlNb/u9wLUUrCyPqWm9PQcI2Qeoojc4OhWiJ8tf4TH9O2xWubbSTVBG7cJsXY3+0QoB611G8efISV/5wrC1CxvkvEy+YWp9oDdwYAUu6VLu7Jp4qvNVDVhIlg1CTN9NfHrHi8CW0xEUwyTR8YJrRCKQynAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=etuhEHLc; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0EF54102F66E4;
	Tue, 25 Mar 2025 17:16:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742919398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=RWBAlXIiGSk72+6SessRFhuHLNEcm290ACC2CqugoH8=;
	b=etuhEHLcGMuGJ2sHkEQHMUW7CYyd3kSRO3VgG7YzetdL6iKlTmQA65K9QexSY4M43MDD/r
	KCcEd+MmekrLuoa37EcJI/0jVOs3zXxpLl1cNyqzsJwavPkatyebPXJQXI+e0SWcf9o4eS
	AWqtCd6tTylJ06cBTHBZfrXyioOnFHYokl3L/EkiJMyvXIzE9MnzQe5s011oXV+4lGofXM
	pfrMFFlbky0wXbK5uLpu8eZlkIxe/PjP4+fC8ikwsQ9kfo1YuS51Ftr2OF/xs0Dlhmm6VT
	0TURP8y1DhSClSnNk+U1Lc1odU0a219CNa/vm6D3qm0KjQMMA9r/8Loc5VVXmg==
Date: Tue, 25 Mar 2025 17:16:34 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 4/5] arm: dts: imx287: Provide description for MTIP L2
 switch
Message-ID: <20250325171634.1c982583@wsk>
In-Reply-To: <40c6c272-d4a3-4bf2-87a1-17086d96afea@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-5-lukma@denx.de>
	<40c6c272-d4a3-4bf2-87a1-17086d96afea@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/greT4myIzbgADdfT0SPqvTm";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/greT4myIzbgADdfT0SPqvTm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> On Tue, Mar 25, 2025 at 12:57:35PM +0100, Lukasz Majewski wrote:
> > This description is similar to one supprted with the cpsw_new.c
> > driver.
> >=20
> > It has separated ports and PHYs (connected to mdio bus).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/boot/dts/nxp/mxs/imx28-xea.dts | 56
> > +++++++++++++++++++++++++ 1 file changed, 56 insertions(+)
> >=20
> > diff --git a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts
> > b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts index
> > 6c5e6856648a..e645b086574d 100644 ---
> > a/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts +++
> > b/arch/arm/boot/dts/nxp/mxs/imx28-xea.dts @@ -5,6 +5,7 @@
> >   */
> > =20
> >  /dts-v1/;
> > +#include<dt-bindings/interrupt-controller/irq.h>
> >  #include "imx28-lwe.dtsi"
> > =20
> >  / {
> > @@ -18,6 +19,61 @@ &can0 {
> >  	status =3D "okay";
> >  };
> > =20
> > +&eth_switch {
> > +	compatible =3D "fsl,imx287-mtip-switch"; =20
>=20
> The switch is part of the SoC. So i would expect the compatible to be
> in the .dtsi file for the SoC.

Ok.

I'm also wondering if I shall use "fsl," or "nxp," prefix. The former
one is the same as in fec_main.c, but as I do add new driver, the
prefix could be updated.

>=20
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&mac0_pins_a>, <&mac1_pins_a>;
> > +	phy-supply =3D <&reg_fec_3v3>;
> > +	phy-reset-duration =3D <25>;
> > +	phy-reset-post-delay =3D <10>;
> > +	interrupts =3D <100>, <101>, <102>;
> > +	clocks =3D <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> > +	clock-names =3D "ipg", "ahb", "enet_out", "ptp"; =20
>=20
> Which of these properties are SoC properties? I _guess_ interrupts,
> clocks and clock-names. So they should be in the SoC .dtsi file. You
> should only add board properties here.

Ok. I will add them.

>=20
>        Andrew

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/greT4myIzbgADdfT0SPqvTm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfi1uIACgkQAR8vZIA0
zr1rmggAx1FgdV+Uvb819ObkX0K7D/zPrmuFUWMVgi8RNIV2Wr55ejmrX3s/QQRV
emSwGiQ4g3CJL9w4bbtQ1lvEmxPMmzlzG69NXvgWyLykHKFLnlCQ8YBclJHRHNWy
gwzqLyqpSkM4RgM/qVh8Tqg1HEk9hyhwiLVwZo25qyPOq/0mPzbFhgqyKHi3CIxT
U75LviRxABG9/5/7/7cNgYsobJfrKjFA4rRDjXiSfxwv6gX0oO8hyKLGMviv+5B8
KBoETzr7Ukhty1Iqp2g8HyUAeU11GV+HxPwENZ6EwAy1FytBgKj28mP/kl+pAXLQ
zpHVgwgILNnvfDlFKcZPaAcUBdmeMw==
=gPXo
-----END PGP SIGNATURE-----

--Sig_/greT4myIzbgADdfT0SPqvTm--


Return-Path: <netdev+bounces-181687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C985A8623C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 17:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2B41BA879B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C643211A15;
	Fri, 11 Apr 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PKfuqoTB"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA2620E33F;
	Fri, 11 Apr 2025 15:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386338; cv=none; b=svjIsITF89v0t09hWT0e81KwldoikFzkAJME9p2YYiBjAP1pfs1RA9sf4HwDZTUFC3EJlSbB/aU8N/rZ2TBTuQp9cBM7KBQlptSFQTlzmNdXf25R5IMtnh6aPA9xlj5XUQ+KRL5maJ6P+OGPZ/6ntuZbhRO4C91bJjfw3LAdGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386338; c=relaxed/simple;
	bh=P6bHlax7gtaFOXyBlmDivlwl4i2XuFH3nXhBHUOMVX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Stv55MIM82vaCpUnF1dowsfirS3DRbE0Y13FAcAlyutKmvI+ASCQGRUVYl1BrK9Fz32J0pSY0SWNMEkbrbhWWpBw2TK5XtFDgoaclQ6gn7ScglNrqQlaWup7gyoSNVkO1BWqjDuWevkS1fp2kfTpPHWYxy8ZSDekzYOPS5NUC10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PKfuqoTB; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0A915103B92D7;
	Fri, 11 Apr 2025 17:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744386333; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+Upffkr9Yy13DmAWHLsmplXaonISPjC+YsZOOcmdckk=;
	b=PKfuqoTBF8hjxW1TDHptk6vQF1Na4fKu97/graZ1upeWhnoUHjsLEoWYFxyC8VPu6oyC99
	9Uto9JRbj8FkfXTq/K2/OC0pPMDnatJ/j0bxpB7riTgd/Jqke49Bgzflc6fdFcHFOanZJn
	IiVZ+p8nvpYIH3+z3iY0V2MWcYw78Xee0+ek4V462morBil0Sys8qMkL8eyjcbd+psxghK
	gzS33Lz3HveHbzpPwh1qjeHaGodlFLGGQlBO99IBW//nRUwfcn4Ljj+OZ9ZMAweKB4HhLx
	qzgbqyXNiZ/XBU8hl79FMd3XYTtb3Se3FpwE2iOyV9P099yoH20PPiJxKrHfKQ==
Date: Fri, 11 Apr 2025 17:45:27 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>
Subject: Re: [net-next v4 3/5] ARM: dts: nxp: mxs: Adjust XEA board's DTS to
 support L2 switch
Message-ID: <20250411174527.14a175d1@wsk>
In-Reply-To: <CAOMZO5B6q06nvk3+hzbioGpcW8_JXPZGEebApTU5JZbKvMLzxA@mail.gmail.com>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-4-lukma@denx.de>
	<CAOMZO5B6q06nvk3+hzbioGpcW8_JXPZGEebApTU5JZbKvMLzxA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RjsyxtHSE6bgRB8ADC.4s63";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/RjsyxtHSE6bgRB8ADC.4s63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Apr 7, 2025 at 11:52=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>=20
> > +               ethphy0: ethernet-phy@0 {
> > +                       reg =3D <0>;
> > +                       smsc,disable-energy-detect;
> > +                       /* Both PHYs (i.e. 0,1) have the same,
> > single GPIO, */
> > +                       /* line to handle both, their interrupts
> > (OR'ed) */ =20
>=20
> Please fix the multi-line comment style.

Ok, I will fix it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/RjsyxtHSE6bgRB8ADC.4s63
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf5ORcACgkQAR8vZIA0
zr2oJwf8Ck6aJmjSk5FB00W4YTIEgy2n/BJVaK1BTJCll5U54B+Hlrwra2iixLwh
jvZqm01bg4Qncx7bYbcHaUeyiW7B7SBc/ikaBi56eDthprdbKS0r3s5wFHTEW8vg
V2JzJjT6jeGJT+nMW7wRouLuZ5EQvi2rrUWbbi8gCKaztEHwEVqbc8BOJ4Kbhinz
gB1OakDJzWZPtgadY8QOUYQMdLx68vBOG9tsttGiiKQG0+s0a4Tih0jqbQCfBgwJ
CQAYHWX11CLdPW7yNvJFKO7nTdw3fNRmFQf3+fk5LbkeLKt7IWNHBPoiB3m3bUZh
YFEUvNsexJb+gquBquCl/bIpp/AVCQ==
=OHjq
-----END PGP SIGNATURE-----

--Sig_/RjsyxtHSE6bgRB8ADC.4s63--


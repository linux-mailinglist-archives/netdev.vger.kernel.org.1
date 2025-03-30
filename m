Return-Path: <netdev+bounces-178229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DBA75C40
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 23:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7B11885729
	for <lists+netdev@lfdr.de>; Sun, 30 Mar 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E38F1DEFD2;
	Sun, 30 Mar 2025 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Mx7Umlj5"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EF1DED69;
	Sun, 30 Mar 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743368675; cv=none; b=D7U9JHAvyxPJbluRKRc0xplVPBoOgtMwksASex2xX8UWLJWbEOniZqy17xY4GYlYW20B2ea1GLAL9ehF1plC9FIP4peE8Np0BHC1+XOmRoKI6XX8ip3Ln4q+FJdhRGWaeRoyTlwTRvroWMfEmRj3KilK+x8SeBtBdGtDv0Tku1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743368675; c=relaxed/simple;
	bh=j7sCc9j8ExMeuzg/Pz8nUC9Flf6ycTDiJgl84vrGO+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXkkQgbfSz7M6lx/vWCVKTYxW6X7KPJxSaFErJGUn9847MvJZnG730bYsSxmJa1SXh+SJ0wxKaQKs/SxdiNI69TqyrCqsZ3lqtyC9YHf0rgwJXsVOv/Jz8LRS5dKz22i1T/kUzzl176m9OmlzGyZ2jNZNnHkmRRVO+hF8Pmr+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Mx7Umlj5; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7552102F66E1;
	Sun, 30 Mar 2025 23:04:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743368670; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=901Bq3gxJ4OzVl6RNicUF10kt/4QX89li+J+N6jGrBA=;
	b=Mx7Umlj5Dy67EVKrXk5rs0zN0m01GfK9PxcRu6h4Ck4cYNEAiDqg7YEbMpOyVpdVRt+jne
	UCUpfNJnGxNJRGxRDCMcUMSgrvUxAsWiZLacqZsJTHjYuDs6DfzT3VWx8s51nmjaW2K8JD
	fNEwacAMRdWupC0W8RVpuApWWR6KTpLZ/M/oFYrLcftzMp7JJd5A0hwH83DRI1xJgWR1y0
	20nQNobttE5U4qB71Hied1LhQLJGxQ3KDvotNIuRQsnyJMbuA8h1HH2FFUcUl0LQ2wqVhS
	kc74lmL8lGDGHPQBkKX+TUZn2VBWyenSsCXYNodai5WKeeAt82HIHHfELv0pew==
Date: Sun, 30 Mar 2025 23:04:25 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250330223630.4a0b23cc@wsk>
In-Reply-To: <564768c3-56f0-4236-86e6-00cacb7b6e7d@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-2-lukma@denx.de>
	<e6f3e50f-8d97-4dbc-9de3-1d9a137ae09c@kernel.org>
	<20250329231004.4432831b@wsk>
	<564768c3-56f0-4236-86e6-00cacb7b6e7d@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E2PoMMoC/cTLiz_ZN0ugdQX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/E2PoMMoC/cTLiz_ZN0ugdQX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 29/03/2025 23:10, Lukasz Majewski wrote:
> >>> +   =20
> >>
> >> If this is ethernet switch, why it does not reference
> >> ethernet-switch schema? or dsa.yaml or dsa/ethernet-ports? I am
> >> not sure which one should go here, but surprising to see none. =20
> >=20
> > It uses:
> > $ref:=C2=B7ethernet-controller.yaml#
> >=20
> > for "ports".
> >=20
> > Other crucial node is "mdio", which references $ref: mdio.yaml# =20
>=20
> These are children, I am speaking about this device node.

It looks like there is no such reference.

I've checked the aforementioned ti,cpsw-switch.yaml,
microchip,lan966x-switch.yaml and renesas,r8a779f0-ether-switch.yaml.

Those only have $ref: for ethernet-port children node.

The "outer" one doesn't have it.


Or am I missing something?

>=20
> >  =20
> >> =20
> >>> +properties:
> >>> +  compatible:
> >>> +    const: nxp,imx287-mtip--switch   =20
> >>
> >> Just one -.
> >> =20
> >=20
> > Ok.
> >  =20
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      The physical base address and size of the MTIP L2 SW module
> >>> IO range   =20
> >>
> >> Wasn't here, drop.
> >> =20
> >=20
> > The 'reg' property (reg =3D <0x800f0000 0x20000>;) is defined in
> > imx28.dtsi, where the SoC generic properties (as suggested by
> > Andrew - like clocks, interrupts, clock-names) are moved. =20
>=20
> Drop description, not the reg. Reg was in the previous version. You
> added random changes here, not coming from the previous review.
>=20

Ach... You mean the "description" in the:

	reg:
	  maxItems: 1
	  description:
	    XX YY

Ok, I will remove it.

> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/E2PoMMoC/cTLiz_ZN0ugdQX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfpsdkACgkQAR8vZIA0
zr2OOwf8D0o3VBKQo0wzlGRUM/T2N281OQjJWLHyJkh73CTqHrX2rUeLf9n4uJBu
pQbWZbpX7HOxC/3XTUZi5m56dARLhcV2px0RPiMkjRikv/G84Ol530tpvCkWL6xo
yFtrnA9AhHL/2UBUcBu3tymPQ5BWj5uBQN83AZskGaaRu1aZ8U+DGDa+2cPDEM00
5IfBke7cGgUZGS6RPSE6Pdbl3eHRQrY3Kw1tB5UxwhTAePDEMPQ9lR34aOAJ7EJS
6QudhKxb9AeI/FixnJxhtE0HVyyb/NfSYtm4OtqDTRgHe5UXdNVL6MheoTGhyfrh
o2PPkKI+Gp1erjBY7OGhV8Qv1Su5nw==
=Ch8l
-----END PGP SIGNATURE-----

--Sig_/E2PoMMoC/cTLiz_ZN0ugdQX--


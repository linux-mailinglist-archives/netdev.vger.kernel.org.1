Return-Path: <netdev+bounces-177349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6BA6FADB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C573B18F9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8BE2566E6;
	Tue, 25 Mar 2025 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RDAxNLLY"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33F1A073F;
	Tue, 25 Mar 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904921; cv=none; b=NSazdjK7gypbvcOKDuXVuDOsb3IHPn5jGiu+F0Whcia52MHNeMCSZaS6gGGc+FDADhs7w+MjDIME9MEYGRG4XfuLyG6G5XsxgeiwY4pSGbPVdawDKITPBFhs00gD1I1gK6bWJ1vEVQtuG3BwWuglL3SU8zqzvk+/uptHfz4kA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904921; c=relaxed/simple;
	bh=3EjRv+MDeGAnLpJRXA7dgB81OVwWdjtHPSO7rMKHRxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsLnBN+SflG/bQaOzVFMTT4W3qdYReH85dG6+bPsfQ7G5SHwJ5wk73GhqQ7kwchtylTYRepOunwDwnwe4DvZjIX3SGMweYdkpmI2uU2bcHz4QmQfrNtzJYCNAEccxtKGhIUVqrNq/WLZCtUCmk2j5vNVNfZ8u0HFlzFLmYps5+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RDAxNLLY; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D418102F66FF;
	Tue, 25 Mar 2025 13:15:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742904913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=9okx19OZpA+5j+MdAvd2Ecd4r6SR5dnQkH8UTLcqtMA=;
	b=RDAxNLLY7NjCYc9nDp9XPBY/sX9jaLljzG7jM3kuJVgUUJ9EGP9qnv20zqYq/jCVu+G+4s
	Y6Wr+WsadOCDrZwhb1vFIbDRgtYoGK75k7F9LddbLAmfAKwLpflfidZjb57bIcB8EXz9DJ
	v0mInSfgKtf+VOU4Kbbp+74/VXeritZ2UpIVVZ7YL6VvbF7DkyT6bTmrokO/JgDNJsDemf
	XqIBUp6QbmHYp2A7kzlsuE/zbgB25xjpj22T6ApRlIQWs/JHgph7x3hqQ1gi1Ob+MggWzk
	7b+y3ih4yqzdD98wb+etvWGhl/0QRboNwsoSJr9u2nq4U3R/8WlCsVym/ceK1A==
Date: Tue, 25 Mar 2025 13:15:07 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
Message-ID: <20250325131507.692804cd@wsk>
In-Reply-To: <2bf73cc2-c79a-4a06-9c5f-174e3b846f1d@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-3-lukma@denx.de>
	<2bf73cc2-c79a-4a06-9c5f-174e3b846f1d@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zapl74rJPPeU2cp5Y+tnTMV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/Zapl74rJPPeU2cp5Y+tnTMV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 12:57, Lukasz Majewski wrote:
> > This patch provides description of the MTIP L2 switch available in
> > some NXP's SOCs - imx287, vf610.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  .../bindings/net/fec,mtip-switch.yaml         | 160
> > ++++++++++++++++++ =20
>=20
> Use compatible as filename.

I've followed the fsl,fec.yaml as an example. This file has description
for all the device tree sources from fec_main.c

I've considered adding the full name - e.g. fec,imx287-mtip-switch.yaml
but this driver could (and probably will) be extended to vf610.

So what is the advised way to go?

>=20
> >  1 file changed, 160 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml new
> > file mode 100644 index 000000000000..cd85385e0f79 --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> > @@ -0,0 +1,160 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/fsl,mtip-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Freescale MTIP Level 2 (L2) switch
> > +
> > +maintainers:
> > +  - Lukasz Majewski <lukma@denx.de>
> > + =20
>=20
> description?

Ok.

>=20
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf: =20
>=20
> Drop, you have only one variant.

Ok, for imx287 this can be dropped, and then extended with vf610.

>=20
> > +      - enum:
> > +	  - imx287-mtip-switch =20
>=20
> This wasn't tested. Except whitespace errors, above compatible does
> not have format of compatible. Please look at other NXP bindings.
>=20
> Missing blank line.
>=20
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 3 =20
>=20
> Need to list items instead.
>=20
> > +
> > +  clocks:
> > +    maxItems: 4
> > +    description:
> > +      The "ipg", for MAC ipg_clk_s, ipg_clk_mac_s that are for
> > register accessing.
> > +      The "ahb", for MAC ipg_clk, ipg_clk_mac that are bus clock.
> > +      The "ptp"(option), for IEEE1588 timer clock that requires
> > the clock.
> > +      The "enet_out"(option), output clock for external device,
> > like supply clock
> > +      for PHY. The clock is required if PHY clock source from SOC.
> > =20
>=20
> Same problems. This binding does not look at all as any other
> binding. I finish review here, but the code has similar trivial
> issues all the way, including incorrect indentation. Start from well
> reviewed existing binding or example-schema.

As I've stated above - this code is reduced copy of fsl,fec.yaml...

>=20
> Best regards,
> Krzysztof

Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Zapl74rJPPeU2cp5Y+tnTMV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfinksACgkQAR8vZIA0
zr17vAgAgqtwGoPNUc3EI7NljZqJvIZf6svb+ViihSV8scb7rPfd86a83cfQZpfC
Bo90ssMcSCwGTisf+VkcCumpXu3rH2TM7dC7eGc9ipr8dxD5sTgQtoek0kU51IUF
T1TpgmyNMS8qSG+Y7Y0GRE6+iRYQQrZXSRGzBaLYmamuvJdQpIbBt1v8rSojc1R7
qme7A5VKr8j+ERYCwjDxqV/K8PNeUaNEpRxl6QOLi2g9xqQuYWFuk5pow4OGzOv/
/Dnv6w1tZQNueZLPtd7noEh9ic/3jNHm0/36sQBBvQZv/IWBCtHq76PH/f2dGKa2
M2JTkCKr7K5WdSzlmXYoGCSQTrfs7g==
=5nCI
-----END PGP SIGNATURE-----

--Sig_/Zapl74rJPPeU2cp5Y+tnTMV--


Return-Path: <netdev+bounces-183611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E37A9142B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C1C5A136F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CC205ACF;
	Thu, 17 Apr 2025 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CF/2hWxC"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFB202F92;
	Thu, 17 Apr 2025 06:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744871918; cv=none; b=F5/x+m1SUYU+X5GyCx0cg8Xrm+K5hlSG2RM860UlcKtzPyDaKam0tbY0km0/fhTKX/VzNq6rAYAZcISd2jaILO4BsWJaRAt9j1raodayfBX4rYmLJmjBe0Z5vCWXXlguv+icuO0UJWSI5fY/sxhpiTnUjjyVxEm6kzs7QNHm5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744871918; c=relaxed/simple;
	bh=tqaxSkan5BJNfx0iwyF53Vkk22mFEv646P/1RQT7T3E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXskiD8O56l8QDY7Rtl6qrh0GMRbPqAGOOAbvOLV5R1FBiOEaCnuRSk/9Dz5Lfzpwhw10q9qqOIXI54ptjBYoZANPgki9oUjylFG/ueK8CCrk572EC6x3m9UgeGa7sRxyWVF6FimJKfv4fdRH1EXqaJIgr3w0fBk0EjhvOtvP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CF/2hWxC; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D2F71039EF2D;
	Thu, 17 Apr 2025 08:38:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744871913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=4xC/PhptF14VeztLYAsEO8pCcnPUWsP9GLAXS3cNIZA=;
	b=CF/2hWxCbLmyznN+D4w1XLf9hTfNa3IlQGV9P1xLRtiTkTvKB2rsUefG/fnIWMApKDFrVg
	Eo8CffVpxeFD8qYq3PJrrHiZ0M1gurjKANoN7D5hro8xGyYGCvQykMdCCO8sMfW3ilD4sT
	Cmo4SFGJavrJmq60/84/o24mKLIntvXyxzWAiDm75u4pNpLp4Z13Nm9n+ECRri1l4vZ5Jr
	9PLe/U1RWkGlHcaxdhDwM3DfIPzpl169Waw6jqTCPagNVug+Eh6p7JTfdM1Tkypxz1X0VF
	Pe4ukl4Q0Zs7kZGfsjcgcWWV8l/QRarunsHL7SyXZShxBiAlwWxmkuJpt5RN2Q==
Date: Thu, 17 Apr 2025 08:38:30 +0200
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [net-next v5 1/6] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250417083830.2517e1d3@wsk>
In-Reply-To: <bc818477-509d-4561-905a-743feeea6a74@gmx.net>
References: <20250414140128.390400-1-lukma@denx.de>
	<20250414140128.390400-2-lukma@denx.de>
	<bc818477-509d-4561-905a-743feeea6a74@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZnpQTjJr3BoJn5+lo3OMTMV";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/ZnpQTjJr3BoJn5+lo3OMTMV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Hi Lukasz,
>=20
> Am 14.04.25 um 16:01 schrieb Lukasz Majewski:
> > This patch provides description of the MTIP L2 switch available in
> > some NXP's SOCs - e.g. imx287.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Rename the file to match exactly the compatible
> >    (nxp,imx287-mtip-switch)
> >
> > Changes for v3:
> > - Remove '-' from const:'nxp,imx287-mtip-switch'
> > - Use '^port@[12]+$' for port patternProperties
> > - Drop status =3D "okay";
> > - Provide proper indentation for 'example' binding (replace 8
> >    spaces with 4 spaces)
> > - Remove smsc,disable-energy-detect; property
> > - Remove interrupt-parent and interrupts properties as not required
> > - Remove #address-cells and #size-cells from required properties
> > check
> > - remove description from reg:
> > - Add $ref: ethernet-switch.yaml#
> >
> > Changes for v4:
> > - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove
> > already referenced properties
> > - Rename file to nxp,imx28-mtip-switch.yaml
> >
> > Changes for v5:
> > - Provide proper description for 'ethernet-port' node
> > ---
> >   .../bindings/net/nxp,imx28-mtip-switch.yaml   | 141
> > ++++++++++++++++++ 1 file changed, 141 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > new file mode 100644 index 000000000000..6f2b5a277ac2 --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > @@ -0,0 +1,141 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
> > BSD-2-Clause) +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP switch)
> > +
> > +maintainers:
> > +  - Lukasz Majewski <lukma@denx.de>
> > +
> > +description:
> > +  The 2-port switch ethernet subsystem provides ethernet packet
> > (L2)
> > +  communication and can be configured as an ethernet switch. It
> > provides the
> > +  reduced media independent interface (RMII), the management data
> > input
> > +  output (MDIO) for physical layer device (PHY) management.
> > +
> > +$ref: ethernet-switch.yaml#/$defs/ethernet-ports
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,imx28-mtip-switch
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  phy-supply:
> > +    description:
> > +      Regulator that powers Ethernet PHYs.
> > +
> > +  clocks:
> > +    items:
> > +      - description: Register accessing clock
> > +      - description: Bus access clock
> > +      - description: Output clock for external device - e.g. PHY
> > source clock
> > +      - description: IEEE1588 timer clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: ipg
> > +      - const: ahb
> > +      - const: enet_out
> > +      - const: ptp
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Switch interrupt
> > +      - description: ENET0 interrupt
> > +      - description: ENET1 interrupt =20
> sorry for the late suggestion, but can we have additional=20
> interrupt-names here, please?

I've extended the proper *.yaml file and modified the driver to use
platform_get_irq_byname().


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/ZnpQTjJr3BoJn5+lo3OMTMV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgAoeYACgkQAR8vZIA0
zr0R0wf/UwSt8TP7hDCj2Np3vpeG1t+lQve+Zir7IsS5QK++xCMrXzUVm0u1eXoS
qSXBPridMN46qYCVZsLlR5Aa2hH8Kx5eJKKX101zMUswou2/nSKYGO698PbEGy7A
oNkfP5Frd6jlhyCkku0X1wpuTXNO0m7qG0CHxuzVK7LbEnTsiYleOIZXy0MxCs7r
tfGGxhfQXqnHZPGszZJsKgtCAW+F8lq7jLjB/hOuq/84yOItO5a65oEHIWGNGOfw
8b4/vaD0nia9TNdE8sHpnt7fwIJ7OjMQZ4n1Uw9SKr8eWgn9P/8jkmj+mY+qGgGj
KMdkdjax5kKRdc8xFUbsQt80zab+dg==
=CRSJ
-----END PGP SIGNATURE-----

--Sig_/ZnpQTjJr3BoJn5+lo3OMTMV--


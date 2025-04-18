Return-Path: <netdev+bounces-184090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088ECA93502
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A428E0408
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF226B951;
	Fri, 18 Apr 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Otj7vOEp"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF5145FE0;
	Fri, 18 Apr 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966888; cv=none; b=pRXqZUNdp5gVk9JCeP3/vXROPaIunYi6opR4HBFxKARFEg8cjXtclKQM3IEltOsdnCmy2wm7p+J3uV6kpmQ2aK7R/cyHZRnIodwr/tEB4w5Q4Hlauj78m+JlszZX6Zgj80miGftD+eZuk9ZJgkG+l6bYCybWrCXw9GrZmgKLSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966888; c=relaxed/simple;
	bh=yAumbfAfLWtVrqiRnX+aM7VpKReKjvJiNcORP9SS0wE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N04EfDZWgXZpLpu8taT2Lc+6X8ipbko6PsH0nXeNYg63vuzF6sY0hw7bMw8Pqh7M0jF2IRmDcDYcJ7D/43wZea3J76irpdYh7sYi32qAXcPziwOKkIxxACA43Bn5VzjA2Fz5QjHB5Lvt+KLV3VzI3gs+zFCoDu/x3Pq4hoCBws8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Otj7vOEp; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC642102E6336;
	Fri, 18 Apr 2025 11:01:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744966883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=1LODpW59RyDH7h3ZIvqn9KHid7mkClVKSG/86SmQNPw=;
	b=Otj7vOEpjjF7gWOeUvYT1YhAkKogTqAUbZdCbz62wihYTh0G1+htCizqDjtD5l/wA6yWZw
	i+Lm8tgSc5pSWuiQF3ZQgNltEVT5zIBdXPyJA7Af+K95AU9E9/ASQowpQCQ58SS1GJXH9T
	8qWnFlvHL6xy9H/OC8+QM/w/qKzt3jjhf17x9ll2ZUy5vTekLuTo465TaCratUX2C3Ziqf
	y/MkDqzka0RKet4E8beVgWdCL9lr1qLfB/1ZGMdplySu0yj2LGrkbVh5QQ8DpQt/+K1ZxW
	SDWxHoE+sGX9OyxdC2rZHHzgF/FDlNtayIw+NvLxrs5CAI9pzTLPG0pkrm3LYw==
Date: Fri, 18 Apr 2025 11:01:16 +0200
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
Subject: Re: [net-next v6 1/7] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250418110116.6179d8b5@wsk>
In-Reply-To: <e4c7662f-4d10-4d45-843d-0a0f3c893a1f@gmx.net>
References: <20250418060716.3498031-1-lukma@denx.de>
	<20250418060716.3498031-2-lukma@denx.de>
	<e4c7662f-4d10-4d45-843d-0a0f3c893a1f@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7vFZWx1R8BN07Jfliry9yAD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/7vFZWx1R8BN07Jfliry9yAD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Am 18.04.25 um 08:07 schrieb Lukasz Majewski:
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
> >
> > Changes for v6:
> > - Proper usage of
> >    $ref:
> > ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties when
> > specifying the 'ethernet-ports' property
> > - Add description and check for interrupt-names property
> > ---
> >   .../bindings/net/nxp,imx28-mtip-switch.yaml   | 148
> > ++++++++++++++++++ 1 file changed, 148 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > new file mode 100644 index 000000000000..3e2d724074d5 --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > @@ -0,0 +1,148 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
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
> > +      - description: ENET1 interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: mtipl2sw =20
> Sorry for nitpicking, but could we name it similiar to something from=20
> the i.MX28 reference manual like "switch" or "enet_switch"

I think that "enet_switch" may be OK.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/7vFZWx1R8BN07Jfliry9yAD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgCFNwACgkQAR8vZIA0
zr2puQgAkx2OqWOU6OUJqUpgOxkCPyyhhTyvDgEGBINxAqRunRFKsHsGk3C0lYAA
EO1xkhxuaMaN5IwB8G70geq9Dw5xGv5jMqZUaGjMtIz7aKehInA5220pz5uLO+Es
qQYwOaQ5yXnK6qq41NbN990K23S3wUPn4rr/B1UifLFpFe1LRM4yA3pKVaYYumVa
T8bOyyzzpLVshGJU01x5xmRvg4Za3CaxRGiR0vHS6CjnDCz6zcpRIUdi36oW/22C
Cp4XZbAvi+3ckxwmMaRW6wSVpEUMb7GXvQFdT5nIxm82990Lh5JA2drKt5SF49me
95Xspq3uyD4oESdTyNhRYoPY07KRZA==
=UHBk
-----END PGP SIGNATURE-----

--Sig_/7vFZWx1R8BN07Jfliry9yAD--


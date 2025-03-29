Return-Path: <netdev+bounces-178212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 273C1A757F8
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 23:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66EB16A62E
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 22:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5721DF74E;
	Sat, 29 Mar 2025 22:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="AE8ZduE3"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAF1B4138;
	Sat, 29 Mar 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743286214; cv=none; b=ID9TCQxlGG+FrVvxOC4nK1JhFPC7qeOr86tDz8gHNmxA64nJGZImiM0X4EHbliG4peVTZ3eGqbR9joj9BgOXyb4VUlBfBou3Dq9n1RS5dqgtQ9V2lYnA/pWmXS9EmE3I2o2eNG0ha5JnkTsV8rk0rNKuBVPOzw2JUWM9ze/cKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743286214; c=relaxed/simple;
	bh=pZpq9ghubjJLhD+JS8dYzRXBCv3CK7S4BnH8+Gq+jls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMqzwazn1/sw9/9utOImN+/lWAeWoiUSi0qyPtLDKaUaRwLmjZ0PgFGU+IoiD0D65NsxUXzrV7nk/CikErjK+FAlnM9yDN5G4hkMLJtKFh32UgkK2LOdHlbbNqdQG1Wx8IeAvwVTNJk+6BmPClTpYmxj2eMZEgnFaNocJ5RQbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=AE8ZduE3; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2117910290279;
	Sat, 29 Mar 2025 23:10:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743286209; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OfWmKzMpdhulgNMGGh3laefwHhLvWPtC8uEl5axzFsw=;
	b=AE8ZduE3XoX4GiJCzdR+S+uagY3W1crhK/9Od/0Du+QVU4y8VvoDLlYYTDV9kGoIoNpilx
	WR3M9k1vokP49/Jn1bmr8qz7R86785D0aJ3iKLhYhpS4gtcANNPMRIDso7WMGTKdMOUzX2
	eO5q4adU7YC7IFkjmcY3sMOEPGgbqou7xoIuZ03aiLgGXXaUuk6FlMNdsGUOYE0+JS9Qgj
	ncNBLIEhuz2buRy3I6eQinFMApz+GtQm1owfcp97isb/GbKyt6Dv9wIelTUU3mvWvc9H9z
	O8GLVicWGe3phK+pjb6gV6wvRPH2H+OeHpQEHAjhrxQOJKgreOGqXSy9dYmM3A==
Date: Sat, 29 Mar 2025 23:10:04 +0100
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
Message-ID: <20250329231004.4432831b@wsk>
In-Reply-To: <e6f3e50f-8d97-4dbc-9de3-1d9a137ae09c@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-2-lukma@denx.de>
	<e6f3e50f-8d97-4dbc-9de3-1d9a137ae09c@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GOaK/S/VyPuiJbaUJ6=UdAb";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/GOaK/S/VyPuiJbaUJ6=UdAb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 28/03/2025 14:35, Lukasz Majewski wrote:
> > This patch provides description of the MTIP L2 switch available in
> > some NXP's SOCs - e.g. imx287.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Rename the file to match exactly the compatible
> >   (nxp,imx287-mtip-switch) =20
>=20
> Please implement all the changes, not only the rename. I gave several
> comments, although quick glance suggests you did implement them, so
> then changelog is just incomplete.

Those comments were IMHO addressed automatically, as this time I took
(I suppose :-) ) better file as a starting point.

To be more specific it was:
./Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml

as I've been advised to use for the MTIP driver the same DTS
description as the above one has (i.e. they are conceptually similar,
so DTS description ABI can be used for both).

I've also checked the:
make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Dnxp,imx287-mtip-switch.yaml
nxp/mxs/imx28-xea.dtb

on Linux next and it gave no errors.

>=20
> > ---
> >  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 165
> > ++++++++++++++++++ 1 file changed, 165 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > new file mode 100644 index 000000000000..a3e0fe7783ec --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > @@ -0,0 +1,165 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
> > BSD-2-Clause) +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/nxp,imx287-mtip-switch.yaml#
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
> > + =20
>=20
> If this is ethernet switch, why it does not reference ethernet-switch
> schema? or dsa.yaml or dsa/ethernet-ports? I am not sure which one
> should go here, but surprising to see none.

It uses:
$ref:=C2=B7ethernet-controller.yaml#

for "ports".

Other crucial node is "mdio", which references $ref: mdio.yaml#

>=20
> > +properties:
> > +  compatible:
> > +    const: nxp,imx287-mtip--switch =20
>=20
> Just one -.
>=20

Ok.

> > +
> > +  reg:
> > +    maxItems: 1
> > +    description:
> > +      The physical base address and size of the MTIP L2 SW module
> > IO range =20
>=20
> Wasn't here, drop.
>=20

The 'reg' property (reg =3D <0x800f0000 0x20000>;) is defined in
imx28.dtsi, where the SoC generic properties (as suggested by Andrew -
like clocks, interrupts, clock-names) are moved.

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
> > +  pinctrl-names: true =20
>=20
> Drop

The 'pinctrl-names =3D "default";' are specified.

Shouldn't it be kept?

>=20
> > +
> > +  ethernet-ports:
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^port@[0-9]+$": =20
>=20
> Keep consistent quotes, either " or '. Also [01]
>=20

[12] - ports are numbered starting from 1.

>=20
> > +        type: object
> > +        description: MTIP L2 switch external ports
> > +
> > +        $ref: ethernet-controller.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          reg:
> > +            items:
> > +              - enum: [1, 2]
> > +            description: MTIP L2 switch port number
> > +
> > +          label:
> > +            description: Label associated with this port
> > +
> > +        required:
> > +          - reg
> > +          - label
> > +          - phy-mode
> > +          - phy-handle
> > +
> > +  mdio:
> > +    type: object
> > +    $ref: mdio.yaml#
> > +    unevaluatedProperties: false
> > +    description:
> > +      Specifies the mdio bus in the switch, used as a container
> > for phy nodes. +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - interrupts
> > +  - mdio
> > +  - ethernet-ports
> > +  - '#address-cells'
> > +  - '#size-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include<dt-bindings/interrupt-controller/irq.h>
> > +    switch@800f0000 {
> > +        compatible =3D "nxp,imx287-mtip-switch";
> > +        reg =3D <0x800f0000 0x20000>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&mac0_pins_a>, <&mac1_pins_a>;
> > +        phy-supply =3D <&reg_fec_3v3>;
> > +        interrupts =3D <100>, <101>, <102>;
> > +        clocks =3D <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> > +        clock-names =3D "ipg", "ahb", "enet_out", "ptp";
> > +        status =3D "okay"; =20
>=20
> Drop

Ok.

>=20
> > +
> > +        ethernet-ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>; =20
>=20
> Messed indentation. See example-schema or writing-schema.
>=20

Ok.

>=20
>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/GOaK/S/VyPuiJbaUJ6=UdAb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfob7wACgkQAR8vZIA0
zr1dnAf+K8wn68GHQnDP8Ngyr4LbkqtyX9vgW/b3tfNaPTIZkL1lMEUZ2HD2n+yv
zlFrkNAv/msNWFbZKT/+yFvX3YNPLS0gc8TV0SyMoZ6naIlto86WX8t4qv1pWi6X
38gwP4DGcCYMSALmPwyn3JH2pOnY7LuGT2GbomsOYfdn8UgjACmHJIVDWyhn/AA3
cQHdJbFC2p7J+7QFGihcig3Neoepo1vI76sProBWIw7U9dIu+ybP14y5tmBAaxpV
Urcqt7Wg43hU7HgM27muOk7XFttDbfbt408y//qjkHKdsQehjfJKpT4NKhol0oDK
baCZykor3+/dSnMz0IhemScHL+k6rw==
=IoZW
-----END PGP SIGNATURE-----

--Sig_/GOaK/S/VyPuiJbaUJ6=UdAb--


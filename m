Return-Path: <netdev+bounces-189983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CEAB4BB4
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEB217D240
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01671E9B0C;
	Tue, 13 May 2025 06:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XgIlxJAC"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F7B145B25;
	Tue, 13 May 2025 06:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747116569; cv=none; b=mhNwdGK0KpCdfArHh7T6WOJI3V3QvF6TnB8ftAYFF3hisVzwTtw0XT9D9BQ6ecK52oNzBp9ILo3ChG0bUE2ksyK/lcRd80lPAgU4/fLHIt62emc0uwFXxx/pv2Ll/m95jIYnZFMrWBPlbmYyqpZUi5UzbUBfJ1m6WqE0H5eUwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747116569; c=relaxed/simple;
	bh=sFh2ICeB4mznTP4Bfry/I+dPTE8ZXXQmZmNZVTM9oeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LU9cX5svjxm/T3/yYN8HmQ8xeo4+FeCFfkLgTx/J5N5pqfOKadt96u9IRxqlLGWMmpciF2rsS4pn4KtoUED/F1gjnuRFI0oWnYX7P7cpblOMw2h2B3+7NL9357hVWJSlV+fItrFFOawI+GK0jYLp+elnVYhqNy2w1SOdqKuQnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XgIlxJAC; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B21DD101F54F9;
	Tue, 13 May 2025 08:09:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747116564; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=MncshJ1N3nQkNK52N5FTaCdNEcC11NmMuRNRJmKFpY8=;
	b=XgIlxJACCVW018Pi0FgvOmE3ybj/A0gfvBO5sbPbBVtV3RlD3DCEvISmFRHrg/u5mfvWxp
	R8GDDioBVq6Kl3fcH9G/gZr1OlsvkjkMW95Zx9T4EGjHq34AXnR8ES0uOpOMk8z3QYpk0/
	YmNPkIUkcdgsm2NTbRLDju8qDA5pWD6XJLiTR/efIjqFkzF+b3QK3blk3pQI45EZTucwii
	nAjwYFmkVTQSwZZEcWiIjhaDT2a1u4UZOcxeIbfnLQaFSBl/M9n4hH6pJ5BL/Pop36cEcX
	cJvh/pjNbllhD77gopHErZZGvDRcV8fLoPYogdLlgC3OboQb3AoijmoY85J55g==
Date: Tue, 13 May 2025 08:09:20 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v11 1/7] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250513080920.7c8a2a06@wsk>
In-Reply-To: <20250512164025.GA3454904-robh@kernel.org>
References: <20250504145538.3881294-1-lukma@denx.de>
	<20250504145538.3881294-2-lukma@denx.de>
	<20250512164025.GA3454904-robh@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/szb2u=yuhhNpm=y0AkbX6Qf";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/szb2u=yuhhNpm=y0AkbX6Qf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Sun, May 04, 2025 at 04:55:32PM +0200, Lukasz Majewski wrote:
> > This patch provides description of the MTIP L2 switch available in
> > some NXP's SOCs - e.g. imx287.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
> >=20
> > ---
> > Changes for v2:
> > - Rename the file to match exactly the compatible
> >   (nxp,imx287-mtip-switch)
> >=20
> > Changes for v3:
> > - Remove '-' from const:'nxp,imx287-mtip-switch'
> > - Use '^port@[12]+$' for port patternProperties
> > - Drop status =3D "okay";
> > - Provide proper indentation for 'example' binding (replace 8
> >   spaces with 4 spaces)
> > - Remove smsc,disable-energy-detect; property
> > - Remove interrupt-parent and interrupts properties as not required
> > - Remove #address-cells and #size-cells from required properties
> > check
> > - remove description from reg:
> > - Add $ref: ethernet-switch.yaml#
> >=20
> > Changes for v4:
> > - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove
> > already referenced properties
> > - Rename file to nxp,imx28-mtip-switch.yaml
> >=20
> > Changes for v5:
> > - Provide proper description for 'ethernet-port' node
> >=20
> > Changes for v6:
> > - Proper usage of
> >   $ref: ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties
> >   when specifying the 'ethernet-ports' property
> > - Add description and check for interrupt-names property
> >=20
> > Changes for v7:
> > - Change switch interrupt name from 'mtipl2sw' to 'enet_switch'
> >=20
> > Changes for v8:
> > - None
> >=20
> > Changes for v9:
> > - Add GPIO_ACTIVE_LOW to reset-gpios mdio phandle
> >=20
> > Changes for v10:
> > - None
> >=20
> > Changes for v11:
> > - None
> > ---
> >  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 149
> > ++++++++++++++++++ 1 file changed, 149 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > new file mode 100644 index 000000000000..35f1fe268de7 --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > @@ -0,0 +1,149 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
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
> > +      - const: enet_switch
> > +      - const: enet0
> > +      - const: enet1
> > +
> > +  pinctrl-names: true
> > +
> > +  ethernet-ports:
> > +    type: object
> > +    $ref:
> > ethernet-switch.yaml#/$defs/ethernet-ports/patternProperties =20
>=20
> 'patternProperties' is wrong. Drop.
>=20

When I do drop it, then
make dt_binding_check DT_SCHEMA_FILES=3Dnxp,imx28-mtip-switch.yaml

shows:

nxp,imx28-mtip-switch.example.dtb: switch@800f0000: ethernet-ports:
'oneOf' conditional failed, one must be fixed:

'ports' is a required property=20
'ethernet-ports' is a required property
        from schema $id:
        http://devicetree.org/schemas/net/nxp,imx28-mtip-switch.yaml#

We do have ethernet-ports:
and we do "include" ($ref)
https://elixir.bootlin.com/linux/v6.14.6/source/Documentation/devicetree/bi=
ndings/net/ethernet-switch.yaml#L77

which is what we exactly need.

> > +    additionalProperties: true =20
>=20
> Drop.
>=20

When removed we do have:
nxp,imx28-mtip-switch.example.dtb: switch@800f0000: Unevaluated
properties are not allowed ('ethernet-ports' was unexpected)

or=20

nxp,imx28-mtip-switch.yaml: ethernet-ports: Missing
additionalProperties/unevaluatedProperties constraint

Depending if I do remove 'patternProperties' above.

To sum up - with the current code, the DT schema checks pass. It also
looks like the $ref for ethernet-switch is used in an optimal way.

I would opt for keeping the code as is for v12.

> > +
> > +    patternProperties:
> > +      '^ethernet-port@[12]$':
> > +        type: object
> > +        additionalProperties: true
> > +        properties:
> > +          reg:
> > +            items:
> > +              - enum: [1, 2]
> > +            description: MTIP L2 switch port number
> > +
> > +        required:
> > +          - reg
> > +          - label =20
>=20
> 'label' shouldn't ever be required because s/w shouldn't care what
> the value is.

Ok, I will remove it for v12.

>=20
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
> > +  - interrupt-names
> > +  - mdio
> > +  - ethernet-ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include<dt-bindings/interrupt-controller/irq.h>
> > +    #include<dt-bindings/gpio/gpio.h>
> > +    switch@800f0000 {
> > +        compatible =3D "nxp,imx28-mtip-switch";
> > +        reg =3D <0x800f0000 0x20000>;
> > +        pinctrl-names =3D "default";
> > +        pinctrl-0 =3D <&mac0_pins_a>, <&mac1_pins_a>;
> > +        phy-supply =3D <&reg_fec_3v3>;
> > +        interrupts =3D <100>, <101>, <102>;
> > +        interrupt-names =3D "enet_switch", "enet0", "enet1";
> > +        clocks =3D <&clks 57>, <&clks 57>, <&clks 64>, <&clks 35>;
> > +        clock-names =3D "ipg", "ahb", "enet_out", "ptp";
> > +
> > +        ethernet-ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            mtip_port1: ethernet-port@1 {
> > +                reg =3D <1>;
> > +                label =3D "lan0";
> > +                local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +                phy-mode =3D "rmii";
> > +                phy-handle =3D <&ethphy0>;
> > +            };
> > +
> > +            mtip_port2: ethernet-port@2 {
> > +                reg =3D <2>;
> > +                label =3D "lan1";
> > +                local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +                phy-mode =3D "rmii";
> > +                phy-handle =3D <&ethphy1>;
> > +            };
> > +        };
> > +
> > +        mdio_sw: mdio {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            reset-gpios =3D <&gpio2 13 GPIO_ACTIVE_LOW>;
> > +            reset-delay-us =3D <25000>;
> > +            reset-post-delay-us =3D <10000>;
> > +
> > +            ethphy0: ethernet-phy@0 {
> > +                reg =3D <0>;
> > +            };
> > +
> > +            ethphy1: ethernet-phy@1 {
> > +                reg =3D <1>;
> > +            };
> > +        };
> > +    };
> > --=20
> > 2.39.5
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/szb2u=yuhhNpm=y0AkbX6Qf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgi4hAACgkQAR8vZIA0
zr2PiQf/cfG3+ozsR1UCw0lSG/JLHOpz0LUFMjubElolzz4TEfNW4ErqdBptFyNQ
rna1NkbRl3YTxViqoBnYVyOrR3lAN25+rPAieJdWZYeKc4BOTkXVh5faZHGTQlPX
IIHNuHnoLny6vJ8Qod38+mMiQL5LYMVVmNhq5PwxuqfTswcrEKaGp7o9AgTUL0CE
zTzV2ah6nKRuOPTCOzpo2MJCFd0FxebpgqCHxvusVUyi+uzpy6Jl7sCHdN5Rlpb9
9tETECoKMAxFLpoVePSYKRLdpdYJDUeSHwU1jZrm3eANglKtstNLyelNBr5MvBeQ
0iT8FnR49zccvtTNAq2duXAbBUVbIw==
=Cvzg
-----END PGP SIGNATURE-----

--Sig_/szb2u=yuhhNpm=y0AkbX6Qf--


Return-Path: <netdev+bounces-178559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3AA778E8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A8D7A2AF6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916A51F12F6;
	Tue,  1 Apr 2025 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Tprvait7"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFA1F09B6;
	Tue,  1 Apr 2025 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743503723; cv=none; b=H1U61Ig+lf60V5h/TDoM0JhNxm0NlZcA6xcQyc7Rc9fKLAJSYdXLh2tmS6w+XcxxmsjA8NQTGB+npPmQ8YjMGjhjGWj+Z0whn1uWw5uvmGP/TdffMAQTsFEFF60u8yN9z0kQmJSKFLkPtjd5TufP/wA7b/fYyRE1Ce+K5RDsf64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743503723; c=relaxed/simple;
	bh=v9kSnKkZYZ8WOxxdEDKtjf+iuECm/3V8MlhXkQVOj30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNLgt1YIS2TSf3jkMFXTP+vg+4/4UZ9kbkONPQRqImHsCdWkOqg0RhPoUtne2MCqvBpYNaByTZyjBJUEq2d4yK/1sakdd83f3+0nCXwJy8D0nB0v4lyeC2TRt4GjPh1RIUExBBV2Hr9h6yZHLDJHCE1VJYF33KL7c4S91b7mLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Tprvait7; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C57C101CA6E8;
	Tue,  1 Apr 2025 12:35:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743503712; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=s7Poqe3mZVIgpU2JGC2x8jHFSjWgHlNoBHPst74G6xY=;
	b=Tprvait7ezlgUnAVteDKrKb1PEx6byXSrNXb/HiG066infjz5H+UTJvCI6zLh9XeLH6MKU
	MxkqTmCR6QkesCm39uIpLj4kXiXIH56ZhgtIsLMfHMDmI+28XrcmloOb9g2XzhJqnPNB66
	WtXO/aqYSH8geX9cjsFOO1M6bbUn2lQYwNNWVud73LoU4hDW071gPsXenQRGv00jDZ6Kxl
	eS/K1EqL162DFt++crqpY+cKc+lxs3ZB13GzUXpqlw/sMHEBMMWUwMq3m/uT2ZnYXlRkfL
	WcmLG0/LhqHwh3iY7bgZr6pSCQWXGCctRUcx0i2Am6uMrzLULMijb5gL0lYoUA==
Date: Tue, 1 Apr 2025 12:35:07 +0200
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
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250401123507.2e3bf0a6@wsk>
In-Reply-To: <20250331235518.GA2823373-robh@kernel.org>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331103116.2223899-2-lukma@denx.de>
	<20250331235518.GA2823373-robh@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RWGAJJQc9ifwwn2SMI2BeSX";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/RWGAJJQc9ifwwn2SMI2BeSX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Mon, Mar 31, 2025 at 12:31:13PM +0200, Lukasz Majewski wrote:
> > This patch provides description of the MTIP L2 switch available in
> > some NXP's SOCs - e.g. imx287.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
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
> > ---
> >  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 154
> > ++++++++++++++++++ 1 file changed, 154 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > new file mode 100644 index 000000000000..98eba3665f32 --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > @@ -0,0 +1,154 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
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
> > +
> > +$ref: ethernet-switch.yaml# =20
>=20
> This needs to be: ethernet-switch.yaml#/$defs/ethernet-ports
>=20
> With that, you can drop much of the below part. More below...
>=20
> > +
> > +properties:

So it shall be after the "properties:"

$ref: ethernet-switch.yaml#/$defs/ethernet-ports   [*]


> > +  compatible:
> > +    const: nxp,imx287-mtip-switch
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
> > +  pinctrl-names: true
> > + =20
>=20
> > +  ethernet-ports:

And then this "node" can be removed as it has been referenced above [*]?

(I shall only keep the properties, which are not standard to [*] if
any).

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
> > +      '^port@[12]+$': =20
>=20
> Note that 'ethernet-port' is the preferred node name though 'port' is=20
> allowed.

Ok. That would be the correct define:

ethernet-ports {
     mtip_port1: ethernet-port@1 {
               reg =3D <1>;
               label =3D "lan0";
               local-mac-address =3D [ 00 00 00 00 00 00 ];
               phy-mode =3D "rmii";
               phy-handle =3D <&ethphy0>;
	       };

               mtip_port2: port@2 {
		....
	       };

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
> > +          - phy-handle =20
>=20
> All the above under 'ethernet-ports' can be dropped though you might=20
> want to keep 'required' part.

Ok, I will keep it.

>=20
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
> > +
> > +        ethernet-ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            mtip_port1: port@1 {
> > +                reg =3D <1>;
> > +                label =3D "lan0";
> > +                local-mac-address =3D [ 00 00 00 00 00 00 ];
> > +                phy-mode =3D "rmii";
> > +                phy-handle =3D <&ethphy0>;
> > +            };
> > +
> > +            mtip_port2: port@2 {
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
> > +            reset-gpios =3D <&gpio2 13 0>;
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

Thanks for the hint.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/RWGAJJQc9ifwwn2SMI2BeSX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfrwVsACgkQAR8vZIA0
zr24oQf/anBJOGl0tWgnq6LRJxzQ6T2tFRMS9KaTl/Yl6SF0MpjdSH1Wjw4HV+oV
gfTYtA1SQiOTdgGUq4oM8BTfLLxjLpD12kjIOAEY4ObVyfkYCtTFjyA5S+NA80Zs
tcAyZZa9TVHculFJliwKPe6/XuAPXLwdPMb63tQrokVOi4XmKBO/PC1i6mpRONei
y+aBVCE3+j+CiqVkK9ZEwKpI3FWfcODNbAQQ+tXQoKSvrsFLlr9xUMqUZnR2vr0V
+qdkD74tQDFVoEOd9BQCUP0sacxP9+pS4sIjRgq8t4gJv0W59RxNKssq8RgWN10t
GEICbrn8XIbQCF2SyxmkwxbNAym54g==
=siSa
-----END PGP SIGNATURE-----

--Sig_/RWGAJJQc9ifwwn2SMI2BeSX--


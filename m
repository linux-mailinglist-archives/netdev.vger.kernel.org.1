Return-Path: <netdev+bounces-181598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D8A85A3B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 12:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E8C7A8C77
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078029AAEC;
	Fri, 11 Apr 2025 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="LsUrmkQg"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0836238C30;
	Fri, 11 Apr 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367834; cv=none; b=XMeErHhQgc4F2PtuhED8AKOOZrcSQe/avfrAsEzsX5k8ksYYTu7Z1SBdGp7PzqHOyzWqnbafl47t8zslzKQ9wDgW/s1I9/RRAvASIl0Jy/NgoM8UoHHqP48lUTDPJVQK16Ua5lkr5uaQvBz0zFeF4uFwvOPbTewz5bFRONFRjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367834; c=relaxed/simple;
	bh=pUIml0VjgQvYLw/I3MbZxyiPLU4wyR56Bp7cCG0fmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d5nJ3FcLzgwBdUbA0rXciNvICT+AAKWc5IJAshebJ+EmDhg+sfK+RO7LOpfdzt1KhFpyC+ATJDFD7aFMULeXALmazAOYeLBSYjriNZdDy0zvX/dyjrpQBXUnGXxoXplTDodjLAuhcphp27uP/Ck5SAfrkDdSCbEI+ISMDFYZq5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=LsUrmkQg; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D95BB1026A388;
	Fri, 11 Apr 2025 12:36:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744367822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=mLnLOSlhtLpb0tEj9yUCdGtla2q99b0iozFagK1gjew=;
	b=LsUrmkQgXZOdDCNfeN/NeVHoVZ8ajgk/cioXWtuc1GDsAA0Gswyux/NCtO+KjxeztTBUTp
	DRq78JIC4lPqHo49PB4IkJhcNVm4zqiCwKCEC3n4k5hnt6KQc2pW+Elmh1Jkr4q/aSVe6+
	TnSLD2c3pgMb2RfTqr1ZpSIStYFOazbkq8KzMReZKPlZ9jOtmVWIn66I8ryxpS8DYl3or2
	L9JV3M7EO+ATnGihFUMOPA5NOXbeWf+8diAyRn+oV5LTxUXWf8rLdOgp53qYD4pAcv0rrV
	441Fw4+7K4vhbx+9f3HoLroYjtnoWnejBWT6qOKWfGOMU5pp1Z6YU9HVQ2VVEA==
Date: Fri, 11 Apr 2025 12:36:54 +0200
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
 <wahrenst@gmx.net>
Subject: Re: [net-next v4 1/5] dt-bindings: net: Add MTIP L2 switch
 description
Message-ID: <20250411123654.04cfff4a@wsk>
In-Reply-To: <20250410205925.GA1041840-robh@kernel.org>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-2-lukma@denx.de>
	<20250410205925.GA1041840-robh@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pHINZLvXGmujDrt1h/8BuJ7";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/pHINZLvXGmujDrt1h/8BuJ7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Mon, Apr 07, 2025 at 04:51:53PM +0200, Lukasz Majewski wrote:
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
> >=20
> > Changes for v4:
> > - Use $ref: ethernet-switch.yaml#/$defs/ethernet-ports and remove
> > already referenced properties
> > - Rename file to nxp,imx28-mtip-switch.yaml
> > ---
> >  .../bindings/net/nxp,imx28-mtip-switch.yaml   | 126
> > ++++++++++++++++++ 1 file changed, 126 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > new file mode 100644 index 000000000000..1afaf8029725 --- /dev/null
> > +++
> > b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
> > @@ -0,0 +1,126 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
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
> > + =20
>=20
> > +patternProperties:
> > +  "^(ethernet-)?ports$": =20
>=20
> New bindings should only use 'ethernet-ports'.

Ok.

>=20
> > +    type: object
> > +    additionalProperties: true =20
>=20
> But what's this for? I thought you had some constrants for phy-mode
> and phy-handle?
>=20

I've prepared following changes:

--- a/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
@@ -17,11 +17,6 @@ description:
=20
 $ref: ethernet-switch.yaml#/$defs/ethernet-ports
=20
-patternProperties:
-  "^(ethernet-)?ports$":
-    type: object
-    additionalProperties: true
-
 properties:
   compatible:
     const: nxp,imx28-mtip-switch
@@ -55,6 +50,26 @@ properties:
=20
   pinctrl-names: true
=20
+  ethernet-ports:
+    type: object
+    additionalProperties: true
+    properties:
+      ethernet-port:
+        type: object
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            items:
+              - enum: [1, 2]
+            description: MTIP L2 switch port number
+
+        required:
+          - reg
+          - label
+          - phy-mode
+          - phy-handle
+
   mdio:
     type: object
     $ref: mdio.yaml#
@@ -71,7 +86,7 @@ required:
   - mdio
   - ethernet-ports
=20
-additionalProperties: false
+unevaluatedProperties: false
=20
 examples:

To be applied on top of this patch. It takes into account the
"required:" for 'ethernet-port' and also reuses the=20
$ref: ethernet-switch.yaml#/$defs/ethernet-ports

Last, but not least:
make dt_binding_check DT_SCHEMA_FILES=3Dnxp,imx28-mtip-switch.yaml
make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Dnxp,imx28-mtip-switch.yaml
nxp/mxs/imx28-xea.dtb

show no errors.


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
> > +  pinctrl-names: true
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
> > +additionalProperties: false =20
>=20
> unevaluatedProperties: false

Ok.

>=20
> > +
> > +examples:
> > +  - |
> > +    #include<dt-bindings/interrupt-controller/irq.h>
> > +    switch@800f0000 {
> > +        compatible =3D "nxp,imx28-mtip-switch";
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


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/pHINZLvXGmujDrt1h/8BuJ7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf48MYACgkQAR8vZIA0
zr3LEwf4oZ8G6avjAzXGZNtwQoJnqXaGrxBTt50eP6lxNSRlA1NWE7Ey+52LI5MD
eD1tWPzQYjrIprD5a2n7GL9ot7s46olO+T4Qzm5wWiBfmUyL+I4TsUCIHgKZb1fd
sCv8dbYQCHkc8I5um7WEVf/ubo6dBoViXhGbOc4JB7Z7Jm0/TbgOOPSeuusx36md
ffp1o2r0Dh3tfqQUBcvovTUHUDiqctNTV5OWbZbFWronzVBOPyK5AktCcZ9NhPNm
rD9wZK/KSL8ZjJEE89DzprcKbvKgRNr3a5JFau64elrGBlDcByjqGWI1EFiNpN+W
6D2ltGdLv7kIjmfwwsP2A430ye3J
=5i4m
-----END PGP SIGNATURE-----

--Sig_/pHINZLvXGmujDrt1h/8BuJ7--


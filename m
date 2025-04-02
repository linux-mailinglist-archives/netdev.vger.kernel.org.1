Return-Path: <netdev+bounces-178746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A72A78AB2
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387697A3AD6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 09:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BDF23534A;
	Wed,  2 Apr 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CqkqJPFc"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8C233129;
	Wed,  2 Apr 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584952; cv=none; b=HsMFzuGLWC+CUO5UrGc6G32Cb/7Of7YZ69pAaET1bfjoW8EfbfBy2ADAHOpbYobghqvNqMXinTCRG1RZv06EJ+G8bEaz2lInxQfc35KiR8ocwYtSJaCfR7Gba5uxdOnHCg98gJjhEgRsp1DWoAYTKuqx41oBIDOhhiGWiA2f1hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584952; c=relaxed/simple;
	bh=l9yAr0wAEJgeNm6nW7xi8ljAC/OGlVK+n3Mp4tG6MWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgqJuTA5e6q2GUVEYTzq+tkMVjebTSGkQKwoICCkD59KOYY4Zo9zUcYwgbNdW9sRM1N2UU4yZDcLrHTUx7arAebWKBcvS0uyJeAnie8LjdGFaqtRke6STEGrjIwoiU71blSLETjcRaMuzzyyD1mZ4RlRXOj3BE4/E01gSGEwX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CqkqJPFc; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41F29102780A3;
	Wed,  2 Apr 2025 11:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743584947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=HCl71+B/mWDteASs/fx+ejiotd32rdy+bdrr9fbBE6E=;
	b=CqkqJPFcH1TcNaBCn2t6uGeAIdCw2h1slnVMqXrmW/JT7ppsePNm2Vx3Q2fLQ7nvPxArQ+
	J1K5fTD3ipeu1yjmqhLq0RRyvx7shceWlUM1p+ib55UYqtU2i/kqpILONhteDluRPFdrYI
	JDIye+0JirnA0n1JJfFIhZkOXMWfI6dS9lTDkYxilQtHqHo2dATH/kBIPgczgkR+b0DoNu
	eWqx7dqwKSpEhbOHAPM6aW7JvYsMK/chP/8Y5BoulEJCYTd+jI6yKtW37M3REMvtaxrC8d
	ccoh8qVabatxQ/hZhOQvuwZPRPG1yf9BSSkSIClM8Xasovt/AFmIFnKWOeR8Zw==
Date: Wed, 2 Apr 2025 11:09:00 +0200
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
Message-ID: <20250402110900.6141cc1b@wsk>
In-Reply-To: <20250401230346.GA28557-robh@kernel.org>
References: <20250331103116.2223899-1-lukma@denx.de>
	<20250331103116.2223899-2-lukma@denx.de>
	<20250331235518.GA2823373-robh@kernel.org>
	<20250401123507.2e3bf0a6@wsk>
	<20250401230346.GA28557-robh@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0sOa=FWTe.Vb=8T9Ymlk/qv";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/0sOa=FWTe.Vb=8T9Ymlk/qv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 18:03:46 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, Apr 01, 2025 at 12:35:07PM +0200, Lukasz Majewski wrote:
> > Hi Rob,
> >  =20
> > > On Mon, Mar 31, 2025 at 12:31:13PM +0200, Lukasz Majewski wrote: =20
> > > > This patch provides description of the MTIP L2 switch available
> > > > in some NXP's SOCs - e.g. imx287.
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > > Changes for v2:
> > > > - Rename the file to match exactly the compatible
> > > >   (nxp,imx287-mtip-switch)
> > > >=20
> > > > Changes for v3:
> > > > - Remove '-' from const:'nxp,imx287-mtip-switch'
> > > > - Use '^port@[12]+$' for port patternProperties
> > > > - Drop status =3D "okay";
> > > > - Provide proper indentation for 'example' binding (replace 8
> > > >   spaces with 4 spaces)
> > > > - Remove smsc,disable-energy-detect; property
> > > > - Remove interrupt-parent and interrupts properties as not
> > > > required
> > > > - Remove #address-cells and #size-cells from required properties
> > > > check
> > > > - remove description from reg:
> > > > - Add $ref: ethernet-switch.yaml#
> > > > ---
> > > >  .../bindings/net/nxp,imx287-mtip-switch.yaml  | 154
> > > > ++++++++++++++++++ 1 file changed, 154 insertions(+)
> > > >  create mode 100644
> > > > Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > > new file mode 100644 index 000000000000..98eba3665f32 ---
> > > > /dev/null +++
> > > > b/Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
> > > > @@ -0,0 +1,154 @@ +# SPDX-License-Identifier: (GPL-2.0-only OR
> > > > BSD-2-Clause) +%YAML 1.2
> > > > +---
> > > > +$id:
> > > > http://devicetree.org/schemas/net/nxp,imx287-mtip-switch.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml# +
> > > > +title: NXP SoC Ethernet Switch Controller (L2 MoreThanIP
> > > > switch) +
> > > > +maintainers:
> > > > +  - Lukasz Majewski <lukma@denx.de>
> > > > +
> > > > +description:
> > > > +  The 2-port switch ethernet subsystem provides ethernet packet
> > > > (L2)
> > > > +  communication and can be configured as an ethernet switch. It
> > > > provides the
> > > > +  reduced media independent interface (RMII), the management
> > > > data input
> > > > +  output (MDIO) for physical layer device (PHY) management.
> > > > +
> > > > +$ref: ethernet-switch.yaml#   =20
> > >=20
> > > This needs to be: ethernet-switch.yaml#/$defs/ethernet-ports
> > >=20
> > > With that, you can drop much of the below part. More below...
> > >  =20
> > > > +
> > > > +properties: =20
> >=20
> > So it shall be after the "properties:"
> >=20
> > $ref: ethernet-switch.yaml#/$defs/ethernet-ports   [*] =20
>=20
> It can stay where it is, just add "/$defs/ethernet-ports"
>=20
>=20
> > > > +  compatible:
> > > > +    const: nxp,imx287-mtip-switch
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  phy-supply:
> > > > +    description:
> > > > +      Regulator that powers Ethernet PHYs.
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Register accessing clock
> > > > +      - description: Bus access clock
> > > > +      - description: Output clock for external device - e.g.
> > > > PHY source clock
> > > > +      - description: IEEE1588 timer clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: ipg
> > > > +      - const: ahb
> > > > +      - const: enet_out
> > > > +      - const: ptp
> > > > +
> > > > +  interrupts:
> > > > +    items:
> > > > +      - description: Switch interrupt
> > > > +      - description: ENET0 interrupt
> > > > +      - description: ENET1 interrupt
> > > > +
> > > > +  pinctrl-names: true
> > > > +   =20
> > >  =20
> > > > +  ethernet-ports: =20
> >=20
> > And then this "node" can be removed as it has been referenced above
> > [*]? =20
>=20
> Well, you have to keep it to have 'required' in the child nodes.
>=20
> >=20
> > (I shall only keep the properties, which are not standard to [*] if
> > any).
> >  =20
> > > > +    type: object
> > > > +    additionalProperties: false
> > > > +
> > > > +    properties:
> > > > +      '#address-cells':
> > > > +        const: 1
> > > > +      '#size-cells':
> > > > +        const: 0
> > > > +
> > > > +    patternProperties:
> > > > +      '^port@[12]+$':   =20
> > >=20
> > > Note that 'ethernet-port' is the preferred node name though
> > > 'port' is allowed. =20
> >=20
> > Ok. That would be the correct define:
> >=20
> > ethernet-ports {
> >      mtip_port1: ethernet-port@1 {
> >                reg =3D <1>;
> >                label =3D "lan0";
> >                local-mac-address =3D [ 00 00 00 00 00 00 ];
> >                phy-mode =3D "rmii";
> >                phy-handle =3D <&ethphy0>;
> > 	       };
> >=20
> >                mtip_port2: port@2 { =20
>=20
> And here...
>=20
> > 		....
> > 	       };
> >  =20
> > >  =20
> > > > +        type: object
> > > > +        description: MTIP L2 switch external ports
> > > > +
> > > > +        $ref: ethernet-controller.yaml#
> > > > +        unevaluatedProperties: false
> > > > +
> > > > +        properties:
> > > > +          reg:
> > > > +            items:
> > > > +              - enum: [1, 2]
> > > > +            description: MTIP L2 switch port number
> > > > +
> > > > +          label:
> > > > +            description: Label associated with this port
> > > > +
> > > > +        required:
> > > > +          - reg
> > > > +          - label
> > > > +          - phy-mode
> > > > +          - phy-handle   =20
> > >=20
> > > All the above under 'ethernet-ports' can be dropped though you
> > > might want to keep 'required' part. =20
> >=20
> > Ok, I will keep it. =20
>=20
> So I think you just want this:
>=20
> ethernet-ports:
>   type: object
>   additionalProperties: true  # Check if you need this
>=20
>   patternProperties:
>     '^ethernet-port@[12]$':
>       required:
>         - label
>         - phy-mode
>         - phy-handle
>=20

I had to add:

$ref: ethernet-switch.yaml#/$defs/ethernet-ports
patternProperties:
  "^(ethernet-)?ports$":
    type: object
    additionalProperties: true

after the=20
description:

to avoid issues when checking DT schema.

Simple adding=20

   patternProperties:
     '^ethernet-port@[12]$':
       required:
         - label
         - phy-mode
         - phy-handle

Causes more errors.

> Rob




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/0sOa=FWTe.Vb=8T9Ymlk/qv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfs/qwACgkQAR8vZIA0
zr086wgA5Jn0IbIaaEpVjBvcYY2ArHgPvw/BZFmTl1ybvb3477EmZI1iEIn1UHyW
qMO4jx5mlSoR9QkP/GfI9DE99ySe+EQgqSqPqcY79JPlqq6WeT578E9NBqLO7YT5
h59WwQShvBR4np37X5r26HtcdP8CXEWYUFITteTqh+EYiXDKPeXi4e6KiGmcJAuJ
jT4riux80AJ4ImCRjnj9S/pv3ODm6Q//Rd9DKse/k/RPUKRrqCM9MvLval02tdzV
SD+MsepkMI+j/NXayLHABP++2Lcl3lNNW3fnAGKckvqdGBPmIRlS4MnqN+PzAprB
tkiD4bkrDW3Eu65fMpIQtsnOT47bkA==
=9mZL
-----END PGP SIGNATURE-----

--Sig_/0sOa=FWTe.Vb=8T9Ymlk/qv--


Return-Path: <netdev+bounces-110002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17FC92AA70
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C6E283014
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCC013FD84;
	Mon,  8 Jul 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBdzbztE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278CB22EE5;
	Mon,  8 Jul 2024 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470013; cv=none; b=oKrBuIAs+rSaAWwJKm+blc2CFoLYDh0BNDZkXk8BQnSy4LfAGPgbVloox/HERoVLcQPRc/Xyz7dR/WmYrI/S+QCdp7/eGlCOjm3pEvgfn7gChf4k6EZmJ2CeRCUh5SmoUp9CYl4k1cJuN/aUjUDMixHrtCRh9yVdOtbUvKJlHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470013; c=relaxed/simple;
	bh=HV7Lg9GbWEI37XJ0m+ZmO1viWZb9/nqYpYNMp00Qlqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njcJDB0dxllRnyGOP/z3FHILSxm7kn03YrkOatRsX3qIOLdrPTtTL/2w+XjOXVpAiBWVF8KVl+Q/ISszzip8iUnml4FAwxNBPhJasdLMh15/5EgU4sane8Fu03CdOKvaGJT9j/qPoX1IYqDiJElGas74rQayd5+smC/5gp89NiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBdzbztE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946C4C3277B;
	Mon,  8 Jul 2024 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470012;
	bh=HV7Lg9GbWEI37XJ0m+ZmO1viWZb9/nqYpYNMp00Qlqo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EBdzbztEDWcHWv/SScy1izQ3j9DC7qBnoVH22iaX2xcdtbRkisVURD+n1YFZtEp38
	 vNf6hzO+66a/npWyEjvVcq7Mxt6QYZnn277R8jkhDAPrX5cE2lKctsyFhMuUzUYY3s
	 hndh6iEgyWHAhtyBaFMiaWgzZotRXlotWlZ9yyYBJl6S5KYxu0zPPWG2kmP7s9HH/b
	 gIei3JxdXpdKM449gUQXIrfVxl83r+DRr+7v4+H0rQ7kLsHODKX6vrwKu7fcmOxvwd
	 HYxDyun1JGHOiUUD3jjbUay42W+YwLKCXpduPKNjHYpK5isiFz9H6+dNWbMQJicvxC
	 1RmA1PKE6SlmA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso4057547e87.1;
        Mon, 08 Jul 2024 13:20:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXzp+br6EuJ0zfDXnIN4dWpFFV2vsBGQj9p9E2kv10gAPWlSmul2Rf+Ue3miFXGdEGmfu6NHSmW3Mbe2gmZK+L6D7aSbk7hIYOCLg==
X-Gm-Message-State: AOJu0Yy769ges7XcphrS/Ox65mYwbCVYLihuZEwDFdo2kLm7/btuakqe
	uCyEAl3DBKBipCUV0WHcPDWcK/GFbGyW1bu+d0E6vW9CAnz7t1s/svi/2U0aANn1FBamNTVmidw
	/XDayrXb9+d6bw/ml8+sHvTj2yg==
X-Google-Smtp-Source: AGHT+IFVl01xaDQRc/ZGGwO0nRmj0AkMhV3V9/1s4uqWiHEvLP14i75vJYAI6A71wUIiMc4ww5euuIkcTMelg39BuRg=
X-Received: by 2002:a05:6512:3e0c:b0:52e:9c0a:3522 with SMTP id
 2adb3069b0e04-52eb99d1694mr226752e87.44.1720470010939; Mon, 08 Jul 2024
 13:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720079772.git.lorenzo@kernel.org> <48dde2595c6ff497a846183b117ac9704537b78c.1720079772.git.lorenzo@kernel.org>
 <20240708163708.GA3371750-robh@kernel.org> <Zowb18jXTOw5L2aT@lore-desk>
In-Reply-To: <Zowb18jXTOw5L2aT@lore-desk>
From: Rob Herring <robh@kernel.org>
Date: Mon, 8 Jul 2024 14:19:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>
Message-ID: <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	upstream@airoha.com, angelogioacchino.delregno@collabora.com, 
	benjamin.larsson@genexis.eu, rkannoth@marvell.com, sgoutham@marvell.com, 
	andrew@lunn.ch, arnd@arndb.de, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 11:03=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.or=
g> wrote:
>
> > On Thu, Jul 04, 2024 at 10:08:10AM +0200, Lorenzo Bianconi wrote:
> > > Introduce device-tree binding documentation for Airoha EN7581 etherne=
t
> > > mac controller.
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  .../bindings/net/airoha,en7581-eth.yaml       | 146 ++++++++++++++++=
++
> > >  1 file changed, 146 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en75=
81-eth.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.=
yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > new file mode 100644
> > > index 000000000000..f4b1f8afddd0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > @@ -0,0 +1,146 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha EN7581 Frame Engine Ethernet controller
> > > +
> > > +allOf:
> > > +  - $ref: ethernet-controller.yaml#
> >
> > Again, to rephrase, what are you using from this binding? It does not
> > make sense for the parent and child both to use it.
>
> Below I reported the ethernet dts node I am using (I have not posted the =
dts
> changes yet):

What happens when you remove this $ref? Nothing, because you use 0
properties from it. If none of the properties apply, then don't
reference it. It is that simple.

>
> eth0: ethernet@1fb50000 {
>         compatible =3D "airoha,en7581-eth";
>         reg =3D <0 0x1fb50000 0 0x2600>,
>               <0 0x1fb54000 0 0x2000>,
>               <0 0x1fb56000 0 0x2000>;
>         reg-names =3D "fe", "qdma0", "qdma1";
>
>         resets =3D <&scuclk EN7581_FE_RST>,
>                  <&scuclk EN7581_FE_PDMA_RST>,
>                  <&scuclk EN7581_FE_QDMA_RST>,
>                  <&scuclk EN7581_XSI_MAC_RST>,
>                  <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
>                  <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
>                  <&scuclk EN7581_HSI_MAC_RST>,
>                  <&scuclk EN7581_XFP_MAC_RST>;
>         reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
>                       "hsi0-mac", "hsi1-mac", "hsi-mac",
>                       "xfp-mac";
>
>         interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
>                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>
>         status =3D "disabled";
>
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>
>         gdm1: mac@1 {
>                 compatible =3D "airoha,eth-mac";
>                 reg =3D <1>;
>                 phy-mode =3D "internal";
>                 status =3D "disabled";
>
>                 fixed-link {
>                         speed =3D <1000>;
>                         full-duplex;
>                         pause;
>                 };
>         };
> };
>
> I am using phy related binding for gdm1:mac@1 node.

Right, so you should reference ethernet-controller.yaml for the mac
node because you use properties from the schema.

> gdm1 is the GMAC port used
> as cpu port by the mt7530 dsa switch

That has nothing to do with *this* binding...

>
> switch: switch@1fb58000 {
>         compatible =3D "airoha,en7581-switch";
>         reg =3D <0 0x1fb58000 0 0x8000>;
>         resets =3D <&scuclk EN7581_GSW_RST>;
>
>         interrupt-controller;
>         #interrupt-cells =3D <1>;
>         interrupt-parent =3D <&gic>;
>         interrupts =3D <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
>
>         status =3D "disabled";
>
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>                 gsw_port1: port@1 {
>                         reg =3D <1>;
>                         label =3D "lan1";
>                         phy-mode =3D "internal";
>                         phy-handle =3D <&gsw_phy1>;
>                 };
>
>                 gsw_port2: port@2 {
>                         reg =3D <2>;
>                         label =3D "lan2";
>                         phy-mode =3D "internal";
>                         phy-handle =3D <&gsw_phy2>;
>                 };
>
>                 gsw_port3: port@3 {
>                         reg =3D <3>;
>                         label =3D "lan3";
>                         phy-mode =3D "internal";
>                         phy-handle =3D <&gsw_phy3>;
>                 };
>
>                 gsw_port4: port@4 {
>                         reg =3D <4>;
>                         label =3D "lan4";
>                         phy-mode =3D "internal";
>                         phy-handle =3D <&gsw_phy4>;
>                 };
>
>                 port@6 {
>                         reg =3D <6>;
>                         label =3D "cpu";
>                         ethernet =3D <&gdm1>;
>                         phy-mode =3D "internal";
>
>                         fixed-link {
>                                 speed =3D <1000>;
>                                 full-duplex;
>                                 pause;
>                         };
>                 };
>         };
>
>         mdio {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>                 gsw_phy1: ethernet-phy@1 {
>                         compatible =3D "ethernet-phy-ieee802.3-c22";
>                         reg =3D <9>;
>                         phy-mode =3D "internal";
>                 };
>
>                 gsw_phy2: ethernet-phy@2 {
>                         compatible =3D "ethernet-phy-ieee802.3-c22";
>                         reg =3D <10>;
>                         phy-mode =3D "internal";
>                 };
>
>                 gsw_phy3: ethernet-phy@3 {
>                         compatible =3D "ethernet-phy-ieee802.3-c22";
>                         reg =3D <11>;
>                         phy-mode =3D "internal";
>                 };
>
>                 gsw_phy4: ethernet-phy@4 {
>                         compatible =3D "ethernet-phy-ieee802.3-c22";
>                         reg =3D <12>;
>                         phy-mode =3D "internal";
>                 };
>         };
> };

None of this is relevant.

> > > +patternProperties:
> > > +  "^mac@[1-4]$":
> >
> > 'ethernet' is the defined node name for users of
> > ethernet-controller.yaml.
>
> Looking at the dts above, ethernet is already used by the parent node.

So? Not really any reason a node named foo can't have a child named foo, to=
o.

An 'ethernet' node should implement an ethernet interface. It is the
child nodes that implement the ethernet interface(s). Whether you use
'ethernet' on the parent or not, I don't care too much.

> This approach has been already used here [0],[1],[2]. Is it fine to reuse=
 it?

That one appears to be wrong too with the parent referencing
ethernet-controller.yaml.

Rob

> Regards,
> Lorenzo
>
> [0] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/med=
iatek/mt7622.dtsi#L964
> [1] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/med=
iatek/mt7622-bananapi-bpi-r64.dts#L136
> [2] https://github.com/torvalds/linux/blob/master/Documentation/devicetre=
e/bindings/net/mediatek%2Cnet.yaml#L370


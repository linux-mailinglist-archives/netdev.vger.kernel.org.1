Return-Path: <netdev+bounces-110017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4941F92AAEB
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C85D1C2116B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744A514E2F4;
	Mon,  8 Jul 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk2ks/fL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7720DE8;
	Mon,  8 Jul 2024 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473064; cv=none; b=ZcDqkY8hmq3e88yk/jypsvrcxP2vHS7PsvVELHf6OXRoHLm50e/bCpfcFjXyU/vt3VmkL6uiUiHxs+1Fx+ciOHb2/8MZBhTVyEOmly5TgLaZ8eLaoHRjockvVIRAW7/DyditnyTPyL16iZEzqbagQmzlfaq2bH2jnHPnWqFZ4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473064; c=relaxed/simple;
	bh=qlncNLyaA3yc3AXdndUDPtc2YHOaKBOTbDUfNAxhA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWAvq+XtWPprPxVBg30OdLaYNFd/drUgmsNtwHEHxL452vWAe2cZ41stzRbYYhuUCs9vY1SpSq50im4nkocDzp+dsn4/pSGcZinq7VXDLHv6vmN/UGqNJlPyiiL4jYROIgXWJPPlImTwphSPvprUwBpazcssPZmhYiv2mbJXdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk2ks/fL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFCDC116B1;
	Mon,  8 Jul 2024 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720473063;
	bh=qlncNLyaA3yc3AXdndUDPtc2YHOaKBOTbDUfNAxhA+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lk2ks/fLh9udrJ7lJ91dCC/vOQjE9igKDqIPouyruxFx7NuUSnt/UOfSF8B0KDX8Z
	 75Qk8fGD+k52p9CINZwijEzldy2+ZrWfrrM4JhbQRMTzuWEChgna3Iyqv1qDo5LMAn
	 KZ+BOgMJO1rZgYXuy7k1S7I4t6mjkRo2uiDAI3e8+qxto8Bq39qClrYOQxK4v4le1h
	 8eKg1hDye4d3FPSn6VceKYRhRr/A+gMP352CYdO3BYaHKAo8WjxwviN5fE795KKC0e
	 SkKwaPD//zEcR6LfEl8TcFnmGr/o4gyPZrTJ2TTzGqq0IdGcSUUGWQu7hLVQq5yMbv
	 qEZ7eRig+kwLw==
Date: Mon, 8 Jul 2024 23:10:59 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, andrew@lunn.ch, arnd@arndb.de,
	horms@kernel.org
Subject: Re: [PATCH v5 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <ZoxV45hyccLHAm1P@lore-desk>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <48dde2595c6ff497a846183b117ac9704537b78c.1720079772.git.lorenzo@kernel.org>
 <20240708163708.GA3371750-robh@kernel.org>
 <Zowb18jXTOw5L2aT@lore-desk>
 <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lIwAWTvaLItX9IW"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>


--4lIwAWTvaLItX9IW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Jul 8, 2024 at 11:03=E2=80=AFAM Lorenzo Bianconi <lorenzo@kernel.=
org> wrote:
> >
> > > On Thu, Jul 04, 2024 at 10:08:10AM +0200, Lorenzo Bianconi wrote:
> > > > Introduce device-tree binding documentation for Airoha EN7581 ether=
net
> > > > mac controller.
> > > >
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > >  .../bindings/net/airoha,en7581-eth.yaml       | 146 ++++++++++++++=
++++
> > > >  1 file changed, 146 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en=
7581-eth.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-et=
h.yaml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > new file mode 100644
> > > > index 000000000000..f4b1f8afddd0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > > > @@ -0,0 +1,146 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Airoha EN7581 Frame Engine Ethernet controller
> > > > +
> > > > +allOf:
> > > > +  - $ref: ethernet-controller.yaml#
> > >
> > > Again, to rephrase, what are you using from this binding? It does not
> > > make sense for the parent and child both to use it.
> >
> > Below I reported the ethernet dts node I am using (I have not posted th=
e dts
> > changes yet):
>=20
> What happens when you remove this $ref? Nothing, because you use 0
> properties from it. If none of the properties apply, then don't
> reference it. It is that simple.

if I get rid of "$ref: ethernet-controller.yaml#" here I get the following =
error using
en7581-evb.dts (not posted upstream yet):

$make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Dairoha airoha/en7581-evb.dtb
  UPD     include/config/kernel.release
  DTC_CHK arch/arm64/boot/dts/airoha/en7581-evb.dtb
  /home/lorenzo/workspace/linux-mediatek/arch/arm64/boot/dts/airoha/en7581-=
evb.dtb: ethernet@1fb50000: mac@1: Unevaluated properties are not allowed (=
'fixed-link', 'phy-mode' were unexpected)
  from schema $id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#

>=20
> >
> > eth0: ethernet@1fb50000 {
> >         compatible =3D "airoha,en7581-eth";
> >         reg =3D <0 0x1fb50000 0 0x2600>,
> >               <0 0x1fb54000 0 0x2000>,
> >               <0 0x1fb56000 0 0x2000>;
> >         reg-names =3D "fe", "qdma0", "qdma1";
> >
> >         resets =3D <&scuclk EN7581_FE_RST>,
> >                  <&scuclk EN7581_FE_PDMA_RST>,
> >                  <&scuclk EN7581_FE_QDMA_RST>,
> >                  <&scuclk EN7581_XSI_MAC_RST>,
> >                  <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
> >                  <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
> >                  <&scuclk EN7581_HSI_MAC_RST>,
> >                  <&scuclk EN7581_XFP_MAC_RST>;
> >         reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
> >                       "hsi0-mac", "hsi1-mac", "hsi-mac",
> >                       "xfp-mac";
> >
> >         interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> >                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> >
> >         status =3D "disabled";
> >
> >         #address-cells =3D <1>;
> >         #size-cells =3D <0>;
> >
> >         gdm1: mac@1 {
> >                 compatible =3D "airoha,eth-mac";
> >                 reg =3D <1>;
> >                 phy-mode =3D "internal";
> >                 status =3D "disabled";
> >
> >                 fixed-link {
> >                         speed =3D <1000>;
> >                         full-duplex;
> >                         pause;
> >                 };
> >         };
> > };
> >
> > I am using phy related binding for gdm1:mac@1 node.
>=20
> Right, so you should reference ethernet-controller.yaml for the mac
> node because you use properties from the schema.

ack. So, IIUC what you mean here, I need to get rid of "$ref: ethernet-cont=
roller.yaml#"
in the parent node and just use in the mac node. Correct?

>=20
> > gdm1 is the GMAC port used
> > as cpu port by the mt7530 dsa switch
>=20
> That has nothing to do with *this* binding...
>=20
> >
> > switch: switch@1fb58000 {
> >         compatible =3D "airoha,en7581-switch";
> >         reg =3D <0 0x1fb58000 0 0x8000>;
> >         resets =3D <&scuclk EN7581_GSW_RST>;
> >
> >         interrupt-controller;
> >         #interrupt-cells =3D <1>;
> >         interrupt-parent =3D <&gic>;
> >         interrupts =3D <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
> >
> >         status =3D "disabled";
> >
> >         #address-cells =3D <1>;
> >         #size-cells =3D <1>;
> >
> >         ports {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >
> >                 gsw_port1: port@1 {
> >                         reg =3D <1>;
> >                         label =3D "lan1";
> >                         phy-mode =3D "internal";
> >                         phy-handle =3D <&gsw_phy1>;
> >                 };
> >
> >                 gsw_port2: port@2 {
> >                         reg =3D <2>;
> >                         label =3D "lan2";
> >                         phy-mode =3D "internal";
> >                         phy-handle =3D <&gsw_phy2>;
> >                 };
> >
> >                 gsw_port3: port@3 {
> >                         reg =3D <3>;
> >                         label =3D "lan3";
> >                         phy-mode =3D "internal";
> >                         phy-handle =3D <&gsw_phy3>;
> >                 };
> >
> >                 gsw_port4: port@4 {
> >                         reg =3D <4>;
> >                         label =3D "lan4";
> >                         phy-mode =3D "internal";
> >                         phy-handle =3D <&gsw_phy4>;
> >                 };
> >
> >                 port@6 {
> >                         reg =3D <6>;
> >                         label =3D "cpu";
> >                         ethernet =3D <&gdm1>;
> >                         phy-mode =3D "internal";
> >
> >                         fixed-link {
> >                                 speed =3D <1000>;
> >                                 full-duplex;
> >                                 pause;
> >                         };
> >                 };
> >         };
> >
> >         mdio {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >
> >                 gsw_phy1: ethernet-phy@1 {
> >                         compatible =3D "ethernet-phy-ieee802.3-c22";
> >                         reg =3D <9>;
> >                         phy-mode =3D "internal";
> >                 };
> >
> >                 gsw_phy2: ethernet-phy@2 {
> >                         compatible =3D "ethernet-phy-ieee802.3-c22";
> >                         reg =3D <10>;
> >                         phy-mode =3D "internal";
> >                 };
> >
> >                 gsw_phy3: ethernet-phy@3 {
> >                         compatible =3D "ethernet-phy-ieee802.3-c22";
> >                         reg =3D <11>;
> >                         phy-mode =3D "internal";
> >                 };
> >
> >                 gsw_phy4: ethernet-phy@4 {
> >                         compatible =3D "ethernet-phy-ieee802.3-c22";
> >                         reg =3D <12>;
> >                         phy-mode =3D "internal";
> >                 };
> >         };
> > };
>=20
> None of this is relevant.
>=20
> > > > +patternProperties:
> > > > +  "^mac@[1-4]$":
> > >
> > > 'ethernet' is the defined node name for users of
> > > ethernet-controller.yaml.
> >
> > Looking at the dts above, ethernet is already used by the parent node.
>=20
> So? Not really any reason a node named foo can't have a child named foo, =
too.

ack, fine. I will fix it in the next revision.

>=20
> An 'ethernet' node should implement an ethernet interface. It is the
> child nodes that implement the ethernet interface(s). Whether you use
> 'ethernet' on the parent or not, I don't care too much.

ack, I will use "$ref: ethernet-controller.yaml#" just for the child in thi=
s case.

Regards,
Lorenzo

>=20
> > This approach has been already used here [0],[1],[2]. Is it fine to reu=
se it?
>=20
> That one appears to be wrong too with the parent referencing
> ethernet-controller.yaml.
>=20
> Rob
>=20
> > Regards,
> > Lorenzo
> >
> > [0] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/m=
ediatek/mt7622.dtsi#L964
> > [1] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/m=
ediatek/mt7622-bananapi-bpi-r64.dts#L136
> > [2] https://github.com/torvalds/linux/blob/master/Documentation/devicet=
ree/bindings/net/mediatek%2Cnet.yaml#L370

--4lIwAWTvaLItX9IW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoxV4wAKCRA6cBh0uS2t
rP37AP41VxaGSbi9DK4tkO8fFeR3aWMDrKOBXVc4wqVtPu62+wEA+PBBRzvFOLrf
fI5irjM0KudrfoyuZYD3c1kLhu82KwU=
=Cemr
-----END PGP SIGNATURE-----

--4lIwAWTvaLItX9IW--


Return-Path: <netdev+bounces-109960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33E92A7C3
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FB9B2113D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63E78C75;
	Mon,  8 Jul 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjHo8/4d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C2146D74;
	Mon,  8 Jul 2024 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458203; cv=none; b=t/SRsmbBHmH1qjgeWUWrE82yl1hK2vLFUD+yS2B4+cGd+IZ5IZpDrivrJlHAEKry4Op7ZtUDxgJ15hL4TeJtwGBeeqFGZ3dUCt5IS+5oFXKwPmxNOePITaUTLyNwDiq+tf+tOcccVqMPYQGALltgRo8gdg10ee3n/fpyFRBPaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458203; c=relaxed/simple;
	bh=/zVeUUSVvC18k+FUNosdZfoZKRUTIhKFMk9o+kpjdUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfDET4ExxNGmwKKeaCnAKi02yBmqPZPguKcgoz53UcYBppuMNE3TioH5IQ/AS5RSCaH7AQGWP2aVUp9US/9hsiXwjtz3Cl8epL1AX6xFakT13ce1s4Es8oEVbe8rOEW1h7J0Hzc8YbGRBVae+JDju4G/0bJUhDr+oOHOCq0i5Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjHo8/4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7E0C116B1;
	Mon,  8 Jul 2024 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458203;
	bh=/zVeUUSVvC18k+FUNosdZfoZKRUTIhKFMk9o+kpjdUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjHo8/4dfpQhiujA64bX8AlP0hTPDvjmCsBgfHvQAuCefyF0gttZiQePSx191j52e
	 A42Ong3nhDc5TMSa0xkde/QrvVxkdmt0wo8Tqc4WN7RKLdIGO+k4obEupD2ad/Drm8
	 T637Rs4BB+crrLb+Q0z3FXajdKBQSp2U7HYxz0Q6MsqAQgGSNd/IyKz7Lx44BIrR7n
	 nR2syOw2+6QG52ZMaxqx/yzpTvo1efhw6TLe+Yv7Q9GucU1gdGrE/qe0D9TFDn7ZLr
	 2umnJYU3mfpmd3hovVgOqBLUkgSRD/mKFapbsfHtimM02oVkYtdwirjfOHs4gOKekG
	 pxs0kS+45qZuQ==
Date: Mon, 8 Jul 2024 19:03:19 +0200
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
Message-ID: <Zowb18jXTOw5L2aT@lore-desk>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <48dde2595c6ff497a846183b117ac9704537b78c.1720079772.git.lorenzo@kernel.org>
 <20240708163708.GA3371750-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tPaCCj80FvzUkZUL"
Content-Disposition: inline
In-Reply-To: <20240708163708.GA3371750-robh@kernel.org>


--tPaCCj80FvzUkZUL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jul 04, 2024 at 10:08:10AM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/net/airoha,en7581-eth.yaml       | 146 ++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
-eth.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > new file mode 100644
> > index 000000000000..f4b1f8afddd0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -0,0 +1,146 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/airoha,en7581-eth.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Airoha EN7581 Frame Engine Ethernet controller
> > +
> > +allOf:
> > +  - $ref: ethernet-controller.yaml#
>=20
> Again, to rephrase, what are you using from this binding? It does not=20
> make sense for the parent and child both to use it.

Below I reported the ethernet dts node I am using (I have not posted the dts
changes yet):

eth0: ethernet@1fb50000 {
	compatible =3D "airoha,en7581-eth";
	reg =3D <0 0x1fb50000 0 0x2600>,
	      <0 0x1fb54000 0 0x2000>,
	      <0 0x1fb56000 0 0x2000>;
	reg-names =3D "fe", "qdma0", "qdma1";

	resets =3D <&scuclk EN7581_FE_RST>,
		 <&scuclk EN7581_FE_PDMA_RST>,
		 <&scuclk EN7581_FE_QDMA_RST>,
		 <&scuclk EN7581_XSI_MAC_RST>,
		 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
		 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
		 <&scuclk EN7581_HSI_MAC_RST>,
		 <&scuclk EN7581_XFP_MAC_RST>;
	reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
		      "hsi0-mac", "hsi1-mac", "hsi-mac",
		      "xfp-mac";

	interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
		     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;

	status =3D "disabled";

	#address-cells =3D <1>;
	#size-cells =3D <0>;

	gdm1: mac@1 {
		compatible =3D "airoha,eth-mac";
		reg =3D <1>;
		phy-mode =3D "internal";
		status =3D "disabled";

		fixed-link {
			speed =3D <1000>;
			full-duplex;
			pause;
		};
	};
};

I am using phy related binding for gdm1:mac@1 node. gdm1 is the GMAC port u=
sed
as cpu port by the mt7530 dsa switch

switch: switch@1fb58000 {
	compatible =3D "airoha,en7581-switch";
	reg =3D <0 0x1fb58000 0 0x8000>;
	resets =3D <&scuclk EN7581_GSW_RST>;

	interrupt-controller;
	#interrupt-cells =3D <1>;
	interrupt-parent =3D <&gic>;
	interrupts =3D <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;

	status =3D "disabled";

	#address-cells =3D <1>;
	#size-cells =3D <1>;

	ports {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		gsw_port1: port@1 {
			reg =3D <1>;
			label =3D "lan1";
			phy-mode =3D "internal";
			phy-handle =3D <&gsw_phy1>;
		};

		gsw_port2: port@2 {
			reg =3D <2>;
			label =3D "lan2";
			phy-mode =3D "internal";
			phy-handle =3D <&gsw_phy2>;
		};

		gsw_port3: port@3 {
			reg =3D <3>;
			label =3D "lan3";
			phy-mode =3D "internal";
			phy-handle =3D <&gsw_phy3>;
		};

		gsw_port4: port@4 {
			reg =3D <4>;
			label =3D "lan4";
			phy-mode =3D "internal";
			phy-handle =3D <&gsw_phy4>;
		};

		port@6 {
			reg =3D <6>;
			label =3D "cpu";
			ethernet =3D <&gdm1>;
			phy-mode =3D "internal";

			fixed-link {
				speed =3D <1000>;
				full-duplex;
				pause;
			};
		};
	};

	mdio {
		#address-cells =3D <1>;
		#size-cells =3D <0>;

		gsw_phy1: ethernet-phy@1 {
			compatible =3D "ethernet-phy-ieee802.3-c22";
			reg =3D <9>;
			phy-mode =3D "internal";
		};

		gsw_phy2: ethernet-phy@2 {
			compatible =3D "ethernet-phy-ieee802.3-c22";
			reg =3D <10>;
			phy-mode =3D "internal";
		};

		gsw_phy3: ethernet-phy@3 {
			compatible =3D "ethernet-phy-ieee802.3-c22";
			reg =3D <11>;
			phy-mode =3D "internal";
		};

		gsw_phy4: ethernet-phy@4 {
			compatible =3D "ethernet-phy-ieee802.3-c22";
			reg =3D <12>;
			phy-mode =3D "internal";
		};
	};
};

>=20
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +description:
> > +  The frame engine ethernet controller can be found on Airoha SoCs.
> > +  These SoCs have multi-GMAC ports.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - airoha,en7581-eth
> > +
> > +  reg:
> > +    items:
> > +      - description: Frame engine base address
> > +      - description: QDMA0 base address
> > +      - description: QDMA1 base address
> > +
> > +  reg-names:
> > +    items:
> > +      - const: fe
> > +      - const: qdma0
> > +      - const: qdma1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: QDMA lan irq0
> > +      - description: QDMA lan irq1
> > +      - description: QDMA lan irq2
> > +      - description: QDMA lan irq3
> > +      - description: QDMA wan irq0
> > +      - description: QDMA wan irq1
> > +      - description: QDMA wan irq2
> > +      - description: QDMA wan irq3
> > +      - description: FE error irq
> > +      - description: PDMA irq
> > +
> > +  resets:
> > +    maxItems: 8
> > +
> > +  reset-names:
> > +    items:
> > +      - const: fe
> > +      - const: pdma
> > +      - const: qdma
> > +      - const: xsi-mac
> > +      - const: hsi0-mac
> > +      - const: hsi1-mac
> > +      - const: hsi-mac
> > +      - const: xfp-mac
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +patternProperties:
> > +  "^mac@[1-4]$":
>=20
> 'ethernet' is the defined node name for users of =20
> ethernet-controller.yaml.

Looking at the dts above, ethernet is already used by the parent node.
This approach has been already used here [0],[1],[2]. Is it fine to reuse i=
t?

Regards,
Lorenzo

[0] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/media=
tek/mt7622.dtsi#L964
[1] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/media=
tek/mt7622-bananapi-bpi-r64.dts#L136
[2] https://github.com/torvalds/linux/blob/master/Documentation/devicetree/=
bindings/net/mediatek%2Cnet.yaml#L370

>=20
> > +    type: object
> > +    unevaluatedProperties: false
> > +    $ref: ethernet-controller.yaml#
> > +    description:
> > +      Ethernet GMAC port associated to the MAC controller
> > +    properties:
> > +      compatible:
> > +        const: airoha,eth-mac
> > +
> > +      reg:
> > +        minimum: 1
> > +        maximum: 4
> > +        description: GMAC port identifier
> > +
> > +    required:
> > +      - reg
> > +      - compatible
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - resets
> > +  - reset-names
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/en7523-clk.h>
> > +
> > +    soc {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +
> > +      eth0: ethernet@1fb50000 {
> > +        compatible =3D "airoha,en7581-eth";
> > +        reg =3D <0 0x1fb50000 0 0x2600>,
> > +              <0 0x1fb54000 0 0x2000>,
> > +              <0 0x1fb56000 0 0x2000>;
> > +        reg-names =3D "fe", "qdma0", "qdma1";
> > +
> > +        resets =3D <&scuclk 44>,
> > +                 <&scuclk 30>,
> > +                 <&scuclk 31>,
> > +                 <&scuclk 6>,
> > +                 <&scuclk 15>,
> > +                 <&scuclk 16>,
> > +                 <&scuclk 17>,
> > +                 <&scuclk 26>;
> > +        reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
> > +                      "hsi0-mac", "hsi1-mac", "hsi-mac",
> > +                      "xfp-mac";
> > +
> > +        interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        mac1: mac@1 {
> > +          compatible =3D "airoha,eth-mac";
> > +          reg =3D <1>;
> > +        };
> > +      };
> > +    };
> > --=20
> > 2.45.2
> >=20

--tPaCCj80FvzUkZUL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZowb1wAKCRA6cBh0uS2t
rJKmAP9RXSZKfgOxplTzY6bgX1BUg+hCXnXAXDfYTvqzdeT9PQD/SS2xjlUup6Hf
Nw8KvpGzno/Fji5Mi4grgUaKaw/xzgY=
=I4sd
-----END PGP SIGNATURE-----

--tPaCCj80FvzUkZUL--


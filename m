Return-Path: <netdev+bounces-108367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B01692390B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4191F2444D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD8D15359B;
	Tue,  2 Jul 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0zPmMXW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409231509BA;
	Tue,  2 Jul 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910908; cv=none; b=T761iEi2FfajwaBMm6C69WosH87xWOutiGnZR4xD6tLkc8t4pU61DExo32LCqb79xfAx2QnQx9cBnuCFfbbYIEB1ROhQsw4fG3kVYe5VK92xPNpfqO08LjnAuYd9ScY72qwzX5vlDj1Ho13afaiPlJzwWvuxWAnTm+xiOkj5OdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910908; c=relaxed/simple;
	bh=KzF3cJ1U01d8m+TALz/UUSM+PvPSVilZwRLb/3qCyuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzcDSL8yM1aMQMrPOD98LcJ2Y7Zr32mZC0PLwoesnH91rrTMWNbENgoZQwcxemMw/d8kAR1AoI7SY5Pn8f38j7G7QW2CWM4qPPpCMPw3fRhwHMyjBm+RqSYmNbPAc3sldr7JH8HoNCC9+NycNH9bjHgT/bzthFepgX65zE12MDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0zPmMXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B18C116B1;
	Tue,  2 Jul 2024 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719910907;
	bh=KzF3cJ1U01d8m+TALz/UUSM+PvPSVilZwRLb/3qCyuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0zPmMXWVIafUs0cE8j43wlZ/CTHZ0I4lZpLqYNs0uTKMsX908zNdXogsklEv4bM1
	 S621EEymxKSgYvnzw2GdbCXZZ5uj2BUWr4b9454YiLlbl0FU7IGaWa8HYwgIpHk9F1
	 LhYAC5GEim0DUzxvX9XhYPE3bU9sZYoFZLN94kYN2Bwh/JOmM9/eJn9tOJwe0oAcRq
	 IAImDR9HR1pyD4uuQ+KBViHk2H8FEAJgOP3C4vZcEElJ/4FZWMHQ5p0tyJrG/brJ7S
	 RzGoLDN66Z+geGXtBiaTZAxr2ax4rVPSiZOkenyEhRBwjYZM2YviKYaqlcr9+P7jFQ
	 KaBditk4OxRwA==
Date: Tue, 2 Jul 2024 11:01:43 +0200
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
Subject: Re: [PATCH v4 1/2] dt-bindings: net: airoha: Add EN7581 ethernet
 controller
Message-ID: <ZoPB9yvSFUSVdrqd@lore-rh-laptop>
References: <cover.1719672695.git.lorenzo@kernel.org>
 <20d103799a20d9d61a1c378eb27e61748859e978.1719672695.git.lorenzo@kernel.org>
 <20240701182151.GA320555-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJUB+IoPMbpPmzmz"
Content-Disposition: inline
In-Reply-To: <20240701182151.GA320555-robh@kernel.org>


--YJUB+IoPMbpPmzmz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, Jun 29, 2024 at 05:01:37PM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/net/airoha,en7581-eth.yaml       | 171 ++++++++++++++++++
> >  1 file changed, 171 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
-eth.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > new file mode 100644
> > index 000000000000..e2c0da02ccf2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -0,0 +1,171 @@
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
> > +
> > +maintainers:
> > +  - Lorenzo Bianconi <lorenzo@kernel.org>
> > +
> > +description:
> > +  The frame engine ethernet controller can be found on Airoha SoCs.
> > +  These SoCs have dual GMAC ports.
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
> ethernet@

Should it be like mtk_eth_soc binding?
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/net/mediatek%2Cnet.yaml#L371

>=20
> > +    type: object
> > +    unevaluatedProperties: false
> > +    allOf:
>=20
> Can drop 'allOf'

ack, I will fix it in v5

>=20
> > +      - $ref: ethernet-controller.yaml#
>=20
> Which node represents an ethernet controller? This one or the parent?=20
> Most likely it is not both.

This node reprensts the GMAC port associated to the parent enternet control=
ler.

>=20
> > +    description:
> > +      Ethernet MAC node
> > +    properties:
> > +      compatible:
> > +        const: airoha,eth-mac
> > +
> > +      reg:
> > +        maxItems: 1
>=20
> Based on the unit-address, you need instead:
>=20
> minimum: 1
> maximum: 4

ack, I will fix it in v5

>=20
> But what does 1-4 represent? There are no MMIO registers associated with=
=20
> the MACs? Please describe.

This is the GMAC port ID.

>=20
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
> > +          phy-mode =3D "2500base-x";
> > +          phy-handle =3D <&phy0>;
> > +        };
> > +
> > +        mac2: mac@2 {
> > +          compatible =3D "airoha,eth-mac";
> > +          reg =3D <2>;
> > +          phy-mode =3D "2500base-x";
> > +          phy-handle =3D <&phy1>;
> > +        };
> > +      };
> > +
> > +      mdio: mdio-bus {
>=20
> mdio {
>=20
> But really, drop this if it is not part of this device (binding). What=20
> is the control interface for this MDIO bus? If it is part of this=20
> device, then the mdio node needs to be within the device's node.

ack, I will drop it in v5.

Regards,
Lorenzo

>=20
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        phy0: ethernet-phy@0 {
> > +            compatible =3D "ethernet-phy-id67c9.de0a";
> > +            reg =3D <0>;
> > +            phy-mode =3D "2500base-x";
> > +        };
> > +
> > +        phy1: ethernet-phy@1 {
> > +            compatible =3D "ethernet-phy-id67c9.de0a";
> > +            reg =3D <1>;
> > +            phy-mode =3D "2500base-x";
> > +        };
> > +      };
> > +    };
> > --=20
> > 2.45.2
> >=20

--YJUB+IoPMbpPmzmz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoPB9AAKCRA6cBh0uS2t
rNgkAQD2jvH/4boYQ2FedZoz2s1HclPFvkscGxFNBEDIDMFUygEAgKLlN0UZ/FSn
XKi8NiZZmZm9Hg7qqJqjllMi5FvigA0=
=3zZl
-----END PGP SIGNATURE-----

--YJUB+IoPMbpPmzmz--


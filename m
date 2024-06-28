Return-Path: <netdev+bounces-107576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0564091B987
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F8D1C2295E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972E2145353;
	Fri, 28 Jun 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsX4zqa0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2394436A;
	Fri, 28 Jun 2024 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562262; cv=none; b=tSGS75SUffqIfgANnwoC98a6+Dvc5OYMl6TuEq1DncABorCoNT56jAXtya25sK5kNHB4JqUcbrMW69DDYzYSYY/So6MA2Ccv0kL2c+FbY6NOnkzRmObsHFJmgie6kFayMhxkozEfxwh3yiHBSq4o3SrQkrtveRXrTMsLtv0V/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562262; c=relaxed/simple;
	bh=qH0hUeJp5WdywexB7qHSHvkmDo/Ev7rR2aoYaZNMI5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idbGlH8jmEwkxEQYc0f62t91H9thlbBUzl4+XfXVlRGZkyitJEUoiUiSnWGpYud6CI8wHzR/9ChIQpOyk2QPWnw9O/fNVIqb4YlG6GLpqedu3jR72Rhayc/Yz4+vOfH6jQA46Io7DerzhDutxYTmzd4IOpAO4Wzv0DvRfD/UYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsX4zqa0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F23C116B1;
	Fri, 28 Jun 2024 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719562262;
	bh=qH0hUeJp5WdywexB7qHSHvkmDo/Ev7rR2aoYaZNMI5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsX4zqa0BRH73ZVGwqcnwn0JCbyHSAucP2Edj4cnc23buK7a2nT9Wek38SInslxRl
	 glYvthHmIs4Y2W85caJa0m+63U7lwSOOPBWDURc8RF4Brpq8dRN0dNnzklpKelImv1
	 jfD6JWUu1xCvBUjx212nZnaC39UnUn4lwAV/AZQv2gbOhdMy+qVVxV5ckDFj+9Vu5g
	 x1t8+X9aSU9Xlmhd0zFc4+Es6FAOa5eg5hSNKT98tQWTCcgoA41VejCFSxKsov9FbU
	 ivRqXuq+6Urm9sKsPCjpa+P9Dk2ckmW+apN+WGtpbS7N3VhTo0WKLfiR6xZnTXHXDO
	 5jaPu/vjSV9LA==
Date: Fri, 28 Jun 2024 10:10:58 +0200
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
	sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <Zn5wErirnIlkzaoj@lore-desk>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <ec00d7042f43d289f7a88e0fed70a68905db0bde.1719159076.git.lorenzo@kernel.org>
 <20240627221007.GA646876-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mE1ojJjZZ6/R0duQ"
Content-Disposition: inline
In-Reply-To: <20240627221007.GA646876-robh@kernel.org>


--mE1ojJjZZ6/R0duQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, Jun 23, 2024 at 06:19:56PM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../bindings/net/airoha,en7581-eth.yaml       | 108 ++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
-eth.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-eth.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > new file mode 100644
> > index 000000000000..e25a462a75d4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
> > @@ -0,0 +1,108 @@
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
> > +    maxItems: 10
>=20
> You need to define what each interrupt is. Just like 'reg'.

ack, I will fix it in v4.

>=20
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
>=20
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
>=20
> What are these for? You have no child nodes to use them.

ack, in v4 I will add mac ethernet subnode.

Regards,
Lorenzo

>=20
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
> > +      };
> > +    };
> > --=20
> > 2.45.2
> >=20

--mE1ojJjZZ6/R0duQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZn5wEgAKCRA6cBh0uS2t
rPBDAP0VFISvwEjp5slaMCIeahLjeBlxThDttQpEv3MVItyDGAEAyIJ24SNWoigy
vMJ/oqNXrVsk72tvU1hdyCLn8y4BhAA=
=4SEp
-----END PGP SIGNATURE-----

--mE1ojJjZZ6/R0duQ--


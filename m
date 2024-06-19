Return-Path: <netdev+bounces-104742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D190E3A5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845721C2388A
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51D6F2EF;
	Wed, 19 Jun 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYoq2woa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04054C98;
	Wed, 19 Jun 2024 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779374; cv=none; b=bJdlq0IxujgnHduCQSJAibxyQTXSM04pV6D63NFNaTtop9APfQ3S7Y8mM7QnRSFk0vvRWe/yik4syIGBpK66Xvhayluz/thp7pg/Tj8c8DVAXWIgsfdSB71PagUW8EF0Pj4aBRe66KoX6C/l3NFwXwGFbLWGAHBiEln23kURmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779374; c=relaxed/simple;
	bh=IkRW3HOcJchHG5TiRUqcdeSB6KjV1y4pynH2FMahj/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWlkTv0hK84pu25TAblj8XcuNA0L8X8bjhXci+RT/cyznqLFRdJZethk5Iki2xztNESbCB5Bqewvj3JZ+10YfIxr1sSLnLwc5NF6n9WjvWs7fbzZgc/D//eafOdmBoOo1npuJRyO1xH9fNSVX91JSKhFG1ChbDZgnW4x1jet6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYoq2woa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FC4C2BBFC;
	Wed, 19 Jun 2024 06:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718779374;
	bh=IkRW3HOcJchHG5TiRUqcdeSB6KjV1y4pynH2FMahj/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYoq2woa5IN9fOrOXUErEaup+DWZa+BHkH3uh0KfpJF4r7Daj3lwl/9ijBtlQPCtH
	 qoYWx34+2qHC8pUmM7AzcdiifWvSVz8gb59CAFemSkGJ7aFEdVelQmLIiRTwBsoXCl
	 zdMaR1GRqf+8PFzdCUQJ8d0thmuv3XeEq8DKNziFZoWvFZNykkjPF1HhYDhw3pS9Qr
	 qZWTrkn/1n6lZrvLb652Mjsr4bSb14Wo30e5WVhgE3VcZBs2fWUXrEqcQPmdwfOEMO
	 oToAG9FaXeXkGE/vOLQTxppjs2LE/gXpUbeRt6sHfs+7satsRFr5UfJvbrs0C5lM21
	 Mh6U41V5ijX3Q==
Date: Wed, 19 Jun 2024 08:42:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <ZnJ96o2i29Wjq4Pp@lore-desk>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
 <20240618-synthetic-favored-31cbf735705d@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="10rL0aXjv/TfuGAB"
Content-Disposition: inline
In-Reply-To: <20240618-synthetic-favored-31cbf735705d@spud>


--10rL0aXjv/TfuGAB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jun 18, 2024 at 09:49:02AM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > This patch is based on the following one not applied yet on clk tree:
> > dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
> > https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428=
d4c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/
>=20
> Why introduce that dep? What's here is just an example, you can use the
> "raw" numbers (or any made up numbers really) and not have to depend on
> that.

ack, fine. I will fix it in v3.

Regards,
Lorenzo

>=20
> Thanks,
> Conor.
>=20
> > ---
> >  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
=2Eyaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b=
/Documentation/devicetree/bindings/net/airoha,en7581.yaml
> > new file mode 100644
> > index 000000000000..09e7b5eed3ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/airoha,en7581.yaml#
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
> > +
> > +  resets:
> > +    maxItems: 7
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
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
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
> > +    #include <dt-bindings/reset/airoha,en7581-reset.h>
> > +
> > +    soc {
> > +      #address-cells =3D <2>;
> > +      #size-cells =3D <2>;
> > +
> > +      eth0: ethernet@1fb50000 {
>=20
> The label here is unused and should be removed.
>=20
> > +        compatible =3D "airoha,en7581-eth";
> > +        reg =3D <0 0x1fb50000 0 0x2600>,
> > +              <0 0x1fb54000 0 0x2000>,
> > +              <0 0x1fb56000 0 0x2000>;
> > +        reg-names =3D "fe", "qdma0", "qdma1";
> > +
>=20
> Unusual whitespace.
>=20
> Those are nits:
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> > +        resets =3D <&scuclk EN7581_FE_RST>,
> > +                 <&scuclk EN7581_FE_PDMA_RST>,
> > +                 <&scuclk EN7581_FE_QDMA_RST>,
> > +                 <&scuclk EN7581_XSI_MAC_RST>,
> > +                 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
> > +                 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
> > +                 <&scuclk EN7581_HSI_MAC_RST>;
> > +        reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
> > +                      "hsi0-mac", "hsi1-mac", "hsi-mac";
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
> > 2.45.1
> >=20



--10rL0aXjv/TfuGAB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnJ96gAKCRA6cBh0uS2t
rIG2AQDEHG0TDj/3ANcsI8AbFS0cmAkGQCmZfhwzdr7SQLcwqwEAh6e2QYOkXkTz
9DzRxYR4OYBvyOnY5VNfx+1if01SlAg=
=lPKH
-----END PGP SIGNATURE-----

--10rL0aXjv/TfuGAB--


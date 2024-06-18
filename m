Return-Path: <netdev+bounces-104636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2480790DAEF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 19:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3FDB21E82
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A99145B34;
	Tue, 18 Jun 2024 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMaBx3+U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F913F00A;
	Tue, 18 Jun 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732810; cv=none; b=M8lEyYSgXN1Rxdrw7x6Qw+q80BeHouziwegAKQlaz03KH0JzxBWRZidLWhA4CTDWGoB/7dAtKD3G3swbjoxRRKi+zJj1U8wzx9DLEZJW5B6jjO4flk5vm0i05cuPnygm0KGfaXKgbW9hk76DjO+WoojKiG8xlCn0I0oxixADSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732810; c=relaxed/simple;
	bh=ZcTwmm50MtdGB41czVloH8VRZoQTyCljpqWSKgLxLik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TC481JC/ZJrcWEjeLaY/XwHztGnpqNyydC48xR8MZw/EPh7H5gGGfjX/OwuHicdBwYRlwkC+HymQpyAgUFij34fxRBfd8zuKDnWQt8oQ60v9tZG+JJMIuDPR/829lumXIdflb2P32j0UDjn8wfGTq7oRDVqDcBXwTLJmg5Orq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMaBx3+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B4C3277B;
	Tue, 18 Jun 2024 17:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718732809;
	bh=ZcTwmm50MtdGB41czVloH8VRZoQTyCljpqWSKgLxLik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMaBx3+UPeuZOw4jV6jHd4xmTYJ2wcsn8iyq1volTpUnxk8DMvJtYDBYrJN4yTyaa
	 aZ3u593sRRdarceR1wL0ARIehef5L3ATf0riimAPkDkn+fngfzUkQYlTsDwkzdioep
	 KZz2KdssTC5ba/QeeL1wZ9mt6NqRdmTeF8Yb1DVUarAdqk8bpGfEljths7L/KpBxOx
	 fgPGH/TYFBOtAYjLlzkQqjtjWhFQEOAfk1glVErBk/rY+9DYcORfxb3JH/VHL18xDD
	 a+7Gm53w1rVXqoG34KtXuTzwCbzq2uPSOkzpUAsq/9lW5ELMot6MvmIVn4hgSyT0xk
	 1jUhjjilWPZpg==
Date: Tue, 18 Jun 2024 18:46:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
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
Message-ID: <20240618-synthetic-favored-31cbf735705d@spud>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fgj7sBOw/bfj3zxh"
Content-Disposition: inline
In-Reply-To: <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>


--fgj7sBOw/bfj3zxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 09:49:02AM +0200, Lorenzo Bianconi wrote:
> Introduce device-tree binding documentation for Airoha EN7581 ethernet
> mac controller.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> This patch is based on the following one not applied yet on clk tree:
> dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
> https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428d4=
c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/

Why introduce that dep? What's here is just an example, you can use the
"raw" numbers (or any made up numbers really) and not have to depend on
that.

Thanks,
Conor.

> ---
>  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581.y=
aml
>=20
> diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b/D=
ocumentation/devicetree/bindings/net/airoha,en7581.yaml
> new file mode 100644
> index 000000000000..09e7b5eed3ae
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/airoha,en7581.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha EN7581 Frame Engine Ethernet controller
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +maintainers:
> +  - Lorenzo Bianconi <lorenzo@kernel.org>
> +
> +description:
> +  The frame engine ethernet controller can be found on Airoha SoCs.
> +  These SoCs have dual GMAC ports.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - airoha,en7581-eth
> +
> +  reg:
> +    items:
> +      - description: Frame engine base address
> +      - description: QDMA0 base address
> +      - description: QDMA1 base address
> +
> +  reg-names:
> +    items:
> +      - const: fe
> +      - const: qdma0
> +      - const: qdma1
> +
> +  interrupts:
> +    maxItems: 10
> +
> +  resets:
> +    maxItems: 7
> +
> +  reset-names:
> +    items:
> +      - const: fe
> +      - const: pdma
> +      - const: qdma
> +      - const: xsi-mac
> +      - const: hsi0-mac
> +      - const: hsi1-mac
> +      - const: hsi-mac
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - resets
> +  - reset-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    #include <dt-bindings/reset/airoha,en7581-reset.h>
> +
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      eth0: ethernet@1fb50000 {

The label here is unused and should be removed.

> +        compatible =3D "airoha,en7581-eth";
> +        reg =3D <0 0x1fb50000 0 0x2600>,
> +              <0 0x1fb54000 0 0x2000>,
> +              <0 0x1fb56000 0 0x2000>;
> +        reg-names =3D "fe", "qdma0", "qdma1";
> +

Unusual whitespace.

Those are nits:

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> +        resets =3D <&scuclk EN7581_FE_RST>,
> +                 <&scuclk EN7581_FE_PDMA_RST>,
> +                 <&scuclk EN7581_FE_QDMA_RST>,
> +                 <&scuclk EN7581_XSI_MAC_RST>,
> +                 <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
> +                 <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
> +                 <&scuclk EN7581_HSI_MAC_RST>;
> +        reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
> +                      "hsi0-mac", "hsi1-mac", "hsi-mac";
> +
> +        interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> +                     <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> --=20
> 2.45.1
>=20

--fgj7sBOw/bfj3zxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnHIAwAKCRB4tDGHoIJi
0l40AQCOOPo6NmJ5RIwwapPwKloQsJSL4DCEixffR0dr7LGvJQEAsm6DTp6Mb2J2
xdHXofpvm/2jT0n+WYf6cCTbUDc9Qw0=
=F8jF
-----END PGP SIGNATURE-----

--fgj7sBOw/bfj3zxh--


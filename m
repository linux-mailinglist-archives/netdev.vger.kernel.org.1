Return-Path: <netdev+bounces-20516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF90F75FDCE
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3259E28155E
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FDEF9E1;
	Mon, 24 Jul 2023 17:33:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2505DF66
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:33:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB20C433C8;
	Mon, 24 Jul 2023 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690220026;
	bh=C1kIKtLvD2fSSuDBUdV4Cvt/EP+eROsYIbuJMlryYOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FG+W6428sBf3W01KAkqIHUbc3/Yd86j+flK1Wp5sBRGtLSvPu28CefvMEXFfQC9pX
	 TvAKx1TGhyecq/RNkiSEIdn5wPic4kTBQvaiRL6dGPfe4fHJT2mqm26gEbUX1IfqxB
	 4wRD0qCxmYN58aZhTvHAju6H0LpQgRMxZrwqMmgdlJQIsmzqJm0ow2AvZ77GCG5CFx
	 8n0gyBkWEKOmwgZ7Wsq1hX0+9eQo+RKw9aXBnCnhCcKUASoyt+SK6JmGR+7vg2FCOT
	 rciF2US5mfBIANhCxd8KvVfIBOLTEbn2vNEL5z8GmiZHGGw1/am7rDXPwbWj7b0LCR
	 Q6oAhmCig3nCQ==
Date: Mon, 24 Jul 2023 18:33:41 +0100
From: Conor Dooley <conor@kernel.org>
To: nick.hawkins@hpe.com
Cc: verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: net: Add HPE GXP UMAC MDIO
Message-ID: <20230724-tragedy-mute-3d165bf7fdf6@spud>
References: <20230721212044.59666-1-nick.hawkins@hpe.com>
 <20230721212044.59666-2-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D31npTHFewmiLuNr"
Content-Disposition: inline
In-Reply-To: <20230721212044.59666-2-nick.hawkins@hpe.com>


--D31npTHFewmiLuNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2023 at 04:20:40PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
>=20
> Provide access to the register regions and interrupt for Universal
> MAC(UMAC). The driver under the hpe,gxp-umac-mdio will provide an
> interface for managing both the internal and external PHYs.
>=20
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  .../bindings/net/hpe,gxp-umac-mdio.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac-md=
io.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml=
 b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
> new file mode 100644
> index 000000000000..bb0db1bb67b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/hpe,gxp-umac-mdio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP UMAC MDIO Controller
> +
> +maintainers:
> +  - Nicholas Hawkins <nick.hawkins@hpe.com>
> +
> +description: |+

You've got no formatting to preserve, so even | on its own would be
wasted here.

> +  The HPE GXP Unversal MAC (UMAC) MDIO controller provides a configurati=
on
> +  path for both external PHY's and SERDES connected PHY's.
> +
> +allOf:
> +  - $ref: mdio.yaml#
> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-umac-mdio
> +
> +  reg:
> +    maxItems: 1

> +    description: The register range of the MDIO controller instance

This is a statement of the obvious, no?

Otherwise, looks okay to me.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio0: mdio@4080 {
> +      compatible =3D "hpe,gxp-umac-mdio";
> +      reg =3D <0x4080 0x10>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      ethphy0: ethernet-phy@0 {
> +        compatible =3D "ethernet-phy-ieee802.3-c22";
> +        phy-mode =3D "sgmii";
> +        reg =3D <0>;
> +      };
> +    };
> --=20
> 2.17.1
>=20

--D31npTHFewmiLuNr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL619QAKCRB4tDGHoIJi
0kGcAPwLhCiqKYUlAkeinOfunOtHjod1LqGxUusqBN+4m3xU3QEA0tG96pn7achg
Hldzm760/YP66jfNd/ze33o5h9E4awE=
=aG+M
-----END PGP SIGNATURE-----

--D31npTHFewmiLuNr--


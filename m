Return-Path: <netdev+bounces-19098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05554759AF2
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30AC51C210CF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B5180F;
	Wed, 19 Jul 2023 16:36:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64709800
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F60C433C8;
	Wed, 19 Jul 2023 16:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689784586;
	bh=T67KVuMsXJyOHPpyRG/bF4u+lVYth3Zf4FyYGoex53A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y3ZdEYbupgVsJzit/TJjMBMI1pQ8pnMPk2eY2TJHizVHcRhCCIs2G6wSKmru9CuYg
	 ruEp67kxjdVKQIPZVkMwSI6CdpryX0NZpAYAhYUDUruC6T9xnyuEMf2dXWHR4kmH3k
	 ewV2JPjapcDFamJ7uVoBOsUQ5oUAjoqYdB8sIQD9OXmyPECcbB7PxQXvDBxym+NuMm
	 J5WscmACVaQfmSU4drA+8IVI/cCN8A5AHBdzlsBrYvP5My+3Cg3Ej9st3hAK9Jtp6S
	 uvKnK/Cg/MX8z/aNRtrEtQAbBROe2du8KC3a2UsYabJm5jWi4G3npRk+0opcqGD520
	 SgmaXBE+V5bjg==
Date: Wed, 19 Jul 2023 17:36:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Pranavi Somisetty <pranavi.somisetty@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, michal.simek@amd.com, harini.katakam@amd.com,
	git@amd.com, radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: net: xilinx_gmii2rgmii: Convert to json
 schema
Message-ID: <20230719-sizzling-heaving-bc802f2ed2ae@spud>
References: <20230719061808.30967-1-pranavi.somisetty@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZZlRDUsAAGIHGb0l"
Content-Disposition: inline
In-Reply-To: <20230719061808.30967-1-pranavi.somisetty@amd.com>


--ZZlRDUsAAGIHGb0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 12:18:08AM -0600, Pranavi Somisetty wrote:
> Convert the Xilinx GMII to RGMII Converter device tree binding
> documentation to json schema.
> This converter is usually used as gem <---> gmii2rgmii <---> external phy
> and, it's phy-handle should point to the phandle of the external phy.
>=20
> Signed-off-by: Pranavi Somisetty <pranavi.somisetty@amd.com>
> ---
> Changes v2:
> 1. Changed description for the property "reg".
> 2. Added a reference to the description of "phy-handle" property.

Seems fine to me, one /minor/ nit that I don't expect to be addressed.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> diff --git a/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yam=
l b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml
> new file mode 100644
> index 000000000000..9d22382a64ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/xlnx,gmii-to-rgmii.yaml

> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        phy: ethernet-phy@0 {
> +            reg =3D <0>;
> +        };
> +        gmiitorgmii@8 {
> +            compatible =3D "xlnx,gmii-to-rgmii-1.0";
> +            reg =3D <8>;
> +            phy-handle =3D <&phy>;
> +        };

Ideally, add a blank line before child nodes.

> +    };
> --=20
> 2.36.1
>=20

--ZZlRDUsAAGIHGb0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgRBQAKCRB4tDGHoIJi
0pFDAQCmtiE2GnotCBnhox3kae5HrWkNtj3/Tv6uGBwnTLajtAEAiiBsXMRS3sfZ
PMfmBowd0X1+f9ihnG6IfCkO/fQ2pgg=
=Asfq
-----END PGP SIGNATURE-----

--ZZlRDUsAAGIHGb0l--


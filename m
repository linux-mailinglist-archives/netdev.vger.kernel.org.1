Return-Path: <netdev+bounces-23424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB28D76BEDD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA211C20FA7
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0831D263AC;
	Tue,  1 Aug 2023 20:57:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07ED4DC77
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 20:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32C1C433C7;
	Tue,  1 Aug 2023 20:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690923472;
	bh=MZpsgZkrTs9N2DXeSvVULBbBTbC/2zrygwHEmp8YujM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5zvTHcaV4FqvE9jjvKUtp/xndGtvumroKOColDoaHHgiuq4X1+XKbmp++w7LWLQ8
	 cVR2WGZ3SHE7NWqWskw88lRJ8hO3IK6X4//+uqggtlZpbIgWBfl3cY43X4Lzee8cgm
	 pEGPmTmWwovy18PICv9IEzeR9ywuTsxY5zOfhwg9R8UlHzgxExjVhO463h3Gdn+NMD
	 nF+lycPEvbrtmpei2B3YOb06JSwAU7VwCx/lG6DIoFk70sACLCJtS0YwJ+ndkcd21x
	 2p3JctnekTWlWkhLSYWsnmXkgc9sWJtmAfXpKjj2rbk9ikS37d0tdq8WmxayEsNAkc
	 doM2vHgGHLIrQ==
Date: Tue, 1 Aug 2023 21:57:43 +0100
From: Conor Dooley <conor@kernel.org>
To: niravkumar.l.rabara@intel.com
Cc: adrian.ho.yin.ng@intel.com, andrew@lunn.ch, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dinguyen@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, mturquette@baylibre.com,
	netdev@vger.kernel.org, p.zabel@pengutronix.de,
	richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
	wen.ping.teh@intel.com
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Message-ID: <20230801-handball-glorifier-e55d44a2b638@spud>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UYgz3o3mOFvMlDjf"
Content-Disposition: inline
In-Reply-To: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>


--UYgz3o3mOFvMlDjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 09:02:32AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add clock ID definitions for Intel Agilex5 SoCFPGA.
> The registers in Agilex5 handling the clock is named as clock manager.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>  .../bindings/clock/intel,agilex5-clkmgr.yaml  |  41 +++++++
>  .../dt-bindings/clock/intel,agilex5-clkmgr.h  | 100 ++++++++++++++++++
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex5=
-clkmgr.yaml
>  create mode 100644 include/dt-bindings/clock/intel,agilex5-clkmgr.h
>=20
> diff --git a/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr=
=2Eyaml b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> new file mode 100644
> index 000000000000..60e57a9fb939
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,agilex5-clkmgr.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/intel,agilex5-clkmgr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel SoCFPGA Agilex5 clock manager
> +
> +maintainers:
> +  - Dinh Nguyen <dinguyen@kernel.org>
> +
> +description:
> +  The Intel Agilex5 Clock Manager is an integrated clock controller, whi=
ch
> +  generates and supplies clock to all the modules.
> +
> +properties:
> +  compatible:
> +    const: intel,agilex5-clkmgr
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:

> +  # Clock controller node:

This comment seems utterly pointless.
Otherwise this looks okay to me.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +  - |
> +    clkmgr: clock-controller@10d10000 {
> +      compatible =3D "intel,agilex5-clkmgr";
> +      reg =3D <0x10d10000 0x1000>;
> +      #clock-cells =3D <1>;
> +    };
> +...

--UYgz3o3mOFvMlDjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMlxxwAKCRB4tDGHoIJi
0po0AQDZnIwfegUcCT3iU12bMW+7Rzx574ajligwACkn70tY7QD7BqfnIx/HSMTi
r+m16KOx6UHod5DfGI/YVENWzFoUfwo=
=GoDZ
-----END PGP SIGNATURE-----

--UYgz3o3mOFvMlDjf--


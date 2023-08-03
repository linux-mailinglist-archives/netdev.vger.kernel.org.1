Return-Path: <netdev+bounces-24129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EEE76EE18
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECA4282210
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2135723BE7;
	Thu,  3 Aug 2023 15:27:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B486FA2
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 15:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F12C433C9;
	Thu,  3 Aug 2023 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691076465;
	bh=HebtrT+FvWTW4Qoj0iQhJkBGJFGGesCcCI9C4O78+z4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHwXWs3kLCI9fnfkK3skYvdL16N5zzLxymEl2WJN9faARVEwjCMphRqQmNovlCTjP
	 aRoqR8SFLQg05lc4G1+hv3cstBURlzL32mXYRrCSWbFh4TPWYinymAlrTQeNsAykdY
	 fgyLgGQyXa90TLBVfT/QUB31WJcYxZkT7DN3UQQHq61fSzXgkgOiDOZJ30Rm1ra8XG
	 jWNjDiDqMjlRUQ8qDI/h4081wptQIQrLvYcDJfWaH5VqiNrzPFhUtq0cq3UZPRDncT
	 xsoURIoGOABkepVtDRP24Pra5Iy+gEYUXwenAfNRuqqHmNevOkR2zIuLtGucXm7sd6
	 GFUDlzLFsyQnQ==
Date: Thu, 3 Aug 2023 16:27:39 +0100
From: Conor Dooley <conor@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Richard Cochran <richardcochran@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, nm@ti.com, srk@ti.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: net: Add ICSS IEP
Message-ID: <20230803-guacamole-buddy-d8179f11615e@spud>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Szg8jUrBoYIrXJg5"
Content-Disposition: inline
In-Reply-To: <20230803110153.3309577-2-danishanwar@ti.com>


--Szg8jUrBoYIrXJg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 04:31:50PM +0530, MD Danish Anwar wrote:
> From: Md Danish Anwar <danishanwar@ti.com>
>=20
> Add DT binding documentation for ICSS IEP module.
>=20
> Signed-off-by: Md Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Doc=
umentation/devicetree/bindings/net/ti,icss-iep.yaml
> new file mode 100644
> index 000000000000..79cd72b330a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
> +
> +maintainers:
> +  - Md Danish Anwar <danishanwar@ti.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am654-icss-iep   # for K3 AM65x, J721E and AM64x SoCs

No. ti,am654-icss-iep is for am654. You should really have compatibles
specific to the SoC - is there a reason why this has not been done?


> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the IEP source clock
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    icssg0_iep0: iep@2e000 {
> +        compatible =3D "ti,am654-icss-iep";
> +        reg =3D <0x2e000 0x1000>;
> +        clocks =3D <&icssg0_iepclk_mux>;
> +    };
> --=20
> 2.34.1
>=20

--Szg8jUrBoYIrXJg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMvHagAKCRB4tDGHoIJi
0oA9AQDxymufAtPzH28krZy4nohqru7kyIVsevPrc8ILMh3a3gD+Jg9SDu9c/zGg
fLRLWoHQPXwuRfHpkz8sKhEz/SClMQ0=
=AJJT
-----END PGP SIGNATURE-----

--Szg8jUrBoYIrXJg5--


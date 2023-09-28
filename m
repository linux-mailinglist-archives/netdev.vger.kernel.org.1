Return-Path: <netdev+bounces-36913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E447B2377
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 19:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8D90828214F
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC015124C;
	Thu, 28 Sep 2023 17:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FD55123C;
	Thu, 28 Sep 2023 17:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AF6C433CA;
	Thu, 28 Sep 2023 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695921258;
	bh=tXrtMWlwOkfqKNhjWq3vR9L4n6dBzGkeLZc+XQRiVK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWpDdv3+ksAvGEbNOJjqpj7q/5jMHatTKJ6it5aZ7nm2U87e6YhGkdg2q43rVdojX
	 syggjiJg5ofTPT4ATJLWCuz47QSHmXFDJDhLEGRk1OuahUyYkwlVZi6lmjC5+Dh1mQ
	 67LUx4MmVrgVgHKK8ylOt8LjMq3shKSUja7kpoc6Df4kVVvr21dYUAtqmYmkdVuWva
	 PS5yDmUx+0w9nPgivh0w+5vaSp9XfsdcRFb9kkRDhAaXoRi5lrJGPcHoHr9wvVGf+U
	 Cu04xLMuPz3yw7g2+EXxkqrrZPbxHdkL2HkUsDfA/NW+0lEIMECd0ohKE5Jo1WD+pR
	 KmRdxOVEncZsA==
Date: Thu, 28 Sep 2023 18:14:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/12] dt-bindings: net: add phy-supply property for
 stm32
Message-ID: <20230928-pelvis-outhouse-28bb691bd790@spud>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
 <20230928151512.322016-4-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z+Q9ArmXRwc2oCyE"
Content-Disposition: inline
In-Reply-To: <20230928151512.322016-4-christophe.roullier@foss.st.com>


--z+Q9ArmXRwc2oCyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 05:15:03PM +0200, Christophe Roullier wrote:
> Phandle to a regulator that provides power to the PHY. This
> regulator will be managed during the PHY power on/off sequence.
>=20
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Tjanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Doc=
umentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 67840cab02d2d..8114c325a4eed 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -78,6 +78,9 @@ properties:
>        encompases the glue register, the offset of the control register a=
nd
>        the mask to set bitfield in control register
> =20
> +  phy-supply:
> +    description: PHY regulator
> +
>    st,ext-phyclk:
>      description:
>        set this property in RMII mode when you have PHY without crystal 5=
0MHz and want to
> --=20
> 2.25.1
>=20

--z+Q9ArmXRwc2oCyE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRW0YwAKCRB4tDGHoIJi
0p4/AP9+zFrcdUG4lft9L0yl+zWXuhbkd/AOM7N86NFMT57JlgEAh0jws3IZ/Vty
dGXkDN6EFYwVjejcIawKvNSaWv29VQI=
=2LGR
-----END PGP SIGNATURE-----

--z+Q9ArmXRwc2oCyE--


Return-Path: <netdev+bounces-32723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98258799D86
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 11:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DEA1C2085B
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 09:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164A23BC;
	Sun, 10 Sep 2023 09:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93169A49
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 09:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C6CC433C8;
	Sun, 10 Sep 2023 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694338783;
	bh=ysgPsq9QspCHPdVZ1NaI1wqrQYbL59Pa0hwTYZh34Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3i5HiRGNxsKaTMRC+nDxaeScpBzQq2QvqVKltUakavvPuMPRD8hp82/gdKep768f
	 S7omkx2VlYsBPhWdmbCgIRVEwPfsQkZxCEcBOYYJbhfkx3anVlHgXSDgy/upQY23F2
	 f0SbrOOc7v/H9zLOHoxM3sg88rhmJHbV/658hNtsxI30jJtoDyRHw7Jr4ha6Ksh7Ud
	 y5OJl+X/RFb9pnHqDkoS/Z7Mx1BaAf/Dg0JV6cjP4kPkgh/3Vrz4hkQ1evME/SPWfC
	 KxIu+9XFxu7tWBgEhzvKiNQoq4CaQ04SAnY4kgixGGBkFZDm8s4Mjb0bYhxBMFXUm5
	 NuvAaUogKpa/A==
Date: Sun, 10 Sep 2023 10:39:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawnguo@kernel.org, wei.fang@nxp.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, kuba@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH 1/2] dt-bindings: net: fec: Add imx8dxl description
Message-ID: <20230910-isotope-uncured-53d69b025137@spud>
References: <20230909123107.1048998-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7DpLp73U/PzOMoT"
Content-Disposition: inline
In-Reply-To: <20230909123107.1048998-1-festevam@gmail.com>


--i7DpLp73U/PzOMoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 09:31:06AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
>=20
> The imx8dl FEC has the same programming model as the one on the imx8qxp.
>=20
> Add the imx8dl compatible string.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/net/fsl,fec.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documen=
tation/devicetree/bindings/net/fsl,fec.yaml
> index b494e009326e..8948a11c994e 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -59,6 +59,7 @@ properties:
>            - const: fsl,imx6sx-fec
>        - items:
>            - enum:
> +              - fsl,imx8dxl-fec
>                - fsl,imx8qxp-fec
>            - const: fsl,imx8qm-fec
>            - const: fsl,imx6sx-fec
> --=20
> 2.34.1
>=20

--i7DpLp73U/PzOMoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP2O2gAKCRB4tDGHoIJi
0jpyAP0dvclFyo0iMw+7wMHdalTWBEOGqHTHl9OEZMugJPfSGgD/UmJBuWlsafdS
Tx9lrExixAw10OvS1Ygi/Wl7VGduQQM=
=dscV
-----END PGP SIGNATURE-----

--i7DpLp73U/PzOMoT--


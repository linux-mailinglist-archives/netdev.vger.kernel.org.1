Return-Path: <netdev+bounces-39604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBB7C0058
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C09D1C20B33
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5982744D;
	Tue, 10 Oct 2023 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciJ9Kh17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7C27442;
	Tue, 10 Oct 2023 15:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AF7C433C8;
	Tue, 10 Oct 2023 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696951560;
	bh=YodDTkaZ+bcycK00pqPePN0/QiKatfmhX9P+LMDLFh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciJ9Kh17CIbzsZylz9Dhiv6Ic/cVCJqmhTy+BBoVtfI8Cq2soIFi/cdmTU2nP5Ali
	 vFevqR3JKFBHM3dPd7Yjp6Fgr78K7+ZW91WBFidPz16aEv6054jmYAfpnLUEXBqn6I
	 biD0Ujni2GK+/Vt2ilLkU5DGIDbwREo3BpRuWCTdBG2YQLaRKepC907LBuUNUAAA/V
	 1ni/Upg+byAdumPHsEEJMu7YgpWhFbHPkEFI72rBl5oMhGphoAKw4Xch9YrgBmUJ+d
	 hsRwrpOO7T2Z5LOtnR2fn+cqWFPFeAU0BSDM/9BfhHweYHwoxXbypQYlqdzaw9Gniq
	 /C+0yQquSzcKw==
Date: Tue, 10 Oct 2023 16:25:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231010-unwired-trench-c7a467118879@spud>
References: <cover.1693482665.git.ante.knezic@helmholz.de>
 <df8490e3a39a6daa66c5a0dd266d9f4a388dfe7b.1693482665.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZK4vbLQNLyDEl6PG"
Content-Disposition: inline
In-Reply-To: <df8490e3a39a6daa66c5a0dd266d9f4a388dfe7b.1693482665.git.ante.knezic@helmholz.de>


--ZK4vbLQNLyDEl6PG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 03:18:54PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index e51be1ac0362..3df5d2e72dba 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -49,6 +49,12 @@ properties:
>        Set if the output SYNCLKO clock should be disabled. Do not mix with
>        microchip,synclko-125.
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock should be provided internally.

> Applies only
> +      to KSZ88X3 devices.

This should be enforced by the schema, the example schema in the docs
should show you how to do this.

Thanks,
Conor.

> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20
>=20

--ZK4vbLQNLyDEl6PG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSVtAgAKCRB4tDGHoIJi
0izpAP4vBdiuYP3WAEbZcqrN4YsfFf6tlXSryyiZH534hE8mvAD/V8bf4jyCgfGx
pDCsIx/r0oOw16zOeOu4EirMC52AUw8=
=hpzs
-----END PGP SIGNATURE-----

--ZK4vbLQNLyDEl6PG--


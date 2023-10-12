Return-Path: <netdev+bounces-40385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB717C7143
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF99282349
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E0F26E3D;
	Thu, 12 Oct 2023 15:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGuD6B3Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16042421C;
	Thu, 12 Oct 2023 15:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62640C433C7;
	Thu, 12 Oct 2023 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697123894;
	bh=ib4tVcVonMixI1OaRSfJ8k6/MBGpORgj2wRciIN3hFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGuD6B3Y4kGRzFfF+OHdIZKGMC3mk5oZ7/NsxSP/KgOEk2l4v7U3giA5yC4V2yoUI
	 ALFjgu3Iter3SXK53rgH0MNqNidH1ui7rLKpfSxT/oToFP6YZj0iYshbGOvF4mYZCP
	 BDrOKwCcTR5dZP+ix92yTYkvey50s+565Ay9NLsRzwwZZcC+09+/g/MykdNPAXAYmA
	 b1RapCYfkBnWXxUhpVL7MpiIuTpYCO+zzTW8fSQMv00VU7D+1rLjEx78TpmkbWuAEl
	 9Wq0yzECozGGuH09Egfq6KPAJkpLSFvIp1JHsBokmStGczuntXTd13vcMFUNOTdJNM
	 dGffdeMES2n7w==
Date: Thu, 12 Oct 2023 16:18:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231012-unicorn-rambling-55dc66b78f2f@spud>
References: <cover.1697107915.git.ante.knezic@helmholz.de>
 <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M6DiZrwt0r0ByUbo"
Content-Disposition: inline
In-Reply-To: <1b8db5331638f1380ec2ba6e00235c8d5d7a882c.1697107915.git.ante.knezic@helmholz.de>


--M6DiZrwt0r0ByUbo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 12:55:56PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++++++=
++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 41014f5c01c4..eaa347b04db1 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -72,6 +72,25 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock is provided internally. Otherwise
> +      reference clock should be provided externally.

I regret not asking this on the previous iteration - how come you need a
custom property? In the externally provided case would there not be a
clocks property pointing to the RMII reference clock, that would be
absent when provided by the itnernal reference?

Cheers,
Conor.

> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  not:
> +    required:
> +      - microchip,rmii-clk-internal
> +
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20

--M6DiZrwt0r0ByUbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSgOMQAKCRB4tDGHoIJi
0neJAP9d2qGGl2LH+I7VWMfbPU56oSDwdRC6pm1sFFw7lC9EOQEA+esT0L2AHZjZ
D4EAcuZ5Z8L6DtFVkVh8TbCerUm5eAo=
=LPuI
-----END PGP SIGNATURE-----

--M6DiZrwt0r0ByUbo--


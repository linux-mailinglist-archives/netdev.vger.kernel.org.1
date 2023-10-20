Return-Path: <netdev+bounces-43052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571577D1318
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 17:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A61C20F50
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35B11DFC5;
	Fri, 20 Oct 2023 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWuolx4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828451DDCB;
	Fri, 20 Oct 2023 15:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E17FC433C8;
	Fri, 20 Oct 2023 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697816744;
	bh=RTTrL8bUNOD9Virbg1xygXP66WsHbJ0SwSynqR3CXd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lWuolx4MVLTnaeD9lAtm+MCAk5SVuDGc3Lq0Zp0ECpUC1yDQsCD0seAS6GLzx1OZ5
	 uT+wxnrz7dlH8GY5G+EHqFWVHJ3vGbVEqhesje2R061MU5Op4OSYFvdjM9p0fY8nHm
	 HN1WvZ0/IGJMgLlzbVQETcOMTM+xCEWwrsHOV0xj1Tr85nkpXi75wf7PPQylGPNbLv
	 /+0maIs4vdS3JOJEkllH6GPhby1g5/3u01dwa0LkDjj8ttAL9KJIAP2j6DYPwZr5NG
	 eUw2BMkGrMs+QKk7HX9lJ1QRWViW9LNzk4QJBoZdNS5kNorqyajf6P1DnvOz/kt84y
	 Nu9mk2h+zbq8w==
Date: Fri, 20 Oct 2023 16:45:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch,
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, marex@denx.de, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
	o.rempel@pengutronix.de
Subject: Re: [PATCH net-next v4 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231020-agency-yapping-17ba240510c0@spud>
References: <cover.1697811160.git.ante.knezic@helmholz.de>
 <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fdIw5azgw3M22leo"
Content-Disposition: inline
In-Reply-To: <cfeeec0f41a815601439e999a8dc947525b0d938.1697811160.git.ante.knezic@helmholz.de>


--fdIw5azgw3M22leo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 04:25:03PM +0200, Ante Knezic wrote:
> Add documentation for selecting reference rmii clock on KSZ88X3 devices
>=20
> Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>

Something in the commit message explaining why a property is needed
rather than using the regular old clocks property would be good.
Please do that if you re-spin. Otherwise,

Acked-by: Conor Dooley <conor.dooley@microchip.com>

(and despite the domain, I have nothing to do with switches...)

Cheers,
Conor.

> ---
>  .../devicetree/bindings/net/dsa/microchip,ksz.yaml      | 17 +++++++++++=
++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml=
 b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> index 41014f5c01c4..624feb1bb9be 100644
> --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> @@ -72,6 +72,23 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  microchip,rmii-clk-internal:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Set if the RMII reference clock is provided internally. Otherwise
> +      reference clock should be provided externally.
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        enum:
> +          - microchip,ksz8863
> +          - microchip,ksz8873
> +then:
> +  properties:
> +    microchip,rmii-clk-internal: false
> +
>  required:
>    - compatible
>    - reg
> --=20
> 2.11.0
>=20

--fdIw5azgw3M22leo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTKgogAKCRB4tDGHoIJi
0ijRAP492S8PEzqJeTIZB2c+40q4jZzHJi+JGa2i7Li8kg5hwQD/Ykbw86XHgUeU
zVR70acAT3f7YQwvYo2I8YqyIb73KgI=
=PzQ0
-----END PGP SIGNATURE-----

--fdIw5azgw3M22leo--


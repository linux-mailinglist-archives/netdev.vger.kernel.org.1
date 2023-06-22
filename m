Return-Path: <netdev+bounces-13195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62C573A933
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A80281AB2
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180BA21080;
	Thu, 22 Jun 2023 19:55:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E46200C6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A4C433C8;
	Thu, 22 Jun 2023 19:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687463702;
	bh=/Y3hDobY50UVjtDFqg+IraerI8qLf+JHDe3DFP5DZNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FHO5bqdKzTmfFARCy6yMYqX9cFKuDjqxGHm77u9dM/S/d6ZigzqGEKIKSmZS6+dKj
	 IIVJQiytOhSdzOJIvZlM/TCOex53Vsw/t5AeksiOyYJvrl7U0TQifGsnJ1X7+P4v3Z
	 5iHdlaGEzxgs0ISDke4AOS0i1YyLmgfoMN8FOhrCzYpXK9Jdn9/YLsxW8cpfSyty/2
	 yZOtOeM+5trESt1nnk1+1JqokAcvHfgOgJ1MHaMxVBZlHJch69tlYSiFdlS5NiGfaF
	 eT0qs5/KAUjsj23kbJ9qS5Y87DXfU1YUvre67z3vErEHZIM9LcrSYmOPbFJo5gnORL
	 Xx1Tcb6AfNCzQ==
Date: Thu, 22 Jun 2023 20:54:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: altr,tse: Fix error in
 "compatible" conditional schema
Message-ID: <20230622-germless-unless-02d29924ddf2@spud>
References: <20230621231012.3816139-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a/Cjr6/h5jMrqHAk"
Content-Disposition: inline
In-Reply-To: <20230621231012.3816139-1-robh@kernel.org>


--a/Cjr6/h5jMrqHAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Rob,

On Wed, Jun 21, 2023 at 05:10:12PM -0600, Rob Herring wrote:
> The conditional if/then schema has an error as the "enum" values have
> "const" in them. Drop the "const".
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

You waiting for some of these to land before updating dt-schema?

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/net/altr,tse.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/altr,tse.yaml b/Docume=
ntation/devicetree/bindings/net/altr,tse.yaml
> index 9d02af468906..f5d3b70af07a 100644
> --- a/Documentation/devicetree/bindings/net/altr,tse.yaml
> +++ b/Documentation/devicetree/bindings/net/altr,tse.yaml
> @@ -72,8 +72,8 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - const: altr,tse-1.0
> -              - const: ALTR,tse-1.0
> +              - altr,tse-1.0
> +              - ALTR,tse-1.0
>      then:
>        properties:
>          reg:
> --=20
> 2.40.1
>=20

--a/Cjr6/h5jMrqHAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJSnEQAKCRB4tDGHoIJi
0ms8AQCmtnDqlu3WQfbAKGmFyABvaTBCVbHGQ5/+gOrtZoyTDQD/Scy8/gY7sVIA
Y9M1+ImUvdMHcOEcNeAR4HeOFR+CiAM=
=V1Bu
-----END PGP SIGNATURE-----

--a/Cjr6/h5jMrqHAk--


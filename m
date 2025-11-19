Return-Path: <netdev+bounces-240114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D84C9C70AE6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1EDC353495
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 18:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B37242D69;
	Wed, 19 Nov 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOgLihFq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9B3191C4;
	Wed, 19 Nov 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577672; cv=none; b=afcQRVqVaErkXOlJsH8Wwn3bXnSK6yvgErszE7aYWtTuxt+/6u5B7D4oM/ys/oWINeZmW0Dx+POtP8lYU36xw+Txz9ty3bXkb+wHnAWdWm58mvKWyKpW0RcNhLjqgfa0DVlCD5sl/TYxbqXegccYr/GlljUd5AP+3cvcKIZZ+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577672; c=relaxed/simple;
	bh=jPiEf9D0enUbIPbwxeeiH63YOLo0c0B5JvI5bNTryrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXa1wmWTci4AdcHWRNq5cZab8Zi7tsCavF5iTmAbWX1U2yYI7bpxyPVzO1F9pWFxu2x+GjX4pixl+Iujbuz+82uMzHECdSnEbOifMoJxqfAbzgkAlZ1b12ji6URq82xTkAcRvbMacLIesEqI0Q2XeH8LCmMRygbaW0tGVFvZaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOgLihFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83CDC4CEF5;
	Wed, 19 Nov 2025 18:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577670;
	bh=jPiEf9D0enUbIPbwxeeiH63YOLo0c0B5JvI5bNTryrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOgLihFq4e/zbXry3OmMxJlk6/wjfu+Jr63VKL/cUMy8nfY0GxXWpBkKYZ1QGc0pk
	 Um07NKpisn+tyRjh2S/CXmXsUP+rEuir7t5OsaER3oyjiogna/0vI5rFEoiE1KF0yt
	 qdfubygGYscPwGZWQX58N7otP6RQ8wxvOwoHBFY7pE8B7jbUxwJl0WIfleN6HIOruG
	 UrN0npsdRbxaD41STo+S2rD1KA8Pv7d+0JAutXnz/HUO7YYgSoyP84CD07pW8NFWW3
	 FYAR3znkbbNwNFk7Etp1O1A4Ekbi2Uj3RWiWDvGyHx8tfdkad/o2xcSnTRDZ9akjzu
	 pVDIKc8TNSA5g==
Date: Wed, 19 Nov 2025 18:41:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Jeffery <andrew@aj.id.au>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: aspeed: add AST2700 MDIO
 compatible
Message-ID: <20251119-gooey-wifi-413598a8a1d7@spud>
References: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bWqpCW/1YghVWvY"
Content-Disposition: inline
In-Reply-To: <20251117-aspeed_mdio_ast2700-v1-1-8ecb0032f554@aspeedtech.com>


--2bWqpCW/1YghVWvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 03:30:18PM +0800, Jacky Chou wrote:
> Add "aspeed,ast2700-mdio" compatible to the binding schema with a fallback
> to "aspeed,ast2600-mdio".
>=20
> Although the MDIO controller on AST2700 is functionally the same as the
> one on AST2600, it's good practice to add a SoC-specific compatible for
> new silicon. This allows future driver updates to handle any 2700-specific
> integration issues without requiring devicetree changes or complex
> runtime detection logic.
>=20
> For now, the driver continues to bind via the existing
> "aspeed,ast2600-mdio" compatible, so no driver changes are needed.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml | 8 +++++=
++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.ya=
ml b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> index d6ef468495c5..1c90e7c15a44 100644
> --- a/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/aspeed,ast2600-mdio.yaml
> @@ -13,13 +13,19 @@ description: |+
>    The ASPEED AST2600 MDIO controller is the third iteration of ASPEED's =
MDIO
>    bus register interface, this time also separating out the controller f=
rom the
>    MAC.
> +  The ASPEED AST2700 MDIO controller is similar to the AST2600's.

This statement disagrees with your commit message that claims
functionally identical, and implies that the 2700 supports some extra
features or whatever.
I think I'd drop this entirely from the patch, rather than try to reword
it. Remove it and then:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

>  allOf:
>    - $ref: mdio.yaml#
> =20
>  properties:
>    compatible:
> -    const: aspeed,ast2600-mdio
> +    oneOf:
> +      - const: aspeed,ast2600-mdio
> +      - items:
> +          - enum:
> +              - aspeed,ast2700-mdio
> +          - const: aspeed,ast2600-mdio
> =20
>    reg:
>      maxItems: 1
>=20
> ---
> base-commit: c9dfb92de0738eb7fe6a591ad1642333793e8b6e
> change-id: 20251117-aspeed_mdio_ast2700-aa089c4f0474
>=20
> Best regards,
> --=20
> Jacky Chou <jacky_chou@aspeedtech.com>
>=20

--2bWqpCW/1YghVWvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4PQQAKCRB4tDGHoIJi
0sqUAP9r+wKYrCdpXMLj+cK8mnW1jeDSeXieLhR1kXkxcYrCUgEAvz3f7zkatpMU
AoB7sxn/YdlOC4WEHCby7J2J47TRzAo=
=rJkd
-----END PGP SIGNATURE-----

--2bWqpCW/1YghVWvY--


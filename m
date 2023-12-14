Return-Path: <netdev+bounces-57557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A62881361B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D41C20D4A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6675F1F1;
	Thu, 14 Dec 2023 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAa61Vz1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0365EE86;
	Thu, 14 Dec 2023 16:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A04C433C8;
	Thu, 14 Dec 2023 16:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702571033;
	bh=i9cOYx/Gayn1zgR+NrAJh8IzX0ZjGHvQDZb6Hpxnipo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NAa61Vz1CS4IUtt7zsP4Cre/tCNw+loHnsPAbhOM3KapWjC9d+uQ+yF5C4Pw5+L51
	 xB0UWCLEaYPgbp0vyePULtL9N/X0QNnM0ou0RjK4tqu18067LjrN+W8zU0f0EDx71h
	 kWyuXlhsw9LOtyCcFboBMvNXkaVAjlHSiMJuZb7fR/LJ37yjOrDjKkH8Vz/+vc5hDk
	 +YxZ8bB5sqEYCsMNUiNyUukhX1IsRHcFg3u8xUYNXx+SUD8euLturiXSEGA9DLz9Wm
	 wiiT15ijd4cNaJ34S6Dh1davDIfUSsjLUhoaXe/k+ht5gIdFeDQEOC4dp0ZGqhzyeK
	 GH2xfDXrcUsFQ==
Date: Thu, 14 Dec 2023 16:23:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: marvell,orion-mdio: Drop
 "reg" sizes schema
Message-ID: <20231214-buzz-playlist-2f75095ef2b0@spud>
References: <20231213232455.2248056-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="egZ0O0hNuZugmFUi"
Content-Disposition: inline
In-Reply-To: <20231213232455.2248056-1-robh@kernel.org>


--egZ0O0hNuZugmFUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 05:24:55PM -0600, Rob Herring wrote:
> Defining the size of register regions is not really in scope of what
> bindings need to cover. The schema for this is also not completely correct
> as a reg entry can be variable number of cells for the address and size,
> but the schema assumes 1 cell.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Does this not also remove restrictions on what the number in the reg
entry is actually allowed to be?

> ---
>  .../bindings/net/marvell,orion-mdio.yaml      | 22 -------------------
>  1 file changed, 22 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yam=
l b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> index e35da8b01dc2..73429855d584 100644
> --- a/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/marvell,orion-mdio.yaml
> @@ -39,28 +39,6 @@ required:
>  allOf:
>    - $ref: mdio.yaml#
> =20
> -  - if:
> -      required:
> -        - interrupts
> -
> -    then:
> -      properties:
> -        reg:
> -          items:
> -            - items:
> -                - $ref: /schemas/types.yaml#/definitions/cell
> -                - const: 0x84
> -
> -    else:
> -      properties:
> -        reg:
> -          items:
> -            - items:
> -                - $ref: /schemas/types.yaml#/definitions/cell
> -                - enum:
> -                    - 0x4
> -                    - 0x10
> -
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.43.0
>=20

--egZ0O0hNuZugmFUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXssFAAKCRB4tDGHoIJi
0pixAPwNgOnRCXWNYCkXX0M7j++l5pDAq9K5Z0tCgSSn1UjfvwEAiqBUm+qx9bhF
d1itS4+VsRTjBeGiiR5fJiry2jVTtQs=
=sfO/
-----END PGP SIGNATURE-----

--egZ0O0hNuZugmFUi--


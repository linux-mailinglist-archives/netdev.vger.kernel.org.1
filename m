Return-Path: <netdev+bounces-21020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F037622DE
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0955C2819AF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE9326B1D;
	Tue, 25 Jul 2023 20:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1EA26B03
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C47C433C7;
	Tue, 25 Jul 2023 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690315281;
	bh=lwzgyo/hKAuFK/GizHWHih6d+oZtsu+UCV4ITL+g4X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrvRwTSL077Nhz2abeL01Pl1y5Rq3ZIGKTyA15Yk5lIHqflXYSmAf+nqBLIYPHEzx
	 a8MWyRLwFC+YS1tlEKiB+fWJ6FLK6yJ6IEYceXAZwhmfp6djVDfP4x8cEmnqjSYdig
	 qU6qH8X/47ooz+FIbb4yLDlz/UjMtIUGoHjdDE7T9RnpUMQ6s+vMio1PZ+n7rWvqTI
	 gtXCqKTgriWfMH+6lP3p4Cd4gGmRYwB7Z1878yE5ZbWsREG8MF+cZoXxtNccdDKJyO
	 mvJ65AnJTJdWs1i9qAu8FqfVBb1WtAgjakwNOJjswfVuy1bGQDHJQZrSH9EQtCB3MX
	 sTc5OfTuyUwYg==
Date: Tue, 25 Jul 2023 21:01:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing
 unevaluatedProperties for each regulator
Message-ID: <20230725-suggest-juggle-c062521399f9@spud>
References: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ot+MAbhOrYmNPSVw"
Content-Disposition: inline
In-Reply-To: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>


--Ot+MAbhOrYmNPSVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2023 at 02:37:11PM +0200, Krzysztof Kozlowski wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>


> ---
>  Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Docu=
mentation/devicetree/bindings/net/qca,ar803x.yaml
> index 161d28919316..3acd09f0da86 100644
> --- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> +++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
> @@ -75,6 +75,7 @@ properties:
>      description:
>        Initial data for the VDDIO regulator. Set this to 1.5V or 1.8V.
>      $ref: /schemas/regulator/regulator.yaml
> +    unevaluatedProperties: false
> =20
>    vddh-regulator:
>      type: object
> @@ -82,6 +83,7 @@ properties:
>        Dummy subnode to model the external connection of the PHY VDDH
>        regulator to VDDIO.
>      $ref: /schemas/regulator/regulator.yaml
> +    unevaluatedProperties: false
> =20
>  unevaluatedProperties: false
> =20
> --=20
> 2.34.1
>=20

--Ot+MAbhOrYmNPSVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMAqDAAKCRB4tDGHoIJi
0pTaAP4xqWscNl1Z2K7dWlggYN0rr87fskelc5n8AGihPxrlWgEAlBqN8MbJJRlI
GgDx+30oEkC/nReimgsm95+i0bISdgU=
=UjTP
-----END PGP SIGNATURE-----

--Ot+MAbhOrYmNPSVw--


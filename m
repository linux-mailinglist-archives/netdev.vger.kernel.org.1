Return-Path: <netdev+bounces-149498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E3B9E5CE0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3631216212B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47F722259A;
	Thu,  5 Dec 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqXVxizw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953C21C16C;
	Thu,  5 Dec 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419145; cv=none; b=CBOUy1F9kKOngsjToKruX30k/btcjvsgEG+Y38sKgsgUTbE+mfhf+oezvWgNDsadh1rp7e7H6O4IZHMj+J3yLdc1lF5mHH6NjUInRYzveeKuQJ60Sav9NYPqE3MEBOgZPyW8moLXnpPH4PAyzMGB1kEvZtPsV625dBLzjWdwqKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419145; c=relaxed/simple;
	bh=VsHwaUKv8NduryaYVZPPWuh8ZJKhLgoxE8VFqbLnXXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfvREG6BICa+u7Pp1Ml/++VdzzzNic/pFpZu3vVmZDfx0+DIi7ALUltyd4zoS28b0wY4U1Pn8f94vHDXiZ+VnYpghZ4IPsbEpSsbQoQKKT96CMOGwTLFUHWHaHLjad0sMkeuq5lhF1Lu2UD9JWHwRZc9R/L2EqFH1jhjncm4FSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqXVxizw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20443C4CED1;
	Thu,  5 Dec 2024 17:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733419145;
	bh=VsHwaUKv8NduryaYVZPPWuh8ZJKhLgoxE8VFqbLnXXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iqXVxizwcvQkD9rq3KFgJyvFuOdHzgaQO8kBF39WBbeNcav25kluxu3pPGntKJaig
	 RkxMrbzDY2Ei5bHfBWTbiSjbGLfW8YfebfXURg+CmduSThPpYppBvMCF1hWyvhgB2c
	 WC0sQEbkPUAWMx7+yvX35+GzorEtlc81sGCYWQM06OOFKJps0L9JOCFjdDCiQjVhbg
	 nc2JRnQ+jThNFzZRjA/degil7VDUjEwBPIdvD8C6zBqWnPAqMzTLgKZ6DDmCXIqZWh
	 R1BdL5pKk5U87ncZ7HQZI8boarF//m8eYLDzEnASkmevuobDXSMv2pKIym8COqD35P
	 HwdRhC/5PC3YQ==
Date: Thu, 5 Dec 2024 17:18:59 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 1/5] dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
Message-ID: <20241205-immortal-sneak-8c5a348a8563@spud>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mjIsdWncN73NzB2k"
Content-Disposition: inline
In-Reply-To: <20241205125640.1253996-2-o.rempel@pengutronix.de>


--mjIsdWncN73NzB2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 01:56:36PM +0100, Oleksij Rempel wrote:
> Introduce devicetree binding for the Texas Instruments DP83TD510
> Ultra Low Power 802.3cg 10Base-T1L Single Pair Ethernet PHY.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/net/ti,dp83td510.yaml | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,dp83td510.ya=
ml
>=20
> diff --git a/Documentation/devicetree/bindings/net/ti,dp83td510.yaml b/Do=
cumentation/devicetree/bindings/net/ti,dp83td510.yaml
> new file mode 100644
> index 000000000000..cf13e86a4017
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,dp83td510.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI DP83TD510 10BaseT1L PHY
> +
> +maintainers:
> +  - Oleksij Rempel <o.rempel@pengutronix.de>
> +
> +description:
> +  DP83TD510E Ultra Low Power 802.3cg 10Base-T1L 10M Single Pair Ethernet=
 PHY
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ethernet-phy-id2000.0181

There's nothing specific here, can someone remind me why the generic
binding is not enough?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-phy@0 {
> +            compatible =3D "ethernet-phy-id2000.0181";
> +            reg =3D <0>;
> +        };
> +    };
> --=20
> 2.39.5
>=20

--mjIsdWncN73NzB2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1HggwAKCRB4tDGHoIJi
0mbBAQCXfiVmatNc13W2wjQPVHIfWlcAcWN2O6DRjLQbv3T9bgD9HC5cLIkqrx8y
ta22P06gmsmSfDEpMhRxajj8S8YG7AM=
=lKMn
-----END PGP SIGNATURE-----

--mjIsdWncN73NzB2k--


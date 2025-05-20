Return-Path: <netdev+bounces-191932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05EFABDF76
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663C68A530B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22AA2609FD;
	Tue, 20 May 2025 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDHIr2AL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAA2405FD;
	Tue, 20 May 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756064; cv=none; b=b/AHerSRhVhr4ZGWlJ/4wGl3nkN6BFuHstg8W8YyLFKAEaQq8CtHZPbSsIBdFOsvh5wXGl4gWdg/GRXUTDJ/3AdT2T9eyF67J8jvOgZMSlPOpds+XXczXVw8UuVzY6yU4/qyVuulXJeWyFRoyB8CrlLCLwLU+TuMgt3i+TXlpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756064; c=relaxed/simple;
	bh=Kx5G6jb5VVr3oqqGbr04JrYV0NFaNI05NayVcBLr/w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEEjyBEaFL++tdF5Xik1bA4gM9mK5aZ5c2p/f1MDsH8mC4hzrh8i5O3jb25zu4Jq5Rhigc5/HEQDFcilTMt/QdNnbVznj5lwfeLajfHAIXLot9v3CkBBFZSjXHehkRauAyuKNwtXbeeduUZgoRotJhu+WDef9VF0RlT58+USN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDHIr2AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6480CC4CEE9;
	Tue, 20 May 2025 15:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756063;
	bh=Kx5G6jb5VVr3oqqGbr04JrYV0NFaNI05NayVcBLr/w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDHIr2ALlh8Morhko7v8apJ8Wf7asZINSwivtyHAkUn9ZrbEKdsayhHxZXZh4H+4R
	 Z7qxw5zKWSJGNISJvIzArsoDxoXB2buC5LyPKDBNpPJr7O2MZUxOaxZaw+kpW7d5Cb
	 qj48E+LAch77GIp6/cqnk13gPn3LIDDyS5QDyRcvM/Tdh513xGXroq6pmuAdjnP1Qe
	 cfwOsBrw6lNPMb7+gCZT+NDIHqIzRroJQfireRm6trozaM+8Xjv8IZCPfNyS/v4gZ4
	 SyDv93Q91Kh/KVnQ6AC1RwUzsRNMvruQ8QL8VizeKjtyO2s21zuvV0DPGgN3I575J1
	 tPbBN43Jku3qA==
Date: Tue, 20 May 2025 16:47:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au,
	andrew@codeconstruct.com.au, mturquette@baylibre.com,
	sboyd@kernel.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [net 1/4] dt-bindings: net: ftgmac100: Add resets property
Message-ID: <20250520-creature-strenuous-e8b1f36ab82d@spud>
References: <20250520092848.531070-1-jacky_chou@aspeedtech.com>
 <20250520092848.531070-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vqRuqlVkPNRifbyp"
Content-Disposition: inline
In-Reply-To: <20250520092848.531070-2-jacky_chou@aspeedtech.com>


--vqRuqlVkPNRifbyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 05:28:45PM +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and
> RGMII/RMII.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml=
 b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> index 55d6a8379025..f7af2cd432d3 100644
> --- a/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> +++ b/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml
> @@ -35,6 +35,11 @@ properties:
>        - description: MAC IP clock
>        - description: RMII RCLK gate for AST2500/2600
> =20
> +  resets:
> +    maxItems: 1
> +    description:
> +      Optional reset control for the MAC controller (e.g. Aspeed SoCs)

If only aspeed socs support this, then please restrict to just your
products.

> +
>    clock-names:
>      minItems: 1
>      items:
> --=20
> 2.34.1
>=20

--vqRuqlVkPNRifbyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaCykGAAKCRB4tDGHoIJi
0ldUAQCs0SeY54j9yeQV50Qs6FaOw51w5rsiRnuKhNfqKgBERAD/bi4/ULFOC+eK
hIqwX2TOHjPWTh/uDyZS4qnyKuCRnAs=
=5R4U
-----END PGP SIGNATURE-----

--vqRuqlVkPNRifbyp--


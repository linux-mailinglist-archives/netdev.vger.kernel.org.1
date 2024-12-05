Return-Path: <netdev+bounces-149496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05A69E5CD4
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758DA284F5F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808A7225778;
	Thu,  5 Dec 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGxelnSm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546507E105;
	Thu,  5 Dec 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418980; cv=none; b=spzfjSPJj2wXNZdIbWTqHqt4Hx+oxQmRMqmvuz/W/tVeOzFGDUcibkv9TnYpD5rR3pWAbAk3V5Smji5ZYz+VLBEzW0tFDOu5mCyCV458BsyWGxH+JMStfLLBuVW/CrlIQRgFisr32JGBffGIQZSAU2zUSEyoKQ0mdfZVf19c90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418980; c=relaxed/simple;
	bh=ll/pqBlh7VQdZrfl40Y3GRd2AxpRWeO2O5BqSRhjrXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mhn2Oozg6kmdWU3apIee0BV0mm3GoHolw6YqTLz3/pYyHGDz/CBcWzeZR0jrzKdG/nPv9XlxPg1o2K6Nd34lfpraKbuyPuYlftbQMhrj8p/1S6xKQOsZ/NIzDaPHz1M/Qj2/p7Lj8GkiTR36szePTIrNPPospvrGWqvcbDXORx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGxelnSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A18C4CED1;
	Thu,  5 Dec 2024 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733418979;
	bh=ll/pqBlh7VQdZrfl40Y3GRd2AxpRWeO2O5BqSRhjrXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGxelnSmP2fi+QBtv0TaH/Q9nACsWEbMiXTzcVD8FSQHtVUZmxSLiisduv91ug+sS
	 Ax5e/T0z+6bvflbNCWXVu47JOFQRYk7k6HmJYDoCCwditaCWxk4O2fJ3AWlSo4fzua
	 Uf7/+C9qjPN37R2kGgv6k78I5ZLIOtoJ6vVrYqkLT78lSYMkOJpmBAT4mTRI+QFIwM
	 tv555atqTSfiYtDUEe4wuTnR8GZCmULXsaUg6uMaBo2IbSWPqD+opXDzaQwGbFNsqb
	 vH+pPl3AQa3oSI8fHxfOqVisVWNpp9sHWglYH14WkcCIzTkdajm+dEi57YY+zUQbvB
	 f7QmOrNvl4H6A==
Date: Thu, 5 Dec 2024 17:16:14 +0000
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
Subject: Re: [PATCH v1 2/5] dt-bindings: vendor-prefixes: Add prefix for Priva
Message-ID: <20241205-hamstring-mantis-b8b3a25210ef@spud>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RfxN6UD6pYJLj5Ip"
Content-Disposition: inline
In-Reply-To: <20241205125640.1253996-3-o.rempel@pengutronix.de>


--RfxN6UD6pYJLj5Ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 01:56:37PM +0100, Oleksij Rempel wrote:
> Introduce the 'pri' vendor prefix for Priva, a company specializing in
> sustainable solutions for building automation, energy, and climate
> control.  More information about Priva can be found at
> https://www.priva.com
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index da01616802c7..9a9ac3adc5ef 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1198,6 +1198,8 @@ patternProperties:
>      description: Primux Trading, S.L.
>    "^probox2,.*":
>      description: PROBOX2 (by W2COMP Co., Ltd.)
> +  "^pri,.*":
> +    description: Priva

Why not "priva"? Saving two chars doesn't seem worth less info.

--RfxN6UD6pYJLj5Ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1Hf3gAKCRB4tDGHoIJi
0vCCAPsHVLh5ARoGVS/2vGmP95xh8i6OPSPvwg87l4tT5DQKGAD+OrSsG3fRMkAH
BhsrJpztvvaJq8afTPZtjQh4PQEPlQc=
=4PKr
-----END PGP SIGNATURE-----

--RfxN6UD6pYJLj5Ip--


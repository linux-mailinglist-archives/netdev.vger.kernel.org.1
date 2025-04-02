Return-Path: <netdev+bounces-178804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0FBA78FC6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7498A1894381
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E23523908C;
	Wed,  2 Apr 2025 13:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHQr1qkE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FA11EF360;
	Wed,  2 Apr 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743600545; cv=none; b=kp8U/B4Kf9X80KaysoBfxSnG/5rtoVcsWEQsAUN5hxzhXi356/7wQNSFcNE5FAceKqIyS4s88mOmd/Wqd13Cu/IDJTzZkJuPtvQUs9tkHs/yvn8c8bkYfWChnsm1nrf8lFmdJ4m8aUNAJW8yCLrKrz4xje/UiOYW0pXly17HcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743600545; c=relaxed/simple;
	bh=J8Cb8WfrOi04FgY+I+b68wymSxxbztaQD6sKD+oS7zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7ZIwhXH/9DcxxDNRNKiN6Ekk4tAy81BIvbkrJpxsjENB1ZKKf9oD0XZaGOr0I8JTdudHjOJHatGueXLE/1nEt95PnhfYe/fvO/2CO9kIPNoFh2UVTi3fKjnfRDdU7rumYPbGWNQtmWNc8xogNA+VfIno3OfDpTE42VM2T7vTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHQr1qkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D19C4CEDD;
	Wed,  2 Apr 2025 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743600544;
	bh=J8Cb8WfrOi04FgY+I+b68wymSxxbztaQD6sKD+oS7zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHQr1qkE3buusVy8ANjaLnBQ4zFUyD7GilFdYyHgonPwzXV4aOCz4Y9erDD26d/jY
	 f5yO9EoQXQjoJFF0wd2cfxPa3hwTQYqJxD/GgOAPbx3ewUN5oS/8qQXZrlwHSaGtc7
	 6eXf+l8fvvg/MLbu09N9vycPmtgAx6SrALgiZdi4rMfD7VOQ2lsYEqD27M+jbaNIPa
	 eVfcbagk0M6Cpz/2z4yxYDgS68pqrtgz3dOSmCgNshDmhnZfRuWTQ+2//mQVJnQOQT
	 0mS0vVIHFqktcXzu5bnWyX9oJ4TjbU+nGSbYxKemOtgrSJzial7Jyv4SeFbg/yPuKt
	 HQqyqoA510bGw==
Date: Wed, 2 Apr 2025 14:28:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan.Wanner@microchip.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: net: cdns,macb: add sama7d65 ethernet
 interface
Message-ID: <20250402-scribing-doorknob-53a67e9e27cd@spud>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
 <392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZH+IhbSqEBnXm3HD"
Content-Disposition: inline
In-Reply-To: <392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com>


--ZH+IhbSqEBnXm3HD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2025 at 09:13:17AM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>=20
> Add documentation for sama7d65 ethernet interface.
>=20
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index 3c30dd23cd4e..eeb9b6592720 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -62,6 +62,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,sam9x7-gem     # Microchip SAM9X7 gigabit ethe=
rnet interface
> +              - microchip,sama7d65-gem   # Microchip SAMA7D65 gigabit et=
hernet interface
>            - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit eth=
ernet interface
> =20
>    reg:
> --=20
> 2.43.0
>=20
>=20

--ZH+IhbSqEBnXm3HD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ+07mwAKCRB4tDGHoIJi
0oaaAQDZCHsKizxzSW01d9pShvwWkQbjhsKYMyc+Dx+WthYU/AD/QMHJfPRMRa92
2cV+g+ELOsKdCKbzefq6+0KCssfZrAg=
=l9g7
-----END PGP SIGNATURE-----

--ZH+IhbSqEBnXm3HD--


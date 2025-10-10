Return-Path: <netdev+bounces-228538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F1BBCD9BB
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AC33AF58C
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941F2F6182;
	Fri, 10 Oct 2025 14:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3OeukVv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB012F5A33;
	Fri, 10 Oct 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760107788; cv=none; b=e5Zoe2hbZYvfrIlSYhUk9hazywReqO+z41IQY5aHMxAQJrZD3jjZkDd0t1FeeqSxsJCYWVzNBRycgNHyqgYgP5Ms8uN+B02zQbe8u8A0BzbUHdW1oweEH7g5zSyE9hACyiwSVFN0CTGsmEpijDQ+skIXm3m4+zUzoIgKltatcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760107788; c=relaxed/simple;
	bh=e1bcvsoWZNLQobGksLmW2VF9li2+bkiUFOuPrW1bo/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIDty3L0tTYAHrZFIPC5MvUZOG+X/nJxoaI+bPF//R5TjECYPRRuYZIRKRt3YOgor6+A9lnYvbkPhMb5jD9VFLPZIbsy4Ku0F81WX6DEojbw012T6VREg6aDxmvESIuk+PT0qZyFZXxX+Ta/RWmRd7ccn4KiqPx43/1Cj3eThSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3OeukVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813FC4CEF1;
	Fri, 10 Oct 2025 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760107787;
	bh=e1bcvsoWZNLQobGksLmW2VF9li2+bkiUFOuPrW1bo/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3OeukVv9ab/fLuTN2A6/BfzhxyvshB8YrWwYXMmQ1a+gsss0ocL3K6P8Esrc+MyL
	 Qj5NElOYaDmAsmKTViosjOL3HQuwPrQ/2alfbQFAil9TN6bUtLPrt8ZP5kL6nMyZoo
	 jasuTYVwBzQ3RVFsZ/ew14wKEYf+k1OrIrR/ft02/wc8nEKSESMYbrQnGLTtexfBDL
	 EOkPa2pVax0ggYySCJs842i2bbqj45olb4l66NHU8M0fT04Pl8VgVBZsCxN3+asGqK
	 zFtnFm0772BDC8Ipb0U1FB1fsSxBqEnDXv3At2+0xT70bXIGZO0waheGaAsBB9SYUc
	 zdGDS+U2BBFnQ==
Date: Fri, 10 Oct 2025 15:49:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Wismer <thomas.wismer@scs.ch>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
Message-ID: <20251010-strudel-pagan-162308e183e2@spud>
References: <20251004180351.118779-2-thomas@wismer.xyz>
 <20251004180351.118779-8-thomas@wismer.xyz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhdFBT2hggI1LJAn"
Content-Disposition: inline
In-Reply-To: <20251004180351.118779-8-thomas@wismer.xyz>


--hhdFBT2hggI1LJAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 04, 2025 at 08:03:53PM +0200, Thomas Wismer wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
>=20
> Add the TPS23881B I2C power sourcing equipment controller to the list of
> supported devices.
>=20
> Signed-off-by: Thomas Wismer <thomas.wismer@scs.ch>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yam=
l b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> index bb1ee3398655..0b3803f647b7 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/ti,tps23881.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - ti,tps23881
> +      - ti,tps23881b
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--hhdFBT2hggI1LJAn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOkdBgAKCRB4tDGHoIJi
0tvoAP9asRWEu2vGy95zW9p7nwFO085CCdV5tmNlHYrbrQnycQD+PHtOm9g2iR4y
1B1ZLGs/cyh4zZe0vZFTG5Ph8gGuRAo=
=9FWq
-----END PGP SIGNATURE-----

--hhdFBT2hggI1LJAn--


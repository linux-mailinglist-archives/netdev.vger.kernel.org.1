Return-Path: <netdev+bounces-130399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3598A5E5
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5701C224C3
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5518FC89;
	Mon, 30 Sep 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkmEAuNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4137A4D9FE;
	Mon, 30 Sep 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704332; cv=none; b=b6ZevhylbBuFQEVR0Trm1kKGypNGPRxfJABDWQNW7Uq9K6YFZxcWvIeIc3mx6L5lB3dGh9dkAhWhwOspZ588mqtxwQZZyypewx+YE+yH+My7Z+/bMwjoDXnirn2hO/ebrfRivSQBjpfas4TQqKw8quMbR8sG/Ur3HOqiW6cWHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704332; c=relaxed/simple;
	bh=gRyrUqnsVTZ04DmjZlOcDqqFW1akJcUB1uvMMHzWt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA/865aRlkxqkVQOi2H0PPrIsOEgYyg7Iz/x1+rwlUe1omIcXkvNwFLEpiVUrf1iOAOvZUnS5f6OFz5I9UCuTBT0S0i0n4BY4/3fSPQ5vD40MMQGOx1xrAhpPixK31cSt1e1eebhRE4QkkO3rMZjP8kEY2WdvAKFElNDGzPYdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkmEAuNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E424EC4CEC7;
	Mon, 30 Sep 2024 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704331;
	bh=gRyrUqnsVTZ04DmjZlOcDqqFW1akJcUB1uvMMHzWt/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkmEAuNSoHxHqmL+ZHpv1567Q5bOr3gONzre5aoFoX1ZHarVqStk5kAtUZMLtmdeE
	 1U24YHV/DmKJ16BasnQGdBitG+8xfp+DnQZuUbbTPKpYQgFEH1/ajaaygtBUlIRKYb
	 PLJnNJ528IYlIiY4OIPJGSdW+TnLROp8sbWZqx2zeIQx10YpHBRqe4AuBvJOVOmfn6
	 wDG0IeVgmOC6yed1zJlrJDa0pAKbItWpbE/UoxJdz+GEldR7PzW3wNfzBtQOKCqDb+
	 SlQG6tsBwp/vc/2jolqwjzZig1wWcsg8v9RXXTKWU1G++ZT6msaqjRrWr2UuPB56Kx
	 1Ns8/9EzdGsvw==
Date: Mon, 30 Sep 2024 14:52:06 +0100
From: Conor Dooley <conor@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 12/20] dt-bindings: net: cdns,macb: Add PIC64GX
 compatibility
Message-ID: <20240930-unify-scratch-bbc8adf4e39d@spud>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-13-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OLuPF48/Wq3esOBj"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-13-pierre-henry.moussay@microchip.com>


--OLuPF48/Wq3esOBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:41AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX uses cdns,macb IP, without additional vendor features

That's not really true. There's a mpfs specific match data structure in
the driver which the pic64gx also needs to use.

>=20
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Docum=
entation/devicetree/bindings/net/cdns,macb.yaml
> index 3c30dd23cd4e..25ca7f5a7357 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -38,7 +38,10 @@ properties:
>                - cdns,sam9x60-macb     # Microchip sam9x60 SoC
>                - microchip,mpfs-macb   # Microchip PolarFire SoC
>            - const: cdns,macb          # Generic
> -
> +      - items:
> +          - const: microchip,pic64gx-macb # Microchip PIC64GX SoC
> +          - const: microchip,mpfs-macb    # Microchip PolarFire SoC
> +          - const: cdns,macb              # Generic
>        - items:
>            - enum:
>                - atmel,sama5d3-macb    # 10/100Mbit IP on Atmel sama5d3 S=
oCs
> --=20
> 2.30.2
>=20

--OLuPF48/Wq3esOBj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvqtBgAKCRB4tDGHoIJi
0pmRAP453ZWh5pXP53sHIW3HHT4o23sKukkC4I3CZSzhXf54OAD+ImfTrAvyCU9x
gfrLa0Li1So6ci+g92nO/ujiDMopngw=
=BmjB
-----END PGP SIGNATURE-----

--OLuPF48/Wq3esOBj--


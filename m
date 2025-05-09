Return-Path: <netdev+bounces-189331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB9AB19DB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 18:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B4A1C476DE
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB862356A0;
	Fri,  9 May 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjm4lrdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8E230D01;
	Fri,  9 May 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806508; cv=none; b=J0rJ0PMWdc4o1IhenHHHTBGB16sRvs4idGeg/UQu1QB3wRtEP2XOQCYQ060CslZbprDliDFrObu3x88pBBUXB7dCsRnpVlLRtj/2nsTMY8JurFKXbZshI4BcE46OHcevG5ahIAGhZNKa4eLm6Zb6WM/fGhWSx4ZBojBqB6Bjj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806508; c=relaxed/simple;
	bh=NrkYDyKSilsAumoR4cRQAKFbhAGXqGkeJLktkDCMNqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lybsxFSW3tmlQn+mjunrtXd9kk7gK631FWKpfMLIrpjJHvePGDN43o7V1pk4DHMPWYI8QWW5rhRhmatN10dDpC9YMdW4S1UXX6pmpPq5OBi6fkRdSZ8LzDAO875XK92QUyUOZ7OWQAHT6fUmxhc8udfRaIXTZ1prdfoz8xv4l1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjm4lrdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF97C4CEE4;
	Fri,  9 May 2025 16:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806507;
	bh=NrkYDyKSilsAumoR4cRQAKFbhAGXqGkeJLktkDCMNqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wjm4lrdJlKILmgHDx/mfcB0fQRX9o8yVtiASGQs1FypLeZeMu7Ce2lZri0/xi4q8P
	 DjIHeQ1BrRom5cYIxfFUll8R+SCSmvMmFHrQTQQ+G4VrE5JDkrq7e/KbGurlku65gJ
	 3RE2ZuaLk8VkaKS5jmFgAn5pGwd6Fm++MIigMNackzPRYKsfkDTpcE0MwL+MDo58gf
	 Bkw8jb2hFw39vHSX6h5mjj2FaJ5JWpx5dcCYZqlJRap12kzpXiigIfsw5R63xuM/2l
	 s2x2z4xqN9MaxuCCtZesMoPPPMzQwFGlUsUfE8IWT8QxKZZKyCw/1D6/kaYNnynHUE
	 HA4qEFjty+gYg==
Date: Fri, 9 May 2025 17:01:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next V3 1/6] dt-bindings: vertexcom-mse102x: Fix IRQ
 type in example
Message-ID: <20250509-unlaced-roman-9ccd128245a8@spud>
References: <20250509120435.43646-1-wahrenst@gmx.net>
 <20250509120435.43646-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fSDdIfCxJGaH/+pC"
Content-Disposition: inline
In-Reply-To: <20250509120435.43646-2-wahrenst@gmx.net>


--fSDdIfCxJGaH/+pC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 02:04:30PM +0200, Stefan Wahren wrote:
> According to the MSE102x documentation the trigger type is a
> high level.
>=20
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
(but I think something like this doesn't need one)

> ---
>  Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml=
 b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> index 4158673f723c..8359de7ad272 100644
> --- a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> +++ b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
> @@ -63,7 +63,7 @@ examples:
>              compatible =3D "vertexcom,mse1021";
>              reg =3D <0>;
>              interrupt-parent =3D <&gpio>;
> -            interrupts =3D <23 IRQ_TYPE_EDGE_RISING>;
> +            interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH>;
>              spi-cpha;
>              spi-cpol;
>              spi-max-frequency =3D <7142857>;
> --=20
> 2.34.1
>=20

--fSDdIfCxJGaH/+pC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaB4m5gAKCRB4tDGHoIJi
0ggfAP41su6OEiVbz5Wf/6f8GW8/5AQn1d+logk1bSwUBKkRAQEAk/ip+J94UScP
Sd5MO3BfuDlPdpjuGFOyVegwtnZ++QY=
=vHrf
-----END PGP SIGNATURE-----

--fSDdIfCxJGaH/+pC--


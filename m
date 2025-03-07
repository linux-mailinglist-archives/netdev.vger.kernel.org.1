Return-Path: <netdev+bounces-172991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296C8A56C56
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB418988A1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5422121D3F0;
	Fri,  7 Mar 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpRVUrtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269FF2E822;
	Fri,  7 Mar 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362163; cv=none; b=VD0fb/0HpNBl18F2hYqXodf2cHLk6krDV765hp//1RO9uQnrGNs3Kce2EI8vAXwZNaPu4LnFzNah1CHo5ijKvbAf4Fw1A5d3y/zjzvPWY/XljIAtXDYu+g3644Kv9u4ebZ4mICupNvvhfiLieLtZZmiBPGzaTWySc8Gym9bpzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362163; c=relaxed/simple;
	bh=/6SO0EcADvKbiU2IUbCpmVnHTLreXfwak6PliDc6LIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTG6Ks7sWbA82AqSajLbgL12Gmhdx8D2DcMP1AXA36TKGC5/f78qgiK+j+YnLJBF9hMIR0HK8IzM1tPC8aWxVQpfrPmz5JT+PsxXBT3GAwFu5/Jetn+b/Y34a7jhgGHXYMTyI49+RtEYM9j1HrMTG4VSsuu1PoB6Zcu/7Eq3U8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpRVUrtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3FC4CED1;
	Fri,  7 Mar 2025 15:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741362162;
	bh=/6SO0EcADvKbiU2IUbCpmVnHTLreXfwak6PliDc6LIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpRVUrtEQlJ/hOslRpwQkyvvb8x0q7U4z7yGhb4IqPrOi132Pl5AhyBUKor82AU88
	 YuCBNG8P0re5CI4t6N4R/Jo8X6lEAiujVN5BVJ8fxSZosNSrsQPnj4ulUvG3dL8h0N
	 WM1nK1DFWuePX1WRRJOp+OopOssB8j59RDKFTUqpLaF7au3H6Oq6CnK+4eSJIF6Wxi
	 ero7/47yLDfxcyeJs1cHxDLrqL75KcnaKl6w8nIpiAiRFDGnIBxdE1w1I3lF+BGLUn
	 J3CCCiR5JyvBvMv5TmGnXQKg4xH9rlHMPQBZxLFi/AAj3+U8/1NHLjewvghgaLYhdw
	 aviKA5meeNWug==
Date: Fri, 7 Mar 2025 15:42:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>, Yao Zi <ziyao@disroot.org>,
	linux-rockchip@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: net: rockchip-dwmac: Add compatible
 string for RK3528
Message-ID: <20250307-tipping-womanlike-a1ce2370d8d3@spud>
References: <20250306221402.1704196-1-jonas@kwiboo.se>
 <20250306221402.1704196-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nXvMqSCu4bHBti4w"
Content-Disposition: inline
In-Reply-To: <20250306221402.1704196-2-jonas@kwiboo.se>


--nXvMqSCu4bHBti4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 10:13:54PM +0000, Jonas Karlman wrote:
> Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
> Ethernet QoS IP.
>=20
> Add compatible string for the RK3528 variant.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> I was not able to restrict the minItems change to only apply to the new
> compatible, please advise on how to properly restrict the minItems
> change if needed.

What do you mean by that? As in, what did you try and did not work?
Usually you do something like
if:
  not:
    compatible:
      contains:
        rockchip,rk3528-gmac
then:
  properties:
    clocks:
      minItems: 5

>=20
> Also, because snps,dwmac-4.20a is already listed in snps,dwmac.yaml
> adding the rockchip,rk3528-gmac compatible did not seem necessary.
> ---
>  Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/=
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> index 05a5605f1b51..3c25b49bd78e 100644
> --- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> @@ -24,6 +24,7 @@ select:
>            - rockchip,rk3366-gmac
>            - rockchip,rk3368-gmac
>            - rockchip,rk3399-gmac
> +          - rockchip,rk3528-gmac
>            - rockchip,rk3568-gmac
>            - rockchip,rk3576-gmac
>            - rockchip,rk3588-gmac
> @@ -49,6 +50,7 @@ properties:
>                - rockchip,rv1108-gmac
>        - items:
>            - enum:
> +              - rockchip,rk3528-gmac
>                - rockchip,rk3568-gmac
>                - rockchip,rk3576-gmac
>                - rockchip,rk3588-gmac
> @@ -56,7 +58,7 @@ properties:
>            - const: snps,dwmac-4.20a
> =20
>    clocks:
> -    minItems: 5
> +    minItems: 4
>      maxItems: 8
> =20
>    clock-names:
> --=20
> 2.48.1
>=20

--nXvMqSCu4bHBti4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ8sT7AAKCRB4tDGHoIJi
0udWAQDKedml54kYUJVxrtEqR1NZzEn4apvbK6/9yyqKPmhoTgEAm7XXd7+22bQ4
e+hQ7xUKSRFfeiw9diT+3VJ3kwyPBQY=
=97ov
-----END PGP SIGNATURE-----

--nXvMqSCu4bHBti4w--


Return-Path: <netdev+bounces-17689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA4752B03
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF793281F3D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9F31F938;
	Thu, 13 Jul 2023 19:31:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43909200CE
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3270C433C8;
	Thu, 13 Jul 2023 19:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689276699;
	bh=Xr1JrHIprji0ukEKi29zvb5WpkvZKQdH5WChRsNQ15s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlDX6HGaX0LJ38M7+fvYcHgyuhOjkDgV7Fm53HOj6CCsEz/pfPZU49T7t+Pl+0VYV
	 wT7jnh5LiR3wgars1BCAvgY2D6Zc0zMgVzgPh40YQHS7Rt0BXAQK3y3w2GJlJkzTST
	 uYWReLTOrggsv7D1jOM7+YkZjMR36f+fiBQBUr6AjMS4ddsFQr/xKRj6v+5/BOKy1m
	 5xiLWxyhiB+V5PL7fACWwQfK0hECTf41k0gZWaz14ESyhopQrJfKD8aHFS9mRxFhyr
	 YTbscvzjXRBqINYVbVx/RSma2Lw9D/9VT60o9e4wOw4H6juOxQtCJHjBuh4+xjRQA/
	 UVnMn4u3RCVxA==
Date: Thu, 13 Jul 2023 20:31:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: memory-controllers: ingenic,nemc:
 reference peripheral properties
Message-ID: <20230713-negate-dividend-f38ab42129e1@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsRu64CPx95BLEjP"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-2-krzysztof.kozlowski@linaro.org>


--bsRu64CPx95BLEjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:46PM +0200, Krzysztof Kozlowski wrote:
> Ingenic NAND / External Memory Controller has children with peripheral
> properties, so it should reference the Memory Controller bus
> Peripheral-specific schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bsRu64CPx95BLEjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBRFgAKCRB4tDGHoIJi
0khIAP9IgbmAHM/UT/eETAEQJY62dEbyeeW+zvV7HakoZPQ7EgD8CKDAm0doPxfe
fTWQaP45EPkxkA5pzSrbovLyeNx02AM=
=wnVp
-----END PGP SIGNATURE-----

--bsRu64CPx95BLEjP--


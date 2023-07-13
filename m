Return-Path: <netdev+bounces-17688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B44752B02
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65701C2137E
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B258200BA;
	Thu, 13 Jul 2023 19:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB02419A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E57C433C9;
	Thu, 13 Jul 2023 19:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689276666;
	bh=NF5yZAAgooAQlnpwD7HEyp3sC7TthSVdoNdpc3rPOiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1uN6jphzQUuckMjqodwu+gqtdc0TWbHHyq740yYaIxSfLoqR1dc9ogCfXu4r87kx
	 fHt/ScYPHTFFR7V2shfMjmM+o2f8RAtdkXfpPfL+R2dZB9gzuxL4eXzSvUt2ozMNxQ
	 4/1oaVc8M5FeVYRKrq8ug3QOrwWLTZgoN2jJBlm8VA8uu9Avf+B3q6WPUfgZ9ImtKC
	 QGguBS//dXBJb+/LtcfBwYNE+5tJiEPVBCnmgETlU4WVUaOVq1fESiAyUchhWGk8B5
	 gj099Q1VyoXpOGS4VM94dfjkAqBxY1hbnMai3BtFJ3EFLePULgqIa7Hp5a2507g0YN
	 mfdU2/YVcsVjw==
Date: Thu, 13 Jul 2023 20:31:01 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: memory-controllers: reference TI GPMC
 peripheral properties
Message-ID: <20230713-vertebrae-declared-f83a0f836ecd@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="53x7rfT98yyxKzvW"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-3-krzysztof.kozlowski@linaro.org>


--53x7rfT98yyxKzvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:47PM +0200, Krzysztof Kozlowski wrote:
> Reference the Texas Instruments GPMC Bus Child Nodes schema with
> peripheral properties, in common Memory Controller bus
> Peripheral-specific schema, to allow properly validate devices like
> davicom,dm9000.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--53x7rfT98yyxKzvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBQ9QAKCRB4tDGHoIJi
0gdhAQC3JA+5u3kXmUp6gSJWwfdXB5C8Ex2NP56NKa9NVyb0ogD+O6TXWOm7QWAV
n6sAQvE2F6swQzSBBJ90FkLmBAhYPgo=
=DBJn
-----END PGP SIGNATURE-----

--53x7rfT98yyxKzvW--


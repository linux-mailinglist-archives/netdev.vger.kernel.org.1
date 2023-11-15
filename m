Return-Path: <netdev+bounces-48206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3567ED66A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 22:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99111F2587E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C23FB08;
	Wed, 15 Nov 2023 21:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2kFn1/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C0F45BEB;
	Wed, 15 Nov 2023 21:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5C7C433C8;
	Wed, 15 Nov 2023 21:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700085452;
	bh=utRWzAUPDR/YGuRAiQgw7t0J+7beCClfBghAq9tfy7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2kFn1/qvdpWpt6Sa7+G3dXsJ4Cbv1CzVhvzu5dwJsUqmu6iyOBj92/iAP71LyWS/
	 jq9esZ/hPoY3l1tjHBR/OvQhykIHE7aPhN8YdTgP/PLj7wd7RxkMagETuErzXWWPln
	 sa1S95Bv9wII2Fsh/2Wi+eJnpjbRHmmeFS26QcFkIkEYQcu7EJjvrZ2HqcvSCTniH3
	 oC3eucpdS3xJAee2huLROhIBCdXn2OHG8glRQyL2JJ/IiOTFY6HJzKeDoXRJXupYmH
	 rbxs/qEmZjYlSOGYJN3S2Ug+XIXce5G39JyWXQ2DXihOW7acP8ane0RmDfs5oWrNwi
	 mPDpGauwFHNZw==
Date: Wed, 15 Nov 2023 21:57:28 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
Message-ID: <20231115-marry-lagoon-d78d6085f7d7@squawk>
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bQAUvGBLU9yZJPAS"
Content-Disposition: inline
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--bQAUvGBLU9yZJPAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:04:48PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
>=20
> No driver changes are required as generic compatible string
> "renesas,rzg2l-gbeth" will be used as a fallback on RZ/Five SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bQAUvGBLU9yZJPAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVU+xQAKCRB4tDGHoIJi
0ksWAQCrH2BGWrEy+3mGVr9EmqX6AEJBK8pFi/wB9kpSOcLm+AD9FhX7YgTDDIxI
1mt+waCdmjiuk7XHFmrMnYATmhKa2AA=
=f8sj
-----END PGP SIGNATURE-----

--bQAUvGBLU9yZJPAS--


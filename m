Return-Path: <netdev+bounces-17687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F73752B01
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73261281EF6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76EA200B0;
	Thu, 13 Jul 2023 19:30:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3491F943
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30829C433C7;
	Thu, 13 Jul 2023 19:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689276641;
	bh=yHyleVf55ms5OcbTmxlWVK0NQdIvDY066IjRVG6q0Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QdigQ6RU6vfvQNsqmZxPwN25ZmnXh80xsn+RuEvGOr/DbpVvcv6y2nR4cdAuxwkM1
	 UzWKhWr4Pp98kcxtFf2TJxiLKi7hTXXKsubITcfk4fYT4wscvT0DlmE2jzJ3+a7ZpN
	 UOp/Nmk7CDi699x8IIDjbxjrN9Z11JTEOLGcdzLQtTyNdxAHJ0epfw4a3G6e2d39lc
	 0EiyUbA22YSCNuLVbbboo/VTbVCuyZyPpqQqBQxyEyeueQKMtBK9FHW3SMymyjlqEM
	 B5CiKpEcicOPSEXhHNkzcz9UZw2ojvuTZZC30/6Aroi/28UP9O7e2n/RApHg9SRCHG
	 IdtEzW4ceSjVg==
Date: Thu, 13 Jul 2023 20:30:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>, Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: net: davicom,dm9000: convert to DT
 schema
Message-ID: <20230713-putdown-submersed-ec2306a7e484@spud>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
 <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KOCyIo0M2eMeOzL3"
Content-Disposition: inline
In-Reply-To: <20230713152848.82752-4-krzysztof.kozlowski@linaro.org>


--KOCyIo0M2eMeOzL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 05:28:48PM +0200, Krzysztof Kozlowski wrote:
> Convert the Davicom DM9000 Fast Ethernet Controller bindings to DT
> schema.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Seems like a faithful conversion to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--KOCyIo0M2eMeOzL3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLBQ3AAKCRB4tDGHoIJi
0vhaAP0QNEgWAMAo3BUKQl5mNSLdydSpPdJ6kTA1v6E2KB2DgAEApWcE5EffscXW
ZWE1qQYgjo8yAE4+7qq2Jy49AcDfqgM=
=mOdJ
-----END PGP SIGNATURE-----

--KOCyIo0M2eMeOzL3--


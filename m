Return-Path: <netdev+bounces-14855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696027441D1
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E7D280E5A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE4174DE;
	Fri, 30 Jun 2023 18:06:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB8168DA
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44654C433CC;
	Fri, 30 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148415;
	bh=yz5t1GiipNFNh1NtxgqisnUQ1CD8Mwvmr2prkm+aqsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8BVS2sR9N6T9w9CrLbGEkLtZUN8hymR5Yfqq38a/aJIH/8+cN3LhWC1qe0ABBgYh
	 +WqBRGYdoQU6Nt3Hxgu274LZGxuj3dXTjUFC0gpadKnR24KWnwNss6TUOYs5HzPAgL
	 69DWTSkPmvlyIGijGGtVsdNgq93wlUFCgrMlNUyUbtwMMbYkbBTmdNaNRMd8a9wsOh
	 HHDYDzKOmi2CTL7ac6HlH4x3ONaT6UQE/kzzOtQfsAzzW63ScznY5jFrNSUqpfzIhG
	 AoZkWNd9IQDpbsm4pGf/Gu3vudY9yeH3x7B7zrg0vngrABIfRCyWMgg5e+S/ARWYIe
	 MIrXoY3Cv3KjA==
Date: Fri, 30 Jun 2023 19:06:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-oxnas@groups.io,
	Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2 08/15] dt-bindings: net: oxnas-dwmac: remove obsolete
 bindings
Message-ID: <20230630-oppressor-circulate-1a2e5631d0dc@spud>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-8-fb6ab3dea87c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BvTA36mVIWDn/yrV"
Content-Disposition: inline
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-8-fb6ab3dea87c@linaro.org>


--BvTA36mVIWDn/yrV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:58:33PM +0200, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 dwmac glue.
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--BvTA36mVIWDn/yrV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8ZtgAKCRB4tDGHoIJi
0n34AQCaqt+oiyrpU/1VK5nJptp1QM1CruwCYZ4Kyxm+cqFlRAEA/3ZXE+gSBEOw
+/4RXjuoc0d0lEczRHPZqKqBpZdabgU=
=8KMl
-----END PGP SIGNATURE-----

--BvTA36mVIWDn/yrV--


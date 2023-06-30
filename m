Return-Path: <netdev+bounces-14856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1917441DA
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB421281190
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B807174E0;
	Fri, 30 Jun 2023 18:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC9174DE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFB0C433C0;
	Fri, 30 Jun 2023 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148446;
	bh=t3UiunEO1jCFQO48ppNgdOs68jT6bdUCWvW91NbYvx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsolcNbxeIfKRUkDzAeIeP+FAczdcaxY7suAmHTs4REMOWIBxBCF1ivd6b5v67PKC
	 O/ykE2B6j+McmLwMcrmFgCimdsbzDsuSnraDCFnFhFMN87wOOLonGq9O10xX2pl8xC
	 i5tMXoVzZXj9ax33debb349/ap0Ppg7oOJbQFERZwLQRti73kS2cGvrPz5Vyy/2lDs
	 xmhLejciKKgYKuhnSUs2LCYvoIzAA17feKPjczCju/s9nM0X4zvJZky1faL30feOaW
	 ebCsLsWAyEhp6bvuZzyM0nJD6i4h6JmpfnuR2ct/P77xuKrMFV5WPUgWg0HGT4J9uf
	 Wz+gtnuHXHwAA==
Date: Fri, 30 Jun 2023 19:07:17 +0100
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
Subject: Re: [PATCH v2 14/15] dt-bindings: interrupt-controller:
 arm,versatile-fpga-irq: mark oxnas compatible as deprecated
Message-ID: <20230630-carmaker-tablet-da1516122b65@spud>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-14-fb6ab3dea87c@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FNR50n0ttdoybkYr"
Content-Disposition: inline
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-14-fb6ab3dea87c@linaro.org>


--FNR50n0ttdoybkYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 06:58:39PM +0200, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, mark the
> OX810 and OX820 IRQ compatible as deprecated.
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--FNR50n0ttdoybkYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8Z1QAKCRB4tDGHoIJi
0oi5AP0fOVGdDREXAChDzrubQUvnaUVdAhqsJYui9kW6ylPwiwEA3lkNSMv2oqP7
pXh6Uo+fuIM4XtY3n9BAm0Wmeq+jOwI=
=Bqlm
-----END PGP SIGNATURE-----

--FNR50n0ttdoybkYr--


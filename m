Return-Path: <netdev+bounces-22340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C305C7670FD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 17:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F339D1C218C2
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4F114283;
	Fri, 28 Jul 2023 15:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F361426F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C90EC433C9;
	Fri, 28 Jul 2023 15:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690559439;
	bh=FnMFqj/s49TzaM6yfmyNpQSSy8bKQ5ugm5trajmOYB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P35iWrPTULn82aCR/saWbIvbhgW9FBRWLcm7T6831r1mxA0XYv+wihRnJ+bpe/h3j
	 SQI3nQMltLvs9348RcuJx3yB58okKZtFAr67/yunNdLCTQ2ZAlpKy0CNnGvyQUq65x
	 UrAO5Epy3B3om7fYqnjZtzYBwh45VSZ631NEvGXKAPrDQSjTxJAjUh1rN7eW+yXxHJ
	 eLRbo5WOQNZFnIGkYWrKLd8HdNhtbK4c/sT60Vc/9pvTSwX0j9KuCzgDlonRK7extE
	 8tHwl7EsCsHE8lDYNbtsAppmrzbvldMf2em+uOSVDgypVZkFhhh5VSQPOOlCZKdviU
	 v1FgZjXrTMz3A==
Date: Fri, 28 Jul 2023 16:50:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Varshini Rajendran <varshini.rajendran@microchip.com>,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
	andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org,
	lee@kernel.org, ulf.hansson@linaro.org, tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linus.walleij@linaro.org, sre@kernel.org, p.zabel@pengutronix.de,
	olivia@selenic.com, a.zummo@towertech.it, radu_nicolae.pirea@upb.ro,
	richard.genoud@gmail.com, gregkh@linuxfoundation.org,
	lgirdwood@gmail.com, broonie@kernel.org, wim@linux-watchdog.org,
	linux@roeck-us.net, linux@armlinux.org.uk,
	durai.manickamkr@microchip.com, andrew@lunn.ch,
	jerry.ray@microchip.com, andre.przywara@arm.com, mani@kernel.org,
	alexandre.torgue@st.com, gregory.clement@bootlin.com, arnd@arndb.de,
	rientjes@google.com, deller@gmx.de, 42.hyeyoo@gmail.com,
	vbabka@suse.cz, mripard@kernel.org, mihai.sain@microchip.com,
	codrin.ciubotariu@microchip.com, eugen.hristev@collabora.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Message-ID: <20230728-floss-stark-889158f968ea@spud>
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
 <c0792cfd-db4f-7153-0775-824912277908@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Z+IvU8OCRbt7H1L"
Content-Disposition: inline
In-Reply-To: <c0792cfd-db4f-7153-0775-824912277908@linaro.org>


--1Z+IvU8OCRbt7H1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 01:32:12PM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 12:22, Varshini Rajendran wrote:
> > This patch series adds support for the new SoC family - sam9x7.
> >  - The device tree, configs and drivers are added
> >  - Clock driver for sam9x7 is added
> >  - Support for basic peripherals is added
> >  - Target board SAM9X75 Curiosity is added
> >=20
>=20
> Your threading is absolutely broken making it difficult to review and app=
ly.

I had a chat with Varshini today, they were trying to avoid sending the
patches to a massive CC list, but didn't set any in-reply-to header.
For the next submission whole series could be sent to the binding &
platform maintainers and the individual patches additionally to their
respective lists/maintainers. Does that sound okay to you, or do you
think it should be broken up?

Cheers,
Conor.


--1Z+IvU8OCRbt7H1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMPjwAAKCRB4tDGHoIJi
0t3wAQDbx8dLxPQPnIoDByHTBcuDjvFBZTpWUg4bhE01/+BpfQEArGia1WutY/7n
UhhVDqMheWjj/xZNVFl/ZTTiVbw1vwI=
=NVNa
-----END PGP SIGNATURE-----

--1Z+IvU8OCRbt7H1L--


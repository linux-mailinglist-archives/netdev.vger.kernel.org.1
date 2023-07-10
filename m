Return-Path: <netdev+bounces-16446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506274D42F
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E11C1C203D8
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD53C2EF;
	Mon, 10 Jul 2023 11:04:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDCF10783
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D578C433C7;
	Mon, 10 Jul 2023 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688987084;
	bh=TwtuDKEbyYTJYwb5YfWy40545UzZJ3eX6HtXjCq2/DY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F1hoO4AmByvX1+/WmpbkKZwew5eudKc1FQfa/lRAOOwiXQ8zRshL+Oq9bFoJQeu7s
	 LcEcu9oephfIQANzA4/3cifEEgUeal19PEixt2fvddV8g2XCmGK0fFh3Uc4W+J5uOn
	 XEO983Rlb7MGqbsEKGjwJjCaRtJ44jxPCT5CF+Iau9ZSof+GY2neKJt0KjAvaY/9jd
	 RBqd+kDX18tFNSlYceBbrvR3r37PvxSvj3S5DjVmlQqBMkOMXeP2JrMR5z6F5rg6jE
	 qp2ogGv8JQb+t32ZmOV4oiKG0GwgxT5l0kEjeNVOqRmXVjkyf2EUtnmSnqitny5s3z
	 HoqJaUtvZLO7w==
Date: Mon, 10 Jul 2023 12:04:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Kris Bahnsen <kris@embeddedts.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and
 SPI_MASTER_MUST_.X
Message-ID: <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kWZTJCyyxQE+byGQ"
Content-Disposition: inline
In-Reply-To: <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?


--kWZTJCyyxQE+byGQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:

> Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> and kill the not used anymore definitions.

The above is not what this change does:

> -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

--kWZTJCyyxQE+byGQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSr5cIACgkQJNaLcl1U
h9Ah2wf+KmkGI9qlUKgHUSNXh1DbqoLxbTpYFnFP5xpasapdwBa05UYP3eghOigF
R9RLm+Z+cOhxpxkEijdYqYKOu94px87YE9vU9+e00ZWaz+X+R8C17kt4hk+9x5pI
n6ln7unk1TDzZww8TWx81WkEqR6E4uMcYhMfsfjKKDcC6ZOxJu6+h3wWjhkj8q35
k8NbtIo8bz2TzLqTuNjWsA64H1AxpRqwoT1fLLiZRPrng7Zc4wIP68cX17WSWwqj
+Tn8sO3EBbpYl4vuJircRmezY6Roo1TuLU4M7iIGhGoUrt+jdmoqIDsjQVU4IKIv
kRGC3WQT0+LuWsoU8vUp0PFt+ntu4w==
=03Nv
-----END PGP SIGNATURE-----

--kWZTJCyyxQE+byGQ--


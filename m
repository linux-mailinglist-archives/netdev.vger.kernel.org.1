Return-Path: <netdev+bounces-16451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793F574D47D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F552811AF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DA7107A4;
	Mon, 10 Jul 2023 11:23:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D9E10949
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F29C433C7;
	Mon, 10 Jul 2023 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688988188;
	bh=rVbOiKgyxND9mKZk3rAKjAS4exnyG60MuJg/qoml1Vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NmQJc/tPCMy3i5v1VlHdRroye/CciPC/ZvFOKcppf3TZf0qRJ3dgdRYwmDVOMOmqP
	 VHTHnUz3SjT2CkGo2po+jFLM51kzErpdYTDzbIh1ssyixtC39WoS5AEx1AHhOh2rUT
	 oGH0Cj/eImkEiRwQY+a6G/4uTBojRaP1c3PpTvWdlPa8OmIjqYJiqIt27qBeoOyByD
	 uIezS9sRdsa2l0+EXR9NmvWwdDucaVOT+HG9neus16SKNTI7aq5f6UxW++970eT5gb
	 zfoX4LNe9GA9UuIFwotHUiqYP63tgZEO9J8trRSJc2+FmmGG2Hl/AKVEk1ykYfoY0k
	 6E9c0qXH0JqVA==
Date: Mon, 10 Jul 2023 12:22:59 +0100
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
Message-ID: <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SoPr26CyLWhD+5za"
Content-Disposition: inline
In-Reply-To: <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?


--SoPr26CyLWhD+5za
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 02:08:00PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> > > On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:

> > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > and kill the not used anymore definitions.

> > > The above is not what this change does:

> > How to improve it? I was sure that the form of "converting to something and
> > something" is clear...

> A wild guess, maybe you meant to split to two changes, one per each macro group?

No, doing TX and RX in one commit is fine.

> > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

What part of the above change is replacing _NO_ with _MUST_?

--SoPr26CyLWhD+5za
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSr6hIACgkQJNaLcl1U
h9AMOgf+KMPcMsJntwEWI8UJ7/re0uGZ3D9fX1qeb76OfxTqQ5bt1PsIzRULHkqL
pEOuOVnEu3HTSuNnMgEyy0ms1PA7+yFFiMWSdYlZy02GpNeD8FY/VFwOM9dR4pte
UWnlYD6vJK8wffaEnxtKF5F2gOah96lH3Yws15T1IN8/YbK5wzCnJ2R5XWgm5Ka6
zIFhD0cZ077/Z1hO9SJrqAKPpTLLr1KtyC7ZHsvN2YE5+bzvELKFqPSyt3HPy61r
v+QdG7vRj8/tNW2Hn4lpLR8g9tz5JSMFLhxcyg9TRz67jSiOxM/utfw2IY+Q8DB8
YvmjuYpF+tbhIo7G3bYNULQS39HNSQ==
=ZD6G
-----END PGP SIGNATURE-----

--SoPr26CyLWhD+5za--


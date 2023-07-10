Return-Path: <netdev+bounces-16471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9776D74D75D
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1E42811C1
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612D11C93;
	Mon, 10 Jul 2023 13:21:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20E7C8F9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94191C433C7;
	Mon, 10 Jul 2023 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688995274;
	bh=ruJlO0wimIrsDY1JgPUqCqS7prBe1pSopi+dM4yYAWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCUvqCttiPcwuUH6oQaeDTVlt/jVMTKddukpB3Rq2NTAjbzgaXhOs+IbQKiqA2zFS
	 A9RwOziobHTKo8xtAoLCbw9/G5XP7z93lwwcMiVxafq8PiTNYdyOWz2ZmNVbJqaRu3
	 p+o7GErUG6dN3D+2vdmSUok/vpvLEP/d4e2/6uVM8lFbtbK1g1KhHRcJ+YzSNSc8aV
	 vzC9RTasZiyt6DNQvmgXjaDeqvMTkrDbkZFHHHz5OJ3MwZifaBQsXsj96SFX7XFS5/
	 2yl7VTCIzPWHRNx1uEfr8lQDSlw+D72llgC2cC8KCiu81fGygjzL2Umg2d4uKSVdv1
	 5QaNEib99pP6w==
Date: Mon, 10 Jul 2023 14:21:05 +0100
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
Message-ID: <7aff8759-cfca-47b5-b995-5260e5082c45@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
 <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
 <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bc8mzeK4BJwaYeTa"
Content-Disposition: inline
In-Reply-To: <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?


--Bc8mzeK4BJwaYeTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 03:37:59PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 12:22:59PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:

> > > > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > > > and kill the not used anymore definitions.

...

> > > > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

> > What part of the above change is replacing _NO_ with _MUST_?

> None, that's why assuming the split by name should be fine.

That's what the above changelog sounds like it's trying to do (I'm not
sure the change itself makes sense but the first thing I ran into when
reviewing the patch), AFIACT you're missing a "from" in the changelog?

--Bc8mzeK4BJwaYeTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsBcAACgkQJNaLcl1U
h9BDYgf/Sarsl9t6SagewIDl2ctlFPl7f++zP6SLId0C0LErq2lPLxZKf8tzzV5x
7mUMpK3rPcygDeYAqOKLncxnrZp/i7yix/98fZtls9IesvOQa29aRYKVSvhKnB6y
dHoZoMBdYj1Rbo/olUcS1xjzzZ0o1VUHkLsp9rjoMW4lcz6Hu3o8GSOq1pbc9lRd
qlCYAjMqjR9K3te5I6FICKKGnIrXm2uxuzSPZl1G7LaN0THUZGZJvcBHjhR2PcJs
K9i9m0gJ9xsQXDOQgLTcXrm8hdSF7yQoRI3TBZ7RXzdWeO3mjNjeHGbVDRr3DMZy
Oici+Ga3mBLzIlFlF51Tg71+BGqcoQ==
=NWL6
-----END PGP SIGNATURE-----

--Bc8mzeK4BJwaYeTa--


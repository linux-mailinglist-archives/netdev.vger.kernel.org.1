Return-Path: <netdev+bounces-16448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A5B74D44A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 13:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A751B1C20916
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98DD101D3;
	Mon, 10 Jul 2023 11:10:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91E10783
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 11:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE7CC433C7;
	Mon, 10 Jul 2023 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688987414;
	bh=gBzc2tZIawZS0PUBWYuNntkIVRyxrqJrpV4aYLufX50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCpsYi8hZ5dhRZJo2dzz+GDrlvZ3y3Af66p3CIYUZn5Y7dTwO5nu+KqKKyalcHXoR
	 PkygyNMxxD1kJ/lpREraWAr7ptMwrZdtMjK3PU29AnATl/uf8vAL9Nckrl/+MeLppg
	 19u1l5oucwxlHlsOpcNXdgeY/3jdD6Md8RpxHE5vhqDd2CdGQZpt4EJ9jkXLMIe2Vi
	 j8G3+oragW3KzCHXGkgfsqlqyuDdPjSBwMnDouPbYGO7j5vHL2lOm/CiBcEG3D/6Yt
	 UEI3ZfBZW8x+aJt6SPMz70Pu1DNSCBE7XnZHCFijw9ibPwJlex9VzJs5Gg1OIblL+p
	 7Sf/vgDKmS0KA==
Date: Mon, 10 Jul 2023 12:10:03 +0100
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
Message-ID: <bb3b9ef2-0a32-4f8a-8d92-06d47875b562@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsbcL+9pzd4b793B"
Content-Disposition: inline
In-Reply-To: <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?


--XsbcL+9pzd4b793B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 02:08:00PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 12:04:35PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 01:27:47PM +0300, Andy Shevchenko wrote:
> >=20
> > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > and kill the not used anymore definitions.

> > The above is not what this change does:

> How to improve it? I was sure that the form of "converting to something a=
nd
> something" is clear...

> > > -	controller->flags =3D SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > +	controller->flags =3D SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_=
TX;

The change here is not the change that is described above.

--XsbcL+9pzd4b793B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSr5woACgkQJNaLcl1U
h9AETQf/V6X5zgJr6k7uYHVQFcwbbL/m5vofjoxPJtbBrBmanG5Gk4nvQRtvE5KM
RpVSjTeFZ6uC+MkUxft/VIyhHYX0UETqWF2qmW7X91ieOzQ+qA80TTz19J1soL8A
bdQuSDpZRGY0O5f9XVApQSJ9PvLzql1IvaU8JVkUlF9HL8cNol+5w/YPdvB3kKU0
zxUG62Tx0R0Qvo/ku288lZhsKbhtXH6jwNvsxH39TNsnewnat7fJiZvShg6theLk
vV02J7JmsFAeUR3ZH24aBIcYM3bYv86vKInV1cKHAzBjoan98DG8cghY3IvapKia
sf0W5e1oHmvyUi1zga0aGvHvsKHkcA==
=AmsT
-----END PGP SIGNATURE-----

--XsbcL+9pzd4b793B--


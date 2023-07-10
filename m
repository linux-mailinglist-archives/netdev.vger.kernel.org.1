Return-Path: <netdev+bounces-16543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD474DC13
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994031C20B37
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E3013AF0;
	Mon, 10 Jul 2023 17:16:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E4107B4
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:16:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607EFC433C8;
	Mon, 10 Jul 2023 17:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689009395;
	bh=CgnlYd6F8QNT9n++b/k47msx5swkm6/AbNv02cH7FqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCNLRwD0ouHI8pJTPN00LKshCADBsrezjsyCWSHlUtPA86QMcTtmuANY2THapc+ya
	 rkH5tcQmXa5WkKmxP1SPoeLDBnKChb3smPLszGKE/fOJpIoKZHw2XHyVjIgwHTZ/1z
	 MufgsvMGmS7UeltSFfqOX5aakYX6Oi9D+fdx6r4xTwDjZDukvdOJHqT+HXAuPx0WPm
	 TWMpwYu5OvJq0RnyxMb5KHCGmQeKSlmlgHlItZHKy5JjIjq74cV332HHX8EX4US9YN
	 7LvxZOQBp61R6AEZ7cokvT4lucM8T0YliBj7nuBwioqSX1VDucIF209VQysfZBVMCk
	 jUIpbFJ9ng45w==
Date: Mon, 10 Jul 2023 18:16:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v2 05/15] spi: Remove code duplication in
 spi_add_device_locked()
Message-ID: <7557bada-3076-4d6e-a5c5-d368433706e2@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="smwEq19A8LfCcchg"
Content-Disposition: inline
In-Reply-To: <20230710154932.68377-6-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?


--smwEq19A8LfCcchg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 06:49:22PM +0300, Andy Shevchenko wrote:
> Seems by unknown reason, probably some kind of mis-rebase,
> the commit 0c79378c0199 ("spi: add ancillary device support")
> adds a dozen of duplicating lines of code. Drop them.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/spi/spi.c | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index c99ee4164f11..46cbda383228 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -712,17 +712,6 @@ EXPORT_SYMBOL_GPL(spi_add_device);
>  static int spi_add_device_locked(struct spi_device *spi)
>  {
>  	struct spi_controller *ctlr =3D spi->controller;
> -	struct device *dev =3D ctlr->dev.parent;
> -
> -	/* Chipselects are numbered 0..max; validate. */
> -	if (spi_get_chipselect(spi, 0) >=3D ctlr->num_chipselect) {
> -		dev_err(dev, "cs%d >=3D max %d\n", spi_get_chipselect(spi, 0),
> -			ctlr->num_chipselect);
> -		return -EINVAL;
> -	}
> -
> -	/* Set the bus ID string */
> -	spi_dev_set_name(spi);

I see that this is duplicating spi_add_device() (and we really could do
better with code sharing there I think) but I can't immediately see
where the duplication that's intended to be elimiated is here - where
else in the one call path that spi_add_device_locked() has would we do
the above?  Based on the changelog I was expecting to see some
duplicated code in the function itself.

--smwEq19A8LfCcchg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsPOUACgkQJNaLcl1U
h9DBUwf9Euy3I6rYQCugpUDlBhWVoSMMz7t1ATFjPAfJAReJsl7tNz8zO3ZIBKvo
DT0wuXofoowlS3XkS80I3NNL7wRjCktrPJnRHSBr/n15W3VCvz7cA+vkKlJdt60d
vqLIOGnEqqPBftrOwUjsobHicO0YhL47AxOStev3fjlhFEbS0RrIpvCsVsRI1HDs
5MalNotHe8wd+ujY4p9wUX9c2EZvSWQAE4XUBml+faspwunMGqKbjE+srfTbz+eB
bkym8H1s/H5a/SQn5ya4y6dkDZ0jR9hz4H3HxMm4C/KgUJRnZXiIgNRtghmsQNys
LGdv8LQz0S452H4iaGYZlWdB4IEu1w==
=KWBr
-----END PGP SIGNATURE-----

--smwEq19A8LfCcchg--


Return-Path: <netdev+bounces-16844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B21374EFCE
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A281C20EDF
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4718B19;
	Tue, 11 Jul 2023 13:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8A12598
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE23AC433C8;
	Tue, 11 Jul 2023 13:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689080732;
	bh=HnVEva2jdOLXu3EN/cKYarAoyETVmcXrgG0CY9KCvZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BO5Sf+xL4FaASSNsNdM5EGXByrv4WeTUxRBoPW2QNejIwlELvXTu5gKKqv4hkKhGg
	 oi3ZfR9Shzo5QwnSHTFndf8ZIVkqpTClpssosTOBH6/4HIjVrlXO3KdynsW5+Pg7kp
	 pbkKvKQx6ir3yg7CLJDoLHQzo0ewO66SzIeDifz9SCJzdBAZAn9RpEQzQEGNZHOmt+
	 6tOI/PPlmxZBFom+gGGjOjy+qrSc5cI26iueLs1Gv6DR2sYD26rubxcFZS48+8Dw/G
	 5SSyFU8wEM4MuZLWsQU4tXLcKI+0ehoZc3/OitBA10N/7/7vB38b2KMdMwG1AhcrlN
	 +CUurb7ZrrwoQ==
Date: Tue, 11 Jul 2023 14:05:18 +0100
From: Mark Brown <broonie@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
Subject: Re: [PATCH v2 04/15] spi: Replace open coded
 spi_controller_xfer_timeout()
Message-ID: <e3688ce5-616a-4399-a4e3-c410a09f6a45@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
 <83c4b75a-06d7-9fca-ffa0-f2e6a6ae7aed@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="925w7TTgRoHZtFsT"
Content-Disposition: inline
In-Reply-To: <83c4b75a-06d7-9fca-ffa0-f2e6a6ae7aed@collabora.com>
X-Cookie: marriage, n.:


--925w7TTgRoHZtFsT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 10:28:13AM +0200, AngeloGioacchino Del Regno wrote:
> Il 10/07/23 17:49, Andy Shevchenko ha scritto:

> > +		ms = spi_controller_xfer_timeout(ctlr, xfer);

> I agree on using helpers, but the logic is slightly changing here: yes it is
> unlikely (and also probably useless) to get ms == UINT_MAX, but the helper is
> limiting the maximum timeout value to 500mS, which may not work for some slow
> controllers/devices.

The helper is limiting the *minimum* timeout value to 500ms - it's using
max() not min().  The idea is the other way around, that for a very fast
transfer we don't want to end up with such a short timeout that it false
triggers due to scheduling issues.

--925w7TTgRoHZtFsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStU40ACgkQJNaLcl1U
h9B+yQf+KBYXJ7506wC0Am0zY2LnPrpwi7/uhVWQsN9GzhBVU0RGwam2xuqmpCeo
A3o92lqKSQPkQGllTlnuM3r4jp2qDy1/U/QJJxak+i/i8NjuVxIQQIKtnM/nRQxh
yRpIp6WbVt+HJsdFgPS6j6r/3m1qS4eTbso7/ciwLzdRc2Yxk9SLXFteOErlAEoq
hhR7VxhID4BE72a+1NbyuALEVGjSMYBdpddD//Qa1UsJVw1yK5HuM51CaQd9bTlo
EtrmXMgaG9FB+lQeu2zedT6HTQQH/hOB77luYq4zGm849tw2sfBPIhqVgQtkkutv
4hpXSMiuD+iL32PThXfathhu4xvFiQ==
=l6sR
-----END PGP SIGNATURE-----

--925w7TTgRoHZtFsT--


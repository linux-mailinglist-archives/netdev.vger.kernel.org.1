Return-Path: <netdev+bounces-16541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AF874DBEF
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D43F28126A
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC2C13AE2;
	Mon, 10 Jul 2023 17:09:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DBC134DD
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822D8C433C9;
	Mon, 10 Jul 2023 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689008956;
	bh=nKZycr1bbDIhX+7r/umilV/wuLHcsLLg8WWLjNqfVGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ks7RL3h40J9Gsg6+T5tGMhXUPebOkMtv2HYbINZYkE0HBcDFe3InO0uHvSLO6Ywfd
	 z9dbScYbXDyBfN0KKzvhwsevIOZI2Wa4nTPSPcqSdIk9dVy3t4CwrMIhESNVB8EcTq
	 DHcqHiLwexT4fjkOSD7WRFfWxwr4oLox+CN38zoYAqwcwq7DLt0YYhvaSCGjOeZdC6
	 /OMp7mPT/0W9iS9bRuPwjhjEgn3ZN4a3GPUVex+MO83a5hpzqpvTmLwha1tCaAJG7B
	 IOQDzu3lMvKgzC08AKXIF8wSz30WvJ3WDseHtgBrUd0ZFYjZe2rdpVVbiRnkMjF1jV
	 sbYhTW/HyF8mg==
Date: Mon, 10 Jul 2023 18:09:00 +0100
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
Subject: Re: [PATCH v2 02/15] spi: Drop duplicate IDR allocation code in
 spi_register_controller()
Message-ID: <97f3436a-78ca-4a94-a409-ef04bd3b593f@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ugTz/0iIbXaMesMQ"
Content-Disposition: inline
In-Reply-To: <20230710154932.68377-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Do you have lysdexia?


--ugTz/0iIbXaMesMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 06:49:19PM +0300, Andy Shevchenko wrote:

> Refactor spi_register_controller() to drop duplicate IDR allocation.
> Instead of if-else-if branching use two sequential if:s, which allows
> to re-use the logic of IDR allocation in all cases.

For legibility this should have been split into a separate factoring out
of the shared code and rewriting of the logic, that'd make it trivial to
review.

> -		mutex_lock(&board_lock);
> -		id = idr_alloc(&spi_master_idr, ctlr, first_dynamic,
> -			       0, GFP_KERNEL);
> -		mutex_unlock(&board_lock);
> -		if (WARN(id < 0, "couldn't get idr"))
> -			return id;
> -		ctlr->bus_num = id;
> +		status = spi_controller_id_alloc(ctlr, first_dynamic, 0);
> +		if (status)
> +			return status;

The original does not do the remapping of return codes that the previous
two copies do...

--ugTz/0iIbXaMesMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsOysACgkQJNaLcl1U
h9Bj2wf/eujSGQes7B4PBTQ3n1oBhkcL7Y24XQnkT5q6FXhb+PNy2gOUL7X4u8/s
jewRdgc+ViUGaokkDON2TN26dLdi/+KEGq7rPGhgLMeyGSqKJx5uRaCQSSdKa2Y2
w1zSdEXhWd9SZsgsLa18k9bVMBbmyuylLjQYrLlHktiuD4/baW1HQ5SqKICkb1Bg
/ZdcRGqcKDfgJWnVfK4loF7rFNMRBY0rXsSdOVE3yOKeZE2uS46s2BPPN+xc7UaA
KTSUu8JjCacwP+V70yrm4VGRb5/c0NJ++iO44yiykKNRvcJWCDemwAYhj9zV1ja/
5l/fUqxd3+5Kv3hbc1rSnyAywM7/4g==
=1GBL
-----END PGP SIGNATURE-----

--ugTz/0iIbXaMesMQ--


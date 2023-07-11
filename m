Return-Path: <netdev+bounces-16868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DB74F16F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E433F281865
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 14:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301C19BAD;
	Tue, 11 Jul 2023 14:15:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9814AB5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 14:15:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CBC433C9;
	Tue, 11 Jul 2023 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689084907;
	bh=A+lgFSqWg8vRgir1XqFzY9nIE1Cw0dwqFBu8P2BdZBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwXQpO0JwJwS2tync5AfGpO9HXb9u4mgZfpWRxyxjmWV7o23oHa66oSgLBUqWen2D
	 ZlOHsSEyXpzrsEeWWEmLhLLitAzI15911I18ub63ARZldiwGDK6EeLi3B34Qy+IEG4
	 waxyA6VmnpE80hBohYtayTpWfyRhiz5yBCu2xfPCie7wDB1OJGO5pfFeIe7TmhLaf6
	 2F7TtEpspxDmIAOKWfQt4n5/QaTo60Dymh5zBKNq1hnkXPOMFNsHXFu721qfrAekf9
	 KAql0ORVXuf2YxOmwhPq6tE1iNaCTZM61qgKsPoZvWs0hppRNFtMcBrTT4RcCr66z6
	 VpMXSzxRgleHw==
Date: Tue, 11 Jul 2023 15:14:54 +0100
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
Subject: Re: [PATCH v2 04/15] spi: Replace open coded
 spi_controller_xfer_timeout()
Message-ID: <5959b123-09e3-474b-9ab0-68d71cfdd9a2@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <20230710154932.68377-5-andriy.shevchenko@linux.intel.com>
 <cfaffa00-4b61-4d81-8675-70295844513b@sirena.org.uk>
 <ZK02efTYxV3czigr@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MZrPSMfLUzZVYlnE"
Content-Disposition: inline
In-Reply-To: <ZK02efTYxV3czigr@smile.fi.intel.com>
X-Cookie: marriage, n.:


--MZrPSMfLUzZVYlnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 02:01:13PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 06:30:32PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 06:49:21PM +0300, Andy Shevchenko wrote:

> > > + * Assume speed to be 100 kHz if it's not defined at the time of invocation.

> > You didn't mention this bit in the changelog, and I'm not 100% convinced
> > it was the best idea in the first place.  It's going to result in some
> > very big timeouts if it goes off, and we really should be doing
> > validation much earlier in the process.

> Okay, let's drop this change.

Like I say we *should* be fine with the refactoring without this, or at
least if it's an issue we should improve the validation.

> > > +	u32 speed_hz = xfer->speed_hz ?: 100000;

> > Not only the ternery operator, but the version without the second
> > argument for extra clarity!

> Elvis can be interpreted as "A _or_ B (if A is false/0)".
> Some pieces related to SPI use Elvis already IIRC.

I understand what it means, I just don't find it's adding clarity most
of the times it's used (there's a few places where it is useful like
pasting in strings in formats).  There are some examples that I'd
complain about in the code, most of them predating me working on SPI too
much, but I'm not a fan.

--MZrPSMfLUzZVYlnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStY90ACgkQJNaLcl1U
h9DeQQf+MxpgOv6egcsQtreuAtaq7Ev7HPCaH6MbusHDNH2hElvH+GmEYjovkV6m
h3LadU5OvktJBaXfjDQRjU71Cbf70/Nlo8I3WN5V4iRKzqWtfMV16ZStvy2+1Rx/
jHek+Aib8L8SiwlzvD6WB163yHCsSn5KBv2Pqp95DjGWamTl918onxXzSS6g2j5A
ib1Mz8aOXWBsiIdaFTQ3NoK7Uvnykzp1X2uGcfrRZuPWQNVvpJs/wt5iOuTpuEws
6O2PEgJext+6CeKBCv8pCvpex2QsVtDKLnDVvmDX4Oa2impxsxSIjLyVbZfbJ480
4XviYIQ2LNlTFidlbAAqqEafOQrvRg==
=WM20
-----END PGP SIGNATURE-----

--MZrPSMfLUzZVYlnE--


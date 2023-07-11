Return-Path: <netdev+bounces-16856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB0274F05F
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C871C20ECD
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA39E18C24;
	Tue, 11 Jul 2023 13:38:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDAD18AFF
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 13:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C419BC433C7;
	Tue, 11 Jul 2023 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689082738;
	bh=ItxG0MufVqKsV6l67e6rahqYiXE+oNZWIixR/ZiAk7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m4h5A9eucXGEK5wiqhxNlBc101UZTB1GTSu+bNPFIqQi8lSIpgckIDopdxZ8GCXDU
	 KaYIqfFehq9XBY9C78BmSRuGAnEkoiVqck1jWN3OSijvCTDKQiEiACW+JrNNDrogva
	 3EVk5wIoKUlrmASobQlDeI0AXZVsTEb3Co/GLkxVP16Cs59Esgav2MUFclqw4fiLZW
	 IphOe5HIOtsn51q81shBdkY7+ZB7u0D1/Dnzv8i5DLtWFLx045byoaUqXj3YMCZRgP
	 Ssnb20dZBFAw4KBSQvZFSG4aJSBBBsmLSdXDHDge2m5HFHwVmkPwFjrJUGV9EZW521
	 Yi9ajN7auQ10g==
Date: Tue, 11 Jul 2023 14:38:37 +0100
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
Subject: Re: [PATCH v2 00/15] spi: Header and core clean up and refactoring
Message-ID: <af598782-6998-4d60-b7fc-3d9aaeb0fe8f@sirena.org.uk>
References: <20230710154932.68377-1-andriy.shevchenko@linux.intel.com>
 <58c6f76a-8028-4ce8-a101-d5feb3b40897@sirena.org.uk>
 <ZK04/8UQEaNinLoK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fpte6ZPjzz/LFITf"
Content-Disposition: inline
In-Reply-To: <ZK04/8UQEaNinLoK@smile.fi.intel.com>
X-Cookie: marriage, n.:


--Fpte6ZPjzz/LFITf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 11, 2023 at 02:11:59PM +0300, Andy Shevchenko wrote:

> Do you think patch 9 deserves to be proceeded?

That one I need to think about, may as well resend it and I can think
about the resend.

--Fpte6ZPjzz/LFITf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmStW1wACgkQJNaLcl1U
h9DwCgf6A57WeIs5A+kjDx2nQTR4R6O8VfCeSUxA5+sJLtnTgMShxvODRTArEDJp
mTB75kAcKQxMw/qNGyDzWRgUYTymPxp24jfu8cWXoEU6FoM1u7fdVIEs/3zF4VI8
tcXZks8p77A/Xye4dlq/LB2IhJ3CctS47Q6Y+Yr6aACWkOGboS87FDNBeE+4cxcS
nF4f4M2/d0j85zTf5tfGFaY52gS5Nf9G4MQ8/haFpUaUj2seOk+JpKeF+jqpWc+b
fjJfrUWG8bC5u8ZfCBniq+wFRLCP6qCskkygh44lrP9yQTKxdUIRoNkcMT2kdz1H
NguDaiHKGw9X8e6bahJyFd+NyGugwg==
=B9iG
-----END PGP SIGNATURE-----

--Fpte6ZPjzz/LFITf--


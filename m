Return-Path: <netdev+bounces-23066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5256776A94B
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E87E28180A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DB846B6;
	Tue,  1 Aug 2023 06:39:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E57B46B4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:39:16 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB4D98
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:39:13 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qQj0d-00070v-4I; Tue, 01 Aug 2023 08:37:31 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 76E8C20035C;
	Tue,  1 Aug 2023 06:37:21 +0000 (UTC)
Date: Tue, 1 Aug 2023 08:37:21 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jose Abreu <joabreu@synopsys.com>, imx@lists.linux.dev,
	Simon Horman <simon.horman@corigine.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Fabio Estevam <festevam@gmail.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jerome Brunet <jbrunet@baylibre.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wong Vee Khee <veekhee@apple.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Revanth Kumar Uppala <ruppala@nvidia.com>,
	Jochen Henneberg <jh@henneberg-systemdesign.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net 1/2] net: stmmac: add new mode parameter for
 fix_mac_speed
Message-ID: <20230801-portside-prepaid-513f1f39f245-mkl@pengutronix.de>
References: <20230731161929.2341584-1-shenwei.wang@nxp.com>
 <20230731161929.2341584-2-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bosuzfm7oov47gw7"
Content-Disposition: inline
In-Reply-To: <20230731161929.2341584-2-shenwei.wang@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--bosuzfm7oov47gw7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 11:19:28, Shenwei Wang wrote:
> A mode parameter has been added to the callback function of fix_mac_speed
> to indicate the physical layer type.
>=20
> The mode can be one the following:
> 	MLO_AN_PHY	- Conventional PHY
> 	MLO_AN_FIXED	- Fixed-link mode
> 	MLO_AN_INBAND	- In-band protocol
>=20
> Also use short version of 'uint' to replace the 'unsigned int' in the
> function definitions.

There are not many users of 'uint' in the kernel and it's not used in
the stmmac driver so far. From my point of view I would not introduce
it and stick to the standard 'unsigned int'.

Just my 2 cent,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--bosuzfm7oov47gw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTIqBwACgkQvlAcSiqK
BOi7Jgf/UaTFYSC4IuXT7k8VsP0wkBG1kcRP+yNZbLdHhdJNmRn2K0iTpv82c/8q
ZYpLreaQqEKOb7TszFXyDCSS1Mssv66nj047Dc6LHrnW2VbY7P9LSCMsnSUaoh0a
lkOknimCFo9HKbYqND+gh1y/o6Wz5PO36qbaBR1giHbUdB9+Ow0AlTR3V9KeMOb4
OsXSR2ihf5LYXebKvn8StZSwICnzZ78eLFZJsxu0oEMJDnaxIM5VQb9MaCfPbZv8
/Bco4yUWkcOqrMmHnL9TSVvgaNJLzxowhcbwA9rucxpS314AJAqil34OSnmnQeGW
1+lihD2B9mQqxq0drsTeFh5UBcLxNA==
=DXrv
-----END PGP SIGNATURE-----

--bosuzfm7oov47gw7--


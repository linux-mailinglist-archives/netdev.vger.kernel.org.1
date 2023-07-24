Return-Path: <netdev+bounces-20272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D69075EDCF
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDD32814B8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E531917C1;
	Mon, 24 Jul 2023 08:38:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F331102
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:38:21 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2AE76
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:38:18 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qNr4k-0000Cb-FM; Mon, 24 Jul 2023 10:37:54 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 531031F839B;
	Mon, 24 Jul 2023 08:37:52 +0000 (UTC)
Date: Mon, 24 Jul 2023 10:37:51 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Vivek Yadav <vivek.2311@samsung.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH v3 6/6] can: tcan4x5x: Add error messages in probe
Message-ID: <20230724-switch-mulch-3ba56c15997e-mkl@pengutronix.de>
References: <20230721135009.1120562-1-msp@baylibre.com>
 <20230721135009.1120562-7-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47dlh53tks43qz2m"
Content-Disposition: inline
In-Reply-To: <20230721135009.1120562-7-msp@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--47dlh53tks43qz2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.07.2023 15:50:09, Markus Schneider-Pargmann wrote:
> To be able to understand issues during probe easier, add error messages
> if something fails.

Can you print the error codes as "%pe", ERR_PTR(err)?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--47dlh53tks43qz2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+OFwACgkQvlAcSiqK
BOjakgf6A9YWvI4O+h3cneg50ebbmXekF1W+V+CO92LM4MNZ2Vlx3Iv6YrdxgAG/
f7UASQ3G9eBjJLQYnGHbYG5DMgR2p9Y8LGJB6cJQ3EiRcsVe7vRi71iUyRthiUTB
jDgHJwBcTO8jeitILlFmOsrZMljTU5AzkSJG6eoRY4xK5p2GjlFULxr0h8TwxgXQ
McZkpazS9fiijMLL5V63U5P3vpui2iSp1nDy3ZfDeRI71/egjLVj1EmZ5ILcY/cQ
hthAmBCjEZ5hHS8lvllfRcP5zr/N2L9/OylrwTrPT1dsU6dVAQE7einaoUgSSvrU
z4zth+g2cGEh5UXzTHg3iZ2aZPR0LA==
=23ps
-----END PGP SIGNATURE-----

--47dlh53tks43qz2m--


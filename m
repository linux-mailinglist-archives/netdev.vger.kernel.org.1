Return-Path: <netdev+bounces-22730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE14768FCD
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3E9280ABC
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D896711C82;
	Mon, 31 Jul 2023 08:14:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF263A2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:14:36 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2510E0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:14:22 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qQO2U-0006jW-9D; Mon, 31 Jul 2023 10:14:02 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0315A1FEAF8;
	Mon, 31 Jul 2023 08:13:58 +0000 (UTC)
Date: Mon, 31 Jul 2023 10:13:57 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, haibo.chen@nxp.com,
	u.kleine-koenig@pengutronix.de, socketcan@hartkopp.net,
	yangyingliang@huawei.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH -next] can: flexcan: fix the return value handle for
 platform_get_irq()
Message-ID: <20230731-vineyard-subarctic-4ced2dc600c2-mkl@pengutronix.de>
References: <20230731075252.359965-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rap7gd5fgqjweinl"
Content-Disposition: inline
In-Reply-To: <20230731075252.359965-1-ruanjinjie@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--rap7gd5fgqjweinl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 15:52:52, Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rap7gd5fgqjweinl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTHbUIACgkQvlAcSiqK
BOhmsggApUJW/FLPG1Q8xGk8M0O5N/d+lMpE+KWDZhzRxPbxS8MocYOckH3PhaeA
zzSdzmHYMaZWnDLw6MecGTW/JBsntiGlrWqrGw9u9K+2lOC19IkbqPzAJtFek3+/
hUvtyQam2z9ev7N9dNx586GhIwsdyaQvLrZ7dHel90CUYyqOXG166QzfgNVVdFlX
W8Vzpk6qJYOjioQK91YATy55vm/K5YgAQgp8sjQLEINMRLfj6jD9yx9LPhe3j8yT
LqRfDPCzkHRP3SdIKmFapoWv09+mMBTIec09LxG2jqWKAGGKbmBxzZnjRcy9TNfi
agZnAVg0XYgKHtHLdW2kNwcSRbywaA==
=16Gc
-----END PGP SIGNATURE-----

--rap7gd5fgqjweinl--


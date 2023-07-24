Return-Path: <netdev+bounces-20268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 117F075ED49
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3211C20A9F
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 08:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A341C32;
	Mon, 24 Jul 2023 08:21:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFF1FBF
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 08:21:23 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CAA93
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 01:21:22 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qNqoS-0006f6-5U; Mon, 24 Jul 2023 10:21:04 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 91D5A1F8378;
	Mon, 24 Jul 2023 08:21:01 +0000 (UTC)
Date: Mon, 24 Jul 2023 10:21:01 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Peter Seiderer <ps.report@gmx.net>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukas Magel <lukas.magel@posteo.net>,
	Stephane Grosjean <s.grosjean@peak-system.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] can: peak_usb: remove unused/legacy
 peak_usb_netif_rx() function
Message-ID: <20230724-anemia-canola-508fb2e26392-mkl@pengutronix.de>
References: <20230721180758.26199-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2l4np6uf55mes7zh"
Content-Disposition: inline
In-Reply-To: <20230721180758.26199-1-ps.report@gmx.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--2l4np6uf55mes7zh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.07.2023 20:07:58, Peter Seiderer wrote:
> Remove unused/legacy peak_usb_netif_rx() function (not longer used
> since commit 28e0a70cede3 ("can: peak_usb: CANFD: store 64-bits hw
> timestamps").
>=20
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2l4np6uf55mes7zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+NGcACgkQvlAcSiqK
BOjC7Af/W6pC9oD0GH+r7tZRybBPDyWZMCMQy7h3ye3f+QktxRZAP1WVbUdF21wp
1nYJeHJ1+bLOYaKfmBxuZOJLQ6eHVksWA2KRiaqWqvk0pOPeioUyzog1rhJdifzM
tmRnop8JU1mhb2f59S9MCwpCDhhFXdw+EQo0rVNlqyPdDZ1VNyouD9ptqB73fOX0
4dLr2a0f0UFRJ/o3YPDd63B8rKGIb1T5L3CUudEOhwM+RFIJXhQA3a3/Dd1spG1p
5PRdk/AWo6JFObhy9VdphxyMDDRWHQvpusCk4j8yKOPjsIqZ2bNKlO0wVi+fiNUV
OE2o4MASv27JHbA46Kk/NiCQ/vWv8w==
=FTcs
-----END PGP SIGNATURE-----

--2l4np6uf55mes7zh--


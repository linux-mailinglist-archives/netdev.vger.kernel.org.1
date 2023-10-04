Return-Path: <netdev+bounces-37919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF81E7B7CE7
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C6FB281458
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7E11195;
	Wed,  4 Oct 2023 10:14:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52C11193
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:14:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDE090
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:14:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnytm-0005c4-9F; Wed, 04 Oct 2023 12:14:34 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnytk-00B0Sc-JE; Wed, 04 Oct 2023 12:14:32 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 48A9722ECE4;
	Wed,  4 Oct 2023 10:14:32 +0000 (UTC)
Date: Wed, 4 Oct 2023 12:14:31 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	sylvain.girard@se.com, pascal.eberhard@se.com
Subject: Re: [PATCH net-next] can: sja1000: Fix comment
Message-ID: <20231004-playgroup-angler-707c3d55bf9b-mkl@pengutronix.de>
References: <20230922155130.592187-1-miquel.raynal@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j6gsdx63leplzql5"
Content-Disposition: inline
In-Reply-To: <20230922155130.592187-1-miquel.raynal@bootlin.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--j6gsdx63leplzql5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22.09.2023 17:51:30, Miquel Raynal wrote:
> There is likely a copy-paste error here, as the exact same comment
> appears below in this function, one time calling set_reset_mode(), the
> other set_normal_mode().
>=20
> Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--j6gsdx63leplzql5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdOwUACgkQvlAcSiqK
BOgGGgf6AzbARBdNBmWLKKT8OsUwkarlKPEiAy0OAXn8QtDpiV8NikKVKvNcB+/8
C3OEF8wD3LCMvccdobAismQtDdmV5CYITjycGrIYwsHcVQGbEvtoAjKf9NFyaaDY
jNEC9j4xv4dpN5dNbSctBfcR6s0rOmxZbKDenRXT1O1632+9O2BaF0JGaETxUXnQ
ykPsMog4zGa63Gwx2J4uz7WYxbVrE0yyYkDLGqLCysOYkp++qPrue4gsBpL9fEq6
9+R58gAqrg4Uk8pzqRBzf2NXQrENkXIiwhxqFGgR3jqAjYqMNwdbYeK0mbn7EFik
6dpO6dy0J00faUb5DrNUxdcDE1hqLA==
=UhI7
-----END PGP SIGNATURE-----

--j6gsdx63leplzql5--


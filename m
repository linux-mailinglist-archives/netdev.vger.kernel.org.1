Return-Path: <netdev+bounces-37921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070447B7D0F
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B6B8E281470
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD7C1119F;
	Wed,  4 Oct 2023 10:24:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2211181
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:24:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2407AF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:23:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz2g-00075J-Tj; Wed, 04 Oct 2023 12:23:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz2g-00B0Xh-2u; Wed, 04 Oct 2023 12:23:46 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C502222ED16;
	Wed,  4 Oct 2023 10:23:45 +0000 (UTC)
Date: Wed, 4 Oct 2023 12:23:45 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: John Watts <contact@jookia.org>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set
Message-ID: <20231004-icky-contempt-b46d6bb68918-mkl@pengutronix.de>
References: <20230905231342.2042759-2-contact@jookia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3zhqjwthn6wlylc"
Content-Disposition: inline
In-Reply-To: <20230905231342.2042759-2-contact@jookia.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--z3zhqjwthn6wlylc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.09.2023 09:13:43, John Watts wrote:
> When adding the RISCV option I didn't gate it behind ARCH_SUNXI.
> As a result this option shows up with Allwinner support isn't enabled.
> Fix that by requiring ARCH_SUNXI to be set if RISCV is set.
>=20
> Fixes: 8abb95250ae6 ("can: sun4i_can: Add support for the Allwinner D1")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-sunxi/CAMuHMdV2m54UAH0X2dG7stEg=3Dg=
rFihrdsz4+o7=3D_DpBMhjTbkw@mail.gmail.com/
> Signed-off-by: John Watts <contact@jookia.org>

Applied to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--z3zhqjwthn6wlylc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdPS4ACgkQvlAcSiqK
BOhU5wf/dWWTRwtQpRT5Pz70QGC+v3K6sLXPZfBgh7btGZOF7Icwh3w4GGbx4RTA
k1lx2Brcq6tPO3MsdqJRgp4CSpOrDlvuwIG51mA/UfFjRSbBYfpbdVkYjBJ7UdiK
VUBUiHfv9W7IUon50lb0SFUREQ/wnaCgfoorQ+tPC0lhPhOAsR14/pk3xu5snmcH
VUgJZobxei+Dvs6OfWcVt34+OeBwD28v60NNhVKR7lcVVB8pGsOs7zNM4R/d6N7f
rXPxbs2SJi2hiT0+87c9p5AvwxslNDOq5SMhXUGtFfNDBByOnvfLBeLo5xC5Rs3k
60tmdWRPZRMQ9uBkCvFItxgM2c4YcA==
=HeNY
-----END PGP SIGNATURE-----

--z3zhqjwthn6wlylc--


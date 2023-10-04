Return-Path: <netdev+bounces-37920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437497B7D02
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9AEFA281466
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5164611181;
	Wed,  4 Oct 2023 10:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E509E1096D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:22:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5EA9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:22:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz1f-0006w7-Tb; Wed, 04 Oct 2023 12:22:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz1e-00B0XR-DR; Wed, 04 Oct 2023 12:22:42 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 121FB22ED0F;
	Wed,  4 Oct 2023 10:22:42 +0000 (UTC)
Date: Wed, 4 Oct 2023 12:22:41 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: tcan4x5x: Fix id2_register for tcan4553
Message-ID: <20231004-lived-stream-132ba649a5b3-mkl@pengutronix.de>
References: <20230919095401.1312259-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="25nib7y7zc3yztox"
Content-Disposition: inline
In-Reply-To: <20230919095401.1312259-1-msp@baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--25nib7y7zc3yztox
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.09.2023 11:54:01, Markus Schneider-Pargmann wrote:
> Fix id2_register content for tcan4553. This slipped through my testing.
>=20
> Reported-by: Sean Anderson <sean.anderson@seco.com>
> Closes: https://lore.kernel.org/lkml/a94e6fc8-4f08-7877-2ba0-29b9c2780136=
@seco.com/
> Fixes: 142c6dc6d9d7 ("can: tcan4x5x: Add support for tcan4552/4553")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Applied to linux-can/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--25nib7y7zc3yztox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdPO4ACgkQvlAcSiqK
BOggEQgArXhOHxEukUB7xEopgEdyLzObndXNSKu56YlzHEQRyeqYi+om0wXsyZ5J
jqscyu1sCNx4UzYH0uKkaUIKzPw8HzQCNFs+Z/veVlhpeSHRiAaJLcGFUi+ixhQM
XN47Z2m9PkcYiSzggeMmBLv7iV92Jvkj4BfYwUSzxAnk9QLBrMvQZApueC5DmVpp
1TSVy1OBRbumXVyTKY1fPbVAOpQtMixp8YdIZKXKlkodYg0kaMErUGDDkve3hrSX
ghn1LJg2gK6CG11mpKSHebkKwiVnsHoujQWvklBuSlBmZQs5msPLTjx+wH2Aqv6w
yh7LeX4NVoz3U0W8P0riQYICYjI6Zg==
=2QfN
-----END PGP SIGNATURE-----

--25nib7y7zc3yztox--


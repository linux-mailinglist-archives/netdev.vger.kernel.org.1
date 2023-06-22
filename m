Return-Path: <netdev+bounces-12997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA4739A11
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426C91C20318
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC022546;
	Thu, 22 Jun 2023 08:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802B22543
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 08:30:50 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F21BF4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 01:30:20 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qCFhm-0004vd-NI; Thu, 22 Jun 2023 10:30:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F24661DF541;
	Thu, 22 Jun 2023 08:30:13 +0000 (UTC)
Date: Thu, 22 Jun 2023 10:30:13 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/33] pull-request: can-next 2023-06-21
Message-ID: <20230622-enviably-sheet-50ba35975d50-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vx6h4hhvm6tdbzk"
Content-Disposition: inline
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--2vx6h4hhvm6tdbzk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21.06.2023 15:28:41, Marc Kleine-Budde wrote:
> Hello netdev-team,
>=20
> this is a pull request of 33 patches for net-next/master.

Don't pull this branch, Simon Horman noticed it's not bisectable.

See https://lore.kernel.org/all/20230622082658.571150-1-mkl@pengutronix.de
for an updated pull request

Sorry for the noise,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2vx6h4hhvm6tdbzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSUBpEACgkQvlAcSiqK
BOg6dQf+NrS4+lyfPEenv1V+SkD6OH0B1IeZuuzXses3DAPr6I1lRhSy7MixBopq
MtDpgpFH5Gf1ps88AJi2Z92CbVSx6p4sW8hlTU1XOVCXy0ciDlBhxd6yvr2L9mmE
hTHsK3PuJMY9cj/oYPlX3mFRHpD0WlulBySJLUgnpy7Y2n7/ep2vbIzLRQ8RIebV
E/CCfMLJYi248K7QGTbPfSXHcMbY7T05Inlw0wLICJMpEo7QNKk95yltPrXY9aBp
3M3EQEb7rcYvpHfBwNSAcJIeTzyfOLy9ew+lZSkJO3ZVBnBNp0o6N1HizDCZToYP
EuKVyXrJfC+z5j6iBqwGiXjq0Q37BA==
=e/Do
-----END PGP SIGNATURE-----

--2vx6h4hhvm6tdbzk--


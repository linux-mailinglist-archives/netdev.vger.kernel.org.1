Return-Path: <netdev+bounces-18874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C3E758EF7
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1548B280E46
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FB1C2DF;
	Wed, 19 Jul 2023 07:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC6B10953
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:25:25 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F72E43
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:25:24 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qM1Yl-0003ZN-0R; Wed, 19 Jul 2023 09:25:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 57B5A1F4CDD;
	Wed, 19 Jul 2023 07:25:18 +0000 (UTC)
Date: Wed, 19 Jul 2023 09:25:17 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Jimmy Assarsson <extja@kvaser.com>,
	Martin Jocic <majoc@kvaser.com>
Subject: Re: [PATCH net-next 7/8] can: kvaser_pciefd: Move hardware specific
 constants and functions into a driver_data struct
Message-ID: <20230719-flint-saloon-a64345c0243c-mkl@pengutronix.de>
References: <20230717182229.250565-1-mkl@pengutronix.de>
 <20230717182229.250565-8-mkl@pengutronix.de>
 <20230718183315.27c0cd27@kernel.org>
 <20230719-purge-obtrusive-997e0ac2d998-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h4jqsk2ahouwyzc2"
Content-Disposition: inline
In-Reply-To: <20230719-purge-obtrusive-997e0ac2d998-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--h4jqsk2ahouwyzc2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19.07.2023 08:53:04, Marc Kleine-Budde wrote:
> On 18.07.2023 18:33:15, Jakub Kicinski wrote:
> > On Mon, 17 Jul 2023 20:22:28 +0200 Marc Kleine-Budde wrote:
> > > +const struct kvaser_pciefd_address_offset kvaser_pciefd_altera_addre=
ss_offset =3D {
> >=20
> > > +const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask =
=3D {
> >=20
> > > +const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops =3D {
> >=20
> > > +const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_d=
ata =3D {
> >=20
> > sparse points out the structs in this and subsequent patch should
> > be static. Would you be able to queue a quick fix on top and resend,
> > or should we pull as is?
>=20
> Sorry, I'll post an updated pull request.

https://lore.kernel.org/all/20230719072348.525039-1-mkl@pengutronix.de

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--h4jqsk2ahouwyzc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS3j9sACgkQvlAcSiqK
BOiuAAf/azvBFxBcifWVi6V/fUHkB+BhP+7WHoxaj/4nDSbmAHDKCAgouS+cEXUE
ipuBULEMTgSJVTZFucbVdyksUkmkTyhNJ8m1jGmZdFAhzwGpmdyuA2WY7R9uTz0a
YWbLqtmapO+foz0mFtZGSrZN514TY/iMC194mIbPydwFfna5RCcxQQj2Dy1Pg59J
4shXznLeHuaD7rbi4MklO3L4BkOkoO/qgJjT20LeEX3mN7SgB99iXu/Cdn8E5BRs
3AFNZA/6PoizYNDSmwrT5aJ9I0AqcpOQgZivii31SceunawNrfX2vBeulYCygHeC
KJDvKXFRyyrNxGYM+6Ua6tqJWx7rrA==
=gDai
-----END PGP SIGNATURE-----

--h4jqsk2ahouwyzc2--


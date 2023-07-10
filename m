Return-Path: <netdev+bounces-16344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C374CDA0
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 08:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D16280E03
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6986440A;
	Mon, 10 Jul 2023 06:49:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD6E3D8C
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 06:49:39 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F398E
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 23:49:38 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qIkhz-0004j7-25; Mon, 10 Jul 2023 08:49:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3A4901ECAA5;
	Mon, 10 Jul 2023 06:49:15 +0000 (UTC)
Date: Mon, 10 Jul 2023 08:49:14 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Su Hui <suhui@nfschina.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
	yunchuan@nfschina.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2 09/10] can: ems_pci: Remove unnecessary
 (void*) conversions
Message-ID: <20230710-parachute-dispersal-208e1a406b78-mkl@pengutronix.de>
References: <20230710064138.173912-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vliygvx23paytwk4"
Content-Disposition: inline
In-Reply-To: <20230710064138.173912-1-suhui@nfschina.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--vliygvx23paytwk4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10.07.2023 14:41:38, Su Hui wrote:
> From: wuych <yunchuan@nfschina.com>
>=20
> Pointer variables of void * type do not require type cast.

I like the idea. Please add my Acked-by: Marc Kleine-Budde
<mkl@pengutronix.de>, after you've fixed the issue:

> Signed-off-by: wuych <yunchuan@nfschina.com>

This patch is not Signed-off-by the contributing person.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--vliygvx23paytwk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmSrqecACgkQvlAcSiqK
BOiTlQf+KaGq+RQKecV2KZC82/U90JGtuIisVjkNKRh/mMhg+6CPgj37A36dJopA
B309j3311kHTCuBsPWfD+IXLkOunPKJRGtxL+IxsXWtcAClti6YDG7HqUYGl9Mpi
f0vyLf1xV60WUFTu6yJ2w6Rn25G79SM+071PWHHgDGqqb2vSYZFIY8d2hhnh/as8
oKl3x8v+Fskg/so9Z8QKZ3cydmNhH/FOFwu6kNk7ofEzNokpcVQ5Os6Fk6nt5VJT
HjeB7kAV+JuKO07gyMqZKKPfOm5z4f+tsWB3RkSRnKPMM9J6+U/5Gwl/v7X21+5e
d8sLIAYPaGagxcB1uQXk9Djy+S3kbg==
=dqfX
-----END PGP SIGNATURE-----

--vliygvx23paytwk4--


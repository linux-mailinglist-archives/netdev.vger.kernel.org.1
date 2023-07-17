Return-Path: <netdev+bounces-18327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4EA756703
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E23D28132D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061A253C4;
	Mon, 17 Jul 2023 15:01:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40726253AD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:01:00 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAD3B9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:00:59 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qLPiR-00087z-5n; Mon, 17 Jul 2023 17:00:47 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 05ECE1F3742;
	Mon, 17 Jul 2023 15:00:45 +0000 (UTC)
Date: Mon, 17 Jul 2023 17:00:44 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wu Yunchuan <yunchuan@nfschina.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v4 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Message-ID: <20230717-spiritual-fester-3a3545e016af-mkl@pengutronix.de>
References: <20230717071800.144129-1-yunchuan@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2ajwgef3t33s6d4"
Content-Disposition: inline
In-Reply-To: <20230717071800.144129-1-yunchuan@nfschina.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--u2ajwgef3t33s6d4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2023 15:18:01, Wu Yunchuan wrote:
> No need cast (void*) to (struct ems_pci_card *).
>=20
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--u2ajwgef3t33s6d4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS1V5kACgkQvlAcSiqK
BOhN2wf+NQnJZgnGQ4H7tSalyx5onEl/yHFqTFFFAfwcGOlIYfl8yKKk9O0IXu9K
nT0dgyEmvivzr5ioAiuA8QmYMeimymsD67Au+JakBNErPVLLpfcm4nn5NIuSzn0F
ZKnfRiUtgX0+Nb97BhhpgmxFQMP//O/M2XAVqFGMEKsX/RtAl/sn4ykHDQYgv5TO
eVYnZQFV2vX131nbGXvsIkKz6PaLe50oMa1pzc/z6/YX0SUZ5/yab4NJWHr8pEf6
8zXh+vBvSBm3ouGEBpgrofDYsAyt2BU8pXVfBhegIxJP5cFcuI/5DmYnqOEdRTey
MF2Jrp/U3wthnbn9IzIf1cBeYf7PKA==
=d4dX
-----END PGP SIGNATURE-----

--u2ajwgef3t33s6d4--


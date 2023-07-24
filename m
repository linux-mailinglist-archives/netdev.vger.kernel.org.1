Return-Path: <netdev+bounces-20421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495775F754
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E701C20B33
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 12:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5016D38;
	Mon, 24 Jul 2023 12:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235F53BA
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 12:54:46 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76F5BA2
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 05:54:25 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qNv3m-0003xy-60; Mon, 24 Jul 2023 14:53:10 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7BE8F1F883E;
	Mon, 24 Jul 2023 12:53:06 +0000 (UTC)
Date: Mon, 24 Jul 2023 14:53:05 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] can: raw: fix lockdep issue in raw_release()
Message-ID: <20230724-bubble-grasp-b7e65af54bb9-mkl@pengutronix.de>
References: <20230720114438.172434-1-edumazet@google.com>
 <35c85eb5-24aa-d948-516a-72fa7db28c88@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rviok646mxfd6hxt"
Content-Disposition: inline
In-Reply-To: <35c85eb5-24aa-d948-516a-72fa7db28c88@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--rviok646mxfd6hxt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.07.2023 14:49:28, Oliver Hartkopp wrote:
> Hello Eric, Jakub,
>=20
> the patch that needs to be fixed here is currently already on its way into
> the stable trees:
>=20
> > Fixes: ee8b94c8510c ("can: raw: fix receiver memory leak")
>=20
> Should this patch go through the linux-can tree or would somebody like to
> apply it directly to the net tree?

I'll send a PR including this fix today.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rviok646mxfd6hxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS+dC8ACgkQvlAcSiqK
BOiXtAgAiaZgw+a+qM+EwegTjTMuBFDkqzNk/J/0algu+wrN2JCSjxfEA4LNwjNv
779J3kcRB6xkFSlLDfh9ZZ7D2i27hH5G0KhJ39N0qQMbUdLY6yzADM58Gegxqnij
NZHXpT3A1JMh/Bm4qAL6NIS+bHS/aiwPIyWF2jsBKI1TMC1ykSoSKTMRMjZoshkx
+Guibdz9Zr4hAGuZe1fI0JPcHpIYir88atslMDGsGVcomfvLgQrC1ubIbyvf9UYu
IoKY0VehsCcdT3v2+QioQ7w0BTtxcfMEomebMyvziVoESkyM0Fp9fNVEjZHjNQRo
Vg/qlDn7q+nTsaYAIcZUepBdKOAqTg==
=BYRw
-----END PGP SIGNATURE-----

--rviok646mxfd6hxt--


Return-Path: <netdev+bounces-19478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149F675AD50
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA22281E3D
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44E617FF7;
	Thu, 20 Jul 2023 11:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64DF174E9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 11:47:37 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790A1B9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 04:47:35 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qMS7r-0003Lv-EV; Thu, 20 Jul 2023 13:47:19 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 90C721F62F9;
	Thu, 20 Jul 2023 11:47:17 +0000 (UTC)
Date: Thu, 20 Jul 2023 13:47:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-can@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>, stable@vger.kernel.org
Subject: Re: [PATCH net] can: raw: fix lockdep issue in raw_release()
Message-ID: <20230720-relieving-gullible-d92198ce1312-mkl@pengutronix.de>
References: <20230720114438.172434-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njycenkbtazb4qqm"
Content-Disposition: inline
In-Reply-To: <20230720114438.172434-1-edumazet@google.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--njycenkbtazb4qqm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20.07.2023 11:44:38, Eric Dumazet wrote:
> syzbot complained about a lockdep issue [1]
>=20
> Since raw_bind() and raw_setsockopt() first get RTNL
> before locking the socket, we must adopt the same order in raw_release()

Applied to linux-can/testing

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--njycenkbtazb4qqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS5HsIACgkQvlAcSiqK
BOgbsQf/fzzFkg4HORKC5uMObiQtPyNKnugJmoGdXNXkoP+mjmQCdTMnsEpi7sG4
0lVqhMlKzvnevlRWDjS6pm3m5UJ1cXQij7C9GbRRGgmuWxGE/9Oh72O7MZ+uVGlC
zlESkZywfZng14Ap/eMg/XxBbWVCUVof5ecq9LSOVIXZegk/QGSsepfwPse6CfDb
iX6RZg94eezZC69HTYclKVfs+EDX1T6LukLRU+yEovtaQur/G2dnhrWYZ8p4GQbt
+L0nCfAv5oCJu+AFbImgEqcVOztyrk24LCQxoId+RyhjNOybzYEb0T8pojC3gAki
gWC7xPrwrmRNpUFrTC2SbNvbnjnvtg==
=zByJ
-----END PGP SIGNATURE-----

--njycenkbtazb4qqm--


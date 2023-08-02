Return-Path: <netdev+bounces-23575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8F76C8DE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193C81C21176
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECFF5673;
	Wed,  2 Aug 2023 08:59:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD18E5672
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:59:30 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D0E42
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:59:29 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qR7hK-0008Pm-Tm; Wed, 02 Aug 2023 10:59:14 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 504E72015ED;
	Wed,  2 Aug 2023 08:59:11 +0000 (UTC)
Date: Wed, 2 Aug 2023 10:59:10 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@pengutronix.de,
	chi.minghao@zte.com.cn, linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] can: c_can: Do not check for 0 return after
 calling platform_get_irq()
Message-ID: <20230802-spinout-promotion-e14916d50552-mkl@pengutronix.de>
References: <20230802030900.2271322-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xwupzmv4yljpv5ed"
Content-Disposition: inline
In-Reply-To: <20230802030900.2271322-1-ruanjinjie@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--xwupzmv4yljpv5ed
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.08.2023 11:09:00, Ruan Jinjie wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
>=20
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--xwupzmv4yljpv5ed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTKGtwACgkQvlAcSiqK
BOjo0QgAtDaOOqU4hazlfvl1pRySHn+vey+XbSU+zsoFnQNE6KFJx88DOnMwgeje
sBRNKJzO6vuwDaqopDSlkRNnM0tie27AWgMn/C+eeYqYAB/Y1rkOSccTWd+dHFZH
SVf5ZK9Tb4W2mKbejfR7yqeUQ1Vx87jwF/JUlUNuZDzgCGN+G5Ac0e2P7xSGmqt9
MVwIaE0h2MmZYlmK84yqE5YDEKrEx5/7I+vX3vbF/N1Ub3dDSMo6foa/WCCh6Gkv
MPuUclUmhvewvwpU1iRlS8EWuyETwrnQKi1MoWlONnrIsyZBqGDvzIMLGtFC2Wvv
4TTwguKokFNL7HTHMDqhMHbT8k7fsw==
=Mw80
-----END PGP SIGNATURE-----

--xwupzmv4yljpv5ed--


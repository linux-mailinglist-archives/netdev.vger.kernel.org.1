Return-Path: <netdev+bounces-34364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184DE7A3B9E
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 22:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CAD1C2098F
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 20:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB167461;
	Sun, 17 Sep 2023 20:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C56FA7
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 20:20:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C914101
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 13:20:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qhyFF-0008UD-3j; Sun, 17 Sep 2023 22:19:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qhyFB-0073yw-4k; Sun, 17 Sep 2023 22:19:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qhyFA-002Q2Y-R4; Sun, 17 Sep 2023 22:19:48 +0200
Date: Sun, 17 Sep 2023 22:19:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, johannes@sipsolutions.net
Subject: Re: [PATCH v2] net: stmmac: fix incorrect rxq|txq_stats reference
Message-ID: <20230917201946.5z5y2qn4ydpwppse@pengutronix.de>
References: <20230917165328.3403-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z7mb6j7jc652k2fi"
Content-Disposition: inline
In-Reply-To: <20230917165328.3403-1-jszhang@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--z7mb6j7jc652k2fi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2023 at 12:53:28AM +0800, Jisheng Zhang wrote:
> commit 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics
> where necessary") caused one regression as found by Uwe, the backtrace
> looks like:
>=20
> 	INFO: trying to register non-static key.
> 	The code is fine but needs lockdep annotation, or maybe
> 	you didn't initialize this object before use?
> 	turning off the locking correctness validator.
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe1-=
dirty #21
> 	Hardware name: STM32 (Device Tree Support)
> 	 unwind_backtrace from show_stack+0x18/0x1c
> 	 show_stack from dump_stack_lvl+0x60/0x90
> 	 dump_stack_lvl from register_lock_class+0x98c/0x99c
> 	 register_lock_class from __lock_acquire+0x74/0x293c
> 	 __lock_acquire from lock_acquire+0x134/0x398
> 	 lock_acquire from stmmac_get_stats64+0x2ac/0x2fc
> 	 stmmac_get_stats64 from dev_get_stats+0x44/0x130
> 	 dev_get_stats from rtnl_fill_stats+0x38/0x120
> 	 rtnl_fill_stats from rtnl_fill_ifinfo+0x834/0x17f4
> 	 rtnl_fill_ifinfo from rtmsg_ifinfo_build_skb+0xc0/0x144
> 	 rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x50/0x88
> 	 rtmsg_ifinfo from __dev_notify_flags+0xc0/0xec
> 	 __dev_notify_flags from dev_change_flags+0x50/0x5c
> 	 dev_change_flags from ip_auto_config+0x2f4/0x1260
> 	 ip_auto_config from do_one_initcall+0x70/0x35c
> 	 do_one_initcall from kernel_init_freeable+0x2ac/0x308
> 	 kernel_init_freeable from kernel_init+0x1c/0x138
> 	 kernel_init from ret_from_fork+0x14/0x2c
>=20
> The reason is the rxq|txq_stats structures are not what expected
> because stmmac_open() -> __stmmac_open() the structure is overwritten
> by "memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));"
> This causes the well initialized syncp member of rxq|txq_stats is
> overwritten unexpectedly as pointed out by Johannes and Uwe.
>=20
> Fix this issue by moving rxq|txq_stats back to stmmac_extra_stats. For
> SMP cache friendly, we also mark stmmac_txq_stats and stmmac_rxq_stats
> as ____cacheline_aligned_in_smp.
>=20
> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statistics where =
necessary")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reported-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I didn't look at the patch, but it makes the splat go away for me.
Thanks \o/

Tested-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--z7mb6j7jc652k2fi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUHX2EACgkQj4D7WH0S
/k5snggAu813qfU1WKakoC+H/WXhJwN4cXPPgMXgDZA6nrYzT6bBacs0CwmyDpWt
QnNFTF3trjFkTqqD+OIn3o+sSBzDLWcePKsvaaAJwCnhdUwKN0NCS8wFsj1EUS6K
NlRGAoXKAMJ2GxBz/cjG3SH5crrX5JaWQ1Z300jnDyLuissdrE8e1p4FMkx7+u2U
tNQoaDlzrO7/Yyu252ydShGf/7BcPQ0ORHt+J3nwlnia8wEjsyhiuGBEdvNW+lgo
h4zST1Qthn8dzmTg8U4bqG9C1UWJSOC+jliAqn9m3wjguxxlozI1wp9EoAtnQhSy
eJazAhMpOnqwixpWYHL9dJV8Uuaxkw==
=c2ks
-----END PGP SIGNATURE-----

--z7mb6j7jc652k2fi--


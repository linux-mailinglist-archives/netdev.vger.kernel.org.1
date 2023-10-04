Return-Path: <netdev+bounces-37922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91B17B7D17
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 35DAE28145E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C3111A2;
	Wed,  4 Oct 2023 10:26:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933311181
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:26:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E32AF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:26:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz4n-0007NJ-8z; Wed, 04 Oct 2023 12:25:57 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qnz4m-00B0Xz-M8; Wed, 04 Oct 2023 12:25:56 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4E5AE22ED1E;
	Wed,  4 Oct 2023 10:25:56 +0000 (UTC)
Date: Wed, 4 Oct 2023 12:25:55 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: socketcan@hartkopp.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] can: raw: Remove NULL check before dev_{put, hold}
Message-ID: <20231004-shield-accurate-6b875651801b-mkl@pengutronix.de>
References: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7n5eokfyo5pa3sfp"
Content-Disposition: inline
In-Reply-To: <20230825064656.87751-1-jiapeng.chong@linux.alibaba.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--7n5eokfyo5pa3sfp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25.08.2023 14:46:56, Jiapeng Chong wrote:
> The call netdev_{put, hold} of dev_{put, hold} will check NULL, so there
> is no need to check before using dev_{put, hold}, remove it to silence
> the warning:
>=20
> ./net/can/raw.c:497:2-9: WARNING: NULL check before dev_{put, hold} funct=
ions is not needed.
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6231
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Applied to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--7n5eokfyo5pa3sfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUdPbEACgkQvlAcSiqK
BOhaJAf8CJS4q8gjgzgbvGEY1oFdsFx5AOdvsIgFL4F3pg+7AjMNRXIX+CyDnGlf
8tmSvh/3670c5pL8EN5ptuvlUVlJDVOhiH4/28FCC+7zkoWRtEOu4U6v4Uz2onGB
d2FSb0cx7ifFIjrr6IOsBa67lPO5GD2AXXED8uyiE42K6cWYnpVqS6t48YDle5j2
u76Q97bvL2TGI1sh3FWKtrsSpgYKcRiKDW9BxodrQrboRqeUMyqfq5OMnn76bc0r
EyPe0zGVVE2peGfAWhdN1IC/5u7kuhPoB8WdymLnM99pSGeMVrPcvZ+vufB/hM3K
UnMXGbHpmSlZ18a4oJZuyYTQJaSQnQ==
=nayZ
-----END PGP SIGNATURE-----

--7n5eokfyo5pa3sfp--


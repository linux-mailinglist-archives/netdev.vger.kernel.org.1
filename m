Return-Path: <netdev+bounces-21304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F3763344
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9442D281CA3
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A8DBE66;
	Wed, 26 Jul 2023 10:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A00AD37
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 10:17:01 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD41995
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:17:00 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qObZO-0002ZA-8k; Wed, 26 Jul 2023 12:16:38 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C32901FB186;
	Wed, 26 Jul 2023 10:16:36 +0000 (UTC)
Date: Wed, 26 Jul 2023 12:16:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: haibo.chen@nxp.com
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	wg@grandegger.com, kernel@pengutronix.de, linux-imx@nxp.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, devicetree@vger.kernel.org,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: flexcan: lack of stop mode dts properity
 should not block driver probe
Message-ID: <20230726-majorette-manor-ea82bb4afa68-mkl@pengutronix.de>
References: <20230726090909.3417030-1-haibo.chen@nxp.com>
 <20230726090909.3417030-3-haibo.chen@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cjbrrbvmxmmqq34f"
Content-Disposition: inline
In-Reply-To: <20230726090909.3417030-3-haibo.chen@nxp.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--cjbrrbvmxmmqq34f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 26.07.2023 17:09:09, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>=20
> If SoC claim to support stop mode, but dts file do not contain the stop
> mode properity, this should not block the driver probe. For this case,
> the driver only need to skip the wakeup capable setting which means this
> device do not support the feature to wakeup system.

This still breaks old DTS on kernels with patch 2 applied, but not 3.
Please squash this into 2.

>=20
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/net/can/flexcan/flexcan-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/fle=
xcan/flexcan-core.c
> index a3f3a9c909be..d8be69f4a0c3 100644
> --- a/drivers/net/can/flexcan/flexcan-core.c
> +++ b/drivers/net/can/flexcan/flexcan-core.c
> @@ -1987,7 +1987,14 @@ static int flexcan_setup_stop_mode(struct platform=
_device *pdev)
>  		/* return 0 directly if doesn't support stop mode feature */
>  		return 0;
> =20
> -	if (ret)
> +	/* If ret is -EINVAL, this means SoC claim to support stop mode, but
> +	 * dts file lack the stop mode property definition. For this case,
> +	 * directly return 0, this will skip the wakeup capable setting and
> +	 * will not block the driver probe.
> +	 */
> +	if (ret =3D=3D -EINVAL)
> +		return 0;
> +	else if (ret)
>  		return ret;
> =20
>  	device_set_wakeup_capable(&pdev->dev, true);
> --=20
> 2.34.1
>=20
>=20

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--cjbrrbvmxmmqq34f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTA8oEACgkQvlAcSiqK
BOitZAgAre7gePm257fB84ueqkVE0mAA41PVK+xx6PvmmzojzCx48WrmuqgJUKxX
iFaah4dWMj5ls7nm/HZBXCNrX8HVfwZQCqOok8TaMNWn2hlZ80kzJwykcngibAEB
UCx+qAsIuUjniC8rEPkYNFxSTZg5Z+a2/oCo0orcMZ5G4mYzsIUMBH9jwtyuTJ1A
qaZqSK58oLMKNrWtJHJox9Ji2i0uhFOtJuKKsZG8yizyxHQPkKvXk37C2aSEzDXV
mDi3cI0KI+G0uNyoueYc/kxV+Dqpp03g5ZJmjSF1ak+NAvWu/g0KjoBKFSf1FYcE
j24fcHXS6KoDt/1uSaorUjAPpPTTPQ==
=FhOU
-----END PGP SIGNATURE-----

--cjbrrbvmxmmqq34f--


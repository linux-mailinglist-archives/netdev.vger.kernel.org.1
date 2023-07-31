Return-Path: <netdev+bounces-22732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF1768FD7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 10:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F28280FF7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB5A11C85;
	Mon, 31 Jul 2023 08:16:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6A883E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 08:16:35 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030830CB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 01:16:34 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qQO4j-0007KX-1o; Mon, 31 Jul 2023 10:16:21 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 496151FEB03;
	Mon, 31 Jul 2023 08:16:20 +0000 (UTC)
Date: Mon, 31 Jul 2023 10:16:19 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/10] can: slcan: remove casts from tty->disc_data
Message-ID: <20230731-playmate-character-475ae615a245-mkl@pengutronix.de>
References: <20230731080244.2698-1-jirislaby@kernel.org>
 <20230731080244.2698-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yztcseyamfs2bn76"
Content-Disposition: inline
In-Reply-To: <20230731080244.2698-6-jirislaby@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--yztcseyamfs2bn76
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 31.07.2023 10:02:39, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
>=20
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Wolfgang Grandegger <wg@grandegger.com>
> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: linux-can@vger.kernel.org
> Cc: netdev@vger.kernel.org

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yztcseyamfs2bn76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmTHbdEACgkQvlAcSiqK
BOh9/Af/THnCGoP37bgvvE65p0qzqzR//LspAtr3dZ8jCMQf12kthgFVpEAQnShe
8vvnSJXhXiFuIpBUB7nGXjnhkHLDnGX+kywVkJmQpKUWkwK1Jo75pCHIswPHTBE2
7wQkqyhKKyroUSpO7r3r8Fr1ZfH3b8Y/+fnwZtNkn7MXtURJBcrgHrbXUFMG0Pyd
pr6HvOCBDIZwn/HPPGPEnmafYbRn4d8FQl9Z21uCsG3pKVW+4Lc/IVs+SMoD++hU
qcipG4z4maGmN46y42s0V+qidixfZr3QMcxS3UbIRHOe80b1wjsDvrRv4pMb8izy
wlM9Au0ul7AI+NaZU6XphLgK9sjtIA==
=1Zek
-----END PGP SIGNATURE-----

--yztcseyamfs2bn76--


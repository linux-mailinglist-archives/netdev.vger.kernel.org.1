Return-Path: <netdev+bounces-20714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61A5760C0E
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE59281138
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3B9445;
	Tue, 25 Jul 2023 07:37:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC75311C99
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:37:38 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCFDA
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:37:16 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qOCZX-0005zf-7L; Tue, 25 Jul 2023 09:35:07 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 82F4B1F928B;
	Tue, 25 Jul 2023 07:35:02 +0000 (UTC)
Date: Tue, 25 Jul 2023 09:35:02 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] can: Explicitly include correct DT includes, part 2
Message-ID: <20230725-squeamish-walrus-a6ed8833de74-mkl@pengutronix.de>
References: <20230724211841.805053-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocgulp7ippdalqz4"
Content-Disposition: inline
In-Reply-To: <20230724211841.805053-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--ocgulp7ippdalqz4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24.07.2023 15:18:40, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to linux-can-next/testing.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--ocgulp7ippdalqz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS/eyMACgkQvlAcSiqK
BOi3zAf+PBBM2/u8saJpYng8AekPLMr62E/Shm6AKhzJpIQ9KfWUU60iNcdLffNX
lOJTO4aWlkGy4zBNHRu96BFcV7f2O/SbHAXSalaZBGr7xwp16nsGa5OXgTzbcPK7
F8yO0z2+/gNEGJiY85OnMufQ7EKpy7ediD4re0MfGss1rTDxtPh7IP4sTUjZjTgP
n2kUSLz3Wn1wMbbG65XYGLYwQ93cDLDQBVaofbrwWWmQ3Alu64xocRB7rATc3YnB
1TRLJNNtHM6GRveHKHCnWksXCPLWhxe+U1QaAybRqEm23GCHpWFEwihFNdrgGmxY
1rzoVwgLdVQizK17N9saIHKjqQtQfw==
=UTUe
-----END PGP SIGNATURE-----

--ocgulp7ippdalqz4--


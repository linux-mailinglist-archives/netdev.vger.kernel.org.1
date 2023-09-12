Return-Path: <netdev+bounces-33109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F2E79CBA9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264891C20B57
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107A16420;
	Tue, 12 Sep 2023 09:26:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E468F7C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:26:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47C4E79
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:26:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qfzfQ-0005gd-Gb; Tue, 12 Sep 2023 11:26:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qfzfO-005kKp-Vz; Tue, 12 Sep 2023 11:26:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qfzfO-001261-CY; Tue, 12 Sep 2023 11:26:42 +0200
Date: Tue, 12 Sep 2023 11:26:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Eric Dumazet <edumazet@google.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Paolo Abeni <pabeni@redhat.com>, linux-sunxi@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [REGRESSION] [PATCH net-next v5 2/2] net: stmmac: use per-queue
 64 bit statistics where necessary
Message-ID: <20230912092642.wivb4zn7kocp2kfn@pengutronix.de>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
 <20230911171102.cwieugrpthm7ywbm@pengutronix.de>
 <ZQAf9ArWfRkY/yPR@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mojihote6ig6i45p"
Content-Disposition: inline
In-Reply-To: <ZQAf9ArWfRkY/yPR@xhacker>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--mojihote6ig6i45p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 04:23:16PM +0800, Jisheng Zhang wrote:
> On Mon, Sep 11, 2023 at 07:11:02PM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > this patch became commit 133466c3bbe171f826294161db203f7670bb30c8 and is
> > part of v6.6-rc1.
> >=20
> > On my arm/stm32mp157 based machine using NFS root this commit makes the
> > following appear in the kernel log:
> >=20
> > 	INFO: trying to register non-static key.
> > 	The code is fine but needs lockdep annotation, or maybe
> > 	you didn't initialize this object before use?
> > 	turning off the locking correctness validator.
> > 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1-00449-g133466c3bbe=
1-dirty #21
>=20
> Hi,
>=20
> Which kernel version are you using? The latest linus tree? But why here
> say 6.5.0-rc1?

This is the kernel from the last bisection test. I.e.
133466c3bbe171f826294161db203f7670bb30c8 (plus some minor unrelated
changes to work around another problem). This commit is based on
6.5-rc1.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mojihote6ig6i45p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUALtEACgkQj4D7WH0S
/k5hnQf+OVXfgdZKMt4Ieq7lC/IAS3kt0AetAEO8DcU4KGCpivmEgY1+FazKg8bX
/9EVIMroVVS5m0isOSqo/mzGWIRTz3lB6zPm6UwwuLrphYd9TCZ9r7m5mi4CW1Oz
TAxEsmqiz8WG3Uj0Sjm1wX0UyCNLbwMX9s7g8LiZja5A6SEntlxhDS8u0+u+yB4P
fqriIaLSr4eM/9LaoKWbj0XglYi0K0tssYaN7qI7IwtoyDjVAjsKXBPN4U3ttzs3
OCVhg63Szx6LRdCdnYtcLUmZ8b4vS+5BnmrXH5xGeWF+46GS5yUk5ipJ9KTGQ+iL
lrui1dmkt2IprCaqSYCdABOo073omQ==
=mzlm
-----END PGP SIGNATURE-----

--mojihote6ig6i45p--


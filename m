Return-Path: <netdev+bounces-40250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DD7C6660
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E65282041
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845C5DF6A;
	Thu, 12 Oct 2023 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE06DF61
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 07:29:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA3BA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 00:29:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qqq7l-0004HS-Ei; Thu, 12 Oct 2023 09:28:49 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qqq7j-0015rf-UG; Thu, 12 Oct 2023 09:28:47 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 910B2234B97;
	Thu, 12 Oct 2023 07:28:47 +0000 (UTC)
Date: Thu, 12 Oct 2023 09:28:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the imx-mxs tree with the net tree
Message-ID: <20231012-giveaway-cider-963ce91b73cf-mkl@pengutronix.de>
References: <20231012101434.1e5e7340@canb.auug.org.au>
 <20231012004356.GR819755@dragon>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yptlk7dor5hap4t3"
Content-Disposition: inline
In-Reply-To: <20231012004356.GR819755@dragon>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--yptlk7dor5hap4t3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 12.10.2023 08:43:56, Shawn Guo wrote:
> On Thu, Oct 12, 2023 at 10:14:34AM +1100, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > Today's linux-next merge of the imx-mxs tree got a conflict in:
> >=20
> >   arch/arm64/boot/dts/freescale/imx93.dtsi
> >=20
> > between commit:
> >=20
> >   23ed2be5404d ("arm64: dts: imx93: add the Flex-CAN stop mode by GPR")
>=20
> Marc,
>=20
> Is there any particular reason why this dts change needs to go via net
> tree?  Otherwise, could you drop it from net and let it go via i.MX tree?

As far as I understand the problem, the imx93 A0 silicon was supposed to
have a functional auto-stop mode for the flexcan peripheral. But wakeup
stress tests show that it doesn't work reliable. So this and the
following patch switched the imx93 back to the "old" stop-mode via GPR,
which needs a DT update.

| 23ed2be5404d ("arm64: dts: imx93: add the Flex-CAN stop mode by GPR")
| 63ead535570f ("can: flexcan: remove the auto stop mode for IMX93")

See the description of 63ead535570f for more details.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--yptlk7dor5hap4t3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmUnoCsACgkQvlAcSiqK
BOhqxAf/TR6JyrXcR2gU8M5fJLeDnX0Zlc2BMNkHrzylitpeLN9peBKaPdK4WLo/
9EfPAWZn08z3d41N9mKFRwHTc5K/d9dz/eqYMqkiXHm6zIKjSRLASNQWdlhO29Uy
CUTiz3GTK3DbQOzkVASfNpmaH/CTb42Nf66lfbRD85J4fPRKjoDiJhkDRGJlLheO
5Bhky1pm5l8oNZaFfcH6LMeC75Qk+3Z1FW4Pbta5xsDE8b1LpgoaPuLvkK+BTDcD
mdenpyH4XM/zx4nVZvaOLaL9DSY0lVOVWKVQtUbmRtcWOGclccU835SJo8oGWqmZ
wq5I5ErI1HHytNZvt7FzLpDr2TE10Q==
=Ylvq
-----END PGP SIGNATURE-----

--yptlk7dor5hap4t3--


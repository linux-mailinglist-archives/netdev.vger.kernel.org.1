Return-Path: <netdev+bounces-18210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAF7755CF6
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988102812DB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAAB8C0B;
	Mon, 17 Jul 2023 07:33:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C11FD9
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:33:18 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F25185
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:33:17 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qLIjB-0004At-1q; Mon, 17 Jul 2023 09:33:05 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 00E1F1F30CF;
	Mon, 17 Jul 2023 07:33:03 +0000 (UTC)
Date: Mon, 17 Jul 2023 09:33:03 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: yunchuan <yunchuan@nfschina.com>
Cc: wg@grandegger.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, uttenthaler@ems-wuensche.com,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3 8/9] can: ems_pci: Remove unnecessary (void*)
 conversions
Message-ID: <20230717-overeater-handlebar-377cac2af8ec-mkl@pengutronix.de>
References: <20230717-clash-kerchief-afdf910e2ce6-mkl@pengutronix.de>
 <f1e0ecfd-b9b3-2c4b-f548-c08f7615febe@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zynuj47hijq7ykbd"
Content-Disposition: inline
In-Reply-To: <f1e0ecfd-b9b3-2c4b-f548-c08f7615febe@nfschina.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--zynuj47hijq7ykbd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.07.2023 15:30:33, yunchuan wrote:
>=20
> On 2023/7/17 15:07, Marc Kleine-Budde wrote:
> > On 17.07.2023 08:52:42, Marc Kleine-Budde wrote:
> > > On 17.07.2023 11:12:21, Wu Yunchuan wrote:
> > > > No need cast (void*) to (struct ems_pci_card *).
> > > >=20
> > > > Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
> > > > Acked-by: Marc Kleine-Budde<mkl@pengutronix.de>
> > > Please add a space between my name and my e-mail address, so that it
> > > reads:
> > >=20
> > > Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > >=20
> > > nitpick:
> > > You should add your S-o-b as the last trailer.
> > BTW: The threading of this series is still broken. Make sure you send
> > the whole patch series with one single "git send-email" command. For
> > regular contribution you might have a look at the "b4" [1] tool.
>=20
> Hi,
>=20
> Thanks for you suggestions, I use 'git send-email' to send patch.
> I messing up the patch's order in different patchset. This might be the
> reason of the broken threading.
> Really sorry for this, I will take careful next time.

You should send _all_ 9 patches in the series with a _single_ "git
send-email" command. There's no risk to mess up the order.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--zynuj47hijq7ykbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmS07qwACgkQvlAcSiqK
BOgY1Qf/aiTDvlMlmCoRBIxvvrjt5KXRR9nKC9GZ+Xuj/iWW7RVne75zO2X7G1mW
xJEqOd65wTD6KkhFyPFuErTWScLKclXlmRL3cxEgE2228fTrv4XiNwUtKoO5f2R/
t4OAtJ8npU6J6D3BKzejj7fxAG2B/jgGIlTRx3YkhCmw5rCsz+GTmslj4PnJbIpa
+Kj1k2JcMd89YLdCSz3gbBdoPcf8vSBBqikZVyNnGmFJpAxMXwuSgO01V4UpjGvc
tnFr90AXmk24bmt+0kGETA6dkKQ4jAEoSG6cWqERas6JlNdTQjUhaC6nOv6NWFiW
doKFgls3KzLsBNznpJtbXgEsbdjZVQ==
=CQEc
-----END PGP SIGNATURE-----

--zynuj47hijq7ykbd--


Return-Path: <netdev+bounces-34902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEDB7A5C9D
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52EB2820BF
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3941F30F9B;
	Tue, 19 Sep 2023 08:33:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA1D79CD
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 08:33:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF5E114
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 01:33:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiWAm-0000XS-Op; Tue, 19 Sep 2023 10:33:32 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiWAl-007PcR-GU; Tue, 19 Sep 2023 10:33:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiWAl-002wA9-6Z; Tue, 19 Sep 2023 10:33:31 +0200
Date: Tue, 19 Sep 2023 10:33:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Katakam, Harini" <harini.katakam@amd.com>,
	Rob Herring <robh@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alex Elder <elder@linaro.org>, Simon Horman <horms@kernel.org>,
	Wei Fang <wei.fang@nxp.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	huangjunxian <huangjunxian6@hisilicon.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 53/54] net: ethernet: xilinx: Convert to
 platform remove callback returning void
Message-ID: <20230919083329.yqkpu55go5oiy4cq@pengutronix.de>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-54-u.kleine-koenig@pengutronix.de>
 <MN0PR12MB5953B8AD645AA87FF2672200B7FAA@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d4jzrwhtb5l66amb"
Content-Disposition: inline
In-Reply-To: <MN0PR12MB5953B8AD645AA87FF2672200B7FAA@MN0PR12MB5953.namprd12.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--d4jzrwhtb5l66amb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Bhupesh Sharma from the list of recipents, usage of their email
address resulted in a bounce.]

On Tue, Sep 19, 2023 at 04:45:04AM +0000, Pandey, Radhey Shyam wrote:
> > -----Original Message-----
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > Sent: Tuesday, September 19, 2023 2:12 AM
> > To: David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>
> > Cc: Simek, Michal <michal.simek@amd.com>; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Katakam, Harini
> > <harini.katakam@amd.com>; Haoyue Xu <xuhaoyue1@hisilicon.com>;
> > huangjunxian <huangjunxian6@hisilicon.com>; Rob Herring
> > <robh@kernel.org>; Yang Yingliang <yangyingliang@huawei.com>; Dan
> > Carpenter <dan.carpenter@linaro.org>; Bhupesh Sharma
> > <bhupesh.sharma@linaro.org>; Simon Horman <horms@kernel.org>; Alex
> > Elder <elder@linaro.org>; Wei Fang <wei.fang@nxp.com>;
> > netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > kernel@pengutronix.de
> > Subject: [PATCH net-next 53/54] net: ethernet: xilinx: Convert to platf=
orm
> > remove callback returning void
> >=20
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code. However the value returned is ignored (apart
> > from emitting a warning) and this typically results in resource leaks.
> > To improve here there is a quest to make the remove callback return
> > void. In the first step of this quest all drivers are converted to
> > .remove_new() which already returns void. Eventually after all drivers
> > are converted, .remove_new() is renamed to .remove().
> >=20
> > Trivially convert these drivers from always returning zero in the remove
> > callback to the void returning variant.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/net/ethernet/xilinx/ll_temac_main.c       | 5 ++---
> >  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++----
> >  drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 6 ++----
> >  3 files changed, 6 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c
> > b/drivers/net/ethernet/xilinx/ll_temac_main.c
> > index 1444b855e7aa..9df39cf8b097 100644
> > --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> > +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> > @@ -1626,7 +1626,7 @@ static int temac_probe(struct platform_device
> > *pdev)
> >  	return rc;
> >  }
> >=20
> > -static int temac_remove(struct platform_device *pdev)
> > +static void temac_remove(struct platform_device *pdev)
> >  {
> >  	struct net_device *ndev =3D platform_get_drvdata(pdev);
> >  	struct temac_local *lp =3D netdev_priv(ndev);
> > @@ -1636,7 +1636,6 @@ static int temac_remove(struct platform_device
> > *pdev)
> >  	if (lp->phy_node)
> >  		of_node_put(lp->phy_node);
> >  	temac_mdio_teardown(lp);
> > -	return 0;
> >  }
> >=20
> >  static const struct of_device_id temac_of_match[] =3D {
> > @@ -1650,7 +1649,7 @@ MODULE_DEVICE_TABLE(of, temac_of_match);
> >=20
> >  static struct platform_driver temac_driver =3D {
> >  	.probe =3D temac_probe,
> > -	.remove =3D temac_remove,
> > +	.remove_new =3D temac_remove,
> >  	.driver =3D {
> >  		.name =3D "xilinx_temac",
> >  		.of_match_table =3D temac_of_match,
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > index b7ec4dafae90..82d0d44b2b02 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > @@ -2183,7 +2183,7 @@ static int axienet_probe(struct platform_device
> > *pdev)
> >  	return ret;
> >  }
> >=20
> > -static int axienet_remove(struct platform_device *pdev)
> > +static void axienet_remove(struct platform_device *pdev)
> >  {
> >  	struct net_device *ndev =3D platform_get_drvdata(pdev);
> >  	struct axienet_local *lp =3D netdev_priv(ndev);
> > @@ -2202,8 +2202,6 @@ static int axienet_remove(struct platform_device
> > *pdev)
> >  	clk_disable_unprepare(lp->axi_clk);
> >=20
> >  	free_netdev(ndev);
> > -
> > -	return 0;
> >  }
> >=20
> >  static void axienet_shutdown(struct platform_device *pdev)
> > @@ -2256,7 +2254,7 @@ static
> > DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
> >=20
> >  static struct platform_driver axienet_driver =3D {
> >  	.probe =3D axienet_probe,
> > -	.remove =3D axienet_remove,
> > +	.remove_new =3D axienet_remove,
> >  	.shutdown =3D axienet_shutdown,
> >  	.driver =3D {
> >  		 .name =3D "xilinx_axienet",
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > index b358ecc67227..32a502e7318b 100644
> > --- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > +++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> > @@ -1183,7 +1183,7 @@ static int xemaclite_of_probe(struct
> > platform_device *ofdev)
> >   *
> >   * Return:	0, always.
> >   */
>=20
> Nit - kernel-doc return documentation needs to be updated.

Indeed, I fixed that in my tree and so it will be addressed if and when
I resend this patch.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d4jzrwhtb5l66amb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUJXNgACgkQj4D7WH0S
/k6A5wgAj3GRdATh3FcFiAR9NtnJmRh3dptVgEqYTBS6wu5P9X6gV4j1oJED6gmD
rCPRoM846Jjv83D/AMsVBewxZhZBDj4+4K+eyl9oxyffMJMvDxWRn0Z4CYLTRlLa
DdMrqVY40zD7iKyvJu22B0k7Hcd9sFrpoW0UxkpLOfQDxv/JJUD8TpkTIa2Ov9nr
ofW1ijpYI8McMgtQ8MbnsFIs5el/F52jccAR4i/pLIi7NCzgjyD7nBB9zFlD/aTZ
Uf6kh3o/69MoYaHNz9+/Eta0DFDTU9BIb9Gi6zrkbyaag0LAo1r/HjXGu0WI+Q7x
IVRB/ZR+bNlEOIUGcgcHFskZcsRRcA==
=EfLJ
-----END PGP SIGNATURE-----

--d4jzrwhtb5l66amb--


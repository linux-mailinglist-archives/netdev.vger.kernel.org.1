Return-Path: <netdev+bounces-34793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 889C57A54B1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0D71C2119B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB3535880;
	Mon, 18 Sep 2023 20:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E5B34CDC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F0510A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-0007Kt-TS; Mon, 18 Sep 2023 22:42:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-007Ik7-Gr; Mon, 18 Sep 2023 22:42:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-002mpr-6a; Mon, 18 Sep 2023 22:42:45 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Simon Horman <horms@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Michael Walle <michael@walle.cc>,
	Rob Herring <robh@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 41/54] net: ethernet: renesas: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:13 +0200
Message-Id: <20230918204227.1316886-42-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4110; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UZ/GH9I7NOHymPHSgmmDrUE8MFloR4laWwGVFqvoPd0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSObUJ7diVoyDac3N3zrvxX5Wzr+1F7PzUoCc6JfGb8X EOo4/ieTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmsoCX/Z/WZbdOto5Lb5ZE 7nQom6fkuZLzg1X0y68Ok77WME1y1s/R1Lo3R+ZTA4dTsV/M792/PO3v9y5e3rtFsKqj6dnjXg6 m9EoXcY55vN1P5xT+itNiUbxU7XFscf6cGoMJ16wb6z/fbrH9yMNxbO/cDzJzv2Wp2CpNip00dV aovzRfqp2N/+I3fo6HuB1e/j/7p3RSunGoTk7gndqfc/1VAg5XK7Fd6/a9n/DTNb7y+unzj62SF 37+KH6u4kNKckKfM+s17woZjUqWiOQb/d0b3wtMyck7VWPDPy/macXPsIPb154sDt8XnB9Sd9nf PVks7WtuTyxH/Lw51XnKH41eGj6wyTW/mCU1O0i2ae5hAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.
To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new() which already returns void. Eventually after all drivers
are converted, .remove_new() is renamed to .remove().

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 ++----
 drivers/net/ethernet/renesas/rswitch.c   | 6 ++----
 drivers/net/ethernet/renesas/sh_eth.c    | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7df9f9f8e134..e62391180032 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2878,7 +2878,7 @@ static int ravb_probe(struct platform_device *pdev)
 	return error;
 }
 
-static int ravb_remove(struct platform_device *pdev)
+static void ravb_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2905,8 +2905,6 @@ static int ravb_remove(struct platform_device *pdev)
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static int ravb_wol_setup(struct net_device *ndev)
@@ -3044,7 +3042,7 @@ static const struct dev_pm_ops ravb_dev_pm_ops = {
 
 static struct platform_driver ravb_driver = {
 	.probe		= ravb_probe,
-	.remove		= ravb_remove,
+	.remove_new	= ravb_remove,
 	.driver = {
 		.name	= "ravb",
 		.pm	= &ravb_dev_pm_ops,
diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index ea9186178091..3c165b15709f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1968,7 +1968,7 @@ static void rswitch_deinit(struct rswitch_private *priv)
 	rswitch_clock_disable(priv);
 }
 
-static int renesas_eth_sw_remove(struct platform_device *pdev)
+static void renesas_eth_sw_remove(struct platform_device *pdev)
 {
 	struct rswitch_private *priv = platform_get_drvdata(pdev);
 
@@ -1978,13 +1978,11 @@ static int renesas_eth_sw_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver renesas_eth_sw_driver_platform = {
 	.probe = renesas_eth_sw_probe,
-	.remove = renesas_eth_sw_remove,
+	.remove_new = renesas_eth_sw_remove,
 	.driver = {
 		.name = "renesas_eth_sw",
 		.of_match_table = renesas_eth_sw_of_table,
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 274ea16c0a1f..475e1e8c1d35 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3431,7 +3431,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sh_eth_drv_remove(struct platform_device *pdev)
+static void sh_eth_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct sh_eth_private *mdp = netdev_priv(ndev);
@@ -3441,8 +3441,6 @@ static int sh_eth_drv_remove(struct platform_device *pdev)
 	sh_mdio_release(mdp);
 	pm_runtime_disable(&pdev->dev);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -3562,7 +3560,7 @@ MODULE_DEVICE_TABLE(platform, sh_eth_id_table);
 
 static struct platform_driver sh_eth_driver = {
 	.probe = sh_eth_drv_probe,
-	.remove = sh_eth_drv_remove,
+	.remove_new = sh_eth_drv_remove,
 	.id_table = sh_eth_id_table,
 	.driver = {
 		   .name = CARDNAME,
-- 
2.40.1



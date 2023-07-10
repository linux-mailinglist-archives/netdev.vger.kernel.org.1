Return-Path: <netdev+bounces-16357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F410774CE1B
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 09:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB231C20930
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D375388;
	Mon, 10 Jul 2023 07:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A1DD2E0
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 07:20:13 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCF29D
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 00:20:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBX-0008Ds-UG; Mon, 10 Jul 2023 09:19:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBW-00DMeL-6C; Mon, 10 Jul 2023 09:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qIlBV-003jm3-C2; Mon, 10 Jul 2023 09:19:49 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Rob Herring <robh@kernel.org>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v3 3/8] net: fec: Convert to platform remove callback returning void
Date: Mon, 10 Jul 2023 09:19:41 +0200
Message-Id: <20230710071946.3470249-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710071946.3470249-1-u.kleine-koenig@pengutronix.de>
References: <20230710071946.3470249-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4084; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hh8Hlfk7jR3Ldh2PazFHhhi38UfBmSNstUFCLcbVpOY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkq7EIsq1wJs5mXulQ9EpiIsx30xXKH0IDHnMfi 2OwJI8n87iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZKuxCAAKCRCPgPtYfRL+ TviwB/9DsTFJSfudSBNeBQJEr8cPUSHXz7/aws3UKvikcpAJu0TOo3GMYUFfzb/LBezzg5EVIZh OktOE7lvYjDvzHXHf9lXTXABoWkzZvQagXrXArsEZITHVNIbxDyF20wtsYcNmpYynw9ri5KViql WxxOwEQUgQO+rnIFWZ/gFxXSsjchYHINUJAtconha8EBdNJvL/ZKdpQz4UcOXBTlRZF++OedCT+ b3Xpiw918a0/jBmVHiZzFlYryBDksBaMnK1nGHzNfljwOHRQHLOnd6sXIhClHv9Y3dH32fUdOqH /izZcOOLhV7FmGRnxUTBqBAL18h7G8Elv7kjiTUiaXmmS2Fd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c        | 5 ++---
 drivers/net/ethernet/freescale/fec_mpc52xx.c     | 6 ++----
 drivers/net/ethernet/freescale/fec_mpc52xx_phy.c | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8fbe47703d47..1280da699fa3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4458,7 +4458,7 @@ fec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int
+static void
 fec_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
@@ -4494,7 +4494,6 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 
 	free_netdev(ndev);
-	return 0;
 }
 
 static int __maybe_unused fec_suspend(struct device *dev)
@@ -4650,7 +4649,7 @@ static struct platform_driver fec_driver = {
 	},
 	.id_table = fec_devtype,
 	.probe	= fec_probe,
-	.remove	= fec_drv_remove,
+	.remove_new = fec_drv_remove,
 };
 
 module_platform_driver(fec_driver);
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx.c b/drivers/net/ethernet/freescale/fec_mpc52xx.c
index b88816b71ddf..984ece5cd64f 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx.c
@@ -974,7 +974,7 @@ static int mpc52xx_fec_probe(struct platform_device *op)
 	return rv;
 }
 
-static int
+static void
 mpc52xx_fec_remove(struct platform_device *op)
 {
 	struct net_device *ndev;
@@ -998,8 +998,6 @@ mpc52xx_fec_remove(struct platform_device *op)
 	release_mem_region(ndev->base_addr, sizeof(struct mpc52xx_fec));
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1042,7 +1040,7 @@ static struct platform_driver mpc52xx_fec_driver = {
 		.of_match_table = mpc52xx_fec_match,
 	},
 	.probe		= mpc52xx_fec_probe,
-	.remove		= mpc52xx_fec_remove,
+	.remove_new	= mpc52xx_fec_remove,
 #ifdef CONFIG_PM
 	.suspend	= mpc52xx_fec_of_suspend,
 	.resume		= mpc52xx_fec_of_resume,
diff --git a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
index 95f778cce98c..61d3776d6750 100644
--- a/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
+++ b/drivers/net/ethernet/freescale/fec_mpc52xx_phy.c
@@ -117,7 +117,7 @@ static int mpc52xx_fec_mdio_probe(struct platform_device *of)
 	return err;
 }
 
-static int mpc52xx_fec_mdio_remove(struct platform_device *of)
+static void mpc52xx_fec_mdio_remove(struct platform_device *of)
 {
 	struct mii_bus *bus = platform_get_drvdata(of);
 	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
@@ -126,8 +126,6 @@ static int mpc52xx_fec_mdio_remove(struct platform_device *of)
 	iounmap(priv->regs);
 	kfree(priv);
 	mdiobus_free(bus);
-
-	return 0;
 }
 
 static const struct of_device_id mpc52xx_fec_mdio_match[] = {
@@ -145,7 +143,7 @@ struct platform_driver mpc52xx_fec_mdio_driver = {
 		.of_match_table = mpc52xx_fec_mdio_match,
 	},
 	.probe = mpc52xx_fec_mdio_probe,
-	.remove = mpc52xx_fec_mdio_remove,
+	.remove_new = mpc52xx_fec_mdio_remove,
 };
 
 /* let fec driver call it, since this has to be registered before it */
-- 
2.39.2



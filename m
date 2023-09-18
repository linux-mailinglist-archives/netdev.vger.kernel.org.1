Return-Path: <netdev+bounces-34792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2427A54B0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C03D1C20FE0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ABA34CF7;
	Mon, 18 Sep 2023 20:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310934CC7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E052B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-00075v-L3; Mon, 18 Sep 2023 22:42:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-007Iit-2V; Mon, 18 Sep 2023 22:42:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-002mod-PW; Mon, 18 Sep 2023 22:42:39 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 22/54] net: ethernet: hisilicon: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:54 +0200
Message-Id: <20230918204227.1316886-23-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7864; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xAEFQJ5Rp0392MDhw7UzOmHiidzVh5j99GZh9WGK96I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX9Curt7DOEjveMEnCdkiyHO0HKOVHCINmFH p/wBe+P5o6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi1/QAKCRCPgPtYfRL+ ThNMCACw/840LdjHhOb0f3UTQhae+Wxcmet5NmWb2C/BZ14mP5+RDW9eKZHDnVDZTDM8d/C6S5n j7j3bKAJ3wIK0vS3YfVFvr0e04M74x3r9oQ6ka4axzoBk3dWbfAkxxZKkO8B1PaZJ/fyrVim8hR 1OwdolJvSQ33dHh9mFUzzkl3HZYsDlMc3aoFUdUblhgZ+Bayu+818tBZebPOZj2gYiZ/KB71VNk 4OcL335Mem2DmqDBne2NpxczgNoihomRmF5eFPwQpbKK0SPu0eeDnWY3ivnTqfD1uU+q4Mp+2Ob /FPbytp5qTOKu5/aC6YWJIhEpO8gj3C2QtoO6K8FTgBt59Wm
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
 drivers/net/ethernet/hisilicon/hip04_eth.c         | 6 ++----
 drivers/net/ethernet/hisilicon/hisi_femac.c        | 6 ++----
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      | 6 ++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 6 ++----
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 5 ++---
 drivers/net/ethernet/hisilicon/hns_mdio.c          | 5 ++---
 6 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index ecf92a5d56bb..b91e7a06b97f 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -1021,7 +1021,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hip04_remove(struct platform_device *pdev)
+static void hip04_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hip04_priv *priv = netdev_priv(ndev);
@@ -1035,8 +1035,6 @@ static int hip04_remove(struct platform_device *pdev)
 	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id hip04_mac_match[] = {
@@ -1048,7 +1046,7 @@ MODULE_DEVICE_TABLE(of, hip04_mac_match);
 
 static struct platform_driver hip04_mac_driver = {
 	.probe	= hip04_mac_probe,
-	.remove	= hip04_remove,
+	.remove_new = hip04_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= hip04_mac_match,
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index cb7b0293fe85..2406263c9dd3 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -893,7 +893,7 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_femac_drv_remove(struct platform_device *pdev)
+static void hisi_femac_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hisi_femac_priv *priv = netdev_priv(ndev);
@@ -904,8 +904,6 @@ static int hisi_femac_drv_remove(struct platform_device *pdev)
 	phy_disconnect(ndev->phydev);
 	clk_disable_unprepare(priv->clk);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -961,7 +959,7 @@ static struct platform_driver hisi_femac_driver = {
 		.of_match_table = hisi_femac_match,
 	},
 	.probe = hisi_femac_drv_probe,
-	.remove = hisi_femac_drv_remove,
+	.remove_new = hisi_femac_drv_remove,
 #ifdef CONFIG_PM
 	.suspend = hisi_femac_drv_suspend,
 	.resume = hisi_femac_drv_resume,
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index 26d22bb04b87..506fa3d8bbee 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1282,7 +1282,7 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hix5hd2_dev_remove(struct platform_device *pdev)
+static void hix5hd2_dev_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hix5hd2_priv *priv = netdev_priv(ndev);
@@ -1298,8 +1298,6 @@ static int hix5hd2_dev_remove(struct platform_device *pdev)
 	of_node_put(priv->phy_node);
 	cancel_work_sync(&priv->tx_timeout_task);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id hix5hd2_of_match[] = {
@@ -1319,7 +1317,7 @@ static struct platform_driver hix5hd2_dev_driver = {
 		.of_match_table = hix5hd2_of_match,
 	},
 	.probe = hix5hd2_dev_probe,
-	.remove = hix5hd2_dev_remove,
+	.remove_new = hix5hd2_dev_remove,
 };
 
 module_platform_driver(hix5hd2_dev_driver);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index fcaf5132b865..1b67da1f6fa8 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -3007,7 +3007,7 @@ static int hns_dsaf_probe(struct platform_device *pdev)
  * hns_dsaf_remove - remove dsaf dev
  * @pdev: dasf platform device
  */
-static int hns_dsaf_remove(struct platform_device *pdev)
+static void hns_dsaf_remove(struct platform_device *pdev)
 {
 	struct dsaf_device *dsaf_dev = dev_get_drvdata(&pdev->dev);
 
@@ -3020,8 +3020,6 @@ static int hns_dsaf_remove(struct platform_device *pdev)
 	hns_dsaf_free(dsaf_dev);
 
 	hns_dsaf_free_dev(dsaf_dev);
-
-	return 0;
 }
 
 static const struct of_device_id g_dsaf_match[] = {
@@ -3033,7 +3031,7 @@ MODULE_DEVICE_TABLE(of, g_dsaf_match);
 
 static struct platform_driver g_dsaf_driver = {
 	.probe = hns_dsaf_probe,
-	.remove = hns_dsaf_remove,
+	.remove_new = hns_dsaf_remove,
 	.driver = {
 		.name = DSAF_DRV_NAME,
 		.of_match_table = g_dsaf_match,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 7cf10d1e2b31..0900abf5c508 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2384,7 +2384,7 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hns_nic_dev_remove(struct platform_device *pdev)
+static void hns_nic_dev_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct hns_nic_priv *priv = netdev_priv(ndev);
@@ -2413,7 +2413,6 @@ static int hns_nic_dev_remove(struct platform_device *pdev)
 	of_node_put(to_of_node(priv->fwnode));
 
 	free_netdev(ndev);
-	return 0;
 }
 
 static const struct of_device_id hns_enet_of_match[] = {
@@ -2431,7 +2430,7 @@ static struct platform_driver hns_nic_dev_driver = {
 		.acpi_match_table = ACPI_PTR(hns_enet_acpi_match),
 	},
 	.probe = hns_nic_dev_probe,
-	.remove = hns_nic_dev_remove,
+	.remove_new = hns_nic_dev_remove,
 };
 
 module_platform_driver(hns_nic_dev_driver);
diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index 409a89d80220..ed73707176c1 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -610,7 +610,7 @@ static int hns_mdio_probe(struct platform_device *pdev)
  *
  * Return 0 on success, negative on failure
  */
-static int hns_mdio_remove(struct platform_device *pdev)
+static void hns_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus;
 
@@ -618,7 +618,6 @@ static int hns_mdio_remove(struct platform_device *pdev)
 
 	mdiobus_unregister(bus);
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 static const struct of_device_id hns_mdio_match[] = {
@@ -636,7 +635,7 @@ MODULE_DEVICE_TABLE(acpi, hns_mdio_acpi_match);
 
 static struct platform_driver hns_mdio_driver = {
 	.probe = hns_mdio_probe,
-	.remove = hns_mdio_remove,
+	.remove_new = hns_mdio_remove,
 	.driver = {
 		   .name = MDIO_DRV_NAME,
 		   .of_match_table = hns_mdio_match,
-- 
2.40.1



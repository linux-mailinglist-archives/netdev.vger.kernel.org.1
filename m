Return-Path: <netdev+bounces-34782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F557A548B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C042281DD1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A92AB53;
	Mon, 18 Sep 2023 20:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ED231A70
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45625128
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-0006lZ-RA; Mon, 18 Sep 2023 22:42:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-007IiC-9c; Mon, 18 Sep 2023 22:42:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-002mnu-Vp; Mon, 18 Sep 2023 22:42:37 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Li Zetao <lizetao1@huawei.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 11/54] net: ethernet: broadcom: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:43 +0200
Message-Id: <20230918204227.1316886-12-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9047; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0b/bLQyi0ZuLTgRYlpYsCi95TPyjphFZP+nNG0ND+3o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXxr0dMUK6xU5P5sxsohVBZXONcuOxeIkSEx 9E8rliVFiuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi18QAKCRCPgPtYfRL+ To/yB/0UjXx3S3OCLJliL5iR7WXxpUDWMYy+IQ6Msp/TGnNk3KF4CsjW8Fo7TByiCPHZQHe1Xna qjo2gi88OPBfiEntv+1ciZ5TzSpHnJrKqGY6ITOc7TCvE/bOgPYS6ElZ4eSXKTH9ZNpltGdyvCe eM75k4ODKKxM79Oh8NHXTvoFitRCSkSt1zI02aNelExO/xxjfh9wytmqPNB4x2sOPHHsVMhP4wm BYw6LDSgF3I09lxunISMaPrKFLEEoZJq7SPIPICRoExu4XmMUNmIVdW7HxbLPbpAnx36T63z6yd fqfkmZtZRBROxPLsDBABjoMja9O+KFXNNPeg3Z26QK9X2tGk
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
 drivers/net/ethernet/broadcom/asp2/bcmasp.c    |  8 +++-----
 drivers/net/ethernet/broadcom/bcm4908_enet.c   |  6 ++----
 drivers/net/ethernet/broadcom/bcm63xx_enet.c   | 10 ++++------
 drivers/net/ethernet/broadcom/bcmsysport.c     |  6 ++----
 drivers/net/ethernet/broadcom/bgmac-platform.c |  6 ++----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |  6 ++----
 drivers/net/ethernet/broadcom/sb1250-mac.c     |  6 ++----
 7 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 41a6098eb0c2..29b04a274d07 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1344,17 +1344,15 @@ static int bcmasp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcmasp_remove(struct platform_device *pdev)
+static void bcmasp_remove(struct platform_device *pdev)
 {
 	struct bcmasp_priv *priv = dev_get_drvdata(&pdev->dev);
 
 	if (!priv)
-		return 0;
+		return;
 
 	priv->destroy_wol(priv);
 	bcmasp_remove_intfs(priv);
-
-	return 0;
 }
 
 static void bcmasp_shutdown(struct platform_device *pdev)
@@ -1428,7 +1426,7 @@ static SIMPLE_DEV_PM_OPS(bcmasp_pm_ops,
 
 static struct platform_driver bcmasp_driver = {
 	.probe = bcmasp_probe,
-	.remove = bcmasp_remove,
+	.remove_new = bcmasp_remove,
 	.shutdown = bcmasp_shutdown,
 	.driver = {
 		.name = "brcm,asp-v2",
diff --git a/drivers/net/ethernet/broadcom/bcm4908_enet.c b/drivers/net/ethernet/broadcom/bcm4908_enet.c
index 33d86683af50..3e7c8671cd11 100644
--- a/drivers/net/ethernet/broadcom/bcm4908_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm4908_enet.c
@@ -768,7 +768,7 @@ static int bcm4908_enet_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcm4908_enet_remove(struct platform_device *pdev)
+static void bcm4908_enet_remove(struct platform_device *pdev)
 {
 	struct bcm4908_enet *enet = platform_get_drvdata(pdev);
 
@@ -776,8 +776,6 @@ static int bcm4908_enet_remove(struct platform_device *pdev)
 	netif_napi_del(&enet->rx_ring.napi);
 	netif_napi_del(&enet->tx_ring.napi);
 	bcm4908_enet_dma_free(enet);
-
-	return 0;
 }
 
 static const struct of_device_id bcm4908_enet_of_match[] = {
@@ -791,7 +789,7 @@ static struct platform_driver bcm4908_enet_driver = {
 		.of_match_table = bcm4908_enet_of_match,
 	},
 	.probe	= bcm4908_enet_probe,
-	.remove = bcm4908_enet_remove,
+	.remove_new = bcm4908_enet_remove,
 };
 module_platform_driver(bcm4908_enet_driver);
 
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index a741070f1f9a..105afde5dbe1 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1902,7 +1902,7 @@ static int bcm_enet_probe(struct platform_device *pdev)
 /*
  * exit func, stops hardware and unregisters netdevice
  */
-static int bcm_enet_remove(struct platform_device *pdev)
+static void bcm_enet_remove(struct platform_device *pdev)
 {
 	struct bcm_enet_priv *priv;
 	struct net_device *dev;
@@ -1932,12 +1932,11 @@ static int bcm_enet_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->mac_clk);
 
 	free_netdev(dev);
-	return 0;
 }
 
 static struct platform_driver bcm63xx_enet_driver = {
 	.probe	= bcm_enet_probe,
-	.remove	= bcm_enet_remove,
+	.remove_new = bcm_enet_remove,
 	.driver	= {
 		.name	= "bcm63xx_enet",
 	},
@@ -2739,7 +2738,7 @@ static int bcm_enetsw_probe(struct platform_device *pdev)
 
 
 /* exit func, stops hardware and unregisters netdevice */
-static int bcm_enetsw_remove(struct platform_device *pdev)
+static void bcm_enetsw_remove(struct platform_device *pdev)
 {
 	struct bcm_enet_priv *priv;
 	struct net_device *dev;
@@ -2752,12 +2751,11 @@ static int bcm_enetsw_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->mac_clk);
 
 	free_netdev(dev);
-	return 0;
 }
 
 static struct platform_driver bcm63xx_enetsw_driver = {
 	.probe	= bcm_enetsw_probe,
-	.remove	= bcm_enetsw_remove,
+	.remove_new = bcm_enetsw_remove,
 	.driver	= {
 		.name	= "bcm63xx_enetsw",
 	},
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index bf1611cce974..ab096795e805 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2648,7 +2648,7 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm_sysport_remove(struct platform_device *pdev)
+static void bcm_sysport_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = dev_get_drvdata(&pdev->dev);
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
@@ -2663,8 +2663,6 @@ static int bcm_sysport_remove(struct platform_device *pdev)
 		of_phy_deregister_fixed_link(dn);
 	free_netdev(dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-
-	return 0;
 }
 
 static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
@@ -2901,7 +2899,7 @@ static SIMPLE_DEV_PM_OPS(bcm_sysport_pm_ops,
 
 static struct platform_driver bcm_sysport_driver = {
 	.probe	= bcm_sysport_probe,
-	.remove	= bcm_sysport_remove,
+	.remove_new = bcm_sysport_remove,
 	.driver =  {
 		.name = "brcm-systemport",
 		.of_match_table = bcm_sysport_of_match,
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index b4381cd41979..0b21fd5bd457 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -246,13 +246,11 @@ static int bgmac_probe(struct platform_device *pdev)
 	return bgmac_enet_probe(bgmac);
 }
 
-static int bgmac_remove(struct platform_device *pdev)
+static void bgmac_remove(struct platform_device *pdev)
 {
 	struct bgmac *bgmac = platform_get_drvdata(pdev);
 
 	bgmac_enet_remove(bgmac);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -296,7 +294,7 @@ static struct platform_driver bgmac_enet_driver = {
 		.pm = BGMAC_PM_OPS
 	},
 	.probe = bgmac_probe,
-	.remove = bgmac_remove,
+	.remove_new = bgmac_remove,
 };
 
 module_platform_driver(bgmac_enet_driver);
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 24bade875ca6..91f3a7e78d65 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4164,7 +4164,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int bcmgenet_remove(struct platform_device *pdev)
+static void bcmgenet_remove(struct platform_device *pdev)
 {
 	struct bcmgenet_priv *priv = dev_to_priv(&pdev->dev);
 
@@ -4172,8 +4172,6 @@ static int bcmgenet_remove(struct platform_device *pdev)
 	unregister_netdev(priv->dev);
 	bcmgenet_mii_exit(priv->dev);
 	free_netdev(priv->dev);
-
-	return 0;
 }
 
 static void bcmgenet_shutdown(struct platform_device *pdev)
@@ -4352,7 +4350,7 @@ MODULE_DEVICE_TABLE(acpi, genet_acpi_match);
 
 static struct platform_driver bcmgenet_driver = {
 	.probe	= bcmgenet_probe,
-	.remove	= bcmgenet_remove,
+	.remove_new = bcmgenet_remove,
 	.shutdown = bcmgenet_shutdown,
 	.driver	= {
 		.name	= "bcmgenet",
diff --git a/drivers/net/ethernet/broadcom/sb1250-mac.c b/drivers/net/ethernet/broadcom/sb1250-mac.c
index 3a6763c5e8b3..fcf8485f3446 100644
--- a/drivers/net/ethernet/broadcom/sb1250-mac.c
+++ b/drivers/net/ethernet/broadcom/sb1250-mac.c
@@ -2593,7 +2593,7 @@ static int sbmac_probe(struct platform_device *pldev)
 	return err;
 }
 
-static int sbmac_remove(struct platform_device *pldev)
+static void sbmac_remove(struct platform_device *pldev)
 {
 	struct net_device *dev = platform_get_drvdata(pldev);
 	struct sbmac_softc *sc = netdev_priv(dev);
@@ -2604,13 +2604,11 @@ static int sbmac_remove(struct platform_device *pldev)
 	mdiobus_free(sc->mii_bus);
 	iounmap(sc->sbm_base);
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver sbmac_driver = {
 	.probe = sbmac_probe,
-	.remove = sbmac_remove,
+	.remove_new = sbmac_remove,
 	.driver = {
 		.name = sbmac_string,
 	},
-- 
2.40.1



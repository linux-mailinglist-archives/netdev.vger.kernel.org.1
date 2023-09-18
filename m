Return-Path: <netdev+bounces-34789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A0A7A54AC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567371C2123C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90534CD3;
	Mon, 18 Sep 2023 20:43:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5340341AE
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6F810D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-0007E7-De; Mon, 18 Sep 2023 22:42:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-007IjJ-Rs; Mon, 18 Sep 2023 22:42:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-002mp5-I9; Mon, 18 Sep 2023 22:42:41 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Russell King <linux@armlinux.org.uk>,
	Michael Walle <michael@walle.cc>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 29/54] net: ethernet: marvell: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:01 +0200
Message-Id: <20230918204227.1316886-30-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8764; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q8Pe096OSKOuwHd5mASVjnErAsVt6HcjFx+m3MCjddE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYFYPkmYDP/od59jAt/SigemaPz4qukWb8jh tSyllkJBrOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2BQAKCRCPgPtYfRL+ TovJCACyMU972gHmiedPG8NBcCuTCUAlfqaBquka6aKTrnsz3kh+IY7svd/U7mERiPx63embXvj JPa1s1MmMknyy7SITYPNxDbjdJN7R9JutARXkis0tl8SPiwooo9Gy/REk88qAR6da2YtVMOx6LR bTcNJHcZ+OEU3cn4jj9ziRbhKu4DFAieZOjmde1WS2BPd9vj2YiSBvPIIb+QVaW0651lXTWC16g 2bqf7yb2ooqbcW3o+a/6V884kT9aN7RKHq9Y9756W45x0+3UsjXKmYzIm7Up4SG01x+BrWeLeFo 7l/b+upKeAZsEfMvQC+Cy6/Z9TjbPiicuHt2lbTiwqazB9Pc
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
 drivers/net/ethernet/marvell/mv643xx_eth.c      | 11 ++++-------
 drivers/net/ethernet/marvell/mvmdio.c           |  6 ++----
 drivers/net/ethernet/marvell/mvneta.c           |  6 ++----
 drivers/net/ethernet/marvell/mvneta_bm.c        |  6 ++----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |  8 +++-----
 drivers/net/ethernet/marvell/pxa168_eth.c       |  5 ++---
 6 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 3b129a1c3381..f0bdc06d253d 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2892,19 +2892,18 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mv643xx_eth_shared_remove(struct platform_device *pdev)
+static void mv643xx_eth_shared_remove(struct platform_device *pdev)
 {
 	struct mv643xx_eth_shared_private *msp = platform_get_drvdata(pdev);
 
 	mv643xx_eth_shared_of_remove();
 	if (!IS_ERR(msp->clk))
 		clk_disable_unprepare(msp->clk);
-	return 0;
 }
 
 static struct platform_driver mv643xx_eth_shared_driver = {
 	.probe		= mv643xx_eth_shared_probe,
-	.remove		= mv643xx_eth_shared_remove,
+	.remove_new	= mv643xx_eth_shared_remove,
 	.driver = {
 		.name	= MV643XX_ETH_SHARED_NAME,
 		.of_match_table = of_match_ptr(mv643xx_eth_shared_ids),
@@ -3279,7 +3278,7 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mv643xx_eth_remove(struct platform_device *pdev)
+static void mv643xx_eth_remove(struct platform_device *pdev)
 {
 	struct mv643xx_eth_private *mp = platform_get_drvdata(pdev);
 	struct net_device *dev = mp->dev;
@@ -3293,8 +3292,6 @@ static int mv643xx_eth_remove(struct platform_device *pdev)
 		clk_disable_unprepare(mp->clk);
 
 	free_netdev(mp->dev);
-
-	return 0;
 }
 
 static void mv643xx_eth_shutdown(struct platform_device *pdev)
@@ -3311,7 +3308,7 @@ static void mv643xx_eth_shutdown(struct platform_device *pdev)
 
 static struct platform_driver mv643xx_eth_driver = {
 	.probe		= mv643xx_eth_probe,
-	.remove		= mv643xx_eth_remove,
+	.remove_new	= mv643xx_eth_remove,
 	.shutdown	= mv643xx_eth_shutdown,
 	.driver = {
 		.name	= MV643XX_ETH_NAME,
diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 674913184ebf..89f26402f8fb 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -388,7 +388,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int orion_mdio_remove(struct platform_device *pdev)
+static void orion_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct orion_mdio_dev *dev = bus->priv;
@@ -404,8 +404,6 @@ static int orion_mdio_remove(struct platform_device *pdev)
 		clk_disable_unprepare(dev->clk[i]);
 		clk_put(dev->clk[i]);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id orion_mdio_match[] = {
@@ -426,7 +424,7 @@ MODULE_DEVICE_TABLE(acpi, orion_mdio_acpi_match);
 
 static struct platform_driver orion_mdio_driver = {
 	.probe = orion_mdio_probe,
-	.remove = orion_mdio_remove,
+	.remove_new = orion_mdio_remove,
 	.driver = {
 		.name = "orion-mdio",
 		.of_match_table = orion_mdio_match,
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index d483b8c00ec0..61a430e5bc91 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -5725,7 +5725,7 @@ static int mvneta_probe(struct platform_device *pdev)
 }
 
 /* Device removal routine */
-static int mvneta_remove(struct platform_device *pdev)
+static void mvneta_remove(struct platform_device *pdev)
 {
 	struct net_device  *dev = platform_get_drvdata(pdev);
 	struct mvneta_port *pp = netdev_priv(dev);
@@ -5744,8 +5744,6 @@ static int mvneta_remove(struct platform_device *pdev)
 				       1 << pp->id);
 		mvneta_bm_put(pp->bm_priv);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -5871,7 +5869,7 @@ MODULE_DEVICE_TABLE(of, mvneta_match);
 
 static struct platform_driver mvneta_driver = {
 	.probe = mvneta_probe,
-	.remove = mvneta_remove,
+	.remove_new = mvneta_remove,
 	.driver = {
 		.name = MVNETA_DRIVER_NAME,
 		.of_match_table = mvneta_match,
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.c b/drivers/net/ethernet/marvell/mvneta_bm.c
index 46c942ef2287..3f46a0fed048 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.c
+++ b/drivers/net/ethernet/marvell/mvneta_bm.c
@@ -457,7 +457,7 @@ static int mvneta_bm_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mvneta_bm_remove(struct platform_device *pdev)
+static void mvneta_bm_remove(struct platform_device *pdev)
 {
 	struct mvneta_bm *priv = platform_get_drvdata(pdev);
 	u8 all_ports_map = 0xff;
@@ -475,8 +475,6 @@ static int mvneta_bm_remove(struct platform_device *pdev)
 	mvneta_bm_write(priv, MVNETA_BM_COMMAND_REG, MVNETA_BM_STOP_MASK);
 
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static const struct of_device_id mvneta_bm_match[] = {
@@ -487,7 +485,7 @@ MODULE_DEVICE_TABLE(of, mvneta_bm_match);
 
 static struct platform_driver mvneta_bm_driver = {
 	.probe = mvneta_bm_probe,
-	.remove = mvneta_bm_remove,
+	.remove_new = mvneta_bm_remove,
 	.driver = {
 		.name = MVNETA_BM_DRIVER_NAME,
 		.of_match_table = mvneta_bm_match,
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 21c3f9b015c8..463e89d3f17a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -7662,7 +7662,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mvpp2_remove(struct platform_device *pdev)
+static void mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
 	struct fwnode_handle *fwnode = pdev->dev.fwnode;
@@ -7700,15 +7700,13 @@ static int mvpp2_remove(struct platform_device *pdev)
 	}
 
 	if (is_acpi_node(port_fwnode))
-		return 0;
+		return;
 
 	clk_disable_unprepare(priv->axi_clk);
 	clk_disable_unprepare(priv->mg_core_clk);
 	clk_disable_unprepare(priv->mg_clk);
 	clk_disable_unprepare(priv->pp_clk);
 	clk_disable_unprepare(priv->gop_clk);
-
-	return 0;
 }
 
 static const struct of_device_id mvpp2_match[] = {
@@ -7734,7 +7732,7 @@ MODULE_DEVICE_TABLE(acpi, mvpp2_acpi_match);
 
 static struct platform_driver mvpp2_driver = {
 	.probe = mvpp2_probe,
-	.remove = mvpp2_remove,
+	.remove_new = mvpp2_remove,
 	.driver = {
 		.name = MVPP2_DRIVER_NAME,
 		.of_match_table = mvpp2_match,
diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
index d5691b6a2bc5..dd6ca2e4fd51 100644
--- a/drivers/net/ethernet/marvell/pxa168_eth.c
+++ b/drivers/net/ethernet/marvell/pxa168_eth.c
@@ -1528,7 +1528,7 @@ static int pxa168_eth_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int pxa168_eth_remove(struct platform_device *pdev)
+static void pxa168_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct pxa168_eth_private *pep = netdev_priv(dev);
@@ -1547,7 +1547,6 @@ static int pxa168_eth_remove(struct platform_device *pdev)
 	mdiobus_free(pep->smi_bus);
 	unregister_netdev(dev);
 	free_netdev(dev);
-	return 0;
 }
 
 static void pxa168_eth_shutdown(struct platform_device *pdev)
@@ -1580,7 +1579,7 @@ MODULE_DEVICE_TABLE(of, pxa168_eth_of_match);
 
 static struct platform_driver pxa168_eth_driver = {
 	.probe = pxa168_eth_probe,
-	.remove = pxa168_eth_remove,
+	.remove_new = pxa168_eth_remove,
 	.shutdown = pxa168_eth_shutdown,
 	.resume = pxa168_eth_resume,
 	.suspend = pxa168_eth_suspend,
-- 
2.40.1



Return-Path: <netdev+bounces-34795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6C7A54B7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C853A2823C0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBEC3589B;
	Mon, 18 Sep 2023 20:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A434CEB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA3114
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-0007TN-C4; Mon, 18 Sep 2023 22:42:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-007Ikd-Lh; Mon, 18 Sep 2023 22:42:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-002mqN-B3; Mon, 18 Sep 2023 22:42:47 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nathan Huckleberry <nhuck@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next 49/54] net: ethernet: ti: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:21 +0200
Message-Id: <20230918204227.1316886-50-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5112; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GAzMPmTXiHRYGL72nZp+bTQHer1MdGrU4/9n6vQGbZE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYbKcwv4juvlGF2GyxUT/eBKwQwSyvbq2/GL QtGUYa2R9GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2GwAKCRCPgPtYfRL+ ThBqB/0QH054ARQK0eHP4ODSndxB3JFel3Ybp97YrfdkNGp4IMU5XaW5dHQLtvLou2PfI2bGp07 oQVblhLa+cb79spIxftIXiqSKicm+zcliwW9cr6sZa5wYnVlPCj28prPcJs8d0wn6Q/J0VSVXFO B0RBY3vtt9aeK5yFdKJGt7Ka0SPBNJsKq5Rs9jRzZABH3UM3F1NoAAR4LE0/j4wQCDIMB8erkxG l/UNVpxjmo3zGYnavkPUO2ai6KDVb+bmtwk8jMA53w83jZp7hw5m7bSZOiK0ogWcEhpyJkiN7FI RvfeyQq7v4scquY3H4ikvZDR0/9+w1iAlHDCyuJCxPDxLQyv
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
 drivers/net/ethernet/ti/cpmac.c        | 6 ++----
 drivers/net/ethernet/ti/davinci_emac.c | 6 ++----
 drivers/net/ethernet/ti/davinci_mdio.c | 6 ++----
 drivers/net/ethernet/ti/netcp_core.c   | 5 ++---
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpmac.c b/drivers/net/ethernet/ti/cpmac.c
index 80eeeb463c4f..bc9b5d18427d 100644
--- a/drivers/net/ethernet/ti/cpmac.c
+++ b/drivers/net/ethernet/ti/cpmac.c
@@ -1151,14 +1151,12 @@ static int cpmac_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int cpmac_remove(struct platform_device *pdev)
+static void cpmac_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_netdev(dev);
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver cpmac_driver = {
@@ -1166,7 +1164,7 @@ static struct platform_driver cpmac_driver = {
 		.name 	= "cpmac",
 	},
 	.probe 	= cpmac_probe,
-	.remove = cpmac_remove,
+	.remove_new = cpmac_remove,
 };
 
 int __init cpmac_init(void)
diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index 2eb9d5a32588..5d756df133eb 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -2002,7 +2002,7 @@ static int davinci_emac_probe(struct platform_device *pdev)
  * Called when removing the device driver. We disable clock usage and release
  * the resources taken up by the driver and unregister network device
  */
-static int davinci_emac_remove(struct platform_device *pdev)
+static void davinci_emac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct emac_priv *priv = netdev_priv(ndev);
@@ -2022,8 +2022,6 @@ static int davinci_emac_remove(struct platform_device *pdev)
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static int davinci_emac_suspend(struct device *dev)
@@ -2076,7 +2074,7 @@ static struct platform_driver davinci_emac_driver = {
 		.of_match_table = davinci_emac_of_match,
 	},
 	.probe = davinci_emac_probe,
-	.remove = davinci_emac_remove,
+	.remove_new = davinci_emac_remove,
 };
 
 /**
diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 89b6d23e9937..628c87dc1d28 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -673,7 +673,7 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int davinci_mdio_remove(struct platform_device *pdev)
+static void davinci_mdio_remove(struct platform_device *pdev)
 {
 	struct davinci_mdio_data *data = platform_get_drvdata(pdev);
 
@@ -686,8 +686,6 @@ static int davinci_mdio_remove(struct platform_device *pdev)
 
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -766,7 +764,7 @@ static struct platform_driver davinci_mdio_driver = {
 		.of_match_table = of_match_ptr(davinci_mdio_of_mtable),
 	},
 	.probe = davinci_mdio_probe,
-	.remove = davinci_mdio_remove,
+	.remove_new = davinci_mdio_remove,
 };
 
 static int __init davinci_mdio_init(void)
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index d829113c16ee..11b90e1da0c6 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2228,7 +2228,7 @@ static int netcp_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int netcp_remove(struct platform_device *pdev)
+static void netcp_remove(struct platform_device *pdev)
 {
 	struct netcp_device *netcp_device = platform_get_drvdata(pdev);
 	struct netcp_intf *netcp_intf, *netcp_tmp;
@@ -2256,7 +2256,6 @@ static int netcp_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
-	return 0;
 }
 
 static const struct of_device_id of_match[] = {
@@ -2271,7 +2270,7 @@ static struct platform_driver netcp_driver = {
 		.of_match_table	= of_match,
 	},
 	.probe = netcp_probe,
-	.remove = netcp_remove,
+	.remove_new = netcp_remove,
 };
 module_platform_driver(netcp_driver);
 
-- 
2.40.1



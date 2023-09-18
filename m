Return-Path: <netdev+bounces-34799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E47A54BC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054B02823FA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60F727EDA;
	Mon, 18 Sep 2023 20:43:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC2450DD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1782A119
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4z-0007cX-Qk; Mon, 18 Sep 2023 22:42:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-007Ikw-UQ; Mon, 18 Sep 2023 22:42:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-002mqd-J1; Mon, 18 Sep 2023 22:42:48 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Haoyue Xu <xuhaoyue1@hisilicon.com>,
	huangjunxian <huangjunxian6@hisilicon.com>,
	Rob Herring <robh@kernel.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 53/54] net: ethernet: xilinx: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:25 +0200
Message-Id: <20230918204227.1316886-54-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=91YEtCx6j0vCh9tGyZFZdjRlApPiV7S6jjfIf0Z10Uw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYfXgSmky1FCO04dDgwYth40/AQbLNSYvWXg v6od6aEqnKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2HwAKCRCPgPtYfRL+ ThfQCACGzlav7rGekDQl7fbJ2ChP8zA3gdjRbb2n9iFZu183C/QcgXINjjgogDPuGyzccA48QSd 6chnWDerHobm9JWZRcBTFOR6ewimFR3GZHayAjtsR7+6KHZUgqiFkvAflzhwA8MVEtfjyZ8Zmgp 1rfDd3muwtiMzTa8HN8K9EB/gh5rH7Mi0sUbiggfEwUED9uT8y2wTELwAzf25to/bFRe6uA41lR tpySUNAeknxiCOfSmuXBRrl5c8nKojY92bv0wtYfpPP55qBPr5zsaIzhD3HS8KDPKRnl2n7xKUR k8UUr+eCpoySeGPqn/F9aJJF5SchhB0LXywVlJjvp1Quho8k
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
 drivers/net/ethernet/xilinx/ll_temac_main.c       | 5 ++---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++----
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 1444b855e7aa..9df39cf8b097 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -1626,7 +1626,7 @@ static int temac_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int temac_remove(struct platform_device *pdev)
+static void temac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct temac_local *lp = netdev_priv(ndev);
@@ -1636,7 +1636,6 @@ static int temac_remove(struct platform_device *pdev)
 	if (lp->phy_node)
 		of_node_put(lp->phy_node);
 	temac_mdio_teardown(lp);
-	return 0;
 }
 
 static const struct of_device_id temac_of_match[] = {
@@ -1650,7 +1649,7 @@ MODULE_DEVICE_TABLE(of, temac_of_match);
 
 static struct platform_driver temac_driver = {
 	.probe = temac_probe,
-	.remove = temac_remove,
+	.remove_new = temac_remove,
 	.driver = {
 		.name = "xilinx_temac",
 		.of_match_table = temac_of_match,
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index b7ec4dafae90..82d0d44b2b02 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2183,7 +2183,7 @@ static int axienet_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int axienet_remove(struct platform_device *pdev)
+static void axienet_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct axienet_local *lp = netdev_priv(ndev);
@@ -2202,8 +2202,6 @@ static int axienet_remove(struct platform_device *pdev)
 	clk_disable_unprepare(lp->axi_clk);
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static void axienet_shutdown(struct platform_device *pdev)
@@ -2256,7 +2254,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(axienet_pm_ops,
 
 static struct platform_driver axienet_driver = {
 	.probe = axienet_probe,
-	.remove = axienet_remove,
+	.remove_new = axienet_remove,
 	.shutdown = axienet_shutdown,
 	.driver = {
 		 .name = "xilinx_axienet",
diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index b358ecc67227..32a502e7318b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1183,7 +1183,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
  *
  * Return:	0, always.
  */
-static int xemaclite_of_remove(struct platform_device *of_dev)
+static void xemaclite_of_remove(struct platform_device *of_dev)
 {
 	struct net_device *ndev = platform_get_drvdata(of_dev);
 
@@ -1202,8 +1202,6 @@ static int xemaclite_of_remove(struct platform_device *of_dev)
 	lp->phy_node = NULL;
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
@@ -1262,7 +1260,7 @@ static struct platform_driver xemaclite_of_driver = {
 		.of_match_table = xemaclite_of_match,
 	},
 	.probe		= xemaclite_of_probe,
-	.remove		= xemaclite_of_remove,
+	.remove_new	= xemaclite_of_remove,
 };
 
 module_platform_driver(xemaclite_of_driver);
-- 
2.40.1



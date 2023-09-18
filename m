Return-Path: <netdev+bounces-34774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D37A547D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5057F1C20B3E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8D31A6E;
	Mon, 18 Sep 2023 20:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7932AB53
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B781D126
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006iq-SZ; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-007Ihq-VN; Mon, 18 Sep 2023 22:42:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-002mna-LV; Mon, 18 Sep 2023 22:42:35 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 06/54] net: ethernet: amd: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:38 +0200
Message-Id: <20230918204227.1316886-7-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3988; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jaKN1H9c3VRFaKrvVCIJNZtutA638xkBm56+c151qCc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXrvFRFjPiG2eOzL+pbA6fm1PyM2y6DFiKOe dGEEupglBuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi16wAKCRCPgPtYfRL+ TpCeB/4jQKIA2M6GHo6S3cSBoaBtpWHn7Kf8dxwjKdSXOi1LEoeXEGYbciv9aUdkLZ7aMP1wEFi tfnhy9RK4m5XKs5EEsBPoUU3GAgNR9wjN5xLv67yNEUi+H1vigfJIQ3epk/FG3REQnJG+8Y4in5 B9xar0fS3keLOOr39wSlR6VJyxt5Bnaegg+uMpXa/gR/vNSPg8PONK/sisF3WGBT8tKK50RYdar XZ7D1R7mgDrrPZNGN6Mt5sWQe+wJWyGxh71mzC8RP1lbFTDke25fE2oAem2yg3SOh33duCoXW4o iI1L1LsCJl+3xAQc0LgXsGalkzWW9mcqv3jjxIjMH8COEcTM
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
 drivers/net/ethernet/amd/au1000_eth.c         | 6 ++----
 drivers/net/ethernet/amd/sunlance.c           | 6 ++----
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 6 ++----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index c5cec4e79489..85c978149bf6 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1323,7 +1323,7 @@ static int au1000_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int au1000_remove(struct platform_device *pdev)
+static void au1000_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct au1000_private *aup = netdev_priv(dev);
@@ -1359,13 +1359,11 @@ static int au1000_remove(struct platform_device *pdev)
 	release_mem_region(macen->start, resource_size(macen));
 
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver au1000_eth_driver = {
 	.probe  = au1000_probe,
-	.remove = au1000_remove,
+	.remove_new = au1000_remove,
 	.driver = {
 		.name   = "au1000-eth",
 	},
diff --git a/drivers/net/ethernet/amd/sunlance.c b/drivers/net/ethernet/amd/sunlance.c
index 33bb539ad70a..c78706d21a6a 100644
--- a/drivers/net/ethernet/amd/sunlance.c
+++ b/drivers/net/ethernet/amd/sunlance.c
@@ -1487,7 +1487,7 @@ static int sunlance_sbus_probe(struct platform_device *op)
 	return err;
 }
 
-static int sunlance_sbus_remove(struct platform_device *op)
+static void sunlance_sbus_remove(struct platform_device *op)
 {
 	struct lance_private *lp = platform_get_drvdata(op);
 	struct net_device *net_dev = lp->dev;
@@ -1497,8 +1497,6 @@ static int sunlance_sbus_remove(struct platform_device *op)
 	lance_free_hwresources(lp);
 
 	free_netdev(net_dev);
-
-	return 0;
 }
 
 static const struct of_device_id sunlance_sbus_match[] = {
@@ -1516,7 +1514,7 @@ static struct platform_driver sunlance_sbus_driver = {
 		.of_match_table = sunlance_sbus_match,
 	},
 	.probe		= sunlance_sbus_probe,
-	.remove		= sunlance_sbus_remove,
+	.remove_new	= sunlance_sbus_remove,
 };
 
 module_platform_driver(sunlance_sbus_driver);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index 4d790a89fe77..91842a5e161b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -512,7 +512,7 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int xgbe_platform_remove(struct platform_device *pdev)
+static void xgbe_platform_remove(struct platform_device *pdev)
 {
 	struct xgbe_prv_data *pdata = platform_get_drvdata(pdev);
 
@@ -521,8 +521,6 @@ static int xgbe_platform_remove(struct platform_device *pdev)
 	platform_device_put(pdata->phy_platdev);
 
 	xgbe_free_pdata(pdata);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -615,7 +613,7 @@ static struct platform_driver xgbe_driver = {
 		.pm = &xgbe_platform_pm_ops,
 	},
 	.probe = xgbe_platform_probe,
-	.remove = xgbe_platform_remove,
+	.remove_new = xgbe_platform_remove,
 };
 
 int xgbe_platform_init(void)
-- 
2.40.1



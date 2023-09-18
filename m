Return-Path: <netdev+bounces-34794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C907A54B6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5824128214A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B73588A;
	Mon, 18 Sep 2023 20:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAB34CC0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:05 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221811A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-0006sF-10; Mon, 18 Sep 2023 22:42:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-007IiS-DJ; Mon, 18 Sep 2023 22:42:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-002moB-1q; Mon, 18 Sep 2023 22:42:38 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>,
	Simon Horman <horms@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 15/54] net: ethernet: cirrus: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:47 +0200
Message-Id: <20230918204227.1316886-16-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4098; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LYjDPCWY0oSq/+crF0XhbbuypyZxlnxb7qCBTtMXfqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX1fBhTnHmhp2JaT8a0JQ5c7fTdswVjeifho H5DKhZQ8+aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi19QAKCRCPgPtYfRL+ Tg/SCACgHqOZ0VEbCuIXqAwkBHRANyVi7WzET+qJsXc0BIC6OfPC5/kJUxhW58EVeSrQ5a3M1go j3xN6AD7C8swgwLtLNEAbgciin3o/CGDBafMVbtrZ2zuDc4Gr+eMpuWcdPPsNcCilOIU2OR09ma PHdaBfrJ43fVx3sl0ke0kkDbKJaocYVCK2jxP+0RAf4yH3064ApGmGmIRLjTNijzxTc+3KNSuEv Fv1Gw31qNR47iLxyLMrq0sfpSibeYnE5z8Tq1f/32eI6bQe3s3PqEojIsRfHqzjn071D9QWWSCv v8o2G9Uv9R0zwOFou9/lRd1s3x9q7OGmSAHocnoK+TguXFSK
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
 drivers/net/ethernet/cirrus/cs89x0.c     | 5 ++---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 8 +++-----
 drivers/net/ethernet/cirrus/mac89x0.c    | 5 ++---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index d323c5c23521..0a21a10a791c 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -1879,7 +1879,7 @@ static int __init cs89x0_platform_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int cs89x0_platform_remove(struct platform_device *pdev)
+static void cs89x0_platform_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
@@ -1889,7 +1889,6 @@ static int cs89x0_platform_remove(struct platform_device *pdev)
 	 */
 	unregister_netdev(dev);
 	free_netdev(dev);
-	return 0;
 }
 
 static const struct of_device_id __maybe_unused cs89x0_match[] = {
@@ -1904,7 +1903,7 @@ static struct platform_driver cs89x0_driver = {
 		.name		= DRV_NAME,
 		.of_match_table	= of_match_ptr(cs89x0_match),
 	},
-	.remove	= cs89x0_platform_remove,
+	.remove_new = cs89x0_platform_remove,
 };
 
 module_platform_driver_probe(cs89x0_driver, cs89x0_platform_probe);
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 8627ab19d470..1c2a540db13d 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -757,7 +757,7 @@ static struct net_device *ep93xx_dev_alloc(struct ep93xx_eth_data *data)
 }
 
 
-static int ep93xx_eth_remove(struct platform_device *pdev)
+static void ep93xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ep93xx_priv *ep;
@@ -765,7 +765,7 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
 
 	dev = platform_get_drvdata(pdev);
 	if (dev == NULL)
-		return 0;
+		return;
 
 	ep = netdev_priv(dev);
 
@@ -782,8 +782,6 @@ static int ep93xx_eth_remove(struct platform_device *pdev)
 	}
 
 	free_netdev(dev);
-
-	return 0;
 }
 
 static int ep93xx_eth_probe(struct platform_device *pdev)
@@ -862,7 +860,7 @@ static int ep93xx_eth_probe(struct platform_device *pdev)
 
 static struct platform_driver ep93xx_eth_driver = {
 	.probe		= ep93xx_eth_probe,
-	.remove		= ep93xx_eth_remove,
+	.remove_new	= ep93xx_eth_remove,
 	.driver		= {
 		.name	= "ep93xx-eth",
 	},
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 21a70b1f0ac5..887876f35f10 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -556,19 +556,18 @@ static int set_mac_address(struct net_device *dev, void *addr)
 
 MODULE_LICENSE("GPL");
 
-static int mac89x0_device_remove(struct platform_device *pdev)
+static void mac89x0_device_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
 	unregister_netdev(dev);
 	nubus_writew(0, dev->base_addr + ADD_PORT);
 	free_netdev(dev);
-	return 0;
 }
 
 static struct platform_driver mac89x0_platform_driver = {
 	.probe = mac89x0_device_probe,
-	.remove = mac89x0_device_remove,
+	.remove_new = mac89x0_device_remove,
 	.driver = {
 		.name = "mac89x0",
 	},
-- 
2.40.1



Return-Path: <netdev+bounces-34756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41A87A5455
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BFF281312
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F09128DB0;
	Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799127EDC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186D10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-0007Hx-4S; Mon, 18 Sep 2023 22:42:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-007Ijk-Og; Mon, 18 Sep 2023 22:42:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-002mpW-ES; Mon, 18 Sep 2023 22:42:43 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 36/54] net: ethernet: natsemi: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:08 +0200
Message-Id: <20230918204227.1316886-37-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6ut+ktGhprMg3ZA7qKOu98KV3jC7LLvQZXddHHVD/RI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYMJdMMqoYv6IZKA09L3FHlMQInBYS1Cb6a1 eBWdTrBclWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2DAAKCRCPgPtYfRL+ TtveB/9aeqcXKv52xoy3Q/7JaiLRff6bIUFaYsGtSLVkS1tG+ld02ZHYPhHjH4eWUpZUYXS3g+t 4MgoQLGI/U30q3hpQkKXbU3RPnsxTwyHHRxK5yaLup/ZZ0f8+riK+QDI9FrxElRSTcgC1aIQtzO nfX8wap3FhDdzUcE3FcykuKl3Rxpx35wZjqaEedZvzJCDjuvOGHdmYtUE0aHzCCVQVWogEykRf7 TdjV48NoTIEQ+X24YoeGgHWvMfcKyCyTEO4IXOy9e7Tx0UodRhd49PmSp4FZhtrFOASFZej7/lS /UoC1uznYnPSO/DALbQNjn4eILSRwFDhie6UOywmmGDjdgLP
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
 drivers/net/ethernet/natsemi/jazzsonic.c | 6 ++----
 drivers/net/ethernet/natsemi/macsonic.c  | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/natsemi/jazzsonic.c b/drivers/net/ethernet/natsemi/jazzsonic.c
index 3f371faeb6d0..2b6e097df28f 100644
--- a/drivers/net/ethernet/natsemi/jazzsonic.c
+++ b/drivers/net/ethernet/natsemi/jazzsonic.c
@@ -227,7 +227,7 @@ MODULE_ALIAS("platform:jazzsonic");
 
 #include "sonic.c"
 
-static int jazz_sonic_device_remove(struct platform_device *pdev)
+static void jazz_sonic_device_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sonic_local* lp = netdev_priv(dev);
@@ -237,13 +237,11 @@ static int jazz_sonic_device_remove(struct platform_device *pdev)
 	                  lp->descriptors, lp->descriptors_laddr);
 	release_mem_region(dev->base_addr, SONIC_MEM_SIZE);
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver jazz_sonic_driver = {
 	.probe	= jazz_sonic_probe,
-	.remove	= jazz_sonic_device_remove,
+	.remove_new = jazz_sonic_device_remove,
 	.driver	= {
 		.name	= jazz_sonic_string,
 	},
diff --git a/drivers/net/ethernet/natsemi/macsonic.c b/drivers/net/ethernet/natsemi/macsonic.c
index b16f7c830f9b..2fc63860dbdb 100644
--- a/drivers/net/ethernet/natsemi/macsonic.c
+++ b/drivers/net/ethernet/natsemi/macsonic.c
@@ -532,7 +532,7 @@ MODULE_ALIAS("platform:macsonic");
 
 #include "sonic.c"
 
-static int mac_sonic_platform_remove(struct platform_device *pdev)
+static void mac_sonic_platform_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct sonic_local* lp = netdev_priv(dev);
@@ -541,13 +541,11 @@ static int mac_sonic_platform_remove(struct platform_device *pdev)
 	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
 	                  lp->descriptors, lp->descriptors_laddr);
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver mac_sonic_platform_driver = {
 	.probe  = mac_sonic_platform_probe,
-	.remove = mac_sonic_platform_remove,
+	.remove_new = mac_sonic_platform_remove,
 	.driver = {
 		.name = "macsonic",
 	},
-- 
2.40.1



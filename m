Return-Path: <netdev+bounces-34773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D797A547C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32865281A75
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2ED31A64;
	Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE21266CF
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191F310A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4z-0007an-A4; Mon, 18 Sep 2023 22:42:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-007Iks-J6; Mon, 18 Sep 2023 22:42:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-002mqZ-8t; Mon, 18 Sep 2023 22:42:48 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 52/54] net: ethernet: wiznet: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:24 +0200
Message-Id: <20230918204227.1316886-53-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2697; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ko163uYmBqtg7pPQVxbxv5fbIvhDYVf4MVzWT+KrosM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYesTJe2fue8+KWI133ZzFFuyuUnWoV62I1S fIts5PTB82JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2HgAKCRCPgPtYfRL+ TgWzB/9sbd1a4XCiywY2/s5V3us74rMX45qe14AvLdb7iSYBxaRuSeedwB91g5Ij5Bv7DYwFeW9 AEeoBf0TWnwMhbaBQFe13Q0Z+hR2odvdnsfwIzDEshLaI+PNbG6k5MU8w047yIzCz7QcHXhaUQj 7TP2Ug9hjgz5FarOFZT9Ta85nPiSbsXX+xwlyOFC8Acj3Co+ZAZwhmNWAB5CEBLzLXf6nATTbfZ Z5UcLy2wiLcFCpIotwK7zvQ5CluoVeGKSes895ATg6ANF/kvtaGcs3AQiHTC7jU9dyA7JiA76Mn NsiW3MjgQYFiFyDiWgigLLIsOzyhvLgbEe2VwMhFF77ttXFK
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
 drivers/net/ethernet/wiznet/w5100.c | 6 ++----
 drivers/net/ethernet/wiznet/w5300.c | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/wiznet/w5100.c b/drivers/net/ethernet/wiznet/w5100.c
index 634946e87e5f..341ee2f249fd 100644
--- a/drivers/net/ethernet/wiznet/w5100.c
+++ b/drivers/net/ethernet/wiznet/w5100.c
@@ -1062,11 +1062,9 @@ static int w5100_mmio_probe(struct platform_device *pdev)
 			   mac_addr, irq, data ? data->link_gpio : -EINVAL);
 }
 
-static int w5100_mmio_remove(struct platform_device *pdev)
+static void w5100_mmio_remove(struct platform_device *pdev)
 {
 	w5100_remove(&pdev->dev);
-
-	return 0;
 }
 
 void *w5100_ops_priv(const struct net_device *ndev)
@@ -1273,6 +1271,6 @@ static struct platform_driver w5100_mmio_driver = {
 		.pm	= &w5100_pm_ops,
 	},
 	.probe		= w5100_mmio_probe,
-	.remove		= w5100_mmio_remove,
+	.remove_new	= w5100_mmio_remove,
 };
 module_platform_driver(w5100_mmio_driver);
diff --git a/drivers/net/ethernet/wiznet/w5300.c b/drivers/net/ethernet/wiznet/w5300.c
index b0958fe8111e..3318b50a5911 100644
--- a/drivers/net/ethernet/wiznet/w5300.c
+++ b/drivers/net/ethernet/wiznet/w5300.c
@@ -627,7 +627,7 @@ static int w5300_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int w5300_remove(struct platform_device *pdev)
+static void w5300_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct w5300_priv *priv = netdev_priv(ndev);
@@ -639,7 +639,6 @@ static int w5300_remove(struct platform_device *pdev)
 
 	unregister_netdev(ndev);
 	free_netdev(ndev);
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -683,7 +682,7 @@ static struct platform_driver w5300_driver = {
 		.pm	= &w5300_pm_ops,
 	},
 	.probe		= w5300_probe,
-	.remove		= w5300_remove,
+	.remove_new	= w5300_remove,
 };
 
 module_platform_driver(w5300_driver);
-- 
2.40.1



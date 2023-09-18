Return-Path: <netdev+bounces-34758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E2D7A5456
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8692812F6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04BB28DC4;
	Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6CA2375B
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC126120
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-0007Gd-U0; Mon, 18 Sep 2023 22:42:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-007IjV-MD; Mon, 18 Sep 2023 22:42:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-002mpH-Ck; Mon, 18 Sep 2023 22:42:42 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 32/54] net: ethernet: micrel: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:04 +0200
Message-Id: <20230918204227.1316886-33-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2812; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yzXfpsJihNVhjFjIM0ZY5bQqNvzB0NKEVfvzo5gDk9g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYIS5GB4juT+etHuSteyb6k+BFmWYZT0krJJ HjPBBmcRyGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2CAAKCRCPgPtYfRL+ TqrjB/wPqvvAfP1lGdvngwOmZB3N5x4UAaGpLqk7U9LsOyziiAvwq8JwQANqgRt+i7+Hs0y1ylL K6LIHSL1MeH+1eyQSo6H+v38uHhLlkn1LpSHvcZrdQruqvdzTBaSmGyaHAiOKkQ82CM8J6x06Xt AWHmUsgD6CKicBHGsbS8z8QjwNWCQZpLA10F5kTKxZXoJnIYTaGTATqd6zmokvTo93irBRa6dHG Sj+0cF6fJ2oAzm9ySVeNUvnzuXzr+sVcZDRgGnsBcVgbt2N6lme/m5GOByWhdZfc31XUz6OQ5J2 bBoB8vjchNLB5ep9mLKzYfd61TTuO14VVDExC+44Ofmu86aZ
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
 drivers/net/ethernet/micrel/ks8842.c     | 5 ++---
 drivers/net/ethernet/micrel/ks8851_par.c | 6 ++----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index c11b118dc415..ddd87ef71caf 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -1228,7 +1228,7 @@ static int ks8842_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ks8842_remove(struct platform_device *pdev)
+static void ks8842_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct ks8842_adapter *adapter = netdev_priv(netdev);
@@ -1239,7 +1239,6 @@ static int ks8842_remove(struct platform_device *pdev)
 	iounmap(adapter->hw_addr);
 	free_netdev(netdev);
 	release_mem_region(iomem->start, resource_size(iomem));
-	return 0;
 }
 
 
@@ -1248,7 +1247,7 @@ static struct platform_driver ks8842_platform_driver = {
 		.name	= DRV_NAME,
 	},
 	.probe		= ks8842_probe,
-	.remove		= ks8842_remove,
+	.remove_new	= ks8842_remove,
 };
 
 module_platform_driver(ks8842_platform_driver);
diff --git a/drivers/net/ethernet/micrel/ks8851_par.c b/drivers/net/ethernet/micrel/ks8851_par.c
index 7f49042484bd..2a7f29854267 100644
--- a/drivers/net/ethernet/micrel/ks8851_par.c
+++ b/drivers/net/ethernet/micrel/ks8851_par.c
@@ -327,11 +327,9 @@ static int ks8851_probe_par(struct platform_device *pdev)
 	return ks8851_probe_common(netdev, dev, msg_enable);
 }
 
-static int ks8851_remove_par(struct platform_device *pdev)
+static void ks8851_remove_par(struct platform_device *pdev)
 {
 	ks8851_remove_common(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id ks8851_match_table[] = {
@@ -347,7 +345,7 @@ static struct platform_driver ks8851_driver = {
 		.pm = &ks8851_pm_ops,
 	},
 	.probe = ks8851_probe_par,
-	.remove = ks8851_remove_par,
+	.remove_new = ks8851_remove_par,
 };
 module_platform_driver(ks8851_driver);
 
-- 
2.40.1



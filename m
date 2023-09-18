Return-Path: <netdev+bounces-34761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE57A545C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACCA1C20952
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114328E15;
	Mon, 18 Sep 2023 20:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A5828DAC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF711A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006iW-MQ; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4k-007IhZ-Nz; Mon, 18 Sep 2023 22:42:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4k-002mnG-Ca; Mon, 18 Sep 2023 22:42:34 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 01/54] net: ethernet: 8390: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:33 +0200
Message-Id: <20230918204227.1316886-2-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3854; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VeJmdir1aQxXCGD4iZ2AzzTxSW+CmmqArO9SXnbSthU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXmb+PEpaAQqjSlZSBtfy49szpQfpi5EkhOy hvAPlQPAeCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi15gAKCRCPgPtYfRL+ TkU5B/9EVO2PCu35jSvWUeA+VAT56n66dVjZJEy8s9E1wHTga2gqEwfpKb+aTunAYXXuPXgLFdw u1p7kMluoA6YVlW2nOzBT+AscET9jgJSmWxkz3v10jJcNG/FLY+V+RwhyOlNqwYZEny3q2lCkHo KE+2ON5tdJMpzyaCvGWxHz5+gDh+ltBYpo7Jfd2/37aD79y/jZl1SofLsYW1+cGxcq0paWH8zh3 gUPXdwi3yEkV76ixgpD9qyZjgpUunlb4Mz7WV+LJwU3+bq83A6U41oMy/3D/4NbbgsXN5N1lQ/9 +xp2obyb8uZgliavBjsOMH1opeCZU2VaIBM9cWGCw041qOoU
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
 drivers/net/ethernet/8390/ax88796.c | 6 ++----
 drivers/net/ethernet/8390/mcf8390.c | 5 ++---
 drivers/net/ethernet/8390/ne.c      | 5 ++---
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/8390/ax88796.c b/drivers/net/ethernet/8390/ax88796.c
index af603256b724..2874680ef24d 100644
--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -811,7 +811,7 @@ static int ax_init_dev(struct net_device *dev)
 	return ret;
 }
 
-static int ax_remove(struct platform_device *pdev)
+static void ax_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct ei_device *ei_local = netdev_priv(dev);
@@ -832,8 +832,6 @@ static int ax_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 	free_netdev(dev);
-
-	return 0;
 }
 
 /*
@@ -1011,7 +1009,7 @@ static struct platform_driver axdrv = {
 		.name		= "ax88796",
 	},
 	.probe		= ax_probe,
-	.remove		= ax_remove,
+	.remove_new	= ax_remove,
 	.suspend	= ax_suspend,
 	.resume		= ax_resume,
 };
diff --git a/drivers/net/ethernet/8390/mcf8390.c b/drivers/net/ethernet/8390/mcf8390.c
index 217838b28220..5a0fa995e643 100644
--- a/drivers/net/ethernet/8390/mcf8390.c
+++ b/drivers/net/ethernet/8390/mcf8390.c
@@ -441,7 +441,7 @@ static int mcf8390_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mcf8390_remove(struct platform_device *pdev)
+static void mcf8390_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct resource *mem;
@@ -450,7 +450,6 @@ static int mcf8390_remove(struct platform_device *pdev)
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(mem->start, resource_size(mem));
 	free_netdev(dev);
-	return 0;
 }
 
 static struct platform_driver mcf8390_drv = {
@@ -458,7 +457,7 @@ static struct platform_driver mcf8390_drv = {
 		.name	= "mcf8390",
 	},
 	.probe		= mcf8390_probe,
-	.remove		= mcf8390_remove,
+	.remove_new	= mcf8390_remove,
 };
 
 module_platform_driver(mcf8390_drv);
diff --git a/drivers/net/ethernet/8390/ne.c b/drivers/net/ethernet/8390/ne.c
index 7d89ec1cf273..350683a09d2e 100644
--- a/drivers/net/ethernet/8390/ne.c
+++ b/drivers/net/ethernet/8390/ne.c
@@ -823,7 +823,7 @@ static int __init ne_drv_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ne_drv_remove(struct platform_device *pdev)
+static void ne_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
@@ -842,7 +842,6 @@ static int ne_drv_remove(struct platform_device *pdev)
 		release_region(dev->base_addr, NE_IO_EXTENT);
 		free_netdev(dev);
 	}
-	return 0;
 }
 
 /* Remove unused devices or all if true. */
@@ -895,7 +894,7 @@ static int ne_drv_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver ne_driver = {
-	.remove		= ne_drv_remove,
+	.remove_new	= ne_drv_remove,
 	.suspend	= ne_drv_suspend,
 	.resume		= ne_drv_resume,
 	.driver		= {
-- 
2.40.1



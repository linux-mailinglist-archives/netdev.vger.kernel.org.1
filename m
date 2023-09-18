Return-Path: <netdev+bounces-34779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FFF7A5484
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8AD1C20A65
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8768631A99;
	Mon, 18 Sep 2023 20:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B89A30FB5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F96B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-0007MQ-Jl; Mon, 18 Sep 2023 22:42:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-007IkM-Fy; Mon, 18 Sep 2023 22:42:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-002mq7-6Z; Mon, 18 Sep 2023 22:42:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Steve Glendinning <steve.glendinning@shawell.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 45/54] net: ethernet: smsc: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:17 +0200
Message-Id: <20230918204227.1316886-46-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Mlle1d3XJmUJgQgFN7stU50RfZjm+5bbv+jFZjqiZu8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYWY1FS1Rqo/0xouLDhJqf9L+f7wmqaE4VdR /FDaARrvfWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2FgAKCRCPgPtYfRL+ TviPB/0RNOKqiWHpimm++qryzrZA4Tox/ZxuEOpsrTHgaX4hEDr2pr2L37ows7vtYm/Vesvkvm1 k9D/qi1m9pB4ONtbou8A53tecUpGhLmAc8dFgYNU435CRoYbrHHMbmy+fQsWeQ8g6CqBS1OlDLK hgfndnFohEWvRNRIS5PnKBzFJ+ZH3rOJNjNBTE/Sl9tCEDdzpQ7BAMdEeG51I2gGSU407dnknpA 5f3op5XHeWR1rSG9RI+Z+dvFs1PGTHVLwSkjaSLQphCi5e0qmpIMMNa4oHr7jfghM8PrhvoTsmD NqN0H7hHhfdKPOOcFFSacdcR/mCikAyRgZIxBiTJZtDTJMOP
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
 drivers/net/ethernet/smsc/smc91x.c   | 6 ++----
 drivers/net/ethernet/smsc/smsc911x.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 032eccf8eb42..758347616535 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2411,7 +2411,7 @@ static int smc_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int smc_drv_remove(struct platform_device *pdev)
+static void smc_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct smc_local *lp = netdev_priv(ndev);
@@ -2436,8 +2436,6 @@ static int smc_drv_remove(struct platform_device *pdev)
 	release_mem_region(res->start, SMC_IO_EXTENT);
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static int smc_drv_suspend(struct device *dev)
@@ -2480,7 +2478,7 @@ static const struct dev_pm_ops smc_drv_pm_ops = {
 
 static struct platform_driver smc_driver = {
 	.probe		= smc_drv_probe,
-	.remove		= smc_drv_remove,
+	.remove_new	= smc_drv_remove,
 	.driver		= {
 		.name	= CARDNAME,
 		.pm	= &smc_drv_pm_ops,
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index cb590db625e8..31cb7d0166f0 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2314,7 +2314,7 @@ static int smsc911x_init(struct net_device *dev)
 	return 0;
 }
 
-static int smsc911x_drv_remove(struct platform_device *pdev)
+static void smsc911x_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct smsc911x_data *pdata;
@@ -2348,8 +2348,6 @@ static int smsc911x_drv_remove(struct platform_device *pdev)
 	free_netdev(dev);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 /* standard register acces */
@@ -2668,7 +2666,7 @@ MODULE_DEVICE_TABLE(acpi, smsc911x_acpi_match);
 
 static struct platform_driver smsc911x_driver = {
 	.probe = smsc911x_drv_probe,
-	.remove = smsc911x_drv_remove,
+	.remove_new = smsc911x_drv_remove,
 	.driver = {
 		.name	= SMSC_CHIPNAME,
 		.pm	= SMSC911X_PM_OPS,
-- 
2.40.1



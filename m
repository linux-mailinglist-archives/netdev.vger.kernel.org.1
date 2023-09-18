Return-Path: <netdev+bounces-34784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3277A5497
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAB328201E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7B3418B;
	Mon, 18 Sep 2023 20:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0DB31A81
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE13118
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-0007Z5-VO; Mon, 18 Sep 2023 22:42:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-007Iko-9S; Mon, 18 Sep 2023 22:42:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-002mqV-VP; Mon, 18 Sep 2023 22:42:48 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kevin Brace <kevinbrace@bracecomputerlab.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 51/54] net: ethernet: via: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:23 +0200
Message-Id: <20230918204227.1316886-52-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AT0QbPH79+bCdEcT4phV/0cgPmocO9EuYHwRwzLTOJQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYdStacLWk9pd//iWGyMfQV4WW9sv53aa6T+ XPsPZNja0mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2HQAKCRCPgPtYfRL+ Ti/qB/wNA6bxEjxr1vaYalxD0/JqI1A/CrTS7Tazh5oWlr8gpaaCBaHA9a06dIOEfYHtAeXkqxN HDpr8fjZDKKpSByg6ea/uQWyJPO5O7cxDjMc3GW19cUBdQM2VX0xJe4a9pvgsek2OmkCLlsNPtL EivfYqNdrXHcNnT5y1s+Bfbwvsh0I/rocAlGKhKZFxa832o0Ydyy4V4+xEfU0TOLuAnbo2LP6Zm VUCKzP0hS9ThXkg47QgWi+tOxbcFO/y9NKASWTtclsi5G3DbSquuIc8BpKUcOTSuK7rYKAB+cjj VnM8B5gMMPsC0XTOCTBMg5Mr1nDHPTM/fIxu/Vnig6V/RNVF
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
 drivers/net/ethernet/via/via-rhine.c    | 6 ++----
 drivers/net/ethernet/via/via-velocity.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/via/via-rhine.c b/drivers/net/ethernet/via/via-rhine.c
index 3e09e5036490..e80c02948801 100644
--- a/drivers/net/ethernet/via/via-rhine.c
+++ b/drivers/net/ethernet/via/via-rhine.c
@@ -2443,7 +2443,7 @@ static void rhine_remove_one_pci(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static int rhine_remove_one_platform(struct platform_device *pdev)
+static void rhine_remove_one_platform(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct rhine_private *rp = netdev_priv(dev);
@@ -2453,8 +2453,6 @@ static int rhine_remove_one_platform(struct platform_device *pdev)
 	iounmap(rp->base);
 
 	free_netdev(dev);
-
-	return 0;
 }
 
 static void rhine_shutdown_pci(struct pci_dev *pdev)
@@ -2572,7 +2570,7 @@ static struct pci_driver rhine_driver_pci = {
 
 static struct platform_driver rhine_driver_platform = {
 	.probe		= rhine_init_one_platform,
-	.remove		= rhine_remove_one_platform,
+	.remove_new	= rhine_remove_one_platform,
 	.driver = {
 		.name	= DRV_NAME,
 		.of_match_table	= rhine_of_tbl,
diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 731f689412e6..1c6b2a9bba08 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -2957,11 +2957,9 @@ static int velocity_platform_probe(struct platform_device *pdev)
 	return velocity_probe(&pdev->dev, irq, info, BUS_PLATFORM);
 }
 
-static int velocity_platform_remove(struct platform_device *pdev)
+static void velocity_platform_remove(struct platform_device *pdev)
 {
 	velocity_remove(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -3249,7 +3247,7 @@ static struct pci_driver velocity_pci_driver = {
 
 static struct platform_driver velocity_platform_driver = {
 	.probe		= velocity_platform_probe,
-	.remove		= velocity_platform_remove,
+	.remove_new	= velocity_platform_remove,
 	.driver = {
 		.name = "via-velocity",
 		.of_match_table = velocity_of_ids,
-- 
2.40.1



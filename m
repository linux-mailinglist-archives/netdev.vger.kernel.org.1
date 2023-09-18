Return-Path: <netdev+bounces-34697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 969717A52DE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51051281A77
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3328273FB;
	Mon, 18 Sep 2023 19:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4121101
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DB6109
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-0002o0-L3; Mon, 18 Sep 2023 21:19:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-007I2R-GR; Mon, 18 Sep 2023 21:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-002m1k-6j; Mon, 18 Sep 2023 21:19:24 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 2/9] net: dsa: bcm_sf2: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:09 +0200
Message-Id: <20230918191916.1299418-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=llyy666Rn6IKsrY9KOhWrBRVZ6AC1Pp9fkl94JJ/Cqo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKoTkyScMBYGWLcEIZIR6aHuZi2TnPizMl/6 QMbTWxQuyaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiiqAAKCRCPgPtYfRL+ TgCLB/9deQR/xgCLnfS776ZLlNS64RvD2KlMPFVf6MDUUIuH1olBbw5LPuiaQt6Mm0dXmieL+Yd BosNakmXrNL1cAZMgH+u6C4iVRfwuWe3gbaw4ZzW9HK6fLEuW6Pc9A9cAcSNTJt08yDArAzasC4 sOz0dmOBKqeKaEeO/0ZmVFHp/HHzYvbwhpyCRRQ4WBpz4oG7k4sjKul7dDR6E6gq3xE6FJ2/mpH q87T0f5GrMMTT02hw4vampDR//g6yly3yBLxBxWkZqtJ1PayU4Sg7uu11lHdJSaFwZ8OPhmJcco unusEkrlxVAKqWc26JgB4Gvws/8pD2HNEDOxmhWcELPuL7Su
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/dsa/bcm_sf2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 72374b066f64..0b62bd78ac50 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -1537,12 +1537,12 @@ static int bcm_sf2_sw_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int bcm_sf2_sw_remove(struct platform_device *pdev)
+static void bcm_sf2_sw_remove(struct platform_device *pdev)
 {
 	struct bcm_sf2_priv *priv = platform_get_drvdata(pdev);
 
 	if (!priv)
-		return 0;
+		return;
 
 	priv->wol_ports_mask = 0;
 	/* Disable interrupts */
@@ -1554,8 +1554,6 @@ static int bcm_sf2_sw_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->clk);
 	if (priv->type == BCM7278_DEVICE_ID)
 		reset_control_assert(priv->rcdev);
-
-	return 0;
 }
 
 static void bcm_sf2_sw_shutdown(struct platform_device *pdev)
@@ -1601,7 +1599,7 @@ static SIMPLE_DEV_PM_OPS(bcm_sf2_pm_ops,
 
 static struct platform_driver bcm_sf2_driver = {
 	.probe	= bcm_sf2_sw_probe,
-	.remove	= bcm_sf2_sw_remove,
+	.remove_new = bcm_sf2_sw_remove,
 	.shutdown = bcm_sf2_sw_shutdown,
 	.driver = {
 		.name = "brcm-sf2",
-- 
2.40.1



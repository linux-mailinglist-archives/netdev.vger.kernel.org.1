Return-Path: <netdev+bounces-34703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC6A7A52EB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3533F1C20B1C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63B27720;
	Mon, 18 Sep 2023 19:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4762273F2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:41 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B8F7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmI-0002o4-31; Mon, 18 Sep 2023 21:19:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-007I2d-DO; Mon, 18 Sep 2023 21:19:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-002m20-3i; Mon, 18 Sep 2023 21:19:25 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Colin Foster <colin.foster@in-advantage.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 6/9] net: dsa: ocelot: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:13 +0200
Message-Id: <20230918191916.1299418-7-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OecXssYwG3kS7FXtpkQg3ZT09QXx7vYIQaKPOCGYaEU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKtFR3KGsKsoLgnsiV5+hVCDEYAswjnVulOV 5VBc/K0UmGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiirQAKCRCPgPtYfRL+ Tr6zB/9sQVRPRbwaxYYNwQGhdVEq0YdisNP9wXKKc3QRaCjcSTruYZE2WUZ4nQXQ1Wsctca/uGD oEW5+hNZ3TKywVA3aRe/GKkA5VsY1uH9MD0Cx+plqt5Cq+wL2Fh3uov3k8e+6UFC0E6/7cJ8Skh eR0+EB2770ZS5nOj46l8DN5yMALzGlCTeBz+gLff0VuVIOEZt0CzgGQI2l+xfcs3LTDF5IlnUmp QanFcxZpe4J+RGss2X0oCkihXdZ9DOX6V3Ji0No8StHoc3R6MMNxtOT07DG1WxX+OEWFVTzoUNa MSTDzwyBXm+ZPQzkt9s0ciAbI4NPNkTzZuYoF2nBGiq8C9j5
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

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/dsa/ocelot/ocelot_ext.c      | 8 +++-----
 drivers/net/dsa/ocelot/seville_vsc9953.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/ocelot/ocelot_ext.c b/drivers/net/dsa/ocelot/ocelot_ext.c
index c29bee5a5c48..22187d831c4b 100644
--- a/drivers/net/dsa/ocelot/ocelot_ext.c
+++ b/drivers/net/dsa/ocelot/ocelot_ext.c
@@ -115,19 +115,17 @@ static int ocelot_ext_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ocelot_ext_remove(struct platform_device *pdev)
+static void ocelot_ext_remove(struct platform_device *pdev)
 {
 	struct felix *felix = dev_get_drvdata(&pdev->dev);
 
 	if (!felix)
-		return 0;
+		return;
 
 	dsa_unregister_switch(felix->ds);
 
 	kfree(felix->ds);
 	kfree(felix);
-
-	return 0;
 }
 
 static void ocelot_ext_shutdown(struct platform_device *pdev)
@@ -154,7 +152,7 @@ static struct platform_driver ocelot_ext_switch_driver = {
 		.of_match_table = ocelot_ext_switch_of_match,
 	},
 	.probe = ocelot_ext_probe,
-	.remove = ocelot_ext_remove,
+	.remove_new = ocelot_ext_remove,
 	.shutdown = ocelot_ext_shutdown,
 };
 module_platform_driver(ocelot_ext_switch_driver);
diff --git a/drivers/net/dsa/ocelot/seville_vsc9953.c b/drivers/net/dsa/ocelot/seville_vsc9953.c
index 8f912bda120b..049930da0521 100644
--- a/drivers/net/dsa/ocelot/seville_vsc9953.c
+++ b/drivers/net/dsa/ocelot/seville_vsc9953.c
@@ -1029,19 +1029,17 @@ static int seville_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int seville_remove(struct platform_device *pdev)
+static void seville_remove(struct platform_device *pdev)
 {
 	struct felix *felix = platform_get_drvdata(pdev);
 
 	if (!felix)
-		return 0;
+		return;
 
 	dsa_unregister_switch(felix->ds);
 
 	kfree(felix->ds);
 	kfree(felix);
-
-	return 0;
 }
 
 static void seville_shutdown(struct platform_device *pdev)
@@ -1064,7 +1062,7 @@ MODULE_DEVICE_TABLE(of, seville_of_match);
 
 static struct platform_driver seville_vsc9953_driver = {
 	.probe		= seville_probe,
-	.remove		= seville_remove,
+	.remove_new	= seville_remove,
 	.shutdown	= seville_shutdown,
 	.driver = {
 		.name		= "mscc_seville",
-- 
2.40.1



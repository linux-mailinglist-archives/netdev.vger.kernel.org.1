Return-Path: <netdev+bounces-34698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE27A52E0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33E81C20756
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539B21101;
	Mon, 18 Sep 2023 19:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB8273FF
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02009112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-0002o2-Lb; Mon, 18 Sep 2023 21:19:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-007I2X-UV; Mon, 18 Sep 2023 21:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-002m1s-L8; Mon, 18 Sep 2023 21:19:24 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 4/9] net: dsa: lantiq_gswip: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:11 +0200
Message-Id: <20230918191916.1299418-5-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EyxEiwLm1s4hEH0+ZFg1xmRmaIOl4GbHujJN0x8ghn0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKqUm2GRLrFevHhCw+3YfgKevQsqzUFbd6ZO rb189sfbc+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiiqgAKCRCPgPtYfRL+ TiYFB/9JyByaxilhomQwOYd5djhSxqTM3Gu1ekV/FdfL11cm03bEoyUBuru0Tv1kaNnmKboJKzt XWt4YN2L0PnCcMiSDhhMtZREddLYS6ojDvVXKiKJBjkyxfEmhzStIGX5nLhukvD2l7gz8ts6Y98 ZcCouSIWrekgaM6s1HlHU0wfUTBIzTZiBUjgR934oJInIa2+fB0rm2IH3Of68N1Ij3A/r7ZVP5y 9MgHjv1C6u8TAQilsbU0QR8n4AEFSSiG8txS5O0COHZq8PzkdDIkLFqp/oogl8KYGoHz2gPln1J FDyS1hC6fxnxDBRb+J4uPPQiuMDCLxtHe3YJJvRgj06YYEu3
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
 drivers/net/dsa/lantiq_gswip.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 3c76a1a14aee..25abf2caf5fb 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -2207,13 +2207,13 @@ static int gswip_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int gswip_remove(struct platform_device *pdev)
+static void gswip_remove(struct platform_device *pdev)
 {
 	struct gswip_priv *priv = platform_get_drvdata(pdev);
 	int i;
 
 	if (!priv)
-		return 0;
+		return;
 
 	/* disable the switch */
 	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
@@ -2228,8 +2228,6 @@ static int gswip_remove(struct platform_device *pdev)
 
 	for (i = 0; i < priv->num_gphy_fw; i++)
 		gswip_gphy_fw_remove(priv, &priv->gphy_fw[i]);
-
-	return 0;
 }
 
 static void gswip_shutdown(struct platform_device *pdev)
@@ -2266,7 +2264,7 @@ MODULE_DEVICE_TABLE(of, gswip_of_match);
 
 static struct platform_driver gswip_driver = {
 	.probe = gswip_probe,
-	.remove = gswip_remove,
+	.remove_new = gswip_remove,
 	.shutdown = gswip_shutdown,
 	.driver = {
 		.name = "gswip",
-- 
2.40.1



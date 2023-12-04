Return-Path: <netdev+bounces-53578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E549C803D08
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2166B20B73
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D22FC32;
	Mon,  4 Dec 2023 18:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF04CD5
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:31:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj2-00038x-Fx; Mon, 04 Dec 2023 19:31:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj1-00DZmS-Oh; Mon, 04 Dec 2023 19:31:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj1-00EE7B-FP; Mon, 04 Dec 2023 19:31:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alex Elder <elder@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 1/9] net: ipa: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:41 +0100
Message-ID:  <c43193b9a002e88da36b111bb44ce2973ecde722.1701713943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2742; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=i2wI1xIadZHZVxHz3LgCDMBnM/dtNyelG/0iXlEJ5xs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbhrUi54GzU/9XeBAfnus3jPPmJ0bFkjuTXU3d KWtuR03VuqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW4a1AAKCRCPgPtYfRL+ Tp2pCACi0vKu/eT7/h53Cl+j/r6WbEgs3d22Q3tTXgOKVdTkS5mIZmn9xUPBUgIsEhw11FCq27q pFK6DNJ2IPBomhVQXwdbzwya2VoVgC6Tk88eg1skJlH1U3fT0i62lknGM4BeKF4OpGWQ8/qwK3R sJtihjGrPOJQbFG4VcJJyuTDfRn+ZpblJ9axJ58vH7Q11HBSGrmTNKSEDCViF1PM9umpj47KKRI bEdP0J0Er7sD5CeVGSLA9Ci8jKGZfB103ptTM/1NDFkZ8xMmnwk+aKipT8RG3qPUkKOPgXhWf/c iR6hctbdKURZQJ/0YizP5+NJ/kfGhRVV94Dn0BgYKV8ZFRr/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Link: https://lore.kernel.org/r/20231117095922.876489-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ipa/ipa_main.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 86884c21e792..00475fd7a205 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -943,7 +943,7 @@ static int ipa_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ipa_remove(struct platform_device *pdev)
+static void ipa_remove(struct platform_device *pdev)
 {
 	struct ipa *ipa = dev_get_drvdata(&pdev->dev);
 	struct ipa_power *power = ipa->power;
@@ -966,8 +966,16 @@ static int ipa_remove(struct platform_device *pdev)
 			usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 			ret = ipa_modem_stop(ipa);
 		}
-		if (ret)
-			return ret;
+		if (ret) {
+			/*
+			 * Not cleaning up here properly might also yield a
+			 * crash later on. As the device is still unregistered
+			 * in this case, this might even yield a crash later on.
+			 */
+			dev_err(dev, "Failed to stop modem (%pe), leaking resources\n",
+				ERR_PTR(ret));
+			return;
+		}
 
 		ipa_teardown(ipa);
 	}
@@ -985,17 +993,6 @@ static int ipa_remove(struct platform_device *pdev)
 	ipa_power_exit(power);
 
 	dev_info(dev, "IPA driver removed");
-
-	return 0;
-}
-
-static void ipa_shutdown(struct platform_device *pdev)
-{
-	int ret;
-
-	ret = ipa_remove(pdev);
-	if (ret)
-		dev_err(&pdev->dev, "shutdown: remove returned %d\n", ret);
 }
 
 static const struct attribute_group *ipa_attribute_groups[] = {
@@ -1008,8 +1005,8 @@ static const struct attribute_group *ipa_attribute_groups[] = {
 
 static struct platform_driver ipa_driver = {
 	.probe		= ipa_probe,
-	.remove		= ipa_remove,
-	.shutdown	= ipa_shutdown,
+	.remove_new	= ipa_remove,
+	.shutdown	= ipa_remove,
 	.driver	= {
 		.name		= "ipa",
 		.pm		= &ipa_pm_ops,
-- 
2.42.0



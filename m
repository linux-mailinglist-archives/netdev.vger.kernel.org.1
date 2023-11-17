Return-Path: <netdev+bounces-48615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5837EEF8B
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0163A1F27EF5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F185C1798A;
	Fri, 17 Nov 2023 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419D584
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-0000Cb-IB; Fri, 17 Nov 2023 10:59:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-009eFe-2c; Fri, 17 Nov 2023 10:59:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vda-002zVv-Pm; Fri, 17 Nov 2023 10:59:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 02/10] net: ipa: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:25 +0100
Message-ID: <20231117095922.876489-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2094; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UR+v83JWKRrfwt67dn6LJcB789pXVB0wn22BwbFd2+8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzl9YU33CM2Es8FE3kX6iVcCgtuYpWiT+I9xA WInnog9/AKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5fQAKCRCPgPtYfRL+ TgAkB/sGtQWgnFy7aBlAT+ZhNVWulBFFwOAOUnXCE76bf8/uBH3UmAbLznc3A/5Xfji6beK0k4s 77QUJBsCrK7um9g7KRJ5nLH1Cy8XQycYua60e7VMZ3vDXau2v4rn5Zv2y6Kb4nCGBVZBoWtbzj/ /NIkt8aJXURcYBQka0Ii49RKym0pwXFUOMoMj9+jT8Yx1jqmJUT/2zpF+Bi8gPesKVputq4qxK6 o+mPNDqP6n7l17ApK8ODoBLHGe1GZtkJhNop/GIC4vfU6+duKpy+F++pNOwALFx/jMqHm6z+ItD uAS7g/C+B/ZPSLUdtY+hUnhKIozYEFzbNgX/hA4K8NEWYKXw
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ipa/ipa_main.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 60e4f590f5de..2c769b85a2cd 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -936,7 +936,7 @@ static int ipa_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ipa_remove(struct platform_device *pdev)
+static void ipa_remove(struct platform_device *pdev)
 {
 	struct ipa *ipa = dev_get_drvdata(&pdev->dev);
 	struct ipa_power *power = ipa->power;
@@ -979,17 +979,6 @@ static int ipa_remove(struct platform_device *pdev)
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
@@ -1002,8 +991,8 @@ static const struct attribute_group *ipa_attribute_groups[] = {
 
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



Return-Path: <netdev+bounces-48574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A817EEE46
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0491F263A9
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718DB125C7;
	Fri, 17 Nov 2023 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00503D4F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:17:18 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-0007gO-38; Fri, 17 Nov 2023 10:17:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyP-009e67-5d; Fri, 17 Nov 2023 10:17:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyO-002yJX-Sq; Fri, 17 Nov 2023 10:17:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: 
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/7] net: ethernet: ti: am65-cpsw: Don't error out in .remove()
Date: Fri, 17 Nov 2023 10:16:57 +0100
Message-ID: <20231117091655.872426-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Zmf+Sb7WCxuxFHZh9EDWZprTFu2LgP66cPulGLElfjs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVy+IjCRiJNFg1lDyufwPqFMmzb9v5ubw+sGP+ dRadg3EAjOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcviAAKCRCPgPtYfRL+ TtW6B/wOrS7SfTwjWIkqEN8WylEaOq5wUblGn5J7QYRFgWtgLoKmmZ/3DQCyuyChPUPPnCMapKd czRZ1nw8qZXqEXTqtkA6JphtgrjpnfkiXST47Zw4JviZtxe3q5Oey6sZ3pL4GLxKjAVKek1VSzK WFaN25FEJjrKKjBe2RFBOfNzIliuWCYwZyV8pWx6UQZg+B7zgLb8LfOqOoWYx+99jpZPI79kKux 6Fw4t9wPGIQFXuPUI4yrHfL2BfwhMsoiRIjVzxOKoL8qu6TlQEnDJDH1Xz1GyWhqM7PUyk2GNli 2OpiJ5oy23TZl9LSmAysF2LqNuchvyrMFuQ7DeCct00QTB7y
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Returning early from .remove() with an error code still results in the
driver unbinding the device. So the driver core ignores the returned error
code and the resources that were not freed are never catched up. In
combination with devm this also often results in use-after-free bugs.

In case of the am65-cpsw-nuss driver there is an error path, but it's never
taken because am65_cpts_resume() never fails (which however might be
another problem). Still make this explicit and drop the early return in
exchange for an error message (that is more useful than the error the
driver core emits when .remove() returns non-zero).

This prepares changing am65_cpsw_nuss_remove() to return void.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..960cb3fa0754 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3007,9 +3007,12 @@ static int am65_cpsw_nuss_remove(struct platform_device *pdev)
 
 	common = dev_get_drvdata(dev);
 
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		return ret;
+		/* am65_cpts_resume() doesn't fail, so handling ret < 0 is only
+		 * for the sake of completeness.
+		 */
+		dev_err(dev, "runtime resume failed (%pe)\n", ERR_PTR(ret));
 
 	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_unregister_notifiers(common);
-- 
2.42.0



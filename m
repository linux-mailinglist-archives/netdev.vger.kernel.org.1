Return-Path: <netdev+bounces-51781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A57FC05E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C73282908
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB055CD3A;
	Tue, 28 Nov 2023 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A510EC
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 09:38:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822i-00064P-4G; Tue, 28 Nov 2023 18:38:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822g-00CECc-0Z; Tue, 28 Nov 2023 18:38:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822f-00AIhZ-NZ; Tue, 28 Nov 2023 18:38:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 1/4] net: ethernet: ti: am65-cpsw: Convert to platform remove callback returning void
Date: Tue, 28 Nov 2023 18:38:25 +0100
Message-ID: <20231128173823.867512-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231128173823.867512-1-u.kleine-koenig@pengutronix.de>
References: <20231128173823.867512-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bVAR8x8tfpDjuDsyMYeSZJ6a7CsZsuWI1Xm1FlBXbXA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlZiWRopMxGZRMAwe9Vm1k2kqKyVfOAktZQcDEU mUaxlS6ERuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWYlkQAKCRCPgPtYfRL+ TgYOB/9FLJMG36orRtOHwk1Btk7fyx8wf66BztVEQ9fOXhn2KG9Ybip1/nTzTG2MowuLIMzQl1d gif75hOWXKX5hrifbkikfLAi28TvDOkQHWK3vdN2qWYIUqqLCuZN/o3GI+dlOKSUr+iHkeWG5oL 1BnuqhGLqlcsxgmx0pCSavMRqNyyZimp65Bm3VZ+TypMyjqQkkIjDe/aDruZntWhefez6ZfTodR uYPZfMgPvG1UOfjFk2ZyPur3n5k0zsY2kQhAzsrb6Fbn9a/f4U/1IPal6PeLPRtljwzSnMYWp/V LeIlK9QTnARpRjCp7R8ZhVX3yNraSFcg88+WeEs8tLB7xb0I
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

Replace the error path returning a non-zero value by an error message
and a comment that there is more to do. With that this patch results in
no change of behaviour in this driver apart from improving the error
message.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7992a76ed4d8..7651f90f51f2 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -3028,7 +3028,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int am65_cpsw_nuss_remove(struct platform_device *pdev)
+static void am65_cpsw_nuss_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct am65_cpsw_common *common;
@@ -3037,8 +3037,14 @@ static int am65_cpsw_nuss_remove(struct platform_device *pdev)
 	common = dev_get_drvdata(dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		/* Note, if this error path is taken, we're leaking some
+		 * resources.
+		 */
+		dev_err(&pdev->dev, "Failed to resume device (%pe)\n",
+			ERR_PTR(ret));
+		return;
+	}
 
 	am65_cpsw_unregister_devlink(common);
 	am65_cpsw_unregister_notifiers(common);
@@ -3056,7 +3062,6 @@ static int am65_cpsw_nuss_remove(struct platform_device *pdev)
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int am65_cpsw_nuss_suspend(struct device *dev)
@@ -3156,7 +3161,7 @@ static struct platform_driver am65_cpsw_nuss_driver = {
 		.pm = &am65_cpsw_nuss_dev_pm_ops,
 	},
 	.probe = am65_cpsw_nuss_probe,
-	.remove = am65_cpsw_nuss_remove,
+	.remove_new = am65_cpsw_nuss_remove,
 };
 
 module_platform_driver(am65_cpsw_nuss_driver);
-- 
2.42.0



Return-Path: <netdev+bounces-34753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9F57A544D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D759F1C20434
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31727EF2;
	Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0A266DD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED53611C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-0006lz-5o; Mon, 18 Sep 2023 22:42:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-007IiK-Nu; Mon, 18 Sep 2023 22:42:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-002mo2-ER; Mon, 18 Sep 2023 22:42:37 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 13/54] net: ethernet: calxeda: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:45 +0200
Message-Id: <20230918204227.1316886-14-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XHVaCGZNXkcjmW8qC17UNpNWBdhyT+Qb05ci1B79J+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXzbPc+K+zAWntUEVfFF2aryK6nEveXs91eS 1Bg6IIOg1iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi18wAKCRCPgPtYfRL+ TvlWB/49K+M0Xvy8Xb/MmqHdfF/yjne8x81ZCQe7NaEmN2zzv1goffeSAZtx9qAIaXNbB0gx8B3 y6RaqSU74vrUEjH0lRpru8h7zdZapMbCq5CkLncpxONGIf1BN43xmRUW/H+RCCu+tNz/UI/BRA6 muANcDhJ7mVQ+vIC8Tr+5rTgeJuYj8w4OrWochIz7uMlax5ELcnQOlKwbo55nb+YrptZiQ6OYh8 qWTfesk+gzI+4ASeJwgKiNMV1882fYKcLa+r5JxMPDOxXnn6K329sf37PpLeXmUy70fKCldXNRa ceegVuEpRAuaIuf5VM4OphCAhoI5b+ExjOgS2RN2Yw6VC1Eo
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

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/calxeda/xgmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index f4f87dfa9687..5e97f1e4e38e 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1820,7 +1820,7 @@ static int xgmac_probe(struct platform_device *pdev)
  * changes the link status, releases the DMA descriptor rings,
  * unregisters the MDIO bus and unmaps the allocated memory.
  */
-static int xgmac_remove(struct platform_device *pdev)
+static void xgmac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct xgmac_priv *priv = netdev_priv(ndev);
@@ -1840,8 +1840,6 @@ static int xgmac_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1921,7 +1919,7 @@ static struct platform_driver xgmac_driver = {
 		.pm = &xgmac_pm_ops,
 	},
 	.probe = xgmac_probe,
-	.remove = xgmac_remove,
+	.remove_new = xgmac_remove,
 };
 
 module_platform_driver(xgmac_driver);
-- 
2.40.1



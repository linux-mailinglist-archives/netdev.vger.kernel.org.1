Return-Path: <netdev+bounces-34791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634A7A54AE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6607B1C20C17
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5B34CE6;
	Mon, 18 Sep 2023 20:43:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E4B341B8
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819D8F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-0007KC-Mp; Mon, 18 Sep 2023 22:42:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-007Ik3-4t; Mon, 18 Sep 2023 22:42:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-002mpn-Re; Mon, 18 Sep 2023 22:42:44 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Timur Tabi <timur@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 40/54] net: ethernet: qualcomm: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:12 +0200
Message-Id: <20230918204227.1316886-41-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=90RUkvqu5NHPkAqH4p24gqLPFerBU0bb4s311uUTbxc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYRuZlAAZZcLEMBpdy+GVwvVKCMEmwUQd22S SsMf1P96TyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2EQAKCRCPgPtYfRL+ TtuuCAC5gGJrHZmSAruEDrCgFONy9RcV4vE28VGhGTCrtdKAJN7xoY+zfx1ftritgdGYiO1hhCP Lz2bi7oEYAORwIsMPEYQMamL1s44cUOtdsL5e4r8e7CLnCV+81nA01BEvMqjZ+5seiekYrEBX7z RUGkFA3daSbDjG8CH5fRUQ0aEZsK8hGGeDVU9zVznzdvLIQfQSdi8B4i3Lc2sBchYCNmxxCgzRN lZz9VJAcUYJ2V8jin/rtF0I6cP08gEu8iaxaU9XxI5/pNI5JjOlpR4uaQVilsj8Hs4FOVx28VQ2 DAHbn5+XgNIXb0l6o4GMskeRt+v6u602wpUL5wsnMWz5UWMX
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
 drivers/net/ethernet/qualcomm/emac/emac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 19bb16daf4e7..3270df72541b 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -718,7 +718,7 @@ static int emac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int emac_remove(struct platform_device *pdev)
+static void emac_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev = dev_get_drvdata(&pdev->dev);
 	struct emac_adapter *adpt = netdev_priv(netdev);
@@ -742,8 +742,6 @@ static int emac_remove(struct platform_device *pdev)
 	iounmap(adpt->phy.base);
 
 	free_netdev(netdev);
-
-	return 0;
 }
 
 static void emac_shutdown(struct platform_device *pdev)
@@ -762,7 +760,7 @@ static void emac_shutdown(struct platform_device *pdev)
 
 static struct platform_driver emac_platform_driver = {
 	.probe	= emac_probe,
-	.remove	= emac_remove,
+	.remove_new = emac_remove,
 	.driver = {
 		.name		= "qcom-emac",
 		.of_match_table = emac_dt_match,
-- 
2.40.1



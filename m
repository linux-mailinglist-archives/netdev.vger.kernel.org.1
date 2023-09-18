Return-Path: <netdev+bounces-34755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D47A544F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271D281209
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E928DA0;
	Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE4727732
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62211F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-0006tp-5G; Mon, 18 Sep 2023 22:42:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-007IiW-M4; Mon, 18 Sep 2023 22:42:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-002moF-Bl; Mon, 18 Sep 2023 22:42:38 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 16/54] net: ethernet: cortina: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:48 +0200
Message-Id: <20230918204227.1316886-17-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2685; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EPgu7aEY+1bPQIInvLOmlmi5ze1M5425Gfn0gbB/bX8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX2Qgiqkl97zXJYmQM+e8EQRVMUt9+LfoZXn ROD4R88CxmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi19gAKCRCPgPtYfRL+ TptzB/sEr0uPT8c75aL/mBtnjhAyOq01ScbljLvNAqYucFPKtOmbGiMQOlK44l1iFV4yVX7cnRv ytn3e0ZzFBKXcv92wbDWqwVIeAE43EheKC575LHYjzwhVjCgVR55vniOR0jL2Io8SwAByf91CBe V9jK3C/tVbJQ7IhslbTbdkKGM082HMgDm+COC4OWa13Hrd7I4JL1JH6AGjAdaUSptU3BDxWQZWM r4FrJSpa159vbCRCiXDOWGmKiYpQZcT75GShPnlz5QeXpeAnnO2b32qX5VgavygkEeaqOcBUYNU UU/3qK1/TcEZk0IrJ2U2yBdnQpElsqPIPegTyN9z42J79HXD
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
 drivers/net/ethernet/cortina/gemini.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a8b9d1a3e4d5..5423fe26b4ef 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2518,13 +2518,11 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int gemini_ethernet_port_remove(struct platform_device *pdev)
+static void gemini_ethernet_port_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet_port *port = platform_get_drvdata(pdev);
 
 	gemini_port_remove(port);
-
-	return 0;
 }
 
 static const struct of_device_id gemini_ethernet_port_of_match[] = {
@@ -2541,7 +2539,7 @@ static struct platform_driver gemini_ethernet_port_driver = {
 		.of_match_table = gemini_ethernet_port_of_match,
 	},
 	.probe = gemini_ethernet_port_probe,
-	.remove = gemini_ethernet_port_remove,
+	.remove_new = gemini_ethernet_port_remove,
 };
 
 static int gemini_ethernet_probe(struct platform_device *pdev)
@@ -2583,14 +2581,12 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 	return devm_of_platform_populate(dev);
 }
 
-static int gemini_ethernet_remove(struct platform_device *pdev)
+static void gemini_ethernet_remove(struct platform_device *pdev)
 {
 	struct gemini_ethernet *geth = platform_get_drvdata(pdev);
 
 	geth_cleanup_freeq(geth);
 	geth->initialized = false;
-
-	return 0;
 }
 
 static const struct of_device_id gemini_ethernet_of_match[] = {
@@ -2607,7 +2603,7 @@ static struct platform_driver gemini_ethernet_driver = {
 		.of_match_table = gemini_ethernet_of_match,
 	},
 	.probe = gemini_ethernet_probe,
-	.remove = gemini_ethernet_remove,
+	.remove_new = gemini_ethernet_remove,
 };
 
 static int __init gemini_ethernet_module_init(void)
-- 
2.40.1



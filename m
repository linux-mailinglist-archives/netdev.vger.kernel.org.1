Return-Path: <netdev+bounces-34797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF747A54BA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597728214A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BEB35897;
	Mon, 18 Sep 2023 20:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD434CEB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8B116
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-0007H1-6h; Mon, 18 Sep 2023 22:42:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-007Ija-Ui; Mon, 18 Sep 2023 22:42:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-002mpL-LC; Mon, 18 Sep 2023 22:42:42 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Shang XiaoJing <shangxiaojing@huawei.com>,
	Qiheng Lin <linqiheng@huawei.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 33/54] net: ethernet: microchip: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:05 +0200
Message-Id: <20230918204227.1316886-34-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3082; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FCdV11DYDYyL6dY0Hsqkxdzx09wH+v64xkJ27D5CxTw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYJJgsxIRriyrLq4N/idIJSZyVNbi+TU/C36 RB61cn9HzaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2CQAKCRCPgPtYfRL+ ThbXB/9ECnM8i1dnLPdBG274xSlAvEX3q5JURXuKsKriY0qIv3bVmzZZkPxvOoy6AeOulGwN6ZF R2VdXgEcaXdyWhi2KKDem+Q0ffoLavZZO0XxLVoiIwb5M5o73E06JJAy+XFwHLG5yPMPD4W23PX tdCbZqmp1KzjBzETepjWV89NSgFvYfiO2B7kbn6wTQ5Lf+lN/6dv68rfSTFqGzTfIbwJubuAOb9 RPA1aHe099b3mniOAL3Szeqwco8fD/ljvA7YaWe8nJn4IKwlfXjqCWHeuJ2e1AGtzmjvo4vP1i1 giSyBY9GkustFIWinQ4ILUufTLmyBbz8Liya1UF6x5+u7sAT
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

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 6 ++----
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c   | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 0d6e79af2410..8e4101628fbd 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1261,7 +1261,7 @@ static int lan966x_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int lan966x_remove(struct platform_device *pdev)
+static void lan966x_remove(struct platform_device *pdev)
 {
 	struct lan966x *lan966x = platform_get_drvdata(pdev);
 
@@ -1280,13 +1280,11 @@ static int lan966x_remove(struct platform_device *pdev)
 	lan966x_ptp_deinit(lan966x);
 
 	debugfs_remove_recursive(lan966x->debugfs_root);
-
-	return 0;
 }
 
 static struct platform_driver lan966x_driver = {
 	.probe = lan966x_probe,
-	.remove = lan966x_remove,
+	.remove_new = lan966x_remove,
 	.driver = {
 		.name = "lan966x-switch",
 		.of_match_table = lan966x_match,
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
index dc9af480bfea..d1f7fc8b1b71 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
@@ -911,7 +911,7 @@ static int mchp_sparx5_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mchp_sparx5_remove(struct platform_device *pdev)
+static void mchp_sparx5_remove(struct platform_device *pdev)
 {
 	struct sparx5 *sparx5 = platform_get_drvdata(pdev);
 
@@ -931,8 +931,6 @@ static int mchp_sparx5_remove(struct platform_device *pdev)
 	/* Unregister netdevs */
 	sparx5_unregister_notifier_blocks(sparx5);
 	destroy_workqueue(sparx5->mact_queue);
-
-	return 0;
 }
 
 static const struct of_device_id mchp_sparx5_match[] = {
@@ -943,7 +941,7 @@ MODULE_DEVICE_TABLE(of, mchp_sparx5_match);
 
 static struct platform_driver mchp_sparx5_driver = {
 	.probe = mchp_sparx5_probe,
-	.remove = mchp_sparx5_remove,
+	.remove_new = mchp_sparx5_remove,
 	.driver = {
 		.name = "sparx5-switch",
 		.of_match_table = mchp_sparx5_match,
-- 
2.40.1



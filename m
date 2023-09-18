Return-Path: <netdev+bounces-34776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F457A5480
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB761C209F9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE4031A7E;
	Mon, 18 Sep 2023 20:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804D030F83
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058C7112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-0007HW-So; Mon, 18 Sep 2023 22:42:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-007Ijg-Ez; Mon, 18 Sep 2023 22:42:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-002mpT-5Y; Mon, 18 Sep 2023 22:42:43 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 35/54] net: ethernet: mscc: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:07 +0200
Message-Id: <20230918204227.1316886-36-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=22evVWLmAieIL0TkeUtwIoAuUdqsBU76Qw6kgaIyxk8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYL0YR9fH1Bq9++n/ivdFt0DxdKdW68fPlIp F9h04n7t+WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2CwAKCRCPgPtYfRL+ Tt2kB/90MC4zv19JjLc5oSmIlXex0qZTGC/YjSBTILY8khPPJxRt7EUNeiOgUfEj9eH98axeJx+ e0J6lm7QIV+5Dmrnqte8aoZjTKxeYb0DNgN5vOEJGT8ubdyIWgwR6mLBnN0yC6ZB1oemEWRjId6 TxKXTbwRs2KJtyJ0vVEJcV7PBBXvZOtbjkkzzo3ZFf1z6izHAOB4+f/aPnelA2ehsZAw6c3VC3Q nd41gJyjnhnpuqbAmt2jbVEV0W0/O16Xv9yGasXu1cyfRqEPkd+3Eca6kYDFzVA2cWnSefvn3cv 2gfhYGXGk8DHb2ImNVCDBdpq/jR9UGVqrb/DWVn9VDTyf0OA
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
 drivers/net/ethernet/mscc/ocelot_vsc7514.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_vsc7514.c b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
index 151b42465348..993212c3a7da 100644
--- a/drivers/net/ethernet/mscc/ocelot_vsc7514.c
+++ b/drivers/net/ethernet/mscc/ocelot_vsc7514.c
@@ -392,7 +392,7 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mscc_ocelot_remove(struct platform_device *pdev)
+static void mscc_ocelot_remove(struct platform_device *pdev)
 {
 	struct ocelot *ocelot = platform_get_drvdata(pdev);
 
@@ -408,13 +408,11 @@ static int mscc_ocelot_remove(struct platform_device *pdev)
 	unregister_switchdev_notifier(&ocelot_switchdev_nb);
 	unregister_netdevice_notifier(&ocelot_netdevice_nb);
 	devlink_free(ocelot->devlink);
-
-	return 0;
 }
 
 static struct platform_driver mscc_ocelot_driver = {
 	.probe = mscc_ocelot_probe,
-	.remove = mscc_ocelot_remove,
+	.remove_new = mscc_ocelot_remove,
 	.driver = {
 		.name = "ocelot-switch",
 		.of_match_table = mscc_ocelot_match,
-- 
2.40.1



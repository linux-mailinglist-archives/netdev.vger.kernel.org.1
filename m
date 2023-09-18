Return-Path: <netdev+bounces-34696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434617A52DD
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE361C20FBB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32C2273F4;
	Mon, 18 Sep 2023 19:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C3B1F5E9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B02F7
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-0002o1-LB; Mon, 18 Sep 2023 21:19:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-007I2U-NM; Mon, 18 Sep 2023 21:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-002m1o-Dt; Mon, 18 Sep 2023 21:19:24 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 3/9] net: dsa: hirschmann: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:10 +0200
Message-Id: <20230918191916.1299418-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GQmQQm3TF8lxaZLT0myTGc4xj1c2ppBZF83ucqsBqsc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKpT50GMVLTYJXRmWY79y231zis0Hzjj1J5X LtwrenuEG6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiiqQAKCRCPgPtYfRL+ TpzmCACgwhe1PHYA8Su79wQwCHXq5XM3jFyPRCIwpg/IsG3EKzBEziHCrMKvFEko7xUGtyWK+ID o48dvinPPnqT5CLYAwHyq2lfLOp+z9SxRz3U5EghZvlEF4EBBTtB7/rS7Tlt5ow2o+q49W7LgWr sYBI5vyfzw70xnWxyIWUPPRU4Doh7RA4xVybw2/3mruZRxx0c3+7sF4trrxTfvxGq5vCuIrutkG h1PB/gvDdoiiA4tenitlDLTw80NisErcBE1e5mThmmq2yGiVPyBkvjSshdPREEeHNq4EXBJZGzd lypjBi54sno6p5eLwmpLWUsseX0qv1E2GnafVOkSZPrFG5fL
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
 drivers/net/dsa/hirschmann/hellcreek.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 11ef1d7ea229..beda1e9d350f 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -2060,18 +2060,16 @@ static int hellcreek_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hellcreek_remove(struct platform_device *pdev)
+static void hellcreek_remove(struct platform_device *pdev)
 {
 	struct hellcreek *hellcreek = platform_get_drvdata(pdev);
 
 	if (!hellcreek)
-		return 0;
+		return;
 
 	hellcreek_hwtstamp_free(hellcreek);
 	hellcreek_ptp_free(hellcreek);
 	dsa_unregister_switch(hellcreek->ds);
-
-	return 0;
 }
 
 static void hellcreek_shutdown(struct platform_device *pdev)
@@ -2107,7 +2105,7 @@ MODULE_DEVICE_TABLE(of, hellcreek_of_match);
 
 static struct platform_driver hellcreek_driver = {
 	.probe	= hellcreek_probe,
-	.remove = hellcreek_remove,
+	.remove_new = hellcreek_remove,
 	.shutdown = hellcreek_shutdown,
 	.driver = {
 		.name = "hellcreek",
-- 
2.40.1



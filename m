Return-Path: <netdev+bounces-34751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 900E77A544B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D0928103D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAA450FF;
	Mon, 18 Sep 2023 20:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F95266D6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55768112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006ii-4Q; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-007Ihj-ET; Mon, 18 Sep 2023 22:42:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-002mnS-4k; Mon, 18 Sep 2023 22:42:35 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH net-next 04/54] net: ethernet: allwinner: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:36 +0200
Message-Id: <20230918204227.1316886-5-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/brLzDs1X8Bi9La4K8zev2mnuxRHEMkq0e27iN0d61o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXpjCQR2Xy6r9GAUU5Slp4iE7VmvuvsDyHWw BKa/uhDBaiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi16QAKCRCPgPtYfRL+ TuFvB/95bAWGago7Ab7zdAK8oFt2UfUEXr13+CjxQG92mOLLsC7zpqs0M5xJk3M8WGh4YPbw1h3 Y2OkP8OfiQO5OLchqnB5dLnq2nvU5d6Jfpt4mVXylIUHN23D1P+ZZVhXPQXlCfvkpkclteNpMGv S8UIekel8klXTQ/kQUBNRBbKsl7Le+a5yAhh1OH/0gBrpKKxecgMMU6EEJLBC+WuwNljMShlpS9 mXIfRRQEZ4vLhBfCXJNRktjjkX7DwZxG9g9MiSCj8iUbUHF9/OZ21aGzjmQ2w6K6P8r3Wf3gqOi +bsVdyIXYhzYFyx9cNe4Ej6jPQeqGvq1xFJrFFFtuUNGm8ra
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
 drivers/net/ethernet/allwinner/sun4i-emac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index a94c62956eed..d761c08fe5c1 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -1083,7 +1083,7 @@ static int emac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int emac_remove(struct platform_device *pdev)
+static void emac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct emac_board_info *db = netdev_priv(ndev);
@@ -1101,7 +1101,6 @@ static int emac_remove(struct platform_device *pdev)
 	free_netdev(ndev);
 
 	dev_dbg(&pdev->dev, "released and freed device\n");
-	return 0;
 }
 
 static int emac_suspend(struct platform_device *dev, pm_message_t state)
@@ -1143,7 +1142,7 @@ static struct platform_driver emac_driver = {
 		.of_match_table = emac_of_match,
 	},
 	.probe = emac_probe,
-	.remove = emac_remove,
+	.remove_new = emac_remove,
 	.suspend = emac_suspend,
 	.resume = emac_resume,
 };
-- 
2.40.1



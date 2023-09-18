Return-Path: <netdev+bounces-34752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABBA7A544C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551C02812EE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550F266D6;
	Mon, 18 Sep 2023 20:42:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C826E09
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:50 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF010F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-0006lh-US; Mon, 18 Sep 2023 22:42:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-007IiG-Gz; Mon, 18 Sep 2023 22:42:37 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-002mny-7N; Mon, 18 Sep 2023 22:42:37 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 12/54] net: ethernet: cadence: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:44 +0200
Message-Id: <20230918204227.1316886-13-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Cfr5BgicrnP5ae9jlixqApXDT7tkbBUn4AnbyQjA/ZM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXyXfacFkoPORYFw2+N92auPvPkw5AcwAlZj s3pGVoaXTeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi18gAKCRCPgPtYfRL+ TgxaB/wOzO3Slz4xx4Eft7azvgkg7yOIeoSmjxmq8dGQPyc6/EwyWtuTskS1DirBhfJRkTO6xqy xRP6lADbZC8JIP5pUJRUqEgZzfCUuRsLfRtRnvHJFp3PPt6iN7d3hhpLCFDkldg6xncYb/oL0L6 J/jbs5C41aefEXtB+lve4FCqOopCtUMXlpU6MZANiTxLWs7Vrex4+BBB9LxSNnmJv6ECFEuRn2w yy3sLfUaVlAEG8B7dxT9YwlowcNpjpoR9fGuv9xi3d5Se3mst+DNkcRNLxWI+5iynlW5GjJDAIp wOAbqBdViMrEOhyDf+gZE2quajUijzfDOfW7CX8wI3kLxeKp
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
 drivers/net/ethernet/cadence/macb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b940dcd3ace6..cebae0f418f2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5156,7 +5156,7 @@ static int macb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int macb_remove(struct platform_device *pdev)
+static void macb_remove(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct macb *bp;
@@ -5181,8 +5181,6 @@ static int macb_remove(struct platform_device *pdev)
 		phylink_destroy(bp->phylink);
 		free_netdev(dev);
 	}
-
-	return 0;
 }
 
 static int __maybe_unused macb_suspend(struct device *dev)
@@ -5398,7 +5396,7 @@ static const struct dev_pm_ops macb_pm_ops = {
 
 static struct platform_driver macb_driver = {
 	.probe		= macb_probe,
-	.remove		= macb_remove,
+	.remove_new	= macb_remove,
 	.driver		= {
 		.name		= "macb",
 		.of_match_table	= of_match_ptr(macb_dt_ids),
-- 
2.40.1



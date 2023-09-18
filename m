Return-Path: <netdev+bounces-34783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5352F7A548F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3981C20F22
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3A934184;
	Mon, 18 Sep 2023 20:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E731A69
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBEF8F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-0007Wj-K2; Mon, 18 Sep 2023 22:42:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-007Ikh-W1; Mon, 18 Sep 2023 22:42:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-002mqR-J9; Mon, 18 Sep 2023 22:42:47 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 50/54] net: ethernet: tundra: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:22 +0200
Message-Id: <20230918204227.1316886-51-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wa14XBoWnIwREl97ONINRSaZIPAUOO//2tBdTAbeqCQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYcGPcKxKp9cxTpFfZStHBVLDMfGHc4CR8TH 0T561c6J6WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2HAAKCRCPgPtYfRL+ Tu5/B/0W1HeuVWazYovBF/5MAs6SotNgYyPc9xvpBO2zLiAjiC6WDl4uMhHTObJb19t4MYv1iZF mh/4coVhmNpoi1VM79RWMY2ofS2avFx/bxYaFNs57FZJLZdy/VAn8QAaIfJI3NC4FSI23WZirSB nvt00/cMiB8EB8Upx/Y89DKt4NDh2b3gmZs9IjCdQkK4s0MZZfEI9oSboQwY9ErtOoWznz4A/H2 RQtGYnkobLNYyqbQNzg6XfG8IaM6RnPwVtAuiWk7pLfBbgb3DaB5/7/nAnaeLBzhxHOFDgvLjTD ZBTj7CLBBwox+7LuBOlVAzsj3vUG5RkYOrmgv5FouNrAnJ5V
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
 drivers/net/ethernet/tundra/tsi108_eth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/tundra/tsi108_eth.c b/drivers/net/ethernet/tundra/tsi108_eth.c
index d09d352e1c0a..554aff7c8f3b 100644
--- a/drivers/net/ethernet/tundra/tsi108_eth.c
+++ b/drivers/net/ethernet/tundra/tsi108_eth.c
@@ -1660,7 +1660,7 @@ static void tsi108_timed_checker(struct timer_list *t)
 	mod_timer(&data->timer, jiffies + CHECK_PHY_INTERVAL);
 }
 
-static int tsi108_ether_remove(struct platform_device *pdev)
+static void tsi108_ether_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct tsi108_prv_data *priv = netdev_priv(dev);
@@ -1670,15 +1670,13 @@ static int tsi108_ether_remove(struct platform_device *pdev)
 	iounmap(priv->regs);
 	iounmap(priv->phyregs);
 	free_netdev(dev);
-
-	return 0;
 }
 
 /* Structure for a device driver */
 
 static struct platform_driver tsi_eth_driver = {
 	.probe = tsi108_init_one,
-	.remove = tsi108_ether_remove,
+	.remove_new = tsi108_ether_remove,
 	.driver	= {
 		.name = "tsi-ethernet",
 	},
-- 
2.40.1



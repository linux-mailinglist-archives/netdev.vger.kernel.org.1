Return-Path: <netdev+bounces-34772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88B7A5476
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE49281AEC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0930FB6;
	Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4D2AB27
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527611C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-0007Jk-TA; Mon, 18 Sep 2023 22:42:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-007Ijz-Ry; Mon, 18 Sep 2023 22:42:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-002mpj-IY; Mon, 18 Sep 2023 22:42:44 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 39/54] net: ethernet: nxp: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:11 +0200
Message-Id: <20230918204227.1316886-40-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=NlzNcrEbMIgR6ZtQJzaOSKjlp/4sQRsw/UzHmRhBu40=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYQvP+txWCYy6bo4tAo8+DcYSb1zIFKdovPX SGS2491XJeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2EAAKCRCPgPtYfRL+ Ttn+B/4nHGW06U2U9Yb7HMhpOQqGc2obFG2H68Se6bHDw9sp35vqszZs5hvgKd62flTRutBvIgU ekMvX4Zjuig64jDFa4VyA4dxHjnNh653fK9sE8qmChEGY//JqW4YudQtmnQRoxXq47aJljjpFgq WQxk7rD+4xJa22VmZFHAn4Xc+SuZHLH4wRF2vrlJXeT5gxlSTP+uTWebTewJvo+B1L0N48t6zlw X/T+83RmNkXRH07UDm3qdGINfTrU4qgm6R/youcUtMHyHCkjeG+8o2+NahBEnvdhHDKcL+d02XW U/k+B5LEGlD40TMw4vWj0tZg8fOti0i4/964wcqlVYt7GBjE
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
 drivers/net/ethernet/nxp/lpc_eth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
index 1a4a272f4c5c..dd3e58a1319c 100644
--- a/drivers/net/ethernet/nxp/lpc_eth.c
+++ b/drivers/net/ethernet/nxp/lpc_eth.c
@@ -1417,7 +1417,7 @@ static int lpc_eth_drv_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int lpc_eth_drv_remove(struct platform_device *pdev)
+static void lpc_eth_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct netdata_local *pldat = netdev_priv(ndev);
@@ -1436,8 +1436,6 @@ static int lpc_eth_drv_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pldat->clk);
 	clk_put(pldat->clk);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1505,7 +1503,7 @@ MODULE_DEVICE_TABLE(of, lpc_eth_match);
 
 static struct platform_driver lpc_eth_driver = {
 	.probe		= lpc_eth_drv_probe,
-	.remove		= lpc_eth_drv_remove,
+	.remove_new	= lpc_eth_drv_remove,
 #ifdef CONFIG_PM
 	.suspend	= lpc_eth_drv_suspend,
 	.resume		= lpc_eth_drv_resume,
-- 
2.40.1



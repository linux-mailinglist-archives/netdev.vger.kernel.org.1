Return-Path: <netdev+bounces-34778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3C7A5483
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F61C209BF
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE431A91;
	Mon, 18 Sep 2023 20:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BB30FA4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F8D115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-0007O2-Ks; Mon, 18 Sep 2023 22:42:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-007IkP-PS; Mon, 18 Sep 2023 22:42:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-002mqB-G2; Mon, 18 Sep 2023 22:42:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jassi Brar <jaswinder.singh@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 46/54] net: ethernet: socionext: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:18 +0200
Message-Id: <20230918204227.1316886-47-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2903; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/9gc0xs4sbly4T5H2ySmtsJ6UvNyolK3OiLiO4bOId8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYYE7j2t2/YVZck/NMSdtxfTVqUjIS4pecwP 0CiLgn/PD6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2GAAKCRCPgPtYfRL+ TpB/CACM9HRt+JmAllbQ0YWR+6/625fPTa+BKfqXYYP5Ez4w3SonMnBX2WR84B4VVlCPt/4uJ7u 0aPty/IIQin5jRcH6CZ5Jt2EHlAozVKCqhDyKe+DcewQN/n4u5hebabqNZFeLsAlgZedccI7say kGoRP4SwZCvoo141eHqAlaVDigG0IutpUFOb9/o+Z+E9qF19Ly0OeaEH4zAjCccvYOPFU6gm17p 0pZX7/TRmwYOr3YD/t/ovGUtudvSpoK0pYlDxh7MrWbuurNvPiOdWL4ovw6dq8YQD+LwHW1kN52 IY/nv/2LExMjqZHaH6CvulENowGSPMuuK2DMxyfx2+SGjRBU
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
 drivers/net/ethernet/socionext/netsec.c  | 6 ++----
 drivers/net/ethernet/socionext/sni_ave.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index f358ea003193..d9cfafb96085 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2150,7 +2150,7 @@ static int netsec_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int netsec_remove(struct platform_device *pdev)
+static void netsec_remove(struct platform_device *pdev)
 {
 	struct netsec_priv *priv = platform_get_drvdata(pdev);
 
@@ -2162,8 +2162,6 @@ static int netsec_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	free_netdev(priv->ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2211,7 +2209,7 @@ MODULE_DEVICE_TABLE(acpi, netsec_acpi_ids);
 
 static struct platform_driver netsec_driver = {
 	.probe	= netsec_probe,
-	.remove	= netsec_remove,
+	.remove_new = netsec_remove,
 	.driver = {
 		.name = "netsec",
 		.pm = &netsec_pm_ops,
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 4838d2383a43..eed24e67c5a6 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1719,7 +1719,7 @@ static int ave_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ave_remove(struct platform_device *pdev)
+static void ave_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct ave_private *priv = netdev_priv(ndev);
@@ -1727,8 +1727,6 @@ static int ave_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	netif_napi_del(&priv->napi_rx);
 	netif_napi_del(&priv->napi_tx);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1976,7 +1974,7 @@ MODULE_DEVICE_TABLE(of, of_ave_match);
 
 static struct platform_driver ave_driver = {
 	.probe  = ave_probe,
-	.remove = ave_remove,
+	.remove_new = ave_remove,
 	.driver	= {
 		.name = "ave",
 		.pm   = AVE_PM_OPS,
-- 
2.40.1



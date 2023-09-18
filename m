Return-Path: <netdev+bounces-34796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A057A54B9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E941C212A3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46611358A6;
	Mon, 18 Sep 2023 20:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6C135897
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E977D10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-0007Ph-1d; Mon, 18 Sep 2023 22:42:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4x-007IkU-26; Mon, 18 Sep 2023 22:42:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-002mqF-OZ; Mon, 18 Sep 2023 22:42:46 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Alex Elder <elder@linaro.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Wei Fang <wei.fang@nxp.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 47/54] net: ethernet: sun: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:19 +0200
Message-Id: <20230918204227.1316886-48-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eNUPWqS3HwsvdRnQwonIfX0MnGa81NyHrfpAAK9T1F8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYZfD2YVSr4iAEonj+Wsse1LfN9wsARYWdiX 1KE5dMYK1qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2GQAKCRCPgPtYfRL+ Tqn3B/9wCcI4Q5uMpeHMBh1d/iCzPUro9K4b8T5Utqhh0xpmRdkj4S2xLRqvhgpf3c5tI3BEDrV XA7t/RQtqFeyXtIrKz+79iQdtlIBlwUWiOZLvnyt1ANOOe/tTbzq1kxpXBiMjtG/GPIne4jlW7s /9cnPeFFHz+t3QLGCUaRplQh2Y05kTHGVSJNi2WpYOGCV/X4UUXRvbpGAOjk4ow2h/pNj33GWPh D+WsaXrvMOQicqle2eYLml3+kJxqzOCcnRiycQOVA6sVJPJJeSVc63FfScIhBeeOiSxLvLJRvko wirckDLRDUANBdcvnQmRkwcbIjNqLuh3uvhwy5TlICGXUN4n
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
 drivers/net/ethernet/sun/niu.c     | 5 ++---
 drivers/net/ethernet/sun/sunbmac.c | 6 ++----
 drivers/net/ethernet/sun/sunqe.c   | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 011d74087f86..21431f43e4c2 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -10132,7 +10132,7 @@ static int niu_of_probe(struct platform_device *op)
 	return err;
 }
 
-static int niu_of_remove(struct platform_device *op)
+static void niu_of_remove(struct platform_device *op)
 {
 	struct net_device *dev = platform_get_drvdata(op);
 
@@ -10165,7 +10165,6 @@ static int niu_of_remove(struct platform_device *op)
 
 		free_netdev(dev);
 	}
-	return 0;
 }
 
 static const struct of_device_id niu_match[] = {
@@ -10183,7 +10182,7 @@ static struct platform_driver niu_of_driver = {
 		.of_match_table = niu_match,
 	},
 	.probe		= niu_of_probe,
-	.remove		= niu_of_remove,
+	.remove_new	= niu_of_remove,
 };
 
 #endif /* CONFIG_SPARC64 */
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index cc34d92d2e3d..16c86b13c185 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -1234,7 +1234,7 @@ static int bigmac_sbus_probe(struct platform_device *op)
 	return bigmac_ether_init(op, qec_op);
 }
 
-static int bigmac_sbus_remove(struct platform_device *op)
+static void bigmac_sbus_remove(struct platform_device *op)
 {
 	struct bigmac *bp = platform_get_drvdata(op);
 	struct device *parent = op->dev.parent;
@@ -1255,8 +1255,6 @@ static int bigmac_sbus_remove(struct platform_device *op)
 			  bp->bblock_dvma);
 
 	free_netdev(net_dev);
-
-	return 0;
 }
 
 static const struct of_device_id bigmac_sbus_match[] = {
@@ -1274,7 +1272,7 @@ static struct platform_driver bigmac_sbus_driver = {
 		.of_match_table = bigmac_sbus_match,
 	},
 	.probe		= bigmac_sbus_probe,
-	.remove		= bigmac_sbus_remove,
+	.remove_new	= bigmac_sbus_remove,
 };
 
 module_platform_driver(bigmac_sbus_driver);
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index b37360f44972..aedd13c94225 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -933,7 +933,7 @@ static int qec_sbus_probe(struct platform_device *op)
 	return qec_ether_init(op);
 }
 
-static int qec_sbus_remove(struct platform_device *op)
+static void qec_sbus_remove(struct platform_device *op)
 {
 	struct sunqe *qp = platform_get_drvdata(op);
 	struct net_device *net_dev = qp->dev;
@@ -948,8 +948,6 @@ static int qec_sbus_remove(struct platform_device *op)
 			  qp->buffers, qp->buffers_dvma);
 
 	free_netdev(net_dev);
-
-	return 0;
 }
 
 static const struct of_device_id qec_sbus_match[] = {
@@ -967,7 +965,7 @@ static struct platform_driver qec_sbus_driver = {
 		.of_match_table = qec_sbus_match,
 	},
 	.probe		= qec_sbus_probe,
-	.remove		= qec_sbus_remove,
+	.remove_new	= qec_sbus_remove,
 };
 
 static int __init qec_init(void)
-- 
2.40.1



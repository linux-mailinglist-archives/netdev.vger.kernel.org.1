Return-Path: <netdev+bounces-34750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A247A544A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0C81C20C07
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9598450F6;
	Mon, 18 Sep 2023 20:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793F1D69E
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FCB8F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006ij-E4; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-007Ihn-ND; Mon, 18 Sep 2023 22:42:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-002mnW-DM; Mon, 18 Sep 2023 22:42:35 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Joyce Ooi <joyce.ooi@intel.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 05/54] net: ethernet: altera: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:37 +0200
Message-Id: <20230918204227.1316886-6-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Sp88t+dNPfPvXPh/0eZ7Jv86PJSLjnxb94QZmtB+6i8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXqixKOKdyPcfMJva/g2JsHyUD2XYNKEu6AH BqRfO52/PqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi16gAKCRCPgPtYfRL+ TqixB/9hAaZ7l3CVNkzqqPM5wnyZBmxM1YHU3DtIOx/EXgcumGu6NlJuqcXXubW8Ym/GYF/xITe 9k7BewSPUSYoWl/sMPftdu6LUN2Ubr5wyVdgbjmh7ayxjfTae80P6AxBDJ7oQeuaYTXI2Ca2J1Z DEjxQsS3cDCqJ5qqRUTs5X+dbO91TcVtWxszF2ocCp0clH6INJgjm7bQmGZlnidFzNQewxkRHfg F3UIMVLe2I5n1ht03WXXw1VH8zrDzq21TuhT1Y9JfO4KOayb2IGwic+ShWkMWN4RhejvxAOeUQq 8DOFfL+f0dqscc9Oiak99C0b//ZLTGjef433SCEwly7tymvD
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
 drivers/net/ethernet/altera/altera_tse_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 2e15800e5310..1b1799985d1d 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1464,7 +1464,7 @@ static int altera_tse_probe(struct platform_device *pdev)
 
 /* Remove Altera TSE MAC device
  */
-static int altera_tse_remove(struct platform_device *pdev)
+static void altera_tse_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct altera_tse_private *priv = netdev_priv(ndev);
@@ -1476,8 +1476,6 @@ static int altera_tse_remove(struct platform_device *pdev)
 	lynx_pcs_destroy(priv->pcs);
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct altera_dmaops altera_dtype_sgdma = {
@@ -1528,7 +1526,7 @@ MODULE_DEVICE_TABLE(of, altera_tse_ids);
 
 static struct platform_driver altera_tse_driver = {
 	.probe		= altera_tse_probe,
-	.remove		= altera_tse_remove,
+	.remove_new	= altera_tse_remove,
 	.suspend	= NULL,
 	.resume		= NULL,
 	.driver		= {
-- 
2.40.1



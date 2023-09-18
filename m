Return-Path: <netdev+bounces-34767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4AF7A5463
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6935C280ACA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7137D30F80;
	Mon, 18 Sep 2023 20:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EBE28DDA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2AB12C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-0006zl-MS; Mon, 18 Sep 2023 22:42:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-007Iij-AL; Mon, 18 Sep 2023 22:42:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-002moQ-11; Mon, 18 Sep 2023 22:42:39 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 19/54] net: ethernet: engleder: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:51 +0200
Message-Id: <20230918204227.1316886-20-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=m1yK9yrKjp2KXFhoFv0erU8bDH720k8hAHf1Dk17Rl8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX6YHe/Eft6GUKuxTPwgqoaShYMwMxP9vaYj AnCuZe+e6aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi1+gAKCRCPgPtYfRL+ TmrWB/4wQlhwcAJDcG0DYiL8/oVi1xysEFD11UMcLYl9eDtTZP6XVr6HG+UnR+dM2OHlbqBJnnR mRuo2wuoP36w7M07r3BglrvFWNEQ3Hu82oqun3IbTAz3Dw174SwKCG0yDturbIJRvLXYQMylQbA orlakCK4OG3Q4xgxx/sv4ALYWLPdfrIPceWx/NDv0a+GCGDHTjTOWMQR8ParH06vC52j7e6d5JS q1Z2bqFe57YCAe+GllBz185zoaKL797+dnPWtdlkrlYaihZ/p/DIEXeJM8Ju3YrL+x3uYxqOKbB 8H5/witiSuKDIZBo9q/6m+o+weAWPe9H6uV6bvUh+8axN75w
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
 drivers/net/ethernet/engleder/tsnep_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index f61bd89734c5..c32c65b20d5d 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2577,7 +2577,7 @@ static int tsnep_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int tsnep_remove(struct platform_device *pdev)
+static void tsnep_remove(struct platform_device *pdev)
 {
 	struct tsnep_adapter *adapter = platform_get_drvdata(pdev);
 
@@ -2593,8 +2593,6 @@ static int tsnep_remove(struct platform_device *pdev)
 		mdiobus_unregister(adapter->mdiobus);
 
 	tsnep_disable_irq(adapter, ECM_INT_ALL);
-
-	return 0;
 }
 
 static const struct of_device_id tsnep_of_match[] = {
@@ -2609,7 +2607,7 @@ static struct platform_driver tsnep_driver = {
 		.of_match_table = tsnep_of_match,
 	},
 	.probe = tsnep_probe,
-	.remove = tsnep_remove,
+	.remove_new = tsnep_remove,
 };
 module_platform_driver(tsnep_driver);
 
-- 
2.40.1



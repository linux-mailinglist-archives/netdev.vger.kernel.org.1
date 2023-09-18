Return-Path: <netdev+bounces-34749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB87A5446
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BAF281592
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB6450EF;
	Mon, 18 Sep 2023 20:42:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F214010
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BA210F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006iY-HJ; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4l-007Ihg-5c; Mon, 18 Sep 2023 22:42:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4k-002mnO-SA; Mon, 18 Sep 2023 22:42:34 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andreas Larsson <andreas@gaisler.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 03/54] net: ethernet: aeroflex: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:35 +0200
Message-Id: <20230918204227.1316886-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=8WXkMNqzG0/9SRJt3MEZXSg9KAXLUFS2ZsUc2zryNWE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXoNqLutMPWbLoSKz3gaWNRAN3R+n9Up6MSc yTMrIoGq+OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi16AAKCRCPgPtYfRL+ TpyWB/wN7O3O6jddQ4jR8XUEjVfiwqrO3gYdEt2I5ki2LQ5zm0ImFfaPh+wsxSFnUJt11xya9ry BemQlKUWwZ/VULOmDKAH+jvoa541FcmDs2eghy5fyBuoYCE7hsojMSG6TiFn8OKk/OYiBj34Zxa AkgeH44y/d8yWf/tYcUj6RWHTK5koHNLXziw8/UQ9scpp5QsaYh4n4ye3nl5O0S2TP7OlT9N2Y9 cZGEwLxHJCrm7/KeVieRdDTlUwBOrnGej2KQmeW57JK6QeygxxgKgaYL7orNuJ7ua2PLFhvAZf5 Zau+Xw1qcBrUzdUAFeOuxIv8koM86St9pdAVn1cg+1AympDi
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
 drivers/net/ethernet/aeroflex/greth.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 597a02c75d52..27af7746d645 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -1525,7 +1525,7 @@ static int greth_of_probe(struct platform_device *ofdev)
 	return err;
 }
 
-static int greth_of_remove(struct platform_device *of_dev)
+static void greth_of_remove(struct platform_device *of_dev)
 {
 	struct net_device *ndev = platform_get_drvdata(of_dev);
 	struct greth_private *greth = netdev_priv(ndev);
@@ -1544,8 +1544,6 @@ static int greth_of_remove(struct platform_device *of_dev)
 	of_iounmap(&of_dev->resource[0], greth->regs, resource_size(&of_dev->resource[0]));
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id greth_of_match[] = {
@@ -1566,7 +1564,7 @@ static struct platform_driver greth_of_driver = {
 		.of_match_table = greth_of_match,
 	},
 	.probe = greth_of_probe,
-	.remove = greth_of_remove,
+	.remove_new = greth_of_remove,
 };
 
 module_platform_driver(greth_of_driver);
-- 
2.40.1



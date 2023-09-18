Return-Path: <netdev+bounces-34762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F17A545D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C028166C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0F28E1D;
	Mon, 18 Sep 2023 20:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9DA28DB2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2F0128
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-000722-Km; Mon, 18 Sep 2023 22:42:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-007Iin-Kn; Mon, 18 Sep 2023 22:42:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-002moV-AM; Mon, 18 Sep 2023 22:42:39 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 20/54] net: ethernet: ethoc: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:52 +0200
Message-Id: <20230918204227.1316886-21-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1872; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=zlgD2JKyU/EZmA+CsWjz0suN7N7ZGlwMW9Q/k3fASQw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX7nhAVESufEuJ/e2Ypiz3+yjAuHIJwmDi1x ftsjmoJcFKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi1+wAKCRCPgPtYfRL+ TpHkB/9yzv7CTXPmPn0ZXiqcmoIUKniiRs2nhFMJI71Fy9ZVM7Mn0IMRHipZsNytx8IQ++olrno Aiy91CKzlJTJdsD6WLZFzU9dktnG9PkLQ5NIk7g5Y60RlNSQIk5EsdFJZgItehtLp6U7RjKyC+h M/KNsigi9N0xViOHylppSDrhgrJ/Uk6Ps7FJCOZjUrE2Gxut/k8m5ml3gYLMGEACxOQ4wLslCKG aATMHNq6CCjlSsGeiGEz78iIjTlfvntJZ630iaMUYrKwci98anDxRdeabt4SQXSILhskqnFd+X9 8rv/EkD32/R1VWST8BDMzo7NpOMSJlSlTE4+cYBb3S8p7k2B
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
 drivers/net/ethernet/ethoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ethoc.c b/drivers/net/ethernet/ethoc.c
index 95cbad198b4b..ad41c9019018 100644
--- a/drivers/net/ethernet/ethoc.c
+++ b/drivers/net/ethernet/ethoc.c
@@ -1254,7 +1254,7 @@ static int ethoc_probe(struct platform_device *pdev)
  * ethoc_remove - shutdown OpenCores ethernet MAC
  * @pdev:	platform device
  */
-static int ethoc_remove(struct platform_device *pdev)
+static void ethoc_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev = platform_get_drvdata(pdev);
 	struct ethoc *priv = netdev_priv(netdev);
@@ -1271,8 +1271,6 @@ static int ethoc_remove(struct platform_device *pdev)
 		unregister_netdev(netdev);
 		free_netdev(netdev);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -1298,7 +1296,7 @@ MODULE_DEVICE_TABLE(of, ethoc_match);
 
 static struct platform_driver ethoc_driver = {
 	.probe   = ethoc_probe,
-	.remove  = ethoc_remove,
+	.remove_new = ethoc_remove,
 	.suspend = ethoc_suspend,
 	.resume  = ethoc_resume,
 	.driver  = {
-- 
2.40.1



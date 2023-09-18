Return-Path: <netdev+bounces-34754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 454DD7A544E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B5F1C2074E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75E426E09;
	Mon, 18 Sep 2023 20:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCD27730
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBC115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-0007HP-Ha; Mon, 18 Sep 2023 22:42:44 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-007Ijd-88; Mon, 18 Sep 2023 22:42:43 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-002mpP-Uk; Mon, 18 Sep 2023 22:42:42 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 34/54] net: ethernet: moxa:: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:06 +0200
Message-Id: <20230918204227.1316886-35-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wXOI6S47J5dHS/U5QseF9XA6nO3sTVZA3dGFoZk8jZg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYKLPAT+UFm7FybbH8mJErgdNRFv45EOe8mk LYRVI4vYtmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2CgAKCRCPgPtYfRL+ Thb0B/9niYDndyPWxpgqPLGIZFh4fGaYddG/zFiN1HEM8z2NvFR0OBJ6g/fQmfdqi0VEQOwKPZ1 Xz0yCR9ztML41bw6SfXB+qJ+gXtbSm//OL66km0/Vf6z2rztFIUzilqk77k8BnzRaYuISDyRQ8e lyaYc9HPSIHSYDmBnS+uXGTgn3FAXrZ2OipMjSs/5DNgZYjNsiyk9ZRVyaEcLXgUxI5+MaLlfr/ CcV7jMhYYveMcD0O8nZlsIxNPdowOI6Jd82CmRxlX9ovFAc3Vd+1OG1iwDN6dOZKiNX1+8iY1vQ +nyJOS6zkoCeJtXR0JjdKJqMuqKrkKfKyglBdAFrlrAGHwen
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
 drivers/net/ethernet/moxa/moxart_ether.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 3da99b62797d..96dc69e7141f 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -558,7 +558,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int moxart_remove(struct platform_device *pdev)
+static void moxart_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
@@ -566,8 +566,6 @@ static int moxart_remove(struct platform_device *pdev)
 	devm_free_irq(&pdev->dev, ndev->irq, ndev);
 	moxart_mac_free_memory(ndev);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id moxart_mac_match[] = {
@@ -578,7 +576,7 @@ MODULE_DEVICE_TABLE(of, moxart_mac_match);
 
 static struct platform_driver moxart_mac_driver = {
 	.probe	= moxart_mac_probe,
-	.remove	= moxart_remove,
+	.remove_new = moxart_remove,
 	.driver	= {
 		.name		= "moxart-ethernet",
 		.of_match_table	= moxart_mac_match,
-- 
2.40.1



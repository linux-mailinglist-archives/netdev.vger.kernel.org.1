Return-Path: <netdev+bounces-34781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27107A5487
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71BF1C20849
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3D328AB;
	Mon, 18 Sep 2023 20:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250131A62
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C31E10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-00073z-Ab; Mon, 18 Sep 2023 22:42:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-007Iiq-Rs; Mon, 18 Sep 2023 22:42:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-002moZ-Ig; Mon, 18 Sep 2023 22:42:39 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Paul Fertser <fercerpav@gmail.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sergei Antonov <saproj@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 21/54] net: ethernet: faraday: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:53 +0200
Message-Id: <20230918204227.1316886-22-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2985; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ncYvWGWYqtGYOyBbzDJL2m1y2tPA950RnnBcBOlwpgE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX8HDtRoWYOxOJPmcbZPM+xpCtTl322yJoCq OEt0llZSXiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi1/AAKCRCPgPtYfRL+ TjqKB/9R9ihPoLaBGIkvCFL9Pp8jmD+EUjkeSpqvh5unKy/BgrIXNmFNEjKwKT1F/OHpjTDnG3M ZZ8hDbmh3PSpHwx5EvEgcBfN5lmOr/7d1slBdV6kHBl+g2/fuAZ4nWA8urET+/uwjud72etjLjY iUe3k+GhX7KlOM8JnHMeSbsx8ImUlpK6T80GyJmm9s7lvN942CSJdb91M/vwTkjAN1pBrGaviWA 3j4SS+8Kab6SjBoubUCgxj0i1GrUHuqYc55a92j9TkX8jQ8f6W/oxzbC1AEcVNrPa+wJJ+FnZ2C 6pkrMXh1XQbE22fpWw53pM9Z6xNLUAuupZ/t6hPpdh9acjYI
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
 drivers/net/ethernet/faraday/ftgmac100.c | 5 ++---
 drivers/net/ethernet/faraday/ftmac100.c  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 9135b918dd49..fddfd1dd5070 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -2012,7 +2012,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ftgmac100_remove(struct platform_device *pdev)
+static void ftgmac100_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev;
 	struct ftgmac100 *priv;
@@ -2040,7 +2040,6 @@ static int ftgmac100_remove(struct platform_device *pdev)
 
 	netif_napi_del(&priv->napi);
 	free_netdev(netdev);
-	return 0;
 }
 
 static const struct of_device_id ftgmac100_of_match[] = {
@@ -2051,7 +2050,7 @@ MODULE_DEVICE_TABLE(of, ftgmac100_of_match);
 
 static struct platform_driver ftgmac100_driver = {
 	.probe	= ftgmac100_probe,
-	.remove	= ftgmac100_remove,
+	.remove_new = ftgmac100_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.of_match_table	= ftgmac100_of_match,
diff --git a/drivers/net/ethernet/faraday/ftmac100.c b/drivers/net/ethernet/faraday/ftmac100.c
index 183069581bc0..003bc9a45c65 100644
--- a/drivers/net/ethernet/faraday/ftmac100.c
+++ b/drivers/net/ethernet/faraday/ftmac100.c
@@ -1219,7 +1219,7 @@ static int ftmac100_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ftmac100_remove(struct platform_device *pdev)
+static void ftmac100_remove(struct platform_device *pdev)
 {
 	struct net_device *netdev;
 	struct ftmac100 *priv;
@@ -1234,7 +1234,6 @@ static int ftmac100_remove(struct platform_device *pdev)
 
 	netif_napi_del(&priv->napi);
 	free_netdev(netdev);
-	return 0;
 }
 
 static const struct of_device_id ftmac100_of_ids[] = {
@@ -1244,7 +1243,7 @@ static const struct of_device_id ftmac100_of_ids[] = {
 
 static struct platform_driver ftmac100_driver = {
 	.probe		= ftmac100_probe,
-	.remove		= ftmac100_remove,
+	.remove_new	= ftmac100_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.of_match_table = ftmac100_of_ids
-- 
2.40.1



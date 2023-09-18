Return-Path: <netdev+bounces-34788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 014797A54AB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4B8282016
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEE4328C6;
	Mon, 18 Sep 2023 20:43:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C7341AB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E243115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-0006wH-GB; Mon, 18 Sep 2023 22:42:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-007Iia-Uh; Mon, 18 Sep 2023 22:42:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-002moJ-KO; Mon, 18 Sep 2023 22:42:38 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wei Fang <wei.fang@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Nathan Huckleberry <nhuck@google.com>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 17/54] net: ethernet: davicom: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:49 +0200
Message-Id: <20230918204227.1316886-18-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tEBu7jnlxEXG0ygWZxel1V+/nRZwKfzp9nIiPQrfaM0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLX34lyKDeZdmY67MKoqAgFbHgd4ZC6Eu5d4D raXq9CsKjuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi19wAKCRCPgPtYfRL+ TsEWCACBMQoDyXNw3EQ+iS2WoXAuEa8zEtD9z8rNrFDblgIhcndO+odrH5cf2Q5nT5b8j0FJVG4 7T9duihOT2KrqT0VvmKVrj1DSYYCskHYLldnO9O7DMjqduoRoQUf7MifJX2xEihRzASoXpliUYd OnoeO0dNMknkzv5uaoAtnkw8G4E2T1P3dM94G/uy/mdEfi4IAZ5SPKpfZx7RgrLShXwlruRYzcj jv2t5qLc6GPKsxCE+L8/Zc1RkH15fTRZh9SdrekMf7tK9RGf9DhCNnQxFdlRRgpiwflKTxUwSw5 KkjTozm8HEwyVtozonTUEzSPQby7kC9qOzXoAg5rErITaPL5
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
 drivers/net/ethernet/davicom/dm9000.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 05a89ab6766c..150cc94ae9f8 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1770,8 +1770,7 @@ static const struct dev_pm_ops dm9000_drv_pm_ops = {
 	.resume		= dm9000_drv_resume,
 };
 
-static int
-dm9000_drv_remove(struct platform_device *pdev)
+static void dm9000_drv_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct board_info *dm = to_dm9000_board(ndev);
@@ -1783,7 +1782,6 @@ dm9000_drv_remove(struct platform_device *pdev)
 		regulator_disable(dm->power_supply);
 
 	dev_dbg(&pdev->dev, "released and freed device\n");
-	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -1801,7 +1799,7 @@ static struct platform_driver dm9000_driver = {
 		.of_match_table = of_match_ptr(dm9000_of_matches),
 	},
 	.probe   = dm9000_probe,
-	.remove  = dm9000_drv_remove,
+	.remove_new = dm9000_drv_remove,
 };
 
 module_platform_driver(dm9000_driver);
-- 
2.40.1



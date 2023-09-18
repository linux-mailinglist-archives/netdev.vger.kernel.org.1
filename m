Return-Path: <netdev+bounces-34770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F097A546C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759061C204D6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC830F95;
	Mon, 18 Sep 2023 20:42:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B9628E36
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818B38F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4n-0006ke-6G; Mon, 18 Sep 2023 22:42:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-007Ii2-N0; Mon, 18 Sep 2023 22:42:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-002mnm-De; Mon, 18 Sep 2023 22:42:36 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH net-next 09/54] net: ethernet: arc: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:41 +0200
Message-Id: <20230918204227.1316886-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=rYsQlnU4Zpdy+1FCQVNsYjaerpegxcHny3CbdTGErvU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXuXjW2oGENYdmI6sEhfokUmb+RNb6H0vrWP 5gcBjUooP6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi17gAKCRCPgPtYfRL+ TjECB/0dP7YUtvYCnAJ7Tq9beTJ4KxL+9Om6TuE9RAKtvlRBUEq+Zs58P5xE4064WMq+77fpLLX uro2dBIaIC/dQC6YUQEGm2uN6wbMEb6rE6onpSKh0kTcmmjG0fsLa2zzvR2YP72O2Bi6ZlHQLX6 fiP37LojrVBYW8W3PtpW9qY1hqat6DH2M5dQEmbHSgnYhxYJa469AAknFTQ+IIqjBLNEcevOR8H tI0bY9PiXjUOWoKy8e+ulrGsLzK45n6adzE7ibxKHj2rwhqVEVx0+5V3ELw/4PqnHJKnokXtFAt 5NLFylv5phTtR38Tl82bpynW+BW+dcq8pozkqqhqr13U1xki
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
 drivers/net/ethernet/arc/emac_arc.c      | 6 ++----
 drivers/net/ethernet/arc/emac_rockchip.c | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/arc/emac_arc.c b/drivers/net/ethernet/arc/emac_arc.c
index ce3147e886a1..a3afddb23ee8 100644
--- a/drivers/net/ethernet/arc/emac_arc.c
+++ b/drivers/net/ethernet/arc/emac_arc.c
@@ -58,14 +58,12 @@ static int emac_arc_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int emac_arc_remove(struct platform_device *pdev)
+static void emac_arc_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	arc_emac_remove(ndev);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id emac_arc_dt_ids[] = {
@@ -76,7 +74,7 @@ MODULE_DEVICE_TABLE(of, emac_arc_dt_ids);
 
 static struct platform_driver emac_arc_driver = {
 	.probe = emac_arc_probe,
-	.remove = emac_arc_remove,
+	.remove_new = emac_arc_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table  = emac_arc_dt_ids,
diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
index 509101112279..493d6356c8ca 100644
--- a/drivers/net/ethernet/arc/emac_rockchip.c
+++ b/drivers/net/ethernet/arc/emac_rockchip.c
@@ -244,7 +244,7 @@ static int emac_rockchip_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int emac_rockchip_remove(struct platform_device *pdev)
+static void emac_rockchip_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct rockchip_priv_data *priv = netdev_priv(ndev);
@@ -260,12 +260,11 @@ static int emac_rockchip_remove(struct platform_device *pdev)
 		clk_disable_unprepare(priv->macclk);
 
 	free_netdev(ndev);
-	return 0;
 }
 
 static struct platform_driver emac_rockchip_driver = {
 	.probe = emac_rockchip_probe,
-	.remove = emac_rockchip_remove,
+	.remove_new = emac_rockchip_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table  = emac_rockchip_dt_ids,
-- 
2.40.1



Return-Path: <netdev+bounces-48572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D47EEE40
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BEE1B20A5A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AED10A25;
	Fri, 17 Nov 2023 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF6D4D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:17:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-0007hH-Q2; Fri, 17 Nov 2023 10:17:14 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-009e6T-CI; Fri, 17 Nov 2023 10:17:14 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3uyQ-002yJv-3G; Fri, 17 Nov 2023 10:17:14 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: 
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Rob Herring <robh@kernel.org>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 7/7] net: ethernet: ezchip: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:17:03 +0100
Message-ID: <20231117091655.872426-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
References: <20231117091655.872426-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WCsH3AMo/doRPWS4MbdyGRufJOyZqp9N04kNPeC/Gik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVy+PV6v2I6EmNxRvcipcDEJ99dfcKTYnDgtlb 3D2ierZF62JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVcvjwAKCRCPgPtYfRL+ Tn27B/wN7nxid4K7vbgw/2MDnGz8u/TrBtAQubQ/5pTOGLEB9cWB+TYr70GEGt06sqxx2TLcZNW DxsSjahBCYUb6t/N1Nfqa8RzEGJuIfuxMERnPe1HWJyGpwfJ2mL0ie97hXIsx2m/h6SxBsaWqAW HuGWKgqg6XM8kHBGzvIJ/cadUgkLd4RYBuLzc63BQ11mCS2AKAEYbpDNuQOcl89pA5FrL1b5a1R 3c/oEt6A+JZAfy4vtS19+r1paaOtiwRe3dCp1zTF2Ygx2VrHntzBH68Hi9YP8qUEEJa8mLuuR02 ce/Is+SbUBE/NQfJeMvcb65s4hoLt6ZE0nKRUwCTzLeItYwI
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ethernet/ezchip/nps_enet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 4d7184d46824..07c2b701b5fa 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -633,7 +633,7 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 	return err;
 }
 
-static s32 nps_enet_remove(struct platform_device *pdev)
+static void nps_enet_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct nps_enet_priv *priv = netdev_priv(ndev);
@@ -641,8 +641,6 @@ static s32 nps_enet_remove(struct platform_device *pdev)
 	unregister_netdev(ndev);
 	netif_napi_del(&priv->napi);
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static const struct of_device_id nps_enet_dt_ids[] = {
@@ -653,7 +651,7 @@ MODULE_DEVICE_TABLE(of, nps_enet_dt_ids);
 
 static struct platform_driver nps_enet_driver = {
 	.probe = nps_enet_probe,
-	.remove = nps_enet_remove,
+	.remove_new = nps_enet_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table  = nps_enet_dt_ids,
-- 
2.42.0



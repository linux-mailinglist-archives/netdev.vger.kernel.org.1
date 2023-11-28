Return-Path: <netdev+bounces-51782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD66F7FC05F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0741C20DA1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3427C5E0B4;
	Tue, 28 Nov 2023 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030601B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 09:38:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822i-00064T-ME; Tue, 28 Nov 2023 18:38:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822g-00CECl-NC; Tue, 28 Nov 2023 18:38:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r822g-00AIhl-Dn; Tue, 28 Nov 2023 18:38:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Wei Fang <wei.fang@nxp.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 4/4] net: ethernet: ezchip: Convert to platform remove callback returning void
Date: Tue, 28 Nov 2023 18:38:28 +0100
Message-ID: <20231128173823.867512-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231128173823.867512-1-u.kleine-koenig@pengutronix.de>
References: <20231128173823.867512-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WCsH3AMo/doRPWS4MbdyGRufJOyZqp9N04kNPeC/Gik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlZiWUV6v2I6EmNxRvcipcDEJ99dfcKTYnDgtlb 3D2ierZF62JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWYllAAKCRCPgPtYfRL+ Ts2tCACWtYDOpaQWd3qkHjGEkwEmctfr8LmpvWrCCx67xjhDXobcoJtCCv9NBNcLtVxKlVDgAq6 VTFw57rRrUtqqh63hsO9yZQMjwBf5okOjEIaT2XI/mOIzphaol0T5yMZo8Iot8nScFN8RI8Xqri e0YoUWacv1eDHY7b9mcPn1Ig5KLPAlID5/WKQ2wvuRfNWJoDv9GnXYWO43M4Nqm+GNo4nD9cX8L UuKAB4rT5NakcA1o5mFzRInkla6uyfDmXNx5C4HhByLzmgprn99lWKfRJaQ7MzOp1KG6frRG/JR tYT/9kYn/nPzvDvIJKKHsJvk98VeSNWahimVWk6aSduQHau8
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



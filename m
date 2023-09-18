Return-Path: <netdev+bounces-34704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6447A52F7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE8851C20D23
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF2A27EEF;
	Mon, 18 Sep 2023 19:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949827EE4
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536AB10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmK-0002o3-7g; Mon, 18 Sep 2023 21:19:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-007I2a-6K; Mon, 18 Sep 2023 21:19:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-002m1w-Sq; Mon, 18 Sep 2023 21:19:24 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 5/9] net: dsa: mt7530: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:12 +0200
Message-Id: <20230918191916.1299418-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1765; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=nO1JWmSop0L3veRkZxK9FkMgjch0he5qMND8E1/M8rk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKsVuBOwhhRc+2qQ1z6c9j3R2PGT592utBCs T+D0rcKz0GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiirAAKCRCPgPtYfRL+ TnYCCACYBOI5eMvlX1tSsKtJ7iSGZj0yp5ZSBreERbC1/sXAjGBclH7MRs2BXhRYYCkUXYLUseU W54pSAcSLJNzQyEral5s5L54GTbJgPBMmcFJJ4gNAsFgj8uEpA0I5yULuky0+xCB4DXkWiRVUS4 FACHjbnYHahpOI8ZE+pCbLssgL2+xxsdMb79HuujSLJzJDPzdcTir+2wUp8gDNbdaWTDnUZst2s vYUM7wnhzqiuTGJq4sPHE9HcrOO1vxdIhISUq4AOE7lJRkVl9wqcKSPRXRAAMnAB2SucPbUrRsJ 2lIPuDbSxpctjqqZM4nOgmvt4Z2387pgbsTR0273AU/ba4XX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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
 drivers/net/dsa/mt7530-mmio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index 0a6a2fe34e64..b74a230a3f13 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -63,15 +63,12 @@ mt7988_probe(struct platform_device *pdev)
 	return dsa_register_switch(priv->ds);
 }
 
-static int
-mt7988_remove(struct platform_device *pdev)
+static void mt7988_remove(struct platform_device *pdev)
 {
 	struct mt7530_priv *priv = platform_get_drvdata(pdev);
 
 	if (priv)
 		mt7530_remove_common(priv);
-
-	return 0;
 }
 
 static void mt7988_shutdown(struct platform_device *pdev)
@@ -88,7 +85,7 @@ static void mt7988_shutdown(struct platform_device *pdev)
 
 static struct platform_driver mt7988_platform_driver = {
 	.probe  = mt7988_probe,
-	.remove = mt7988_remove,
+	.remove_new = mt7988_remove,
 	.shutdown = mt7988_shutdown,
 	.driver = {
 		.name = "mt7530-mmio",
-- 
2.40.1



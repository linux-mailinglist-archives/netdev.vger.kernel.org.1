Return-Path: <netdev+bounces-34701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE2A7A52E5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B4281DE0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1E27724;
	Mon, 18 Sep 2023 19:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDBC273F2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E7111
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmI-0002oT-8j; Mon, 18 Sep 2023 21:19:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-007I2g-Jp; Mon, 18 Sep 2023 21:19:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-002m24-AH; Mon, 18 Sep 2023 21:19:25 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 7/9] net: dsa: realtek: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:14 +0200
Message-Id: <20230918191916.1299418-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iK3BmQjJkWOMIFKZCHM8yW7ZW3YftPwlpPY4/uZATmA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKKuRSzdYeY7+3Lw0N/t0mr1avEzzMTIUIs0L /XiCyRyT5yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiirgAKCRCPgPtYfRL+ TggRB/0TSKF6AfgrmeAfVmZhxpb0rkTJhBJ747SykkwWh4cfy+J9SsP3YHhor0sBLgePclbOLAr 3OJpgkR/k5+FHhD0BgmPLWJnFWKaWKCK6jct/5ZPknPI/Z5/brK0DtZHdyx1mcyRjbRu3jLSCtb hl7ixJEHZ+jVClej09VOfsDuHYBk3z8tc1zF+le54p+Ge48rQCtqimijEshjVEd5Qh8z4mOmKTM w19jhtm403bVdvku9RUr5THaXqAm65YvNwJg4NHRSh/cNcD/m2jdZv1slTI+R6ISxeCngxwxDUL vClsX8WnetKwCg4iBCM287rF+EbcVFIELNc0kGFd3X5Jrkjt
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
 drivers/net/dsa/realtek/realtek-smi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index ff13563059c5..bfd11591faf4 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -506,12 +506,12 @@ static int realtek_smi_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int realtek_smi_remove(struct platform_device *pdev)
+static void realtek_smi_remove(struct platform_device *pdev)
 {
 	struct realtek_priv *priv = platform_get_drvdata(pdev);
 
 	if (!priv)
-		return 0;
+		return;
 
 	dsa_unregister_switch(priv->ds);
 	if (priv->slave_mii_bus)
@@ -520,8 +520,6 @@ static int realtek_smi_remove(struct platform_device *pdev)
 	/* leave the device reset asserted */
 	if (priv->reset)
 		gpiod_set_value(priv->reset, 1);
-
-	return 0;
 }
 
 static void realtek_smi_shutdown(struct platform_device *pdev)
@@ -559,7 +557,7 @@ static struct platform_driver realtek_smi_driver = {
 		.of_match_table = realtek_smi_of_match,
 	},
 	.probe  = realtek_smi_probe,
-	.remove = realtek_smi_remove,
+	.remove_new = realtek_smi_remove,
 	.shutdown = realtek_smi_shutdown,
 };
 module_platform_driver(realtek_smi_driver);
-- 
2.40.1



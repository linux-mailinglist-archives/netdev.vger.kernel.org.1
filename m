Return-Path: <netdev+bounces-34711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F9A7A5348
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E856B281F5C
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677A27EC6;
	Mon, 18 Sep 2023 19:51:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C191CAB9
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:27 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB48F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-0003kO-PL; Mon, 18 Sep 2023 21:51:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH7-007I8W-To; Mon, 18 Sep 2023 21:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH7-002mCA-Jm; Mon, 18 Sep 2023 21:51:17 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/19] net: mdio: bcm-unimac: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:46 +0200
Message-Id: <20230918195102.1302746-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
References: <20230918195102.1302746-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=H1NiB/erDsanzSmLc7kgYHyi3+QZdqx9CiVgqb8zgCo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoCXwJzqqcLSLM8g2ttOEMGsP8vURHQfl2P7 WxS+ETwTjSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqAgAKCRCPgPtYfRL+ TqlXB/4rYSwVtTPMP7SsF2DbRSI+mT9eQ6BHFfDqMc1rZTgX8bSV/mlJbbfqI/i2CX4Z2B09WhI DwPhWB55DDCqsiqvL58tDN2+fY63QkJKZC/R0xfHsvc6fCD5wxe1YfKqY2Fs7tDM+Y0UjdOUMKB PgySOjW4d6k7xfU1JiJIIaSqE/v6r2pVyBZexi6HY9Tt6nxze5ZBtFRjcqqC4EBZPXU3IzNP9Bp qcP/Mw9fz2SXPyhjMyiy5weOGkYX+m+thCDh/MlCp3NokL5/l81mqqoMGeH0umdRZqVc+23ejr8 bNBUnckwLuqyFTDiJeDhow6iQCJGeL0iwwgGDBiPDMrh39EI
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
 drivers/net/mdio/mdio-bcm-unimac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 6b26a0803696..e8cd8eef319b 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -296,15 +296,13 @@ static int unimac_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int unimac_mdio_remove(struct platform_device *pdev)
+static void unimac_mdio_remove(struct platform_device *pdev)
 {
 	struct unimac_mdio_priv *priv = platform_get_drvdata(pdev);
 
 	mdiobus_unregister(priv->mii_bus);
 	mdiobus_free(priv->mii_bus);
 	clk_disable_unprepare(priv->clk);
-
-	return 0;
 }
 
 static int __maybe_unused unimac_mdio_suspend(struct device *d)
@@ -353,7 +351,7 @@ static struct platform_driver unimac_mdio_driver = {
 		.pm = &unimac_mdio_pm_ops,
 	},
 	.probe	= unimac_mdio_probe,
-	.remove	= unimac_mdio_remove,
+	.remove_new = unimac_mdio_remove,
 };
 module_platform_driver(unimac_mdio_driver);
 
-- 
2.40.1



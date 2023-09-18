Return-Path: <netdev+bounces-34712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A123D7A5350
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5AD281FF2
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951DB27ED5;
	Mon, 18 Sep 2023 19:51:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80726E0A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B009B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-0003kP-Gd; Mon, 18 Sep 2023 21:51:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-007I8Z-3S; Mon, 18 Sep 2023 21:51:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH7-002mCE-QD; Mon, 18 Sep 2023 21:51:17 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/19] net: mdio: gpio: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:47 +0200
Message-Id: <20230918195102.1302746-5-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=0fNciZ2Ogo3cRtSdHu7jp42q5VnQbmOVsBeR1IsGiJU=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoDKN2oRdQbFtSgbfoqfsLkF7IUlYn8fcDwA asJQQvjP4yJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqAwAKCRCPgPtYfRL+ Tr0jB/ik+LJiTWaMBLvw+6/R08c4EbPKLgRS8hCo7Y7iEhw+l4I26e13xz57D0EnbjMDeTRQVlR VD+LXfdocThsnzCVKo2SBC/IORQCZby7B4AE5fePa0yhHXdfrJTu3ZfbpkgJYyb8MGLtVzcOCwR FoOu+w8lbJm+eDokkardtEVPji4h+0EmjscmS8Mvv3uweKYW5HBoPHoITXJwnEOEKTTebQfvNX4 wfmrQqs49aJZploLjzhDRU3mT5UmEaPca6NDRyfnnkaCqE5DQCgxLeqFCzv5zeojly1TO4pN5Bt 8K20npHnzy1AaZCi0INjAPWUZYVI48/xJTlpuhfX9Lh5bd0=
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
 drivers/net/mdio/mdio-gpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 0fb3c2de0845..897b88c50bbb 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -194,11 +194,9 @@ static int mdio_gpio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mdio_gpio_remove(struct platform_device *pdev)
+static void mdio_gpio_remove(struct platform_device *pdev)
 {
 	mdio_gpio_bus_destroy(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id mdio_gpio_of_match[] = {
@@ -210,7 +208,7 @@ MODULE_DEVICE_TABLE(of, mdio_gpio_of_match);
 
 static struct platform_driver mdio_gpio_driver = {
 	.probe = mdio_gpio_probe,
-	.remove = mdio_gpio_remove,
+	.remove_new = mdio_gpio_remove,
 	.driver		= {
 		.name	= "mdio-gpio",
 		.of_match_table = mdio_gpio_of_match,
-- 
2.40.1



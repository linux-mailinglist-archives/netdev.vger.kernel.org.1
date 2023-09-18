Return-Path: <netdev+bounces-34717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7237A5363
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9527C1C20994
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68122869D;
	Mon, 18 Sep 2023 19:51:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5027EEA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E2115
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHA-0003tL-C7; Mon, 18 Sep 2023 21:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH9-007I95-VJ; Mon, 18 Sep 2023 21:51:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH9-002mCk-M5; Mon, 18 Sep 2023 21:51:19 +0200
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
Subject: [PATCH net-next 12/19] net: mdio: mux-gpio: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:55 +0200
Message-Id: <20230918195102.1302746-13-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=hQqRNV8NsCd4cBul46DdSDBZQJNVvAuFrQayXN//utY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoOwxkwQFWAkwvVquicdsXySMLhBTb7umS07 Os3/QW54DyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqDgAKCRCPgPtYfRL+ ThfrB/4gxxOgjOJ8EtCV/RM63KVb5TugxUI10+z/PiyrPUM8rYtn4wjMlFImlITihxAAhNu0sqq v2DeaR0GE/EI9Vx84zkgyLVOmYFWa+FT5VN1Fm8EkqNZFfnj/ND3NAF2zxo4R4h5ds+avN12Ts1 VGhtQ+uSTyzpOQ4Hrro7wiEk9cq+LD2ydfHoCmBbNtylbx7DoZi30X5eEMIfuwL29JCZlVRwBD0 Cwz5EQpmQLAESKhhJHBdrpwHxKyNX9iCfYTth12y5vBBiLwis/D0wBMeBm+d1RhYQlq0InXJVNH n1t0SC9Ph1DGBstl0aBnKOmlYS4zV7SmxKsrvNyWnwGkDDVU
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
 drivers/net/mdio/mdio-mux-gpio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-gpio.c b/drivers/net/mdio/mdio-mux-gpio.c
index 3c7f16f06b45..38fb031f8979 100644
--- a/drivers/net/mdio/mdio-mux-gpio.c
+++ b/drivers/net/mdio/mdio-mux-gpio.c
@@ -62,11 +62,10 @@ static int mdio_mux_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mdio_mux_gpio_remove(struct platform_device *pdev)
+static void mdio_mux_gpio_remove(struct platform_device *pdev)
 {
 	struct mdio_mux_gpio_state *s = dev_get_platdata(&pdev->dev);
 	mdio_mux_uninit(s->mux_handle);
-	return 0;
 }
 
 static const struct of_device_id mdio_mux_gpio_match[] = {
@@ -87,7 +86,7 @@ static struct platform_driver mdio_mux_gpio_driver = {
 		.of_match_table = mdio_mux_gpio_match,
 	},
 	.probe		= mdio_mux_gpio_probe,
-	.remove		= mdio_mux_gpio_remove,
+	.remove_new	= mdio_mux_gpio_remove,
 };
 
 module_platform_driver(mdio_mux_gpio_driver);
-- 
2.40.1



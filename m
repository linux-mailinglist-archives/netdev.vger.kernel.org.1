Return-Path: <netdev+bounces-34720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B17A5366
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1981A1C20B23
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF9827EFC;
	Mon, 18 Sep 2023 19:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975792868B
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CD10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHA-0003tb-JB; Mon, 18 Sep 2023 21:51:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHA-007I99-5V; Mon, 18 Sep 2023 21:51:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH9-002mCo-SC; Mon, 18 Sep 2023 21:51:19 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 13/19] net: mdio: mux-meson-g12a: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:56 +0200
Message-Id: <20230918195102.1302746-14-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EzJFBBjWak83XqZfwXAmsPeATMXEasxL4vEIaynihO4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoPKfUwDQDhH8du0OvFGHGy/cy/8NHJo8l/V BExs0+U2kmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqDwAKCRCPgPtYfRL+ TnypCACUDyS5DHFzFzNuBt/1GnxBHxRj+FItq3pn9j1bAuTt0BtINBnJ2FVOxKZ+HWIeM5lgJXy G1MK3iGEBVHvLVu6TLS8UpA8aJ5rUdfFO3KyFKmViyoLkQpusyo4wqA9wj0QSdZ5wk/jDXrHivX cgIYGngVkHSzlzeMTA8nJNmdcDDQHc4g5iJ9fzVmJODorwn06JAs7ttSAbkRsqQU6kGicXkCcLU dN5nz/WyYw8xn3PgbaN9bGDo1kfVAwTDN3Tm6VW5zVS4ief9o7IcZ+66f5i9W5oxUIjQoC5Z+tJ Jk5GHCetMEO5hxLCA1MdOapxlaZcEa7htdOFyd+X5q7ze+ZL
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
 drivers/net/mdio/mdio-mux-meson-g12a.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux-meson-g12a.c b/drivers/net/mdio/mdio-mux-meson-g12a.c
index 910e5cf74e89..754b0f2cf15b 100644
--- a/drivers/net/mdio/mdio-mux-meson-g12a.c
+++ b/drivers/net/mdio/mdio-mux-meson-g12a.c
@@ -336,7 +336,7 @@ static int g12a_mdio_mux_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int g12a_mdio_mux_remove(struct platform_device *pdev)
+static void g12a_mdio_mux_remove(struct platform_device *pdev)
 {
 	struct g12a_mdio_mux *priv = platform_get_drvdata(pdev);
 
@@ -344,13 +344,11 @@ static int g12a_mdio_mux_remove(struct platform_device *pdev)
 
 	if (__clk_is_enabled(priv->pll))
 		clk_disable_unprepare(priv->pll);
-
-	return 0;
 }
 
 static struct platform_driver g12a_mdio_mux_driver = {
 	.probe		= g12a_mdio_mux_probe,
-	.remove		= g12a_mdio_mux_remove,
+	.remove_new	= g12a_mdio_mux_remove,
 	.driver		= {
 		.name	= "g12a-mdio_mux",
 		.of_match_table = g12a_mdio_mux_match,
-- 
2.40.1



Return-Path: <netdev+bounces-53583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E2803D0F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1741F20F39
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756322FE0B;
	Mon,  4 Dec 2023 18:31:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1865B116
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:31:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj4-0003D8-2h; Mon, 04 Dec 2023 19:31:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj3-00DZml-KI; Mon, 04 Dec 2023 19:31:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj3-00EE7a-AF; Mon, 04 Dec 2023 19:31:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 6/9] net: wan/ixp4xx_hss: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:46 +0100
Message-ID:  <b0488fa6181a47668e5737905ae7adc8d7cd055e.1701713943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=R3GOFhoPlqaWIMswQrULsAL9Ly7E9xywKQWRfTObpGA=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQ8qQdef+tjSo9sZrs+L+ia9Wf1jsNRnBYtE7LmXrJ/L rNJ/2hxJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQAT4eNk/1+Tv4XjYmTx/d8y fZdq3Xq3Tl46Savhf0448yeeA4HS0QU7N89a99DXzU7e7ipv0NmupCnVL7Yvs/Th5ePI+nZ64qk 7N9IFP1XPmhGuxhAjYCF2uHvS6VrJZ2xBRp8vBblFxfH5R7qlXX2a3xK6Tv7fn/kBMf6Fje4sHP K1C9Z4zfV5fD1g8998D8mjLz5l2btWamkol/IznRfT083mt+1bPd/r+PrTnHJFV4s/zc3+dTdfU abyZVnf8vMVIgk8j1pmZR5/HDalOeT3YfGNP+QaSgv+3/KSYlXtE075Vmw/lyuwV8zcOdXv7Cxt DZ0Vc89Urt5osuqLwcGJvInhUYrRijllxeu7779as9kcAA==
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

Link: https://lore.kernel.org/r/20231117095922.876489-8-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wan/ixp4xx_hss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index b09f4c235142..931c5ca79ea5 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1522,20 +1522,19 @@ static int ixp4xx_hss_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ixp4xx_hss_remove(struct platform_device *pdev)
+static void ixp4xx_hss_remove(struct platform_device *pdev)
 {
 	struct port *port = platform_get_drvdata(pdev);
 
 	unregister_hdlc_device(port->netdev);
 	free_netdev(port->netdev);
 	npe_release(port->npe);
-	return 0;
 }
 
 static struct platform_driver ixp4xx_hss_driver = {
 	.driver.name	= DRV_NAME,
 	.probe		= ixp4xx_hss_probe,
-	.remove		= ixp4xx_hss_remove,
+	.remove_new	= ixp4xx_hss_remove,
 };
 module_platform_driver(ixp4xx_hss_driver);
 
-- 
2.42.0



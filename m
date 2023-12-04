Return-Path: <netdev+bounces-53579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A50803D0A
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954EBB20AEA
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B812FC38;
	Mon,  4 Dec 2023 18:31:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B24CA
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:31:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj3-00039O-BI; Mon, 04 Dec 2023 19:31:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj2-00DZmd-Sv; Mon, 04 Dec 2023 19:31:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj2-00EE7O-Ja; Mon, 04 Dec 2023 19:31:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH net-next v2 4/9] net: sfp: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:44 +0100
Message-ID:  <7c1d50d559c0e0e36a20eb3e410f6e9d3f884b6f.1701713943.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ksAknJksbw+L56iVSgvs+eTBS5f0dAwxllBF4NUUw14=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbhrcd5G8mOX+Ay2gPcMcoVzJfoaS6mWdw0O66 wW06i5vESaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW4a3AAKCRCPgPtYfRL+ TqNXCAConpXJxBEaV3ns0IrmTYH2LKFl46PMzNh0Wt2LAYSudtjg3Ku3thYNMObYDwyFj2ZiqqY 9/VzPz/SkyFDRxQIOlAZkQSyABTHtNVwM263iNMvhRHzIvkCXZYDIKhuMwkV+vLSNlvFMY8KTs3 VBa+YfEB0eD4QLRLnbgBSHFATpmf4W6JC13iebAM85kvsCA6W3SJnmbplm3Sf+WV/xhFZFatpBv lxuJQn1WivJI6KZbYeQjLYt2iADAuBWr5uJD/4UObaq224zyON2BXgGcZYfBw/IVL+Pq4k2PUPi 6y6klc25IMP3F0juFHQ7xc7aqt3TEbW7CHga05TAzMgEDBpL
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

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20231117095922.876489-6-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/phy/sfp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5eb00295b8bf..3780a96d2caa 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -3097,7 +3097,7 @@ static int sfp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sfp_remove(struct platform_device *pdev)
+static void sfp_remove(struct platform_device *pdev)
 {
 	struct sfp *sfp = platform_get_drvdata(pdev);
 
@@ -3107,8 +3107,6 @@ static int sfp_remove(struct platform_device *pdev)
 	rtnl_lock();
 	sfp_sm_event(sfp, SFP_E_REMOVE);
 	rtnl_unlock();
-
-	return 0;
 }
 
 static void sfp_shutdown(struct platform_device *pdev)
@@ -3129,7 +3127,7 @@ static void sfp_shutdown(struct platform_device *pdev)
 
 static struct platform_driver sfp_driver = {
 	.probe = sfp_probe,
-	.remove = sfp_remove,
+	.remove_new = sfp_remove,
 	.shutdown = sfp_shutdown,
 	.driver = {
 		.name = "sfp",
-- 
2.42.0



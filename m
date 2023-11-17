Return-Path: <netdev+bounces-48618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845AF7EEF8F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC16C1F215E3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4018639;
	Fri, 17 Nov 2023 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC8AA9
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-0000Cw-A1; Fri, 17 Nov 2023 10:59:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-009eFp-Ra; Fri, 17 Nov 2023 10:59:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-002zWC-II; Fri, 17 Nov 2023 10:59:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 05/10] net: sfp: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:28 +0100
Message-ID: <20231117095922.876489-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6b1/r3nohYrC/70zxlL2kNntlccPvHvYfH1SCl9wYnk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRwy4bwsK+9BS1FH9/paXnyqJwN0rzUHNP+68yP6enfv QMyeMs7GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZiIrS37P5N1dxvC1m5Ry/MX 3OaY4xE+a7LLP3fN236hTI/9NBdGTTH7M1foQdnswP28HbIqJ/U6lr3lYwnbaPmfX/bAxe5YKzf D3cmFdsVsCtmLLmr6m7su/8awOmQud/gBjfJtW09vu2P/4sbKT/bTZgbt3Xo5T+yghOCnggU3Qo 8ZB4Y6egUKOLgtsVx3VTI4plfz/enjn4wnPzhi/jN94sInpmuCZqRPW8f3c1qpQOjCaw6H21iZv V/85Np/lUtfMEXMIcdscmFXd+I2qVlFH1zCaj7VVt76fODg04uqS8vb2CuOGbdOsolZ6GYu+/DF 94jIz6deNYqyFDmpiXncKnB4y1pd0t2qXniCk80g3akXAA==
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
 drivers/net/phy/sfp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 5468bd209fab..859b4749e8e2 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -3096,7 +3096,7 @@ static int sfp_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sfp_remove(struct platform_device *pdev)
+static void sfp_remove(struct platform_device *pdev)
 {
 	struct sfp *sfp = platform_get_drvdata(pdev);
 
@@ -3106,8 +3106,6 @@ static int sfp_remove(struct platform_device *pdev)
 	rtnl_lock();
 	sfp_sm_event(sfp, SFP_E_REMOVE);
 	rtnl_unlock();
-
-	return 0;
 }
 
 static void sfp_shutdown(struct platform_device *pdev)
@@ -3128,7 +3126,7 @@ static void sfp_shutdown(struct platform_device *pdev)
 
 static struct platform_driver sfp_driver = {
 	.probe = sfp_probe,
-	.remove = sfp_remove,
+	.remove_new = sfp_remove,
 	.shutdown = sfp_shutdown,
 	.driver = {
 		.name = "sfp",
-- 
2.42.0



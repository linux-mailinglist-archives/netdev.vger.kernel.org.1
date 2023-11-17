Return-Path: <netdev+bounces-48620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4AD7EEF92
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9F41C20AC8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839C182C4;
	Fri, 17 Nov 2023 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94939C1
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-0000Cv-9c; Fri, 17 Nov 2023 10:59:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-009eFk-Km; Fri, 17 Nov 2023 10:59:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-002zW3-BC; Fri, 17 Nov 2023 10:59:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 04/10] net: pcs: rzn1-miic: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:27 +0100
Message-ID: <20231117095922.876489-5-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Lz7tUUn8eW/6NCcaxKNY5iWuUPDkoUM+e6kcay8ikz8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzl/WQWllQ3FE1DQmW5liysNkRx63mxlc37PF 4wFaaRbqcmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5fwAKCRCPgPtYfRL+ Ts6YCACNWuOngwvtkSGhR7t2Q7eFmZ8/QI6gXu5p3TS8Su/MzrQIXjfYcV3XMCaqM1cOH7RGMrq TxLogqADW3/qKbp+srvIt1gGPgBQ7lq2Fvk977+lHPn+SlXmapvjFN0id5JrVPPBsyhH8BWpf49 bhwtwOZVJOUPQX0zpwwJkYZi/CoUHcK0z2Wr1U+d4L1mFOTY7r5iNcV7g6mrwtV5B1LBrSuWza9 xRJLh6n5+p2RsiL5uQoP0aMysrUUdEm07Zhu/H2OzWOnNeKi1VFbXSdKtDlprU61DohYrEwNLby cUfK/KnF/wmFoETsN5vFQM5haBl5pZhFcBBdtmRDXF2hjH1M
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
 drivers/net/pcs/pcs-rzn1-miic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index 97139c07130f..d93f84fbb1fd 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -505,11 +505,9 @@ static int miic_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int miic_remove(struct platform_device *pdev)
+static void miic_remove(struct platform_device *pdev)
 {
 	pm_runtime_put(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id miic_of_mtable[] = {
@@ -525,7 +523,7 @@ static struct platform_driver miic_driver = {
 		.of_match_table = miic_of_mtable,
 	},
 	.probe = miic_probe,
-	.remove = miic_remove,
+	.remove_new = miic_remove,
 };
 module_platform_driver(miic_driver);
 
-- 
2.42.0



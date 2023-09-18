Return-Path: <netdev+bounces-34724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D340B7A536A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DCD1C20A83
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB97728DC9;
	Mon, 18 Sep 2023 19:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC8286B3
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E5120
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHB-0003uR-K7; Mon, 18 Sep 2023 21:51:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHB-007I9Q-38; Mon, 18 Sep 2023 21:51:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKHA-002mD4-Pk; Mon, 18 Sep 2023 21:51:20 +0200
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
Subject: [PATCH net-next 17/19] net: mdio: octeon: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:51:00 +0200
Message-Id: <20230918195102.1302746-18-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JgSJpI+VgVasj2hx9BfwfaykoqbFS61hnmgshTkmMks=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoTbUB4KBW9aATzEPLdw6uEFKPaCItJVlsBH o736L7smEWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqEwAKCRCPgPtYfRL+ ToxUCACIr1RfOW1GF5asJluuxSIZo6fSkOMkZ3BXImWLOugohvvLL33TVjHornpg87S3BXmJf/e sbn51ri7AsGXTVCZHlaXIWm+cDeTOTAztOQpYQ+P7G480pbnehIJn9B2dUpoOvhoW8lcChX3GsY 7SjpY19IK0rSNlou3Qq8vhPB2pR/CgPWEdm5Zt25BEQF9S6a3L/Z050S41TPcyR2GV+FAF31jbC 2zIaPsZ534nbQcz/M3niwn7OeEmkuR1avl4IJWi2RW+mgtoYqJGK2zy0EbKcTijAmkvLF/0ThFf a6kf9+TrzLUS92Fc0/FX8qIZS+QVXQBCupb9JDto/aAb4Je9
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
 drivers/net/mdio/mdio-octeon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-octeon.c b/drivers/net/mdio/mdio-octeon.c
index 7c65c547d377..037a38cfed56 100644
--- a/drivers/net/mdio/mdio-octeon.c
+++ b/drivers/net/mdio/mdio-octeon.c
@@ -78,7 +78,7 @@ static int octeon_mdiobus_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int octeon_mdiobus_remove(struct platform_device *pdev)
+static void octeon_mdiobus_remove(struct platform_device *pdev)
 {
 	struct cavium_mdiobus *bus;
 	union cvmx_smix_en smi_en;
@@ -88,7 +88,6 @@ static int octeon_mdiobus_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus->mii_bus);
 	smi_en.u64 = 0;
 	oct_mdio_writeq(smi_en.u64, bus->register_base + SMI_EN);
-	return 0;
 }
 
 static const struct of_device_id octeon_mdiobus_match[] = {
@@ -105,7 +104,7 @@ static struct platform_driver octeon_mdiobus_driver = {
 		.of_match_table = octeon_mdiobus_match,
 	},
 	.probe		= octeon_mdiobus_probe,
-	.remove		= octeon_mdiobus_remove,
+	.remove_new	= octeon_mdiobus_remove,
 };
 
 module_platform_driver(octeon_mdiobus_driver);
-- 
2.40.1



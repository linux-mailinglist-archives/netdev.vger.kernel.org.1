Return-Path: <netdev+bounces-34725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48A7A536B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A9D1C20AFE
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E91286B1;
	Mon, 18 Sep 2023 19:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB30286B2
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB811C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH9-0003kt-5G; Mon, 18 Sep 2023 21:51:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-007I8j-OS; Mon, 18 Sep 2023 21:51:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-002mCQ-Ef; Mon, 18 Sep 2023 21:51:18 +0200
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
Subject: [PATCH net-next 07/19] net: mdio: ipq8064: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:50 +0200
Message-Id: <20230918195102.1302746-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=miGmpzcVxDh0lJ0Y47z/irjCSAlu12OWqTaS3ah8Cn0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCKoH1VkGIYYdyqftOgEqKWtvPUrGb2Q9i1Eds h9R/LfWhc+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQiqBwAKCRCPgPtYfRL+ TuXOB/0Vo6HeAm9CXB3VfnLjjtTyZxnjdd3rHx/Cn54Ig6livRNGk8z11WX6xi69v2CxNR3mx+O 0Dqlk043Mj9J7wp5vEKX6eKuGmJolEEQfN9e3XyRLgsRyrRwOyfalyPATGynWpFbnsnQsPk7h2g oo0Ty51+61jlV8CytWEu0wefsJ6w51HQ/LaQ8iJZh6v48OsOkt6RJFc1K4WWH7rCT2et5ZteKRr 0eWEHy8cd6BF+8CABZLdPQJp1YKB1Tg4BbBeKIf3uz5E7Cl6fyvoGTCocePjH2/XA5Elzb1Qjdm bUDM7PM/f3v/ICEfTQC45i5jOY/VPbFfFBMohAsdhGFSCtGa
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
 drivers/net/mdio/mdio-ipq8064.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index fd9716960106..f71b6e1c66e4 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -147,14 +147,11 @@ ipq8064_mdio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int
-ipq8064_mdio_remove(struct platform_device *pdev)
+static void ipq8064_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 
 	mdiobus_unregister(bus);
-
-	return 0;
 }
 
 static const struct of_device_id ipq8064_mdio_dt_ids[] = {
@@ -165,7 +162,7 @@ MODULE_DEVICE_TABLE(of, ipq8064_mdio_dt_ids);
 
 static struct platform_driver ipq8064_mdio_driver = {
 	.probe = ipq8064_mdio_probe,
-	.remove = ipq8064_mdio_remove,
+	.remove_new = ipq8064_mdio_remove,
 	.driver = {
 		.name = "ipq8064-mdio",
 		.of_match_table = ipq8064_mdio_dt_ids,
-- 
2.40.1



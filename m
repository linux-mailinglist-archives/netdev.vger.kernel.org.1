Return-Path: <netdev+bounces-34718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99787A5364
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DCF1C20A9B
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200F286A4;
	Mon, 18 Sep 2023 19:51:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C52868A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:51:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE9112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:51:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-0003kT-N6; Mon, 18 Sep 2023 21:51:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-007I8c-9v; Mon, 18 Sep 2023 21:51:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiKH8-002mCH-0K; Mon, 18 Sep 2023 21:51:18 +0200
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
Subject: [PATCH net-next 05/19] net: mdio: hisi-femac: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:50:48 +0200
Message-Id: <20230918195102.1302746-6-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=HQon30rRgBBgFtnAN7jXNVSSzpSUENvH/4/wmd2IRT4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOVSy9rSkl6fWq2v7mOcFFEQmKorExfe9VJxXa2Zw0z 8rl8uxkNGZhYORikBVTZLFvXJNpVSUX2bn232WYQaxMIFMYuDgFYCKb73IwdAekO1m9W6DqI/T+ 442fxw1kj2lseLrhzpell+dZV905WnyzVH6tyYfpgf9Us655T3SXk95RMbd7fpKO0AtNsVjVi9+ 4xTyT2D49DI1bpOD6TzjpU2TS79Bkr3KXtxMPJi3/8OOn9j/hK7oTyr++P/DU6Yq2pV54YzHD4W ul6iwVPxkjLrGZGoXu+qGfeSP59LT+KUtLttd8FvTyMwnwtRQ9Kntsz67rT/PEzHKjmq9IvIquC 65jepHZ87f7b9GsiTsLqu6XbfaSuKLSXhw741Ry7rWe/3PTpfW3m3VPE43+b3aqx+a/vopBctiS u+wfQhQzAjUZT6ldf65yeQOf7MdIncl3bTyW7NPifx4NAA==
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
 drivers/net/mdio/mdio-hisi-femac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mdio/mdio-hisi-femac.c b/drivers/net/mdio/mdio-hisi-femac.c
index f231c2fbb1de..6703f626ee83 100644
--- a/drivers/net/mdio/mdio-hisi-femac.c
+++ b/drivers/net/mdio/mdio-hisi-femac.c
@@ -118,7 +118,7 @@ static int hisi_femac_mdio_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int hisi_femac_mdio_remove(struct platform_device *pdev)
+static void hisi_femac_mdio_remove(struct platform_device *pdev)
 {
 	struct mii_bus *bus = platform_get_drvdata(pdev);
 	struct hisi_femac_mdio_data *data = bus->priv;
@@ -126,8 +126,6 @@ static int hisi_femac_mdio_remove(struct platform_device *pdev)
 	mdiobus_unregister(bus);
 	clk_disable_unprepare(data->clk);
 	mdiobus_free(bus);
-
-	return 0;
 }
 
 static const struct of_device_id hisi_femac_mdio_dt_ids[] = {
@@ -138,7 +136,7 @@ MODULE_DEVICE_TABLE(of, hisi_femac_mdio_dt_ids);
 
 static struct platform_driver hisi_femac_mdio_driver = {
 	.probe = hisi_femac_mdio_probe,
-	.remove = hisi_femac_mdio_remove,
+	.remove_new = hisi_femac_mdio_remove,
 	.driver = {
 		.name = "hisi-femac-mdio",
 		.of_match_table = hisi_femac_mdio_dt_ids,
-- 
2.40.1



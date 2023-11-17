Return-Path: <netdev+bounces-48622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DC97EEF96
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC55EB20A27
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34BD17999;
	Fri, 17 Nov 2023 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F10B0
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-0000Cc-9w; Fri, 17 Nov 2023 10:59:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-009eFh-A4; Fri, 17 Nov 2023 10:59:47 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-002zVz-0S; Fri, 17 Nov 2023 10:59:47 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Dawei Li <set_pte_at@outlook.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 03/10] net: fjes: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:26 +0100
Message-ID: <20231117095922.876489-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pz7UYK1tnAUTXNX0xhss9QTvMQ+xahN+AfbQOiDS1Qk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzl+pweqfFiPpTKUwuX441ZTXCsqLedvDs/Yj V87hTNNYvyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5fgAKCRCPgPtYfRL+ Ti5LB/9AZT99rHDbHUSUjqvbgbggSNXC0d8TyDyVPo4oB8TDjt138P6iMf0Jm0r1FPNzHGnkIbz cgpIFIq0hr6IVLsn8WNGDFktxk64VWpU0J2GjQOoObbIkSMGdAwVa08cQJ+W59WyZ+QfRqcbqwx /EY3IgZj8XiyeiXE3gDxfzaBNoCek/u76irHz+z6/Nezhf6eKes1RjEzxMkbnEY8BpatN3Ja/Cq 5la7Zap+hnecwNXnk/tKXnMP3oCtaBkwqJTS8/2O1h6MOamrrQLPsIVCIkgvukCIr5tq274fILl EE4gLeKo1UyKhFeQGsFAz7wlXGKusiVBRZZeN+AYDFyMvcdz
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
 drivers/net/fjes/fjes_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
index cd8cf08477ec..5fbe33a09bb0 100644
--- a/drivers/net/fjes/fjes_main.c
+++ b/drivers/net/fjes/fjes_main.c
@@ -1438,7 +1438,7 @@ static int fjes_probe(struct platform_device *plat_dev)
 }
 
 /* fjes_remove - Device Removal Routine */
-static int fjes_remove(struct platform_device *plat_dev)
+static void fjes_remove(struct platform_device *plat_dev)
 {
 	struct net_device *netdev = dev_get_drvdata(&plat_dev->dev);
 	struct fjes_adapter *adapter = netdev_priv(netdev);
@@ -1462,8 +1462,6 @@ static int fjes_remove(struct platform_device *plat_dev)
 	netif_napi_del(&adapter->napi);
 
 	free_netdev(netdev);
-
-	return 0;
 }
 
 static struct platform_driver fjes_driver = {
@@ -1471,7 +1469,7 @@ static struct platform_driver fjes_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = fjes_probe,
-	.remove = fjes_remove,
+	.remove_new = fjes_remove,
 };
 
 static acpi_status
-- 
2.42.0



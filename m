Return-Path: <netdev+bounces-34746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808D7A543F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AB1C209FC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FA450D7;
	Mon, 18 Sep 2023 20:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35029450C5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC3B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-0006jz-Sb; Mon, 18 Sep 2023 22:42:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-007Ihx-EP; Mon, 18 Sep 2023 22:42:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4m-002mni-50; Mon, 18 Sep 2023 22:42:36 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Atul Raut <rauji.raut@gmail.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 08/54] net: ethernet: apple: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:40 +0200
Message-Id: <20230918204227.1316886-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1845; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jmp5Q6olaMQmsf5jsOdUbgu14ygX8fkd2B8UHHZME00=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLXtFfak/6vCRgVCcfcoo8H/geLW3T2taXfbP u3jMPUHD6iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi17QAKCRCPgPtYfRL+ Tvk7B/9uHL4MA/ZRV2K7MLxUO4Ad0+2yzWoHmKl0KqLsqz19FawCTLnKob6PKthJQZnnO28IEJx yoH02CCMkBUCvN0Oa+cgAIUmSwvPY6D98LaKjZjKg+gytbB3Ssdg3bdD9deNYtRiCSzgE9DTJPK elKO0/NNAw7lVLOgM6SbcXmkAiLyhuilfQwticZWEEP0uzQ9l0VVRwAIxnlzbd8e6q2uUb/zMQ3 /kV2mvU6UwLh0fUE0djaFtsORmx0R87NLYPD7+oZAQHOUTcWwFLoPKxRbbPrcuVIUCaVWY/gsuQ wiTpzCyaiubwKszL3HhQ+qDfyVsck+95P7mpN9SfFm0/sN/O
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
 drivers/net/ethernet/apple/macmace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/apple/macmace.c b/drivers/net/ethernet/apple/macmace.c
index 8775c3234e91..766ab78256fe 100644
--- a/drivers/net/ethernet/apple/macmace.c
+++ b/drivers/net/ethernet/apple/macmace.c
@@ -739,7 +739,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Macintosh MACE ethernet driver");
 MODULE_ALIAS("platform:macmace");
 
-static int mac_mace_device_remove(struct platform_device *pdev)
+static void mac_mace_device_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 	struct mace_data *mp = netdev_priv(dev);
@@ -755,13 +755,11 @@ static int mac_mace_device_remove(struct platform_device *pdev)
 	                  mp->tx_ring, mp->tx_ring_phys);
 
 	free_netdev(dev);
-
-	return 0;
 }
 
 static struct platform_driver mac_mace_driver = {
 	.probe  = mace_probe,
-	.remove = mac_mace_device_remove,
+	.remove_new = mac_mace_device_remove,
 	.driver	= {
 		.name	= mac_mace_string,
 	},
-- 
2.40.1



Return-Path: <netdev+bounces-34700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51CD7A52E3
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84767281DEA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8027735;
	Mon, 18 Sep 2023 19:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39602273ED
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:19:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7910F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:19:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmH-0002nz-L2; Mon, 18 Sep 2023 21:19:25 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmG-007I2O-8c; Mon, 18 Sep 2023 21:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiJmF-002m1g-UM; Mon, 18 Sep 2023 21:19:23 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 1/9] net: dsa: b53: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 21:19:08 +0200
Message-Id: <20230918191916.1299418-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
References: <20230918191916.1299418-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GqU17FgeMi/nZ1dy/v0xgslfOsHBLbsjKnEzgzQUCn8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSORctfLtA1DJrhxsVycS57Yn++kuexj59nPJ+n/HZx3 T3Nikk9nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMxOgw+z+VtI/fHKpLUr7s /MvKJHVtQaBWoOWzjd+MEguqk44szL2ydyb/GlFulqtO5/n/7t/9Km2OukLY/tIzrwJ8nl2/ntG dNNfocIUyK2dUX828e89YNf6INbRbvlK/XDRJR5RbpOH/RMu/clmyXzYlGU/+Gl8n+q5EIz+6bE nMrBD9SdK1U2Zck+NWzi5o4fHWusDzzGvnq4maorMZUnaUTVg6pWDL7JOnH0f+0WVexRu9btLnZ SkX+faHLSqva7q0uCzCrOisaUFTh5jIfKVnpUsEXYHKeeZo6jdr/VFarxLzgrH4TvTb2hPeu8w0 XRvKsw8/u9+UlHVb1duPL/3z+1ie4O2+Hr3zXz+QS1MFAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

Trivially convert these drivers from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/dsa/b53/b53_mmap.c | 6 ++----
 drivers/net/dsa/b53/b53_srab.c | 8 +++-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 5e39641ea887..3a89349dc918 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -324,14 +324,12 @@ static int b53_mmap_probe(struct platform_device *pdev)
 	return b53_switch_register(dev);
 }
 
-static int b53_mmap_remove(struct platform_device *pdev)
+static void b53_mmap_remove(struct platform_device *pdev)
 {
 	struct b53_device *dev = platform_get_drvdata(pdev);
 
 	if (dev)
 		b53_switch_remove(dev);
-
-	return 0;
 }
 
 static void b53_mmap_shutdown(struct platform_device *pdev)
@@ -372,7 +370,7 @@ MODULE_DEVICE_TABLE(of, b53_mmap_of_table);
 
 static struct platform_driver b53_mmap_driver = {
 	.probe = b53_mmap_probe,
-	.remove = b53_mmap_remove,
+	.remove_new = b53_mmap_remove,
 	.shutdown = b53_mmap_shutdown,
 	.driver = {
 		.name = "b53-switch",
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index bcb44034404d..f3f95332ff17 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -657,17 +657,15 @@ static int b53_srab_probe(struct platform_device *pdev)
 	return b53_switch_register(dev);
 }
 
-static int b53_srab_remove(struct platform_device *pdev)
+static void b53_srab_remove(struct platform_device *pdev)
 {
 	struct b53_device *dev = platform_get_drvdata(pdev);
 
 	if (!dev)
-		return 0;
+		return;
 
 	b53_srab_intr_set(dev->priv, false);
 	b53_switch_remove(dev);
-
-	return 0;
 }
 
 static void b53_srab_shutdown(struct platform_device *pdev)
@@ -684,7 +682,7 @@ static void b53_srab_shutdown(struct platform_device *pdev)
 
 static struct platform_driver b53_srab_driver = {
 	.probe = b53_srab_probe,
-	.remove = b53_srab_remove,
+	.remove_new = b53_srab_remove,
 	.shutdown = b53_srab_shutdown,
 	.driver = {
 		.name = "b53-srab-switch",
-- 
2.40.1



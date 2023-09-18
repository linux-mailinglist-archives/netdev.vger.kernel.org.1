Return-Path: <netdev+bounces-34777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56677A5482
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C08B1C20A10
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945C31A83;
	Mon, 18 Sep 2023 20:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482802AB50
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD8312A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4w-0007LK-V9; Mon, 18 Sep 2023 22:42:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-007IkA-Oc; Mon, 18 Sep 2023 22:42:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-002mpv-FB; Mon, 18 Sep 2023 22:42:45 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Byungho An <bh74.an@samsung.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 42/54] net: ethernet: samsung: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:14 +0200
Message-Id: <20230918204227.1316886-43-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ym8U1qySEzMSPQzY9eC/G4UfxWwdZs/xiDO85VtRW78=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSObcL/bre8P3svWt38E5N9/9ZJO3j1HHQ5eVqKDhUuF Q49JVHdyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEuhjY/2dcaX+0quLiRbNo k2/xXCxel9ym2fmolDZOVdTIjDb5fifv2VLjdQ7nTioUvLNRO28n5Brke6Rpyz6rNc/ql6wVjGN 5/yWuYzHz67V1O1O+GhxrZNpRtDNbLl128YP8PhlxrTvKGqrHU4SS445VxJvodh97knj7hBxHpM mtK3xdLsvbtjU/nr8xtzpEbgGbUN6NmPKPJel1ui41vIJstWU+HAHqb3K2HHV3Mt3JWXj10opl0 idFwi2+X57p7xu8gaf5habiSinHExwbuPadONfT/f5WlzrPQx2rQ10xYcei1kQ9v9ikmfxU3viJ gPidqWdZdKcaXbZjtTOxOK7HPO3DMsdJ0rtVOn9oTVoEAA==
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
 drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index fb59ff94509a..e6e130dbe1de 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -169,13 +169,11 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
  * Description: this function calls the main to free the net resources
  * and calls the platforms hook and release the resources (e.g. mem).
  */
-static int sxgbe_platform_remove(struct platform_device *pdev)
+static void sxgbe_platform_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	sxgbe_drv_remove(ndev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -226,7 +224,7 @@ MODULE_DEVICE_TABLE(of, sxgbe_dt_ids);
 
 static struct platform_driver sxgbe_platform_driver = {
 	.probe	= sxgbe_platform_probe,
-	.remove	= sxgbe_platform_remove,
+	.remove_new = sxgbe_platform_remove,
 	.driver	= {
 		.name		= SXGBE_RESOURCE_NAME,
 		.pm		= &sxgbe_platform_pm_ops,
-- 
2.40.1



Return-Path: <netdev+bounces-34785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4282C7A5498
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CA8281E63
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B334192;
	Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FA31A61
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E962114
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL50-0007dw-53; Mon, 18 Sep 2023 22:42:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4z-007Il0-G3; Mon, 18 Sep 2023 22:42:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4y-002mqh-UB; Mon, 18 Sep 2023 22:42:49 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Krzysztof Halasa <khalasa@piap.pl>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 54/54] net: ethernet: xscale: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:26 +0200
Message-Id: <20230918204227.1316886-55-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1976; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=skpJBkdZppqNN1E55eE9rz5DpC2AQpwvWdNyXuoadNM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYgjcNZtpwYRM1VxgjTGXWL6L0+B/Svem2YO FBJL4pONlOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2IAAKCRCPgPtYfRL+ TqbgB/wIuiCrzsJLBweqDBYCFOHcdJfs+3qtQew0QVQqVb1hFXK+9iJSJ45tKDGnLdLzs3CSSqc X6UMOysu3rILIyFdrLfzqs0xAVYZfLDaG+nGzY+5wgJiNUP3nBIjPCsFZD9LpcmIiYKyweOaGV+ A0a7yFt80gkMezl3TiRMDlnXI92nZJJySwHiLdJVoZjUYSUVWT/PKhZ0IfrmpOy7W0C/QTSgJ06 3yAN7gWRnG165Q7FccnfWuw82sgSSeioaMTi7Lse6Um4UL6WUftdjwCf0DR9i8nbdM+7KbSbo1g ett5F4pRTcJVYnhhRNhhCDNF1q7nf/IolOLm0ruy0mm50N8+
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
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index 3b0c5f177447..b242aa61d8ab 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1533,7 +1533,7 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ixp4xx_eth_remove(struct platform_device *pdev)
+static void ixp4xx_eth_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct phy_device *phydev = ndev->phydev;
@@ -1544,7 +1544,6 @@ static int ixp4xx_eth_remove(struct platform_device *pdev)
 	ixp4xx_mdio_remove();
 	npe_port_tab[NPE_ID(port->id)] = NULL;
 	npe_release(port->npe);
-	return 0;
 }
 
 static const struct of_device_id ixp4xx_eth_of_match[] = {
@@ -1560,7 +1559,7 @@ static struct platform_driver ixp4xx_eth_driver = {
 		.of_match_table = of_match_ptr(ixp4xx_eth_of_match),
 	},
 	.probe		= ixp4xx_eth_probe,
-	.remove		= ixp4xx_eth_remove,
+	.remove_new	= ixp4xx_eth_remove,
 };
 module_platform_driver(ixp4xx_eth_driver);
 
-- 
2.40.1



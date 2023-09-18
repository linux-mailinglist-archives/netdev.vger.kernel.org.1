Return-Path: <netdev+bounces-34786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDD87A54A7
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7F2281C4A
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E47341A9;
	Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0E328A1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8510F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4t-0007Eg-HR; Mon, 18 Sep 2023 22:42:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-007IjM-4n; Mon, 18 Sep 2023 22:42:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-002mp9-RM; Mon, 18 Sep 2023 22:42:41 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 30/54] net: ethernet: mediatek: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:02 +0200
Message-Id: <20230918204227.1316886-31-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AvaTDxdQu+sSod8LGo5VRPUDkkzhLSeTrMhxZUFWye8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYGP/0AFpWOpiq6rGiRQFjRSdpNBlaKi3gR9 POZibWbs2mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2BgAKCRCPgPtYfRL+ Tg8CB/0fB24+L8Lq5DGXdIqr31KwnvzrT7m/hpMVWYxD3KmhPdWbRiOaHvPiEIH3WUZKnW0DjbC VXcsXXT049E0VQ/mqskHKOe2rZV3bSruklBceCTRalVH/SloZ2aUBNcatykBOEiaBVmv+3cETRY VjiCyU6vmMS9SqdboYEQIBW0cYYDzfAEVCN5xtFn9bBLlXq92NqvqdUl76GK3vjf+wnNLmZI+2p IzJaUqbYsRMWNYqjuCAW20WrqxzcS2wWrIPbHaUTpYVkgQ1MG1h2ZgehjP46hokP9t6NJXpsDQq fDazgq1AJnrfA4jQ14AaadvNhfja7L2KMW5u5sfymdJDIIO6
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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3cffd1bd3067..4ac8d7cd97ae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5002,7 +5002,7 @@ static int mtk_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int mtk_remove(struct platform_device *pdev)
+static void mtk_remove(struct platform_device *pdev)
 {
 	struct mtk_eth *eth = platform_get_drvdata(pdev);
 	struct mtk_mac *mac;
@@ -5024,8 +5024,6 @@ static int mtk_remove(struct platform_device *pdev)
 	netif_napi_del(&eth->rx_napi);
 	mtk_cleanup(eth);
 	mtk_mdio_cleanup(eth);
-
-	return 0;
 }
 
 static const struct mtk_soc_data mt2701_data = {
@@ -5226,7 +5224,7 @@ MODULE_DEVICE_TABLE(of, of_mtk_match);
 
 static struct platform_driver mtk_driver = {
 	.probe = mtk_probe,
-	.remove = mtk_remove,
+	.remove_new = mtk_remove,
 	.driver = {
 		.name = "mtk_soc_eth",
 		.of_match_table = of_mtk_match,
-- 
2.40.1



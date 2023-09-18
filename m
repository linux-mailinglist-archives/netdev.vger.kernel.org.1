Return-Path: <netdev+bounces-34787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832B7A54AA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C412822B4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD377341B3;
	Mon, 18 Sep 2023 20:43:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EFA328C6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C9F112
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:43:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4v-0007J4-Qp; Mon, 18 Sep 2023 22:42:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-007Ijv-IM; Mon, 18 Sep 2023 22:42:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4u-002mpf-7J; Mon, 18 Sep 2023 22:42:44 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Yuri Karpov <YKarpov@ispras.ru>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 38/54] net: ethernet: ni: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:42:10 +0200
Message-Id: <20230918204227.1316886-39-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=MRBOfQKaCAA7LlXhzXKB3VI+bOl265w+kJ1ZYdd5PnM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlCLYPsVPucH4Lwp0ga5isQz/mGFwVbJ73rjSGC kcLwJBRgveJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQi2DwAKCRCPgPtYfRL+ TivnB/wIHXVlOMEkLC82viwrjcTsEUmH7S1WpqIv9KAimGRrl5PuVSbLS0Fs8ssqBzp2NiFZ/e7 xFCDoDjxkscpypP/JBBsTkLzwWN/JaUQDzgcvFJzs0SDHhOXffjeoDMfiR/5thPXkDYnqhjAQZ6 SvaF+13PY+5sBzl+0biHVe+ig9LuQHlChgDM5THTc2T8cmezjfVQvqXCJa3HLHseJsDSOm72b7E IEJPdiZ+sWXXG5ZXQIw1nrqn9xd4y48WPGrVQki4Fwvx6QcQkOK6tPeKGB5+wSjSEXUF/JlBsKB +aaM058pokfKDrPxBTq2963W9zmecfF6EwpvKehvgacGOg+p
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
 drivers/net/ethernet/ni/nixge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index ba27bbc68f85..97f4798f4b42 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -1397,7 +1397,7 @@ static int nixge_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int nixge_remove(struct platform_device *pdev)
+static void nixge_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct nixge_priv *priv = netdev_priv(ndev);
@@ -1412,13 +1412,11 @@ static int nixge_remove(struct platform_device *pdev)
 		mdiobus_unregister(priv->mii_bus);
 
 	free_netdev(ndev);
-
-	return 0;
 }
 
 static struct platform_driver nixge_driver = {
 	.probe		= nixge_probe,
-	.remove		= nixge_remove,
+	.remove_new	= nixge_remove,
 	.driver		= {
 		.name		= "nixge",
 		.of_match_table	= nixge_dt_ids,
-- 
2.40.1



Return-Path: <netdev+bounces-34771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 580737A5472
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9901C20C59
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88030FB4;
	Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1DD2AB25
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:42:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CE11F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4s-0007CM-LE; Mon, 18 Sep 2023 22:42:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4r-007Ij8-3S; Mon, 18 Sep 2023 22:42:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-002mot-QN; Mon, 18 Sep 2023 22:42:40 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Zhang Changzhong <zhangchangzhong@huawei.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 26/54] net: ethernet: lantiq_etop: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:58 +0200
Message-Id: <20230918204227.1316886-27-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pTfkOOekHkBeP42p7xIlqnM55Pz+zDeGuzXfs4PkLWc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSObYxaohUNpjptR02aeg48e31PK70nadpeK4etT3O1X TRepszuZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAi94rY/wcliFYoih0yDN47 Izfe9XBdSW7Y0j1fv7AfrEzzXX32kq348o/nym4ybAj/FBH3dccB/4DAl28anUu2us+79rlw4+e 7E9gWPRQJrNiuMv2U2t/nyY2+z7rdar1cii7NnmK1S0zDj3dlHOum50Xnc5o67qWbW/X1ikt6rO CMz2SUvhuzYu3mwhV7dKpbv0/xP2sYn9ttXqESMS1tabX9X+3vCufDBS8YOb1cKL9s7exW948u4 fXyXZIiG1a+VczYtHz2tDPztO0Wp7q/4v3wVqSzoTH0S+39tWJueQctXzo1NAgkKvkGyuf9X3so YPdxM/Hnxuc3HWM3+sWqxukwuTKnMvjV7ENJknXpNZn5AA==
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
 drivers/net/ethernet/lantiq_etop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index f5961bdcc480..1d5b7bb6380f 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -721,8 +721,7 @@ ltq_etop_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int
-ltq_etop_remove(struct platform_device *pdev)
+static void ltq_etop_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
 
@@ -732,11 +731,10 @@ ltq_etop_remove(struct platform_device *pdev)
 		ltq_etop_mdio_cleanup(dev);
 		unregister_netdev(dev);
 	}
-	return 0;
 }
 
 static struct platform_driver ltq_mii_driver = {
-	.remove = ltq_etop_remove,
+	.remove_new = ltq_etop_remove,
 	.driver = {
 		.name = "ltq_etop",
 	},
-- 
2.40.1



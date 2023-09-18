Return-Path: <netdev+bounces-34780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE2F7A5486
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2782815A5
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C4A28E36;
	Mon, 18 Sep 2023 20:43:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A830FBC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:43:00 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31544116
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:42:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4q-0006y4-73; Mon, 18 Sep 2023 22:42:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4p-007Iie-4z; Mon, 18 Sep 2023 22:42:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1qiL4o-002moN-S0; Mon, 18 Sep 2023 22:42:38 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 18/54] net: ethernet: dnet: Convert to platform remove callback returning void
Date: Mon, 18 Sep 2023 22:41:50 +0200
Message-Id: <20230918204227.1316886-19-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=r2QWpf2wgTGN+AT9s5oUD1I2vZOPKp3pTQ38LwcseY4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSOrT8+1EjN7lR40Onx3TuW2bVD3vL1R+5gpR3ss2fnZ bzoO8bYyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEHomy/89Pvv9ettzz4rb6 O88e6ZUcj2kvKNt/xXZFTYbOaz6Ws3Gy4fW8DD3rDEyvLDCc3Hyk+ZpGfpzavVMTPITr5vqmJhS pdPM5HHmaueq2h1XdrEv/9hx4LNLbq8DUct+mNKZonVR/3opnkw2mqIZ/v5h/x55V79ySRMv5Uz fIlsUHFgfNOPq7axJPGKcz65qPKX8WcmcFu/fP9OPWuvHbW3aS8vFZr7hYtD6vc8jdVSTHVLpEV 3D1Eh4p4/eHxC9wXDuyhOmfUb0hj2fLtdLPG8yt+fqzdj9aJKR94KNvUGN06NPddxlU2lftiro0 u4E1MuoKd9beOK2JG4t3uu+17fpoEtzL6CtxrZ7d79VCAA==
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
 drivers/net/ethernet/dnet.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/dnet.c b/drivers/net/ethernet/dnet.c
index 151ca9573be9..2a18df3605f1 100644
--- a/drivers/net/ethernet/dnet.c
+++ b/drivers/net/ethernet/dnet.c
@@ -841,7 +841,7 @@ static int dnet_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int dnet_remove(struct platform_device *pdev)
+static void dnet_remove(struct platform_device *pdev)
 {
 
 	struct net_device *dev;
@@ -859,13 +859,11 @@ static int dnet_remove(struct platform_device *pdev)
 		free_irq(dev->irq, dev);
 		free_netdev(dev);
 	}
-
-	return 0;
 }
 
 static struct platform_driver dnet_driver = {
 	.probe		= dnet_probe,
-	.remove		= dnet_remove,
+	.remove_new	= dnet_remove,
 	.driver		= {
 		.name		= "dnet",
 	},
-- 
2.40.1



Return-Path: <netdev+bounces-53577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5691803D06
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC951F211A0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E473D1D684;
	Mon,  4 Dec 2023 18:31:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284ACAF
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 10:31:33 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj3-0003BD-OL; Mon, 04 Dec 2023 19:31:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj3-00DZmh-80; Mon, 04 Dec 2023 19:31:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rADj2-00EE7W-V8; Mon, 04 Dec 2023 19:31:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Zhao Qiang <qiang.zhao@nxp.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kernel@pengutronix.de
Subject: [PATCH net-next v2 5/9] net: wan/fsl_ucc_hdlc: Convert to platform remove callback returning void
Date: Mon,  4 Dec 2023 19:30:45 +0100
Message-ID:  <8c9ffca75ea24810f9ba05a514d5ad59847cc4fe.1701713943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701713943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=BXCJ5RBs9n3Xi3nRuucIGJWxYyOhe3q5AcmI4Pk19QA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlbhreCWyIvQi2zzhLN39R3snoWndXP7tWACp/a BNFVuU6oJaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZW4a3gAKCRCPgPtYfRL+ TuoxB/wMOkST4NGR4hCW1u/Upa0K59hrPLOb5NckuHsuoHLXnqo1xvywmr7V23q5MsJTDuWxob1 2m2dsZkEepK/DhPiQmk7UqEBGt4B6qRZZNU0hdrhoz5C1lhYdvh3q/dwvTunHkWDy0uRnWJPUIb B9KT2KpaKViU06zwdgNo2Sz8bJvlt0ZIFmueD2pmp/VZnOPCMAlcNPRwPNOL+riC8/EurbdGZm9 rtxGTKSFi+vTTdft3kuzua2KfVvNHo7etZ9MWhmzzh7RsYPaRs8v4QZS/TzJC2x9eO9qaHzTawR lEzzcO1THqnxLB85xtQdQC3iWI2AORUgIyT5lpyJ4ApL8/Io
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

Link: https://lore.kernel.org/r/20231117095922.876489-7-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index fd50bb313b92..605e70f7baac 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1259,7 +1259,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ucc_hdlc_remove(struct platform_device *pdev)
+static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
@@ -1277,8 +1277,6 @@ static int ucc_hdlc_remove(struct platform_device *pdev)
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
-
-	return 0;
 }
 
 static const struct of_device_id fsl_ucc_hdlc_of_match[] = {
@@ -1292,7 +1290,7 @@ MODULE_DEVICE_TABLE(of, fsl_ucc_hdlc_of_match);
 
 static struct platform_driver ucc_hdlc_driver = {
 	.probe	= ucc_hdlc_probe,
-	.remove	= ucc_hdlc_remove,
+	.remove_new = ucc_hdlc_remove,
 	.driver	= {
 		.name		= DRV_NAME,
 		.pm		= HDLC_PM_OPS,
-- 
2.42.0



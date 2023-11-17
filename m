Return-Path: <netdev+bounces-48619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904807EEF91
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822751C208E5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60736182A3;
	Fri, 17 Nov 2023 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1D85
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-0000F3-UP; Fri, 17 Nov 2023 10:59:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-009eFv-B9; Fri, 17 Nov 2023 10:59:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-002zWK-22; Fri, 17 Nov 2023 10:59:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 07/10] net: wan/ixp4xx_hss: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:30 +0100
Message-ID: <20231117095922.876489-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=imcM2zPwOV8/aLvSFu/FCWca9j4c+gKvqqz0ToArDKE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzmDmzbqh2Uq1Mj6vs5HB95nEU8p2R0zHyLWM TfaQIH4m2eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5gwAKCRCPgPtYfRL+ TuZiB/90rLadLTRDwDEKpCkZ+7l5WKvUQZrg7oJR0ssc/ZL8pAGnAf2a10ErBAyLsLdWRTwGZfw A2TKyE/c3F3zidg0B4yDgQgGNP3oErlO6fSHo/8zO3MsgJfmZKnvcfL/LGObLUvJfz587xq/6bc GwQPvnk+fM7uhh8EeEgmEj3s9EDJ1Tdvgu1rzi495ie7B8MgHDbb+6tNFCXv3FBSpSp1dtVazzX Ms2qGLg4aOlYDA8NKopDBhIzhp21wm02TzaTbvANyHLIurZg8IEcJwOciCvfEI1ybJIvAasImU1 RVM0ghCkkhbkpUnvxzuIZiRbLFlW8qMssM8mWddsdrU4AYRS
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
 drivers/net/wan/ixp4xx_hss.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index b09f4c235142..931c5ca79ea5 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1522,20 +1522,19 @@ static int ixp4xx_hss_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int ixp4xx_hss_remove(struct platform_device *pdev)
+static void ixp4xx_hss_remove(struct platform_device *pdev)
 {
 	struct port *port = platform_get_drvdata(pdev);
 
 	unregister_hdlc_device(port->netdev);
 	free_netdev(port->netdev);
 	npe_release(port->npe);
-	return 0;
 }
 
 static struct platform_driver ixp4xx_hss_driver = {
 	.driver.name	= DRV_NAME,
 	.probe		= ixp4xx_hss_probe,
-	.remove		= ixp4xx_hss_remove,
+	.remove_new	= ixp4xx_hss_remove,
 };
 module_platform_driver(ixp4xx_hss_driver);
 
-- 
2.42.0



Return-Path: <netdev+bounces-48624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46187EEF97
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D7E2813D8
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E1F19468;
	Fri, 17 Nov 2023 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1C84
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:00:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdd-0000HS-A4; Fri, 17 Nov 2023 10:59:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-009eG4-RG; Fri, 17 Nov 2023 10:59:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-002zWS-I9; Fri, 17 Nov 2023 10:59:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 09/10] ieee802154: fakelb: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:32 +0100
Message-ID: <20231117095922.876489-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bW8hRXr41lIHBTT37J3wUaNIhd6NGJvlV2f3mSrYWnQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzmF/y5+oroMLNKD1jt7neq6OH+mkdMueiR18 t8eMMZCe+OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5hQAKCRCPgPtYfRL+ TsDaCACeRO6UhsdRRppzB6k1yO41zwHlacry8lc2ssMarKdztr/lM5gTp8ANYI5VWKTU7233jZS xdw1NCXbLHYu/VwwmrCNnSh6BQy8AOAcVNRC+62ZBN43R1LHGxoSilIBbbpxoZL9kCuuu7p+f6N R55DH0xXmTsbLVFzssC/CXc3/SER6TwCmlFUPawWEiguPLjz6TX9LLBWd8wffyAvkQZHSfZiSIR MqLPE6ODgqq+59TYlMVAno+I5A9j5dcjPGSnD9ebULmsFioms+lBWZYaxLdLM5B1sSnQTUIop6/ BSES++UHkbdiBZz1YYao9j8m7PQuTD4dicaX+zWXdT3X9Nle
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
 drivers/net/ieee802154/fakelb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 523d13ee02bf..35e55f198e05 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -221,7 +221,7 @@ static int fakelb_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int fakelb_remove(struct platform_device *pdev)
+static void fakelb_remove(struct platform_device *pdev)
 {
 	struct fakelb_phy *phy, *tmp;
 
@@ -229,14 +229,13 @@ static int fakelb_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(phy, tmp, &fakelb_phys, list)
 		fakelb_del(phy);
 	mutex_unlock(&fakelb_phys_lock);
-	return 0;
 }
 
 static struct platform_device *ieee802154fake_dev;
 
 static struct platform_driver ieee802154fake_driver = {
 	.probe = fakelb_probe,
-	.remove = fakelb_remove,
+	.remove_new = fakelb_remove,
 	.driver = {
 			.name = "ieee802154fakelb",
 	},
-- 
2.42.0



Return-Path: <netdev+bounces-48623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016C67EEF95
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADA51F282D7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABC19449;
	Fri, 17 Nov 2023 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D87AD
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 02:00:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdd-0000JE-JR; Fri, 17 Nov 2023 10:59:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdd-009eG8-5V; Fri, 17 Nov 2023 10:59:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdc-002zWW-Sc; Fri, 17 Nov 2023 10:59:48 +0100
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
Subject: [PATCH net-next 10/10] ieee802154: hwsim: Convert to platform remove callback returning void
Date: Fri, 17 Nov 2023 10:59:33 +0100
Message-ID: <20231117095922.876489-11-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1763; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OySE8VQ225pwhwuZLy68C4sg5i3fP0VIUcSiYfkzQmE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzmGfTaQbU/uL7NMdAV08B2HUVvhb4053Ecsa AnNjSiz5ZmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5hgAKCRCPgPtYfRL+ Trv/B/4rMgdZ1dP5QFXvp03L1vFtdVKJHccFaLyyR3o9F1YozR90WlSousX8KuoXq/iErzfA5Mh 4/bB1n4E+jvyOgq643wW4D+6r6aNJk5Pa0T7nGci9RhLpcbZo+CJFtCOWiASrydwLkMStPidqTN 9rcDLo00tY2wP8OlP82sFRYI+axYUASqiLimKZlOP431xej0gH/NGcZKieDSMc3imBuZBNYKesv CfxUTYLG36V9i9Fhton8CiD/FYbdfNAym8F8LPPhey7NCuvOIwGXlQFZpHnZRHMrV5xyWPWsc7D B+MYvVq/ONyZMv+3AfYD9F9OcYd6Hjd950kE5sofdHFwAaQg
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
 drivers/net/ieee802154/mac802154_hwsim.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 31cba9aa7636..2c2483bbe780 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -1035,7 +1035,7 @@ static int hwsim_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int hwsim_remove(struct platform_device *pdev)
+static void hwsim_remove(struct platform_device *pdev)
 {
 	struct hwsim_phy *phy, *tmp;
 
@@ -1043,13 +1043,11 @@ static int hwsim_remove(struct platform_device *pdev)
 	list_for_each_entry_safe(phy, tmp, &hwsim_phys, list)
 		hwsim_del(phy);
 	mutex_unlock(&hwsim_phys_lock);
-
-	return 0;
 }
 
 static struct platform_driver mac802154hwsim_driver = {
 	.probe = hwsim_probe,
-	.remove = hwsim_remove,
+	.remove_new = hwsim_remove,
 	.driver = {
 			.name = "mac802154_hwsim",
 	},
-- 
2.42.0



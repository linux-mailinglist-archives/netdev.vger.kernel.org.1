Return-Path: <netdev+bounces-78658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F4A876037
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 09:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BF001F276DA
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B4535D7;
	Fri,  8 Mar 2024 08:51:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E883535A9
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887919; cv=none; b=uq4sJqBwOTEwGQZA/5IN+Vh3AkExwUh02uqUfd43beL5aCd1qI8/XPSO+paKyBEn3ZH/zGDLlkUAbd87/WYR6GUpAcxkZrAlU0cAXyRxaN4q19HsGjPiMEiI+SUQJeo/JBgsg1LvT+mRnbmMQM1rCAJfXdMH0wksKjZ/SdmZChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887919; c=relaxed/simple;
	bh=vxJz5nig+xzWSq3zj1PqQI4wZdRZNABdHWk6GEKgk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mANEek8I7nkfO5FIRgqBppapFi0gfv9LYKA/rty8eCXf9iWzfxm1AD0DK6KQ/SiSAUXyryp8MeX6RrBBkw3iDnGWJ6TLBWZXcRb1IeBe4lKBZCQKUA9lY2LsJTWGkWdPBX7lEEwZ6neS22YbW8oo38VcWY1hnLLyYpPrdnFiKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxG-0006vt-Qf; Fri, 08 Mar 2024 09:51:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0056ND-Fz; Fri, 08 Mar 2024 09:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-00245c-1K;
	Fri, 08 Mar 2024 09:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] net: wan: framer/pef2256: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:09 +0100
Message-ID:  <9684419fd714cc489a3ef36d838d3717bb6aec6d.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=vxJz5nig+xzWSq3zj1PqQI4wZdRZNABdHWk6GEKgk7U=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tGAzII8sdXD/tAwHLrLK0K3K6EaeEFyysFGh ByYQWIDAYWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRgAAKCRCPgPtYfRL+ TsQWB/47ez8M5T6UiA9K6BYBQc3o4PNXowrdvgKiBr07KeCyelxGxVNXs7LLFt9hNBFKQF2F+M7 VSNS07EEQlLr4BtmJan8aTnmliwnfhqjISRBKqZpsYAT7FCUpU99ZJlLZme+wt5siPAhFiqU9xp qj9mdAaSXRRebu1+azUgxgju1U9a2R+P78SxVNLMcT3xOwV1+nFFAs+m91b1Epb4t1q1y2Y9ZiN abVqRhe0WOoCbWq59WkNHdU4PqYDkkEFp7+yccpI1uQhbIyJD+ehPPE/fUKTxjPjH0enM7ZZebW atD6MsyE/lSoPCxpAS1ZhE7aLcm4VzevFZ99Zl/quISSqG+8
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
 drivers/net/wan/framer/pef2256/pef2256.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
index 4f81053ee4f0..413a3c1d15bb 100644
--- a/drivers/net/wan/framer/pef2256/pef2256.c
+++ b/drivers/net/wan/framer/pef2256/pef2256.c
@@ -838,7 +838,7 @@ static int pef2256_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pef2256_remove(struct platform_device *pdev)
+static void pef2256_remove(struct platform_device *pdev)
 {
 	struct pef2256 *pef2256 = platform_get_drvdata(pdev);
 
@@ -849,8 +849,6 @@ static int pef2256_remove(struct platform_device *pdev)
 	pef2256_write8(pef2256, PEF2256_IMR3, 0xff);
 	pef2256_write8(pef2256, PEF2256_IMR4, 0xff);
 	pef2256_write8(pef2256, PEF2256_IMR5, 0xff);
-
-	return 0;
 }
 
 static const struct of_device_id pef2256_id_table[] = {
@@ -865,7 +863,7 @@ static struct platform_driver pef2256_driver = {
 		.of_match_table = pef2256_id_table,
 	},
 	.probe = pef2256_probe,
-	.remove = pef2256_remove,
+	.remove_new = pef2256_remove,
 };
 module_platform_driver(pef2256_driver);
 

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0



Return-Path: <netdev+bounces-48617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7077EEF8E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A931F214A6
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59B182B9;
	Fri, 17 Nov 2023 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB0BA7
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:59:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vdb-0000Ca-I9; Fri, 17 Nov 2023 10:59:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vda-009eFb-Ri; Fri, 17 Nov 2023 10:59:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r3vda-002zVr-Ia; Fri, 17 Nov 2023 10:59:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alex Elder <elder@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 01/10] net: ipa: Don't error out in .remove()
Date: Fri, 17 Nov 2023 10:59:24 +0100
Message-ID: <20231117095922.876489-2-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ByYbLET6ybS3EL2khqi5VvFTgeu+iTZlHH25mHWO8/Y=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlVzl8uXxZfoXgg/MLTQ1uFyi8IcPpWUqMzPWMk aNc+NPGo6WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVc5fAAKCRCPgPtYfRL+ TjztCACCUZz2DEv7GVcGNO81ONCZc3J7vxjcZB/tuLU+rrluJrqq4HHoa4D5wBpHHxjY1klrfV6 3GpkVjyY1euZaiJv/1getrTclhQsc3woIH+SdmzKIxgF3VZiSIjRidGb584N9gcrIrnQV+bFcev vMrmwortFjplQ5ptQ3d2OZjLBPuJj1Sy6mS7c3GlUhpUvWi5gzs7cOT1/8+VfLqBrDZLQ0x6VC1 XrEiccShKVDmT8bYuqLUuhtjGIvBlXTgSHek3qCW+dKv0xhmwNflgxPGIf2XX0cumB5eJJDUKIz L/EtaLWMe05sUc9my72OwKU01CJ3J27lk09vMUVG61SEwbjF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Returning early from .remove() with an error code still results in the
driver unbinding the device. So the driver core ignores the returned error
code and the resources that were not freed are never catched up. In
combination with devm this also often results in use-after-free bugs.

Here even if the modem cannot be stopped, resources must be freed. So
replace the early error return by an error message an continue to clean up.

This prepares changing ipa_remove() to return void.

Fixes: cdf2e9419dd9 ("soc: qcom: ipa: main code")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/net/ipa/ipa_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index da853353a5c7..60e4f590f5de 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -960,7 +960,8 @@ static int ipa_remove(struct platform_device *pdev)
 			ret = ipa_modem_stop(ipa);
 		}
 		if (ret)
-			return ret;
+			dev_err(dev, "Failed to stop modem (%pe)\n",
+				ERR_PTR(ret));
 
 		ipa_teardown(ipa);
 	}
-- 
2.42.0



Return-Path: <netdev+bounces-86422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F4F89EC2F
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BC5283FD8
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951B13D2B3;
	Wed, 10 Apr 2024 07:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0513D2A6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734506; cv=none; b=llPksU6AaAijZQRY/s5gOVMTLX/J5D2Z0ZnW+m0jhuWfTKkBZwRrMvxKB4YNwdgpkbrUxJpfqAMPHQDeek6u+RveaOjIrQxSlzddAqzJnwl75r//jFrS7K68mbPXqoD0ogP2jG6ILLpTp+TpNA8Ft6kBhnEB17IE+MgLrG1VPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734506; c=relaxed/simple;
	bh=zS3A/NvYkdqObR2oT9yvvV1KKg0CD5GJlQWGJRPexTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQgK6zl1A9M1Y2QVAChs7XgEPELSfznJFFdtsQ3UM3HnxbPVDK7LuHqJnKY9bc/SQs2ZauvIGKU2ywW4INP0JGifk17N36foMPsiSh16jE+NIpjJWwZdpSNTVJJW8e03NMZU4yHShYf75C5/LFFAKmwKs5zYmKInczIfd7t1vl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00041d-Th; Wed, 10 Apr 2024 09:35:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS18-Gp; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00HQ6W-1O;
	Wed, 10 Apr 2024 09:35:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 3/5] ptp: ptp_idt82p33: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:52 +0200
Message-ID:  <5807d0b11214b35f48908fd35cbb7b31b7655ba6.1712734365.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=zS3A/NvYkdqObR2oT9yvvV1KKg0CD5GJlQWGJRPexTE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEdMnrvnnruNyr9ODQv6iuF0BlpB31TtxeUR gYJfYo4g1mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBHQAKCRCPgPtYfRL+ TtJOB/4u6FezSgrJpvAPmQCZ0J8hFifXHBBoK4zSk2CuaVgvF79FED4eXPeBAWo4GZqOvpvymhB 0P5HQWNLD0RP0zGMxk7REeJ+QJ/QN3Xp1co5QU1rLANZjr/PC/aOQErQzvHgI7JP6qtZqnvvq/7 MtY/OCNSedbA19J0nYdf0CUnCarEVLh0/waiNQTEXmBv9DWnuqJwqiMsvN8s21m2KdQpxE6F75J 6vaJKeSgTe7cPh5vcAKF15Bk3FzYCZJ2goQ9flVyQ3xzemz4w0Mf9hdHvMGNaaBQ5Na9BffSnmS E0CBP5vSnSrjogGftHKbrWJYqQyTxGp3rArF7M/IAo6B/k2R
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
 drivers/ptp/ptp_idt82p33.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.c b/drivers/ptp/ptp_idt82p33.c
index 057190b9cd3d..92bb42c43fb2 100644
--- a/drivers/ptp/ptp_idt82p33.c
+++ b/drivers/ptp/ptp_idt82p33.c
@@ -1447,15 +1447,13 @@ static int idt82p33_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int idt82p33_remove(struct platform_device *pdev)
+static void idt82p33_remove(struct platform_device *pdev)
 {
 	struct idt82p33 *idt82p33 = platform_get_drvdata(pdev);
 
 	cancel_delayed_work_sync(&idt82p33->extts_work);
 
 	idt82p33_ptp_clock_unregister_all(idt82p33);
-
-	return 0;
 }
 
 static struct platform_driver idt82p33_driver = {
@@ -1463,7 +1461,7 @@ static struct platform_driver idt82p33_driver = {
 		.name = "82p33x1x-phc",
 	},
 	.probe = idt82p33_probe,
-	.remove	= idt82p33_remove,
+	.remove_new = idt82p33_remove,
 };
 
 module_platform_driver(idt82p33_driver);
-- 
2.43.0



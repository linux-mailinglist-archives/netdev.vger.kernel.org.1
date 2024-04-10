Return-Path: <netdev+bounces-86423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D859289EC30
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873DE1F22791
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020213D51C;
	Wed, 10 Apr 2024 07:35:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DEB13D2AE
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734506; cv=none; b=JVgmxM+IcQ80fEpFbOGwrBeLxPRZkTJqCdBEnzFkvWJLz5a1fvuARplAkmWaFw8RlIt0qLg+YIhKeAxdVnZ/ouXoe7vk77yvY/8zQnC6N6S0q8Yr43foPXKU/+9HzWrB6iYde1r9mU7sBqhTZnJLljP8pe1Ik2gYP8dDwmOrT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734506; c=relaxed/simple;
	bh=VzQOwsB3jfY1dogE9hsp8aNW8xE9cnUt5GXKBcanjY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX5eZRtqduwA5cXcEwOOGAKjXgi5hwMx5z4RTEZqHphFFZnndAlhpWsa1jqRLsXLnEzQGnZKi03AaT3hpBMBMNtbSdMifpcBkqf2yqh15dGU284qwco+OGn4db5dHiKVflW6LtjBrJerMw5UhmNf0xm8adS3JOwI4O87hO/ZGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU3-00041z-3r; Wed, 10 Apr 2024 09:35:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS1B-N8; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00HQ6a-22;
	Wed, 10 Apr 2024 09:35:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 4/5] ptp: ptp_ines: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:53 +0200
Message-ID:  <2cc6c137dd43444abb5bdb53693713f7c2c08b71.1712734365.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VzQOwsB3jfY1dogE9hsp8aNW8xE9cnUt5GXKBcanjY8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEeyZ2kDOikR6CDYAps3HLYMfQAXUZDFzkQo 0yEwTrjRw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBHgAKCRCPgPtYfRL+ Tux4CACb+6HcICS0s8eUtT210h6VaOw7LwzTasxzXfcaP07VHA4V/2KxweXKAL0Um0Xh5saHHK3 uyAGTMjePsx0Lbvei1MrCxmHMhz2thq7G/dtlVGoZzTJLcW5dm4hjIADsenaQwqOBrUDkXWsfV8 gLN6lnI6fwxomDoy9rqHhfve3MVo6mAfeg4iwNRqH6fzNiI6RWL2ipaMAUsOCAOYV95RO0voux+ wLoz22wITj5VW/1u9C9CjzfQue52LwwvW+1jB3aXPKX97Im8khGlS1AC4KxCon8QhPL0kj2uRTf YmrmT2jsINKBvSqJvBgmJyLS8bzzPx/tuxUhoKeA0pgLTvnZ
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
 drivers/ptp/ptp_ines.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_ines.c b/drivers/ptp/ptp_ines.c
index 1d2940a78455..385643f3f8fe 100644
--- a/drivers/ptp/ptp_ines.c
+++ b/drivers/ptp/ptp_ines.c
@@ -765,7 +765,7 @@ static int ines_ptp_ctrl_probe(struct platform_device *pld)
 	return err;
 }
 
-static int ines_ptp_ctrl_remove(struct platform_device *pld)
+static void ines_ptp_ctrl_remove(struct platform_device *pld)
 {
 	struct ines_clock *clock = dev_get_drvdata(&pld->dev);
 
@@ -775,7 +775,6 @@ static int ines_ptp_ctrl_remove(struct platform_device *pld)
 	mutex_unlock(&ines_clocks_lock);
 	ines_clock_cleanup(clock);
 	kfree(clock);
-	return 0;
 }
 
 static const struct of_device_id ines_ptp_ctrl_of_match[] = {
@@ -787,7 +786,7 @@ MODULE_DEVICE_TABLE(of, ines_ptp_ctrl_of_match);
 
 static struct platform_driver ines_ptp_ctrl_driver = {
 	.probe  = ines_ptp_ctrl_probe,
-	.remove = ines_ptp_ctrl_remove,
+	.remove_new = ines_ptp_ctrl_remove,
 	.driver = {
 		.name = "ines_ptp_ctrl",
 		.of_match_table = ines_ptp_ctrl_of_match,
-- 
2.43.0



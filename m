Return-Path: <netdev+bounces-78119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3023F8741EB
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 22:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB93B20AEA
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06480199B8;
	Wed,  6 Mar 2024 21:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D414265
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760233; cv=none; b=Ke0U90JQRVEzNjxYSDn5SwusW/hGK/TKNMDbqq9/3RCjGPZyyBr3+6eYQVSQ9ZbAjSIikgWWoO+ZINmfAy+NJB9p3Ep0HQ2SJlerHUMB84wujcadFIk/ALiSS+dfDoluNA8EaAb5Nxi8L7BcjPCFHRAY4iRNxAIXnwRa9u2+O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760233; c=relaxed/simple;
	bh=XBrLAP5gXxeSMaSldB/jXR3338giUqBL4gHt38EKe7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qHpy+fHu8NYQLuyaX0DOvjQp2vt3uKqPVXAPxorKx9g8J4lLfTpXRAH9QdQY+qUeAMl5KfMUL2mGH85ftDOrWpKZlrZMsFZi6fhnFZTqMQs4zUFOv1Y5BMAUKqiHW4TMH1dIGrHmKuUMbb+kr7SMFMZJFRqs/xKJncPY/tXf+wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyjs-00037x-Si; Wed, 06 Mar 2024 22:23:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyjs-004ou6-F8; Wed, 06 Mar 2024 22:23:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhyjs-000ssj-1F;
	Wed, 06 Mar 2024 22:23:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH next] atm: fore200e: Convert to platform remove callback returning void
Date: Wed,  6 Mar 2024 22:23:44 +0100
Message-ID: <20240306212344.97985-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1746; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XBrLAP5gXxeSMaSldB/jXR3338giUqBL4gHt38EKe7o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6N7glrgztXYA+jo2t8cVQgZhAuYpgcE23WpFm m1qFGjVJiyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeje4AAKCRCPgPtYfRL+ TmV5B/92RSMzG2wBhTEkp31zXzOo7h4qPvxO7SrwIPuj7Vwdc+iDfx3OBbNC1KVL2EJs9RdsLK9 +7e6ox7gpo3qldN8FstKtk4m4F398PCCl3CYNF9wlewxyoQ3wy+4xhJ5abqpV7p/T3kEWwgQQN5 EUzUhHpOuuigPweEXwgfNaV75+GS5SP6jt8U51PG+TBtYvuDhJih52QL0n5Vf6EgAOZAG/HYU8H 67+3kLmotDl5QuaUhxn6MmJljSZRJ/5G1oxqa4fspQnM39dWs2PDG3OczqY8J4voraTzGx3kKw0 6ABg+bwzvPgiU4Q3j8Hol9b15fIlCkFu4E0yH824RT1Mfg79
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
 drivers/atm/fore200e.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 50d8ce20ae5b..9fb1575f8d88 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -2550,14 +2550,12 @@ static int fore200e_sba_probe(struct platform_device *op)
 	return 0;
 }
 
-static int fore200e_sba_remove(struct platform_device *op)
+static void fore200e_sba_remove(struct platform_device *op)
 {
 	struct fore200e *fore200e = dev_get_drvdata(&op->dev);
 
 	fore200e_shutdown(fore200e);
 	kfree(fore200e);
-
-	return 0;
 }
 
 static const struct of_device_id fore200e_sba_match[] = {
@@ -2574,7 +2572,7 @@ static struct platform_driver fore200e_sba_driver = {
 		.of_match_table = fore200e_sba_match,
 	},
 	.probe		= fore200e_sba_probe,
-	.remove		= fore200e_sba_remove,
+	.remove_new	= fore200e_sba_remove,
 };
 #endif
 

base-commit: 11afac187274a6177a7ac82997f8691c0f469e41
-- 
2.43.0



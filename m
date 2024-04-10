Return-Path: <netdev+bounces-86424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7789EC31
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C83F1F2278E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E1A13D520;
	Wed, 10 Apr 2024 07:35:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10813D29F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734507; cv=none; b=IDLWK7A8l3GEGGHGjAHLkDCbmZ/ZgnuEzLD6gf+iZLRXGzW5tFVtwjlDPIBKCNE0xk6Q2E1xYt3LiWNve9CyCOHG90lTPsTM4JxKeKFDar9/YE2Z0k6elrrmG9ErqXMxzAkm+EiaUXK8Zt8mxDOsbwlxzvBd21cnlTR6ASk8xhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734507; c=relaxed/simple;
	bh=I0XDCJ0jSC3RZZlCBrBai5GWRKEW6z/idZ0NTi135XM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjcAqk/bUI5tuTLJkGQxDFV8tojR+TjQ15w5UYiYKIqpONfjQsyo+1gnrRyBwsaop4iFjuBuUj4MUrk6SuMZkxW7RsTUpNXc+eoZDcvVAF+9SGPwwwW9srcT5P6ZHYl97GstUVurjEGTg6UznnjOs1czZ9Nm9kP98z7mcnvgbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00041U-M4; Wed, 10 Apr 2024 09:35:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS12-5Z; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00HQ6O-0I;
	Wed, 10 Apr 2024 09:35:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 1/5] ptp: ptp_clockmatrix: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:50 +0200
Message-ID:  <0f0f5680c1a2a3ef19975935a2c6828a98bc4d25.1712734365.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=I0XDCJ0jSC3RZZlCBrBai5GWRKEW6z/idZ0NTi135XM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEb6O1ejE4C6uGLQMhKOCekurzrCGYpXtAV7 SvAblUzkFiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBGwAKCRCPgPtYfRL+ TtWUCACH4stU4JhoY4A10opFfOKYezgusbaUhcGdSiNHlddn20obHpsuxhtBp8XRx6JqLR8oGPe N1QcW+Hx+iGt2yS71sRbtaBbXL2VOwW1UubRdGBsDTjeu3nP+gyrpc7lQpQftFK0T56xhlvVQ23 x+xsgEeLk901pRYdO7FbiP3XKNX9IMwal4T3jLVSEz7Bmaz5NZKT9SoD5gIprlgPPlrV957Uj7/ D6gstcmvktLHXRTvVweOEDpRtAz/gbNh/WGkiwCHmvd94WMy9yOR17cz8ng7WanUKx5Ej/2TRsw 3wqSug/hcIw036CNBGX1471Hp8wiXHTGGM/kJA6LKVZEdsoI
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
 drivers/ptp/ptp_clockmatrix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f6f9d4adce04..209a45a76e6b 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -2457,15 +2457,13 @@ static int idtcm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int idtcm_remove(struct platform_device *pdev)
+static void idtcm_remove(struct platform_device *pdev)
 {
 	struct idtcm *idtcm = platform_get_drvdata(pdev);
 
 	idtcm->extts_mask = 0;
 	ptp_clock_unregister_all(idtcm);
 	cancel_delayed_work_sync(&idtcm->extts_work);
-
-	return 0;
 }
 
 static struct platform_driver idtcm_driver = {
@@ -2473,7 +2471,7 @@ static struct platform_driver idtcm_driver = {
 		.name = "8a3400x-phc",
 	},
 	.probe = idtcm_probe,
-	.remove	= idtcm_remove,
+	.remove_new = idtcm_remove,
 };
 
 module_platform_driver(idtcm_driver);
-- 
2.43.0



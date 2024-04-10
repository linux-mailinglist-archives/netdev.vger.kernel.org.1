Return-Path: <netdev+bounces-86420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A34389EC2D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D574284132
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1F013D281;
	Wed, 10 Apr 2024 07:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19313D2A1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734506; cv=none; b=D/VGZQ5pdcQTgoMbtEV+cwa1pZqnhLQJS+BQy4tD8CPkGaNezSEXIEtmwWfF8Dw8DRCpqekianVF71K8fzm75i2Rw8s3qVAVoQI0PrXLNsq84AO9CtrnJOQOpPn/kY0/FG8uYLsSi3rxu9MQM9FXCHkEYaxPyJ7RqLm/+sLp5H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734506; c=relaxed/simple;
	bh=GKLi1TpQ/4PyoUz6yT+sH3qWf8dCktmZyI9/1Dn7SOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQsoWiZvoYd1FuRStlYzVLvb0hjyexdJoGK8+SDEemsklqeecytGHRxmxxxYqcHlXoIOPtq5BlKgg09zgqD9msh+7o/VALoMlD1WrB3aTAk+lxEyGR/c2g+SPxaLQ0XfSDPF0EzBsVeeA1sG0cCXVOr7+7OStKSPHUVrbQMJBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00041V-Nd; Wed, 10 Apr 2024 09:35:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS15-Av; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00HQ6S-0q;
	Wed, 10 Apr 2024 09:35:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 2/5] ptp: ptp_dte: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:51 +0200
Message-ID:  <e8a0de7e8e6d642242350360a938132c7ba0488e.1712734365.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1780; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GKLi1TpQ/4PyoUz6yT+sH3qWf8dCktmZyI9/1Dn7SOI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEc8+twDccL+ZbJtKINx2NYPUIIGFnO2J/NI vHRx1ShSA2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBHAAKCRCPgPtYfRL+ Tj1uB/9GldHrepIHt32G5H9D2zN7qXgbYJ9svEMZs9eepEceJOpGVpygGGPseO8JMnDuidZVvF4 mF9YILMJnKmoobpY+DJcqWeRKRtyCTSSwolAkHp5noWnkwFQ6IjRwwL8Gf2SLdkQRu3eqtFoDrr SYZIDLi3WU4859gvGlq21OvuWfB2/SN6t+wzrHqGhqIzU+CimmAwu65UWRK/r/FYgfTjlkCoC2b R9vVxtxtlu8ewpqmacA41rajaG5eUYlG+jdkd9Fp1XFIKJKX/ylDhiW0eJnsCdTv+KD3MHhu1Bi zA1bJeS97aR0NpX8eEmCM61dIFNnMRokMvdHcVQHD0xJLoJN
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
 drivers/ptp/ptp_dte.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ptp/ptp_dte.c b/drivers/ptp/ptp_dte.c
index 7cc5a00e625b..449ff90927be 100644
--- a/drivers/ptp/ptp_dte.c
+++ b/drivers/ptp/ptp_dte.c
@@ -258,7 +258,7 @@ static int ptp_dte_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ptp_dte_remove(struct platform_device *pdev)
+static void ptp_dte_remove(struct platform_device *pdev)
 {
 	struct ptp_dte *ptp_dte = platform_get_drvdata(pdev);
 	u8 i;
@@ -267,8 +267,6 @@ static int ptp_dte_remove(struct platform_device *pdev)
 
 	for (i = 0; i < DTE_NUM_REGS_TO_RESTORE; i++)
 		writel(0, ptp_dte->regs + (i * sizeof(u32)));
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -329,7 +327,7 @@ static struct platform_driver ptp_dte_driver = {
 		.of_match_table = ptp_dte_of_match,
 	},
 	.probe    = ptp_dte_probe,
-	.remove   = ptp_dte_remove,
+	.remove_new = ptp_dte_remove,
 };
 module_platform_driver(ptp_dte_driver);
 
-- 
2.43.0



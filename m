Return-Path: <netdev+bounces-86425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03F289EC32
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A802842AE
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4600D13D521;
	Wed, 10 Apr 2024 07:35:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD4013D27F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734507; cv=none; b=cahez8TImBCyp1ClVJMZXRGfPSRJO71t2oyamYlk54XoCa4E4rsVnVp1FZm+oBtrtqeHop4Omdod9VfVlZGRmcJkMY4ICmiBDpDWNxP9ZNBdQO3Zut1oZMifWKpAli4pErerJ7rhHGTXIqShbD6pQhF7IlcxMbOngpPQTn9byjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734507; c=relaxed/simple;
	bh=3M3EjbbjykLd5QusKoud38l8dOFTlf4n5uAyLMf3oMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G28egFNxWB2ZlCzoMy8NUDCcj580cOaJqRF2KT1dd7GzFStzynInor9qWA3OHvmgyrOz4zOEFmjSOO6qbaLGSpkc1hJ3S73QEOc8AmuK3Z8EWrHxZJ1zfVHMMHFg4LTlX0sQrd106rkKZi8lhN49g0s7CHK3YqiR1Kgplnig1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU3-000428-9c; Wed, 10 Apr 2024 09:35:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00BS1H-ST; Wed, 10 Apr 2024 09:35:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruSU2-00HQ6e-2Z;
	Wed, 10 Apr 2024 09:35:02 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>,
	netdev@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH net-next 5/5] ptp: ptp_qoriq: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 09:34:54 +0200
Message-ID:  <477c6995046eee729447d4f88bf042c7577fe100.1712734365.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3M3EjbbjykLd5QusKoud38l8dOFTlf4n5uAyLMf3oMM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFkEgBl07CxG9YCXrifAJG8BER38HW10E5/Mh0 eEMcxyixzSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhZBIAAKCRCPgPtYfRL+ TrEvCAC4uuVpkreR7sgGpRWsrXtHl3shsUUB1ZgXTdomPLc9Dq4Jwz8RsRHie1sThSKzIDVHOJ3 GMZEWr7nzS5ZfQnLP+d9ElOeCHziKoTdeYTORDwhREl90nxqNLVyau74h0+sPmOVdIQrbnU5nww NpvaEhQJV72+inmWkHFUktqOEVttNsyMKZWvIaKjvXcWKwUU+WL2Q/P+t4Wfh85CcSy6gc8KdJI 5wmncC4RsL8/Ib8yJx3OXmyc6P/ESpTsIlzmo3cQzLRBt2CYZ2t2ozD8GA+kI+BYJmwLLcw8OjO eJa2Bod966y1XXm9DqoqAea64Jr4Rnl8PJgQsKKWjgkRIOSs
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
 drivers/ptp/ptp_qoriq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index a52859d024f0..879cfc1537ac 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -648,14 +648,13 @@ static int ptp_qoriq_probe(struct platform_device *dev)
 	return err;
 }
 
-static int ptp_qoriq_remove(struct platform_device *dev)
+static void ptp_qoriq_remove(struct platform_device *dev)
 {
 	struct ptp_qoriq *ptp_qoriq = platform_get_drvdata(dev);
 
 	ptp_qoriq_free(ptp_qoriq);
 	release_resource(ptp_qoriq->rsrc);
 	kfree(ptp_qoriq);
-	return 0;
 }
 
 static const struct of_device_id match_table[] = {
@@ -671,7 +670,7 @@ static struct platform_driver ptp_qoriq_driver = {
 		.of_match_table	= match_table,
 	},
 	.probe       = ptp_qoriq_probe,
-	.remove      = ptp_qoriq_remove,
+	.remove_new  = ptp_qoriq_remove,
 };
 
 module_platform_driver(ptp_qoriq_driver);
-- 
2.43.0



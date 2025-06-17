Return-Path: <netdev+bounces-198718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9CADD3CB
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3C9400407
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009DE2EA179;
	Tue, 17 Jun 2025 15:51:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803572EA149
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175491; cv=none; b=IVOYr67rqDNI2EPASKQh//f/IrYb94a84axwxO2lTWrndTwb8q/yU0TLhVMJd4OXb2WxaBCi7l38w4fG8Gfbp55Fqw74eEjCWrf6TE+2sfspJQp13URxQTli3O8fXu9dWI8b+RFLaIaNc925M1d1U4WTPAzFbUoO0KnKsPsimXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175491; c=relaxed/simple;
	bh=tOKJT91wwihS5RlT+81Ya3+xQchzZJGolLeSHxd9XZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXzbx9WbdsNzduj6EM1/gNemluLD4zOnqXqThwYVH8cbEQ7GZY3HLo5WRxewbj71nbiOeLtQHljv85xI7KfMu+H5dZzuZ5CjFzfspHx1fuGYHNzETc/CMwY+5hhMm6wcBtplxU2+SuF6b906Up1TstK2FPGfSOnSgffAeaaz614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYat-0000M6-Oy
	for netdev@vger.kernel.org; Tue, 17 Jun 2025 17:51:27 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uRYat-003znQ-1r
	for netdev@vger.kernel.org;
	Tue, 17 Jun 2025 17:51:27 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4299442AAB1
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 15:51:27 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 95A8042AAA5;
	Tue, 17 Jun 2025 15:51:25 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 9766db9c;
	Tue, 17 Jun 2025 15:51:24 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Brett Werling <brett.werling@garmin.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net] can: tcan4x5x: fix power regulator retrieval during probe
Date: Tue, 17 Jun 2025 17:50:02 +0200
Message-ID: <20250617155123.2141584-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617155123.2141584-1-mkl@pengutronix.de>
References: <20250617155123.2141584-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Brett Werling <brett.werling@garmin.com>

Fixes the power regulator retrieval in tcan4x5x_can_probe() by ensuring
the regulator pointer is not set to NULL in the successful return from
devm_regulator_get_optional().

Fixes: 3814ca3a10be ("can: tcan4x5x: tcan4x5x_can_probe(): turn on the power before parsing the config")
Signed-off-by: Brett Werling <brett.werling@garmin.com>
Link: https://patch.msgid.link/20250612191825.3646364-1-brett.werling@garmin.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index e5c162f8c589..8edaa339d590 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -411,10 +411,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	priv = cdev_to_priv(mcan_class);
 
 	priv->power = devm_regulator_get_optional(&spi->dev, "vsup");
-	if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out_m_can_class_free_dev;
-	} else {
+	if (IS_ERR(priv->power)) {
+		if (PTR_ERR(priv->power) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto out_m_can_class_free_dev;
+		}
 		priv->power = NULL;
 	}
 

base-commit: 7b4ac12cc929e281cf7edc22203e0533790ebc2b
-- 
2.47.2




Return-Path: <netdev+bounces-105593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E53911E32
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5111C213A8
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC95175561;
	Fri, 21 Jun 2024 08:02:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA4717108F
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956940; cv=none; b=QQa2gn18pKIhr2RINHmeOBssVJAjR42aH5Or/sltu5oo5Y/nkphcuQibBouZ76qvbdKI5vhV83prk42ZL/0AqZajicxSbjlT/JFeJ7uw2Y8ziEL4bhQxuTCBSejiY8xyTjPZqgKr7zu3T0qLmdpPvQzpmDtbpCt9AJ6FT5lqJi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956940; c=relaxed/simple;
	bh=mDqk1dl5NFsNmrpUJgXabP5bUFYZsvUH02hIXQJwZ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2fRGM5x1+wZJLtgxxk5oxbAzWV82CwXPI7OSfCXOQY8VboI+Fghk3vTkqmF82H29CZzb+Yxhm3G9aerUE+xQHmEyXguTjr642AtxXN6AGX9+gRiXmtFB6g5MqdjKVXL+G37LAPIJFxuISmYEWFPBg1fADsDI1WbTPXakkjEAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDp-00047G-8y
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tN9-Gw
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 2C5652EE44E
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5EB992EE3C2;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1ce5fce1;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/24] can: mcp251x: simplify with spi_get_device_match_data()
Date: Fri, 21 Jun 2024 09:48:42 +0200
Message-ID: <20240621080201.305471-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/20240606142424.129709-2-krzysztof.kozlowski@linaro.org
[mkl: add intermediate cast to uintptr_t]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 643974b3f329..3b8736ff0345 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1300,7 +1300,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 
 static int mcp251x_can_probe(struct spi_device *spi)
 {
-	const void *match = device_get_match_data(&spi->dev);
 	struct net_device *net;
 	struct mcp251x_priv *priv;
 	struct clk *clk;
@@ -1338,10 +1337,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->can.clock.freq = freq / 2;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
-	if (match)
-		priv->model = (enum mcp251x_model)(uintptr_t)match;
-	else
-		priv->model = spi_get_device_id(spi)->driver_data;
+	priv->model = (enum mcp251x_model)(uintptr_t)spi_get_device_match_data(spi);
 	priv->net = net;
 	priv->clk = clk;
 
-- 
2.43.0




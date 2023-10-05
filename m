Return-Path: <netdev+bounces-38394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1A7BAAF7
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2008C2835B8
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CA41AB2;
	Thu,  5 Oct 2023 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9942BE8
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD525E9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUK-0004nz-Eo
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUF-00BLJJ-GR
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 718EF230010
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B739E22FF8C;
	Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 070dbdaa;
	Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 15/37] can: at91_can: ECR register: convert to FIELD_GET()
Date: Thu,  5 Oct 2023 21:57:50 +0200
Message-Id: <20231005195812.549776-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use FIELD_GET() to access the individual fields of the ECR register.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-5-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 79eb78b9f8ae..7597da543348 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -72,6 +72,9 @@ enum at91_reg {
 #define AT91_BR_BRP_MASK GENMASK(22, 16)
 #define AT91_BR_SMP BIT(24)
 
+#define AT91_ECR_REC_MASK GENMASK(8, 0)
+#define AT91_ECR_TEC_MASK GENMASK(23, 16)
+
 #define AT91_MMR_PRIO_SHIFT (16)
 
 #define AT91_MID_MIDE BIT(29)
@@ -385,8 +388,8 @@ static int at91_get_berr_counter(const struct net_device *dev,
 	const struct at91_priv *priv = netdev_priv(dev);
 	u32 reg_ecr = at91_read(priv, AT91_ECR);
 
-	bec->rxerr = reg_ecr & 0xff;
-	bec->txerr = reg_ecr >> 16;
+	bec->rxerr = FIELD_GET(AT91_ECR_REC_MASK, reg_ecr);
+	bec->txerr = FIELD_GET(AT91_ECR_TEC_MASK, reg_ecr);
 
 	return 0;
 }
-- 
2.40.1




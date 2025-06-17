Return-Path: <netdev+bounces-198605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A206ADCD3D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 15:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E682F189C03B
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3B2E973A;
	Tue, 17 Jun 2025 13:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from glittertind.blackshift.org (glittertind.blackshift.org [116.203.23.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FD92E7626
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.23.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750166742; cv=none; b=dB0akPH6Ip63imC8Vu+ikkvL4a/pC18jTTRsmjMDxAXVGTMoSnxAeTEQksLth7PY0YAEpvXp4HI1L3nuDgjqjpHxavw3fVLhAqG3vSdfzQSdkEDwRqSTUCwELuYkJ8fhc3Q4MuVdUSOoDuVubxS+fdme7WJRMflOx3M6aSC7ibc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750166742; c=relaxed/simple;
	bh=eqt9u0PahhGFb1NEChhjIN3+SH4MC2Q5qUzt3VoERHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9gjXP7TVqtFMPHcGEbdoiHmFF5QRLSFPERdizb02eKxrmmY9u0b93ZuqIUsknwsPGrqVRnMbjy/FQHHWTwiLRZvdgrvNaItQhrMRECNwOUQatU4TQ3Zykn/o1PMejiTABmhYUNO6W7LA3xCMl8w4IJZgdunjCUdDC37yuKk3Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=none smtp.mailfrom=hardanger.blackshift.org; arc=none smtp.client-ip=116.203.23.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hardanger.blackshift.org
Received: from bjornoya.blackshift.org (unknown [IPv6:2003:e3:7f3d:bb00:e2bf:c3f2:96ab:885d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "bjornoya.blackshift.org", Issuer "R10" (verified OK))
	by glittertind.blackshift.org (Postfix) with ESMTPS id 6ACD066ED72
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 3358142A85B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 13:25:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CC08F42A7A8;
	Tue, 17 Jun 2025 13:25:21 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 881f6e66;
	Tue, 17 Jun 2025 13:25:20 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 17 Jun 2025 15:24:55 +0200
Subject: [PATCH net-next v3 05/10] net: fec: fec_restart(): introduce a
 define for FEC_ECR_SPEED
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250617-fec-cleanups-v3-5-a57bfb38993f@pengutronix.de>
References: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
In-Reply-To: <20250617-fec-cleanups-v3-0-a57bfb38993f@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1320; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=eqt9u0PahhGFb1NEChhjIN3+SH4MC2Q5qUzt3VoERHE=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBoUWy16GQU7NQUxS8Y/J7hrv2oXVAPAb6RGgWbX
 3NyNWrTrMiJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaFFstQAKCRAMdGXf+ZCR
 nG3CCACcg3N7f1pd0K9NkAdj6Q32XsVA36apnjj4a+qXzpqUwZXbKiUNPexL2SpzXo9PLuZmXHK
 OFgPb7/2V5mlaNurqHMbFD8O9cobBRcvE9TfsxOIFX8Arw94M0WTgFcsirNxUJedOPBXxuvgfH+
 3fymuMrvynBNyR2XVuNzsFSq5AC+prV65jT+ujcDONV8d8KAZo6rrS6LaDkNlqVmtx7HLdJIc/S
 vGzB/XKcy2XI4lM091eJQjOtdboQyfG9IcqwCvoQcYsIpmkZef1DGaqoC+ErQPpJ67KylnqYpy6
 WeWGN/ae4RTnWYsV0/y9D4igRw2eUh3RTexygmDcIe5LNM/B
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Replace "1 << 5" for configuring 1000 MBit/s with a defined constant to
improve code readability and maintainability.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e0d7365e5b4f..21891baa2fc5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -276,6 +276,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_ECR_MAGICEN         BIT(2)
 #define FEC_ECR_SLEEP           BIT(3)
 #define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_SPEED           BIT(5)
 #define FEC_ECR_BYTESWP         BIT(8)
 /* FEC RCR bits definition */
 #define FEC_RCR_LOOP            BIT(0)
@@ -1207,7 +1208,7 @@ fec_restart(struct net_device *ndev)
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
-				ecntl |= (1 << 5);
+				ecntl |= FEC_ECR_SPEED;
 			else if (ndev->phydev->speed == SPEED_100)
 				rcntl &= ~FEC_RCR_10BASET;
 			else

-- 
2.47.2




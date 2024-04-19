Return-Path: <netdev+bounces-89637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53288AAFCF
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 15:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8791C2248A
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3EB12C81F;
	Fri, 19 Apr 2024 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjQS3YQZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C912AAFD
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534877; cv=none; b=Wi7wnWMhy6lUkEgL6lHJ1WUEXqcJkQbQR+0SL+ghgMnqoRSp0xTLifRrTi636Ri6jHFa5P1Ca/ONRuEci3TbR1/LGPEcs31n4Atn77guYanN9E5EbL4kUbJeGkuBROiBOtgw50i6HDYyqDkHiP1WwvB1+LA1Qj9BvXRFgcrTOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534877; c=relaxed/simple;
	bh=aBTK1cJaMQMQrFN94QGOEJpdZKLOF9ZUWyTxuqqR9ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oP/urvMpYtlpgJbvi5URxu1aNrbvq6wdToya/f8qpNPksVE+Q+N3bVlCKbZHKoF+ofuVSohldoQJLHsIfL4Oz6OpEJWvIKR+w5sdmOMvfSoQ87qLZB0CTH1m7NWcQW7sWRHLJs1D2WOZ7ilkNdcDd6WEaUcvyJ8UeXWccDCE1s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjQS3YQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AC0C2BD10;
	Fri, 19 Apr 2024 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713534877;
	bh=aBTK1cJaMQMQrFN94QGOEJpdZKLOF9ZUWyTxuqqR9ZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jjQS3YQZ8aXjG1ECwDUcQxy+tDl5xjyi+4y3b5WaP9ffi7H6Z1chXTxhXPXIAaihx
	 UTxgKPREUHBoewxjRrAaI3QLnqXo54q3vgn3fDjvoUSkLHj04u3l3CbhAfTEKDZL58
	 PaSnrF/AbdMW4SXWanCtwSO5SbvUm08PV5AiWs7dMa8jRAWc0S5dUT97FbbG/JVd2o
	 y/3KD2RsbsgJrxOzWjmzAo36fYoh8dzyTABE/PSXfLi7m0S9CYRzHaySPzX1GxVsV7
	 teFL2liTwxwbdZ4ntfMk4+4JdttKThKIsiQefF1rby13hdlymcleCtMhg+XkZ4pRBK
	 gNKdTXlJnJUdQ==
From: Simon Horman <horms@kernel.org>
Date: Fri, 19 Apr 2024 14:54:19 +0100
Subject: [PATCH net-next 3/4] net: encx24j600: Correct spelling in comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-lan743x-confirm-v1-3-2a087617a3e5@kernel.org>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
In-Reply-To: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.12.3

Correct spelling in comments, as flagged by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/microchip/encx24j600-regmap.c | 4 ++--
 drivers/net/ethernet/microchip/encx24j600.c        | 6 ++++--
 drivers/net/ethernet/microchip/encx24j600_hw.h     | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600-regmap.c b/drivers/net/ethernet/microchip/encx24j600-regmap.c
index 443128adbcb6..3885d6fbace1 100644
--- a/drivers/net/ethernet/microchip/encx24j600-regmap.c
+++ b/drivers/net/ethernet/microchip/encx24j600-regmap.c
@@ -75,7 +75,7 @@ static int regmap_encx24j600_sfr_read(void *context, u8 reg, u8 *val,
 		if (unlikely(ret))
 			return ret;
 	} else {
-		/* Translate registers that are more effecient using
+		/* Translate registers that are more efficient using
 		 * 3-byte SPI commands
 		 */
 		switch (reg) {
@@ -129,7 +129,7 @@ static int regmap_encx24j600_sfr_update(struct encx24j600_context *ctx,
 		if (unlikely(ret))
 			return ret;
 	} else {
-		/* Translate registers that are more effecient using
+		/* Translate registers that are more efficient using
 		 * 3-byte SPI commands
 		 */
 		switch (reg) {
diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index cdc2872ace1b..b011bf5c2305 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -569,7 +569,7 @@ static void encx24j600_dump_config(struct encx24j600_priv *priv,
 	pr_info(DRV_NAME " MABBIPG: %04X\n", encx24j600_read_reg(priv,
 								 MABBIPG));
 
-	/* PHY configuation */
+	/* PHY configuration */
 	pr_info(DRV_NAME " PHCON1:  %04X\n", encx24j600_read_phy(priv, PHCON1));
 	pr_info(DRV_NAME " PHCON2:  %04X\n", encx24j600_read_phy(priv, PHCON2));
 	pr_info(DRV_NAME " PHANA:   %04X\n", encx24j600_read_phy(priv, PHANA));
@@ -837,7 +837,9 @@ static void encx24j600_hw_tx(struct encx24j600_priv *priv)
 		dump_packet("TX", priv->tx_skb->len, priv->tx_skb->data);
 
 	if (encx24j600_read_reg(priv, EIR) & TXABTIF)
-		/* Last transmition aborted due to error. Reset TX interface */
+		/* Last transmission aborted due to error.
+		 * Reset TX interface
+		 */
 		encx24j600_reset_hw_tx(priv);
 
 	/* Clear the TXIF flag if were previously set */
diff --git a/drivers/net/ethernet/microchip/encx24j600_hw.h b/drivers/net/ethernet/microchip/encx24j600_hw.h
index 34c5a289898c..2522f4f48b67 100644
--- a/drivers/net/ethernet/microchip/encx24j600_hw.h
+++ b/drivers/net/ethernet/microchip/encx24j600_hw.h
@@ -243,7 +243,7 @@ int devm_regmap_init_encx24j600(struct device *dev,
 
 /* MAIPG */
 /* value of the high byte is given by the reserved bits,
- * value of the low byte is recomended setting of the
+ * value of the low byte is recommended setting of the
  * IPG parameter.
  */
 #define MAIPGH_VAL 0x0C

-- 
2.43.0



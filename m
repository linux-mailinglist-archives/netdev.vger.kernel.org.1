Return-Path: <netdev+bounces-91000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A098B0DFC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDC5284A21
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F6E160794;
	Wed, 24 Apr 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7xXIqXi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6059F15F41B
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972029; cv=none; b=Tc1wkHcoCuKG9iQkgchKGKKbZNlhYf+QcY+zJijt2+9RQmH7iMqtBoiWySmKut4GhAEG0H0OY5bxfPvZBFy5Og2o6I5xGZtmBC1mLM/AYIFg++LDHmeUhHUajqEZH1cwDapCPSz4UEgDx4hy7TA58uOwkqtx4EtQoU3VgEUf6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972029; c=relaxed/simple;
	bh=aBTK1cJaMQMQrFN94QGOEJpdZKLOF9ZUWyTxuqqR9ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YVzCHMLO1GM8fTMLmhhl115oCA1zJnMswv3xnHBugKoSX2EnKWVFRd6NES+MK+azQfq7bVsU/p6BgM5bcUPGZT42iZhMjGqGQGmJ3co7ucXYhC1XIj9mhwTUEHLrGU492O8pgOvKa3KWM7MWblFBjq23/UcLvL6eDYiMcZdtq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7xXIqXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517F4C2BD10;
	Wed, 24 Apr 2024 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713972028;
	bh=aBTK1cJaMQMQrFN94QGOEJpdZKLOF9ZUWyTxuqqR9ZI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g7xXIqXiza5Y6qlIPtDolqtGj3Ao4JK5DVBzkCFiEVAYC1oJrCfuD73EPmQYtBpit
	 lF73bB3+oIyTbQD9O61o5Qg8eqXh/wAqpdr0xVXRRJEUGaIKdEtFdf31dylT1ytRxV
	 cUMd6BbAdskBEt2PHx4yNZvEJ0XTuSkCTPcj5EdK2wcfZG8MnlhhyQMrio/DN1bbBE
	 TI65LqvogYKDrhO96Wx23o/vB7NrGzhQy6IqwWPJFmfnvZCTfqFEhKPRbj+CKL2nXk
	 a6qzk/bwXUwg79hXZj4SP/apUyME6/YAau1+YgRRDCd5in1JW8/HsnqM9RdFjK95mt
	 RB26L4wpeorsg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 24 Apr 2024 16:13:25 +0100
Subject: [PATCH net-next v2 3/4] net: encx24j600: Correct spelling in
 comments
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-lan743x-confirm-v2-3-f0480542e39f@kernel.org>
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
In-Reply-To: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
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



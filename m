Return-Path: <netdev+bounces-115985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CAB948A8A
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9CF1F22285
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0E1BC9F4;
	Tue,  6 Aug 2024 07:47:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35BF1BA895
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=qOh1AfPkObQNG3/eYr9XDbsR/jwcdTrOzuYBnIZ+CFl8xGEdeGv5BJLBzsf977CQuaPFGRLt0e9m8C2ZTogDZklNGbirApZy/YyvcetA5UKb8HqY5fjBX+TPwXZqv0jkJFfUaOzTwjrVrqyHrXSGOFvOp+zUMnKbYgdV9QRFyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=HnUUsY0Ik0bNaWSvrTyj6lvUM9rw4Wd0Oy6j5RsIBag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzMnaBZsng4TVPb3Ihbw1YoqgzDAH/4NZgbD/K/02eWwVbACEs3wRhNlsZUKdd6EPzL0SfT2CUxoSrGeEdfDBj0unG9fls6E3XZBMXfbMrde5A2/5y6eFPg43031QXaeHengzBDvhHl3xNxdD9342GZvN7Mkk6n5at3bIvL0tvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEux-000459-Kl
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:39 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-004trP-OR
	for netdev@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6DD9F3179C2
	for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:47:36 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id CFA48317972;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e9ae320a;
	Tue, 6 Aug 2024 07:47:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Stefan=20M=C3=A4tje?= <stefan.maetje@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 05/20] can: esd_402_pci: Add support for one-shot mode
Date: Tue,  6 Aug 2024 09:41:56 +0200
Message-ID: <20240806074731.1905378-6-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Stefan Mätje <stefan.maetje@esd.eu>

This patch adds support for one-shot mode. In this mode there happens no
automatic retransmission in the case of an arbitration lost error or on
any bus error.

Signed-off-by: Stefan Mätje <stefan.maetje@esd.eu>
Link: https://lore.kernel.org/all/20240717214409.3934333-3-stefan.maetje@esd.eu
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/esd/esd_402_pci-core.c | 5 +++--
 drivers/net/can/esd/esdacc.c           | 9 +++++++--
 drivers/net/can/esd/esdacc.h           | 1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index b7cdcffd0e45..5d6d2828cd04 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -369,12 +369,13 @@ static int pci402_init_cores(struct pci_dev *pdev)
 		SET_NETDEV_DEV(netdev, &pdev->dev);
 
 		priv = netdev_priv(netdev);
+		priv->can.clock.freq = card->ov.core_frequency;
 		priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
 			CAN_CTRLMODE_LISTENONLY |
 			CAN_CTRLMODE_BERR_REPORTING |
 			CAN_CTRLMODE_CC_LEN8_DLC;
-
-		priv->can.clock.freq = card->ov.core_frequency;
+		if (card->ov.features & ACC_OV_REG_FEAT_MASK_DAR)
+			priv->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 		if (card->ov.features & ACC_OV_REG_FEAT_MASK_CANFD)
 			priv->can.bittiming_const = &pci402_bittiming_const_canfd;
 		else
diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
index ef33d2ccd220..c80032bc1a52 100644
--- a/drivers/net/can/esd/esdacc.c
+++ b/drivers/net/can/esd/esdacc.c
@@ -17,6 +17,9 @@
 /* esdACC DLC register layout */
 #define ACC_DLC_DLC_MASK GENMASK(3, 0)
 #define ACC_DLC_RTR_FLAG BIT(4)
+#define ACC_DLC_SSTX_FLAG BIT(24)	/* Single Shot TX */
+
+/* esdACC DLC in struct acc_bmmsg_rxtxdone::acc_dlc.len only! */
 #define ACC_DLC_TXD_FLAG BIT(5)
 
 /* ecc value of esdACC equals SJA1000's ECC register */
@@ -59,7 +62,7 @@ static void acc_resetmode_leave(struct acc_core *core)
 	acc_resetmode_entered(core);
 }
 
-static void acc_txq_put(struct acc_core *core, u32 acc_id, u8 acc_dlc,
+static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
 			const void *data)
 {
 	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
@@ -249,7 +252,7 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	u8 tx_fifo_head = core->tx_fifo_head;
 	int fifo_usage;
 	u32 acc_id;
-	u8 acc_dlc;
+	u32 acc_dlc;
 
 	if (can_dropped_invalid_skb(netdev, skb))
 		return NETDEV_TX_OK;
@@ -274,6 +277,8 @@ netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 	acc_dlc = can_get_cc_dlc(cf, priv->can.ctrlmode);
 	if (cf->can_id & CAN_RTR_FLAG)
 		acc_dlc |= ACC_DLC_RTR_FLAG;
+	if (priv->can.ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		acc_dlc |= ACC_DLC_SSTX_FLAG;
 
 	if (cf->can_id & CAN_EFF_FLAG) {
 		acc_id = cf->can_id & CAN_EFF_MASK;
diff --git a/drivers/net/can/esd/esdacc.h b/drivers/net/can/esd/esdacc.h
index d13dfa60703a..6b7ebd8c91b2 100644
--- a/drivers/net/can/esd/esdacc.h
+++ b/drivers/net/can/esd/esdacc.h
@@ -35,6 +35,7 @@
  */
 #define ACC_OV_REG_FEAT_MASK_CANFD BIT(27 - 16)
 #define ACC_OV_REG_FEAT_MASK_NEW_PSC BIT(28 - 16)
+#define ACC_OV_REG_FEAT_MASK_DAR BIT(30 - 16)
 
 #define ACC_OV_REG_MODE_MASK_ENDIAN_LITTLE BIT(0)
 #define ACC_OV_REG_MODE_MASK_BM_ENABLE BIT(1)
-- 
2.43.0




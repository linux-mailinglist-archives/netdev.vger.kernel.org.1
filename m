Return-Path: <netdev+bounces-124958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2073396B71F
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888921F2143B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1ED1CFEA2;
	Wed,  4 Sep 2024 09:42:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBB1CF5F9
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442956; cv=none; b=MxKYJiyRrbsSeuj/W+2CM0hoA/6ChMyhtYcsyWRe8tMPI3mRscwVY3rqfr5SJnP0NmXH+zP622ySr/HB4JlkCDcA/WeP+CHo9x9ihSEifNHYhlAhQ0kMuEmQjVVF9k9VolyS6GG9o6EQR1jX/ggMG2zEnkF+Wn9rqXWTx4EesDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442956; c=relaxed/simple;
	bh=jjsE66m5/TlnNE6F0EUTgvHyn81/es/ea1txRQrJ4J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTMG/TxC7+A7HT3yaHPBgrzm3rgCUiFRrIb7fG53rbBfeLY4WvyXMENZt6X7SXczjlsNNu6CzOysw1eK4Y9Lnz77A/MbE8iA/dmAr/KV/NEMx0RPyYxMPlJemdWJavDjgPxtKeYAi8uFsBqIrqSLpEMJZe+V8FAfPQZsnhREu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmX0-0004T5-M3
	for netdev@vger.kernel.org; Wed, 04 Sep 2024 11:42:30 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmWw-005QAz-SC
	for netdev@vger.kernel.org; Wed, 04 Sep 2024 11:42:26 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 65DFF3323EA
	for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 09:42:26 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E2E5033236A;
	Wed, 04 Sep 2024 09:42:22 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 12182d40;
	Wed, 4 Sep 2024 09:42:22 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alibek Omarov <a1ba.omarov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH net-next 11/20] can: rockchip_canfd: add TX PATH
Date: Wed,  4 Sep 2024 11:38:46 +0200
Message-ID: <20240904094218.1925386-12-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904094218.1925386-1-mkl@pengutronix.de>
References: <20240904094218.1925386-1-mkl@pengutronix.de>
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

The IP core has a TX event FIFO. In other IP cores, this type of FIFO
usually contains the events that a CAN frame has been successfully
sent. However, the IP core on the rk3568v2 the FIFO also holds events
of unsuccessful transmission attempts.

It turned out that the best way to work around this problem is to set
the IP core to self-receive mode (RXSTX), filter out the self-received
frames and insert them into the complete TX path.

Add a pair new functions to check if 2 struct canfd_frame are equal.
The 1st checks if the header of the CAN frames are equal, the 2nd
checks if the data portion are equal:

- rkcanfd_can_frame_header_equal()
- rkcanfd_can_frame_data_equal()

Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patch.msgid.link/20240904-rockchip-canfd-v5-11-8ae22bcb27cc@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/rockchip/rockchip_canfd-core.c    |  6 +-
 drivers/net/can/rockchip/rockchip_canfd-rx.c  | 96 +++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd-tx.c  | 94 ++++++++++++++++++
 drivers/net/can/rockchip/rockchip_canfd.h     | 26 +++++
 4 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index d6c0f2fe8d2b..700702e4d2ed 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -229,6 +229,7 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 	 * - CAN_FD: enable CAN-FD
 	 * - AUTO_RETX_MODE: auto retransmission on TX error
 	 * - COVER_MODE: RX-FIFO overwrite mode, do not send OVERLOAD frames
+	 * - RXSTX_MODE: Receive Self Transmit data mode
 	 * - WORK_MODE: transition from reset to working mode
 	 */
 	reg = rkcanfd_read(priv, RKCANFD_REG_MODE);
@@ -236,17 +237,20 @@ static void rkcanfd_chip_start(struct rkcanfd_priv *priv)
 		RKCANFD_REG_MODE_CAN_FD_MODE_ENABLE |
 		RKCANFD_REG_MODE_AUTO_RETX_MODE |
 		RKCANFD_REG_MODE_COVER_MODE |
+		RKCANFD_REG_MODE_RXSTX_MODE |
 		RKCANFD_REG_MODE_WORK_MODE;
 
 	/* mask, i.e. ignore:
 	 * - TIMESTAMP_COUNTER_OVERFLOW_INT - timestamp counter overflow interrupt
 	 * - TX_ARBIT_FAIL_INT - TX arbitration fail interrupt
 	 * - OVERLOAD_INT - CAN bus overload interrupt
+	 * - TX_FINISH_INT - Transmit finish interrupt
 	 */
 	priv->reg_int_mask_default =
 		RKCANFD_REG_INT_TIMESTAMP_COUNTER_OVERFLOW_INT |
 		RKCANFD_REG_INT_TX_ARBIT_FAIL_INT |
-		RKCANFD_REG_INT_OVERLOAD_INT;
+		RKCANFD_REG_INT_OVERLOAD_INT |
+		RKCANFD_REG_INT_TX_FINISH_INT;
 
 	rkcanfd_chip_fifo_setup(priv);
 	rkcanfd_timestamp_init(priv);
diff --git a/drivers/net/can/rockchip/rockchip_canfd-rx.c b/drivers/net/can/rockchip/rockchip_canfd-rx.c
index 609282359bca..650dfd41e0a0 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-rx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-rx.c
@@ -4,8 +4,52 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <net/netdev_queues.h>
+
 #include "rockchip_canfd.h"
 
+static bool rkcanfd_can_frame_header_equal(const struct canfd_frame *const cfd1,
+					   const struct canfd_frame *const cfd2,
+					   const bool is_canfd)
+{
+	const u8 mask_flags = CANFD_BRS | CANFD_ESI | CANFD_FDF;
+	canid_t mask = CAN_EFF_FLAG;
+
+	if (canfd_sanitize_len(cfd1->len) != canfd_sanitize_len(cfd2->len))
+		return false;
+
+	if (!is_canfd)
+		mask |= CAN_RTR_FLAG;
+
+	if (cfd1->can_id & CAN_EFF_FLAG)
+		mask |= CAN_EFF_MASK;
+	else
+		mask |= CAN_SFF_MASK;
+
+	if ((cfd1->can_id & mask) != (cfd2->can_id & mask))
+		return false;
+
+	if (is_canfd &&
+	    (cfd1->flags & mask_flags) != (cfd2->flags & mask_flags))
+		return false;
+
+	return true;
+}
+
+static bool rkcanfd_can_frame_data_equal(const struct canfd_frame *cfd1,
+					 const struct canfd_frame *cfd2,
+					 const bool is_canfd)
+{
+	u8 len;
+
+	if (!is_canfd && (cfd1->can_id & CAN_RTR_FLAG))
+		return true;
+
+	len = canfd_sanitize_len(cfd1->len);
+
+	return !memcmp(cfd1->data, cfd2->data, len);
+}
+
 static unsigned int
 rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 				  const struct rkcanfd_fifo_header *header,
@@ -47,6 +91,48 @@ rkcanfd_fifo_header_to_cfd_header(const struct rkcanfd_priv *priv,
 	return len + cfd->len;
 }
 
+static int rkcanfd_rxstx_filter(struct rkcanfd_priv *priv,
+				const struct canfd_frame *cfd_rx, const u32 ts,
+				bool *tx_done)
+{
+	const struct canfd_frame *cfd_nominal;
+	const struct sk_buff *skb;
+	unsigned int tx_tail;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	skb = priv->can.echo_skb[tx_tail];
+	if (!skb) {
+		netdev_err(priv->ndev,
+			   "%s: echo_skb[%u]=NULL tx_head=0x%08x tx_tail=0x%08x\n",
+			   __func__, tx_tail,
+			   priv->tx_head, priv->tx_tail);
+
+		return -ENOMSG;
+	}
+	cfd_nominal = (struct canfd_frame *)skb->data;
+
+	/* We RX'ed a frame identical to our pending TX frame. */
+	if (rkcanfd_can_frame_header_equal(cfd_rx, cfd_nominal,
+					   cfd_rx->flags & CANFD_FDF) &&
+	    rkcanfd_can_frame_data_equal(cfd_rx, cfd_nominal,
+					 cfd_rx->flags & CANFD_FDF)) {
+		unsigned int frame_len;
+
+		rkcanfd_handle_tx_done_one(priv, ts, &frame_len);
+
+		WRITE_ONCE(priv->tx_tail, priv->tx_tail + 1);
+		netif_subqueue_completed_wake(priv->ndev, 0, 1, frame_len,
+					      rkcanfd_get_tx_free(priv),
+					      RKCANFD_TX_START_THRESHOLD);
+
+		*tx_done = true;
+
+		return 0;
+	}
+
+	return 0;
+}
+
 static inline bool
 rkcanfd_fifo_header_empty(const struct rkcanfd_fifo_header *header)
 {
@@ -89,6 +175,16 @@ static int rkcanfd_handle_rx_int_one(struct rkcanfd_priv *priv)
 		return 0;
 	}
 
+	if (rkcanfd_get_tx_pending(priv)) {
+		bool tx_done = false;
+
+		err = rkcanfd_rxstx_filter(priv, cfd, header->ts, &tx_done);
+		if (err)
+			return err;
+		if (tx_done)
+			return 0;
+	}
+
 	if (header->frameinfo & RKCANFD_REG_FD_FRAMEINFO_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &skb_cfd);
 	else
diff --git a/drivers/net/can/rockchip/rockchip_canfd-tx.c b/drivers/net/can/rockchip/rockchip_canfd-tx.c
index 89c65db3b2dc..668a902f4c2a 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-tx.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-tx.c
@@ -4,9 +4,103 @@
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
+#include <net/netdev_queues.h>
+
 #include "rockchip_canfd.h"
 
+static void rkcanfd_start_xmit_write_cmd(const struct rkcanfd_priv *priv,
+					 const u32 reg_cmd)
+{
+	rkcanfd_write(priv, RKCANFD_REG_CMD, reg_cmd);
+}
+
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct rkcanfd_priv *priv = netdev_priv(ndev);
+	u32 reg_frameinfo, reg_id, reg_cmd;
+	unsigned int tx_head, frame_len;
+	const struct canfd_frame *cfd;
+	int err;
+	u8 i;
+
+	if (can_dropped_invalid_skb(ndev, skb))
+		return NETDEV_TX_OK;
+
+	if (!netif_subqueue_maybe_stop(priv->ndev, 0,
+				       rkcanfd_get_tx_free(priv),
+				       RKCANFD_TX_STOP_THRESHOLD,
+				       RKCANFD_TX_START_THRESHOLD)) {
+		if (net_ratelimit())
+			netdev_info(priv->ndev,
+				    "Stopping tx-queue (tx_head=0x%08x, tx_tail=0x%08x, tx_pending=%d)\n",
+				    priv->tx_head, priv->tx_tail,
+				    rkcanfd_get_tx_pending(priv));
+
+		return NETDEV_TX_BUSY;
+	}
+
+	cfd = (struct canfd_frame *)skb->data;
+
+	if (cfd->can_id & CAN_EFF_FLAG) {
+		reg_frameinfo = RKCANFD_REG_FD_FRAMEINFO_FRAME_FORMAT;
+		reg_id = FIELD_PREP(RKCANFD_REG_FD_ID_EFF, cfd->can_id);
+	} else {
+		reg_frameinfo = 0;
+		reg_id = FIELD_PREP(RKCANFD_REG_FD_ID_SFF, cfd->can_id);
+	}
+
+	if (cfd->can_id & CAN_RTR_FLAG)
+		reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_RTR;
+
+	if (can_is_canfd_skb(skb)) {
+		reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_FDF;
+
+		if (cfd->flags & CANFD_BRS)
+			reg_frameinfo |= RKCANFD_REG_FD_FRAMEINFO_BRS;
+
+		reg_frameinfo |= FIELD_PREP(RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH,
+					    can_fd_len2dlc(cfd->len));
+	} else {
+		reg_frameinfo |= FIELD_PREP(RKCANFD_REG_FD_FRAMEINFO_DATA_LENGTH,
+					    cfd->len);
+	}
+
+	tx_head = rkcanfd_get_tx_head(priv);
+	reg_cmd = RKCANFD_REG_CMD_TX_REQ(tx_head);
+
+	rkcanfd_write(priv, RKCANFD_REG_FD_TXFRAMEINFO, reg_frameinfo);
+	rkcanfd_write(priv, RKCANFD_REG_FD_TXID, reg_id);
+	for (i = 0; i < cfd->len; i += 4)
+		rkcanfd_write(priv, RKCANFD_REG_FD_TXDATA0 + i,
+			      *(u32 *)(cfd->data + i));
+
+	frame_len = can_skb_get_frame_len(skb);
+	err = can_put_echo_skb(skb, ndev, tx_head, frame_len);
+	if (!err)
+		netdev_sent_queue(priv->ndev, frame_len);
+
+	WRITE_ONCE(priv->tx_head, priv->tx_head + 1);
+
+	rkcanfd_start_xmit_write_cmd(priv, reg_cmd);
+
+	netif_subqueue_maybe_stop(priv->ndev, 0,
+				  rkcanfd_get_tx_free(priv),
+				  RKCANFD_TX_STOP_THRESHOLD,
+				  RKCANFD_TX_START_THRESHOLD);
+
 	return NETDEV_TX_OK;
 }
+
+void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
+				unsigned int *frame_len_p)
+{
+	struct net_device_stats *stats = &priv->ndev->stats;
+	unsigned int tx_tail;
+
+	tx_tail = rkcanfd_get_tx_tail(priv);
+	stats->tx_bytes +=
+		can_rx_offload_get_echo_skb_queue_timestamp(&priv->offload,
+							    tx_tail, ts,
+							    frame_len_p);
+	stats->tx_packets++;
+}
diff --git a/drivers/net/can/rockchip/rockchip_canfd.h b/drivers/net/can/rockchip/rockchip_canfd.h
index c775e75a2740..a4688411e586 100644
--- a/drivers/net/can/rockchip/rockchip_canfd.h
+++ b/drivers/net/can/rockchip/rockchip_canfd.h
@@ -471,10 +471,36 @@ rkcanfd_get_timestamp(const struct rkcanfd_priv *priv)
 	return rkcanfd_read(priv, RKCANFD_REG_TIMESTAMP);
 }
 
+static inline unsigned int
+rkcanfd_get_tx_head(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_head) & (RKCANFD_TXFIFO_DEPTH - 1);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_tail(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_tail) & (RKCANFD_TXFIFO_DEPTH - 1);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_pending(const struct rkcanfd_priv *priv)
+{
+	return READ_ONCE(priv->tx_head) - READ_ONCE(priv->tx_tail);
+}
+
+static inline unsigned int
+rkcanfd_get_tx_free(const struct rkcanfd_priv *priv)
+{
+	return RKCANFD_TXFIFO_DEPTH - rkcanfd_get_tx_pending(priv);
+}
+
 int rkcanfd_handle_rx_int(struct rkcanfd_priv *priv);
 
 void rkcanfd_timestamp_init(struct rkcanfd_priv *priv);
 
 int rkcanfd_start_xmit(struct sk_buff *skb, struct net_device *ndev);
+void rkcanfd_handle_tx_done_one(struct rkcanfd_priv *priv, const u32 ts,
+				unsigned int *frame_len_p);
 
 #endif
-- 
2.45.2




Return-Path: <netdev+bounces-18496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D756775760F
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066841C20C5D
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F88FF9EF;
	Tue, 18 Jul 2023 07:58:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4D5FBF0
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:58:04 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EE51722
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:38 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so8907879e87.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689667042; x=1690271842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AK0Rm8Fd4cR85ZcVvm40GzTywtAuoEO7O2YztJGYb0=;
        b=ruz+IRpF7rE4iBlS32tW+elIkSGs7yR2EjNV4eDI41K9tKTdbbaFFs7+g6BKjgMYUY
         RvCNZcvG7QJ3RGuVozsvGqaJ8JDXl0K6QqdEM5orl42GP0sjn9X1VMKWuHctTG/3An/s
         kyvQ7l98WwuRWPCELTkThwfz4HvtTq0VhY2iYTSX07G8LF5HkJbpx0SomFNKvPBo6JHn
         r14NtqbnWm84D3oD5NLCgwQ4FEsotQSJxUi0E/Qi/dgk1fCl4RpAviBc5dHEnCvO6CSU
         3jHCxa/J9LptnX4F0MWnmwOwbxXmDWm3Irxe8n+J4dWkU41f6gDJZ2OEqM1sETyRm36r
         25Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667042; x=1690271842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AK0Rm8Fd4cR85ZcVvm40GzTywtAuoEO7O2YztJGYb0=;
        b=jBBBaiuzCnnfUrruFP2FzQ5Wp5fv8q3NwkEftNCXS+RUzuG0f3VxBzHvrHxJDr/1dW
         9ELSdfGng2sLfHqWOxReqiwrg7YOcMruzYUDDA0sNK611rF9NVRWVmnUZ9CKlFcNZA06
         F6LB+kSXbj2RTcF17lpY+y7V2edhzkxTxhqsQ7VVCNtGWPrsUcgRkci77FaExCeaOQtU
         1GXcMdo2pPnvXFhGZ4v9xQN1W9sEg3odeau8GH3nPaDni94ffdvj9qhkoponlnpZmDJK
         tFJWz9xuCWomLzKYloMBTZQPsefFwPQ3gloAPU7aBmc6KdwS0KRlOhkUbxbepTzqS1Y6
         17Dw==
X-Gm-Message-State: ABy/qLaYYAdrVD3G0Ov2sCCGo8hTl1K25NeP1l0AdjyYLvdkYY7VnIdQ
	bGtEAH0HM8gpVoIK1vBfihCl6w==
X-Google-Smtp-Source: APBJJlEp0ByHQTOfDClnrAWQfVq+D/D3S9r53Hs4xtWuXDl4mz/8VyqXtsyEoni2UMoRBRcPg5xiTw==
X-Received: by 2002:a05:6512:23a6:b0:4f9:5a0c:85b8 with SMTP id c38-20020a05651223a600b004f95a0c85b8mr10561931lfv.36.1689667042566;
        Tue, 18 Jul 2023 00:57:22 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b003142439c7bcsm1585959wrv.80.2023.07.18.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 00:57:22 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Wolfgang Grandegger <wg@grandegger.com>
Cc: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	Simon Horman <simon.horman@corigine.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v5 11/12] can: m_can: Implement BQL
Date: Tue, 18 Jul 2023 09:57:07 +0200
Message-Id: <20230718075708.958094-12-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement byte queue limiting in preparation for the use of xmit_more().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 49 +++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index c01f60317e31..b775ee8e5ff5 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -468,6 +468,8 @@ static void m_can_clean(struct net_device *net)
 	for (int i = 0; i != cdev->can.echo_skb_max; ++i)
 		can_free_echo_skb(cdev->net, i, NULL);
 
+	netdev_reset_queue(cdev->net);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	cdev->tx_fifo_in_flight = 0;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
@@ -1022,29 +1024,34 @@ static int m_can_poll(struct napi_struct *napi, int quota)
  * echo. timestamp is used for peripherals to ensure correct ordering
  * by rx-offload, and is ignored for non-peripherals.
  */
-static void m_can_tx_update_stats(struct m_can_classdev *cdev,
-				  unsigned int msg_mark,
-				  u32 timestamp)
+static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
+					  unsigned int msg_mark, u32 timestamp)
 {
 	struct net_device *dev = cdev->net;
 	struct net_device_stats *stats = &dev->stats;
+	unsigned int frame_len;
 
 	if (cdev->is_peripheral)
 		stats->tx_bytes +=
 			can_rx_offload_get_echo_skb(&cdev->offload,
 						    msg_mark,
 						    timestamp,
-						    NULL);
+						    &frame_len);
 	else
-		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, NULL);
+		stats->tx_bytes += can_get_echo_skb(dev, msg_mark, &frame_len);
 
 	stats->tx_packets++;
+
+	return frame_len;
 }
 
-static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
+static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted,
+			    unsigned int transmitted_frame_len)
 {
 	unsigned long irqflags;
 
+	netdev_completed_queue(cdev->net, transmitted, transmitted_frame_len);
+
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
 	if (cdev->tx_fifo_in_flight >= cdev->tx_fifo_size && transmitted > 0)
 		netif_wake_queue(cdev->net);
@@ -1083,6 +1090,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 	int err = 0;
 	unsigned int msg_mark;
 	int processed = 0;
+	unsigned int processed_frame_len = 0;
 
 	struct m_can_classdev *cdev = netdev_priv(dev);
 
@@ -1111,7 +1119,9 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		fgi = (++fgi >= cdev->mcfg[MRAM_TXE].num ? 0 : fgi);
 
 		/* update stats */
-		m_can_tx_update_stats(cdev, msg_mark, timestamp);
+		processed_frame_len += m_can_tx_update_stats(cdev, msg_mark,
+							     timestamp);
+
 		++processed;
 	}
 
@@ -1119,7 +1129,7 @@ static int m_can_echo_tx_event(struct net_device *dev)
 		m_can_write(cdev, M_CAN_TXEFA, FIELD_PREP(TXEFA_EFAI_MASK,
 							  ack_fgi));
 
-	m_can_finish_tx(cdev, processed);
+	m_can_finish_tx(cdev, processed, processed_frame_len);
 
 	return err;
 }
@@ -1194,11 +1204,12 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		if (ir & IR_TC) {
 			/* Transmission Complete Interrupt*/
 			u32 timestamp = 0;
+			unsigned int frame_len;
 
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
-			m_can_tx_update_stats(cdev, 0, timestamp);
-			m_can_finish_tx(cdev, 1);
+			frame_len = m_can_tx_update_stats(cdev, 0, timestamp);
+			m_can_finish_tx(cdev, 1, frame_len);
 		}
 	} else  {
 		if (ir & (IR_TEFN | IR_TEFW)) {
@@ -1714,6 +1725,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	u32 cccr, fdflags;
 	int err;
 	u32 putidx;
+	unsigned int frame_len = can_skb_get_frame_len(skb);
 
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
@@ -1759,7 +1771,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		}
 		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
 
-		can_put_echo_skb(skb, dev, 0, 0);
+		can_put_echo_skb(skb, dev, 0, frame_len);
 
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
@@ -1797,7 +1809,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
-		can_put_echo_skb(skb, dev, putidx, 0);
+		can_put_echo_skb(skb, dev, putidx, frame_len);
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
@@ -1868,14 +1880,23 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
 				    struct net_device *dev)
 {
 	struct m_can_classdev *cdev = netdev_priv(dev);
+	netdev_tx_t ret;
+	unsigned int frame_len;
 
 	if (can_dev_dropped_skb(dev, skb))
 		return NETDEV_TX_OK;
 
+	frame_len = can_skb_get_frame_len(skb);
+
 	if (cdev->is_peripheral)
-		return m_can_start_peripheral_xmit(cdev, skb);
+		ret = m_can_start_peripheral_xmit(cdev, skb);
 	else
-		return m_can_start_fast_xmit(cdev, skb);
+		ret = m_can_start_fast_xmit(cdev, skb);
+
+	if (ret == NETDEV_TX_OK)
+		netdev_sent_queue(dev, frame_len);
+
+	return ret;
 }
 
 static int m_can_open(struct net_device *dev)
-- 
2.40.1



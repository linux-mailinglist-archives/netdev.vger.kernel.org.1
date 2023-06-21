Return-Path: <netdev+bounces-12515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57B737EF6
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F1A281504
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A454B11CA1;
	Wed, 21 Jun 2023 09:24:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9295711C8A
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:27 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB71BCF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:08 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so4554476f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339447; x=1689931447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6rWS7bREqVUPkH2+6lOc5shnNXmaz1zo3KIcC701tw=;
        b=IdEDUigz2e/1Ljo91fcbJy4qTNc9c2A1u+FPRbyB8azGWrnWOlz8CI9bAgex0hX5Ji
         lAYk97/j3J9lMM1ctK9UHR2RWC3j355Hhwpm8vmbM9ZQEBWPuiVzcIkVjSA9gAi6fIYG
         O8EMOLbEGToTe7G4tBI6j58uRHEIQusPTHaqqKISVYBNirpiJiCylWAGn7MYYkKD+LYA
         lg7YIDwv9hXrGUcqEWn9z/ER8DCRNlFuLykGE/ScENkQxi32fE7segAodG6Za+A9uxf9
         UPbJRYKHPbZ5ByaCIzmM/wKjXLyKB0yo1RwawzcljcSnpmlFhMZJvyD8ydmuzfH8TJyf
         NQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339447; x=1689931447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6rWS7bREqVUPkH2+6lOc5shnNXmaz1zo3KIcC701tw=;
        b=RPNBksM4Fm+5OL4xPQY1813QQLIZ0xnPER+YiIvzsZ9eHoqI1aN3Rcr0YOL62SXtH/
         r78IWqVaj2saZ5PL6A5JErbmhL5mu3kPVbOyf9Un6O/1efiDaj388xpjHDo/XX1dGpZp
         Tdut+tyhprU9eQJxfLyiUG0gxKmrU5IAA0J5rRf5qRhYQVpANy7feXXaXGZJlNRxzLUv
         Ihh3LRln0pxa62deawhtkCqV57gXzOnFcBvawtH6HY/ZX9gnpNUvmP2W86XUl0l5i1nw
         5fipXkHvpIWmkPtob1lnCG/k9WalLRjf7UhHILU8mR+BtTopgYaBCfDZSzxMASIQyKBC
         Bbpg==
X-Gm-Message-State: AC+VfDwSw31y5YMaETxTLpL2Hw9JW0vsJhoojNYXyR8fh0/V7+aPwZbu
	yz1ZzYmGh8ZBnhTFPK4UWsYamg==
X-Google-Smtp-Source: ACHHUZ7Hf03F0mBOItRu/4VKUOpNvvg+HFqjLdZlDboDYL+3+UE5WRdooJkg/Wd1jJz1qWmXU1PPIw==
X-Received: by 2002:adf:f409:0:b0:311:3eaf:f011 with SMTP id g9-20020adff409000000b003113eaff011mr7583058wro.19.1687339447165;
        Wed, 21 Jun 2023 02:24:07 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:06 -0700 (PDT)
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
Subject: [PATCH v4 10/12] can: m_can: Use tx_fifo_in_flight for netif_queue control
Date: Wed, 21 Jun 2023 11:23:48 +0200
Message-Id: <20230621092350.3130866-11-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621092350.3130866-1-msp@baylibre.com>
References: <20230621092350.3130866-1-msp@baylibre.com>
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

The network queue is currently always stopped in start_xmit and
continued in the interrupt handler. This is not possible anymore if we
want to keep multiple transmits in flight in parallel.

Use the previously introduced tx_fifo_in_flight counter to control the
network queue instead. This has the benefit of not needing to ask the
hardware about fifo status.

This patch stops the network queue in start_xmit if the number of
transmits in flight reaches the size of the fifo and wakes up the queue
from the interrupt handler once the transmits in flight drops below the
fifo size. This means any skbs over the limit will be rejected
immediately in start_xmit (it shouldn't be possible at all to reach that
state anyways).

The maximum number of transmits in flight is the size of the fifo.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 85 +++++++++++------------------------
 1 file changed, 26 insertions(+), 59 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 3353fd9fb3a2..38bdab9b5cd6 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -376,16 +376,6 @@ m_can_txe_fifo_read(struct m_can_classdev *cdev, u32 fgi, u32 offset, u32 *val)
 	return cdev->ops->read_fifo(cdev, addr_offset, val, 1);
 }
 
-static inline bool _m_can_tx_fifo_full(u32 txfqs)
-{
-	return !!(txfqs & TXFQS_TFQF);
-}
-
-static inline bool m_can_tx_fifo_full(struct m_can_classdev *cdev)
-{
-	return _m_can_tx_fifo_full(m_can_read(cdev, M_CAN_TXFQS));
-}
-
 static void m_can_config_endisable(struct m_can_classdev *cdev, bool enable)
 {
 	u32 cccr = m_can_read(cdev, M_CAN_CCCR);
@@ -1056,17 +1046,31 @@ static void m_can_finish_tx(struct m_can_classdev *cdev, int transmitted)
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
+	if (cdev->tx_fifo_in_flight >= cdev->tx_fifo_size && transmitted > 0)
+		netif_wake_queue(cdev->net);
 	cdev->tx_fifo_in_flight -= transmitted;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
 }
 
-static void m_can_start_tx(struct m_can_classdev *cdev)
+static netdev_tx_t m_can_start_tx(struct m_can_classdev *cdev)
 {
 	unsigned long irqflags;
+	int tx_fifo_in_flight;
 
 	spin_lock_irqsave(&cdev->tx_handling_spinlock, irqflags);
-	++cdev->tx_fifo_in_flight;
+	tx_fifo_in_flight = cdev->tx_fifo_in_flight + 1;
+	if (tx_fifo_in_flight >= cdev->tx_fifo_size) {
+		netif_stop_queue(cdev->net);
+		if (tx_fifo_in_flight > cdev->tx_fifo_size) {
+			netdev_err_once(cdev->net, "hard_xmit called while TX FIFO full\n");
+			spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+			return NETDEV_TX_BUSY;
+		}
+	}
+	cdev->tx_fifo_in_flight = tx_fifo_in_flight;
 	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
+
+	return NETDEV_TX_OK;
 }
 
 static int m_can_echo_tx_event(struct net_device *dev)
@@ -1194,7 +1198,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			if (cdev->is_peripheral)
 				timestamp = m_can_get_timestamp(cdev);
 			m_can_tx_update_stats(cdev, 0, timestamp);
-			netif_wake_queue(dev);
 			m_can_finish_tx(cdev, 1);
 		}
 	} else  {
@@ -1202,10 +1205,6 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 			/* New TX FIFO Element arrived */
 			if (m_can_echo_tx_event(dev) != 0)
 				goto out_fail;
-
-			if (netif_queue_stopped(dev) &&
-			    !m_can_tx_fifo_full(cdev))
-				netif_wake_queue(dev);
 		}
 	}
 
@@ -1705,20 +1704,6 @@ static int m_can_close(struct net_device *dev)
 	return 0;
 }
 
-static int m_can_next_echo_skb_occupied(struct net_device *dev, u32 putidx)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	/*get wrap around for loopback skb index */
-	unsigned int wrap = cdev->can.echo_skb_max;
-	u32 next_idx;
-
-	/* calculate next index */
-	next_idx = (++putidx >= wrap ? 0 : putidx);
-
-	/* check if occupied */
-	return !!cdev->can.echo_skb[next_idx];
-}
-
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 				    struct sk_buff *skb)
 {
@@ -1728,7 +1713,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	struct net_device *dev = cdev->net;
 	struct id_and_dlc fifo_header;
 	u32 cccr, fdflags;
-	u32 txfqs;
 	int err;
 	u32 putidx;
 
@@ -1783,24 +1767,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	} else {
 		/* Transmit routine for version >= v3.1.x */
 
-		txfqs = m_can_read(cdev, M_CAN_TXFQS);
-
-		/* Check if FIFO full */
-		if (_m_can_tx_fifo_full(txfqs)) {
-			/* This shouldn't happen */
-			netif_stop_queue(dev);
-			netdev_warn(dev,
-				    "TX queue active although FIFO is full.");
-
-			if (cdev->is_peripheral) {
-				kfree_skb(skb);
-				dev->stats.tx_dropped++;
-				return NETDEV_TX_OK;
-			} else {
-				return NETDEV_TX_BUSY;
-			}
-		}
-
 		/* get put index for frame */
 		putidx = cdev->tx_fifo_putidx;
 
@@ -1838,11 +1804,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
 		cdev->tx_fifo_putidx = (++cdev->tx_fifo_putidx >= cdev->can.echo_skb_max ?
 					0 : cdev->tx_fifo_putidx);
-
-		/* stop network queue if fifo full */
-		if (m_can_tx_fifo_full(cdev) ||
-		    m_can_next_echo_skb_occupied(dev, putidx))
-			netif_stop_queue(dev);
 	}
 
 	return NETDEV_TX_OK;
@@ -1876,14 +1837,16 @@ static void m_can_tx_queue_skb(struct m_can_classdev *cdev, struct sk_buff *skb)
 static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 					       struct sk_buff *skb)
 {
+	netdev_tx_t err;
+
 	if (cdev->can.state == CAN_STATE_BUS_OFF) {
 		m_can_clean(cdev->net);
 		return NETDEV_TX_OK;
 	}
 
-	netif_stop_queue(cdev->net);
-
-	m_can_start_tx(cdev);
+	err = m_can_start_tx(cdev);
+	if (err != NETDEV_TX_OK)
+		return err;
 
 	m_can_tx_queue_skb(cdev, skb);
 
@@ -1893,7 +1856,11 @@ static netdev_tx_t m_can_start_peripheral_xmit(struct m_can_classdev *cdev,
 static netdev_tx_t m_can_start_fast_xmit(struct m_can_classdev *cdev,
 					 struct sk_buff *skb)
 {
-	m_can_start_tx(cdev);
+	netdev_tx_t err;
+
+	err = m_can_start_tx(cdev);
+	if (err != NETDEV_TX_OK)
+		return err;
 
 	return m_can_tx_handler(cdev, skb);
 }
-- 
2.40.1



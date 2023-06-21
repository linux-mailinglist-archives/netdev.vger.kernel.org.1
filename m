Return-Path: <netdev+bounces-12516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB6C737EF7
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A8A1C20E4F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329DF125C7;
	Wed, 21 Jun 2023 09:24:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F78125AF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:28 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC761BD3
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311367a3e12so4736773f8f.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339448; x=1689931448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnUnzSIjjASfPwMtskRGblxnthY3N6SsU/Hyarpa4rM=;
        b=yjtIIVhkCxt+LK4zSutC32yInmFrQPo5BiQFauqWivAsL1FhOmTYP0rQ5Lx8m5N7wc
         ZFefMPgm0r3cPw6uYOVgeDMe837pyzSLVvSyCk6JtWgZP+VV+/v26YLldf9XYQ1vvuk9
         ceMef06EL50wQBiJloKbb+dd+4xvgkZg/a1Au1OioI2Q0uCumXRgMMLL5d4Nc9X0lnAW
         sovSPJe3MXmpZWX5SMO2Zv4FLEEr5MTK3EifoPa/0EHJvUrKu3lPgISvCxaKCVxkL9Yz
         RYl5gftoSeS/WkyZXZlG5s3iXNx1oURdhOBg1ITYQCzcKct13A0I/fb6rrvG+1Gpvdro
         00zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339448; x=1689931448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnUnzSIjjASfPwMtskRGblxnthY3N6SsU/Hyarpa4rM=;
        b=iCC32CXkFAy+CuCG0c7dx/02zv9+UvdrTmBqxhDR9Xd2bhFgzU+tNvdf4dvMy4gw//
         IpLi1ysocFNBwl0yrtNM+gUReoGa5S0VOEL/mncFa/998OsQgcMyPlMmr1wpjicPdANx
         cKTGHq1hntn8b//lYaLt77BTXGuaG8x5WQ6jaVvPYxZ6292GJRn850Yn3SZivR/HLeVN
         HrB1oXFho5afWQ2z04zCJle6q14uFSi8seH+Wg0OfF4+t/lW5tGkNZfBIzuXdPMutTJs
         m8arwLr9L8pSjZiab+khXCBnDJcDORw9axu2gt96yy7cTcJYoTHgy9pbF8GxmyPYeJxX
         G0iw==
X-Gm-Message-State: AC+VfDx5VJyIvfLqFq3IVdv4w11KB3fl4fp0TWAzQzH2Zl39KNvHWSHV
	E7DbEwtM8jxfK52ybaXDMwvr+w==
X-Google-Smtp-Source: ACHHUZ67eiO14Pu0Mziq4FMbdAuhxUlX/AOXJx8zGLQAp+oleHDmnpGNQHpIOEBFogxNuKTbSdnYNA==
X-Received: by 2002:adf:fc47:0:b0:30f:b953:f9fa with SMTP id e7-20020adffc47000000b0030fb953f9famr12220712wrs.16.1687339448146;
        Wed, 21 Jun 2023 02:24:08 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:24:07 -0700 (PDT)
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
Subject: [PATCH v4 11/12] can: m_can: Implement BQL
Date: Wed, 21 Jun 2023 11:23:49 +0200
Message-Id: <20230621092350.3130866-12-msp@baylibre.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement byte queue limiting in preparation for the use of xmit_more().

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 drivers/net/can/m_can/m_can.c | 49 +++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 38bdab9b5cd6..62e275c87c29 100644
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
@@ -1715,6 +1726,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 	u32 cccr, fdflags;
 	int err;
 	u32 putidx;
+	unsigned int frame_len = can_skb_get_frame_len(skb);
 
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
@@ -1760,7 +1772,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		}
 		m_can_write(cdev, M_CAN_TXBTIE, 0x1);
 
-		can_put_echo_skb(skb, dev, 0, 0);
+		can_put_echo_skb(skb, dev, 0, frame_len);
 
 		m_can_write(cdev, M_CAN_TXBAR, 0x1);
 		/* End of xmit function for version 3.0.x */
@@ -1798,7 +1810,7 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 		/* Push loopback echo.
 		 * Will be looped back on TX interrupt based on message marker
 		 */
-		can_put_echo_skb(skb, dev, putidx, 0);
+		can_put_echo_skb(skb, dev, putidx, frame_len);
 
 		/* Enable TX FIFO element to start transfer  */
 		m_can_write(cdev, M_CAN_TXBAR, (1 << putidx));
@@ -1869,14 +1881,23 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
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



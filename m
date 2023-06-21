Return-Path: <netdev+bounces-12506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E7A737EDD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13301C20DBF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9054AD2EA;
	Wed, 21 Jun 2023 09:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A945D2E0
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:24:17 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D219BB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f9bdb01ec0so5678935e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339437; x=1689931437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IztrjGfMix5tskQ3YAq+GbppbknMQpNbHYwT+eFcuyg=;
        b=SSp73YYGJCLinA3gBiXji4iBZRTLr1zODBJib8/+eDTd0p8hHxbpzpM4rDaJTwBI2q
         wUXpB2ygTtS94+2COr8bDgaPanKW63gfCFh8/wUg0IxDRX1gjlJZwbSnb626jiDo8gaf
         VUzhtMUnB8UGGPKQD3cV5kEMtsMlUPtg+ydQr0DRUnOOT6d7kEAyuEs36aMiVDVXMVS5
         M8SpQtwBxKw/HIZpqdgdixsdKHnbZpzrVMsyD4tJC0Ooaked6WlOqngC6HkK5U1rDriR
         hW+86VycgFP9UpOLwPDHBfgK4bxIvKl52rvFKyjT9maD01ncc+frQmQ2c4O8C5GI+GyG
         LzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339437; x=1689931437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IztrjGfMix5tskQ3YAq+GbppbknMQpNbHYwT+eFcuyg=;
        b=V+USY3h/Kf9VVzjS1XRDvIZLHKFEPJs9gG9Y1HEDZKFwmrevLj1nxmXTsk9bEscVvd
         bx6gG/ZKPAXuoZyjCBSH9S39Hmn8/fgT2MAtI+KC467E+gPgHGKylxPtydMgYvkFyzpm
         1zlxNdw910+0h30GKg4ZrRlWC4iN9QFAESVZe3aqAel/cJL9slW+1Y/gJzrMg6t2Qf0r
         9z+LkbCQw9syD3lMLWvrQkqO47raZAjJ51aexKwgBjKsd7PjQhMesrKy1+cGGzSXUtJk
         aGMO01ybdy7smJDQNZ9RCKc9RKFd44dSP6Qphgw1dymKvQIZbME9dpXbfDED3uN0Mzn8
         sJ0g==
X-Gm-Message-State: AC+VfDxYy0OtPPzHpAkCrLwrUw5jsDCf9pCRyo9OhBmxfI7KMt3i+R0Q
	xJx3bkT6eU5yNPrZG0WFcazlYg==
X-Google-Smtp-Source: ACHHUZ7Vo13JGDVZQSjULWo0WPguFw67QsOvIqSW0HuJYblfXvkL1s9M7ZcAEi86X/sdw/NPQyzlbQ==
X-Received: by 2002:a7b:c405:0:b0:3f9:b1c5:ece0 with SMTP id k5-20020a7bc405000000b003f9b1c5ece0mr5500353wmi.10.1687339437046;
        Wed, 21 Jun 2023 02:23:57 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id i11-20020adffdcb000000b002fda1b12a0bsm4022115wrs.2.2023.06.21.02.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:23:56 -0700 (PDT)
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
Subject: [PATCH v4 01/12] can: m_can: Write transmit header and data in one transaction
Date: Wed, 21 Jun 2023 11:23:39 +0200
Message-Id: <20230621092350.3130866-2-msp@baylibre.com>
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

Combine header and data before writing to the transmit fifo to reduce
the overhead for peripheral chips.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index a5003435802b..5251073987ee 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -317,6 +317,12 @@ struct id_and_dlc {
 	u32 dlc;
 };
 
+struct m_can_fifo_element {
+	u32 id;
+	u32 dlc;
+	u8 data[CANFD_MAX_DLEN];
+};
+
 static inline u32 m_can_read(struct m_can_classdev *cdev, enum m_can_reg reg)
 {
 	return cdev->ops->read_reg(cdev, reg);
@@ -1622,6 +1628,8 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
 static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 {
 	struct canfd_frame *cf = (struct canfd_frame *)cdev->tx_skb->data;
+	u8 len_padded = DIV_ROUND_UP(cf->len, 4);
+	struct m_can_fifo_element fifo_element;
 	struct net_device *dev = cdev->net;
 	struct sk_buff *skb = cdev->tx_skb;
 	struct id_and_dlc fifo_header;
@@ -1635,27 +1643,27 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 	/* Generate ID field for TX buffer Element */
 	/* Common to all supported M_CAN versions */
 	if (cf->can_id & CAN_EFF_FLAG) {
-		fifo_header.id = cf->can_id & CAN_EFF_MASK;
-		fifo_header.id |= TX_BUF_XTD;
+		fifo_element.id = cf->can_id & CAN_EFF_MASK;
+		fifo_element.id |= TX_BUF_XTD;
 	} else {
-		fifo_header.id = ((cf->can_id & CAN_SFF_MASK) << 18);
+		fifo_element.id = ((cf->can_id & CAN_SFF_MASK) << 18);
 	}
 
 	if (cf->can_id & CAN_RTR_FLAG)
-		fifo_header.id |= TX_BUF_RTR;
+		fifo_element.id |= TX_BUF_RTR;
 
 	if (cdev->version == 30) {
 		netif_stop_queue(dev);
 
-		fifo_header.dlc = can_fd_len2dlc(cf->len) << 16;
+		fifo_element.dlc = can_fd_len2dlc(cf->len) << 16;
 
 		/* Write the frame ID, DLC, and payload to the FIFO element. */
-		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_header, 2);
+		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_ID, &fifo_element, 2);
 		if (err)
 			goto out_fail;
 
 		err = m_can_fifo_write(cdev, 0, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+				       cf->data, len_padded);
 		if (err)
 			goto out_fail;
 
@@ -1717,15 +1725,15 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev)
 				fdflags |= TX_BUF_BRS;
 		}
 
-		fifo_header.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
+		fifo_element.dlc = FIELD_PREP(TX_BUF_MM_MASK, putidx) |
 			FIELD_PREP(TX_BUF_DLC_MASK, can_fd_len2dlc(cf->len)) |
 			fdflags | TX_BUF_EFC;
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID, &fifo_header, 2);
-		if (err)
-			goto out_fail;
 
-		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_DATA,
-				       cf->data, DIV_ROUND_UP(cf->len, 4));
+		memcpy_and_pad(fifo_element.data, CANFD_MAX_DLEN, &cf->data,
+			       cf->len, 0);
+
+		err = m_can_fifo_write(cdev, putidx, M_CAN_FIFO_ID,
+				       &fifo_element, 2 + len_padded);
 		if (err)
 			goto out_fail;
 
-- 
2.40.1



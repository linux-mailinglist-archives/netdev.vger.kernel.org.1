Return-Path: <netdev+bounces-12637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A54738565
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990FB1C20EE6
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E8819E57;
	Wed, 21 Jun 2023 13:29:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9419E54
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:53 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1AD1BE7
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:29:40 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qBxty-000760-09
	for netdev@vger.kernel.org; Wed, 21 Jun 2023 15:29:38 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6C68B1DE94D
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 8433F1DE8F3;
	Wed, 21 Jun 2023 13:29:20 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 70da4ea8;
	Wed, 21 Jun 2023 13:29:17 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/33] can: kvaser_pciefd: Change return type for kvaser_pciefd_{receive,transmit,set_tx}_irq()
Date: Wed, 21 Jun 2023 15:29:09 +0200
Message-Id: <20230621132914.412546-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621132914.412546-1-mkl@pengutronix.de>
References: <20230621132914.412546-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jimmy Assarsson <extja@kvaser.com>

Change return type to void for kvaser_pciefd_transmit_irq(),
kvaser_pciefd_receive_irq() and kvaser_pciefd_set_tx_irq().
These functions always return zero.

Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-10-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index bf3fa51069a9..feef044c6b0a 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -338,7 +338,7 @@ static void kvaser_pciefd_disable_err_gen(struct kvaser_pciefd_can *can)
 	spin_unlock_irqrestore(&can->lock, irq);
 }
 
-static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 {
 	u32 msk;
 
@@ -349,8 +349,6 @@ static int kvaser_pciefd_set_tx_irq(struct kvaser_pciefd_can *can)
 	      KVASER_PCIEFD_KCAN_IRQ_TAR;
 
 	iowrite32(msk, can->reg_base + KVASER_PCIEFD_KCAN_IEN_REG);
-
-	return 0;
 }
 
 static inline void kvaser_pciefd_set_skb_timestamp(const struct kvaser_pciefd *pcie,
@@ -1456,7 +1454,7 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 	return res;
 }
 
-static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
+static void kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 {
 	u32 irq;
 
@@ -1482,10 +1480,9 @@ static int kvaser_pciefd_receive_irq(struct kvaser_pciefd *pcie)
 		dev_err(&pcie->pci->dev, "DMA IRQ error 0x%08X\n", irq);
 
 	iowrite32(irq, pcie->reg_base + KVASER_PCIEFD_SRB_IRQ_REG);
-	return 0;
 }
 
-static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
+static void kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 {
 	u32 irq = ioread32(can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
 
@@ -1503,7 +1500,6 @@ static int kvaser_pciefd_transmit_irq(struct kvaser_pciefd_can *can)
 		netdev_err(can->can.dev, "Rx FIFO overflow\n");
 
 	iowrite32(irq, can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
-	return 0;
 }
 
 static irqreturn_t kvaser_pciefd_irq_handler(int irq, void *dev)
-- 
2.40.1




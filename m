Return-Path: <netdev+bounces-12630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDDA73854F
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05EB01C209FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510711992D;
	Wed, 21 Jun 2023 13:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5A19921
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:47 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351461BC6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:29:36 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qBxtt-0006ya-To
	for netdev@vger.kernel.org; Wed, 21 Jun 2023 15:29:33 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id B1A9D1DE930
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 13:29:21 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5DD5A1DE8BB;
	Wed, 21 Jun 2023 13:29:19 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 347620ee;
	Wed, 21 Jun 2023 13:29:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jimmy Assarsson <extja@kvaser.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/33] can: kvaser_pciefd: Remove handler for unused KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK
Date: Wed, 21 Jun 2023 15:29:02 +0200
Message-Id: <20230621132914.412546-22-mkl@pengutronix.de>
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

The Kvaser KCAN controller got a feature to send error frames on request.
The packet KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK signals that the requested
error frame was transmitted.
Since this feature is not supported by the driver, drop the handler and add
KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK to the list of unexpected packet types.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://lore.kernel.org/all/20230529134248.752036-3-extja@kvaser.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/kvaser_pciefd.c | 39 +--------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
index d60d17199a1b..1821ffa4ca79 100644
--- a/drivers/net/can/kvaser_pciefd.c
+++ b/drivers/net/can/kvaser_pciefd.c
@@ -1472,40 +1472,6 @@ static int kvaser_pciefd_handle_status_packet(struct kvaser_pciefd *pcie,
 	return 0;
 }
 
-static int kvaser_pciefd_handle_eack_packet(struct kvaser_pciefd *pcie,
-					    struct kvaser_pciefd_rx_packet *p)
-{
-	struct kvaser_pciefd_can *can;
-	u8 ch_id = (p->header[1] >> KVASER_PCIEFD_PACKET_CHID_SHIFT) & 0x7;
-
-	if (ch_id >= pcie->nr_channels)
-		return -EIO;
-
-	can = pcie->can[ch_id];
-
-	/* If this is the last flushed packet, send end of flush */
-	if (p->header[0] & KVASER_PCIEFD_APACKET_FLU) {
-		u8 count = ioread32(can->reg_base +
-				    KVASER_PCIEFD_KCAN_TX_NPACKETS_REG) & 0xff;
-
-		if (count == 0)
-			iowrite32(KVASER_PCIEFD_KCAN_CTRL_EFLUSH,
-				  can->reg_base + KVASER_PCIEFD_KCAN_CTRL_REG);
-	} else {
-		int echo_idx = p->header[0] & KVASER_PCIEFD_PACKET_SEQ_MSK;
-		int dlc = can_get_echo_skb(can->can.dev, echo_idx, NULL);
-		struct net_device_stats *stats = &can->can.dev->stats;
-
-		stats->tx_bytes += dlc;
-		stats->tx_packets++;
-
-		if (netif_queue_stopped(can->can.dev))
-			netif_wake_queue(can->can.dev);
-	}
-
-	return 0;
-}
-
 static void kvaser_pciefd_handle_nack_packet(struct kvaser_pciefd_can *can,
 					     struct kvaser_pciefd_rx_packet *p)
 {
@@ -1644,16 +1610,13 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 		ret = kvaser_pciefd_handle_error_packet(pcie, p);
 		break;
 
-	case KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK:
-		ret = kvaser_pciefd_handle_eack_packet(pcie, p);
-		break;
-
 	case KVASER_PCIEFD_PACK_TYPE_EFLUSH_ACK:
 		ret = kvaser_pciefd_handle_eflush_packet(pcie, p);
 		break;
 
 	case KVASER_PCIEFD_PACK_TYPE_ACK_DATA:
 	case KVASER_PCIEFD_PACK_TYPE_BUS_LOAD:
+	case KVASER_PCIEFD_PACK_TYPE_EFRAME_ACK:
 	case KVASER_PCIEFD_PACK_TYPE_TXRQ:
 		dev_info(&pcie->pci->dev,
 			 "Received unexpected packet type 0x%08X\n", type);
-- 
2.40.1




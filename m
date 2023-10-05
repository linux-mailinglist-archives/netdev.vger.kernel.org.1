Return-Path: <netdev+bounces-38391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84C7BAAF4
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 65CE6282116
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50442BE4;
	Thu,  5 Oct 2023 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473D41AA9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:28 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE8E7
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:58:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUK-0004n7-08
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:24 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1qoUUF-00BLJB-G1
	for netdev@vger.kernel.org; Thu, 05 Oct 2023 21:58:19 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 6B99723000E
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 19:58:18 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 7D9EC22FF84;
	Thu,  5 Oct 2023 19:58:15 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e0cf1751;
	Thu, 5 Oct 2023 19:58:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 13/37] can: at91_can: at91_irq_tx(): remove one level of indention
Date: Thu,  5 Oct 2023 21:57:48 +0200
Message-Id: <20231005195812.549776-14-mkl@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231005195812.549776-1-mkl@pengutronix.de>
References: <20231005195812.549776-1-mkl@pengutronix.de>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Improve code readability by removing one level of indention.

If a mailbox is not ready, continue the loop early.

Link: https://lore.kernel.org/all/20231005-at91_can-rx_offload-v2-3-9987d53600e0@pengutronix.de
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/at91_can.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 367ccf109652..966980d4b5dd 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -844,15 +844,14 @@ static void at91_irq_tx(struct net_device *dev, u32 reg_sr)
 		 * parked in the echo queue.
 		 */
 		reg_msr = at91_read(priv, AT91_MSR(mb));
-		if (likely(reg_msr & AT91_MSR_MRDY &&
-			   ~reg_msr & AT91_MSR_MABT)) {
-			/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
-			dev->stats.tx_bytes +=
-				can_get_echo_skb(dev,
-						 mb - get_mb_tx_first(priv),
-						 NULL);
-			dev->stats.tx_packets++;
-		}
+		if (unlikely(!(reg_msr & AT91_MSR_MRDY &&
+			       ~reg_msr & AT91_MSR_MABT)))
+			continue;
+
+		/* _NOTE_: subtract AT91_MB_TX_FIRST offset from mb! */
+		dev->stats.tx_bytes +=
+			can_get_echo_skb(dev, mb - get_mb_tx_first(priv), NULL);
+		dev->stats.tx_packets++;
 	}
 
 	/* restart queue if we don't have a wrap around but restart if
-- 
2.40.1




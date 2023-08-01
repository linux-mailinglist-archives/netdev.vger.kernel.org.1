Return-Path: <netdev+bounces-23221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318176B59F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903CA1C20D88
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6521519;
	Tue,  1 Aug 2023 13:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CFD20F9D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:17:14 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E4E9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:17:10 -0700 (PDT)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1690895828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZFKfHLoVK9VEbE1gzJayVggljFTpIvHncJSI/OphfcE=;
	b=F68TrbxVcfZfIMFVW4nQS25E6uI1rOhJnnrLE1GXmZAkjh7YrRS3qaAAae0kKYfJybWENa
	Ma30UHNfbR7XrspfZNOV7QtGCaYZ5PCcgVMGNrcQUbSjl96lbf3sOD1JVM1jNqDo/8J8pL
	iSR+CtpJU9HeldBIAH5GoLvvaBsxDMB5bVkzEHNmoZGOxn60eEA6pXyXno3zb/4ZwQ1f6y
	cNbKd0bUx9zZGVqxLYrGZ7VtneAK8oVZoryDj4Po7stSFBHZhTCXUXhsR6DhcWm+ukiJ3K
	/nHWuy/gJ9SBhYiy4BfbPjqHX3KZTF4uDbDNObp7n0QPDdKvDlJkqXn3c6bDmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1690895828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZFKfHLoVK9VEbE1gzJayVggljFTpIvHncJSI/OphfcE=;
	b=5/LXpZQcxgZFJWm+Vdnc6+5+ilbjrvopL0Zr/uoMvw5PZcmS2Uc3laynVjzjvOCYi4+guX
	PqtJ/SSCEttO1TAg==
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next] net: dsa: hellcreek: Replace bogus comment
Date: Tue,  1 Aug 2023 15:16:47 +0200
Message-Id: <20230801131647.84697-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Replace bogus comment about matching the latched timestamp to one of the
received frames. That comment is probably copied from mv88e6xxx and true for
these switches. However, the hellcreek switch is configured to insert the
timestamp directly into the PTP packets.

While here, remove the other comments regarding the list splicing and locking as
well, because it doesn't add any value.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
index ffd06cf8c44f..bd7aacc71a63 100644
--- a/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
+++ b/drivers/net/dsa/hirschmann/hellcreek_hwtstamp.c
@@ -298,17 +298,10 @@ static void hellcreek_get_rxts(struct hellcreek *hellcreek,
 	struct sk_buff_head received;
 	unsigned long flags;
 
-	/* The latched timestamp belongs to one of the received frames. */
+	/* Construct Rx timestamps for all received PTP packets. */
 	__skb_queue_head_init(&received);
-
-	/* Lock & disable interrupts */
 	spin_lock_irqsave(&rxq->lock, flags);
-
-	/* Add the reception queue "rxq" to the "received" queue an reintialize
-	 * "rxq".  From now on, we deal with "received" not with "rxq"
-	 */
 	skb_queue_splice_tail_init(rxq, &received);
-
 	spin_unlock_irqrestore(&rxq->lock, flags);
 
 	for (; skb; skb = __skb_dequeue(&received)) {
-- 
2.39.2



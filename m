Return-Path: <netdev+bounces-278302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EoTKN3j3WnskwkAu9opvQ
	(envelope-from <netdev+bounces-278302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4694C3F6444
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 626293000B25
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36833F5B6;
	Tue, 14 Apr 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvZUHNW6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6592820A9
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776149465; cv=none; b=AJfIvKry22Uqn8Pc+PKovB+IuTKZ4c3EEOjFcolgyUsDu1t4//AQ1Z6q3lexPv2rLOHFElHeAUkkhXykja/fyGe6buStjioT7Oyb94FgZqv4hgRRLfI902tS9pg+ESq8l8zyJP/eYrGxZpmjAhd1NrdM+5raY4gZfUmJlUE/7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776149465; c=relaxed/simple;
	bh=HZPV2FvJj6UhRn6Km5MahgpIDMpyNJ7h1uzc2GBuNik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gfb7k98rR+3dM7yeskuCr+SntUfdryxMDNJtCPjrKm4Y5EPesG2+/YZaqi9nVbVLCJfUkaBlb9ivPgVkoymblcCxOY71be5GUH5L3W+5l9P9/ZSBKJhz65yGWVlBJV3ASumof5jn3wGgsIN+hW7ZHlUX7jJOcEnr+ZT4Blv9gU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvZUHNW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD8EC19425;
	Tue, 14 Apr 2026 06:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776149465;
	bh=HZPV2FvJj6UhRn6Km5MahgpIDMpyNJ7h1uzc2GBuNik=;
	h=From:Date:Subject:To:Cc:From;
	b=tvZUHNW6QwYV21WEXKJLZ3MqI+TIicgCniMqgtVY0ou5dJL2snWpFw3cNucFcF66M
	 gxa6sIw2keT+r1zwKWLiMltTMuFA+9tsbOZXz3Mz14zdhQjvBPjqxsmuJP3wkHCbCJ
	 I/9A41HV0c9ij3CN44cpXxa2YVN6MCVky/VcJfpOV6W1wwMeq1/3cb/gJHBLUoRDn5
	 8IhyClnaRQ3nueHqNvjAsJNT02dSBHlzH9GP5yFwKgKfvdg63lAYcSzN5SPjKhiP41
	 e/1BRjYsOuRsqkxGiO3eNMnkCoc4OY9NCdl0F2YoOmv9OoKqX1q4xyB3iEX4OyZ5+I
	 iFl7/UuUubGQw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 14 Apr 2026 08:50:52 +0200
Subject: [PATCH net v2] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WNQQ6CMBREr0L+2pp+EIuuvIchTYVfaMQWWiAY0
 rvbcAOXb2Yyb4dA3lCAe7aDp9UE42yC/JRB0yvbETNtYsh5fuUX5EwZ73olp/ajZDOQssso501
 OCy3EtNmYpZndikKUuiSquIZ0NXpK1aF5QhpAncLehNn576Fe8aj+s6zIkL0ECmwqjSSqx5u8p
 eHsfAd1jPEHqO0DYN4AAAA=
X-Change-ID: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278302-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4694C3F6444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
  order to avoid any possible NULL pointer dereference in
  airoha_qdma_cleanup_tx_queue()
- Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
- Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 41 ++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9e995094c32a..3c1a2bc68c42 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -966,27 +966,27 @@ static int airoha_qdma_init_tx_queue(struct airoha_queue *q,
 	dma_addr_t dma_addr;
 
 	spin_lock_init(&q->lock);
-	q->ndesc = size;
 	q->qdma = qdma;
 	q->free_thr = 1 + MAX_SKB_FRAGS;
 	INIT_LIST_HEAD(&q->tx_list);
 
-	q->entry = devm_kzalloc(eth->dev, q->ndesc * sizeof(*q->entry),
+	q->entry = devm_kzalloc(eth->dev, size * sizeof(*q->entry),
 				GFP_KERNEL);
 	if (!q->entry)
 		return -ENOMEM;
 
-	q->desc = dmam_alloc_coherent(eth->dev, q->ndesc * sizeof(*q->desc),
+	q->desc = dmam_alloc_coherent(eth->dev, size * sizeof(*q->desc),
 				      &dma_addr, GFP_KERNEL);
 	if (!q->desc)
 		return -ENOMEM;
 
-	for (i = 0; i < q->ndesc; i++) {
+	for (i = 0; i < size; i++) {
 		u32 val = FIELD_PREP(QDMA_DESC_DONE_MASK, 1);
 
 		list_add_tail(&q->entry[i].list, &q->tx_list);
 		WRITE_ONCE(q->desc[i].ctrl, cpu_to_le32(val));
 	}
+	q->ndesc = size;
 
 	/* xmit ring drop default setting */
 	airoha_qdma_set(qdma, REG_TX_RING_BLOCKING(qid),
@@ -1051,13 +1051,17 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->qdma->eth;
-	int i;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int i, qid = q - &qdma->q_tx[0];
+	struct airoha_queue_entry *e;
+	u16 index = 0;
 
 	spin_lock_bh(&q->lock);
 	for (i = 0; i < q->ndesc; i++) {
-		struct airoha_queue_entry *e = &q->entry[i];
+		struct airoha_qdma_desc *desc = &q->desc[i];
 
+		e = &q->entry[i];
 		if (!e->dma_addr)
 			continue;
 
@@ -1067,8 +1071,31 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 		e->dma_addr = 0;
 		e->skb = NULL;
 		list_add_tail(&e->list, &q->tx_list);
+
+		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->ctrl, 0);
+		WRITE_ONCE(desc->addr, 0);
+		WRITE_ONCE(desc->data, 0);
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		WRITE_ONCE(desc->msg2, 0);
+
 		q->queued--;
 	}
+
+	if (!list_empty(&q->tx_list)) {
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+				     list);
+		index = e - q->entry;
+	}
+	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+
 	spin_unlock_bh(&q->lock);
 }
 

---
base-commit: 2cd7e6971fc2787408ceef17906ea152791448cf
change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>



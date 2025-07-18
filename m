Return-Path: <netdev+bounces-208053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332DAB098D5
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 02:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5261C45B55
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 00:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D391EF1D;
	Fri, 18 Jul 2025 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wxn7tPXf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982542A82
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797665; cv=none; b=QG41AiqCUjgkVNMJHRKVGP9FkPNa0o0oC60niewy4ru8VlrypBH374BHugwQ8RoKHGMtaHG7Pcvr8JWdb2t2EDaXt3Z6THe8rYCLbf/SPLvj1cNeKqVnRvzaAH2IPN3KuucDX2DX6e5SvPo4scr1Vo1NnvwmSArV43GaHwvHrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797665; c=relaxed/simple;
	bh=/bDwmFFINpIWRR5SK/PG7nXu1gtBUvYiwYzW8LY6Lw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9aGULasDOKlslceBqFxp3NoICQGAWLprqrCBLp9nJWw1ljEr94ir3wb/7QA9eCVkROMI1D57QcIB29H09UhGLrs6060GPtDCi5s9M5gItJwSxxXvoBG9Y0TD86GDUMXw4Fqjgra/O+CO0hWqJCwKyH4qxReXB0qvmYeL8ZuvkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wxn7tPXf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752797664; x=1784333664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bDwmFFINpIWRR5SK/PG7nXu1gtBUvYiwYzW8LY6Lw4=;
  b=Wxn7tPXfotQ8TbQE1jUBzsuq0YxEqQuAoQlCA3z4FjfEdV57/gQKFVdt
   TLsfrFZvRPGi6pAAU5ZNNNvrs6+MvLnV3rLYByTVVS3ALKSUKCvTN1bYb
   75/3ItVnetBHa5eqY7T8XH8XdrVOpUKpLVI9eo8HOljf0ng72mM/N3/A3
   WL/sG7GJXdRarDrP/2vapUs7ls5HvXO0OeIVv4Git0UtvZ9IByrPkVAoW
   AKPJUS81Jp9x3lKpnm774EIUvkv/XOWQ7Wc0gnYU3m8QeePf8dwDAqYct
   /aVxdNn+e6umFaX2y04D6X1+I0I24+dy2DtjCBJsOK2t/I4o38MiMJwQk
   g==;
X-CSE-ConnectionGUID: lnvfjTNUTw6Qxzknb3wXeg==
X-CSE-MsgGUID: /0PPZ6zoTeG/o1S+H27a6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65345433"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65345433"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 17:14:22 -0700
X-CSE-ConnectionGUID: fibbVGaeTz6a3NZJf+bb7A==
X-CSE-MsgGUID: T7suhAqpSoO68c9WoQkTlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="188908854"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.13])
  by fmviesa001.fm.intel.com with ESMTP; 17 Jul 2025 17:14:21 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2 3/6] idpf: simplify and fix splitq Tx packet rollback error path
Date: Thu, 17 Jul 2025 17:21:47 -0700
Message-Id: <20250718002150.2724409-4-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250718002150.2724409-1-joshua.a.hay@intel.com>
References: <20250718002150.2724409-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move (and rename) the existing rollback logic to singleq.c since that
will be the only consumer. Create a simplified splitq specific rollback
function to loop through and unmap tx_bufs based on the completion tag.
This is critical before replacing the Tx buffer ring with the buffer
pool since the previous rollback indexing will not work to unmap the
chained buffers from the pool.

Cache the next_to_use index before any portion of the packet is put on
the descriptor ring. In case of an error, the rollback will bump tail to
the correct next_to_use value. Because the splitq path now supports
different types of context descriptors (and potentially multiple in the
future), this will take care of rolling back any and all context
descriptors encoded on the ring for the erroneous packet. The previous
rollback logic was broken for PTP packets since it would not account for
the PTP context descriptor.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 57 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 91 ++++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  5 +-
 3 files changed, 95 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 993c354aa27a..a3b3261bbdfa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -179,6 +179,58 @@ static int idpf_tx_singleq_csum(struct sk_buff *skb,
 	return 1;
 }
 
+/**
+ * idpf_tx_singleq_dma_map_error - handle TX DMA map errors
+ * @txq: queue to send buffer on
+ * @skb: send buffer
+ * @first: original first buffer info buffer for packet
+ * @idx: starting point on ring to unwind
+ */
+static void idpf_tx_singleq_dma_map_error(struct idpf_tx_queue *txq,
+					  struct sk_buff *skb,
+					  struct idpf_tx_buf *first, u16 idx)
+{
+	struct libeth_sq_napi_stats ss = { };
+	struct libeth_cq_pp cp = {
+		.dev	= txq->dev,
+		.ss	= &ss,
+	};
+
+	u64_stats_update_begin(&txq->stats_sync);
+	u64_stats_inc(&txq->q_stats.dma_map_errs);
+	u64_stats_update_end(&txq->stats_sync);
+
+	/* clear dma mappings for failed tx_buf map */
+	for (;;) {
+		struct idpf_tx_buf *tx_buf;
+
+		tx_buf = &txq->tx_buf[idx];
+		libeth_tx_complete(tx_buf, &cp);
+		if (tx_buf == first)
+			break;
+		if (idx == 0)
+			idx = txq->desc_count;
+		idx--;
+	}
+
+	if (skb_is_gso(skb)) {
+		union idpf_tx_flex_desc *tx_desc;
+
+		/* If we failed a DMA mapping for a TSO packet, we will have
+		 * used one additional descriptor for a context
+		 * descriptor. Reset that here.
+		 */
+		tx_desc = &txq->flex_tx[idx];
+		memset(tx_desc, 0, sizeof(*tx_desc));
+		if (idx == 0)
+			idx = txq->desc_count;
+		idx--;
+	}
+
+	/* Update tail in case netdev_xmit_more was previously true */
+	idpf_tx_buf_hw_update(txq, idx, false);
+}
+
 /**
  * idpf_tx_singleq_map - Build the Tx base descriptor
  * @tx_q: queue to send buffer on
@@ -219,8 +271,9 @@ static void idpf_tx_singleq_map(struct idpf_tx_queue *tx_q,
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
 		unsigned int max_data = IDPF_TX_MAX_DESC_DATA_ALIGNED;
 
-		if (dma_mapping_error(tx_q->dev, dma))
-			return idpf_tx_dma_map_error(tx_q, skb, first, i);
+		if (unlikely(dma_mapping_error(tx_q->dev, dma)))
+			return idpf_tx_singleq_dma_map_error(tx_q, skb,
+							     first, i);
 
 		/* record length, and DMA address */
 		dma_unmap_len_set(tx_buf, len, size);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 3359b3b52625..2362d8588e5b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2339,57 +2339,6 @@ unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 	return count;
 }
 
-/**
- * idpf_tx_dma_map_error - handle TX DMA map errors
- * @txq: queue to send buffer on
- * @skb: send buffer
- * @first: original first buffer info buffer for packet
- * @idx: starting point on ring to unwind
- */
-void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
-			   struct idpf_tx_buf *first, u16 idx)
-{
-	struct libeth_sq_napi_stats ss = { };
-	struct libeth_cq_pp cp = {
-		.dev	= txq->dev,
-		.ss	= &ss,
-	};
-
-	u64_stats_update_begin(&txq->stats_sync);
-	u64_stats_inc(&txq->q_stats.dma_map_errs);
-	u64_stats_update_end(&txq->stats_sync);
-
-	/* clear dma mappings for failed tx_buf map */
-	for (;;) {
-		struct idpf_tx_buf *tx_buf;
-
-		tx_buf = &txq->tx_buf[idx];
-		libeth_tx_complete(tx_buf, &cp);
-		if (tx_buf == first)
-			break;
-		if (idx == 0)
-			idx = txq->desc_count;
-		idx--;
-	}
-
-	if (skb_is_gso(skb)) {
-		union idpf_tx_flex_desc *tx_desc;
-
-		/* If we failed a DMA mapping for a TSO packet, we will have
-		 * used one additional descriptor for a context
-		 * descriptor. Reset that here.
-		 */
-		tx_desc = &txq->flex_tx[idx];
-		memset(tx_desc, 0, sizeof(*tx_desc));
-		if (idx == 0)
-			idx = txq->desc_count;
-		idx--;
-	}
-
-	/* Update tail in case netdev_xmit_more was previously true */
-	idpf_tx_buf_hw_update(txq, idx, false);
-}
-
 /**
  * idpf_tx_splitq_bump_ntu - adjust NTU and generation
  * @txq: the tx ring to wrap
@@ -2438,6 +2387,37 @@ static bool idpf_tx_get_free_buf_id(struct idpf_sw_queue *refillq,
 	return true;
 }
 
+/**
+ * idpf_tx_splitq_pkt_err_unmap - Unmap buffers and bump tail in case of error
+ * @txq: Tx queue to unwind
+ * @params: pointer to splitq params struct
+ * @first: starting buffer for packet to unmap
+ */
+static void idpf_tx_splitq_pkt_err_unmap(struct idpf_tx_queue *txq,
+					 struct idpf_tx_splitq_params *params,
+					 struct idpf_tx_buf *first)
+{
+	struct libeth_sq_napi_stats ss = { };
+	struct idpf_tx_buf *tx_buf = first;
+	struct libeth_cq_pp cp = {
+		.dev    = txq->dev,
+		.ss     = &ss,
+	};
+	u32 idx = 0;
+
+	u64_stats_update_begin(&txq->stats_sync);
+	u64_stats_inc(&txq->q_stats.dma_map_errs);
+	u64_stats_update_end(&txq->stats_sync);
+
+	do {
+		libeth_tx_complete(tx_buf, &cp);
+		idpf_tx_clean_buf_ring_bump_ntc(txq, idx, tx_buf);
+	} while (idpf_tx_buf_compl_tag(tx_buf) == params->compl_tag);
+
+	/* Update tail in case netdev_xmit_more was previously true. */
+	idpf_tx_buf_hw_update(txq, params->prev_ntu, false);
+}
+
 /**
  * idpf_tx_splitq_map - Build the Tx flex descriptor
  * @tx_q: queue to send buffer on
@@ -2482,8 +2462,9 @@ static void idpf_tx_splitq_map(struct idpf_tx_queue *tx_q,
 	for (frag = &skb_shinfo(skb)->frags[0];; frag++) {
 		unsigned int max_data = IDPF_TX_MAX_DESC_DATA_ALIGNED;
 
-		if (dma_mapping_error(tx_q->dev, dma))
-			return idpf_tx_dma_map_error(tx_q, skb, first, i);
+		if (unlikely(dma_mapping_error(tx_q->dev, dma)))
+			return idpf_tx_splitq_pkt_err_unmap(tx_q, params,
+							    first);
 
 		first->nr_frags++;
 		idpf_tx_buf_compl_tag(tx_buf) = params->compl_tag;
@@ -2939,7 +2920,9 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
 {
-	struct idpf_tx_splitq_params tx_params = { };
+	struct idpf_tx_splitq_params tx_params = {
+		.prev_ntu = tx_q->next_to_use,
+	};
 	union idpf_flex_tx_ctx_desc *ctx_desc;
 	struct idpf_tx_buf *first;
 	unsigned int count;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 65acad4c929d..e07e21f6a67c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -195,6 +195,7 @@ struct idpf_tx_offload_params {
  * @compl_tag: Associated tag for completion
  * @td_tag: Descriptor tunneling tag
  * @offload: Offload parameters
+ * @prev_ntu: stored TxQ next_to_use in case of rollback
  */
 struct idpf_tx_splitq_params {
 	enum idpf_tx_desc_dtype_value dtype;
@@ -205,6 +206,8 @@ struct idpf_tx_splitq_params {
 	};
 
 	struct idpf_tx_offload_params offload;
+
+	u16 prev_ntu;
 };
 
 enum idpf_tx_ctx_desc_eipt_offload {
@@ -1041,8 +1044,6 @@ void idpf_tx_buf_hw_update(struct idpf_tx_queue *tx_q, u32 val,
 			   bool xmit_more);
 unsigned int idpf_size_to_txd_count(unsigned int size);
 netdev_tx_t idpf_tx_drop_skb(struct idpf_tx_queue *tx_q, struct sk_buff *skb);
-void idpf_tx_dma_map_error(struct idpf_tx_queue *txq, struct sk_buff *skb,
-			   struct idpf_tx_buf *first, u16 ring_idx);
 unsigned int idpf_tx_desc_count_required(struct idpf_tx_queue *txq,
 					 struct sk_buff *skb);
 void idpf_tx_timeout(struct net_device *netdev, unsigned int txqueue);
-- 
2.39.2



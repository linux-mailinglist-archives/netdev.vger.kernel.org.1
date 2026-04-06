Return-Path: <netdev+bounces-275776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NAiKyNA1GmRsQcAu9opvQ
	(envelope-from <netdev+bounces-275776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:22:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF2D3A8192
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 01:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A643049979
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE9B3A0B1D;
	Mon,  6 Apr 2026 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJ3zRlMG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8639D6CF
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775517709; cv=none; b=k1wocofcPIVpumy3cT5CMh73PyM04UsHMABJxEW8dcKCEnRDl/1D7/ORJw35e0dk8AfCS9YDqXK8A0ptuI2vx39+gXvTn/CUXr2SJOHXYr12jxjj+D9tZbEFK+JRbjERMOj4KGVdUs1YUipQJRcJSSY1mTD/MwGA6KaVlh/lDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775517709; c=relaxed/simple;
	bh=LoyL83Q4kP/YIk5ssgNwI9pOEK+CHoIbH+8bUYCFx5w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2XaJU/C5tkjbWHjHlRL/saueXswoeqSHdWSvVmV6adwnoU75+q672n0jk+sgLsfr+cw/+pfxzuEaSI2YpJLQKdSflPhI8oeqt1KEGsebIWcP9DiAiL76izMYuUQSkKBkiCCIY+bWDrjpKN5H9d7rNdZpL6V7USbIIjnsIeVic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJ3zRlMG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775517708; x=1807053708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LoyL83Q4kP/YIk5ssgNwI9pOEK+CHoIbH+8bUYCFx5w=;
  b=lJ3zRlMGvFN0//w2aB1UrOgiw9dzSH1/6DLHtyQpWn9k+9nmzrJ6Rtr1
   R++OgBkiHsO/c541Td1vatOmOXagz/4t83RBB4s3LkpH2sWFrHBv/4YE2
   4iYQAclrFn6c0gJsy0dUlfIpax8unU3zDqof7M/jd+v1N1PVfe8Fw1Kbd
   G6RTrslTF9oeB9esJeO1a85+dDZGr8/En8jZfCYOntTmOxFtlYyEOGMCx
   WhJ/95w7nGTFzBt2/ukKdsB3XhBFIRT3gbwF6nrnTIgk/DgrIoXewXo1A
   01COGMmtjvZct04kYGgcujYQmeVMAAnsKFwlLBd40U1fNxxB4Pyxmdg+q
   A==;
X-CSE-ConnectionGUID: Ccdq39hbQH2yNL96Lfa7WQ==
X-CSE-MsgGUID: rA38uz4kRNiNP2iUNsry5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76368985"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76368985"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 16:21:45 -0700
X-CSE-ConnectionGUID: ie146FGOS0qcepsWoRMBfA==
X-CSE-MsgGUID: 6mnlO9qORUmQRZmMAe4jag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="232050500"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa003.jf.intel.com with ESMTP; 06 Apr 2026 16:21:45 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-net 2/2] idpf: fix skb datapath queue based scheduling crashes and timeouts
Date: Mon,  6 Apr 2026 16:32:36 -0700
Message-Id: <20260406233236.3585504-3-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260406233236.3585504-1-joshua.a.hay@intel.com>
References: <20260406233236.3585504-1-joshua.a.hay@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275776-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshua.a.hay@intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4CF2D3A8192
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The splitq Tx resource checks were assuming that the queues were using
flow based scheduling and checking the refillqs for free buffers.
However, the Tx refillqs are not allocated when using queue based
scheduling resulting in a NULL ptr dereference. Adjust the Tx resource
checks to only check available descriptor resources when using queue
based scheduling. Because queue based scheduling does not have any
notion of descriptor only completions, there cannot be any packets in
flight, meaning there is no need to check for pending completions.

The driver also only supported 8 byte completion descriptors in the skb
datapath previously. However, currently the FW only supports 4 byte
completion descriptors when using queue based scheduling. This meant we
were skipping over completions, resulting in Tx timeouts.  Add support
to process both 4 and 8 byte completion descriptors, depending on the
scheduling mode. Cache the next_to_clean completion descriptor in the
completion queue struct, and fetch this descriptor before the start of
each cleaning loop. Access the next descriptor in the loop by
calculating the index based on raw byte count.

Fixes: 0c3f135e840d ("idpf: stop Tx if there are insufficient buffer resources")
Fixes: 1c325aac10a8 ("idpf: configure resources for TX queues")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 49 +++++++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h |  6 ++-
 2 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f6b3b15364ff..4fc0bb14c5b1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -270,11 +270,9 @@ static int idpf_tx_desc_alloc(const struct idpf_vport *vport,
 static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 				 struct idpf_compl_queue *complq)
 {
-	u32 desc_size;
-
-	desc_size = idpf_queue_has(FLOW_SCH_EN, complq) ?
-		    sizeof(*complq->comp) : sizeof(*complq->comp_4b);
-	complq->size = array_size(complq->desc_count, desc_size);
+	complq->desc_sz = idpf_queue_has(FLOW_SCH_EN, complq) ?
+			  sizeof(*complq->comp) : sizeof(*complq->comp_4b);
+	complq->size = array_size(complq->desc_count, complq->desc_sz);
 
 	complq->desc_ring = dma_alloc_coherent(complq->netdev->dev.parent,
 					       complq->size, &complq->dma,
@@ -284,6 +282,7 @@ static int idpf_compl_desc_alloc(const struct idpf_vport *vport,
 
 	complq->next_to_use = 0;
 	complq->next_to_clean = 0;
+	complq->ntc_desc = complq->comp;
 	idpf_queue_set(GEN_CHK, complq);
 
 	idpf_xsk_setup_queue(vport, complq,
@@ -2193,7 +2192,7 @@ static void idpf_tx_handle_rs_completion(struct idpf_tx_queue *txq,
 static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 				 int *cleaned)
 {
-	struct idpf_splitq_tx_compl_desc *tx_desc;
+	struct idpf_splitq_tx_compl_desc *tx_desc = complq->ntc_desc;
 	s16 ntc = complq->next_to_clean;
 	struct idpf_netdev_priv *np;
 	unsigned int complq_budget;
@@ -2201,7 +2200,6 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 	int i;
 
 	complq_budget = complq->clean_budget;
-	tx_desc = &complq->comp[ntc];
 	ntc -= complq->desc_count;
 
 	do {
@@ -2257,11 +2255,12 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		u64_stats_update_end(&tx_q->stats_sync);
 
 fetch_next_desc:
-		tx_desc++;
+		tx_desc = (struct idpf_splitq_tx_compl_desc *)
+				((u8 *)tx_desc + complq->desc_sz);
 		ntc++;
 		if (unlikely(!ntc)) {
 			ntc -= complq->desc_count;
-			tx_desc = &complq->comp[0];
+			tx_desc = complq->comp;
 			idpf_queue_change(GEN_CHK, complq);
 		}
 
@@ -2271,6 +2270,8 @@ static bool idpf_tx_clean_complq(struct idpf_compl_queue *complq, int budget,
 		complq_budget--;
 	} while (likely(complq_budget));
 
+	complq->ntc_desc = tx_desc;
+
 	/* Store the state of the complq to be used later in deciding if a
 	 * TXQ can be started again
 	 */
@@ -2437,21 +2438,32 @@ static int idpf_txq_has_room(struct idpf_tx_queue *tx_q, u32 descs_needed,
  * @tx_q: the queue to be checked
  * @descs_needed: number of descriptors required for this packet
  * @bufs_needed: number of buffers needed for this packet
+ * @flow: true if queue uses flow based scheduling, false if queue based scheduling
  *
  * Return: 0 if stop is not needed
  */
 static int idpf_tx_maybe_stop_splitq(struct idpf_tx_queue *tx_q,
-				     u32 descs_needed,
-				     u32 bufs_needed)
+				     u32 descs_needed, u32 bufs_needed,
+				     bool flow)
 {
-	/* Since we have multiple resources to check for splitq, our
+	/* Since we have multiple resources to check for flow based splitq, our
 	 * start,stop_thrs becomes a boolean check instead of a count
 	 * threshold.
 	 */
-	if (netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
-				      idpf_txq_has_room(tx_q, descs_needed,
-							bufs_needed),
-				      1, 1))
+	if (flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					      idpf_txq_has_room(tx_q,
+								descs_needed,
+								bufs_needed),
+					      1, 1))
+		return 0;
+
+	/* For queue based splitq, there is no need to check the number of
+	 * pending completions since we cannot reuse descriptors until we get
+	 * completions, so we only need to check for descriptor resources.
+	 */
+	if (!flow && netif_subqueue_maybe_stop(tx_q->netdev, tx_q->idx,
+					       IDPF_DESC_UNUSED(tx_q),
+					       descs_needed, descs_needed))
 		return 0;
 
 	u64_stats_update_begin(&tx_q->stats_sync);
@@ -3021,6 +3033,7 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 					struct idpf_tx_queue *tx_q)
 {
+	bool flow = idpf_queue_has(FLOW_SCH_EN, tx_q);
 	struct idpf_tx_splitq_params tx_params = {
 		.prev_ntu = tx_q->next_to_use,
 	};
@@ -3040,7 +3053,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 	/* Check for splitq specific TX resources */
 	count += (IDPF_TX_DESCS_PER_CACHE_LINE + tso);
-	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count)) {
+	if (idpf_tx_maybe_stop_splitq(tx_q, count, buf_count, flow)) {
 		idpf_tx_buf_hw_update(tx_q, tx_q->next_to_use, false);
 
 		return NETDEV_TX_BUSY;
@@ -3072,7 +3085,7 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 		idpf_tx_set_tstamp_desc(ctx_desc, idx);
 	}
 
-	if (idpf_queue_has(FLOW_SCH_EN, tx_q)) {
+	if (flow) {
 		struct idpf_sw_queue *refillq = tx_q->refillq;
 
 		/* Save refillq state in case of a packet rollback.  Otherwise,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 4be5b3b6d3ed..b6836e38f449 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -807,11 +807,13 @@ libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 24, 32);
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @desc_sz: Descriptor size in bytes
  * @clean_budget: queue cleaning budget
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use. Relevant in both split & single txq
  *		 and bufq.
  * @next_to_clean: Next descriptor to clean
+ * @ntc_desc: Pointer to next_to_clean descriptor for next NAPI poll
  * @num_completions: Only relevant for TX completion queue. It tracks the
  *		     number of completions received to compare against the
  *		     number of completions pending, as accumulated by the
@@ -833,6 +835,7 @@ struct idpf_compl_queue {
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u32 desc_count;
+	u32 desc_sz;
 
 	u32 clean_budget;
 	struct net_device *netdev;
@@ -841,6 +844,7 @@ struct idpf_compl_queue {
 	__cacheline_group_begin_aligned(read_write);
 	u32 next_to_use;
 	u32 next_to_clean;
+	struct idpf_splitq_tx_compl_desc *ntc_desc;
 
 	aligned_u64 num_completions;
 	__cacheline_group_end_aligned(read_write);
@@ -853,7 +857,7 @@ struct idpf_compl_queue {
 	struct idpf_q_vector *q_vector;
 	__cacheline_group_end_aligned(cold);
 };
-libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 16, 24);
+libeth_cacheline_set_assert(struct idpf_compl_queue, 48, 24, 24);
 
 /**
  * struct idpf_sw_queue
-- 
2.39.2



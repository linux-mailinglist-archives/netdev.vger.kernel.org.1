Return-Path: <netdev+bounces-105318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72248910707
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D0B1F2173E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806C41B0125;
	Thu, 20 Jun 2024 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RAy0Q91P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCA21B010A;
	Thu, 20 Jun 2024 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891807; cv=none; b=kZraDrvnou/yB11XeriE3pIlzMGueUkRI5cB57/liWCQiu73XJO35VkA/2Q1MUky8WnamuTKk4UiBUpUZsfonXH9oULyn78RtR7v2baqZT3MD5ZQunQKaOlGGHbu1yEynPUi/LdIfiQQP4Py/aIw9zWvINNAjpkRPx6ii4QfwGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891807; c=relaxed/simple;
	bh=LvT0PREP8vzHzaD58YLaKHIEEGKN0DOAhk38ixhPE/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4M39vseSRaBzwb5k3a2e1UPeo4c8QRuYiYmLg7QHSm0v49pg9zGv0tsMCMfNhK2rJC8YU3ZeNT1VZrfve3FOXHxsOWsGvCEhhChTiZx/DVUgzMVu5KPcPU7fAERVpnyIJKd9qTnoZqK43HD+d7VP4ijWeLfeJ0Qg1a19NpGnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RAy0Q91P; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891806; x=1750427806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LvT0PREP8vzHzaD58YLaKHIEEGKN0DOAhk38ixhPE/Q=;
  b=RAy0Q91PVY+QeQNvpfbSxe+IfAv3aGtwqDBetCw/cUaJ9BvUVNZFU/+b
   QejVatHI+rCYI/lk9P4QwQ8PaxpzKh2T4tX8dXooNiBKrQtI0vxtxq34v
   cOeDaQV1BEmOesW8md5GF3xccenJG0568knYwWdHoJ0aPLZgnO8fkezuN
   jpkfuYwtyqmN+yra6/Lynuy5c/26XAduAK4DJkrq7igD6pFCdTc5aByvd
   F52+IM9b/EzY/CUuJhYXcnzSF1yTXPYWIMgwmsVaqFTkp3U65rNrjSM4z
   tHBRZAdW8l/tiTuLGgXmRPzYEjkabjiNaqCSASF4h6rsxppWJHIwp7HJt
   w==;
X-CSE-ConnectionGUID: r9Y8LK0JShGu63scyVTGow==
X-CSE-MsgGUID: vaZrn0E9QSCIkMQeKvF/9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987865"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987865"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:45 -0700
X-CSE-ConnectionGUID: b8TvPYlgRIGKugUn0hk9VQ==
X-CSE-MsgGUID: W9LUrtVmSSK6hXopah2QQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772113"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:42 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 07/14] idpf: strictly assert cachelines of queue and queue vector structures
Date: Thu, 20 Jun 2024 15:53:40 +0200
Message-ID: <20240620135347.3006818-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
References: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the queue and queue vector structures are separated and laid
out optimally, group the fields as read-mostly, read-write, and cold
cachelines and add size assertions to make sure new features won't push
something out of its place and provoke perf regression.
Despite looking innocent, this gives up to 2% of perf bump on Rx.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 185 +++++++++++++-------
 1 file changed, 118 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 5daa8f905f86..c7ae20ab567b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -6,6 +6,7 @@
 
 #include <linux/dim.h>
 
+#include <net/libeth/cache.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
 #include <net/netdev_queues.h>
@@ -505,58 +506,68 @@ struct idpf_intr_reg {
 /**
  * struct idpf_q_vector
  * @vport: Vport back pointer
- * @napi: napi handler
- * @v_idx: Vector index
- * @intr_reg: See struct idpf_intr_reg
+ * @num_rxq: Number of RX queues
  * @num_txq: Number of TX queues
+ * @num_bufq: Number of buffer queues
  * @num_complq: number of completion queues
+ * @rx: Array of RX queues to service
  * @tx: Array of TX queues to service
+ * @bufq: Array of buffer queues to service
  * @complq: array of completion queues
+ * @intr_reg: See struct idpf_intr_reg
+ * @napi: napi handler
+ * @total_events: Number of interrupts processed
  * @tx_dim: Data for TX net_dim algorithm
  * @tx_itr_value: TX interrupt throttling rate
  * @tx_intr_mode: Dynamic ITR or not
  * @tx_itr_idx: TX ITR index
- * @num_rxq: Number of RX queues
- * @rx: Array of RX queues to service
  * @rx_dim: Data for RX net_dim algorithm
  * @rx_itr_value: RX interrupt throttling rate
  * @rx_intr_mode: Dynamic ITR or not
  * @rx_itr_idx: RX ITR index
- * @num_bufq: Number of buffer queues
- * @bufq: Array of buffer queues to service
- * @total_events: Number of interrupts processed
+ * @v_idx: Vector index
  * @affinity_mask: CPU affinity mask
  */
 struct idpf_q_vector {
+	__cacheline_group_begin_aligned(read_mostly);
 	struct idpf_vport *vport;
-	struct napi_struct napi;
-	u16 v_idx;
-	struct idpf_intr_reg intr_reg;
 
+	u16 num_rxq;
 	u16 num_txq;
+	u16 num_bufq;
 	u16 num_complq;
+	struct idpf_rx_queue **rx;
 	struct idpf_tx_queue **tx;
+	struct idpf_buf_queue **bufq;
 	struct idpf_compl_queue **complq;
 
+	struct idpf_intr_reg intr_reg;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	struct napi_struct napi;
+	u16 total_events;
+
 	struct dim tx_dim;
 	u16 tx_itr_value;
 	bool tx_intr_mode;
 	u32 tx_itr_idx;
 
-	u16 num_rxq;
-	struct idpf_rx_queue **rx;
 	struct dim rx_dim;
 	u16 rx_itr_value;
 	bool rx_intr_mode;
 	u32 rx_itr_idx;
+	__cacheline_group_end_aligned(read_write);
 
-	u16 num_bufq;
-	struct idpf_buf_queue **bufq;
-
-	u16 total_events;
+	__cacheline_group_begin_aligned(cold);
+	u16 v_idx;
 
 	cpumask_var_t affinity_mask;
+	__cacheline_group_end_aligned(cold);
 };
+libeth_cacheline_set_assert(struct idpf_q_vector, 104,
+			    424 + 2 * sizeof(struct dim),
+			    8 + sizeof(cpumask_var_t));
 
 struct idpf_rx_queue_stats {
 	u64_stats_t packets;
@@ -623,11 +634,11 @@ struct idpf_txq_stash {
  * @idx: For RX queue, it is used to index to total RX queue across groups and
  *	 used for skb reporting.
  * @desc_count: Number of descriptors
+ * @rxdids: Supported RX descriptor ids
+ * @rx_ptype_lkup: LUT of Rx ptypes
  * @next_to_use: Next descriptor to use
  * @next_to_clean: Next descriptor to clean
  * @next_to_alloc: RX buffer to allocate at
- * @rxdids: Supported RX descriptor ids
- * @rx_ptype_lkup: LUT of Rx ptypes
  * @skb: Pointer to the skb
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
@@ -641,6 +652,7 @@ struct idpf_txq_stash {
  * @rx_max_pkt_size: RX max packet size
  */
 struct idpf_rx_queue {
+	__cacheline_group_begin_aligned(read_mostly);
 	union {
 		union virtchnl2_rx_desc *rx;
 		struct virtchnl2_singleq_rx_buf_desc *single_buf;
@@ -663,19 +675,23 @@ struct idpf_rx_queue {
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u16 idx;
 	u16 desc_count;
+
+	u32 rxdids;
+	const struct idpf_rx_ptype_decoded *rx_ptype_lkup;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
 	u16 next_to_use;
 	u16 next_to_clean;
 	u16 next_to_alloc;
 
-	u32 rxdids;
-
-	const struct idpf_rx_ptype_decoded *rx_ptype_lkup;
 	struct sk_buff *skb;
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_rx_queue_stats q_stats;
+	__cacheline_group_end_aligned(read_write);
 
-	/* Slowpath */
+	__cacheline_group_begin_aligned(cold);
 	u32 q_id;
 	u32 size;
 	dma_addr_t dma;
@@ -686,7 +702,11 @@ struct idpf_rx_queue {
 	u16 rx_hbuf_size;
 	u16 rx_buf_size;
 	u16 rx_max_pkt_size;
-} ____cacheline_aligned;
+	__cacheline_group_end_aligned(cold);
+};
+libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
+			    72 + sizeof(struct u64_stats_sync),
+			    32);
 
 /**
  * struct idpf_tx_queue - software structure representing a transmit queue
@@ -703,22 +723,7 @@ struct idpf_rx_queue {
  * @idx: For TX queue, it is used as index to map between TX queue group and
  *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
  * @desc_count: Number of descriptors
- * @next_to_use: Next descriptor to use
- * @next_to_clean: Next descriptor to clean
- * @netdev: &net_device corresponding to this queue
- * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
- *		   the TX completion queue, it can be for any TXQ associated
- *		   with that completion queue. This means we can clean up to
- *		   N TXQs during a single call to clean the completion queue.
- *		   cleaned_bytes|pkts tracks the clean stats per TXQ during
- *		   that single call to clean the completion queue. By doing so,
- *		   we can update BQL with aggregate cleaned stats for each TXQ
- *		   only once at the end of the cleaning routine.
- * @clean_budget: singleq only, queue cleaning budget
- * @cleaned_pkts: Number of packets cleaned for the above said case
- * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
  * @tx_min_pkt_len: Min supported packet length
- * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_gen_s: Completion tag generation bit
  *	The format of the completion tag will change based on the TXQ
  *	descriptor ring size so that we can maintain roughly the same level
@@ -739,9 +744,24 @@ struct idpf_rx_queue {
  *	--------------------------------
  *
  *	This gives us 8*8160 = 65280 possible unique values.
+ * @netdev: &net_device corresponding to this queue
+ * @next_to_use: Next descriptor to use
+ * @next_to_clean: Next descriptor to clean
+ * @cleaned_bytes: Splitq only, TXQ only: When a TX completion is received on
+ *		   the TX completion queue, it can be for any TXQ associated
+ *		   with that completion queue. This means we can clean up to
+ *		   N TXQs during a single call to clean the completion queue.
+ *		   cleaned_bytes|pkts tracks the clean stats per TXQ during
+ *		   that single call to clean the completion queue. By doing so,
+ *		   we can update BQL with aggregate cleaned stats for each TXQ
+ *		   only once at the end of the cleaning routine.
+ * @clean_budget: singleq only, queue cleaning budget
+ * @cleaned_pkts: Number of packets cleaned for the above said case
+ * @tx_max_bufs: Max buffers that can be transmitted with scatter-gather
+ * @stash: Tx buffer stash for Flow-based scheduling mode
+ * @compl_tag_bufid_m: Completion tag buffer id mask
  * @compl_tag_cur_gen: Used to keep track of current completion tag generation
  * @compl_tag_gen_max: To determine when compl_tag_cur_gen should be reset
- * @stash: Tx buffer stash for Flow-based scheduling mode
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_tx_queue_stats
  * @q_id: Queue id
@@ -750,6 +770,7 @@ struct idpf_rx_queue {
  * @q_vector: Backreference to associated vector
  */
 struct idpf_tx_queue {
+	__cacheline_group_begin_aligned(read_mostly);
 	union {
 		struct idpf_base_tx_desc *base_tx;
 		struct idpf_base_tx_ctx_desc *base_ctx;
@@ -766,10 +787,16 @@ struct idpf_tx_queue {
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
 	u16 idx;
 	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
+
+	u16 tx_min_pkt_len;
+	u16 compl_tag_gen_s;
 
 	struct net_device *netdev;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	u16 next_to_use;
+	u16 next_to_clean;
 
 	union {
 		u32 cleaned_bytes;
@@ -778,26 +805,27 @@ struct idpf_tx_queue {
 	u16 cleaned_pkts;
 
 	u16 tx_max_bufs;
-	u16 tx_min_pkt_len;
+	struct idpf_txq_stash *stash;
 
 	u16 compl_tag_bufid_m;
-	u16 compl_tag_gen_s;
-
 	u16 compl_tag_cur_gen;
 	u16 compl_tag_gen_max;
 
-	struct idpf_txq_stash *stash;
-
 	struct u64_stats_sync stats_sync;
 	struct idpf_tx_queue_stats q_stats;
+	__cacheline_group_end_aligned(read_write);
 
-	/* Slowpath */
+	__cacheline_group_begin_aligned(cold);
 	u32 q_id;
 	u32 size;
 	dma_addr_t dma;
 
 	struct idpf_q_vector *q_vector;
-} ____cacheline_aligned;
+	__cacheline_group_end_aligned(cold);
+};
+libeth_cacheline_set_assert(struct idpf_tx_queue, 64,
+			    88 + sizeof(struct u64_stats_sync),
+			    24);
 
 /**
  * struct idpf_buf_queue - software structure representing a buffer queue
@@ -822,6 +850,7 @@ struct idpf_tx_queue {
  * @rx_buf_size: Buffer size
  */
 struct idpf_buf_queue {
+	__cacheline_group_begin_aligned(read_mostly);
 	struct virtchnl2_splitq_rx_buf_desc *split_buf;
 	struct {
 		struct idpf_rx_buf *buf;
@@ -832,12 +861,16 @@ struct idpf_buf_queue {
 	void __iomem *tail;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-	u16 next_to_alloc;
+	u32 desc_count;
+	__cacheline_group_end_aligned(read_mostly);
 
-	/* Slowpath */
+	__cacheline_group_begin_aligned(read_write);
+	u32 next_to_use;
+	u32 next_to_clean;
+	u32 next_to_alloc;
+	__cacheline_group_end_aligned(read_write);
+
+	__cacheline_group_begin_aligned(cold);
 	u32 q_id;
 	u32 size;
 	dma_addr_t dma;
@@ -847,7 +880,9 @@ struct idpf_buf_queue {
 	u16 rx_buffer_low_watermark;
 	u16 rx_hbuf_size;
 	u16 rx_buf_size;
-} ____cacheline_aligned;
+	__cacheline_group_end_aligned(cold);
+};
+libeth_cacheline_set_assert(struct idpf_buf_queue, 64, 16, 32);
 
 /**
  * struct idpf_compl_queue - software structure representing a completion queue
@@ -855,11 +890,11 @@ struct idpf_buf_queue {
  * @txq_grp: See struct idpf_txq_group
  * @flags: See enum idpf_queue_flags_t
  * @desc_count: Number of descriptors
+ * @clean_budget: queue cleaning budget
+ * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use. Relevant in both split & single txq
  *		 and bufq.
  * @next_to_clean: Next descriptor to clean
- * @netdev: &net_device corresponding to this queue
- * @clean_budget: queue cleaning budget
  * @num_completions: Only relevant for TX completion queue. It tracks the
  *		     number of completions received to compare against the
  *		     number of completions pending, as accumulated by the
@@ -870,25 +905,33 @@ struct idpf_buf_queue {
  * @q_vector: Backreference to associated vector
  */
 struct idpf_compl_queue {
+	__cacheline_group_begin_aligned(read_mostly);
 	struct idpf_splitq_tx_compl_desc *comp;
 	struct idpf_txq_group *txq_grp;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
+	u32 desc_count;
 
-	struct net_device *netdev;
 	u32 clean_budget;
+	struct net_device *netdev;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	u32 next_to_use;
+	u32 next_to_clean;
+
 	u32 num_completions;
+	__cacheline_group_end_aligned(read_write);
 
-	/* Slowpath */
+	__cacheline_group_begin_aligned(cold);
 	u32 q_id;
 	u32 size;
 	dma_addr_t dma;
 
 	struct idpf_q_vector *q_vector;
-} ____cacheline_aligned;
+	__cacheline_group_end_aligned(cold);
+};
+libeth_cacheline_set_assert(struct idpf_compl_queue, 40, 16, 24);
 
 /**
  * struct idpf_sw_queue
@@ -903,13 +946,21 @@ struct idpf_compl_queue {
  * lockless buffer management system and are strictly software only constructs.
  */
 struct idpf_sw_queue {
+	__cacheline_group_begin_aligned(read_mostly);
 	u32 *ring;
 
 	DECLARE_BITMAP(flags, __IDPF_Q_FLAGS_NBITS);
-	u16 desc_count;
-	u16 next_to_use;
-	u16 next_to_clean;
-} ____cacheline_aligned;
+	u32 desc_count;
+	__cacheline_group_end_aligned(read_mostly);
+
+	__cacheline_group_begin_aligned(read_write);
+	u32 next_to_use;
+	u32 next_to_clean;
+	__cacheline_group_end_aligned(read_write);
+};
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_mostly, 24);
+libeth_cacheline_group_assert(struct idpf_sw_queue, read_write, 8);
+libeth_cacheline_struct_assert(struct idpf_sw_queue, 24, 8);
 
 /**
  * struct idpf_rxq_set
-- 
2.45.2



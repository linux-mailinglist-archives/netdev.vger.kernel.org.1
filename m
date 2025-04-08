Return-Path: <netdev+bounces-180169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1581A7FD17
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51BD3ACB90
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299BD265CDF;
	Tue,  8 Apr 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TCrBzMVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2921C747F
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109326; cv=none; b=FEmIE1CW4NgJPtThS3zE5spYZWO+P7TG6e4vHz5XMWy5E9Ly5RYyYW/bRg0MbTu+taXPr32LVfUXUIgMzeRYSO3ilQg3NT5B+lWMwqbTXkJdcGRn7+idKnwrnXjvQsQ8C/9VEK1t2LTDZZR/dJGI4+wstxvIJVrLHmVhAuBz3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109326; c=relaxed/simple;
	bh=nW7OKx9CUa3Kb7Iad42GSh/N1OpDrQtqJwxkYlnQsNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX5Vts3wSgFr/xpHIL2ZPeuHQ63uB4u5vGjHkRwnART0CsndtixZRq4BMP1LX1WRw57rZgkY0UnHuAXqbemPoTu1oEVUZlAi0VtTvtpqy7JA+RPL1KV4jYSyTW2QSrBbsFy8fHLtt1qZ1IAJr7LA9IekEgORffi8HHFMerDwBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TCrBzMVZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744109325; x=1775645325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nW7OKx9CUa3Kb7Iad42GSh/N1OpDrQtqJwxkYlnQsNQ=;
  b=TCrBzMVZhQadDhuEKZ7Ja0D9reO/0bUUm0Mu9l7gPwVFQaJmJTdW1eq3
   09nDbOvP7oYY+mMpVi8FOuVHN3xlfD8787MZZnJXq/6bk1uMGC8ViaJJg
   HgIJaLb15s+MlHMhQdcgqnuFkNBQIjCUrEqrrV2lMAqVSyPxgN6e/Q+UF
   n3Bmpl9lUFel+Gg0d+UNdiV3JHFXUzmaqLqMaCl5IBLRAcDXlyDHCeelz
   417cepvU4BOc0xEtDLK7d0Mvi35V62oMOMcnkbpdRRVAnoIG0/yUrxxm0
   oRUrxtJQQtzu+zxqhklxYEfjC7IOF2sKGr1w5nGxw3PC6VIiTGOwHuG+A
   Q==;
X-CSE-ConnectionGUID: ScK77IwFSfm02geZXbYwxw==
X-CSE-MsgGUID: ExgxNczdTMOjQT7ZVhnKsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56903010"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56903010"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 03:48:44 -0700
X-CSE-ConnectionGUID: pUbUTWzvQsa9sdVdLch5/w==
X-CSE-MsgGUID: QcvnuzIiS3mlUK4jCQuYoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="128566748"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by fmviesa008.fm.intel.com with ESMTP; 08 Apr 2025 03:48:41 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>,
	YiFei Zhu <zhuyifei@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH v10 iwl-next 11/11] idpf: add support for Rx timestamping
Date: Tue,  8 Apr 2025 12:31:09 +0200
Message-ID: <20250408103240.30287-25-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408103240.30287-2-milena.olech@intel.com>
References: <20250408103240.30287-2-milena.olech@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Rx timestamp function when the Rx timestamp value is read directly
from the Rx descriptor. In order to extend the Rx timestamp value to 64
bit in hot path, the PHC time is cached in the receive groups.
Add supported Rx timestamp modes.

Signed-off-by: Milena Olech <milena.olech@intel.com>
Tested-by: YiFei Zhu <zhuyifei@google.com>
Tested-by: Mina Almasry <almasrymina@google.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
---
v8 -> v9: upscale Rx filters to HWTSTAMP_FILTER_ALL if Rx filter is
different than HWTSTAMP_FILTER_NONE
v7 -> v8: add a function to check if the Rx timestamp for a given vport
is enabled
v5 -> v6: add Rx filter
v2 -> v3: add disable Rx timestamp
v1 -> v2: extend commit message

 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  6 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 86 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 21 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 30 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  7 +-
 6 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index ec4183a609c4..7a4793749bc5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -1333,6 +1333,7 @@ static void idpf_get_timestamp_filters(const struct idpf_vport *vport,
 				SOF_TIMESTAMPING_RAW_HARDWARE;
 
 	info->tx_types = BIT(HWTSTAMP_TX_OFF);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
 
 	if (!vport->tx_tstamp_caps ||
 	    vport->adapter->ptp->tx_tstamp_access == IDPF_PTP_NONE)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index ccceda18c392..db53c9c9a5e5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2350,7 +2350,8 @@ static int idpf_hwtstamp_set(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport)) {
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) &&
+	    !idpf_ptp_is_vport_rx_tstamp_ena(vport)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return -EOPNOTSUPP;
 	}
@@ -2370,7 +2371,8 @@ static int idpf_hwtstamp_get(struct net_device *netdev,
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
-	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport)) {
+	if (!idpf_ptp_is_vport_tx_tstamp_ena(vport) &&
+	    !idpf_ptp_is_vport_rx_tstamp_ena(vport)) {
 		idpf_vport_ctrl_unlock(netdev);
 		return 0;
 	}
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index 63c51684f60d..5be816bd4714 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -328,12 +328,41 @@ static int idpf_ptp_gettimex64(struct ptp_clock_info *info,
 	return 0;
 }
 
+/**
+ * idpf_ptp_update_phctime_rxq_grp - Update the cached PHC time for a given Rx
+ *				     queue group.
+ * @grp: receive queue group in which Rx timestamp is enabled
+ * @split: Indicates whether the queue model is split or single queue
+ * @systime: Cached system time
+ */
+static void
+idpf_ptp_update_phctime_rxq_grp(const struct idpf_rxq_group *grp, bool split,
+				u64 systime)
+{
+	struct idpf_rx_queue *rxq;
+	u16 i;
+
+	if (!split) {
+		for (i = 0; i < grp->singleq.num_rxq; i++) {
+			rxq = grp->singleq.rxqs[i];
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	} else {
+		for (i = 0; i < grp->splitq.num_rxq_sets; i++) {
+			rxq = &grp->splitq.rxq_sets[i]->rxq;
+			if (rxq)
+				WRITE_ONCE(rxq->cached_phc_time, systime);
+		}
+	}
+}
+
 /**
  * idpf_ptp_update_cached_phctime - Update the cached PHC time values
  * @adapter: Driver specific private structure
  *
  * This function updates the system time values which are cached in the adapter
- * structure.
+ * structure and the Rx queues.
  *
  * This function must be called periodically to ensure that the cached value
  * is never more than 2 seconds old.
@@ -356,6 +385,21 @@ static int idpf_ptp_update_cached_phctime(struct idpf_adapter *adapter)
 	WRITE_ONCE(adapter->ptp->cached_phc_time, systime);
 	WRITE_ONCE(adapter->ptp->cached_phc_jiffies, jiffies);
 
+	idpf_for_each_vport(adapter, vport) {
+		bool split;
+
+		if (!vport || !vport->rxq_grps)
+			continue;
+
+		split = idpf_is_queue_model_split(vport->rxq_model);
+
+		for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+			struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+
+			idpf_ptp_update_phctime_rxq_grp(grp, split, systime);
+		}
+	}
+
 	return 0;
 }
 
@@ -616,6 +660,45 @@ int idpf_ptp_request_ts(struct idpf_tx_queue *tx_q, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_ptp_set_rx_tstamp - Enable or disable Rx timestamping
+ * @vport: Virtual port structure
+ * @rx_filter: bool value for whether timestamps are enabled or disabled
+ */
+static void idpf_ptp_set_rx_tstamp(struct idpf_vport *vport, int rx_filter)
+{
+	bool enable = true, splitq;
+
+	vport->tstamp_config.rx_filter = rx_filter;
+	splitq = idpf_is_queue_model_split(vport->rxq_model);
+
+	if (rx_filter == HWTSTAMP_FILTER_NONE)
+		enable = false;
+
+	for (u16 i = 0; i < vport->num_rxq_grp; i++) {
+		struct idpf_rxq_group *grp = &vport->rxq_grps[i];
+		struct idpf_rx_queue *rx_queue;
+		u16 j, num_rxq;
+
+		if (splitq)
+			num_rxq = grp->splitq.num_rxq_sets;
+		else
+			num_rxq = grp->singleq.num_rxq;
+
+		for (j = 0; j < num_rxq; j++) {
+			if (splitq)
+				rx_queue = &grp->splitq.rxq_sets[j]->rxq;
+			else
+				rx_queue = grp->singleq.rxqs[j];
+
+			if (enable)
+				idpf_queue_set(PTP, rx_queue);
+			else
+				idpf_queue_clear(PTP, rx_queue);
+		}
+	}
+}
+
 /**
  * idpf_ptp_set_timestamp_mode - Setup driver for requested timestamp mode
  * @vport: Virtual port structure
@@ -638,6 +721,7 @@ int idpf_ptp_set_timestamp_mode(struct idpf_vport *vport,
 	}
 
 	vport->tstamp_config.tx_type = config->tx_type;
+	idpf_ptp_set_rx_tstamp(vport, config->rx_filter);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.h b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
index ea533d90f0cf..a05364ae9031 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.h
@@ -245,6 +245,27 @@ static inline bool idpf_ptp_is_vport_tx_tstamp_ena(struct idpf_vport *vport)
 		return true;
 }
 
+/**
+ * idpf_ptp_is_vport_rx_tstamp_ena - Verify the Rx timestamping enablement for
+ *				     a given vport.
+ * @vport: Virtual port structure
+ *
+ * Rx timestamp feature is enabled if the PTP clock for the adapter is created
+ * and it is possible to read the value of the device clock. The second
+ * assumption comes from the need to extend the Rx timestamp value to 64 bit
+ * based on the current device clock time.
+ *
+ * Return: true if the Rx timestamping is enabled, false otherwise.
+ */
+static inline bool idpf_ptp_is_vport_rx_tstamp_ena(struct idpf_vport *vport)
+{
+	if (!vport->adapter->ptp ||
+	    vport->adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE)
+		return false;
+	else
+		return true;
+}
+
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 int idpf_ptp_init(struct idpf_adapter *adapter);
 void idpf_ptp_release(struct idpf_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 0aa0680e57ad..5137e9d15adb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3170,6 +3170,33 @@ static int idpf_rx_rsc(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	return 0;
 }
 
+/**
+ * idpf_rx_hwtstamp - check for an RX timestamp and pass up the stack
+ * @rxq: pointer to the rx queue that receives the timestamp
+ * @rx_desc: pointer to rx descriptor containing timestamp
+ * @skb: skb to put timestamp in
+ */
+static void
+idpf_rx_hwtstamp(const struct idpf_rx_queue *rxq,
+		 const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc,
+		 struct sk_buff *skb)
+{
+	u64 cached_time, ts_ns;
+	u32 ts_high;
+
+	if (!(rx_desc->ts_low & VIRTCHNL2_RX_FLEX_TSTAMP_VALID))
+		return;
+
+	cached_time = READ_ONCE(rxq->cached_phc_time);
+
+	ts_high = le32_to_cpu(rx_desc->ts_high);
+	ts_ns = idpf_ptp_tstamp_extend_32b_to_64b(cached_time, ts_high);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ts_ns),
+	};
+}
+
 /**
  * idpf_rx_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rxq: Rx descriptor ring packet is being transacted on
@@ -3195,6 +3222,9 @@ idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	/* process RSS/hash */
 	idpf_rx_hash(rxq, skb, rx_desc, decoded);
 
+	if (idpf_queue_has(PTP, rxq))
+		idpf_rx_hwtstamp(rxq, rx_desc, skb);
+
 	skb->protocol = eth_type_trans(skb, rxq->netdev);
 	skb_record_rx_queue(skb, rxq->idx);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 9b7aa72e1f32..c779fe71df99 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -290,6 +290,8 @@ struct idpf_ptype_state {
  * @__IDPF_Q_POLL_MODE: Enable poll mode
  * @__IDPF_Q_CRC_EN: enable CRC offload in singleq mode
  * @__IDPF_Q_HSPLIT_EN: enable header split on Rx (splitq)
+ * @__IDPF_Q_PTP: indicates whether the Rx timestamping is enabled for the
+ *		  queue
  * @__IDPF_Q_FLAGS_NBITS: Must be last
  */
 enum idpf_queue_flags_t {
@@ -300,6 +302,7 @@ enum idpf_queue_flags_t {
 	__IDPF_Q_POLL_MODE,
 	__IDPF_Q_CRC_EN,
 	__IDPF_Q_HSPLIT_EN,
+	__IDPF_Q_PTP,
 
 	__IDPF_Q_FLAGS_NBITS,
 };
@@ -496,6 +499,7 @@ struct idpf_txq_stash {
  * @next_to_alloc: RX buffer to allocate at
  * @skb: Pointer to the skb
  * @truesize: data buffer truesize in singleq
+ * @cached_phc_time: Cached PHC time for the Rx queue
  * @stats_sync: See struct u64_stats_sync
  * @q_stats: See union idpf_rx_queue_stats
  * @q_id: Queue id
@@ -543,6 +547,7 @@ struct idpf_rx_queue {
 
 	struct sk_buff *skb;
 	u32 truesize;
+	u64 cached_phc_time;
 
 	struct u64_stats_sync stats_sync;
 	struct idpf_rx_queue_stats q_stats;
@@ -562,7 +567,7 @@ struct idpf_rx_queue {
 	__cacheline_group_end_aligned(cold);
 };
 libeth_cacheline_set_assert(struct idpf_rx_queue, 64,
-			    80 + sizeof(struct u64_stats_sync),
+			    88 + sizeof(struct u64_stats_sync),
 			    32);
 
 /**
-- 
2.43.5



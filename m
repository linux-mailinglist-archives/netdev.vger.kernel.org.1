Return-Path: <netdev+bounces-166545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2432A36626
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634D41723F8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F1A1FBEBF;
	Fri, 14 Feb 2025 19:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jukzgPS4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544D91DE2A9
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561286; cv=none; b=iMPV7ASae23+ceHJFOIURFW5/ZyGOpQBduGv/YLyu6Kt0ORDnjx4WFMGXvUFX+Fohje/0pGytARqb0C3fVJHk61pnoJ1pGi8IubkTLrpT4idbvipp/vtNnCoxQPz/LK8GVhE/xAfdmH9b4Y7tvfxRwWGFitCKtqpxl86aRUZhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561286; c=relaxed/simple;
	bh=fi4bQy172L8mEHY1KyFiYaFj5fJW6f2DO/hQMUwqGQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAJ0vckCHdR7vLmQefnrun4NgkTvdSGqaKCCDWcbJoroGasHl2SUF4NPGnc8LA9j/Fv4a/4Dfmk2tOSogcdfIdH6BXI8bs4HHc8fgOpWUHnotR6TnA8UkAP2VGHZPaOXKRTIzZ+NQpQl9NVCNnVxfAFQlS9R5ZWWGMkRRYu8irY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jukzgPS4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561284; x=1771097284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fi4bQy172L8mEHY1KyFiYaFj5fJW6f2DO/hQMUwqGQ8=;
  b=jukzgPS4EWI60KzOxs6F2fJxWjro1xPxsVRgXMGcPGLWbmvNnBzaJrOL
   8qAWme1iD2WUnAAR09FLLJxmtwl3qXUWxag4U+6dIVr/+3kNzlwkr4JQm
   BJkhEHugwqf60Iz2Gdfc0HbpKoyAP8Ms6pg5v4vtZy9LnlfLABzL09wbM
   4EF2/DO6x40YhJ5PWg/Ut9EOlFviWUdFlIA4abeoLD6z5zFVlvxbQ3JHF
   ebaCk21m/TSoy8vWOV3XTxU4UB4C9WZ3zQP3juTP5SoQvVrN5fEyzl/Ot
   1snvLqUAf+TlCTsB8h7AJxK123H8mD2MMcEiM4L6av5qmQhKqQ3tP4S2Y
   w==;
X-CSE-ConnectionGUID: u0N5Kr5aSG+S8ZZT4Khd4A==
X-CSE-MsgGUID: izWFpKjvRDqF9CiENE8UNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244184"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244184"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:55 -0800
X-CSE-ConnectionGUID: 6D3W66IRSuaOUXzpwR6hvQ==
X-CSE-MsgGUID: P06Ut6m9S+OW40iS7vWhXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144394022"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 14/14] iavf: add support for Rx timestamps to hotpath
Date: Fri, 14 Feb 2025 11:27:35 -0800
Message-ID: <20250214192739.1175740-15-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
References: <20250214192739.1175740-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Add support for receive timestamps to the Rx hotpath. This support only
works when using the flexible descriptor format, so make sure that we
request this format by default if we have receive timestamp support
available in the PTP capabilities.

In order to report the timestamps to userspace, we need to perform
timestamp extension. The Rx descriptor does actually contain the "40
bit" timestamp. However, upper 32 bits which contain nanoseconds are
conveniently stored separately in the descriptor. We could extract the
32bits and lower 8 bits, then perform a bitwise OR to calculate the
40bit value. This makes no sense, because the timestamp extension
algorithm would simply discard the lower 8 bits anyways.

Thus, implement timestamp extension as iavf_ptp_extend_32b_timestamp(),
and extract and forward only the 32bits of nominal nanoseconds.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c |  9 +++
 drivers/net/ethernet/intel/iavf/iavf_ptp.c  | 61 +++++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h  | 11 ++++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 43 +++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_type.h |  1 +
 5 files changed, 125 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2d908ff0152c..4c29739780bd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -730,6 +730,15 @@ static u8 iavf_select_rx_desc_format(const struct iavf_adapter *adapter)
 	if (!IAVF_RXDID_ALLOWED(adapter))
 		return VIRTCHNL_RXDID_1_32B_BASE;
 
+	/* Rx timestamping requires the use of flexible NIC descriptors */
+	if (iavf_ptp_cap_supported(adapter, VIRTCHNL_1588_PTP_CAP_RX_TSTAMP)) {
+		if (rxdids & BIT(VIRTCHNL_RXDID_2_FLEX_SQ_NIC))
+			return VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
+
+		pci_warn(adapter->pdev,
+			 "Unable to negotiate flexible descriptor format\n");
+	}
+
 	/* Warn if the PF does not list support for the default legacy
 	 * descriptor format. This shouldn't happen, as this is the format
 	 * used if VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC is not supported. It is
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.c b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
index 4246ddfa6f0d..b4d5eda2e84f 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.c
@@ -394,6 +394,9 @@ void iavf_ptp_release(struct iavf_adapter *adapter)
 	}
 	adapter->aq_required &= ~IAVF_FLAG_AQ_SEND_PTP_CMD;
 	mutex_unlock(&adapter->ptp.aq_cmd_lock);
+
+	adapter->ptp.hwtstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
+	iavf_ptp_disable_rx_tstamp(adapter);
 }
 
 /**
@@ -422,3 +425,61 @@ void iavf_ptp_process_caps(struct iavf_adapter *adapter)
 		iavf_ptp_disable_rx_tstamp(adapter);
 	}
 }
+
+/**
+ * iavf_ptp_extend_32b_timestamp - Convert a 32b nanoseconds timestamp to 64b
+ * nanoseconds
+ * @cached_phc_time: recently cached copy of PHC time
+ * @in_tstamp: Ingress/egress 32b nanoseconds timestamp value
+ *
+ * Hardware captures timestamps which contain only 32 bits of nominal
+ * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
+ *
+ * Extend the 32bit nanosecond timestamp using the following algorithm and
+ * assumptions:
+ *
+ * 1) have a recently cached copy of the PHC time
+ * 2) assume that the in_tstamp was captured 2^31 nanoseconds (~2.1
+ *    seconds) before or after the PHC time was captured.
+ * 3) calculate the delta between the cached time and the timestamp
+ * 4) if the delta is smaller than 2^31 nanoseconds, then the timestamp was
+ *    captured after the PHC time. In this case, the full timestamp is just
+ *    the cached PHC time plus the delta.
+ * 5) otherwise, if the delta is larger than 2^31 nanoseconds, then the
+ *    timestamp was captured *before* the PHC time, i.e. because the PHC
+ *    cache was updated after the timestamp was captured by hardware. In this
+ *    case, the full timestamp is the cached time minus the inverse delta.
+ *
+ * This algorithm works even if the PHC time was updated after a Tx timestamp
+ * was requested, but before the Tx timestamp event was reported from
+ * hardware.
+ *
+ * This calculation primarily relies on keeping the cached PHC time up to
+ * date. If the timestamp was captured more than 2^31 nanoseconds after the
+ * PHC time, it is possible that the lower 32bits of PHC time have
+ * overflowed more than once, and we might generate an incorrect timestamp.
+ *
+ * This is prevented by (a) periodically updating the cached PHC time once
+ * a second, and (b) discarding any Tx timestamp packet if it has waited for
+ * a timestamp for more than one second.
+ *
+ * Return: extended timestamp (to 64b).
+ */
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp)
+{
+	u32 low = lower_32_bits(cached_phc_time);
+	u32 delta = in_tstamp - low;
+	u64 ns;
+
+	/* Do not assume that the in_tstamp is always more recent than the
+	 * cached PHC time. If the delta is large, it indicates that the
+	 * in_tstamp was taken in the past, and should be converted
+	 * forward.
+	 */
+	if (delta > S32_MAX)
+		ns = cached_phc_time - (low - in_tstamp);
+	else
+		ns = cached_phc_time + delta;
+
+	return ns;
+}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ptp.h b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
index 0801e3ff5a59..783b8f287cd9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ptp.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_ptp.h
@@ -6,6 +6,9 @@
 
 #include "iavf_types.h"
 
+/* bit indicating whether a 40bit timestamp is valid */
+#define IAVF_PTP_40B_TSTAMP_VALID	BIT(24)
+
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
 void iavf_ptp_init(struct iavf_adapter *adapter);
 void iavf_ptp_release(struct iavf_adapter *adapter);
@@ -15,6 +18,7 @@ void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter);
 int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
 			   struct kernel_hwtstamp_config *config,
 			   struct netlink_ext_ack *extack);
+u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time, u32 in_tstamp);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 static inline void iavf_ptp_init(struct iavf_adapter *adapter) { }
 static inline void iavf_ptp_release(struct iavf_adapter *adapter) { }
@@ -32,5 +36,12 @@ static inline int iavf_ptp_set_ts_config(struct iavf_adapter *adapter,
 {
 	return -1;
 }
+
+static inline u64 iavf_ptp_extend_32b_timestamp(u64 cached_phc_time,
+						u32 in_tstamp)
+{
+	return 0;
+}
+
 #endif /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 #endif /* _IAVF_PTP_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 283997b8a777..422312b8b54a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -8,6 +8,7 @@
 #include "iavf.h"
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
+#include "iavf_ptp.h"
 
 /**
  * iavf_is_descriptor_done - tests DD bit in Rx descriptor
@@ -1076,6 +1077,45 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring, __le64 qw1,
 	}
 }
 
+/**
+ * iavf_flex_rx_tstamp - Capture Rx timestamp from the descriptor
+ * @rx_ring: descriptor ring
+ * @qw2: quad word 2 of descriptor
+ * @qw3: quad word 3 of descriptor
+ * @skb: skb currently being received
+ *
+ * Read the Rx timestamp value from the descriptor and pass it to the stack.
+ *
+ * This function only operates on the VIRTCHNL_RXDID_2_FLEX_SQ_NIC flexible
+ * descriptor writeback format.
+ */
+static void iavf_flex_rx_tstamp(const struct iavf_ring *rx_ring, __le64 qw2,
+				__le64 qw3, struct sk_buff *skb)
+{
+	u32 tstamp;
+	u64 ns;
+
+	/* Skip processing if timestamps aren't enabled */
+	if (!(rx_ring->flags & IAVF_TXRX_FLAGS_HW_TSTAMP))
+		return;
+
+	/* Check if this Rx descriptor has a valid timestamp */
+	if (!le64_get_bits(qw2, IAVF_PTP_40B_TSTAMP_VALID))
+		return;
+
+	/* the ts_low field only contains the valid bit and sub-nanosecond
+	 * precision, so we don't need to extract it.
+	 */
+	tstamp = le64_get_bits(qw3, IAVF_RXD_FLEX_QW3_TSTAMP_HIGH_M);
+
+	ns = iavf_ptp_extend_32b_timestamp(rx_ring->ptp->cached_phc_time,
+					   tstamp);
+
+	*skb_hwtstamps(skb) = (struct skb_shared_hwtstamps) {
+		.hwtstamp = ns_to_ktime(ns),
+	};
+}
+
 /**
  * iavf_process_skb_fields - Populate skb header fields from Rx descriptor
  * @rx_ring: rx descriptor ring packet is being transacted on
@@ -1097,11 +1137,14 @@ static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 	struct libeth_rx_pt decoded_pt;
 	__le64 qw0 = rx_desc->qw0;
 	__le64 qw1 = rx_desc->qw1;
+	__le64 qw2 = rx_desc->qw2;
+	__le64 qw3 = rx_desc->qw3;
 
 	decoded_pt = libie_rx_pt_parse(ptype);
 
 	if (flex) {
 		iavf_flex_rx_hash(rx_ring, qw1, skb, decoded_pt);
+		iavf_flex_rx_tstamp(rx_ring, qw2, qw3, skb);
 		csum_bits = iavf_flex_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
 					      decoded_pt);
 	} else {
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index e62a8a0067ea..f9e1319620f4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -285,6 +285,7 @@ struct iavf_rx_desc {
 /* L2 Tag 2 Presence */
 #define IAVF_RXD_FLEX_L2TAG2P_M			BIT(11)
 	aligned_le64 qw3;
+#define IAVF_RXD_FLEX_QW3_TSTAMP_HIGH_M		GENMASK_ULL(63, 32)
 } __aligned(4 * sizeof(__le64));
 static_assert(sizeof(struct iavf_rx_desc) == 32);
 
-- 
2.47.1



Return-Path: <netdev+bounces-166542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310DA36629
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CC318972BC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE591DC1A7;
	Fri, 14 Feb 2025 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6DjBpRG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2581DBB13
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561284; cv=none; b=oaRmo4/VWPI5X8F9YSurIi1jprebz3iGn3/T9cbsbhPytwalN57nCIm9YJE8Knw3fa+QSwTDeJRZYXR7EhDyNdUrrXZhk7Kyyf+WRV8oEyjprEg3M2JYgJkzQrF/XcSAplnfu8coUjriks8479cKnaFAJcUYqsmaCopXsKswrOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561284; c=relaxed/simple;
	bh=njdYT6LC4j4T8mMLBd5yVYisyLGXOyC4B69S9heE47E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhHi08zEgQ3lNukAUiAGXrdqFAudFrD4RP6tl3Egcerh/9nKfN+XMK0ZiYSCozdGqgl4Bfn4ye66QSmkECBHXKLUPVxBXujIHpzGUXPqQjzg90C2avnUvlJnTDBgI+go/oim6REMpXaayDk/9T06MLcW7Lvr9uhHJoDQH93UERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6DjBpRG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561282; x=1771097282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=njdYT6LC4j4T8mMLBd5yVYisyLGXOyC4B69S9heE47E=;
  b=Q6DjBpRGumE5pJtoGTHklhTJEbOXKwELEN9Grk1hBwtR9gH0b+zRX3rk
   OFC4/LWV13So5W+1/WK05fasI9NB/kP3eYMkZriU3VJmUsoe/L5O6DzU2
   oNVf1T0ikyJ1tb4t23NuBxkU3VIVGoSR1elj+7z0JxWTVMvl2Pjp0631Y
   1RvuLhY/ZLUMa5od7IylZVoQ+q5j4+Toia+n1SXYg1QffxuEmB+89RDV3
   avgdRqj7gLWdTFJQWG7Yv9NkhL0U36qIGqZiIJFrFCuTYkMjCgOnZUxkM
   1pG9NUPcgEMT/MLKuNV/kQLG0vTy8jiEkSlWe+UKhjQ9H7tOYuBJzrgzx
   A==;
X-CSE-ConnectionGUID: Q+pBcGkrQ4uwNSlbZE3hCw==
X-CSE-MsgGUID: fsMRXgnzQ2W1aqOMOUqWhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244167"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244167"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:54 -0800
X-CSE-ConnectionGUID: cv3yqdIDRmOHeX8c/qkMrQ==
X-CSE-MsgGUID: PATJ9cCXTzOK0OyyVFiKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144394014"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 14 Feb 2025 11:27:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 12/14] iavf: Implement checking DD desc field
Date: Fri, 14 Feb 2025 11:27:33 -0800
Message-ID: <20250214192739.1175740-13-anthony.l.nguyen@intel.com>
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

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Rx timestamping introduced in PF driver caused the need of refactoring
the VF driver mechanism to check packet fields.

The function to check errors in descriptor has been removed and from
now only previously set struct fields are being checked. The field DD
(descriptor done) needs to be checked at the very beginning, before
extracting other fields.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 54 ++++++++++++++++-----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h | 16 ------
 drivers/net/ethernet/intel/iavf/iavf_type.h |  2 +
 3 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 89b71509e521..283997b8a777 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -9,6 +9,25 @@
 #include "iavf_trace.h"
 #include "iavf_prototype.h"
 
+/**
+ * iavf_is_descriptor_done - tests DD bit in Rx descriptor
+ * @qw1: quad word 1 from descriptor to get Descriptor Done field from
+ * @flex: is the descriptor flex or legacy
+ *
+ * This function tests the descriptor done bit in specified descriptor. Because
+ * there are two types of descriptors (legacy and flex) the parameter rx_ring
+ * is used to distinguish.
+ *
+ * Return: true or false based on the state of DD bit in Rx descriptor.
+ */
+static bool iavf_is_descriptor_done(u64 qw1, bool flex)
+{
+	if (flex)
+		return FIELD_GET(IAVF_RXD_FLEX_DD_M, qw1);
+	else
+		return FIELD_GET(IAVF_RXD_LEGACY_DD_M, qw1);
+}
+
 static __le64 build_ctob(u32 td_cmd, u32 td_offset, unsigned int size,
 			 u32 td_tag)
 {
@@ -1063,6 +1082,7 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring, __le64 qw1,
  * @rx_desc: pointer to the EOP Rx descriptor
  * @skb: pointer to current skb being populated
  * @ptype: the packet type decoded by hardware
+ * @flex: is the descriptor flex or legacy
  *
  * This function checks the ring, descriptor, and packet information in
  * order to populate the hash, checksum, VLAN, protocol, and
@@ -1070,7 +1090,8 @@ static void iavf_flex_rx_hash(const struct iavf_ring *ring, __le64 qw1,
  **/
 static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 				    const struct iavf_rx_desc *rx_desc,
-				    struct sk_buff *skb, u32 ptype)
+				    struct sk_buff *skb, u32 ptype,
+				    bool flex)
 {
 	struct libeth_rx_csum csum_bits;
 	struct libeth_rx_pt decoded_pt;
@@ -1079,14 +1100,14 @@ static void iavf_process_skb_fields(const struct iavf_ring *rx_ring,
 
 	decoded_pt = libie_rx_pt_parse(ptype);
 
-	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE) {
-		iavf_legacy_rx_hash(rx_ring, qw0, qw1, skb, decoded_pt);
-		csum_bits = iavf_legacy_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
-						decoded_pt);
-	} else {
+	if (flex) {
 		iavf_flex_rx_hash(rx_ring, qw1, skb, decoded_pt);
 		csum_bits = iavf_flex_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
 					      decoded_pt);
+	} else {
+		iavf_legacy_rx_hash(rx_ring, qw0, qw1, skb, decoded_pt);
+		csum_bits = iavf_legacy_rx_csum(rx_ring->vsi, le64_to_cpu(qw1),
+						decoded_pt);
 	}
 	iavf_rx_csum(rx_ring->vsi, skb, decoded_pt, csum_bits);
 
@@ -1296,12 +1317,13 @@ iavf_extract_flex_rx_fields(const struct iavf_ring *rx_ring,
 
 static struct libeth_rqe_info
 iavf_extract_rx_fields(const struct iavf_ring *rx_ring,
-		       const struct iavf_rx_desc *rx_desc)
+		       const struct iavf_rx_desc *rx_desc,
+		       bool flex)
 {
-	if (rx_ring->rxdid == VIRTCHNL_RXDID_1_32B_BASE)
-		return iavf_extract_legacy_rx_fields(rx_ring, rx_desc);
-	else
+	if (flex)
 		return iavf_extract_flex_rx_fields(rx_ring, rx_desc);
+	else
+		return iavf_extract_legacy_rx_fields(rx_ring, rx_desc);
 }
 
 /**
@@ -1318,6 +1340,7 @@ iavf_extract_rx_fields(const struct iavf_ring *rx_ring,
  **/
 static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 {
+	bool flex = rx_ring->rxdid == VIRTCHNL_RXDID_2_FLEX_SQ_NIC;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	struct sk_buff *skb = rx_ring->skb;
 	u16 cleaned_count = IAVF_DESC_UNUSED(rx_ring);
@@ -1327,6 +1350,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		struct libeth_rqe_info fields;
 		struct libeth_fqe *rx_buffer;
 		struct iavf_rx_desc *rx_desc;
+		u64 qw1;
 
 		/* return some buffers to hardware, one at a time is too slow */
 		if (cleaned_count >= IAVF_RX_BUFFER_WRITE) {
@@ -1343,10 +1367,14 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		 */
 		dma_rmb();
 
-		if (!iavf_test_staterr(rx_desc, IAVF_RXD_FLEX_DD_M))
+		qw1 = le64_to_cpu(rx_desc->qw1);
+		/* If DD field (descriptor done) is unset then other fields are
+		 * not valid
+		 */
+		if (!iavf_is_descriptor_done(qw1, flex))
 			break;
 
-		fields = iavf_extract_rx_fields(rx_ring, rx_desc);
+		fields = iavf_extract_rx_fields(rx_ring, rx_desc, flex);
 
 		iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
 
@@ -1391,7 +1419,7 @@ static int iavf_clean_rx_irq(struct iavf_ring *rx_ring, int budget)
 		total_rx_bytes += skb->len;
 
 		/* populate checksum, VLAN, and protocol */
-		iavf_process_skb_fields(rx_ring, rx_desc, skb, fields.ptype);
+		iavf_process_skb_fields(rx_ring, rx_desc, skb, fields.ptype, flex);
 
 		iavf_trace(clean_rx_irq_rx, rx_ring, rx_desc, skb);
 		iavf_receive_skb(rx_ring, skb, fields.vlan);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.h b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
index 3a1a39ee3615..dff5c8cd27ab 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.h
@@ -80,22 +80,6 @@ enum iavf_dyn_idx_t {
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) | \
 	BIT_ULL(IAVF_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP))
 
-/**
- * iavf_test_staterr - tests bits in Rx descriptor status and error fields
- * @rx_desc: pointer to receive descriptor (in le64 format)
- * @stat_err_bits: value to mask
- *
- * This function does some fast chicanery in order to return the
- * value of the mask which is really only used for boolean tests.
- * The status_error_len doesn't need to be shifted because it begins
- * at offset zero.
- */
-static inline bool iavf_test_staterr(struct iavf_rx_desc *rx_desc,
-				     const u64 stat_err_bits)
-{
-	return !!(rx_desc->qw1 & cpu_to_le64(stat_err_bits));
-}
-
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IAVF_RX_INCREMENT(r, i) \
 	do {					\
diff --git a/drivers/net/ethernet/intel/iavf/iavf_type.h b/drivers/net/ethernet/intel/iavf/iavf_type.h
index 3dc0907bf70d..e62a8a0067ea 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_type.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_type.h
@@ -212,6 +212,8 @@ struct iavf_rx_desc {
 #define IAVF_RXD_FLEX_PKT_LEN_M			GENMASK_ULL(45, 32)
 
 	aligned_le64 qw1;
+/* Descriptor done indication flag. */
+#define IAVF_RXD_LEGACY_DD_M			BIT(0)
 /* End of packet. Set to 1 if this descriptor is the last one of the packet */
 #define IAVF_RXD_LEGACY_EOP_M			BIT(1)
 /* L2 TAG 1 presence indication */
-- 
2.47.1



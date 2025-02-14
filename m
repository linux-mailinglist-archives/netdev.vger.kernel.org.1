Return-Path: <netdev+bounces-166540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17156A36625
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710121886A78
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2A1DBB03;
	Fri, 14 Feb 2025 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzBZEf2r"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10621D6DD4
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561282; cv=none; b=l9jDo+zFWaug+mTNBtb84xQ6ivjc8KBmL+iCAyIzXTIv/E+qqOxp414dBEw0zLhDAPzrTbEm+RomVM7sNfNvCWLNr+QYJS4fN6QoQYIJ6FeY378lsW1/iEIJuN4SF4ypYd4LxIh+MyY+yh+xvzztnXIUKqbx3hzoNKlRUlFcz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561282; c=relaxed/simple;
	bh=gFQyR1Mt5Z8DlG8xDnMFXW5jGuGEJBzeY4z2HIaQUBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNm1iA0grpjFnFlnSVoa/R96fdG+wIAW29cjpahD/3y3gThXHatmu+w+oI3b0Cu5cUDcQQ3lb7YIgKc2jYmJ3jJZ9Kq1ukF2djY7ys+mpv4iWrq0XnSAXDENanGf0QIwwYQHxankXwCzAqHq4LXpPKSSt7JlPQs64MAHAX95OdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzBZEf2r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739561280; x=1771097280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gFQyR1Mt5Z8DlG8xDnMFXW5jGuGEJBzeY4z2HIaQUBM=;
  b=DzBZEf2rq/5IBHhdG8km917Kul97L0aXUtziQ8OsOG9aGRpLB2YGyxoj
   LI5ABypt3DUTdhjuFRNGyNawNYy8TEPNPisQdrrenJK6yoTXulyq8myIS
   yliU0EEmKw14dfZGwRPusjtO1BdGZbPGLu0jjFQVy0T4me5ObdcpDM58z
   7Mced83Q9629sr9yY82nKK1UI6uDoZZom89ZnezpAyR9n4v6hAiV8LJZ+
   ijw+ftS9OkRBF+H091z7EZPiHDovFgOYZtp3nMRqbvv44TenZ2ex4D3OU
   pTrn6Jn9EIljfCJMeE1v0p2UPCMcI4UDKxlSOQh807fzAgxugakMcStnz
   g==;
X-CSE-ConnectionGUID: DagfYyuWStqiaCl5duaPvQ==
X-CSE-MsgGUID: QxPGqW3TRlWW5vL7Z7u4qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40244146"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40244146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 11:27:54 -0800
X-CSE-ConnectionGUID: /Wsx342XQMmlbc2t9lLD6w==
X-CSE-MsgGUID: /M8gvpPGR0WLUcD9dj1dVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144394004"
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
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 09/14] libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
Date: Fri, 14 Feb 2025 11:27:30 -0800
Message-ID: <20250214192739.1175740-10-anthony.l.nguyen@intel.com>
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

Structs idpf_rx_csum_decoded and idpf_rx_extracted are used both in
idpf and iavf Intel drivers. Change the prefix from idpf_* to libeth_*
and move mentioned structs to libeth's rx.h header file.

Adjust usage in idpf driver.

Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 51 ++++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 16 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 19 -------
 include/net/libeth/rx.h                       | 47 +++++++++++++++++
 4 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index dfd7cf1d9aa0..eae1b6f474e6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -595,7 +595,7 @@ static bool idpf_rx_singleq_is_non_eop(const union virtchnl2_rx_desc *rx_desc)
  */
 static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
 				 struct sk_buff *skb,
-				 struct idpf_rx_csum_decoded csum_bits,
+				 struct libeth_rx_csum csum_bits,
 				 struct libeth_rx_pt decoded)
 {
 	bool ipv4, ipv6;
@@ -661,10 +661,10 @@ static void idpf_rx_singleq_csum(struct idpf_rx_queue *rxq,
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_singleq_base_csum(const union virtchnl2_rx_desc *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits = { };
+	struct libeth_rx_csum csum_bits = { };
 	u32 rx_error, rx_status;
 	u64 qword;
 
@@ -696,10 +696,10 @@ idpf_rx_singleq_base_csum(const union virtchnl2_rx_desc *rx_desc)
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_singleq_flex_csum(const union virtchnl2_rx_desc *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits = { };
+	struct libeth_rx_csum csum_bits = { };
 	u16 rx_status0, rx_status1;
 
 	rx_status0 = le16_to_cpu(rx_desc->flex_nic_wb.status_error0);
@@ -798,7 +798,7 @@ idpf_rx_singleq_process_skb_fields(struct idpf_rx_queue *rx_q,
 				   u16 ptype)
 {
 	struct libeth_rx_pt decoded = rx_q->rx_ptype_lkup[ptype];
-	struct idpf_rx_csum_decoded csum_bits;
+	struct libeth_rx_csum csum_bits;
 
 	/* modifies the skb - consumes the enet header */
 	skb->protocol = eth_type_trans(skb, rx_q->netdev);
@@ -891,6 +891,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  * idpf_rx_singleq_extract_base_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -900,20 +901,21 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
  */
 static void
 idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct idpf_rx_extracted *fields)
+				    struct libeth_rqe_info *fields, u32 *ptype)
 {
 	u64 qword;
 
 	qword = le64_to_cpu(rx_desc->base_wb.qword1.status_error_ptype_len);
 
-	fields->size = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_LEN_PBUF_M, qword);
-	fields->rx_ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
+	fields->len = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_LEN_PBUF_M, qword);
+	*ptype = FIELD_GET(VIRTCHNL2_RX_BASE_DESC_QW1_PTYPE_M, qword);
 }
 
 /**
  * idpf_rx_singleq_extract_flex_fields - Extract fields from the Rx descriptor
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  * Decode the Rx descriptor and extract relevant information including the
  * size and Rx packet type.
@@ -923,12 +925,12 @@ idpf_rx_singleq_extract_base_fields(const union virtchnl2_rx_desc *rx_desc,
  */
 static void
 idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
-				    struct idpf_rx_extracted *fields)
+				    struct libeth_rqe_info *fields, u32 *ptype)
 {
-	fields->size = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
-				 le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
-	fields->rx_ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
-				     le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
+	fields->len = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PKT_LEN_M,
+				le16_to_cpu(rx_desc->flex_nic_wb.pkt_len));
+	*ptype = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_PTYPE_M,
+			   le16_to_cpu(rx_desc->flex_nic_wb.ptype_flex_flags0));
 }
 
 /**
@@ -936,17 +938,18 @@ idpf_rx_singleq_extract_flex_fields(const union virtchnl2_rx_desc *rx_desc,
  * @rx_q: Rx descriptor queue
  * @rx_desc: the descriptor to process
  * @fields: storage for extracted values
+ * @ptype: pointer that will store packet type
  *
  */
 static void
 idpf_rx_singleq_extract_fields(const struct idpf_rx_queue *rx_q,
 			       const union virtchnl2_rx_desc *rx_desc,
-			       struct idpf_rx_extracted *fields)
+			       struct libeth_rqe_info *fields, u32 *ptype)
 {
 	if (rx_q->rxdids == VIRTCHNL2_RXDID_1_32B_BASE_M)
-		idpf_rx_singleq_extract_base_fields(rx_desc, fields);
+		idpf_rx_singleq_extract_base_fields(rx_desc, fields, ptype);
 	else
-		idpf_rx_singleq_extract_flex_fields(rx_desc, fields);
+		idpf_rx_singleq_extract_flex_fields(rx_desc, fields, ptype);
 }
 
 /**
@@ -966,9 +969,10 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	/* Process Rx packets bounded by budget */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
-		struct idpf_rx_extracted fields = { };
+		struct libeth_rqe_info fields = { };
 		union virtchnl2_rx_desc *rx_desc;
 		struct idpf_rx_buf *rx_buf;
+		u32 ptype;
 
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rx_q->rx[ntc];
@@ -989,16 +993,16 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		 */
 		dma_rmb();
 
-		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields);
+		idpf_rx_singleq_extract_fields(rx_q, rx_desc, &fields, &ptype);
 
 		rx_buf = &rx_q->rx_buf[ntc];
-		if (!libeth_rx_sync_for_cpu(rx_buf, fields.size))
+		if (!libeth_rx_sync_for_cpu(rx_buf, fields.len))
 			goto skip_data;
 
 		if (skb)
-			idpf_rx_add_frag(rx_buf, skb, fields.size);
+			idpf_rx_add_frag(rx_buf, skb, fields.len);
 		else
-			skb = idpf_rx_build_skb(rx_buf, fields.size);
+			skb = idpf_rx_build_skb(rx_buf, fields.len);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!skb)
@@ -1033,8 +1037,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 		total_rx_bytes += skb->len;
 
 		/* protocol */
-		idpf_rx_singleq_process_skb_fields(rx_q, skb,
-						   rx_desc, fields.rx_ptype);
+		idpf_rx_singleq_process_skb_fields(rx_q, skb, rx_desc, ptype);
 
 		/* send completed skb up the stack */
 		napi_gro_receive(rx_q->pp->p.napi, skb);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9be6a6b59c4e..2747dc69999a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2895,7 +2895,7 @@ idpf_rx_hash(const struct idpf_rx_queue *rxq, struct sk_buff *skb,
  * skb->protocol must be set before this function is called
  */
 static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
-			 struct idpf_rx_csum_decoded csum_bits,
+			 struct libeth_rx_csum csum_bits,
 			 struct libeth_rx_pt decoded)
 {
 	bool ipv4, ipv6;
@@ -2923,7 +2923,7 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 	if (unlikely(csum_bits.l4e))
 		goto checksum_fail;
 
-	if (csum_bits.raw_csum_inv ||
+	if (!csum_bits.raw_csum_valid ||
 	    decoded.inner_prot == LIBETH_RX_PT_INNER_SCTP) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 		return;
@@ -2946,10 +2946,10 @@ static void idpf_rx_csum(struct idpf_rx_queue *rxq, struct sk_buff *skb,
  *
  * Return: parsed checksum status.
  **/
-static struct idpf_rx_csum_decoded
+static struct libeth_rx_csum
 idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum = { };
+	struct libeth_rx_csum csum = { };
 	u8 qword0, qword1;
 
 	qword0 = rx_desc->status_err0_qw0;
@@ -2965,9 +2965,9 @@ idpf_rx_splitq_extract_csum_bits(const struct virtchnl2_rx_flex_desc_adv_nic_3 *
 			       qword1);
 	csum.ipv6exadd = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_STATUS0_IPV6EXADD_M,
 				   qword0);
-	csum.raw_csum_inv =
-		le16_get_bits(rx_desc->ptype_err_fflags0,
-			      VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M);
+	csum.raw_csum_valid =
+		!le16_get_bits(rx_desc->ptype_err_fflags0,
+			       VIRTCHNL2_RX_FLEX_DESC_ADV_RAW_CSUM_INV_M);
 	csum.raw_csum = le16_to_cpu(rx_desc->misc.raw_cs);
 
 	return csum;
@@ -3058,7 +3058,7 @@ static int
 idpf_rx_process_skb_fields(struct idpf_rx_queue *rxq, struct sk_buff *skb,
 			   const struct virtchnl2_rx_flex_desc_adv_nic_3 *rx_desc)
 {
-	struct idpf_rx_csum_decoded csum_bits;
+	struct libeth_rx_csum csum_bits;
 	struct libeth_rx_pt decoded;
 	u16 rx_ptype;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 0f71a6f5557b..cd9a20c9cc7f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -213,25 +213,6 @@ enum idpf_tx_ctx_desc_eipt_offload {
 	IDPF_TX_CTX_EXT_IP_IPV4         = 0x3
 };
 
-/* Checksum offload bits decoded from the receive descriptor. */
-struct idpf_rx_csum_decoded {
-	u32 l3l4p : 1;
-	u32 ipe : 1;
-	u32 eipe : 1;
-	u32 eudpe : 1;
-	u32 ipv6exadd : 1;
-	u32 l4e : 1;
-	u32 pprs : 1;
-	u32 nat : 1;
-	u32 raw_csum_inv : 1;
-	u32 raw_csum : 16;
-};
-
-struct idpf_rx_extracted {
-	unsigned int size;
-	u16 rx_ptype;
-};
-
 #define IDPF_TX_COMPLQ_CLEAN_BUDGET	256
 #define IDPF_TX_MIN_PKT_LEN		17
 #define IDPF_TX_DESCS_FOR_SKB_DATA_PTR	1
diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
index 43574bd6612f..ab05024be518 100644
--- a/include/net/libeth/rx.h
+++ b/include/net/libeth/rx.h
@@ -198,6 +198,53 @@ struct libeth_rx_pt {
 	enum xdp_rss_hash_type			hash_type:16;
 };
 
+/**
+ * struct libeth_rx_csum - checksum offload bits decoded from the Rx descriptor
+ * @l3l4p: detectable L3 and L4 integrity check is processed by the hardware
+ * @ipe: IP checksum error
+ * @eipe: external (outermost) IP header (only for tunels)
+ * @eudpe: external (outermost) UDP checksum error (only for tunels)
+ * @ipv6exadd: IPv6 header with extension headers
+ * @l4e: L4 integrity error
+ * @pprs: set for packets that skip checksum calculation in the HW pre parser
+ * @nat: the packet is a UDP tunneled packet
+ * @raw_csum_valid: set if raw checksum is valid
+ * @pad: padding to naturally align raw_csum field
+ * @raw_csum: raw checksum
+ */
+struct libeth_rx_csum {
+	u32					l3l4p:1;
+	u32					ipe:1;
+	u32					eipe:1;
+	u32					eudpe:1;
+	u32					ipv6exadd:1;
+	u32					l4e:1;
+	u32					pprs:1;
+	u32					nat:1;
+
+	u32					raw_csum_valid:1;
+	u32					pad:7;
+	u32					raw_csum:16;
+};
+
+/**
+ * struct libeth_rqe_info - receive queue element info
+ * @len: packet length
+ * @ptype: packet type based on types programmed into the device
+ * @eop: whether it's the last fragment of the packet
+ * @rxe: MAC errors: CRC, Alignment, Oversize, Undersizes, Length error
+ * @vlan: C-VLAN or S-VLAN tag depending on the VLAN offload configuration
+ */
+struct libeth_rqe_info {
+	u32					len;
+
+	u32					ptype:14;
+	u32					eop:1;
+	u32					rxe:1;
+
+	u32					vlan:16;
+};
+
 void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt *pt);
 
 /**
-- 
2.47.1



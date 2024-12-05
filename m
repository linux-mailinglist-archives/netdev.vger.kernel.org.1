Return-Path: <netdev+bounces-149198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5959E4BC1
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D14016AB31
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBF11474DA;
	Thu,  5 Dec 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNTw5DSm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040782C60
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733361784; cv=none; b=SvSIKnUz5yChiPfPPAx5fsr4a2RcCtPGSntg4jCsRSo+LApydHHbm0j96VifqpLBGZ2zVeXR6auZsH0F8r0ALuli0GrmgWaJtvcoCTEGEJgySrg4IigPXOx2QuYgoLT/yKdSxsOv4suWeYusx1D1yD34VTNONPneQu9fYcP30O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733361784; c=relaxed/simple;
	bh=3Xwt4tVh9I6gC0KpqPOdfPiO9zPIEXZUGn6x9cEvU9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQuBjXlkUDql6ltzs7zUPreP3uJdmpA9nhH9qbphBjhCLDzuPb56VV/39KZdH+QDS5JqhrxtSISiP2TA2UPxHgp0poHFpufqVPbnEt7C4zxWH7z/ec8/NwUBWQDEhNuKTqHdKrHfvbbB9PrLldr/UAtD6KvSrq72V8J+yVJKoFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNTw5DSm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733361783; x=1764897783;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=3Xwt4tVh9I6gC0KpqPOdfPiO9zPIEXZUGn6x9cEvU9g=;
  b=mNTw5DSmgmW7Hr43l8Q1ab8JwXqOUrmOi4bMWx9Ge6UVqfeDYe8xn/Kw
   rk1/9R0JG3a7Q7/zH/Uc8c0FQprkdUtZFJ50B9cRQF3Zg+MI1XWY0ZweS
   GsmShyJgNf9dUdtjw4TukoXnzsyXotW1I+5Hqae1Kp90KWmS2kMXc/uzy
   tQrEBFNXFb0+YOC88u5t9UEDkPYwCZSV4Jv8O0OwcqE3y/5dpH6iB9ZZz
   gvT7JjZesJVw9tihJb0dZoT3M1Ca37AsB8kJyk3XSr1SROKK65v+U7hnP
   DcFdAqRMin6HzY+GFKskmKhk0gZFkyvl6RF0YNqdHhjnxjX8tdPsL9OeO
   A==;
X-CSE-ConnectionGUID: DMnfrzN1TBWXPv8mjWgfXg==
X-CSE-MsgGUID: JXHU5LIeSG2KQ1l6p6YG7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32993847"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="32993847"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
X-CSE-ConnectionGUID: NqSMIrzNRXSRmFXxasg10A==
X-CSE-MsgGUID: LIP5A54CT0CTcN1mUUni9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="98905977"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 17:23:00 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 04 Dec 2024 17:22:52 -0800
Subject: [PATCH net-next v9 06/10] ice: use structures to keep track of
 queue context size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-packing-pack-fields-and-ice-implementation-v9-6-81c8f2bd7323@intel.com>
References: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
In-Reply-To: <20241204-packing-pack-fields-and-ice-implementation-v9-0-81c8f2bd7323@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

The ice Tx and Rx queue context are currently stored as arrays of bytes
with defined size (ICE_RXQ_CTX_SZ and ICE_TXQ_CTX_SZ). The packed queue
context is often passed to other functions as a simple u8 * pointer, which
does not allow tracking the size. This makes the queue context API easy to
misuse, as you can pass an arbitrary u8 array or pointer.

Introduce wrapper typedefs which use a __packed structure that has the
proper fixed size for the Tx and Rx context buffers. This enables the
compiler to track the size of the value and ensures that passing the wrong
buffer size will be detected by the compiler.

The existing APIs do not benefit much from this change, however the
wrapping structures will be used to simplify the arguments of new packing
functions based on the recently introduced pack_fields API.

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 11 +++++++++--
 drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h  |  2 --
 drivers/net/ethernet/intel/ice/ice_base.c       |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c     | 24 +++++++++++-------------
 4 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1489a8ceec51df890f481f7fdc04b1845ca85255..3bf05b135b3557e5867ef037d02621a59dc251d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -12,6 +12,13 @@
 #define ICE_AQC_TOPO_MAX_LEVEL_NUM	0x9
 #define ICE_AQ_SET_MAC_FRAME_SIZE_MAX	9728
 
+#define ICE_RXQ_CTX_SIZE_DWORDS		8
+#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
+#define ICE_TXQ_CTX_SZ			22
+
+typedef struct __packed { u8 buf[ICE_RXQ_CTX_SZ]; } ice_rxq_ctx_buf_t;
+typedef struct __packed { u8 buf[ICE_TXQ_CTX_SZ]; } ice_txq_ctx_buf_t;
+
 struct ice_aqc_generic {
 	__le32 param0;
 	__le32 param1;
@@ -2084,10 +2091,10 @@ struct ice_aqc_add_txqs_perq {
 	__le16 txq_id;
 	u8 rsvd[2];
 	__le32 q_teid;
-	u8 txq_ctx[22];
+	ice_txq_ctx_buf_t txq_ctx;
 	u8 rsvd2[2];
 	struct ice_aqc_txsched_elem info;
-};
+} __packed;
 
 /* The format of the command buffer for Add Tx LAN Queues (0x0C30)
  * is an array of the following structs. Please note that the length of
diff --git a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
index 0e8ed8c226e68988664d64c1fd3297cee32af020..a76e5b0e7861e39e59013637cb176f67d1f7ef15 100644
--- a/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
+++ b/drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h
@@ -371,8 +371,6 @@ enum ice_rx_flex_desc_status_error_1_bits {
 	ICE_RX_FLEX_DESC_STATUS1_LAST /* this entry must be last!!! */
 };
 
-#define ICE_RXQ_CTX_SIZE_DWORDS		8
-#define ICE_RXQ_CTX_SZ			(ICE_RXQ_CTX_SIZE_DWORDS * sizeof(u32))
 #define ICE_TX_CMPLTNQ_CTX_SIZE_DWORDS	22
 #define ICE_TX_DRBELL_Q_CTX_SIZE_DWORDS	5
 #define GLTCLAN_CQ_CNTX(i, CQ)		(GLTCLAN_CQ_CNTX0(CQ) + ((i) * 0x0800))
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 82a9cd4ec7aec90febdc7ab31cf8d707314cbd1f..e7aaa06241210e764b4cb627031310e4fd5b6520 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -910,7 +910,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_tx_ring *ring,
 	ice_setup_tx_ctx(ring, &tlan_ctx, pf_q);
 	/* copy context contents into the qg_buf */
 	qg_buf->txqs[0].txq_id = cpu_to_le16(pf_q);
-	ice_set_ctx(hw, (u8 *)&tlan_ctx, qg_buf->txqs[0].txq_ctx,
+	ice_set_ctx(hw, (u8 *)&tlan_ctx, (u8 *)&qg_buf->txqs[0].txq_ctx,
 		    ice_tlan_ctx_info);
 
 	/* init queue specific tail reg. It is referred as
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 0f5a80269a7be0a302d4229a42bb8bbfc500905a..48d95cb49864ad73769487d2b95b2e8306156cf9 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1359,29 +1359,27 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
 /**
  * ice_copy_rxq_ctx_to_hw
  * @hw: pointer to the hardware structure
- * @ice_rxq_ctx: pointer to the rxq context
+ * @rxq_ctx: pointer to the packed Rx queue context
  * @rxq_index: the index of the Rx queue
  *
  * Copies rxq context from dense structure to HW register space
  */
-static int
-ice_copy_rxq_ctx_to_hw(struct ice_hw *hw, u8 *ice_rxq_ctx, u32 rxq_index)
+static int ice_copy_rxq_ctx_to_hw(struct ice_hw *hw,
+				  const ice_rxq_ctx_buf_t *rxq_ctx,
+				  u32 rxq_index)
 {
 	u8 i;
 
-	if (!ice_rxq_ctx)
-		return -EINVAL;
-
 	if (rxq_index > QRX_CTRL_MAX_INDEX)
 		return -EINVAL;
 
 	/* Copy each dword separately to HW */
 	for (i = 0; i < ICE_RXQ_CTX_SIZE_DWORDS; i++) {
-		wr32(hw, QRX_CONTEXT(i, rxq_index),
-		     *((u32 *)(ice_rxq_ctx + (i * sizeof(u32)))));
+		u32 ctx = ((const u32 *)rxq_ctx)[i];
 
-		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i,
-			  *((u32 *)(ice_rxq_ctx + (i * sizeof(u32)))));
+		wr32(hw, QRX_CONTEXT(i, rxq_index), ctx);
+
+		ice_debug(hw, ICE_DBG_QCTX, "qrxdata[%d]: %08X\n", i, ctx);
 	}
 
 	return 0;
@@ -1426,15 +1424,15 @@ static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
 int ice_write_rxq_ctx(struct ice_hw *hw, struct ice_rlan_ctx *rlan_ctx,
 		      u32 rxq_index)
 {
-	u8 ctx_buf[ICE_RXQ_CTX_SZ] = { 0 };
+	ice_rxq_ctx_buf_t buf = {};
 
 	if (!rlan_ctx)
 		return -EINVAL;
 
 	rlan_ctx->prefena = 1;
 
-	ice_set_ctx(hw, (u8 *)rlan_ctx, ctx_buf, ice_rlan_ctx_info);
-	return ice_copy_rxq_ctx_to_hw(hw, ctx_buf, rxq_index);
+	ice_set_ctx(hw, (u8 *)rlan_ctx, (u8 *)&buf, ice_rlan_ctx_info);
+	return ice_copy_rxq_ctx_to_hw(hw, &buf, rxq_index);
 }
 
 /* LAN Tx Queue Context */

-- 
2.47.0.265.g4ca455297942



Return-Path: <netdev+bounces-150828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38479EBAD6
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C71658B6
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B08C22838C;
	Tue, 10 Dec 2024 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJlmMCvu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC6D227BBE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862454; cv=none; b=n+bnjwQVJrTlPv4mGq7hHlbJtncGcPOvdyEsv6xzc2BUcXmGXRrPNb/1+zYSOQG0ncgk0f/VXM36w7ggMrbnf8JI+6q7pnUI/zyjmSpQvwkz1rKagvP6+2otZVd0/F5d5da+IShV9y8me8rAs1FO3QGcrwJN+GSBYdslAV49S48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862454; c=relaxed/simple;
	bh=opb7uT48Y2WFi1vJb20CXuj96U1Alzvz9aui6U1K5ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nq4SzcKULwWWtt3irgucyYIdGBH5soFwDztfHmOcN4VQYXRv7+ZhLTg388b1kwA9uYP+vLUJoi+EhL+5U6pd0PM9FeYZVO0LA+1FnT6h3ZkfZslXV2ot+NufBpGqQm9BqiDDmTt5LeBL0disiYygb+0WMYg/8LjlRUuNjz5+//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJlmMCvu; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733862452; x=1765398452;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=opb7uT48Y2WFi1vJb20CXuj96U1Alzvz9aui6U1K5ac=;
  b=TJlmMCvu6dBnSjIRxfD3pJA5A/p8pOe0jKsxBb1OGGE08FEdtdumPgQ/
   kWvW+JINW0HK9dFbqq5h0HYfD1hpYRuiP9S9zxmJU5DOYm8Zf6pjlMi+S
   v3Y3WSYXS63SdUv0tpalZPhuqt85Ypqe9YsDrV6Nw8hn3s6FGmmfA8v0h
   SLgWW8DTaVgW3/efwLIQ0F9W/QvqdiUE+RS6zmgxuoHXad+W1cyRqHpYL
   jTzC/aC9DMwHmuzdIt7oexg9HeNtlRxeQJZC2Wpd3AGpcZc96bjXNNwHo
   dlWqs2lSAUGyfpW/1EdsiPWQgqhvgSdl27Z6rsNu/S4/ViW3z+ep3xtux
   g==;
X-CSE-ConnectionGUID: 083uMLEVQOi6nRkgpfH7sg==
X-CSE-MsgGUID: DhGHPvgVQravHvzILTAh8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34147307"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="34147307"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
X-CSE-ConnectionGUID: WgmtICwhQESbaC8Oy66d1A==
X-CSE-MsgGUID: +SSTj3HPRf6fDsnlnKR2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="126424095"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 12:27:28 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 10 Dec 2024 12:27:15 -0800
Subject: [PATCH net-next v10 06/10] ice: use structures to keep track of
 queue context size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-packing-pack-fields-and-ice-implementation-v10-6-ee56a47479ac@intel.com>
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
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
index e2a4f4897119f68a4036b69caca0a03dbc6636ce..64bf25aab673c103803018fd6822f94462e089db 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1362,29 +1362,27 @@ int ice_reset(struct ice_hw *hw, enum ice_reset_req req)
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
@@ -1429,15 +1427,15 @@ static const struct ice_ctx_ele ice_rlan_ctx_info[] = {
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



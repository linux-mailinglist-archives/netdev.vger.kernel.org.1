Return-Path: <netdev+bounces-47506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AEE7EA6BA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316D9281056
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2263D38D;
	Mon, 13 Nov 2023 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBJLcPsR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601902E41A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:10:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF2199
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917056; x=1731453056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tClPFLH91EX7/9fxOmXtzx1yFSQy4V1bxIwa8Lnkq5A=;
  b=gBJLcPsRhieyQJk7VRMRYk3PLHzpB9/o8yJTOH6VBy2urxvrCC++oIGQ
   6cZeIRQOPnIQICq9SWC6o3IfLomsGd8G4Dw97jF6GuElSILx6IDstfOB9
   vU0OwKN+srrImUzKpwrwpqhwlA6RvQMUhC2ffIVgT8iQZbV1XoG+IHORp
   dbOl6Ks8kHoluk38FlvkkXDdIbUm+7PKnFUgEidniTO4LfL/spm33FVhy
   LC6iGHQTuv3IGA9NsrfNmeB25qV2bW/PtLznIM7TPLmiD5/BWNYzQXrgr
   s8Pso9kNtzWKX6zhxO8G29/jRUMR1IOGzXF4YLyh+Hj0cRHij4CvRc71A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562613"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562613"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051403"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051403"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 04/15] i40e: Remove unused flags
Date: Mon, 13 Nov 2023 15:10:23 -0800
Message-ID: <20231113231047.548659-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

The flag I40E_FLAG_RX_CSUM_ENABLED and I40E_HW_FLAG_DROP_MODE are
set and never read. Remove them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 57 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  3 +-
 4 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index e070a1b908f7..7d83dcbd9294 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -502,33 +502,32 @@ struct i40e_pf {
 #define I40E_HW_RESTART_AUTONEG			BIT(18)
 
 	u32 flags;
-#define I40E_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40E_FLAG_MSI_ENABLED			BIT(1)
-#define I40E_FLAG_MSIX_ENABLED			BIT(2)
-#define I40E_FLAG_RSS_ENABLED			BIT(3)
-#define I40E_FLAG_VMDQ_ENABLED			BIT(4)
-#define I40E_FLAG_SRIOV_ENABLED			BIT(5)
-#define I40E_FLAG_DCB_CAPABLE			BIT(6)
-#define I40E_FLAG_DCB_ENABLED			BIT(7)
-#define I40E_FLAG_FD_SB_ENABLED			BIT(8)
-#define I40E_FLAG_FD_ATR_ENABLED		BIT(9)
-#define I40E_FLAG_MFP_ENABLED			BIT(10)
-#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(11)
-#define I40E_FLAG_VEB_MODE_ENABLED		BIT(12)
-#define I40E_FLAG_VEB_STATS_ENABLED		BIT(13)
-#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(14)
-#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(15)
-#define I40E_FLAG_LEGACY_RX			BIT(16)
-#define I40E_FLAG_PTP				BIT(17)
-#define I40E_FLAG_IWARP_ENABLED			BIT(18)
-#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(19)
-#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT(20)
-#define I40E_FLAG_TC_MQPRIO			BIT(21)
-#define I40E_FLAG_FD_SB_INACTIVE		BIT(22)
-#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(23)
-#define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
-#define I40E_FLAG_RS_FEC			BIT(25)
-#define I40E_FLAG_BASE_R_FEC			BIT(26)
+#define I40E_FLAG_MSI_ENABLED			BIT(0)
+#define I40E_FLAG_MSIX_ENABLED			BIT(1)
+#define I40E_FLAG_RSS_ENABLED			BIT(2)
+#define I40E_FLAG_VMDQ_ENABLED			BIT(3)
+#define I40E_FLAG_SRIOV_ENABLED			BIT(4)
+#define I40E_FLAG_DCB_CAPABLE			BIT(5)
+#define I40E_FLAG_DCB_ENABLED			BIT(6)
+#define I40E_FLAG_FD_SB_ENABLED			BIT(7)
+#define I40E_FLAG_FD_ATR_ENABLED		BIT(8)
+#define I40E_FLAG_MFP_ENABLED			BIT(9)
+#define I40E_FLAG_HW_ATR_EVICT_ENABLED		BIT(10)
+#define I40E_FLAG_VEB_MODE_ENABLED		BIT(11)
+#define I40E_FLAG_VEB_STATS_ENABLED		BIT(12)
+#define I40E_FLAG_LINK_POLLING_ENABLED		BIT(13)
+#define I40E_FLAG_TRUE_PROMISC_SUPPORT		BIT(14)
+#define I40E_FLAG_LEGACY_RX			BIT(15)
+#define I40E_FLAG_PTP				BIT(16)
+#define I40E_FLAG_IWARP_ENABLED			BIT(17)
+#define I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED	BIT(18)
+#define I40E_FLAG_SOURCE_PRUNING_DISABLED       BIT(19)
+#define I40E_FLAG_TC_MQPRIO			BIT(20)
+#define I40E_FLAG_FD_SB_INACTIVE		BIT(21)
+#define I40E_FLAG_FD_SB_TO_CLOUD_FILTER		BIT(22)
+#define I40E_FLAG_DISABLE_FW_LLDP		BIT(23)
+#define I40E_FLAG_RS_FEC			BIT(24)
+#define I40E_FLAG_BASE_R_FEC			BIT(25)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
@@ -550,8 +549,8 @@ struct i40e_pf {
  *   the link is being brought down by clearing bit (I40E_AQ_PHY_ENABLE_LINK)
  *   in abilities field of i40e_aq_set_phy_config structure
  */
-#define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(27)
-#define I40E_FLAG_VF_VLAN_PRUNING		BIT(28)
+#define I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED	BIT(26)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 
 	struct i40e_client_instance *cinst;
 	bool stat_offsets_loaded;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 9ce6e633cc2f..9a5a47b29bb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -555,10 +555,8 @@ static void i40e_set_hw_flags(struct i40e_hw *hw)
 
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
-	     aq->api_min_ver >= 8)) {
+	     aq->api_min_ver >= 8))
 		hw->flags |= I40E_HW_FLAG_FW_LLDP_PERSISTENT;
-		hw->flags |= I40E_HW_FLAG_DROP_MODE;
-	}
 
 	if (aq->api_maj_ver > 1 ||
 	    (aq->api_maj_ver == 1 &&
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index af8491f3211d..2158a93261cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -12717,9 +12717,7 @@ static int i40e_sw_init(struct i40e_pf *pf)
 	u16 pow;
 
 	/* Set default capability flags */
-	pf->flags = I40E_FLAG_RX_CSUM_ENABLED |
-		    I40E_FLAG_MSI_ENABLED     |
-		    I40E_FLAG_MSIX_ENABLED;
+	pf->flags = I40E_FLAG_MSI_ENABLED | I40E_FLAG_MSIX_ENABLED;
 
 	/* Set default ITR */
 	pf->rx_itr_default = I40E_ITR_RX_DEF;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index aff6dc6afbe2..060aac35d945 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -553,8 +553,7 @@ struct i40e_hw {
 #define I40E_HW_FLAG_FW_LLDP_STOPPABLE      BIT_ULL(4)
 #define I40E_HW_FLAG_FW_LLDP_PERSISTENT     BIT_ULL(5)
 #define I40E_HW_FLAG_AQ_PHY_ACCESS_EXTENDED BIT_ULL(6)
-#define I40E_HW_FLAG_DROP_MODE              BIT_ULL(7)
-#define I40E_HW_FLAG_X722_FEC_REQUEST_CAPABLE BIT_ULL(8)
+#define I40E_HW_FLAG_X722_FEC_REQUEST_CAPABLE BIT_ULL(7)
 	u64 flags;
 
 	/* Used in set switch config AQ command */
-- 
2.41.0



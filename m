Return-Path: <netdev+bounces-166344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC38A359CF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E02E3AE718
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6C24292B;
	Fri, 14 Feb 2025 09:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c1Q+5405"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DCD22D7BD;
	Fri, 14 Feb 2025 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524142; cv=none; b=gdAKOlPloIv+6U0jeEwZRyROsAUJOZlIIi3wfHU3Mm8AHFjUjM9UCwqITepz9naaEpeIZ5D28b7qhZKKGqRRIJ5UxEMn2gDAtzt7837PLoccgSx4mkKlwfsvGeXTmEySCOduUeRthvQM4F8mdMc9hstHb7el3YDDqLSOuIYNvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524142; c=relaxed/simple;
	bh=H98Bqklr7q/mPZHaEnRcSWObw+lF7Q6e+gb7HAqxuxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pRS8hvrWPVHxQPYKdJARjAc16wuE1iOfAPxW49VvUl1JiqF3uQOT6eCTOCGb4dTS7Z7ZPCHjVqo9KWU7qxWXySpiklnvthHb3/GzLGLSBJNSDsaWr/wQUy6vi4jdBx6zpyfbxulqFkUmJknpdHa8H4iZm1AtS6woW47uFqkd7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c1Q+5405; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739524141; x=1771060141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H98Bqklr7q/mPZHaEnRcSWObw+lF7Q6e+gb7HAqxuxo=;
  b=c1Q+5405eCxEl5/NXjzipkeEU9BnT63FgelJB7aMf2VFM53aR2mCdsLH
   hzfOvSNrS/vlZcbp3F5nTNaNsX7YsCjAoUKh6n3O2YCoY3CH5jTR2gWZp
   VUkgzgBSvco+6vT8TlqqSv50wdlexvVFgvzeXzn39SgvWy8vuodWlQLB7
   RxdzDmWseuEvIXhfyzZ2/J5BBZg+DzB09uTWeVG/WR1ToH32JFlvsCG3N
   bYHkIdEWkXQ17Yi2W7LLCIUsvIpIXf4Pn/BEMH5/U4gfzso0SRxwlqjq+
   AzTx8UwyzWu6YG5Kf81LoiJB0xRDDNHF0Y+uP1pY5gP7+EEWkA6BX1wec
   Q==;
X-CSE-ConnectionGUID: O2uLs+oNTOKsDWdyQI2Dww==
X-CSE-MsgGUID: 7MDS4B5jQuO8AFo1ODrUQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="65617711"
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="65617711"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 01:09:01 -0800
X-CSE-ConnectionGUID: 1hrmlDdMQzK90dTSqTMTRw==
X-CSE-MsgGUID: aq3hPS44RC6xbLvbDPsU1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,285,1732608000"; 
   d="scan'208";a="113145447"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 14 Feb 2025 01:08:58 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 84D3537B87;
	Fri, 14 Feb 2025 09:08:56 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Subject: [PATCH iwl-next v4 2/6] ice: do not add LLDP-specific filter if not necessary
Date: Fri, 14 Feb 2025 09:50:36 +0100
Message-ID: <20250214085215.2846063-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214085215.2846063-1-larysa.zaremba@intel.com>
References: <20250214085215.2846063-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 34295a3696fb ("ice: implement new LLDP filter command")
introduced the ability to use LLDP-specific filter that directs all
LLDP traffic to a single VSI. However, current goal is for all trusted VFs
to be able to see LLDP neighbors, which is impossible to do with the
special filter.

Make using the generic filter the default choice and fall back to special
one only if a generic filter cannot be added. That way setups with "NVMs
where an already existent LLDP filter is blocking the creation of a filter
to allow LLDP packets" will still be able to configure software Rx LLDP on
PF only, while all other setups would be able to forward them to VFs too.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  1 +
 drivers/net/ethernet/intel/ice/ice_common.c | 14 +++++++++----
 drivers/net/ethernet/intel/ice/ice_common.h |  3 +--
 drivers/net/ethernet/intel/ice/ice_lib.c    | 23 ++++++++++++++-------
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7200d6042590..53b990e2e850 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -518,6 +518,7 @@ enum ice_pf_flags {
 	ICE_FLAG_MTU_CHANGED,
 	ICE_FLAG_GNSS,			/* GNSS successfully initialized */
 	ICE_FLAG_DPLL,			/* SyncE/PTP dplls initialized */
+	ICE_FLAG_LLDP_AQ_FLTR,
 	ICE_PF_FLAGS_NBITS		/* must be last */
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index aaa592ffd2d8..f2e51bacecf8 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6010,15 +6010,21 @@ bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw)
 /**
  * ice_lldp_fltr_add_remove - add or remove a LLDP Rx switch filter
  * @hw: pointer to HW struct
- * @vsi_num: absolute HW index for VSI
+ * @vsi: VSI to add the filter to
  * @add: boolean for if adding or removing a filter
+ *
+ * Return: 0 on success, -EOPNOTSUPP if the operation cannot be performed
+ *	   with this HW or VSI, otherwise an error corresponding to
+ *	   the AQ transaction result.
  */
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
+int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add)
 {
 	struct ice_aqc_lldp_filter_ctrl *cmd;
 	struct ice_aq_desc desc;
 
+	if (vsi->type != ICE_VSI_PF || !ice_fw_supports_lldp_fltr_ctrl(hw))
+		return -EOPNOTSUPP;
+
 	cmd = &desc.params.lldp_filter_ctrl;
 
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_lldp_filter_ctrl);
@@ -6028,7 +6034,7 @@ ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add)
 	else
 		cmd->cmd_flags = ICE_AQC_LLDP_FILTER_ACTION_DELETE;
 
-	cmd->vsi_num = cpu_to_le16(vsi_num);
+	cmd->vsi_num = cpu_to_le16(vsi->vsi_num);
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index 9b00aa0ddf10..64c530b39191 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -290,8 +290,7 @@ int
 ice_aq_set_lldp_mib(struct ice_hw *hw, u8 mib_type, void *buf, u16 buf_size,
 		    struct ice_sq_cd *cd);
 bool ice_fw_supports_lldp_fltr_ctrl(struct ice_hw *hw);
-int
-ice_lldp_fltr_add_remove(struct ice_hw *hw, u16 vsi_num, bool add);
+int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add);
 int ice_lldp_execute_pending_mib(struct ice_hw *hw);
 int
 ice_aq_read_i2c(struct ice_hw *hw, struct ice_aqc_link_topo_addr topo_addr,
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 96ad1d8be8dd..edab19a44707 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2085,19 +2085,28 @@ void ice_cfg_sw_lldp(struct ice_vsi *vsi, bool tx, bool create)
 		status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_TX,
 				  ICE_DROP_PACKET);
 	} else {
-		if (ice_fw_supports_lldp_fltr_ctrl(&pf->hw)) {
-			status = ice_lldp_fltr_add_remove(&pf->hw, vsi->vsi_num,
-							  create);
-		} else {
+		if (!test_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags)) {
 			status = eth_fltr(vsi, ETH_P_LLDP, ICE_FLTR_RX,
 					  ICE_FWD_TO_VSI);
+			if (!status || !create)
+				goto report;
+
+			dev_info(dev,
+				 "Failed to add generic LLDP Rx filter on VSI %i error: %d, falling back to specialized AQ control\n",
+				 vsi->vsi_num, status);
 		}
+
+		status = ice_lldp_fltr_add_remove(&pf->hw, vsi, create);
+		if (!status)
+			set_bit(ICE_FLAG_LLDP_AQ_FLTR, pf->flags);
+
 	}
 
+report:
 	if (status)
-		dev_dbg(dev, "Fail %s %s LLDP rule on VSI %i error: %d\n",
-			create ? "adding" : "removing", tx ? "TX" : "RX",
-			vsi->vsi_num, status);
+		dev_warn(dev, "Failed to %s %s LLDP rule on VSI %i error: %d\n",
+			 create ? "add" : "remove", tx ? "Tx" : "Rx",
+			 vsi->vsi_num, status);
 }
 
 /**
-- 
2.43.0



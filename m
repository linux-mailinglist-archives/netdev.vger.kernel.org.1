Return-Path: <netdev+bounces-100578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACC8FB3A5
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF55288610
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39288146D4C;
	Tue,  4 Jun 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSqgpfMp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7F146A89
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507498; cv=none; b=ggqIj9mQX6Sz9luVhD1z/GFOiKmN9DixttqdeZ4cwVuJoyUeXl7Ongv81K1Gab8eCavNHNpA1Xtn+1ZnHc6yJ1pTsyB/YgYxT/zStlcppJzwa23A4wjt5HOlGw1FMnC07JT7+YGWnJ0r+yZuWdZLhvEuyOVQCCa9NIWhP0iYAOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507498; c=relaxed/simple;
	bh=IO2jeLpmSBlGJIMnMe2EKScV1dp0BXiOB1Owvc8lWPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pY1TWidUvZWhxV6y66VkhPQHw5DRyJ17EOtCCZUfO2qXVvUq0DuYLBs7sxwrXkYGfRImFkxZzX94DpcY3CpnBYUumhF6HYZBo/gzfhyci1++32CowDVHzCS5FfUNoMd1hlUPUvKKnpqfhQPsOf0RP0JNkP//W13pOueh4iA9TRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSqgpfMp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507496; x=1749043496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IO2jeLpmSBlGJIMnMe2EKScV1dp0BXiOB1Owvc8lWPs=;
  b=PSqgpfMpABbSRXyaCF/uULbfFrAi7ect+tefyQaYwtmP8zxYmlQiVp1C
   Kd6kQoz4NA7PQWlvn0w+mUspnBB0LpzkAO1Bmyi03i1K72SBaYzE+GFh3
   vsb5j2gFKY26AnloTTC2o5gB3pY+YiJ/6UMouewIi/JdH9j6wSStnyWTK
   xMpZF5tezZAsR+e8UMN7S161AU4D+tzFMSzt/pGYnuqaYynA2KWmnFsxR
   R9p/dVM7EZzGFbtdomDJxujX/uMyaxI57UnU5J1DpjKTvwkF+nJ46dPFR
   zLnKwSnzl92mnBCjD+o70Dl5mhLu25eYgQe9wKjtHBn5XrhZUitybI1A/
   w==;
X-CSE-ConnectionGUID: bjkqa+TtSJ29MSIp1rauaA==
X-CSE-MsgGUID: tLK2KkprQ2uilJkgyE9qnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14245375"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14245375"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:24:56 -0700
X-CSE-ConnectionGUID: i/KahzbFRoWT4TnRNkd2bw==
X-CSE-MsgGUID: 0Iejz18/SaOHpgP47/mzHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37109738"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 06:24:53 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AC4FB125B8;
	Tue,  4 Jun 2024 14:24:45 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Simei Su <simei.su@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v7 02/12] ice: support Rx timestamp on flex descriptor
Date: Tue,  4 Jun 2024 09:13:50 -0400
Message-Id: <20240604131400.13655-3-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Simei Su <simei.su@intel.com>

To support Rx timestamp offload, VIRTCHNL_OP_1588_PTP_CAPS is sent by
the VF to request PTP capability and responded by the PF what capability
is enabled for that VF.

Hardware captures timestamps which contain only 32 bits of nominal
nanoseconds, as opposed to the 64bit timestamps that the stack expects.
To convert 32b to 64b, we need a current PHC time.
VIRTCHNL_OP_1588_PTP_GET_TIME is sent by the VF and responded by the
PF with the current PHC time.

Signed-off-by: Simei Su <simei.su@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_base.c     |  3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 86 ++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |  6 ++
 include/linux/avf/virtchnl.h                  | 15 +++-
 8 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index f3dfce136106..81315e58236a 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -469,9 +469,6 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	 */
 	if (vsi->type != ICE_VSI_VF)
 		ice_write_qrxflxp_cntxt(hw, pf_q, rxdid, 0x3, true);
-	else
-		ice_write_qrxflxp_cntxt(hw, pf_q, ICE_RXDID_LEGACY_1, 0x3,
-					false);
 
 	/* Absolute queue number out of 2K needs to be passed */
 	err = ice_write_rxq_ctx(hw, &rlan_ctx, pf_q);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b7ab6fdf710d..cee6f0d6181e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -364,8 +364,8 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
  */
-static u64
-ice_ptp_read_src_clk_reg(struct ice_pf *pf, struct ptp_system_timestamp *sts)
+u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts)
 {
 	struct ice_hw *hw = &pf->hw;
 	u32 hi, lo, lo2;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index e0c23aaedc12..7697f64261c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -315,6 +315,8 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf);
 
+u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
+			     struct ptp_system_timestamp *sts);
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
 void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index be4266899690..fdc63fae1803 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -136,6 +136,8 @@ struct ice_vf {
 	const struct ice_virtchnl_ops *virtchnl_ops;
 	const struct ice_vf_ops *vf_ops;
 
+	struct virtchnl_ptp_caps ptp_caps;
+
 	/* devlink port data */
 	struct devlink_port devlink_port;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 82ad4c6ff4d7..4f5e36c063e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -495,6 +495,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_USO)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_USO;
 
+	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP)
+		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
+
 	vfres->num_vsis = 1;
 	/* Tx and Rx queue are equal for VF */
 	vfres->num_queue_pairs = vsi->num_txq;
@@ -1783,9 +1786,17 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				rxdid = ICE_RXDID_LEGACY_1;
 			}
 
-			ice_write_qrxflxp_cntxt(&vsi->back->hw,
-						vsi->rxq_map[q_idx],
-						rxdid, 0x03, false);
+			if (vf->driver_caps &
+			    VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC &&
+			    vf->driver_caps & VIRTCHNL_VF_CAP_PTP &&
+			    qpi->rxq.flags & VIRTCHNL_PTP_RX_TSTAMP)
+				ice_write_qrxflxp_cntxt(&vsi->back->hw,
+							vsi->rxq_map[q_idx],
+							rxdid, 0x03, true);
+			else
+				ice_write_qrxflxp_cntxt(&vsi->back->hw,
+							vsi->rxq_map[q_idx],
+							rxdid, 0x03, false);
 		}
 	}
 
@@ -3788,6 +3799,65 @@ static int ice_vc_dis_vlan_insertion_v2_msg(struct ice_vf *vf, u8 *msg)
 				     v_ret, NULL, 0);
 }
 
+static int ice_vc_get_ptp_cap(struct ice_vf *vf, u8 *msg)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	u32 msg_caps;
+	int ret;
+
+	/* VF is not in active state */
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	msg_caps = ((struct virtchnl_ptp_caps *)msg)->caps;
+
+	/* Any VF asking for RX timestamping and reading PHC will get that */
+	if (msg_caps & (VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
+	    VIRTCHNL_1588_PTP_CAP_READ_PHC))
+		vf->ptp_caps.caps = VIRTCHNL_1588_PTP_CAP_RX_TSTAMP |
+				    VIRTCHNL_1588_PTP_CAP_READ_PHC;
+
+err:
+	/* send the response back to the VF */
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_CAPS, v_ret,
+				    (u8 *)&vf->ptp_caps,
+				    sizeof(struct virtchnl_ptp_caps));
+	return ret;
+}
+
+static int ice_vc_get_phc_time(struct ice_vf *vf)
+{
+	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
+	struct virtchnl_phc_time *phc_time = NULL;
+	struct ice_pf *pf = vf->pf;
+	int len = 0;
+	int ret;
+
+	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err;
+	}
+
+	len = sizeof(struct virtchnl_phc_time);
+	phc_time = kzalloc(len, GFP_KERNEL);
+	if (!phc_time) {
+		v_ret = VIRTCHNL_STATUS_ERR_NO_MEMORY;
+		len = 0;
+		goto err;
+	}
+
+	phc_time->time = ice_ptp_read_src_clk_reg(pf, NULL);
+
+err:
+	/* send the response back to the VF */
+	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_1588_PTP_GET_TIME,
+				    v_ret, (u8 *)phc_time, len);
+	kfree(phc_time);
+	return ret;
+}
+
 static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.get_ver_msg = ice_vc_get_ver_msg,
 	.get_vf_res_msg = ice_vc_get_vf_res_msg,
@@ -3821,6 +3891,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.dis_vlan_stripping_v2_msg = ice_vc_dis_vlan_stripping_v2_msg,
 	.ena_vlan_insertion_v2_msg = ice_vc_ena_vlan_insertion_v2_msg,
 	.dis_vlan_insertion_v2_msg = ice_vc_dis_vlan_insertion_v2_msg,
+	.get_ptp_cap = ice_vc_get_ptp_cap,
+	.get_phc_time = ice_vc_get_phc_time,
 };
 
 /**
@@ -3951,6 +4023,8 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.dis_vlan_stripping_v2_msg = ice_vc_dis_vlan_stripping_v2_msg,
 	.ena_vlan_insertion_v2_msg = ice_vc_ena_vlan_insertion_v2_msg,
 	.dis_vlan_insertion_v2_msg = ice_vc_dis_vlan_insertion_v2_msg,
+	.get_ptp_cap = ice_vc_get_ptp_cap,
+	.get_phc_time = ice_vc_get_phc_time,
 };
 
 /**
@@ -4177,6 +4251,12 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	case VIRTCHNL_OP_DISABLE_VLAN_INSERTION_V2:
 		err = ops->dis_vlan_insertion_v2_msg(vf, msg);
 		break;
+	case VIRTCHNL_OP_1588_PTP_GET_CAPS:
+		err = ops->get_ptp_cap(vf, msg);
+		break;
+	case VIRTCHNL_OP_1588_PTP_GET_TIME:
+		err = ops->get_phc_time(vf);
+		break;
 	case VIRTCHNL_OP_UNKNOWN:
 	default:
 		dev_err(dev, "Unsupported opcode %d from VF %d\n", v_opcode,
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.h b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
index 3a4115869153..e1c32f0f2e7a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.h
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.h
@@ -61,6 +61,8 @@ struct ice_virtchnl_ops {
 	int (*dis_vlan_stripping_v2_msg)(struct ice_vf *vf, u8 *msg);
 	int (*ena_vlan_insertion_v2_msg)(struct ice_vf *vf, u8 *msg);
 	int (*dis_vlan_insertion_v2_msg)(struct ice_vf *vf, u8 *msg);
+	int (*get_ptp_cap)(struct ice_vf *vf, u8 *msg);
+	int (*get_phc_time)(struct ice_vf *vf);
 };
 
 #ifdef CONFIG_PCI_IOV
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
index d796dbd2a440..7a442a53f4cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_allowlist.c
@@ -84,6 +84,11 @@ static const u32 fdir_pf_allowlist_opcodes[] = {
 	VIRTCHNL_OP_ADD_FDIR_FILTER, VIRTCHNL_OP_DEL_FDIR_FILTER,
 };
 
+/* VIRTCHNL_VF_CAP_PTP */
+static const u32 ptp_allowlist_opcodes[] = {
+	VIRTCHNL_OP_1588_PTP_GET_CAPS, VIRTCHNL_OP_1588_PTP_GET_TIME,
+};
+
 struct allowlist_opcode_info {
 	const u32 *opcodes;
 	size_t size;
@@ -104,6 +109,7 @@ static const struct allowlist_opcode_info allowlist_opcodes[] = {
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_ADV_RSS_PF, adv_rss_pf_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_FDIR_PF, fdir_pf_allowlist_opcodes),
 	ALLOW_ITEM(VIRTCHNL_VF_OFFLOAD_VLAN_V2, vlan_v2_allowlist_opcodes),
+	ALLOW_ITEM(VIRTCHNL_VF_CAP_PTP, ptp_allowlist_opcodes),
 };
 
 /**
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 3663ad743de1..48bdfa1dc893 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -304,6 +304,18 @@ struct virtchnl_txq_info {
 
 VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_txq_info);
 
+/* virtchnl_rxq_info_flags
+ *
+ * Definition of bits in the flags field of the virtchnl_rxq_info structure.
+ */
+enum virtchnl_rxq_info_flags {
+	/* If the VIRTCHNL_PTP_RX_TSTAMP bit of the flag field is set, this is
+	 * a request to enable Rx timestamp. Other flag bits are currently
+	 * reserved and they may be extended in the future.
+	 */
+	VIRTCHNL_PTP_RX_TSTAMP = BIT(0),
+};
+
 /* VIRTCHNL_OP_CONFIG_RX_QUEUE
  * VF sends this message to set up parameters for one RX queue.
  * External data buffer contains one instance of virtchnl_rxq_info.
@@ -327,7 +339,8 @@ struct virtchnl_rxq_info {
 	u32 max_pkt_size;
 	u8 crc_disable;
 	u8 rxdid;
-	u8 pad1[2];
+	u8 flags; /* see virtchnl_rxq_info_flags */
+	u8 pad1;
 	u64 dma_ring_addr;
 
 	/* see enum virtchnl_rx_hsplit; deprecated with AVF 1.0 */
-- 
2.38.1



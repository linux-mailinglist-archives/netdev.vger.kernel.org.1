Return-Path: <netdev+bounces-133360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83156995BBB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE9D3B2157D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF3B2185BD;
	Tue,  8 Oct 2024 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYgeKpn+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7821859C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430492; cv=none; b=UDSXZB1TvFNtrrlxQC6klpfFU1mJkRpxwIHzIMWu34KCHyOVeKcR/4RiXvLbqPg7afMPViXE4zH1HmkloPkMGQ+8AeWoHJ/XxlSy3ep09VDzloO9Vg+47x3sfZ5O/j4QpTR84d2b2rl6qW22F0sF4jXEh2XGXI43wyBKVALCod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430492; c=relaxed/simple;
	bh=dOBFTuZy7bInWZkxJA5v6TxSkFuLqsA4dyFEhx4JYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfaVmc4i1rsfkwiBgDkHWAL82fOv+f9yUwzqzTCQ3g/m9KTl881MC6p05PS/yrq8ddLhnnHLUmgr4I7salYZPWim74axZN6XgCZeOIaFNXWo2y7ZejfGjNFHZTpm9hJSZAsPAEIyPaiE0l+0UKcpiBdqr81U198oryh88jkNrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYgeKpn+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430490; x=1759966490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dOBFTuZy7bInWZkxJA5v6TxSkFuLqsA4dyFEhx4JYP8=;
  b=KYgeKpn+qxQmu2NlDl+q6l6CJ+VNCR1pR9iXEQwoUXE/e9WU3dxQB3Vr
   GZn5ksc2pKxPDGzs39yHPHHpTiH0mDp8stYIy9EmxmtBhvOm2CwvF+C26
   E1NEpXmQ+pAhcbaELcWBHoWP2JPkU9zbFQhFW7/vRb/lD3RVbUbtL29FZ
   qRTf/uS5KCRUg4C1mO0e1uuJDdr7JkqURtdgosbbyKZ+CtFFu8Z/cZtZe
   jDyj5YDapn4++uNWFVIYyKv+z4ux8ly0uI3ycUb7TNJVABjcz+kT/fYKQ
   /8baif2Wo2yDpa8+oF928Gvrm7Wj+YE84xAG37R5q0jn7kT1CHULXSJFL
   w==;
X-CSE-ConnectionGUID: EQuXLLgxSZm/UwnnB1Xx6g==
X-CSE-MsgGUID: F0trPeAvT3SeM7s6sw2I5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779867"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779867"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:48 -0700
X-CSE-ConnectionGUID: vw5OUPwFTMKkx0oqJi/7hw==
X-CSE-MsgGUID: jlZ0BiJ6QxKV3CYZy+Q98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794179"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	david.m.ertman@intel.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 02/12] ice: add E830 HW VF mailbox message limit support
Date: Tue,  8 Oct 2024 16:34:28 -0700
Message-ID: <20241008233441.928802-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

E830 adds hardware support to prevent the VF from overflowing the PF
mailbox with VIRTCHNL messages. E830 will use the hardware feature
(ICE_F_MBX_LIMIT) instead of the software solution ice_is_malicious_vf().

To prevent a VF from overflowing the PF, the PF sets the number of
messages per VF that can be in the PF's mailbox queue
(ICE_MBX_OVERFLOW_WATERMARK). When the PF processes a message from a VF,
the PF decrements the per VF message count using the E830_MBX_VF_DEC_TRIG
register.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  3 ++
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 ++
 drivers/net/ethernet/intel/ice/ice_main.c     | 24 ++++++++++----
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  3 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 26 +++++++++++++--
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c   | 32 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_mbx.h   |  9 ++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  8 +++--
 9 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 558cda577191..2960709f6b62 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -207,6 +207,7 @@ enum ice_feature {
 	ICE_F_GNSS,
 	ICE_F_ROCE_LAG,
 	ICE_F_SRIOV_LAG,
+	ICE_F_MBX_LIMIT,
 	ICE_F_MAX
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 91cbae1eec89..8d31bfe28cc8 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -539,5 +539,8 @@
 #define E830_PRTMAC_CL01_QNT_THR_CL0_M		GENMASK(15, 0)
 #define VFINT_DYN_CTLN(_i)			(0x00003800 + ((_i) * 4))
 #define VFINT_DYN_CTLN_CLEARPBA_M		BIT(1)
+#define E830_MBX_PF_IN_FLIGHT_VF_MSGS_THRESH	0x00234000
+#define E830_MBX_VF_DEC_TRIG(_VF)		(0x00233800 + (_VF) * 4)
+#define E830_MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT(_VF)	(0x00233000 + (_VF) * 4)
 
 #endif /* _ICE_HW_AUTOGEN_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 06e712cdc3d9..d4e74f96a8ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3880,6 +3880,9 @@ void ice_init_feature_support(struct ice_pf *pf)
 	default:
 		break;
 	}
+
+	if (pf->hw.mac_type == ICE_MAC_E830)
+		ice_set_feature_support(pf, ICE_F_MBX_LIMIT);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eeb48cc48e08..9f6e8a5508a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1563,12 +1563,20 @@ static int __ice_clean_ctrlq(struct ice_pf *pf, enum ice_ctl_q q_type)
 			ice_vf_lan_overflow_event(pf, &event);
 			break;
 		case ice_mbx_opc_send_msg_to_pf:
-			data.num_msg_proc = i;
-			data.num_pending_arq = pending;
-			data.max_num_msgs_mbx = hw->mailboxq.num_rq_entries;
-			data.async_watermark_val = ICE_MBX_OVERFLOW_WATERMARK;
+			if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT)) {
+				ice_vc_process_vf_msg(pf, &event, NULL);
+				ice_mbx_vf_dec_trig_e830(hw, &event);
+			} else {
+				u16 val = hw->mailboxq.num_rq_entries;
+
+				data.max_num_msgs_mbx = val;
+				val = ICE_MBX_OVERFLOW_WATERMARK;
+				data.async_watermark_val = val;
+				data.num_msg_proc = i;
+				data.num_pending_arq = pending;
 
-			ice_vc_process_vf_msg(pf, &event, &data);
+				ice_vc_process_vf_msg(pf, &event, &data);
+			}
 			break;
 		case ice_aqc_opc_fw_logs_event:
 			ice_get_fwlog_data(pf, &event);
@@ -4099,7 +4107,11 @@ static int ice_init_pf(struct ice_pf *pf)
 
 	mutex_init(&pf->vfs.table_lock);
 	hash_init(pf->vfs.table);
-	ice_mbx_init_snapshot(&pf->hw);
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		wr32(&pf->hw, E830_MBX_PF_IN_FLIGHT_VF_MSGS_THRESH,
+		     ICE_MBX_OVERFLOW_WATERMARK);
+	else
+		ice_mbx_init_snapshot(&pf->hw);
 
 	xa_init(&pf->dyn_ports);
 	xa_init(&pf->sf_nums);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index e34fe2516ccc..e7b5fe553d1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -194,7 +194,8 @@ void ice_free_vfs(struct ice_pf *pf)
 		}
 
 		/* clear malicious info since the VF is getting released */
-		list_del(&vf->mbx_info.list_entry);
+		if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+			list_del(&vf->mbx_info.list_entry);
 
 		mutex_unlock(&vf->cfg_lock);
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index a69e91f88d81..d618292dfe27 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -709,6 +709,23 @@ ice_vf_clear_vsi_promisc(struct ice_vf *vf, struct ice_vsi *vsi, u8 promisc_m)
 	return 0;
 }
 
+/**
+ * ice_reset_vf_mbx_cnt - reset VF mailbox message count
+ * @vf: pointer to the VF structure
+ *
+ * This function clears the VF mailbox message count, and should be called on
+ * VF reset.
+ */
+static void ice_reset_vf_mbx_cnt(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		ice_mbx_vf_clear_cnt_e830(&pf->hw, vf->vf_id);
+	else
+		ice_mbx_clear_malvf(&vf->mbx_info);
+}
+
 /**
  * ice_reset_all_vfs - reset all allocated VFs in one go
  * @pf: pointer to the PF structure
@@ -735,7 +752,7 @@ void ice_reset_all_vfs(struct ice_pf *pf)
 
 	/* clear all malicious info if the VFs are getting reset */
 	ice_for_each_vf(pf, bkt, vf)
-		ice_mbx_clear_malvf(&vf->mbx_info);
+		ice_reset_vf_mbx_cnt(vf);
 
 	/* If VFs have been disabled, there is no need to reset */
 	if (test_and_set_bit(ICE_VF_DIS, pf->state)) {
@@ -951,7 +968,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	ice_eswitch_update_repr(&vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
-	ice_mbx_clear_malvf(&vf->mbx_info);
+	ice_reset_vf_mbx_cnt(vf);
 
 out_unlock:
 	if (lag && lag->bonded && lag->primary &&
@@ -1004,7 +1021,10 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	ice_vf_fdir_init(vf);
 
 	/* Initialize mailbox info for this VF */
-	ice_mbx_init_vf_info(&pf->hw, &vf->mbx_info);
+	if (ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		ice_mbx_vf_clear_cnt_e830(&pf->hw, vf->vf_id);
+	else
+		ice_mbx_init_vf_info(&pf->hw, &vf->mbx_info);
 
 	mutex_init(&vf->cfg_lock);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_mbx.c b/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
index 40cb4ba0789c..75c8113e58ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_mbx.c
@@ -210,6 +210,38 @@ ice_mbx_detect_malvf(struct ice_hw *hw, struct ice_mbx_vf_info *vf_info,
 	return 0;
 }
 
+/**
+ * ice_mbx_vf_dec_trig_e830 - Decrements the VF mailbox queue counter
+ * @hw: pointer to the HW struct
+ * @event: pointer to the control queue receive event
+ *
+ * This function triggers to decrement the counter
+ * MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT when the driver replenishes
+ * the buffers at the PF mailbox queue.
+ */
+void ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			      const struct ice_rq_event_info *event)
+{
+	u16 vfid = le16_to_cpu(event->desc.retval);
+
+	wr32(hw, E830_MBX_VF_DEC_TRIG(vfid), 1);
+}
+
+/**
+ * ice_mbx_vf_clear_cnt_e830 - Clear the VF mailbox queue count
+ * @hw: pointer to the HW struct
+ * @vf_id: VF ID in the PF space
+ *
+ * This function clears the counter MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT, and should
+ * be called when a VF is created and on VF reset.
+ */
+void ice_mbx_vf_clear_cnt_e830(const struct ice_hw *hw, u16 vf_id)
+{
+	u32 reg = rd32(hw, E830_MBX_VF_IN_FLIGHT_MSGS_AT_PF_CNT(vf_id));
+
+	wr32(hw, E830_MBX_VF_DEC_TRIG(vf_id), reg);
+}
+
 /**
  * ice_mbx_vf_state_handler - Handle states of the overflow algorithm
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_mbx.h b/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
index 44bc030d17e0..684de89e5c5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_mbx.h
@@ -19,6 +19,9 @@ ice_aq_send_msg_to_vf(struct ice_hw *hw, u16 vfid, u32 v_opcode, u32 v_retval,
 		      u8 *msg, u16 msglen, struct ice_sq_cd *cd);
 
 u32 ice_conv_link_speed_to_virtchnl(bool adv_link_support, u16 link_speed);
+void ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			      const struct ice_rq_event_info *event);
+void ice_mbx_vf_clear_cnt_e830(const struct ice_hw *hw, u16 vf_id);
 int
 ice_mbx_vf_state_handler(struct ice_hw *hw, struct ice_mbx_data *mbx_data,
 			 struct ice_mbx_vf_info *vf_info, bool *report_malvf);
@@ -47,5 +50,11 @@ static inline void ice_mbx_init_snapshot(struct ice_hw *hw)
 {
 }
 
+static inline void
+ice_mbx_vf_dec_trig_e830(const struct ice_hw *hw,
+			 const struct ice_rq_event_info *event)
+{
+}
+
 #endif /* CONFIG_PCI_IOV */
 #endif /* _ICE_VF_MBX_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 59f62306b9cb..3c86d0c2fe1f 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4009,8 +4009,10 @@ ice_is_malicious_vf(struct ice_vf *vf, struct ice_mbx_data *mbxdata)
  * @event: pointer to the AQ event
  * @mbxdata: information used to detect VF attempting mailbox overflow
  *
- * called from the common asq/arq handler to
- * process request from VF
+ * Called from the common asq/arq handler to process request from VF. When this
+ * flow is used for devices with hardware VF to PF message queue overflow
+ * support (ICE_F_MBX_LIMIT) mbxdata is set to NULL and ice_is_malicious_vf
+ * check is skipped.
  */
 void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 			   struct ice_mbx_data *mbxdata)
@@ -4036,7 +4038,7 @@ void ice_vc_process_vf_msg(struct ice_pf *pf, struct ice_rq_event_info *event,
 	mutex_lock(&vf->cfg_lock);
 
 	/* Check if the VF is trying to overflow the mailbox */
-	if (ice_is_malicious_vf(vf, mbxdata))
+	if (mbxdata && ice_is_malicious_vf(vf, mbxdata))
 		goto finish;
 
 	/* Check if VF is disabled. */
-- 
2.42.0



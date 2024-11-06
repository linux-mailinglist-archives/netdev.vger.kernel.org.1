Return-Path: <netdev+bounces-142299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE529BE265
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B978EB23FB7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205031DB55D;
	Wed,  6 Nov 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsGCq3dM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5CD1DA11A;
	Wed,  6 Nov 2024 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885079; cv=none; b=BUEp6mpNzh8HD6bbC8VyER5e0A+CUuzncAPzzgOTFTyV/GKPQRt46RmooDwc/KhbtNJ5eeU7qEC0x5vH6nkAgFHI/lBIJdkssEZBehfQS/FXc3cr5tyP/2GpwivovxKqcDOXcnB9lg8cyZR8LU76qAEsJ6x4bxPbt71DX02tyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885079; c=relaxed/simple;
	bh=XW2EyZ8K2p0vp7qzvoZKXXqJbZvXqsmm06U4t6GU84Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZkR9PJXgzouOPvVbPKplgaCNmuuOz7u/KGMbaoriO5V5vLzIYvsTrid27STQnJ+bBO8iYSjNsEvkPWqXQQrCILj4x+wPY74aQH9fbtb/Rlm2AjBU0e4XIPLOHzYpeh+luSzFf4mvWbXig830oqPQuvnJAlkumlHHF17Qh6Q/S7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsGCq3dM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730885077; x=1762421077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XW2EyZ8K2p0vp7qzvoZKXXqJbZvXqsmm06U4t6GU84Y=;
  b=OsGCq3dM2J5eSIsAw2R6/Od7n/bqyQoiWos+LI427prGA1hISqXAvO6g
   rDPhXI3G/7LkHowXTbAu26Ifabzg0NNLRgdKJJHRmHUfLTNjI7uev3ZVq
   S6xphV4oV1GfNNMhdzUJGW4o8jyhivRYCVeSCyHz0xMFGZ/QGqZ63aP5g
   XVIg/3u8i/XR9bEjuHFGGRKLPfdgnEBiHI/sfGOeCpEX+BkG0sCSWNFwj
   4rDAwTcG6GVt0pwJRm8usc3Me3/NmPYfW8g6GY+vEHlWDSwibyUYU9Ehq
   +5mFrOAxlMtRSsQ4LiHHl29zZWCD7JlHsusDqY3qyjJo/L3Xi6JVpOmv1
   g==;
X-CSE-ConnectionGUID: 9h4FbUGGSGKS3X5J6Xkt2w==
X-CSE-MsgGUID: LmmpxJTRRZe95b3c/PAPJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34368408"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34368408"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 01:24:36 -0800
X-CSE-ConnectionGUID: +tkNWUVkSqWsfdhtIZPzVQ==
X-CSE-MsgGUID: hZ4OcSnQS427B1ZOUfuzPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="115221999"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 06 Nov 2024 01:24:15 -0800
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 1605528780;
	Wed,  6 Nov 2024 09:24:13 +0000 (GMT)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Konrad Knitter <konrad.knitter@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v2 3/3] ice: support FW Recovery Mode
Date: Wed,  6 Nov 2024 10:36:43 +0100
Message-Id: <20241106093643.106476-4-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106093643.106476-1-konrad.knitter@intel.com>
References: <20241106093643.106476-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recovery Mode is intended to recover from a fatal failure scenario in
which the device is not accessible to the host, meaning the firmware is
non-responsive.

The purpose of the Firmware Recovery Mode is to enable software tools to
update firmware and/or device configuration so the fatal error can be
resolved.

Recovery Mode Firmware supports a limited set of admin commands required
for NVM update.
Recovery Firmware does not support hardware interrupts so a polling mode
is used.

The driver will expose only the minimum set of devlink commands required
for the recovery of the adapter.

Using an appropriate NVM image, the user can recover the adapter using
the devlink flash API.

Prior to 4.20 E810 Adapter Recovery Firmware supports only the update
and erase of the "fw.mgmt" component.

E810 Adapter Recovery Firmware doesn't support selected preservation of
cards settings or identifiers.

The following command can be used to recover the adapter:

$ devlink dev flash <pci-address> <update-image.bin> component fw.mgmt
  overwrite settings overwrite identifier

Newer FW versions (4.20 or newer) supports update of "fw.undi" and
"fw.netlist" components.

$ devlink dev flash <pci-address> <update-image.bin>

Tested on Intel Corporation Ethernet Controller E810-C for SFP
FW revision 3.20 and 4.30.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 .../net/ethernet/intel/ice/devlink/devlink.c  |  8 ++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 .../net/ethernet/intel/ice/ice_fw_update.c    | 14 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  6 +++
 drivers/net/ethernet/intel/ice/ice_lib.h      |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 53 +++++++++++++++++++
 6 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index d1b9ccec5e05..d116e2b10bce 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -368,14 +368,18 @@ static int ice_devlink_info_get(struct devlink *devlink,
 			}
 			break;
 		case ICE_VERSION_RUNNING:
-			err = devlink_info_version_running_put(req, key, ctx->buf);
+			err = devlink_info_version_running_put_ext(req, key,
+								   ctx->buf,
+								   DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 			if (err) {
 				NL_SET_ERR_MSG_MOD(extack, "Unable to set running version");
 				goto out_free_ctx;
 			}
 			break;
 		case ICE_VERSION_STORED:
-			err = devlink_info_version_stored_put(req, key, ctx->buf);
+			err = devlink_info_version_stored_put_ext(req, key,
+								  ctx->buf,
+								  DEVLINK_INFO_VERSION_TYPE_COMPONENT);
 			if (err) {
 				NL_SET_ERR_MSG_MOD(extack, "Unable to set stored version");
 				goto out_free_ctx;
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1489a8ceec51..b026478fd98d 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1807,6 +1807,7 @@ struct ice_aqc_nvm_pass_comp_tbl {
 #define ICE_AQ_NVM_PASS_COMP_CAN_BE_UPDATED		0x0
 #define ICE_AQ_NVM_PASS_COMP_CAN_MAY_BE_UPDATEABLE	0x1
 #define ICE_AQ_NVM_PASS_COMP_CAN_NOT_BE_UPDATED		0x2
+#define ICE_AQ_NVM_PASS_COMP_PARTIAL_CHECK		0x3
 	u8 component_response_code; /* Response only */
 #define ICE_AQ_NVM_PASS_COMP_CAN_BE_UPDATED_CODE	0x0
 #define ICE_AQ_NVM_PASS_COMP_STAMP_IDENTICAL_CODE	0x1
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index 2702a0da5c3e..70c201f569ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -6,6 +6,7 @@
 #include <linux/crc32.h>
 #include <linux/pldmfw.h>
 #include "ice.h"
+#include "ice_lib.h"
 #include "ice_fw_update.h"
 
 struct ice_fwu_priv {
@@ -125,6 +126,10 @@ ice_check_component_response(struct ice_pf *pf, u16 id, u8 response, u8 code,
 	case ICE_AQ_NVM_PASS_COMP_CAN_NOT_BE_UPDATED:
 		dev_info(dev, "firmware has rejected updating %s\n", component);
 		break;
+	case ICE_AQ_NVM_PASS_COMP_PARTIAL_CHECK:
+		if (ice_is_recovery_mode(&pf->hw))
+			return 0;
+		break;
 	}
 
 	switch (code) {
@@ -1004,13 +1009,20 @@ int ice_devlink_flash_update(struct devlink *devlink,
 		return -EOPNOTSUPP;
 	}
 
-	if (!hw->dev_caps.common_cap.nvm_unified_update) {
+	if (!hw->dev_caps.common_cap.nvm_unified_update && !ice_is_recovery_mode(hw)) {
 		NL_SET_ERR_MSG_MOD(extack, "Current firmware does not support unified update");
 		return -EOPNOTSUPP;
 	}
 
 	memset(&priv, 0, sizeof(priv));
 
+	if (params->component && strcmp(params->component, "fw.mgmt") == 0) {
+		priv.context.mode = PLDMFW_UPDATE_MODE_SINGLE_COMPONENT;
+		priv.context.component_identifier = NVM_COMP_ID_NVM;
+	} else if (params->component) {
+		return -EOPNOTSUPP;
+	}
+
 	/* the E822 device needs a slightly different ops */
 	if (hw->mac_type == ICE_MAC_GENERIC)
 		priv.context.ops = &ice_fwu_ops_e822;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 01220e21cc81..0cb7137d17d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1708,6 +1708,12 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf)
 	return true;
 }
 
+#define ICE_FW_MODE_REC_M BIT(1)
+bool ice_is_recovery_mode(struct ice_hw *hw)
+{
+	return rd32(hw, GL_MNG_FWSM) & ICE_FW_MODE_REC_M;
+}
+
 /**
  * ice_update_eth_stats - Update VSI-specific ethernet statistics counters
  * @vsi: the VSI to be updated
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 10d6fc479a32..eabb35834a24 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -90,6 +90,7 @@ void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
 
 bool ice_is_safe_mode(struct ice_pf *pf);
 bool ice_is_rdma_ena(struct ice_pf *pf);
+bool ice_is_recovery_mode(struct ice_hw *hw);
 bool ice_is_dflt_vsi_in_use(struct ice_port_info *pi);
 bool ice_is_vsi_dflt_vsi(struct ice_vsi *vsi);
 int ice_set_dflt_vsi(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f3dd300a7dad..41f0d0933c2b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2361,6 +2361,18 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 	}
 }
 
+static void ice_service_task_recovery_mode(struct work_struct *work)
+{
+	struct ice_pf *pf = container_of(work, struct ice_pf, serv_task);
+
+	set_bit(ICE_ADMINQ_EVENT_PENDING, pf->state);
+	ice_clean_adminq_subtask(pf);
+
+	ice_service_task_complete(pf);
+
+	mod_timer(&pf->serv_tmr, jiffies + msecs_to_jiffies(100));
+}
+
 /**
  * ice_service_task - manage and run subtasks
  * @work: pointer to work_struct contained by the PF struct
@@ -5211,6 +5223,36 @@ void ice_unload(struct ice_pf *pf)
 	ice_decfg_netdev(vsi);
 }
 
+static int ice_probe_recovery_mode(struct ice_pf *pf)
+{
+	struct device *dev = ice_pf_to_dev(pf);
+	int err;
+
+	dev_err(dev, "Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode\n");
+
+	INIT_HLIST_HEAD(&pf->aq_wait_list);
+	spin_lock_init(&pf->aq_wait_lock);
+	init_waitqueue_head(&pf->aq_wait_queue);
+
+	timer_setup(&pf->serv_tmr, ice_service_timer, 0);
+	pf->serv_tmr_period = HZ;
+	INIT_WORK(&pf->serv_task, ice_service_task_recovery_mode);
+	clear_bit(ICE_SERVICE_SCHED, pf->state);
+	err = ice_create_all_ctrlq(&pf->hw);
+	if (err)
+		return err;
+
+	scoped_guard(devl, priv_to_devlink(pf)) {
+		err = ice_init_devlink(pf);
+		if (err)
+			return err;
+	}
+
+	ice_service_task_restart(pf);
+
+	return 0;
+}
+
 /**
  * ice_probe - Device initialization routine
  * @pdev: PCI device information struct
@@ -5302,6 +5344,9 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		hw->debug_mask = debug;
 #endif
 
+	if (ice_is_recovery_mode(hw))
+		return ice_probe_recovery_mode(pf);
+
 	err = ice_init_hw(hw);
 	if (err) {
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
@@ -5419,6 +5464,14 @@ static void ice_remove(struct pci_dev *pdev)
 		msleep(100);
 	}
 
+	if (ice_is_recovery_mode(&pf->hw)) {
+		ice_service_task_stop(pf);
+		scoped_guard(devl, priv_to_devlink(pf)) {
+			ice_deinit_devlink(pf);
+		}
+		return;
+	}
+
 	if (test_bit(ICE_FLAG_SRIOV_ENA, pf->flags)) {
 		set_bit(ICE_VF_RESETS_DISABLED, pf->state);
 		ice_free_vfs(pf);
-- 
2.38.1



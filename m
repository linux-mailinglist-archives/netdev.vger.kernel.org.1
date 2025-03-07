Return-Path: <netdev+bounces-172976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA75A56AAA
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 397A03B7085
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17321CC47;
	Fri,  7 Mar 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTRDBEfW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7F421CC40
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358345; cv=none; b=LUEfFy4H2P6+hqjORsDY1EXdhtywmu4djOgtnTlKsG5ir8QH1za1fA1DyUPRY4kIcX5zTb98SczvkMvFYCgYiKkZjGJT3/1RbnG8ByOlnyKnnPhebJ74jLUHu6d7QM1nUddVenSD1GhB2cXMpWBwKQr0q54KOtyvDjI+SnlEtws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358345; c=relaxed/simple;
	bh=qkFt8g5DsR01cKknO0ulQ5mIOJgvpZQPFnZmGkrAkzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQaaKVTZr3xtxReygWKQ5mpqtWOnxAD/UMeR295fzu+h03qMkQnrvvhA/laojT/DTc38eatCn6fo8CAQLD53kjbpuzZR1pCPk4ub79i7ALztcj2kaq2MLP6BsOTobaEyxMgKeF3hD/vaVn2s2VloD3tFZUbIvWKaAsOSjmaRqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTRDBEfW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741358344; x=1772894344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qkFt8g5DsR01cKknO0ulQ5mIOJgvpZQPFnZmGkrAkzs=;
  b=PTRDBEfWPUV+6xkRatpxKkEkcsAyyhR8E0g8i0uKzGqgSPlL1PhiSMGQ
   miJsh/Zpcql7veJ5WAniZ9pzQxHLqIPAXQsR7d44xCyE3jOC0pD7ImIGb
   6qRsrqeBSF6gqIE1kh9XSg+/NVsI9tFZIOkxFE9cLBqRcfX4GM35Y9ilM
   CAYF0mhzRmaIBYMxtO+qJ7cXETACBR9BYajNJmkG+9vKJAR7u5KW63RDP
   oSRMbLrKiCjcD4nDiOcmgN9wG0KBnRucqeTtRd9EGQ1OPzFIIJU4vr5qI
   SaFejCVRuPEgwHQ3FihTOICbKMRUL5VseY3W4xJJ7lhIaCjxySA5MsSEW
   Q==;
X-CSE-ConnectionGUID: G/q7gXAKTimSnz5po0pcYg==
X-CSE-MsgGUID: QE0uy6gqQB2tY0JJZFHuVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42263398"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42263398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 06:39:04 -0800
X-CSE-ConnectionGUID: /SQcE9B6Rs6RSWaans+aTQ==
X-CSE-MsgGUID: 2b4lyHU1SpiIQ/sy0QPZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="142570891"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 07 Mar 2025 06:39:01 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Andrii Staikov <andrii.staikov@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v6 15/15] ixgbe: add support for FW rollback mode
Date: Fri,  7 Mar 2025 15:24:19 +0100
Message-Id: <20250307142419.314402-16-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
References: <20250307142419.314402-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andrii Staikov <andrii.staikov@intel.com>

The driver should detect whether the device entered FW rollback
mode and then notify user with the dedicated message including
FW and NVM versions.

Even if the driver detected rollback mode, this should not result
in an probe error and the normal flow proceeds.

FW tries to rollback to “old” operational FW located in the
inactive NVM bank in cases when newly loaded FW exhibits faulty
behavior. If something goes wrong during boot the FW may switch
into rollback mode in an attempt to avoid recovery mode and stay
operational. After rollback is successful, the banks are swapped,
and the “rollback” bank becomes the active bank for the next reset.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 33 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 26 +++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 ++
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  1 +
 6 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index dce09f5bd8df..6efa094e6a29 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -496,7 +496,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 
-	adapter->flags2 &= ~IXGBE_FLAG2_API_MISMATCH;
+	adapter->flags2 &= ~(IXGBE_FLAG2_API_MISMATCH |
+			     IXGBE_FLAG2_FW_ROLLBACK);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 2246997bc9fb..23c2e2c2649c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -672,6 +672,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_NO_MEDIA			BIT(21)
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
+#define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index d4a3943faa21..5154ce861f2a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -1831,6 +1831,22 @@ static bool ixgbe_fw_recovery_mode_e610(struct ixgbe_hw *hw)
 	return !!(fwsm & IXGBE_GL_MNG_FWSM_RECOVERY_M);
 }
 
+/**
+ * ixgbe_fw_rollback_mode_e610 - Check FW NVM rollback mode
+ * @hw: pointer to hardware structure
+ *
+ * Check FW NVM rollback mode by reading the value of
+ * the dedicated register.
+ *
+ * Return: true if FW is in rollback mode, otherwise false.
+ */
+static bool ixgbe_fw_rollback_mode_e610(struct ixgbe_hw *hw)
+{
+	u32 fwsm = IXGBE_READ_REG(hw, IXGBE_GL_MNG_FWSM);
+
+	return !!(fwsm & IXGBE_GL_MNG_FWSM_ROLLBACK_M);
+}
+
 /**
  * ixgbe_init_phy_ops_e610 - PHY specific init
  * @hw: pointer to hardware structure
@@ -3163,6 +3179,21 @@ int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
 	return ixgbe_get_nvm_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, nvm);
 }
 
+/**
+ * ixgbe_get_active_nvm_ver - Read Option ROM version from the active bank
+ * @hw: pointer to the HW structure
+ * @nvm: storage for Option ROM version information
+ *
+ * Reads the NVM EETRACK ID, Map version, and security revision of the
+ * active NVM bank.
+ *
+ * Return: the exit code of the operation.
+ */
+static int ixgbe_get_active_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
+{
+	return ixgbe_get_nvm_ver_info(hw, IXGBE_ACTIVE_FLASH_BANK, nvm);
+}
+
 /**
  * ixgbe_get_netlist_info - Read the netlist version information
  * @hw: pointer to the HW struct
@@ -3897,6 +3928,8 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
 	.fw_recovery_mode		= ixgbe_fw_recovery_mode_e610,
+	.fw_rollback_mode		= ixgbe_fw_rollback_mode_e610,
+	.get_nvm_ver			= ixgbe_get_active_nvm_ver,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0667e4e85f10..3013ca7ae7e3 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8420,6 +8420,32 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 			return true;
 	}
 
+	/* return here if FW rollback mode has been already detected */
+	if (adapter->flags2 & IXGBE_FLAG2_FW_ROLLBACK)
+		return false;
+
+	if (hw->mac.ops.fw_rollback_mode && hw->mac.ops.fw_rollback_mode(hw)) {
+		struct ixgbe_nvm_info *nvm_info = &adapter->hw.flash.nvm;
+		char ver_buff[64] = "";
+
+		if (hw->mac.ops.get_fw_ver && hw->mac.ops.get_fw_ver(hw))
+			goto no_version;
+
+		if (hw->mac.ops.get_nvm_ver &&
+		    hw->mac.ops.get_nvm_ver(hw, nvm_info))
+			goto no_version;
+
+		snprintf(ver_buff, sizeof(ver_buff),
+			 "Current version is NVM:%x.%x.%x, FW:%d.%d. ",
+			 nvm_info->major, nvm_info->minor, nvm_info->eetrack,
+			 hw->fw_maj_ver, hw->fw_maj_ver);
+no_version:
+		e_dev_warn("Firmware rollback mode detected. %sDevice may exhibit limited functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware rollback mode.",
+			   ver_buff);
+
+		adapter->flags2 |= IXGBE_FLAG2_FW_ROLLBACK;
+	}
+
 	return false;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 6bf6ba7dcdcc..892fa6c1f879 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3525,6 +3525,8 @@ struct ixgbe_mac_operations {
 	int (*get_thermal_sensor_data)(struct ixgbe_hw *);
 	int (*init_thermal_sensor_thresh)(struct ixgbe_hw *hw);
 	bool (*fw_recovery_mode)(struct ixgbe_hw *hw);
+	bool (*fw_rollback_mode)(struct ixgbe_hw *hw);
+	int (*get_nvm_ver)(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm);
 	void (*disable_rx)(struct ixgbe_hw *hw);
 	void (*enable_rx)(struct ixgbe_hw *hw);
 	void (*set_source_address_pruning)(struct ixgbe_hw *, bool,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 1df5ac2e1fc5..c5cf153a19e9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -90,6 +90,7 @@
 
 #define IXGBE_GL_MNG_FWSM		0x000B6134 /* Reset Source: POR */
 #define IXGBE_GL_MNG_FWSM_RECOVERY_M	BIT(1)
+#define IXGBE_GL_MNG_FWSM_ROLLBACK_M    BIT(2)
 
 /* Flash Access Register */
 #define IXGBE_GLNVM_FLA			0x000B6108 /* Reset Source: POR */
-- 
2.31.1



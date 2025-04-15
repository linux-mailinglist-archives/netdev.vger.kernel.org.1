Return-Path: <netdev+bounces-183025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB49A8AB19
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC18172FA5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658427B4EA;
	Tue, 15 Apr 2025 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXf7gje/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC727A120;
	Tue, 15 Apr 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755200; cv=none; b=fnRh0A1QLXWVJM6PAI9nVLmfeP0xLOyh7IRmkT+Rf+PVCBfwOCoitgUiUx1LjBI/1caxdNoFOy6sHvWif3DreqLYHzp3CoTouKUAarpEr7YXuXtiNmFwWrfI3qZKKABESo4zRhtelUXwFwOvhbcUDWa0immLXi6iQglKakpQ2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755200; c=relaxed/simple;
	bh=d8UEXAy6WGaCYRQLJLGha+8gHBWRV8uW9ilzjreCsuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTmqR/Pr6cRsg8g/cPiVH++L5P2BGwwQcWxp4i+7GWlCSjZPYrEcNN7xbvUUE522JWe02yVP0qVI+jeU9BHPbuR0YtuizTjeIF5mp4aWFXEso7bl/A84YYp3v8cAbxNIMD+AkgN1JkKgPylhBDM2al/AKAFuVmBf94DxfhapCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXf7gje/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744755199; x=1776291199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d8UEXAy6WGaCYRQLJLGha+8gHBWRV8uW9ilzjreCsuM=;
  b=UXf7gje/TfgTEMEUarYSr+0ysnWjp4vGhIemrYdi0xe+ss2ILKk+cTNJ
   Q5GH4Q3mot2n9kckAfGooyuIgWupsy3n49A/x8yMujjwOpQrhvNH1mjep
   cdvExkNlKCkal/ztEaYMYaHwD9V1AblSjneKZ0G/UF84chVKmDQGjDdvy
   YgoHvfklTDfkLt1pppA1uT9eUO3jweUifacGEUflSbtB2yopI9F8AcR4J
   Gxm5p1qy4xK4ztkZVkpx9NBTaTYuLal0FkVw0fI37F+a5+dJeZSaCXcmd
   7/Wk+t+V/phSvgwQ5+INFMuFUlGwXsRtKQjygwzTDj+IBEt0Lv+CD6a+9
   Q==;
X-CSE-ConnectionGUID: 611gRX0CRcmeHauUDDHkSw==
X-CSE-MsgGUID: JyffsK46Qc+EvVbb7+QA8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46206704"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46206704"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:13:09 -0700
X-CSE-ConnectionGUID: 8wouwx4gTiWnVRYvhvnDQQ==
X-CSE-MsgGUID: nezf0DZUTSKukTdmE8g6ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="131218566"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 Apr 2025 15:13:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next v2 13/15] ixgbe: add FW API version check
Date: Tue, 15 Apr 2025 15:12:56 -0700
Message-ID: <20250415221301.1633933-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
References: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Add E610 specific function checking whether the FW API version
is compatible with the driver expectations.

The major API version should be less than or equal to the expected
API version. If not the driver won't be fully operational.

Check the minor version, and if it is more than two versions lesser
or greater than the expected version, print a message indicating
that the NVM or driver should be updated respectively.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 34 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  4 +++
 6 files changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index d0197991763c..3e79e446a944 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -471,6 +471,8 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
 
 	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
 
+	adapter->flags2 &= ~IXGBE_FLAG2_API_MISMATCH;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 83d4d7368cda..2246997bc9fb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -671,6 +671,7 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_PHY_FW_LOAD_FAILED		BIT(20)
 #define IXGBE_FLAG2_NO_MEDIA			BIT(21)
 #define IXGBE_FLAG2_MOD_POWER_UNSUPPORTED	BIT(22)
+#define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 
 	/* Tx fast path data */
 	int num_tx_queues;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 9dd788aea0c2..5d42da11547e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3873,6 +3873,7 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.led_off			= ixgbe_led_off_generic,
 	.init_led_link_act		= ixgbe_init_led_link_act_generic,
 	.reset_hw			= ixgbe_reset_hw_e610,
+	.get_fw_ver                     = ixgbe_aci_get_fw_ver,
 	.get_media_type			= ixgbe_get_media_type_e610,
 	.setup_link			= ixgbe_setup_link_e610,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2cc0af0dfe7c..84ee481a0ce1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8365,6 +8365,34 @@ static void ixgbe_reset_subtask(struct ixgbe_adapter *adapter)
 	rtnl_unlock();
 }
 
+static int ixgbe_check_fw_api_mismatch(struct ixgbe_adapter *adapter)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return 0;
+
+	if (hw->mac.ops.get_fw_ver && hw->mac.ops.get_fw_ver(hw))
+		return 0;
+
+	if (hw->api_maj_ver > IXGBE_FW_API_VER_MAJOR) {
+		e_dev_err("The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
+
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+		return -EOPNOTSUPP;
+	} else if (hw->api_maj_ver == IXGBE_FW_API_VER_MAJOR &&
+		   hw->api_min_ver > IXGBE_FW_API_VER_MINOR + IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	} else if (hw->api_maj_ver < IXGBE_FW_API_VER_MAJOR ||
+		   hw->api_min_ver < IXGBE_FW_API_VER_MINOR - IXGBE_FW_API_VER_DIFF_ALLOWED) {
+		e_dev_info("The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
+		adapter->flags2 |= IXGBE_FLAG2_API_MISMATCH;
+	}
+
+	return 0;
+}
+
 /**
  * ixgbe_check_fw_error - Check firmware for errors
  * @adapter: the adapter private structure
@@ -8375,6 +8403,7 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	u32 fwsm;
+	int err;
 
 	/* read fwsm.ext_err_ind register and log errors */
 	fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
@@ -8389,6 +8418,11 @@ static bool ixgbe_check_fw_error(struct ixgbe_adapter *adapter)
 		e_dev_err("Firmware recovery mode detected. Limiting functionality. Refer to the Intel(R) Ethernet Adapters and Devices User Guide for details on firmware recovery mode.\n");
 		return true;
 	}
+	if (!(adapter->flags2 & IXGBE_FLAG2_API_MISMATCH)) {
+		err = ixgbe_check_fw_api_mismatch(adapter);
+		if (err)
+			return true;
+	}
 
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 5f814f023573..6bf6ba7dcdcc 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3456,6 +3456,7 @@ struct ixgbe_mac_operations {
 	int (*start_hw)(struct ixgbe_hw *);
 	int (*clear_hw_cntrs)(struct ixgbe_hw *);
 	enum ixgbe_media_type (*get_media_type)(struct ixgbe_hw *);
+	int (*get_fw_ver)(struct ixgbe_hw *hw);
 	int (*get_mac_addr)(struct ixgbe_hw *, u8 *);
 	int (*get_san_mac_addr)(struct ixgbe_hw *, u8 *);
 	int (*get_device_caps)(struct ixgbe_hw *, u16 *);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index c36eaff3a083..2e105419eef8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -112,6 +112,10 @@
 #define IXGBE_PF_HICR_SV			BIT(2)
 #define IXGBE_PF_HICR_EV			BIT(3)
 
+#define IXGBE_FW_API_VER_MAJOR		0x01
+#define IXGBE_FW_API_VER_MINOR		0x07
+#define IXGBE_FW_API_VER_DIFF_ALLOWED	0x02
+
 #define IXGBE_ACI_DESC_SIZE		32
 #define IXGBE_ACI_DESC_SIZE_IN_DWORDS	(IXGBE_ACI_DESC_SIZE / BYTES_PER_DWORD)
 
-- 
2.47.1



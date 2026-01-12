Return-Path: <netdev+bounces-249051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 764ECD13137
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93F7F300B341
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F0D26A0B9;
	Mon, 12 Jan 2026 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/NDKYAa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421732701CB
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227530; cv=none; b=m9DVywHVU1hFBTPjd0J2D9xjhSnOhf7cyb0HzVLYVAYxg3OPiitsxsSO843A41lum07bvvH4p2me+EmmBvommDeLIL5+1o4FbXlEQvfXVmW4bUc/gYe7vLH416hCwnJ7F3GApTtGDyHR0vEB7eiTluAulxG1ePjnDDwSMkfyqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227530; c=relaxed/simple;
	bh=YdURuEjmkEvSFcp1+L1+0KyYASXqK9qsGaH69y/PfR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ubFhhrMgLXUUbCtBmGyrLejXICwpREKqAGRwNDphIktTDPb0iKWY/n1ULv6mFY7TgKJ+xk7lU7vliGLxPxMvjT0APmB6SWS7eeNLkmHYXhvwp40/AUcKGeBMa+LyaFzLwMLC8xzIw/1VCMEjuuObC4aWAVimDR2D0AOkHCL0/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/NDKYAa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227528; x=1799763528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YdURuEjmkEvSFcp1+L1+0KyYASXqK9qsGaH69y/PfR8=;
  b=B/NDKYAaYZ5OPn9sA3gocLT5gFWH5qy2rF0RZNxaasi4xBigKGXsFJGQ
   GQegTg4eQbgA3ss0wEOpgQlbW3w79kxzAuV0AcXPaF9bwn1DU96DR5NwP
   Owa1I2f+3BEa8cXYE4Hg99hCc7oKHyCfP4GkVfNnpKcKJ/PAtE86YRqsg
   zDgu8zhry3WHWwuCgtLbwjOjDFke6TrF+Fe7ZysWXR8vHbfxTPkVL4Ek+
   UaP7KUDP1KE/ot2nVtwKS8gwm19wLRQ0RDjxclPom/UIfdj/pY/QtQeWN
   qd5cd4eB7vrmezwqhqmh0Kx9E8xak3ZT4AxTwkz43bX8e7ALlV5sE1rFz
   Q==;
X-CSE-ConnectionGUID: FPH8SCJSQWCnxkPSso4vEA==
X-CSE-MsgGUID: uLHW3XQLQ6+VFlt5s/piLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352297"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352297"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:48 -0800
X-CSE-ConnectionGUID: edYdEAgZTiiUEzrd8CGXmA==
X-CSE-MsgGUID: AaVhx20GR1yBKM8z1Z9gWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355654"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:47 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 7/7] ixgbe: E610: add EEE support
Date: Mon, 12 Jan 2026 15:01:08 +0100
Message-Id: <20260112140108.1173835-8-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add E610 specific implementation of .get_eee() and .set_eee() ethtool
callbacks.

Introduce ixgbe_setup_eee_e610() which is used to set EEE config
on E610 device via ixgbe_aci_set_phy_cfg() (0x0601 ACI command).
Assign it to dedicated mac operation.

E610 devices support EEE feature specifically for 2.5, 5 and 10G link
speeds. When user try to set EEE for unsupported speeds log it.
This limitation also affects any runtime link configuration changes so when
link speed changes and EEE is enabled, check whether the feature can remain
enabled.

Setting timer and setting EEE advertised speeds are not yet supported.

EEE shall be enabled by default for E610 devices.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  44 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 154 +++++++++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  36 ++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 6 files changed, 235 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 9f52da4ec711..8104f953aa0c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -984,6 +984,8 @@ int ixgbe_init_interrupt_scheme(struct ixgbe_adapter *adapter);
 bool ixgbe_wol_supported(struct ixgbe_adapter *adapter, u16 device_id,
 			 u16 subdevice_id);
 void ixgbe_set_fw_version_e610(struct ixgbe_adapter *adapter);
+bool ixgbe_is_eee_link_speed_supported_e610(struct ixgbe_adapter *adapter,
+					    bool print_msg);
 void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter);
 #ifdef CONFIG_PCI_IOV
 void ixgbe_full_sync_mac_table(struct ixgbe_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 6818504a25f6..6a6aa2b8f4a7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -2013,6 +2013,49 @@ int ixgbe_identify_phy_e610(struct ixgbe_hw *hw)
 	return 0;
 }
 
+/**
+ * ixgbe_setup_eee_e610 - Enable/disable EEE support
+ * @hw: pointer to the HW structure
+ * @enable_eee: boolean flag to enable EEE
+ *
+ * Enable/disable EEE based on @enable_eee.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee)
+{
+	struct ixgbe_aci_cmd_get_phy_caps_data phy_caps = {};
+	struct ixgbe_aci_cmd_set_phy_cfg_data phy_cfg = {};
+	u16 eee_cap = 0;
+	int err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false,
+		IXGBE_ACI_REPORT_ACTIVE_CFG, &phy_caps);
+	if (err)
+		return err;
+
+	ixgbe_copy_phy_caps_to_cfg(&phy_caps, &phy_cfg);
+	phy_cfg.caps |= (IXGBE_ACI_PHY_ENA_LINK |
+			IXGBE_ACI_PHY_ENA_AUTO_LINK_UPDT);
+
+	if (enable_eee) {
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_100_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_100BASE_TX;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_1GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_1000BASE_T;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_2_5GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_5GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_5GBASE_T;
+		if (hw->phy.eee_speeds_advertised & IXGBE_LINK_SPEED_10GB_FULL)
+			eee_cap |= IXGBE_ACI_PHY_EEE_EN_10GBASE_T;
+	}
+
+	phy_cfg.eee_cap = cpu_to_le16(eee_cap);
+
+	return ixgbe_aci_set_phy_cfg(hw, &phy_cfg);
+}
+
 /**
  * ixgbe_identify_module_e610 - Identify SFP module type
  * @hw: pointer to hardware structure
@@ -3973,6 +4016,7 @@ static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.fw_rollback_mode		= ixgbe_fw_rollback_mode_e610,
 	.get_nvm_ver			= ixgbe_get_active_nvm_ver,
 	.get_link_capabilities		= ixgbe_get_link_capabilities_e610,
+	.setup_eee			= ixgbe_setup_eee_e610,
 	.get_bus_info			= ixgbe_get_bus_info_generic,
 	.acquire_swfw_sync		= ixgbe_acquire_swfw_sync_X540,
 	.release_swfw_sync		= ixgbe_release_swfw_sync_X540,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 782c489b0fa7..8a0b28becf02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -55,6 +55,7 @@ int ixgbe_init_phy_ops_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_phy_e610(struct ixgbe_hw *hw);
 int ixgbe_identify_module_e610(struct ixgbe_hw *hw);
 int ixgbe_setup_phy_link_e610(struct ixgbe_hw *hw);
+int ixgbe_setup_eee_e610(struct ixgbe_hw *hw, bool enable_eee);
 int ixgbe_set_phy_power_e610(struct ixgbe_hw *hw, bool on);
 int ixgbe_enter_lplu_e610(struct ixgbe_hw *hw);
 int ixgbe_init_eeprom_params_e610(struct ixgbe_hw *hw);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 24781bbbcf46..57b994a85949 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -12,6 +12,7 @@
 #include <linux/ethtool.h>
 #include <linux/vmalloc.h>
 #include <linux/highmem.h>
+#include <linux/string_choices.h>
 #include <linux/uaccess.h>
 
 #include "ixgbe.h"
@@ -3534,7 +3535,7 @@ static const struct {
 	{ IXGBE_LINK_SPEED_10_FULL, ETHTOOL_LINK_MODE_10baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_100_FULL, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_1GB_FULL, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
-	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseX_Full_BIT },
+	{ IXGBE_LINK_SPEED_2_5GB_FULL, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_5GB_FULL, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
 	{ IXGBE_LINK_SPEED_10GB_FULL, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
 };
@@ -3551,6 +3552,17 @@ static const struct {
 	{ FW_PHY_ACT_UD_2_10G_KR_EEE, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
 };
 
+static const struct {
+	u16 eee_cap_bit;
+	u32 link_mode;
+} ixgbe_eee_cap_map[] = {
+	{ IXGBE_ACI_PHY_EEE_EN_100BASE_TX, ETHTOOL_LINK_MODE_100baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_1000BASE_T, ETHTOOL_LINK_MODE_1000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_10GBASE_T, ETHTOOL_LINK_MODE_10000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_5GBASE_T, ETHTOOL_LINK_MODE_5000baseT_Full_BIT },
+	{ IXGBE_ACI_PHY_EEE_EN_2_5GBASE_T, ETHTOOL_LINK_MODE_2500baseT_Full_BIT },
+};
+
 static int ixgbe_validate_keee(struct net_device *netdev,
 			       struct ethtool_keee *keee_requested)
 {
@@ -3589,6 +3601,142 @@ static int ixgbe_validate_keee(struct net_device *netdev,
 	return 0;
 }
 
+/**
+ * ixgbe_is_eee_link_speed_supported_e610 - Check if EEE can be enabled
+ * @adapter: pointer to the adapter struct
+ * @print_msg: indicate whether to print info msg when EEE cannot be supported
+ *
+ * Check whether current link configuration is capable of enabling EEE feature.
+ *
+ * E610 specific function - for other adapters supporting EEE there might be
+ * no such limitation.
+ *
+ * Return: true if EEE can be enabled, false otherwise.
+ */
+bool ixgbe_is_eee_link_speed_supported_e610(struct ixgbe_adapter *adapter,
+					    bool print_msg)
+{
+	switch (adapter->link_speed) {
+	case IXGBE_LINK_SPEED_10GB_FULL:
+	case IXGBE_LINK_SPEED_2_5GB_FULL:
+	case IXGBE_LINK_SPEED_5GB_FULL:
+		return true;
+	case IXGBE_LINK_SPEED_10_FULL:
+	case IXGBE_LINK_SPEED_100_FULL:
+	case IXGBE_LINK_SPEED_1GB_FULL:
+		if (print_msg)
+			e_dev_info("Energy Efficient Ethernet (EEE) feature is not supported on link speeds equal to or below 1Gbps. EEE is supported on speeds above 1Gbps.\n");
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
+static int ixgbe_get_eee_e610(struct net_device *netdev,
+			      struct ethtool_keee *kedata)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_aci_cmd_get_phy_caps_data pcaps;
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_link_status link;
+	u16 eee_cap;
+	int err;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE)) {
+		e_dev_info("Energy Efficient Ethernet (EEE) feature is currently not supported on this device, please update the device NVM to the latest and try again");
+		return -EOPNOTSUPP;
+	}
+
+	linkmode_zero(kedata->lp_advertised);
+	linkmode_zero(kedata->supported);
+	linkmode_zero(kedata->advertised);
+
+	err = ixgbe_aci_get_link_info(hw, true, &link);
+	if (err)
+		return err;
+
+	err = ixgbe_aci_get_phy_caps(hw, false, IXGBE_ACI_REPORT_ACTIVE_CFG,
+				     &pcaps);
+	if (err)
+		return err;
+
+	kedata->eee_active =  link.eee_status & IXGBE_ACI_LINK_EEE_ACTIVE;
+	kedata->eee_enabled = link.eee_status & IXGBE_ACI_LINK_EEE_ENABLED;
+
+	/* for E610 devices EEE enablement implies TX LPI enablement */
+	kedata->tx_lpi_enabled = kedata->eee_enabled;
+
+	if (kedata->eee_enabled)
+		kedata->tx_lpi_timer = le16_to_cpu(pcaps.eee_entry_delay);
+
+	eee_cap = le16_to_cpu(pcaps.eee_cap);
+
+	for (int i = 0; i < ARRAY_SIZE(ixgbe_eee_cap_map); i++) {
+		if (eee_cap & ixgbe_eee_cap_map[i].eee_cap_bit)
+			linkmode_set_bit(ixgbe_eee_cap_map[i].link_mode,
+					 kedata->lp_advertised);
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(ixgbe_ls_map); i++) {
+		if (hw->phy.eee_speeds_supported &
+		    ixgbe_ls_map[i].mac_speed)
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
+					 kedata->supported);
+
+		if (hw->phy.eee_speeds_advertised &
+		    ixgbe_ls_map[i].mac_speed)
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
+					 kedata->advertised);
+	}
+
+	return 0;
+}
+
+static int ixgbe_set_eee_e610(struct net_device *netdev,
+			      struct ethtool_keee *kedata)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	if (!(adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE)) {
+		e_dev_info("Energy Efficient Ethernet (EEE) feature is currently not supported on this device, please update the device NVM to the latest and try again");
+		return -EOPNOTSUPP;
+	}
+
+	err = ixgbe_validate_keee(netdev, kedata);
+	if (err == -EALREADY)
+		return 0;
+	else if (err)
+		return err;
+
+	if (!(ixgbe_is_eee_link_speed_supported_e610(adapter, true)) &&
+	    kedata->eee_enabled)
+		return -EOPNOTSUPP;
+
+	hw->phy.eee_speeds_advertised = kedata->eee_enabled ?
+					hw->phy.eee_speeds_supported : 0;
+
+	err = hw->mac.ops.setup_eee(hw, kedata->eee_enabled);
+	if (err) {
+		e_dev_err("Setting EEE %s failed.\n",
+			  str_on_off(kedata->eee_enabled));
+		return err;
+	}
+
+	if (kedata->eee_enabled)
+		adapter->eee_state = IXGBE_EEE_ENABLED;
+	else
+		adapter->eee_state = IXGBE_EEE_DISABLED;
+
+	if (netif_running(netdev))
+		ixgbe_reinit_locked(adapter);
+	else
+		ixgbe_reset(adapter);
+
+	return 0;
+}
+
 static int
 ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 {
@@ -3813,8 +3961,8 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_rxfh		= ixgbe_set_rxfh,
 	.get_rxfh_fields	= ixgbe_get_rxfh_fields,
 	.set_rxfh_fields	= ixgbe_set_rxfh_fields,
-	.get_eee		= ixgbe_get_eee,
-	.set_eee		= ixgbe_set_eee,
+	.get_eee		= ixgbe_get_eee_e610,
+	.set_eee		= ixgbe_set_eee_e610,
 	.get_channels		= ixgbe_get_channels,
 	.set_channels		= ixgbe_set_channels,
 	.get_priv_flags		= ixgbe_get_priv_flags,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index b87d553413cd..ad7f0bdf5f54 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6749,6 +6749,7 @@ void ixgbe_down(struct ixgbe_adapter *adapter)
 
 /**
  * ixgbe_set_eee_capable - helper function to determine EEE support on X550
+ * and E610
  * @adapter: board private structure
  */
 static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
@@ -6765,6 +6766,20 @@ static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
 			break;
 		adapter->eee_state = IXGBE_EEE_ENABLED;
 		break;
+	case IXGBE_DEV_ID_E610_BACKPLANE:
+	case IXGBE_DEV_ID_E610_SFP:
+	case IXGBE_DEV_ID_E610_10G_T:
+	case IXGBE_DEV_ID_E610_2_5G_T:
+		if (hw->dev_caps.common_cap.eee_support &&
+		    hw->phy.eee_speeds_supported) {
+			adapter->flags2 |= IXGBE_FLAG2_EEE_CAPABLE;
+			/* For E610 adapters EEE should be enabled by default
+			 * if the feature is supported by FW.
+			 */
+			adapter->eee_state = IXGBE_EEE_ENABLED;
+			break;
+		}
+		fallthrough;
 	default:
 		adapter->flags2 &= ~IXGBE_FLAG2_EEE_CAPABLE;
 		adapter->eee_state = IXGBE_EEE_DISABLED;
@@ -8146,6 +8161,20 @@ static void ixgbe_watchdog_link_is_up(struct ixgbe_adapter *adapter)
 	       (flow_rx ? "RX" :
 	       (flow_tx ? "TX" : "None"))));
 
+	/* Check if link state change forces changing EEE state */
+	if (hw->mac.type == ixgbe_mac_e610) {
+		if (adapter->eee_state == IXGBE_EEE_ENABLED &&
+		    !(ixgbe_is_eee_link_speed_supported_e610(adapter, true))) {
+			hw->mac.ops.setup_eee(hw, false);
+			adapter->eee_state = IXGBE_EEE_FORCED_DOWN;
+		} else if (adapter->eee_state == IXGBE_EEE_FORCED_DOWN &&
+			   (ixgbe_is_eee_link_speed_supported_e610(adapter,
+			    false))) {
+			hw->mac.ops.setup_eee(hw, true);
+			adapter->eee_state = IXGBE_EEE_ENABLED;
+		}
+	}
+
 	netif_carrier_on(netdev);
 	ixgbe_check_vf_rate_limit(adapter);
 
@@ -12008,6 +12037,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_netdev;
 
+	if (hw->mac.type == ixgbe_mac_e610 &&
+	    (adapter->flags2 & IXGBE_FLAG2_EEE_CAPABLE)) {
+		bool eee_enable = adapter->eee_state == IXGBE_EEE_ENABLED;
+
+		hw->mac.ops.setup_eee(hw, eee_enable);
+	}
+
 	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 36577091cd9e..d17db3b3737f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3521,6 +3521,7 @@ struct ixgbe_mac_operations {
 	int (*get_link_capabilities)(struct ixgbe_hw *, ixgbe_link_speed *,
 				     bool *);
 	void (*set_rate_select_speed)(struct ixgbe_hw *, ixgbe_link_speed);
+	int (*setup_eee)(struct ixgbe_hw *hw, bool enable_eee);
 
 	/* Packet Buffer Manipulation */
 	void (*set_rxpba)(struct ixgbe_hw *, int, u32, int);
-- 
2.31.1



Return-Path: <netdev+bounces-212767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3531CB21C49
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B719D468158
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C022E2663;
	Tue, 12 Aug 2025 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsatzrY0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40D2E4245
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974046; cv=none; b=uvFPTadx79Q46OjfBB2CQdZNhxC1UEBiL+/ZrwooPZAaLWY1ozF2POtQ2NDtI3W8WCEf+3O8mB/nNkOAdhsNt9P65B8AJAyAouLTPwfclDOsKlPFeI4Fli4U2T7BiSOm0D8fxmX50QASqJ26fYjrl3J1ZvdVnTDbjsQ15T2l46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974046; c=relaxed/simple;
	bh=mJSKxGHSwDt5WJCN/LBGNsdRuzVdGiF82AnwzqfK8jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHmSzEmhAtPyDyFVdmNJtE+o7NFe4yU6sIHttuBuEL0osAjF/rTHjMoVF5piZCSnLvfifVEH3wJsA5zRg7n+oix5zBGccYuRcdFGFsAx6O3wDbVtkrytAFyF7SErIqVKSbj2yobt8WmP/BzTux14lKy1bUWd7Estjp8ZnhaDDjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsatzrY0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974044; x=1786510044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJSKxGHSwDt5WJCN/LBGNsdRuzVdGiF82AnwzqfK8jE=;
  b=TsatzrY0OypqtbJ1EU1GGohJM6ZeioeWf4y5GrDBdM0xRLISpE5aP2Lw
   vmtUiefpM1IVy4BlFSYsX0oUw2T6d2CnXNKippON+/ueNaMXbeNgwFp01
   6feQVbxlJP5D775zXGjhlsBUnFxigLJuuIWQQxSLzDsc1mwNHYc4VeNbr
   comBbcVzele2lUXPxC0+O7skZXWiW7cfaR5PB7vkVaqJ1EkKC7SYL7Dyh
   HUVlu0yXABAiEo0M+egssJbuD4ApQpEV7Tcmt7+LErBRes18bPcAyDnY+
   MondF3o9T1YsRboa+5TrZ9fBCu8Cg9Rq9tHOtxWG7RDbaoaz1xPkJxIFB
   g==;
X-CSE-ConnectionGUID: 2QaorQEHT0SeutXN6FwF4g==
X-CSE-MsgGUID: c+9qHakxSlSvToMGKn38gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612781"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612781"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:24 -0700
X-CSE-ConnectionGUID: 3IaZT2wAQuiPcZvURm0hYQ==
X-CSE-MsgGUID: y4vnV1xBTu6IpNi5dsowkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327928"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:22 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 15/15] ixgbe: fwlog support for e610
Date: Tue, 12 Aug 2025 06:23:36 +0200
Message-ID: <20250812042337.1356907-16-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device support firmware logging feature. Use libie code to
initialize it and allow reading the logs using debugfs.

The commands are the same as in ice driver. Look at the description in
commit 96a9a9341cda ("ice: configure FW logging") for more info.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 32 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 ++
 5 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 09f0af386af1..a563a94e2780 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -146,6 +146,7 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select LIBIE_FWLOG
 	select MDIO
 	select NET_DEVLINK
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index b202639b92c7..6dd530a64bd6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3900,6 +3900,38 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
 	return err;
 }
 
+static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
+			    u16 size)
+{
+	struct ixgbe_hw *hw = priv;
+
+	return ixgbe_aci_send_cmd(hw, desc, buf, size);
+}
+
+int ixgbe_fwlog_init(struct ixgbe_hw *hw)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	struct libie_fwlog_api api = {
+		.pdev = adapter->pdev,
+		.send_cmd = __fwlog_send_cmd,
+		.debugfs_root = adapter->ixgbe_dbg_adapter,
+		.priv = hw,
+	};
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return -EOPNOTSUPP;
+
+	return libie_fwlog_init(&hw->fwlog, &api);
+}
+
+void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
+{
+	if (hw->mac.type != ixgbe_mac_e610)
+		return;
+
+	libie_fwlog_deinit(&hw->fwlog);
+}
+
 static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.init_hw			= ixgbe_init_hw_generic,
 	.start_hw			= ixgbe_start_hw_e610,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 782c489b0fa7..11916b979d28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -96,5 +96,7 @@ int ixgbe_aci_update_nvm(struct ixgbe_hw *hw, u16 module_typeid,
 			 bool last_command, u8 command_flags);
 int ixgbe_nvm_write_activate(struct ixgbe_hw *hw, u16 cmd_flags,
 			     u8 *response_flags);
+int ixgbe_fwlog_init(struct ixgbe_hw *hw);
+void ixgbe_fwlog_deinit(struct ixgbe_hw *hw);
 
 #endif /* _IXGBE_E610_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 692b095b5c16..11d0f6f97b02 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -172,6 +172,7 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+MODULE_IMPORT_NS("LIBIE_FWLOG");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL v2");
 
@@ -3361,6 +3362,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 			e_crit(drv, "%s\n", ixgbe_overheat_msg);
 			ixgbe_down(adapter);
 			break;
+		case libie_aqc_opc_fw_logs_event:
+			libie_get_fwlog_data(&hw->fwlog, event.msg_buf,
+					     le16_to_cpu(event.desc.datalen));
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
@@ -12011,6 +12016,10 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
+
+	if (ixgbe_fwlog_init(hw))
+		e_dev_info("Firmware logging not supported\n");
+
 	return 0;
 
 err_netdev:
@@ -12068,6 +12077,7 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	devl_lock(adapter->devlink);
 	devl_unregister(adapter->devlink);
 	ixgbe_devlink_destroy_regions(adapter);
+	ixgbe_fwlog_deinit(&adapter->hw);
 	ixgbe_dbg_adapter_exit(adapter);
 
 	set_bit(__IXGBE_REMOVING, &adapter->state);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 36577091cd9e..b1bfeb21537a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/mdio.h>
 #include <linux/netdevice.h>
+#include <linux/net/intel/libie/fwlog.h>
 #include "ixgbe_type_e610.h"
 
 /* Device IDs */
@@ -3752,6 +3753,7 @@ struct ixgbe_hw {
 	struct ixgbe_flash_info		flash;
 	struct ixgbe_hw_dev_caps	dev_caps;
 	struct ixgbe_hw_func_caps	func_caps;
+	struct libie_fwlog		fwlog;
 };
 
 struct ixgbe_info {
-- 
2.49.0



Return-Path: <netdev+bounces-164753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50BA2EF5B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508EE1887505
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BD623313D;
	Mon, 10 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OgqUH3Fy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBC235370
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196635; cv=none; b=CVxs1Dr8TcK+sTGk9Wo7Ux/FtqhQ5Y6Erm2JGtPWxFZZO83ySpgZBQEA4N5fmc2DJSyWXtD1rrWyuphm8ZcbSV9GdFNVlhWtMFxujtghdFOYocwwgOBLGuqRMNRiQYUzPyGl1Gh/RP0j+H0D915TpSb490/5ZJ04YIBEOCgMJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196635; c=relaxed/simple;
	bh=6XLIpo798Y9yuxJAFWlea5RDPCUVTWT9JkgZd48NiqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlQj9HGJaNdXuuuU0yrFCpsTdsQ3gJgcfFnB6mKxTAcXnMn8a+JA0P6wdmxhDEyuuLn5uaa2dx/Kpas+OBtozva/K2KPY2UePKkXDcmOINqh7fjK6GGSAEtvk0uMB5ALxr/ftKPJ/cxjTsGjgHTj7gM0rWMHXuYfjx8b0YugeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OgqUH3Fy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196634; x=1770732634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6XLIpo798Y9yuxJAFWlea5RDPCUVTWT9JkgZd48NiqA=;
  b=OgqUH3Fy4WDC2Glc6bAiw2xT+yiVCNeUw44EazU9pO3CI9zCO4FjVMf+
   7O8sUhPtGENGApL1b3Nzh3rHvtXQ41MONnNJYqAeH+oYnhxGsMtTctbNp
   Pn11TyYn1gKQQHgf+jNTkM3LpzDSEYn97MXSnaQZdHUVpffXDJakibznf
   XtOVAcAC3vnib8U77qsmKf+T9Uvmu4icE/tVv+WEwqoZy131b9A7msJT+
   9L858rmjYqfxjJZeKLk/9xGKAW+xss4nDnFn397tTLmJf1kXnEVVkN/kS
   dbu2h/oL8bclPiT6hbjd+8zaLUzo7ammfXIWLlnfUQ2rnlKGFe+0yXf8Q
   w==;
X-CSE-ConnectionGUID: wDI5meqyQt+f797MP1myXQ==
X-CSE-MsgGUID: op864Sa/SEWfYRv6bJ4ifA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57190401"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57190401"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:10:33 -0800
X-CSE-ConnectionGUID: LS4Gv6nCR1KBGzmWGwGS2w==
X-CSE-MsgGUID: RjU4D7ziT/2Y2MB5JDdL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="111964214"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 10 Feb 2025 06:10:31 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v2 06/13] ixgbe: add .info_get extension specific for E610 devices
Date: Mon, 10 Feb 2025 14:56:32 +0100
Message-Id: <20250210135639.68674-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
References: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 devices give possibility to show more detailed info than the previous
boards.
Extend reporting NVM info with following pieces:
 fw.mgmt.api -> version number of the API
 fw.mgmt.build -> identifier of the source for the FW
 fw.psid.api -> version defining the format of the flash contents
 fw.netlist -> version of the netlist module
 fw.netlist.build -> first 4 bytes of the netlist hash

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 Documentation/networking/devlink/ixgbe.rst    |  26 ++++
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 133 +++++++++++++++++-
 2 files changed, 156 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
index b63645de37e8..a41073a62776 100644
--- a/Documentation/networking/devlink/ixgbe.rst
+++ b/Documentation/networking/devlink/ixgbe.rst
@@ -38,3 +38,29 @@ The ``ixgbe`` driver reports the following versions
       - 0x80000d0d
       - Unique identifier of the firmware image file that was loaded onto
         the device. Also referred to as the EETRACK identifier of the NVM.
+    * - ``fw.mgmt.api``
+      - running
+      - 1.5.1
+      - 3-digit version number (major.minor.patch) of the API exported over
+        the AdminQ by the management firmware. Used by the driver to
+        identify what commands are supported. Historical versions of the
+        kernel only displayed a 2-digit version number (major.minor).
+    * - ``fw.mgmt.build``
+      - running
+      - 0x305d955f
+      - Unique identifier of the source for the management firmware.
+    * - ``fw.psid.api``
+      - running
+      - 0.80
+      - Version defining the format of the flash contents.
+    * - ``fw.netlist``
+      - running
+      - 1.1.2000-6.7.0
+      - The version of the netlist module. This module defines the device's
+        Ethernet capabilities and default settings, and is used by the
+        management firmware as part of managing link and device
+        connectivity.
+    * - ``fw.netlist.build``
+      - running
+      - 0xee16ced7
+      - The first 4 bytes of the hash of the netlist module contents.
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 9afdbfa45e67..7bc57f3f8e8e 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -41,14 +41,22 @@ static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "%8phD", dsn);
 }
 
-static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
-			       struct ixgbe_info_ctx *ctx)
+static void ixgbe_info_orom_ver(struct ixgbe_adapter *adapter,
+				struct ixgbe_info_ctx *ctx)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_nvm_version nvm_ver;
 
 	ctx->buf[0] = '\0';
 
+	if (hw->mac.type == ixgbe_mac_e610) {
+		struct ixgbe_orom_info *orom = &adapter->hw.flash.orom;
+
+		snprintf(ctx->buf, sizeof(ctx->buf), "%d.%d.%d",
+			 orom->major, orom->build, orom->patch);
+		return;
+	}
+
 	ixgbe_get_oem_prod_version(hw, &nvm_ver);
 	if (nvm_ver.oem_valid) {
 		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x",
@@ -70,6 +78,12 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_nvm_version nvm_ver;
 
+	if (hw->mac.type == ixgbe_mac_e610) {
+		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x",
+			 hw->flash.nvm.eetrack);
+		return;
+	}
+
 	ixgbe_get_oem_prod_version(hw, &nvm_ver);
 
 	/* No ETRACK version for OEM */
@@ -82,6 +96,113 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm_ver.etk_id);
 }
 
+static void ixgbe_info_fw_api(struct ixgbe_adapter *adapter,
+			      struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
+		 hw->api_maj_ver, hw->api_min_ver, hw->api_patch);
+}
+
+static void ixgbe_info_fw_build(struct ixgbe_adapter *adapter,
+				struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", hw->fw_build);
+}
+
+static void ixgbe_info_fw_srev(struct ixgbe_adapter *adapter,
+			       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_nvm_info *nvm = &adapter->hw.flash.nvm;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u", nvm->srev);
+}
+
+static void ixgbe_info_orom_srev(struct ixgbe_adapter *adapter,
+				 struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_orom_info *orom = &adapter->hw.flash.orom;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "%u", orom->srev);
+}
+
+static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
+			       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_nvm_info *nvm = &adapter->hw.flash.nvm;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x", nvm->major, nvm->minor);
+}
+
+static void ixgbe_info_netlist_ver(struct ixgbe_adapter *adapter,
+				   struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_netlist_info *netlist = &adapter->hw.flash.netlist;
+
+	/* The netlist version fields are BCD formatted */
+	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x",
+		 netlist->major, netlist->minor,
+		 netlist->type >> 16, netlist->type & 0xFFFF,
+		 netlist->rev, netlist->cust_ver);
+}
+
+static void ixgbe_info_netlist_build(struct ixgbe_adapter *adapter,
+				     struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_netlist_info *netlist = &adapter->hw.flash.netlist;
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
+}
+
+static int ixgbe_devlink_info_get_E610(struct ixgbe_adapter *adapter,
+				       struct devlink_info_req *req,
+				       struct ixgbe_info_ctx *ctx)
+{
+	int err;
+
+	ixgbe_info_fw_api(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+				     ctx->buf);
+
+	ixgbe_info_fw_build(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.mgmt.build", ctx->buf);
+
+	ixgbe_info_fw_srev(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.mgmt.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_orom_srev(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.undi.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_nvm_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.psid.api", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.netlist", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_build(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     "fw.netlist.build", ctx->buf);
+
+	return err;
+}
+
 static int ixgbe_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -101,7 +222,7 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err)
 		goto free_ctx;
 
-	ixgbe_info_nvm_ver(adapter, ctx);
+	ixgbe_info_orom_ver(adapter, ctx);
 	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
 				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
 				     ctx->buf);
@@ -122,6 +243,12 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_FIXED,
 				     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
 				     ctx->buf);
+
+	if (err || hw->mac.type != ixgbe_mac_e610)
+		goto free_ctx;
+
+	err = ixgbe_devlink_info_get_E610(adapter, req, ctx);
+
 free_ctx:
 	kfree(ctx);
 	return err;
-- 
2.31.1



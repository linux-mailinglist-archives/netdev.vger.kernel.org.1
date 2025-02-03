Return-Path: <netdev+bounces-162162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0CA25E6E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0FB188B6A1
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7920A5F8;
	Mon,  3 Feb 2025 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhboz8HH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCF2045B9
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595847; cv=none; b=PrV1KvrxgHBc9PqKmpDmhiinl0f6sQJCH3TndhYAmBQiQPTECwMOVhFa+7OEXBMtX5+ajoJ+C9RdoJXSbsh8gN5oQEvShWPOFyw9YADMXzl5pOWF9jNG0Fvx5sCY6oJhzJTMVIY38QCMktnO2m0oD7pyZANLLkWplse1v0K7ZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595847; c=relaxed/simple;
	bh=XgAkdgarnf2ThTqN00svkHSe4ijmfdUDtP2rUaJZ+v8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dusPVoE+SHzJp7qVup1oSQpRsHys3VkO2t1tbCNouXUabm6g9n8SpiejPXh00oz9IRpSgzeVUNeMKR1zQ3Kk+cFWvySfWEi4FAMSRPBG5w+rl0uItsl8+unDWj3UyTmjiJ4df6bj1Yh12xQE33aLQu7fEHRmRfmlh0Gyp4PNPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhboz8HH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738595846; x=1770131846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XgAkdgarnf2ThTqN00svkHSe4ijmfdUDtP2rUaJZ+v8=;
  b=Uhboz8HH3cOrrRqpiGS0r7zFi0yJ2suBnP1jq9mCfjZ8WirzzaVkEbMC
   4NxgGUQVwCJ5hL/I3jXBqytnZ8ddrqOfH9412mc4ZM71TQK8fI2o4kN8L
   kVDchIrf0yWa4NWVYTcWkCcBnLRHoclDuG0NLj9GSf8XefLJEJ7isEX+w
   3KPOheocWJP7oYrs5PnHlQCb13XDr5RykFs9mqWYMXdAgcrpvX4QeWrn4
   plcQGjQfQ70CF4AwlgQV26KPl5KoSTUeAmDDryLf4GcSb+aU85Pr3Ijw4
   2Om+w74sMH0+zbP3RxAR5Vp3KvpMiTVomfGUdVxKtu+yjVIR4rPGyyaXF
   A==;
X-CSE-ConnectionGUID: g5tT8UVBRu2TLHZM7e7blg==
X-CSE-MsgGUID: 5WT5YgFgQh6PTRwu+RoRRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56519836"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="56519836"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:17:25 -0800
X-CSE-ConnectionGUID: q+H3eImSSoaLVQLu7V+f/g==
X-CSE-MsgGUID: Y9yJvthJQ6iBe1fFM4OU5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110886254"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 07:17:23 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v1 06/13] ixgbe: add .info_get extension specific for E610 devices
Date: Mon,  3 Feb 2025 16:03:21 +0100
Message-Id: <20250203150328.4095-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
References: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
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
index 5f521f036b0f..ce5bac4c657c 100644
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
index d99a209e2541..87bbd676dbc2 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -41,12 +41,20 @@ static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "%8phD", dsn);
 }
 
-static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
-			       struct ixgbe_info_ctx *ctx)
+static void ixgbe_info_orom_ver(struct ixgbe_adapter *adapter,
+				struct ixgbe_info_ctx *ctx)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_nvm_version nvm_ver;
 
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
@@ -68,6 +76,12 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
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
 	if (nvm_ver.oem_valid)
@@ -77,6 +91,113 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
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
@@ -96,7 +217,7 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err)
 		goto free_ctx;
 
-	ixgbe_info_nvm_ver(adapter, ctx);
+	ixgbe_info_orom_ver(adapter, ctx);
 	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
 				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
 				     ctx->buf);
@@ -117,6 +238,12 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
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



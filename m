Return-Path: <netdev+bounces-183021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD25A8AB13
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A483BA7D3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9260B2797B5;
	Tue, 15 Apr 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXBXa8ni"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E372275861;
	Tue, 15 Apr 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755196; cv=none; b=rpB+VtdyEaGK07w1XaWjQoIoCUCvy1ym9trcuFXsxgRQqIwcIhxtyxSpL3X6f5Cjrrovq9+pgb9aaJOXjuUJJQvNvPcff/bTauB/NI5le2bWX5kIkNyhW0zuGfvzN+NrkXI8x17mr5z2GlEAcmSwCMs+nGc4FIEc2e084iTWHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755196; c=relaxed/simple;
	bh=vnK8aLocactQytnoDWarirrB1gZhTjqSKF8oKJ9yIeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNKLcaK+pJLaf7rxMnFHI5Bbj1MDC1h65hTkIeMJ30VjTlmncC+aF0bGX7BLsOwa5bVFTKPSyfqpZGmlRyNaRyWYk3emZh+oSIKgPhKHN1vaZyegeWJnR+6lIqRIWnUA98OqHd45OmsJWZP4glG+LgRSAyyV71hIWZ+A8t4Wlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXBXa8ni; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744755195; x=1776291195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnK8aLocactQytnoDWarirrB1gZhTjqSKF8oKJ9yIeM=;
  b=BXBXa8niJLAc+CsYV/PD+Ak5XBFAWV2xfSqxYT/2zJgIKivu2O5kwAjm
   jX+7hr45JDgGunqL0oOHfS6rq2JROLfZ7ITIa6Y2xWP/xBbJOjE2dsLsc
   iGaNBvPRRELm34KLNWiLtF7EH7uAb0iV2jkQnwQ7CCjdhyVLc5arW2f+l
   t15nxxOaptwSU3jS2cApRkgLpkUr3QQ3CVbpqQ6JUIxj4aoeI53vAd9RW
   vONk2rQEbVUGy46lUesYiLlxOjXjOUKQakz24JnqYwwNUfbBFh2MtO2U2
   WfV4Dv7r4JIpOr2gIpGvqRvs1vLr8gRgnqlKxwYOWTopLVzDcRqN7fQ40
   w==;
X-CSE-ConnectionGUID: +IqBMDYESMCbE3OPLnc0jA==
X-CSE-MsgGUID: ZPVowKV8TaiALbz9cOQtMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46206661"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46206661"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:13:09 -0700
X-CSE-ConnectionGUID: x+HWB6EIRaSYqGQHI5qMlQ==
X-CSE-MsgGUID: kkQZ1TknS6SvI0SnWlc56A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="131218549"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 Apr 2025 15:13:08 -0700
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
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH net-next v2 08/15] ixgbe: add .info_get extension specific for E610 devices
Date: Tue, 15 Apr 2025 15:12:51 -0700
Message-ID: <20250415221301.1633933-9-anthony.l.nguyen@intel.com>
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

E610 devices give possibility to show more detailed info than the previous
boards.
Extend reporting NVM info with following pieces:
 fw.mgmt.api -> version number of the API
 fw.mgmt.build -> identifier of the source for the FW
 fw.mgmt.srev -> number defining FW's security revision
 fw.psid.api -> version defining the format of the flash contents
 fw.undi.srev -> number defining OROM's security revision
 fw.netlist -> version of the netlist module
 fw.netlist.build -> first 4 bytes of the netlist hash

Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../networking/devlink/devlink-info.rst       |   4 +
 Documentation/networking/devlink/ixgbe.rst    |  38 ++++++
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 128 +++++++++++++++++-
 3 files changed, 167 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 23073bc219d8..dd6adc4d0559 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -86,6 +86,10 @@ In case software/firmware components are loaded from the disk (e.g.
 ``/lib/firmware``) only the running version should be reported via
 the kernel API.
 
+Please note that any security versions reported via devlink are purely
+informational. Devlink does not use a secure channel to communicate with
+the device.
+
 Generic Versions
 ================
 
diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
index b63645de37e8..97692df50cfe 100644
--- a/Documentation/networking/devlink/ixgbe.rst
+++ b/Documentation/networking/devlink/ixgbe.rst
@@ -10,6 +10,10 @@ device driver.
 Info versions
 =============
 
+Any of the versions dealing with the security presented by ``devlink-info``
+is purely informational. Devlink does not use a secure channel to communicate
+with the device.
+
 The ``ixgbe`` driver reports the following versions
 
 .. list-table:: devlink info versions implemented
@@ -33,8 +37,42 @@ The ``ixgbe`` driver reports the following versions
         non-breaking changes and reset to 1 when the major version is
         incremented. The patch version is normally 0 but is incremented when
         a fix is delivered as a patch against an older base Option ROM.
+    * - ``fw.undi.srev``
+      - running
+      - 4
+      - Number indicating the security revision of the Option ROM.
     * - ``fw.bundle_id``
       - running
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
+    * - ``fw.mgmt.srev``
+      - running
+      - 3
+      - Number indicating the security revision of the firmware.
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
index 7bbd1733b8da..8c24564845e0 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -19,14 +19,22 @@ static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
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
+		snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
+			 orom->major, orom->build, orom->patch);
+		return;
+	}
+
 	ixgbe_get_oem_prod_version(hw, &nvm_ver);
 	if (nvm_ver.oem_valid) {
 		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x",
@@ -48,6 +56,12 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
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
@@ -60,6 +74,110 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
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
+static int ixgbe_devlink_info_get_e610(struct ixgbe_adapter *adapter,
+				       struct devlink_info_req *req,
+				       struct ixgbe_info_ctx *ctx)
+{
+	int err;
+
+	ixgbe_info_fw_api(adapter, ctx);
+	err = devlink_info_version_running_put(req,
+					       DEVLINK_INFO_VERSION_GENERIC_FW_MGMT_API,
+					       ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_fw_build(adapter, ctx);
+	err = devlink_info_version_running_put(req, "fw.mgmt.build", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_fw_srev(adapter, ctx);
+	err = devlink_info_version_running_put(req, "fw.mgmt.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_orom_srev(adapter, ctx);
+	err = devlink_info_version_running_put(req, "fw.undi.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_nvm_ver(adapter, ctx);
+	err = devlink_info_version_running_put(req, "fw.psid.api", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_ver(adapter, ctx);
+	err = devlink_info_version_running_put(req, "fw.netlist", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_build(adapter, ctx);
+	return devlink_info_version_running_put(req, "fw.netlist.build",
+						ctx->buf);
+}
+
 static int ixgbe_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -88,7 +206,7 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err)
 		goto free_ctx;
 
-	ixgbe_info_nvm_ver(adapter, ctx);
+	ixgbe_info_orom_ver(adapter, ctx);
 	err = devlink_info_version_running_put(req,
 					       DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
 					       ctx->buf);
@@ -99,6 +217,10 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	err = devlink_info_version_running_put(req,
 					       DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
 					       ctx->buf);
+	if (err || hw->mac.type != ixgbe_mac_e610)
+		goto free_ctx;
+
+	err = ixgbe_devlink_info_get_e610(adapter, req, ctx);
 free_ctx:
 	kfree(ctx);
 	return err;
-- 
2.47.1



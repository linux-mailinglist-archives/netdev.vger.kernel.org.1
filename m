Return-Path: <netdev+bounces-162164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829F5A25E71
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F6D188A192
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3020ADC4;
	Mon,  3 Feb 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfPtZojv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297B20ADCC
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595851; cv=none; b=JmDYK9WSn+AIumCwSIUs1Si7hGeajIPysj4luUQwGrzVVryfVWWhxrkt45IWdbTaEZBCfHtPLWNzui4e7stKrMvYCOS5ftpfYoz/9XCHoUC2KO/44WrO6oMuqdee052sOjXS1ZxG4RbnM7mz6LLTpYX7XGcLs/Byn3sGW8G0iUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595851; c=relaxed/simple;
	bh=OEHjg1sY8NtvvcMk75rb8hiG01bGfpDS3XooETMEbUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOMQ1VEfowkdI132pFrJQXhRsmLeyUy3HFFC1RUPjoz+4uJeuieXm+ui5wE6CS0DK0dwX1buAQbDLVQSWznfoxb4z0rtjybCazRm2M+TwpmpWPhp8wJKjrzXrcjc8MS4Ga13IqTLp2CI31k0M+YKs+JOdQ+I2Xxi+M5u3igwesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfPtZojv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738595850; x=1770131850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OEHjg1sY8NtvvcMk75rb8hiG01bGfpDS3XooETMEbUQ=;
  b=lfPtZojvY8HFwYyx3gj9lYMu8HNSH9Nq/0WOOmvoJ+m4K98YU0dqN/U+
   Q4Uoy9suZjGb8OtcSrVv/SscP4TfwcDVZhYQbFae3/LYKgsU93Bokq5tv
   A7dkxs1YWsQ4H1+SYA+YlSvMj7nkfJ1YGOcURPkDxPcpN/0DmOvz74fLQ
   uNbfBULs2IuE9CNoy/OJwN/gqRqJFZAyOtHdQ682GY97YHGRw1E8JGGfC
   rOHrM1G/NjWVqqDias+LUKBOKNrzxwoNl0GtRAfqcBktDxiUUaKrQyWsr
   P4VMS0yA5vUnKZXkv1nG1oGk+mPjwWuZ5ucGPOktaYVUG9OFgWsL2TtP4
   A==;
X-CSE-ConnectionGUID: o2j1vVcrST67vlNw/tpSfw==
X-CSE-MsgGUID: SatWiayOSdG9gHiZqir/Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56519857"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="56519857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:17:30 -0800
X-CSE-ConnectionGUID: yNkmsZ0NTa2OmkbkBX5LhA==
X-CSE-MsgGUID: XtDwLnq0S3Gu25cimAWx/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110886264"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 07:17:27 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v1 08/13] ixgbe: extend .info_get with stored versions
Date: Mon,  3 Feb 2025 16:03:23 +0100
Message-Id: <20250203150328.4095-9-jedrzej.jagielski@intel.com>
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

Add functions reading inactive versions from the inactive flash
banks.

Print stored NVM, OROM and netlist versions by devlink when there
is an ongoing update for E610 devices.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 180 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  59 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   3 +
 3 files changed, 242 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index d31def1fcd7d..3aae862abc73 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -6,11 +6,16 @@
 
 struct ixgbe_info_ctx {
 	char buf[128];
+	struct ixgbe_orom_info pending_orom;
+	struct ixgbe_nvm_info pending_nvm;
+	struct ixgbe_netlist_info pending_netlist;
+	struct ixgbe_hw_dev_caps dev_caps;
 };
 
 enum ixgbe_devlink_version_type {
 	IXGBE_DL_VERSION_FIXED,
 	IXGBE_DL_VERSION_RUNNING,
+	IXGBE_DL_VERSION_STORED,
 };
 
 static int ixgbe_devlink_info_put(struct devlink_info_req *req,
@@ -25,6 +30,8 @@ static int ixgbe_devlink_info_put(struct devlink_info_req *req,
 		return devlink_info_version_fixed_put(req, key, value);
 	case IXGBE_DL_VERSION_RUNNING:
 		return devlink_info_version_running_put(req, key, value);
+	case IXGBE_DL_VERSION_STORED:
+		return devlink_info_version_stored_put(req, key, value);
 	}
 
 	return 0;
@@ -91,6 +98,15 @@ static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm_ver.etk_id);
 }
 
+static void ixgbe_info_pending_eetrack(struct ixgbe_adapter *adapter,
+				       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_nvm_info *nvm = &ctx->pending_nvm;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm)
+		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm->eetrack);
+}
+
 static void ixgbe_info_fw_api(struct ixgbe_adapter *adapter,
 			      struct ixgbe_info_ctx *ctx)
 {
@@ -116,6 +132,25 @@ static void ixgbe_info_fw_srev(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "%u", nvm->srev);
 }
 
+static void ixgbe_info_pending_fw_srev(struct ixgbe_adapter *adapter,
+				       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_nvm_info *nvm = &ctx->pending_nvm;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%u", nvm->srev);
+}
+
+static void ixgbe_info_pending_orom_ver(struct ixgbe_adapter *adapter,
+					struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_orom_info *orom = &ctx->pending_orom;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_orom)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
+			 orom->major, orom->build, orom->patch);
+}
+
 static void ixgbe_info_orom_srev(struct ixgbe_adapter *adapter,
 				 struct ixgbe_info_ctx *ctx)
 {
@@ -124,6 +159,15 @@ static void ixgbe_info_orom_srev(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "%u", orom->srev);
 }
 
+static void ixgbe_info_pending_orom_srev(struct ixgbe_adapter *adapter,
+					 struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_orom_info *orom = &ctx->pending_orom;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_orom)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%u", orom->srev);
+}
+
 static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
 			       struct ixgbe_info_ctx *ctx)
 {
@@ -132,6 +176,16 @@ static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x", nvm->major, nvm->minor);
 }
 
+static void ixgbe_info_pending_nvm_ver(struct ixgbe_adapter *adapter,
+				       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_nvm_info *nvm = &ctx->pending_nvm;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x",
+			 nvm->major, nvm->minor);
+}
+
 static void ixgbe_info_netlist_ver(struct ixgbe_adapter *adapter,
 				   struct ixgbe_info_ctx *ctx)
 {
@@ -144,6 +198,19 @@ static void ixgbe_info_netlist_ver(struct ixgbe_adapter *adapter,
 		 netlist->rev, netlist->cust_ver);
 }
 
+static void ixgbe_info_pending_netlist_ver(struct ixgbe_adapter *adapter,
+					   struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_netlist_info *netlist = &ctx->pending_netlist;
+
+	/* The netlist version fields are BCD formatted */
+	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x",
+			 netlist->major, netlist->minor,
+			 netlist->type >> 16, netlist->type & 0xFFFF,
+			 netlist->rev, netlist->cust_ver);
+}
+
 static void ixgbe_info_netlist_build(struct ixgbe_adapter *adapter,
 				     struct ixgbe_info_ctx *ctx)
 {
@@ -152,6 +219,50 @@ static void ixgbe_info_netlist_build(struct ixgbe_adapter *adapter,
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
 }
 
+static void ixgbe_info_pending_netlist_build(struct ixgbe_adapter *adapter,
+					     struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_netlist_info *netlist = &ctx->pending_netlist;
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist)
+		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
+}
+
+static int ixgbe_set_ctx_dev_caps(struct ixgbe_hw *hw,
+				  struct ixgbe_info_ctx *ctx,
+				  struct netlink_ext_ack *extack)
+{
+	int err = ixgbe_discover_dev_caps(hw, &ctx->dev_caps);
+
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to discover device capabilities");
+		return err;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_orom) {
+		err = ixgbe_get_inactive_orom_ver(hw, &ctx->pending_orom);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_orom =
+			false;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm) {
+		err = ixgbe_get_inactive_nvm_ver(hw, &ctx->pending_nvm);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_nvm = false;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist) {
+		err = ixgbe_get_inactive_netlist_ver(hw, &ctx->pending_netlist);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_netlist =
+				false;
+	}
+
+	return 0;
+}
+
 static int ixgbe_devlink_info_get_E610(struct ixgbe_adapter *adapter,
 				       struct devlink_info_req *req,
 				       struct ixgbe_info_ctx *ctx)
@@ -198,6 +309,67 @@ static int ixgbe_devlink_info_get_E610(struct ixgbe_adapter *adapter,
 	return err;
 }
 
+static int
+ixgbe_devlink_pending_info_get_E610(struct ixgbe_adapter *adapter,
+				    struct devlink_info_req *req,
+				    struct ixgbe_info_ctx *ctx)
+{
+	int err = 0;
+
+	if (!ctx->dev_caps.common_cap.nvm_update_pending_nvm)
+		goto no_nvm;
+
+	ixgbe_info_pending_fw_srev(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     "fw.mgmt.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_pending_eetrack(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
+				     ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_pending_nvm_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     "fw.psid.api", ctx->buf);
+	if (err)
+		return err;
+
+no_nvm:
+	if (!ctx->dev_caps.common_cap.nvm_update_pending_orom)
+		goto no_orom;
+
+	ixgbe_info_pending_orom_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
+				     ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_pending_orom_srev(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     "fw.undi.srev", ctx->buf);
+no_orom:
+	if (err || !ctx->dev_caps.common_cap.nvm_update_pending_netlist)
+		return err;
+
+	ixgbe_info_pending_netlist_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     "fw.netlist", ctx->buf);
+
+	if (err)
+		return err;
+
+	ixgbe_info_pending_netlist_build(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_STORED,
+				     "fw.netlist.build", ctx->buf);
+
+	return err;
+}
+
 static int ixgbe_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -239,7 +411,15 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err || hw->mac.type != ixgbe_mac_e610)
 		goto free_ctx;
 
+	err = ixgbe_set_ctx_dev_caps(hw, ctx, extack);
+	if (err)
+		goto free_ctx;
+
 	err = ixgbe_devlink_info_get_E610(adapter, req, ctx);
+	if (err)
+		goto free_ctx;
+
+	err = ixgbe_devlink_pending_info_get_E610(adapter, req, ctx);
 
 free_ctx:
 	kfree(ctx);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index da20071eb938..b08590d05a1a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -588,6 +588,15 @@ static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
 		break;
 	case IXGBE_ACI_CAPS_NVM_VER:
 		break;
+	case IXGBE_ACI_CAPS_PENDING_NVM_VER:
+		caps->nvm_update_pending_nvm = true;
+		break;
+	case IXGBE_ACI_CAPS_PENDING_OROM_VER:
+		caps->nvm_update_pending_orom = true;
+		break;
+	case IXGBE_ACI_CAPS_PENDING_NET_VER:
+		caps->nvm_update_pending_netlist = true;
+		break;
 	case IXGBE_ACI_CAPS_MAX_MTU:
 		caps->max_mtu = number;
 		break;
@@ -2929,6 +2938,23 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_get_inactive_orom_ver - Read Option ROM version from the inactive bank
+ * @hw: pointer to the HW structure
+ * @orom: storage for Option ROM version information
+ *
+ * Read the Option ROM version and security revision data for the inactive
+ * section of flash. Used to access version data for a pending update that has
+ * not yet been activated.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_orom_ver(struct ixgbe_hw *hw,
+				struct ixgbe_orom_info *orom)
+{
+	return ixgbe_get_orom_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, orom);
+}
+
 /**
  * ixgbe_get_nvm_ver_info - Read NVM version information
  * @hw: pointer to the HW struct
@@ -2972,6 +2998,22 @@ static int ixgbe_get_nvm_ver_info(struct ixgbe_hw *hw,
 	return 0;
 }
 
+/**
+ * ixgbe_get_inactive_nvm_ver - Read Option ROM version from the inactive bank
+ * @hw: pointer to the HW structure
+ * @nvm: storage for Option ROM version information
+ *
+ * Read the NVM EETRACK ID, Map version, and security revision of the
+ * inactive NVM bank. Used to access version data for a pending update that
+ * has not yet been activated.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
+{
+	return ixgbe_get_nvm_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, nvm);
+}
+
 /**
  * ixgbe_get_netlist_info - Read the netlist version information
  * @hw: pointer to the HW struct
@@ -3052,6 +3094,23 @@ static int ixgbe_get_netlist_info(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_get_inactive_netlist_ver - Read netlist version from the inactive bank
+ * @hw: pointer to the HW struct
+ * @netlist: pointer to netlist version info structure
+ *
+ * Read the netlist version data from the inactive netlist bank. Used to
+ * extract version data of a pending flash update in order to display the
+ * version data.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_netlist_ver(struct ixgbe_hw *hw,
+				   struct ixgbe_netlist_info *netlist)
+{
+	return ixgbe_get_netlist_info(hw, IXGBE_INACTIVE_FLASH_BANK, netlist);
+}
+
 /**
  * ixgbe_get_flash_data - get flash data
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2c971a34200b..07c888d554d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -67,6 +67,9 @@ int ixgbe_aci_read_nvm(struct ixgbe_hw *hw, u16 module_typeid, u32 offset,
 		       u16 length, void *data, bool last_command,
 		       bool read_shadow_ram);
 int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
+int ixgbe_get_inactive_orom_ver(struct ixgbe_hw *hw, struct ixgbe_orom_info *orom);
+int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm);
+int ixgbe_get_inactive_netlist_ver(struct ixgbe_hw *hw, struct ixgbe_netlist_info *netlist);
 int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
 int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
 			u8 *data, bool read_shadow_ram);
-- 
2.31.1



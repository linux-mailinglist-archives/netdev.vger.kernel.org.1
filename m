Return-Path: <netdev+bounces-162158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEC7A25E81
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8463160F59
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C72209F55;
	Mon,  3 Feb 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5bpDJlW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AE5209F4C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595838; cv=none; b=acBEtgPCTEXN8p5FW5m6gS2LYMMjZ/Y4YJamqLFAAe8JPr+C1MX8t9l+Td3bOQ5E5sd+MxS8skLCfXGyALGJ8aC+ST0Y/O3FLrmZYIh56mH1VVkCQGrHNhbskMYN/IBVbrLzt1OjMwSVFZ24U+EqN1f0mtkHMAKki8SO+FBygYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595838; c=relaxed/simple;
	bh=PjEYdVntV9NCqg/kqcEknuh+C/UeX/7NBgUPytEL7TU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C/xpbUcD0LIOK4mK2/OcbJmRBZXJun+kFWHLUH6U5nuxmSDCsuDGj6TSpAsNtmFlp3EbmPUFyksbcy6ylH7QOwMhDUMM5SuxeRP8M1i4ipOyE6ksdd9ixErEhZKZCZkEIB/2Jg5/39SqweEaQcxbpScDFIo+axNO1Zma8C/KdLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5bpDJlW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738595837; x=1770131837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjEYdVntV9NCqg/kqcEknuh+C/UeX/7NBgUPytEL7TU=;
  b=C5bpDJlWtBrMOjdNP2vt4JJeZwYLnGnqw+mhcHTyEVsGF1nRVQGUATTg
   +770IokAJkyXIw5Fib2/BwF9znYIdirGvKtsJeUyLsS7+qOdM/mPm0zo1
   Pus3vaq9NSXRAuvScycY2VYL8SBJSgg5j+PGN9ekMPzErpeoRa4QS0InA
   iTpW0+lbIm1PbhGLCQ0YfWnN/GkbkHKGnMQUTn5t2dewXF3ZlK23pID6M
   GKSsmv8C1rTIyR5/4X/xHmQRwTVd0Pe1rgIgZFhsziNq0vv4DLqLi9OsF
   GJrscKV5IVRQavTstlLLFIEjo4TTupfhOXfPWN9auWeX5+fLgKFYaev09
   A==;
X-CSE-ConnectionGUID: y9cy8O9RSoyKaSPRRXc97Q==
X-CSE-MsgGUID: vCLYaI+ARASutZbNSToXWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56519794"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="56519794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:17:17 -0800
X-CSE-ConnectionGUID: N/XQyaqwSTWGYC7fuHrtZw==
X-CSE-MsgGUID: Z683wOl7TfSGGt8BpZHMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110886221"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 07:17:15 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v1 02/13] ixgbe: add handler for devlink .info_get()
Date: Mon,  3 Feb 2025 16:03:17 +0100
Message-Id: <20250203150328.4095-3-jedrzej.jagielski@intel.com>
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

Provide devlink .info_get() callback implementation to allow the
driver to report detailed version information. The following info
is reported:

 "serial_number" -> The PCI DSN of the adapter
 "fw.bundle_id" -> Unique identifier for the combined flash image
 "fw.undi" -> Version of the Option ROM containing the UEFI driver
 "board.id" -> The PBA ID string

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 Documentation/networking/devlink/ixgbe.rst    |  32 +++++
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 119 ++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
index ca920d421d42..5f521f036b0f 100644
--- a/Documentation/networking/devlink/ixgbe.rst
+++ b/Documentation/networking/devlink/ixgbe.rst
@@ -6,3 +6,35 @@ ixgbe devlink support
 
 This document describes the devlink features implemented by the ``ixgbe``
 device driver.
+
+Info versions
+=============
+
+The ``ixgbe`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``board.id``
+      - fixed
+      - H49289-000
+      - The Product Board Assembly (PBA) identifier of the board.
+    * - ``fw.undi``
+      - running
+      - 1.1937.0
+      - Version of the Option ROM containing the UEFI driver. The version is
+        reported in ``major.minor.patch`` format. The major version is
+        incremented whenever a major breaking change occurs, or when the
+        minor version would overflow. The minor version is incremented for
+        non-breaking changes and reset to 1 when the major version is
+        incremented. The patch version is normally 0 but is incremented when
+        a fix is delivered as a patch against an older base Option ROM.
+    * - ``fw.bundle_id``
+      - running
+      - 0x80000d0d
+      - Unique identifier of the firmware image file that was loaded onto
+        the device. Also referred to as the EETRACK identifier of the NVM.
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index 9e494cdbb4b1..d99a209e2541 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -4,7 +4,126 @@
 #include "ixgbe.h"
 #include "devlink.h"
 
+struct ixgbe_info_ctx {
+	char buf[128];
+};
+
+enum ixgbe_devlink_version_type {
+	IXGBE_DL_VERSION_FIXED,
+	IXGBE_DL_VERSION_RUNNING,
+};
+
+static int ixgbe_devlink_info_put(struct devlink_info_req *req,
+				  enum ixgbe_devlink_version_type type,
+				  const char *key, const char *value)
+{
+	if (!*value)
+		return 0;
+
+	switch (type) {
+	case IXGBE_DL_VERSION_FIXED:
+		return devlink_info_version_fixed_put(req, key, value);
+	case IXGBE_DL_VERSION_RUNNING:
+		return devlink_info_version_running_put(req, key, value);
+	}
+
+	return 0;
+}
+
+static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
+			       struct ixgbe_info_ctx *ctx)
+{
+	u8 dsn[8];
+
+	/* Copy the DSN into an array in Big Endian format */
+	put_unaligned_be64(pci_get_dsn(adapter->pdev), dsn);
+
+	snprintf(ctx->buf, sizeof(ctx->buf), "%8phD", dsn);
+}
+
+static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
+			       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_nvm_version nvm_ver;
+
+	ixgbe_get_oem_prod_version(hw, &nvm_ver);
+	if (nvm_ver.oem_valid) {
+		snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x",
+			 nvm_ver.oem_major, nvm_ver.oem_minor,
+			 nvm_ver.oem_release);
+
+		return;
+	}
+
+	ixgbe_get_orom_version(hw, &nvm_ver);
+	if (nvm_ver.or_valid)
+		snprintf(ctx->buf, sizeof(ctx->buf), "%d.%d.%d",
+			 nvm_ver.or_major, nvm_ver.or_build, nvm_ver.or_patch);
+}
+
+static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
+			       struct ixgbe_info_ctx *ctx)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_nvm_version nvm_ver;
+
+	ixgbe_get_oem_prod_version(hw, &nvm_ver);
+	/* No ETRACK version for OEM */
+	if (nvm_ver.oem_valid)
+		return;
+
+	ixgbe_get_etk_id(hw, &nvm_ver);
+	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", nvm_ver.etk_id);
+}
+
+static int ixgbe_devlink_info_get(struct devlink *devlink,
+				  struct devlink_info_req *req,
+				  struct netlink_ext_ack *extack)
+{
+	struct ixgbe_devlink_priv *devlink_private = devlink_priv(devlink);
+	struct ixgbe_adapter *adapter = devlink_private->adapter;
+	struct ixgbe_hw *hw = &adapter->hw;
+	struct ixgbe_info_ctx *ctx;
+	int err;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ixgbe_info_get_dsn(adapter, ctx);
+	err = devlink_info_serial_number_put(req, ctx->buf);
+	if (err)
+		goto free_ctx;
+
+	ixgbe_info_nvm_ver(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
+				     ctx->buf);
+	if (err)
+		goto free_ctx;
+
+	ixgbe_info_eetrack(adapter, ctx);
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_RUNNING,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
+				     ctx->buf);
+	if (err)
+		goto free_ctx;
+
+	err = ixgbe_read_pba_string_generic(hw, ctx->buf, sizeof(ctx->buf));
+	if (err)
+		goto free_ctx;
+
+	err = ixgbe_devlink_info_put(req, IXGBE_DL_VERSION_FIXED,
+				     DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
+				     ctx->buf);
+free_ctx:
+	kfree(ctx);
+	return err;
+}
+
 static const struct devlink_ops ixgbe_devlink_ops = {
+	.info_get = ixgbe_devlink_info_get,
 };
 
 /**
-- 
2.31.1



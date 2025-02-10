Return-Path: <netdev+bounces-164749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40402A2EF53
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7030D167B87
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752C823498A;
	Mon, 10 Feb 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHbGKoLh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B02327B9
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196624; cv=none; b=MmwhB9LXJ7czg25wmQsx8ijy/uySqq2kuFonHE5F5C9qiCwjyvflHNhdzH5iy+aFBadFqDY0NO3oW++l2dZ8ymfS1a/vhOvXU4cbxxJ/1/vBocK47yxyQtPYy1TsUoCrqY6vlYi9GFn845lVcVegMDZc2mU3kPxbHepjqeWEphg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196624; c=relaxed/simple;
	bh=XxnRsEBKP1xjOYKnq9uKyKhH7lsM8j0pnj95sXM2wug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZfNXPwvjeY1jyyJTyF9TlYkdMpZsVwhVOuGZ067HzrdmxUNaFoQkrU/ImALCRriy0lhq7i4/C7aZ768ZaHr0X4HqlSy30p72Z3LHya6GHDtPzHYexl9j8MAMyIj+duMJI9sNg5ElByAGd8dn6LrL8NKEfl9G5yns8LfiwdSS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHbGKoLh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196623; x=1770732623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxnRsEBKP1xjOYKnq9uKyKhH7lsM8j0pnj95sXM2wug=;
  b=FHbGKoLhaBsYMn3+T/H3Lqz9q/fGFSt73fEK3xzlzD3MNGOFxDfqH6D2
   S9ieEbiPGYqZXIRAc1X+2JiWNRDn6WXPYeiqgEi90Md9Fg0ZJWsl9RBYv
   VCdSrsYU8EqbsgFuL8FJE6Ud+dXbphOROUROz4xR/mXjApYT6r7F7oktc
   j9C/WINAyDogTpX4+aVUqNC3pII7664urB1GmFSThTk5CqE+uxBMx59vl
   oW5j1BathwDO0KDaicq6rBUwtTr316WlJ/aWfobXqDxx+1EOVv9ER6LHy
   cdwNMc7YkVtgDpSxIQz8C5JDrosKIuYgqxzGKdHXemRgfD+b8ICx42wVW
   g==;
X-CSE-ConnectionGUID: +pDFfgnxRfWmZvmJCgyBKw==
X-CSE-MsgGUID: C3ZFjYWNSgKXGjFAtTq5zQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57190351"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57190351"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:10:23 -0800
X-CSE-ConnectionGUID: cCCIfRhAR7ad1lEo1tca2A==
X-CSE-MsgGUID: sc/jVYnpRxaL0vcyMpoEvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="111964186"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 10 Feb 2025 06:10:20 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v2 02/13] ixgbe: add handler for devlink .info_get()
Date: Mon, 10 Feb 2025 14:56:28 +0100
Message-Id: <20250210135639.68674-3-jedrzej.jagielski@intel.com>
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
v2: zero the ctx buff when chance it won't be filled out
---
 Documentation/networking/devlink/ixgbe.rst    |  32 +++++
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 124 ++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
index c04ac51c6d85..b63645de37e8 100644
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
index c052e95c9496..9afdbfa45e67 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -4,7 +4,131 @@
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
+	ctx->buf[0] = '\0';
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
+
+	/* No ETRACK version for OEM */
+	if (nvm_ver.oem_valid) {
+		ctx->buf[0] = '\0';
+		return;
+	}
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



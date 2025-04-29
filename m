Return-Path: <netdev+bounces-186903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC97AA3CEB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 01:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5BB97A27DB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844026B2C0;
	Tue, 29 Apr 2025 23:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6xBzYh2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E9255F2A;
	Tue, 29 Apr 2025 23:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970430; cv=none; b=ASp2UKKtr3drb9AjpfGmbZbfy6+J8ryuGJYG5QPfiqDtfx0X5FAQbPKGAXB3Hv2z0Gd5lDCEdc2fMR7pJ0t2lS+K7OqmNtKauAHnff91T4VIm+VndxI8SdTOq2Yz6e56n6BfwDIa4qP24WMDcT04h+hHZC+oGPVg0j3uhghqGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970430; c=relaxed/simple;
	bh=zrBetzUAMFBFqyi8pf4c9o7czLMKh6LL2X3Yr1ZekTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJc3V4zmHWKEykzcyvEDdhz1LYlWikF0KyElwawEDUjo7a6oEtGZCpFx1zq/Zkw2zLE4SbWmYXGmVn5l///GoWRWUWVOoHZrW19hiCg8FYRNi+utvRP0OT+EhdGqJWrM8ECYDsTa9390OgxVkaJSkx/7vDjzIDQjJ8ND2opVtS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6xBzYh2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745970427; x=1777506427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zrBetzUAMFBFqyi8pf4c9o7czLMKh6LL2X3Yr1ZekTc=;
  b=l6xBzYh2vnWuTVOvMLib+rkWH4AReIytfZ/i1UwS3DXrsGnCokR8jj+f
   cVTPHdEh/1se2rq7/EDG0EPXHHkiYSMRbNEzv2HjJg1pZ7fNjwwu75SFJ
   nWr3+iVpOsFmEVDXOk79hKcPo+Y4cZO1OlMdhAHufP9VmxzfH94U8aKph
   ML78EhlItvHaoIiiRudou71jZPsZifoj3p78TIZflDl/eRBI1LcyltPjK
   z4oFMpedjIy3ch+tdr073vRvUlfdS4JouoXXCyOqYYj7SXsX2w19ZnhIx
   HeKLYouwYlsuEXoBX9OrZeZQmVeWvEnkAy6kgADGJADHK+T5kjMkbUK16
   g==;
X-CSE-ConnectionGUID: gRapZ70BSoudGWaOiEhNsQ==
X-CSE-MsgGUID: npX5mGIaRcuaaBJyIbGtgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="58990134"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="58990134"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 16:47:04 -0700
X-CSE-ConnectionGUID: Os5qmAWaRFWXCHlKQyzgWA==
X-CSE-MsgGUID: 5XAwkUjEQa6A2V9ofSJblw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="137979649"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Apr 2025 16:47:03 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next 11/13] ixgbe: devlink: add devlink region support for E610
Date: Tue, 29 Apr 2025 16:46:46 -0700
Message-ID: <20250429234651.3982025-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
References: <20250429234651.3982025-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>

Provide support for the following devlink cmds:
 -DEVLINK_CMD_REGION_GET
 -DEVLINK_CMD_REGION_NEW
 -DEVLINK_CMD_REGION_DEL
 -DEVLINK_CMD_REGION_READ

ixgbe devlink region implementation, similarly to the ice one,
lets user to create snapshots of content of Non Volatile Memory,
content of Shadow RAM, and capabilities of the device.

For both NVM and SRAM regions provide .read() handler to let user
read their contents without the need to create full snapshots.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 Documentation/networking/devlink/ixgbe.rst    |  49 +++
 drivers/net/ethernet/intel/ixgbe/Makefile     |   3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   2 +
 .../net/ethernet/intel/ixgbe/devlink/region.c | 290 ++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   3 +
 6 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/region.c

diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
index 3fce291348fa..c27d1436c70e 100644
--- a/Documentation/networking/devlink/ixgbe.rst
+++ b/Documentation/networking/devlink/ixgbe.rst
@@ -120,3 +120,52 @@ EMP firmware image.
 
 The driver does not currently support reloading the driver via
 ``DEVLINK_RELOAD_ACTION_DRIVER_REINIT``.
+
+Regions
+=======
+
+The ``ixgbe`` driver implements the following regions for accessing internal
+device data.
+
+.. list-table:: regions implemented
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``nvm-flash``
+      - The contents of the entire flash chip, sometimes referred to as
+        the device's Non Volatile Memory.
+    * - ``shadow-ram``
+      - The contents of the Shadow RAM, which is loaded from the beginning
+        of the flash. Although the contents are primarily from the flash,
+        this area also contains data generated during device boot which is
+        not stored in flash.
+    * - ``device-caps``
+      - The contents of the device firmware's capabilities buffer. Useful to
+        determine the current state and configuration of the device.
+
+Both the ``nvm-flash`` and ``shadow-ram`` regions can be accessed without a
+snapshot. The ``device-caps`` region requires a snapshot as the contents are
+sent by firmware and can't be split into separate reads.
+
+Users can request an immediate capture of a snapshot for all three regions
+via the ``DEVLINK_CMD_REGION_NEW`` command.
+
+.. code:: shell
+
+    $ devlink region show
+    pci/0000:01:00.0/nvm-flash: size 10485760 snapshot [] max 1
+    pci/0000:01:00.0/device-caps: size 4096 snapshot [] max 10
+
+    $ devlink region new pci/0000:01:00.0/nvm-flash snapshot 1
+
+    $ devlink region dump pci/0000:01:00.0/nvm-flash snapshot 1
+    0000000000000000 0014 95dc 0014 9514 0035 1670 0034 db30
+    0000000000000010 0000 0000 ffff ff04 0029 8c00 0028 8cc8
+    0000000000000020 0016 0bb8 0016 1720 0000 0000 c00f 3ffc
+    0000000000000030 bada cce5 bada cce5 bada cce5 bada cce5
+
+    $ devlink region read pci/0000:01:00.0/nvm-flash snapshot 1 address 0 length 16
+    0000000000000000 0014 95dc 0014 9514 0035 1670 0034 db30
+
+    $ devlink region delete pci/0000:01:00.0/device-caps snapshot 1
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index ce447540d146..2e7738f41c58 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_IXGBE) += ixgbe.o
 ixgbe-y := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
            ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
            ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
-           ixgbe_xsk.o ixgbe_e610.o devlink/devlink.o ixgbe_fw_update.o
+           ixgbe_xsk.o ixgbe_e610.o devlink/devlink.o ixgbe_fw_update.o \
+	   devlink/region.o
 
 ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
index 0b27653a3407..381558058048 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
@@ -6,5 +6,7 @@
 
 struct ixgbe_adapter *ixgbe_allocate_devlink(struct device *dev);
 int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter);
+void ixgbe_devlink_init_regions(struct ixgbe_adapter *adapter);
+void ixgbe_devlink_destroy_regions(struct ixgbe_adapter *adapter);
 
 #endif /* _IXGBE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/region.c b/drivers/net/ethernet/intel/ixgbe/devlink/region.c
new file mode 100644
index 000000000000..76f6571c3c34
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/region.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Intel Corporation. */
+
+#include "ixgbe.h"
+#include "devlink.h"
+
+#define IXGBE_DEVLINK_READ_BLK_SIZE (1024 * 1024)
+
+static const struct devlink_region_ops ixgbe_nvm_region_ops;
+static const struct devlink_region_ops ixgbe_sram_region_ops;
+
+static int ixgbe_devlink_parse_region(struct ixgbe_hw *hw,
+				      const struct devlink_region_ops *ops,
+				      bool *read_shadow_ram, u32 *nvm_size)
+{
+	if (ops == &ixgbe_nvm_region_ops) {
+		*read_shadow_ram = false;
+		*nvm_size = hw->flash.flash_size;
+	} else if (ops == &ixgbe_sram_region_ops) {
+		*read_shadow_ram = true;
+		*nvm_size = hw->flash.sr_words * 2u;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+/**
+ * ixgbe_devlink_nvm_snapshot - Capture a snapshot of the NVM content
+ * @devlink: the devlink instance
+ * @ops: the devlink region being snapshotted
+ * @extack: extended ACK response structure
+ * @data: on exit points to snapshot data buffer
+ *
+ * This function is called in response to the DEVLINK_CMD_REGION_NEW cmd.
+ *
+ * Capture a snapshot of the whole requested NVM region.
+ *
+ * No need to worry with freeing @data, devlink core takes care if it.
+ *
+ * Return: 0 on success, -EOPNOTSUPP for unsupported regions, -EBUSY when
+ * cannot lock NVM, -ENOMEM when cannot alloc mem and -EIO when error
+ * occurs during reading.
+ */
+static int ixgbe_devlink_nvm_snapshot(struct devlink *devlink,
+				      const struct devlink_region_ops *ops,
+				      struct netlink_ext_ack *extack, u8 **data)
+{
+	struct ixgbe_adapter *adapter = devlink_priv(devlink);
+	struct ixgbe_hw *hw = &adapter->hw;
+	bool read_shadow_ram;
+	u8 *nvm_data, *buf;
+	u32 nvm_size, left;
+	u8 num_blks;
+	int err;
+
+	err = ixgbe_devlink_parse_region(hw, ops, &read_shadow_ram, &nvm_size);
+	if (err)
+		return err;
+
+	nvm_data = kvzalloc(nvm_size, GFP_KERNEL);
+	if (!nvm_data)
+		return -ENOMEM;
+
+	num_blks = DIV_ROUND_UP(nvm_size, IXGBE_DEVLINK_READ_BLK_SIZE);
+	buf = nvm_data;
+	left = nvm_size;
+
+	for (int i = 0; i < num_blks; i++) {
+		u32 read_sz = min_t(u32, IXGBE_DEVLINK_READ_BLK_SIZE, left);
+
+		/* Need to acquire NVM lock during each loop run because the
+		 * total period of reading whole NVM is longer than the maximum
+		 * period the lock can be taken defined by the IXGBE_NVM_TIMEOUT.
+		 */
+		err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to acquire NVM semaphore");
+			kvfree(nvm_data);
+			return -EBUSY;
+		}
+
+		err = ixgbe_read_flat_nvm(hw, i * IXGBE_DEVLINK_READ_BLK_SIZE,
+					  &read_sz, buf, read_shadow_ram);
+		if (err) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to read RAM content");
+			ixgbe_release_nvm(hw);
+			kvfree(nvm_data);
+			return -EIO;
+		}
+
+		ixgbe_release_nvm(hw);
+
+		buf += read_sz;
+		left -= read_sz;
+	}
+
+	*data = nvm_data;
+	return 0;
+}
+
+/**
+ * ixgbe_devlink_devcaps_snapshot - Capture a snapshot of device capabilities
+ * @devlink: the devlink instance
+ * @ops: the devlink region being snapshotted
+ * @extack: extended ACK response structure
+ * @data: on exit points to snapshot data buffer
+ *
+ * This function is called in response to the DEVLINK_CMD_REGION_NEW for
+ * the device-caps devlink region.
+ *
+ * Capture a snapshot of the device capabilities reported by firmware.
+ *
+ * No need to worry with freeing @data, devlink core takes care if it.
+ *
+ * Return: 0 on success, -ENOMEM when cannot alloc mem, or return code of
+ * the reading operation.
+ */
+static int ixgbe_devlink_devcaps_snapshot(struct devlink *devlink,
+					  const struct devlink_region_ops *ops,
+					  struct netlink_ext_ack *extack,
+					  u8 **data)
+{
+	struct ixgbe_adapter *adapter = devlink_priv(devlink);
+	struct ixgbe_aci_cmd_list_caps_elem *caps;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int err;
+
+	caps = kvzalloc(IXGBE_ACI_MAX_BUFFER_SIZE, GFP_KERNEL);
+	if (!caps)
+		return -ENOMEM;
+
+	err = ixgbe_aci_list_caps(hw, caps, IXGBE_ACI_MAX_BUFFER_SIZE, NULL,
+				  ixgbe_aci_opc_list_dev_caps);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to read device capabilities");
+		kvfree(caps);
+		return err;
+	}
+
+	*data = (u8 *)caps;
+	return 0;
+}
+
+/**
+ * ixgbe_devlink_nvm_read - Read a portion of NVM flash content
+ * @devlink: the devlink instance
+ * @ops: the devlink region to snapshot
+ * @extack: extended ACK response structure
+ * @offset: the offset to start at
+ * @size: the amount to read
+ * @data: the data buffer to read into
+ *
+ * This function is called in response to DEVLINK_CMD_REGION_READ to directly
+ * read a section of the NVM contents.
+ *
+ * Read from either the nvm-flash region either shadow-ram region.
+ *
+ * Return: 0 on success, -EOPNOTSUPP for unsupported regions, -EBUSY when
+ * cannot lock NVM, -ERANGE when buffer limit exceeded and -EIO when error
+ * occurs during reading.
+ */
+static int ixgbe_devlink_nvm_read(struct devlink *devlink,
+				  const struct devlink_region_ops *ops,
+				  struct netlink_ext_ack *extack,
+				  u64 offset, u32 size, u8 *data)
+{
+	struct ixgbe_adapter *adapter = devlink_priv(devlink);
+	struct ixgbe_hw *hw = &adapter->hw;
+	bool read_shadow_ram;
+	u32 nvm_size;
+	int err;
+
+	err = ixgbe_devlink_parse_region(hw, ops, &read_shadow_ram, &nvm_size);
+	if (err)
+		return err;
+
+	if (offset + size > nvm_size) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot read beyond the region size");
+		return -ERANGE;
+	}
+
+	err = ixgbe_acquire_nvm(hw, IXGBE_RES_READ);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM semaphore");
+		return -EBUSY;
+	}
+
+	err = ixgbe_read_flat_nvm(hw, (u32)offset, &size, data, read_shadow_ram);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM contents");
+		ixgbe_release_nvm(hw);
+		return -EIO;
+	}
+
+	ixgbe_release_nvm(hw);
+	return 0;
+}
+
+static const struct devlink_region_ops ixgbe_nvm_region_ops = {
+	.name = "nvm-flash",
+	.destructor = kvfree,
+	.snapshot = ixgbe_devlink_nvm_snapshot,
+	.read = ixgbe_devlink_nvm_read,
+};
+
+static const struct devlink_region_ops ixgbe_sram_region_ops = {
+	.name = "shadow-ram",
+	.destructor = kvfree,
+	.snapshot = ixgbe_devlink_nvm_snapshot,
+	.read = ixgbe_devlink_nvm_read,
+};
+
+static const struct devlink_region_ops ixgbe_devcaps_region_ops = {
+	.name = "device-caps",
+	.destructor = kvfree,
+	.snapshot = ixgbe_devlink_devcaps_snapshot,
+};
+
+/**
+ * ixgbe_devlink_init_regions - Initialize devlink regions
+ * @adapter: adapter instance
+ *
+ * Create devlink regions used to enable access to dump the contents of the
+ * flash memory of the device.
+ */
+void ixgbe_devlink_init_regions(struct ixgbe_adapter *adapter)
+{
+	struct devlink *devlink = adapter->devlink;
+	struct device *dev = &adapter->pdev->dev;
+	u64 nvm_size, sram_size;
+
+	if (adapter->hw.mac.type != ixgbe_mac_e610)
+		return;
+
+	nvm_size = adapter->hw.flash.flash_size;
+	adapter->nvm_region = devl_region_create(devlink, &ixgbe_nvm_region_ops,
+						 1, nvm_size);
+	if (IS_ERR(adapter->nvm_region)) {
+		dev_err(dev,
+			"Failed to create NVM devlink region, err %ld\n",
+			PTR_ERR(adapter->nvm_region));
+		adapter->nvm_region = NULL;
+	}
+
+	sram_size = adapter->hw.flash.sr_words * 2u;
+	adapter->sram_region = devl_region_create(devlink, &ixgbe_sram_region_ops,
+						  1, sram_size);
+	if (IS_ERR(adapter->sram_region)) {
+		dev_err(dev,
+			"Failed to create shadow-ram devlink region, err %ld\n",
+			PTR_ERR(adapter->sram_region));
+		adapter->sram_region = NULL;
+	}
+
+	adapter->devcaps_region = devl_region_create(devlink,
+						     &ixgbe_devcaps_region_ops,
+						     10, IXGBE_ACI_MAX_BUFFER_SIZE);
+	if (IS_ERR(adapter->devcaps_region)) {
+		dev_err(dev,
+			"Failed to create device-caps devlink region, err %ld\n",
+			PTR_ERR(adapter->devcaps_region));
+		adapter->devcaps_region = NULL;
+	}
+}
+
+/**
+ * ixgbe_devlink_destroy_regions - Destroy devlink regions
+ * @adapter: adapter instance
+ *
+ * Remove previously created regions for this adapter instance.
+ */
+void ixgbe_devlink_destroy_regions(struct ixgbe_adapter *adapter)
+{
+	if (adapter->hw.mac.type != ixgbe_mac_e610)
+		return;
+
+	if (adapter->nvm_region)
+		devl_region_destroy(adapter->nvm_region);
+
+	if (adapter->sram_region)
+		devl_region_destroy(adapter->sram_region);
+
+	if (adapter->devcaps_region)
+		devl_region_destroy(adapter->devcaps_region);
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 23c2e2c2649c..47311b134a7a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -616,6 +616,9 @@ struct ixgbe_adapter {
 	struct mii_bus *mii_bus;
 	struct devlink *devlink;
 	struct devlink_port devlink_port;
+	struct devlink_region *nvm_region;
+	struct devlink_region *sram_region;
+	struct devlink_region *devcaps_region;
 
 	unsigned long state;
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 40daab34e4fe..03d31e5b131d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11317,6 +11317,7 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 	ixgbe_devlink_register_port(adapter);
 	SET_NETDEV_DEVLINK_PORT(adapter->netdev,
 				&adapter->devlink_port);
+	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
 
@@ -11824,6 +11825,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_netdev;
 
+	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
 	return 0;
@@ -11882,6 +11884,7 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	netdev  = adapter->netdev;
 	devl_lock(adapter->devlink);
 	devl_unregister(adapter->devlink);
+	ixgbe_devlink_destroy_regions(adapter);
 	ixgbe_dbg_adapter_exit(adapter);
 
 	set_bit(__IXGBE_REMOVING, &adapter->state);
-- 
2.47.1



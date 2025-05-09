Return-Path: <netdev+bounces-189268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED9AB15B7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA3BA043D5
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 13:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E75295D96;
	Fri,  9 May 2025 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkZ68fvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF082957CD;
	Fri,  9 May 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798245; cv=none; b=qkrpTJbMVFNl8hirzMvdBq2aZxk2TXwK3SYHLnfx5f/0V6QjSYSmvzRUrJCHRdofbDaUprNT7LAXO/2eyrGjmepVHLvEMlQJEGtT4gYPd4jqrA9dEqjVUdSQBr7s37S4EzrgtCdO+zfhU9//A9Ak8yA2FeQqJgg5c6f709YmHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798245; c=relaxed/simple;
	bh=57pFULhsbulHXnWbMB8Z+24WO/qyN9Gxay/WlWTNaq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8KkGFZ17UyYsb17CPjqJ2SIKItd/MgHtoPiY2/ZiPCmjke8bDWmzjLdbWO8W4NNTs6VxlD8KsfyKD+zKk2TRivaYWHZWMPvGECedY0isNmrL6tnO/j4Yw32ux+YO8cki+ejV4/GFyXXkWwpjTovE0bTd/NRozveovNhkJuBRaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkZ68fvZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746798243; x=1778334243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57pFULhsbulHXnWbMB8Z+24WO/qyN9Gxay/WlWTNaq4=;
  b=VkZ68fvZTqDK4ByiYnLOEW19iVvS7S+eSzn7LcqEKUmz6L8A67YBK2tM
   nqeMSlz/tbrJdzlZRIIRHSBq3I5hsFWPBn5IKNNGIrj1r3xGduMpoXfeo
   kTD8+Gzs5L80QxK0lsWTN0yyrjBIemmTmPV2hWLpWGU11PSUbYBTNxRU6
   ZZxT3bS2I6Y7A/hJJ4aY1GSpTu2gtM9NYU3x1wpDXo1SwHsBLd6zIxYZJ
   0dPP7ym9E71xE5QDPFswZOE/ewExfqqEbnVPrGE+Tz0d5k4V2r1XQtrzI
   EbHWEeeNconZoWQwZWWiSX5+qH4z9QqPThJb+pzxz6MopwfLpx5x9Lmol
   A==;
X-CSE-ConnectionGUID: XuTgGOb5RsCeQj1/SOdGNw==
X-CSE-MsgGUID: 7NDWxnhgSuSanmOr7uqaIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59257415"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59257415"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 06:44:02 -0700
X-CSE-ConnectionGUID: 490qHHj1T+OFbppMXOmOUg==
X-CSE-MsgGUID: E4Vl5xqmQPmUL3AE8HhWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="137133597"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 09 May 2025 06:43:55 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 74B2B3430D;
	Fri,  9 May 2025 14:43:52 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>
Subject: [PATCH iwl-next v3 15/15] ixd: add devlink support
Date: Fri,  9 May 2025 15:43:12 +0200
Message-ID: <20250509134319.66631-16-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250509134319.66631-1-larysa.zaremba@intel.com>
References: <20250509134319.66631-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amritha Nambiar <amritha.nambiar@intel.com>

Enable initial support for the devlink interface with the ixd driver. The
ixd hardware is a single function PCIe device. So, the PCIe adapter gets
its own devlink instance to manage device-wide resources or configuration.

$ devlink dev show
pci/0000:83:00.6

$ devlink dev info pci/0000:83:00.6
pci/0000:83:00.6:
  driver ixd
  serial_number 00-a0-c9-ff-ff-23-45-67
  versions:
      fixed:
        device.type MEV
      running:
        cp 0.0
        virtchnl 2.0

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/ixd.rst     |  35 +++++++
 drivers/net/ethernet/intel/ixd/Kconfig       |   1 +
 drivers/net/ethernet/intel/ixd/Makefile      |   1 +
 drivers/net/ethernet/intel/ixd/ixd_devlink.c | 105 +++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_devlink.h |  44 ++++++++
 drivers/net/ethernet/intel/ixd/ixd_main.c    |  13 ++-
 7 files changed, 197 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixd.rst
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_devlink.h

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b5933..ee9d89429fa2 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -85,6 +85,7 @@ parameters, info versions, and other features it supports.
    ionic
    ice
    ixgbe
+   ixd
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/ixd.rst b/Documentation/networking/devlink/ixd.rst
new file mode 100644
index 000000000000..81b28ffb00f6
--- /dev/null
+++ b/Documentation/networking/devlink/ixd.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+ixd devlink support
+===================
+
+This document describes the devlink features implemented by the ``ixd``
+device driver.
+
+Info versions
+=============
+
+The ``ixd`` driver reports the following versions
+
+.. list-table:: devlink info versions implemented
+    :widths: 5 5 5 90
+
+    * - Name
+      - Type
+      - Example
+      - Description
+    * - ``device.type``
+      - fixed
+      - MEV
+      - The hardware type for this device
+    * - ``cp``
+      - running
+      - 0.0
+      - Version number (major.minor) of the Control Plane software
+        running on the device.
+    * - ``virtchnl``
+      - running
+      - 2.0
+      - 2-digit version number (major.minor) of the communication channel
+        (virtchnl) used by the device.
diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
index 24510c50070e..34181c59dcdc 100644
--- a/drivers/net/ethernet/intel/ixd/Kconfig
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -7,6 +7,7 @@ config IXD
 	select LIBETH
 	select LIBIE_CP
 	select LIBIE_PCI
+	select NET_DEVLINK
 	help
 	  This driver supports Intel(R) Control Plane PCI Function
 	  of Intel E2100 and later IPUs and FNICs.
diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 90abf231fb16..03760a2580b9 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -8,5 +8,6 @@ obj-$(CONFIG_IXD) += ixd.o
 ixd-y := ixd_main.o
 ixd-y += ixd_ctlq.o
 ixd-y += ixd_dev.o
+ixd-y += ixd_devlink.o
 ixd-y += ixd_lib.o
 ixd-y += ixd_virtchnl.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.c b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
new file mode 100644
index 000000000000..6f60cfe4fab2
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Intel Corporation. */
+
+#include "ixd.h"
+#include "ixd_devlink.h"
+
+#define IXD_DEVLINK_INFO_LEN	128
+
+/**
+ * ixd_fill_dsn - Get the serial number for the ixd device
+ * @adapter: adapter to query
+ * @buf: storage buffer for the info request
+ */
+static void ixd_fill_dsn(struct ixd_adapter *adapter, char *buf)
+{
+	u8 dsn[8];
+
+	/* Copy the DSN into an array in Big Endian format */
+	put_unaligned_be64(pci_get_dsn(adapter->cp_ctx.mmio_info.pdev), dsn);
+
+	snprintf(buf, IXD_DEVLINK_INFO_LEN, "%8phD", dsn);
+}
+
+/**
+ * ixd_fill_device_name - Get the name of the underlying hardware
+ * @adapter: adapter to query
+ * @buf: storage buffer for the info request
+ * @buf_size: size of the storage buffer
+ */
+static void ixd_fill_device_name(struct ixd_adapter *adapter, char *buf,
+				 size_t buf_size)
+{
+	if (adapter->caps.device_type == VIRTCHNL2_MEV_DEVICE)
+		snprintf(buf, buf_size, "%s", "MEV");
+	else
+		snprintf(buf, buf_size, "%s", "UNKNOWN");
+}
+
+/**
+ * ixd_devlink_info_get - .info_get devlink handler
+ * @devlink: devlink instance structure
+ * @req: the devlink info request
+ * @extack: extended netdev ack structure
+ *
+ * Callback for the devlink .info_get operation. Reports information about the
+ * device.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+static int ixd_devlink_info_get(struct devlink *devlink,
+				struct devlink_info_req *req,
+				struct netlink_ext_ack *extack)
+{
+	struct ixd_adapter *adapter = devlink_priv(devlink);
+	char buf[IXD_DEVLINK_INFO_LEN];
+	int err;
+
+	ixd_fill_dsn(adapter, buf);
+	err = devlink_info_serial_number_put(req, buf);
+	if (err)
+		return err;
+
+	ixd_fill_device_name(adapter, buf, IXD_DEVLINK_INFO_LEN);
+	err = devlink_info_version_fixed_put(req, "device.type", buf);
+	if (err)
+		return err;
+
+	snprintf(buf, sizeof(buf), "%u.%u",
+		 le16_to_cpu(adapter->caps.cp_ver_major),
+		 le16_to_cpu(adapter->caps.cp_ver_minor));
+
+	err = devlink_info_version_running_put(req, "cp", buf);
+	if (err)
+		return err;
+
+	snprintf(buf, sizeof(buf), "%u.%u",
+		 adapter->vc_ver.major, adapter->vc_ver.minor);
+
+	return devlink_info_version_running_put(req, "virtchnl", buf);
+}
+
+static const struct devlink_ops ixd_devlink_ops = {
+	.info_get = ixd_devlink_info_get,
+};
+
+/**
+ * ixd_adapter_alloc - Allocate devlink and return adapter pointer
+ * @dev: the device to allocate for
+ *
+ * Allocate a devlink instance for this device and return the private area as
+ * the adapter structure.
+ *
+ * Return: adapter structure on success, NULL on failure
+ */
+struct ixd_adapter *ixd_adapter_alloc(struct device *dev)
+{
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&ixd_devlink_ops, sizeof(struct ixd_adapter),
+				dev);
+	if (!devlink)
+		return NULL;
+
+	return devlink_priv(devlink);
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_devlink.h b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
new file mode 100644
index 000000000000..c43ce0655de2
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_devlink.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025, Intel Corporation. */
+
+#ifndef _IXD_DEVLINK_H_
+#define _IXD_DEVLINK_H_
+#include <net/devlink.h>
+
+struct ixd_adapter *ixd_adapter_alloc(struct device *dev);
+
+/**
+ * ixd_devlink_free - teardown the devlink
+ * @adapter: the adapter structure to free
+ *
+ */
+static inline void ixd_devlink_free(struct ixd_adapter *adapter)
+{
+	struct devlink *devlink = priv_to_devlink(adapter);
+
+	devlink_free(devlink);
+}
+
+/**
+ * ixd_devlink_unregister - Unregister devlink resources for this adapter.
+ * @adapter: the adapter structure to cleanup
+ *
+ * Releases resources used by devlink and cleans up associated memory.
+ */
+static inline void ixd_devlink_unregister(struct ixd_adapter *adapter)
+{
+	devlink_unregister(priv_to_devlink(adapter));
+}
+
+/**
+ * ixd_devlink_register - Register devlink interface for this adapter
+ * @adapter: pointer to ixd adapter structure to be associated with devlink
+ *
+ * Register the devlink instance associated with this adapter
+ */
+static inline void ixd_devlink_register(struct ixd_adapter *adapter)
+{
+	devlink_register(priv_to_devlink(adapter));
+}
+
+#endif /* _IXD_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index c6dd6b3f14bb..d58b49bb3953 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -4,6 +4,7 @@
 #include "ixd.h"
 #include "ixd_ctlq.h"
 #include "ixd_lan_regs.h"
+#include "ixd_devlink.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
 MODULE_IMPORT_NS("LIBIE_CP");
@@ -21,12 +22,15 @@ static void ixd_remove(struct pci_dev *pdev)
 	/* Do not mix removal with (re)initialization */
 	cancel_delayed_work_sync(&adapter->init_task.init_work);
 
+	ixd_devlink_unregister(adapter);
+
 	/* Leave the device clean on exit */
 	ixd_trigger_reset(adapter);
 	ixd_deinit_dflt_mbx(adapter);
 
 	libie_pci_unmap_all_mmio_regions(&adapter->cp_ctx.mmio_info);
 	libie_pci_deinit_dev(pdev);
+	ixd_devlink_free(adapter);
 }
 
 /**
@@ -94,7 +98,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (WARN_ON(ent->device != IXD_DEV_ID_CPF))
 		return -EINVAL;
 
-	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	adapter = ixd_adapter_alloc(&pdev->dev);
 	if (!adapter)
 		return -ENOMEM;
 
@@ -103,7 +107,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = libie_pci_init_dev(pdev);
 	if (err)
-		return err;
+		goto free_adapter;
 
 	pci_set_drvdata(pdev, adapter);
 
@@ -119,11 +123,14 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
 			   msecs_to_jiffies(500));
 
+	ixd_devlink_register(adapter);
+
 	return 0;
 
 deinit_dev:
 	libie_pci_deinit_dev(pdev);
-
+free_adapter:
+	ixd_devlink_free(adapter);
 	return err;
 }
 
-- 
2.47.0



Return-Path: <netdev+bounces-168530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6940FA3F3CF
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62177ADDD9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A991120C489;
	Fri, 21 Feb 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6BShZ/I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B620C000
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139519; cv=none; b=W37WBSOKs9u55b3M/cfUWqpXGbA0vAn47Z6osfIN32Cjm1vYMpwdCQOYoTsk5KaK/aopyyWdz40xuXPYM3HKbHSjqWHwWGLpCGWYX6jf2OyFnzvoLaN3hFxa1o6QZaqmwzLL5viQDsNM4aCoWVh94MmSacroeqCd6tOZq+Os6QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139519; c=relaxed/simple;
	bh=fJFnFS80v+U80xlpF6bL+w0K/mlXrxDM99vxhoy2NDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBUfqi+wULvnuCVVAhhWGVoyXV/n9m+wZb7BEDpIQyXneDVRs1Iz0qsGiGetI6ZjvR0uDJnTHNv5jZtHKwAZZWZcHcPcNLAHfr6LLi9WWrKtAA/8c+cjzABDCJvsE+35XbGXoskSC1vQmOCmWY8BFWeOyLIjsfg74RpJjP3gF7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6BShZ/I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139518; x=1771675518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fJFnFS80v+U80xlpF6bL+w0K/mlXrxDM99vxhoy2NDQ=;
  b=F6BShZ/IBHJ75V3t6iBE6ayue3g7IfOpkJzPJGn0FIoS7BjawB6L1SvH
   /n2sbUwHhVoJ7o/hIul6iZKpnWT6rEyKZJMxeZAqq8Ux4/x/ghZvJ8QQE
   ol9+57pKmeSWuQD9/igT012iF7CyCe6YbJwfHqNQwmCcdwc29yEy6/AIl
   wqHMRhYhwDIR0INT4um6UuYHb5t668aaQqWx4WVtJXoNSIZhDkWxMR996
   aix17vhYCcLQsHKnevP6Zqg4Ye8hSBUDCHvGjJY0MIxMHxH4uf8h8CD65
   WhQzILI+esq8YVHRrL/5yrECqZLEabnYbWS6ySxGXj6aJ2oWMWVrqoquQ
   Q==;
X-CSE-ConnectionGUID: lpaqi7uVScqY/JTLX3lwnw==
X-CSE-MsgGUID: GKrPEFqCRfSPynWzVLjibA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51598944"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51598944"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:05:15 -0800
X-CSE-ConnectionGUID: ROWkfXezRdmAayxuhkNypw==
X-CSE-MsgGUID: wVIDFMFFTjqJh+6dTSOBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116260303"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 21 Feb 2025 04:05:13 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v5 03/15] ixgbe: add initial devlink support
Date: Fri, 21 Feb 2025 12:51:04 +0100
Message-Id: <20250221115116.169158-4-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an initial support for devlink interface to ixgbe driver.

Similarly to i40e driver the implementation doesn't enable
devlink to manage device-wide configuration. Devlink instance
is created for each physical function of PCIe device.

Create separate directory for devlink related ixgbe files
and use naming scheme similar to the one used in the ice driver.

Add a stub for Documentation, to be extended by further patches.

Change struct ixgbe_adapter allocation to be done by devlink (Przemek),
as suggested by Jiri.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: fix error patch in probe; minor tweaks
v4: alloc ixgbe_adapter by devlink
---
 Documentation/networking/devlink/index.rst    |  1 +
 Documentation/networking/devlink/ixgbe.rst    |  8 ++
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |  3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 77 +++++++++++++++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    | 10 +++
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 12 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 30 +++++++-
 8 files changed, 138 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h

diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 948c8c44e233..8319f43b5933 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -84,6 +84,7 @@ parameters, info versions, and other features it supports.
    i40e
    ionic
    ice
+   ixgbe
    mlx4
    mlx5
    mlxsw
diff --git a/Documentation/networking/devlink/ixgbe.rst b/Documentation/networking/devlink/ixgbe.rst
new file mode 100644
index 000000000000..c04ac51c6d85
--- /dev/null
+++ b/Documentation/networking/devlink/ixgbe.rst
@@ -0,0 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+ixgbe devlink support
+=====================
+
+This document describes the devlink features implemented by the ``ixgbe``
+device driver.
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 5579fb9bfd55..3366738c57c8 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -147,6 +147,7 @@ config IXGBE
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select MDIO
+	select NET_DEVLINK
 	select PHYLIB
 	help
 	  This driver supports Intel(R) 10GbE PCI Express family of
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index b456d102655a..11f37140c0a3 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -4,12 +4,13 @@
 # Makefile for the Intel(R) 10GbE PCI Express ethernet driver
 #
 
+subdir-ccflags-y += -I$(src)
 obj-$(CONFIG_IXGBE) += ixgbe.o
 
 ixgbe-y := ixgbe_main.o ixgbe_common.o ixgbe_ethtool.o \
            ixgbe_82599.o ixgbe_82598.o ixgbe_phy.o ixgbe_sriov.o \
            ixgbe_mbx.o ixgbe_x540.o ixgbe_x550.o ixgbe_lib.o ixgbe_ptp.o \
-           ixgbe_xsk.o ixgbe_e610.o
+           ixgbe_xsk.o ixgbe_e610.o devlink/devlink.o
 
 ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
                               ixgbe_dcb_82599.o ixgbe_dcb_nl.o
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
new file mode 100644
index 000000000000..6c3452cf5d7d
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Intel Corporation. */
+
+#include "ixgbe.h"
+#include "devlink.h"
+
+static const struct devlink_ops ixgbe_devlink_ops = {
+};
+
+/**
+ * ixgbe_allocate_devlink - Allocate devlink instance
+ * @dev: device to allocate devlink for
+ *
+ * Allocate a devlink instance for this physical function.
+ *
+ * Return: pointer to the device adapter structure on success,
+ * ERR_PTR(-ENOMEM) when allocation failed.
+ */
+struct ixgbe_adapter *ixgbe_allocate_devlink(struct device *dev)
+{
+	struct ixgbe_adapter *adapter;
+	struct devlink *devlink;
+
+	devlink = devlink_alloc(&ixgbe_devlink_ops, sizeof(*adapter), dev);
+	if (!devlink)
+		return ERR_PTR(-ENOMEM);
+
+	adapter = devlink_priv(devlink);
+	adapter->devlink = devlink;
+
+	return adapter;
+}
+
+/**
+ * ixgbe_devlink_set_switch_id - Set unique switch ID based on PCI DSN
+ * @adapter: pointer to the device adapter structure
+ * @ppid: struct with switch id information
+ */
+static void ixgbe_devlink_set_switch_id(struct ixgbe_adapter *adapter,
+					struct netdev_phys_item_id *ppid)
+{
+	u64 id = pci_get_dsn(adapter->pdev);
+
+	ppid->id_len = sizeof(id);
+	put_unaligned_be64(id, &ppid->id);
+}
+
+/**
+ * ixgbe_devlink_register_port - Register devlink port
+ * @adapter: pointer to the device adapter structure
+ *
+ * Create and register a devlink_port for this physical function.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter)
+{
+	struct devlink_port *devlink_port = &adapter->devlink_port;
+	struct devlink *devlink = adapter->devlink;
+	struct device *dev = &adapter->pdev->dev;
+	struct devlink_port_attrs attrs = {};
+	int err;
+
+	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
+	attrs.phys.port_number = adapter->hw.bus.func;
+	ixgbe_devlink_set_switch_id(adapter, &attrs.switch_id);
+
+	devlink_port_attrs_set(devlink_port, &attrs);
+
+	err = devl_port_register(devlink, devlink_port, 0);
+	if (err) {
+		dev_err(dev,
+			"devlink port registration failed, err %d\n", err);
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
new file mode 100644
index 000000000000..0b27653a3407
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025, Intel Corporation. */
+
+#ifndef _IXGBE_DEVLINK_H_
+#define _IXGBE_DEVLINK_H_
+
+struct ixgbe_adapter *ixgbe_allocate_devlink(struct device *dev);
+int ixgbe_devlink_register_port(struct ixgbe_adapter *adapter);
+
+#endif /* _IXGBE_DEVLINK_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 0efd6da874a5..6cb8772b1ebf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -17,6 +17,8 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 
+#include <net/devlink.h>
+
 #include "ixgbe_type.h"
 #include "ixgbe_common.h"
 #include "ixgbe_dcb.h"
@@ -612,6 +614,8 @@ struct ixgbe_adapter {
 	struct bpf_prog *xdp_prog;
 	struct pci_dev *pdev;
 	struct mii_bus *mii_bus;
+	struct devlink *devlink;
+	struct devlink_port devlink_port;
 
 	unsigned long state;
 
@@ -830,9 +834,15 @@ struct ixgbe_adapter {
 	spinlock_t vfs_lock;
 };
 
+struct ixgbe_netdevice_priv {
+	struct ixgbe_adapter *adapter;
+};
+
 static inline struct ixgbe_adapter *ixgbe_from_netdev(struct net_device *netdev)
 {
-	return netdev_priv(netdev);
+	struct ixgbe_netdevice_priv *priv = netdev_priv(netdev);
+
+	return priv->adapter;
 }
 
 static inline int ixgbe_determine_xdp_q_idx(int cpu)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f4f462a3cd79..e592719daa0c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -49,6 +49,7 @@
 #include "ixgbe_sriov.h"
 #include "ixgbe_model.h"
 #include "ixgbe_txrx_common.h"
+#include "devlink/devlink.h"
 
 char ixgbe_driver_name[] = "ixgbe";
 static const char ixgbe_driver_string[] =
@@ -11206,6 +11207,7 @@ static void ixgbe_set_fw_version(struct ixgbe_adapter *adapter)
 static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
+	struct ixgbe_netdevice_priv *netdev_priv_wrapper;
 	struct ixgbe_adapter *adapter = NULL;
 	struct ixgbe_hw *hw;
 	const struct ixgbe_info *ii = ixgbe_info_tbl[ent->driver_data];
@@ -11259,7 +11261,13 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		indices = IXGBE_MAX_RSS_INDICES_X550;
 	}
 
-	netdev = alloc_etherdev_mq(sizeof(struct ixgbe_adapter), indices);
+	adapter = ixgbe_allocate_devlink(&pdev->dev);
+	if (IS_ERR(adapter)) {
+		err = PTR_ERR(adapter);
+		goto err_devlink;
+	}
+
+	netdev = alloc_etherdev_mq(sizeof(*netdev_priv_wrapper), indices);
 	if (!netdev) {
 		err = -ENOMEM;
 		goto err_alloc_etherdev;
@@ -11267,7 +11275,8 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
-	adapter = ixgbe_from_netdev(netdev);
+	netdev_priv_wrapper = netdev_priv(netdev);
+	netdev_priv_wrapper->adapter = adapter;
 
 	adapter->netdev = netdev;
 	adapter->pdev = pdev;
@@ -11613,6 +11622,11 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 	strcpy(netdev->name, "eth%d");
 	pci_set_drvdata(pdev, adapter);
+
+	devl_lock(adapter->devlink);
+	ixgbe_devlink_register_port(adapter);
+	SET_NETDEV_DEVLINK_PORT(adapter->netdev, &adapter->devlink_port);
+
 	err = register_netdev(netdev);
 	if (err)
 		goto err_register;
@@ -11667,11 +11681,15 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_netdev;
 
+	devl_register(adapter->devlink);
+	devl_unlock(adapter->devlink);
 	return 0;
 
 err_netdev:
 	unregister_netdev(netdev);
 err_register:
+	devl_port_unregister(&adapter->devlink_port);
+	devl_unlock(adapter->devlink);
 	ixgbe_release_hw_control(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
 	if (hw->mac.type == ixgbe_mac_e610)
@@ -11688,7 +11706,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
 err_alloc_etherdev:
+	devlink_free(adapter->devlink);
 	pci_release_mem_regions(pdev);
+err_devlink:
 err_pci_reg:
 err_dma:
 	if (!adapter || disable_dev)
@@ -11717,6 +11737,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 		return;
 
 	netdev  = adapter->netdev;
+	devl_lock(adapter->devlink);
+	devl_unregister(adapter->devlink);
 	ixgbe_dbg_adapter_exit(adapter);
 
 	set_bit(__IXGBE_REMOVING, &adapter->state);
@@ -11752,6 +11774,10 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	if (netdev->reg_state == NETREG_REGISTERED)
 		unregister_netdev(netdev);
 
+	devl_port_unregister(&adapter->devlink_port);
+	devl_unlock(adapter->devlink);
+	devlink_free(adapter->devlink);
+
 	ixgbe_stop_ipsec_offload(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
 
-- 
2.31.1



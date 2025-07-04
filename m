Return-Path: <netdev+bounces-204108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB4EAF8F21
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC51CA32C2
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFA92EBDF6;
	Fri,  4 Jul 2025 09:51:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC4289805
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622696; cv=none; b=lWViIfQ3MplnJzx09i72MKYE61MQ3ICkIjQrYmPRq0Dn+HcNwPTeM5BuNScd2bCH3u+FGP+2jInJDHXKH1Dt+11Cy8Lr5Gyt90bDo+fpkt/3m37Wkghd1PVtwTKuVFCZOrPn1bcFfe+luUfgUTBzXL3ESxKWUlDvaB0iFZj71I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622696; c=relaxed/simple;
	bh=jMJugV0vkxzDgCS0hPxwOdup/PuFmx0hret5Zq5JjeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZaI4U7SonSzRyA+g5c39IZDtEPNgpsYskfhpV4SD7ENzk2gHOuxSoui93cPOOVXANHCNiC3iLWBzXwpz4Jo+x/8NU1E5rr4z/eJGeuXUU9cmSJdWbhIDPbWh/InEGPz390s9wusNqJxemjH/j17SU4e8IfgjBz9M1WwHDjQzGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622608t7445e4c3
X-QQ-Originating-IP: C3INMOZnnDBTWcEgwyPeDfJK8rJlaKvPnPOlQDJ/8Fw=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14338936718117783507
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: michal.swiatkowski@linux.intel.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 04/12] net: wangxun: add txgbevf build
Date: Fri,  4 Jul 2025 17:49:15 +0800
Message-Id: <20250704094923.652-5-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250704094923.652-1-mengyuanlou@net-swift.com>
References: <20250704094923.652-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OZqpMP2dGTMjhEI44P9KKbKiYUjOCg703IbWT+QhTBhQRNJaaUcUStPs
	XCEXd7kMIRN4ajLSTyTI5qg4BsU1AjpY3LatdZaxcxuYIeJoTkrAvtgyb8vMg287nWvC6Fw
	y8l5ixpkoFVbYToGnoazx/LhceXIrGErZ64Qa2qqEGVCoKV0ImuHKvHXrMdb6tQL5g+nRmK
	n/hTTdvA60BufrfriMiWbVBTnWnXYszqiy0KKrdnMXfXqNhuv1xugejc1lkL8R32Dxd6Afb
	wKSmYGP3LETEGtE0eMaedo0PmzLeurjDg7wIx8lXOicDuP++XTQNGVSN/PDlOcpRsBRB+CT
	q64+d6CDcfO3cz+bxnbqsypn/MyRwSrO66Ku7kttwDf93k3zF6W1z3IPqxmWSAMpXUtE4N1
	pqk3OY2yP2alIAmpBRlNPIV07AS3JVhCRrucG5ssGFnyqZt+vORRFsQMdRUCba6jXXbYWD6
	RN1H/PH3rpxVVLgCV3aEsvq+cuNH99ci3INMyRKQcXqqu6v76hu/j0qSUReLRoDTU4uXjiV
	g6mJ/mpHj2ygJfbfIpbEmiQ716RcI4oQNlrscivedVlFRD9p9oXDVAP5vb49+KbupnHuuJ/
	rM3I+55ov2sZki2bG7eW7kXed45owX2mNO/bFp9O+i0iyahaAWjMR+YbJVFIMlIGdjNADRK
	JZBvcZlON7Rv/M63LoJTMDZwjREGhqcEmyUxapnqxgDOErqI9a9YOYDD2ZaZZ7ikS5TTlJB
	PUrpnJpsY28TOnLoAf1wYRdGwILc/ikZLucfdnFCho+v1J5CMazcU9IgF0hL8ThkaTo/Lgb
	LYd59yxKyJ8g/N9OXaK5nsK53u9CnFOzgSsGfoBlRadvWZF5TJBp8vo8eneQxWDj8AcRRoo
	tYzni1c0TISV5z7Jt5eMUvdOdJyiBjN1hnS8xl+2ueJxUhWHrOXLIJ+3u0drZwlzIFbIcSy
	xX3kOwjGRmTCqh+8Y2NGIuxtj8YGQ3bZ3fP2qBJpFXLwzCrjrZQlvhKqjb4FWC0NL5JLHRC
	yqi3LkrHqQbUE5IVHmohK0pA8FfEiawUh3w5wp4tDd5fFtJ17ghGjqIRODctmlFciWy3qVJ
	Afh+Hs+AQWYMpW76uKHyeVXt+PBdrpkx9meVF446Jr4W4gCx4jujua82J5ZZNwKaeFfgcrr
	zxVM
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Add doc build infrastructure for txgbevf driver.
Implement the basic PCI driver loading and unloading interface.
Initialize the id_table which support 10/25/40G virtual
functions for Wangxun.
Ioremap the space of bar0 and bar4 which will be used.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/wangxun/txgbevf.rst              |  16 ++
 drivers/net/ethernet/wangxun/Kconfig          |  18 ++
 drivers/net/ethernet/wangxun/Makefile         |   1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  38 +++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   4 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile |   9 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 154 ++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  20 +++
 9 files changed, 261 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 139b4c75a191..e93453410772 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -58,6 +58,7 @@ Contents:
    ti/tlan
    ti/icssg_prueth
    wangxun/txgbe
+   wangxun/txgbevf
    wangxun/ngbe
 
 .. only::  subproject and html
diff --git a/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst b/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
new file mode 100644
index 000000000000..b2f759b7b518
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+===========================================================================
+Linux Base Virtual Function Driver for Wangxun(R) 10/25/40 Gigabit Ethernet
+===========================================================================
+
+WangXun 10/25/40 Gigabit Virtual Function Linux driver.
+Copyright(c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+
+Support
+=======
+For general information, go to the website at:
+https://www.net-swift.com
+
+If you got any problem, contact Wangxun support team via nic-support@net-swift.com
+and Cc: netdev.
diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index e5fc942c28cc..a6ec73e4f300 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -64,4 +64,22 @@ config TXGBE
 	  To compile this driver as a module, choose M here. The module
 	  will be called txgbe.
 
+config TXGBEVF
+	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
+	depends on PCI
+	depends on PCI_MSI
+	select LIBWX
+	select PHYLINK
+	help
+	  This driver supports virtual functions for SP1000A, WX1820AL,
+	  WX5XXX, WX5XXXAL.
+
+	  This driver was formerly named txgbevf.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst>.
+
+	  To compile this driver as a module, choose M here. MSI-X interrupt
+	  support is required for this driver to work correctly.
+
 endif # NET_VENDOR_WANGXUN
diff --git a/drivers/net/ethernet/wangxun/Makefile b/drivers/net/ethernet/wangxun/Makefile
index ca19311dbe38..71371d47a6ee 100644
--- a/drivers/net/ethernet/wangxun/Makefile
+++ b/drivers/net/ethernet/wangxun/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_LIBWX) += libwx/
 obj-$(CONFIG_TXGBE) += txgbe/
+obj-$(CONFIG_TXGBEVF) += txgbevf/
 obj-$(CONFIG_NGBE) += ngbe/
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index aac420bf578b..4a3c7d61e5fd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -11,6 +11,44 @@
 #include "wx_vf_lib.h"
 #include "wx_vf_common.h"
 
+int wxvf_suspend(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	netif_device_detach(wx->netdev);
+	pci_disable_device(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_suspend);
+
+void wxvf_shutdown(struct pci_dev *pdev)
+{
+	wxvf_suspend(&pdev->dev);
+}
+EXPORT_SYMBOL(wxvf_shutdown);
+
+int wxvf_resume(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	pci_set_master(pdev);
+	netif_device_attach(wx->netdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_resume);
+
+void wxvf_remove(struct pci_dev *pdev)
+{
+	pci_release_selected_regions(pdev,
+				     pci_select_bars(pdev, IORESOURCE_MEM));
+	pci_disable_device(pdev);
+}
+EXPORT_SYMBOL(wxvf_remove);
+
 static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
 {
 	struct wx *wx = data;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index 9bee9de86cb2..f3b31f33407b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -4,6 +4,10 @@
 #ifndef _WX_VF_COMMON_H_
 #define _WX_VF_COMMON_H_
 
+int wxvf_suspend(struct device *dev_d);
+void wxvf_shutdown(struct pci_dev *pdev);
+int wxvf_resume(struct device *dev_d);
+void wxvf_remove(struct pci_dev *pdev);
 int wx_request_msix_irqs_vf(struct wx *wx);
 void wx_negotiate_api_vf(struct wx *wx);
 void wx_reset_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbevf/Makefile b/drivers/net/ethernet/wangxun/txgbevf/Makefile
new file mode 100644
index 000000000000..4c7e6de04424
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+#
+# Makefile for the Wangxun(R) 10/25/40GbE virtual functions driver
+#
+
+obj-$(CONFIG_TXGBE) += txgbevf.o
+
+txgbevf-objs := txgbevf_main.o
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
new file mode 100644
index 000000000000..9e8ddec36913
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/etherdevice.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_vf_common.h"
+#include "txgbevf_type.h"
+
+/* txgbevf_pci_tbl - PCI Device ID Table
+ *
+ * Wildcard entries (PCI_ANY_ID) should come last
+ * Last entry must be all 0s
+ *
+ * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
+ *   Class, Class Mask, private data (not used) }
+ */
+static const struct pci_device_id txgbevf_pci_tbl[] = {
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_SP1000), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_WX1820), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML500F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML510F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5024), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5124), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML503F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML513F), 0},
+	/* required last entry */
+	{ .device = 0 }
+};
+
+/**
+ * txgbevf_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in txgbevf_pci_tbl
+ *
+ * Return: return 0 on success, negative on failure
+ *
+ * txgbevf_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring of the adapter private structure,
+ * and a hardware reset occur.
+ **/
+static int txgbevf_probe(struct pci_dev *pdev,
+			 const struct pci_device_id __always_unused *ent)
+{
+	struct net_device *netdev;
+	struct wx *wx = NULL;
+	int err;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting\n");
+		goto err_pci_disable_dev;
+	}
+
+	err = pci_request_selected_regions(pdev,
+					   pci_select_bars(pdev, IORESOURCE_MEM),
+					   dev_driver_string(&pdev->dev));
+	if (err) {
+		dev_err(&pdev->dev,
+			"pci_request_selected_regions failed 0x%x\n", err);
+		goto err_pci_disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	netdev = devm_alloc_etherdev_mqs(&pdev->dev,
+					 sizeof(struct wx),
+					 TXGBEVF_MAX_TX_QUEUES,
+					 TXGBEVF_MAX_RX_QUEUES);
+	if (!netdev) {
+		err = -ENOMEM;
+		goto err_pci_release_regions;
+	}
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+
+	wx = netdev_priv(netdev);
+	wx->netdev = netdev;
+	wx->pdev = pdev;
+
+	wx->msg_enable = netif_msg_init(-1, NETIF_MSG_DRV |
+					NETIF_MSG_PROBE | NETIF_MSG_LINK);
+	wx->hw_addr = devm_ioremap(&pdev->dev,
+				   pci_resource_start(pdev, 0),
+				   pci_resource_len(pdev, 0));
+	if (!wx->hw_addr) {
+		err = -EIO;
+		goto err_pci_release_regions;
+	}
+
+	wx->b4_addr = devm_ioremap(&pdev->dev,
+				   pci_resource_start(pdev, 4),
+				   pci_resource_len(pdev, 4));
+	if (!wx->b4_addr) {
+		err = -EIO;
+		goto err_pci_release_regions;
+	}
+
+	netdev->features |= NETIF_F_HIGHDMA;
+
+	pci_set_drvdata(pdev, wx);
+
+	return 0;
+
+err_pci_release_regions:
+	pci_release_selected_regions(pdev,
+				     pci_select_bars(pdev, IORESOURCE_MEM));
+err_pci_disable_dev:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * txgbevf_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * txgbevf_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  The could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void txgbevf_remove(struct pci_dev *pdev)
+{
+	wxvf_remove(pdev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(txgbevf_pm_ops, wxvf_suspend, wxvf_resume);
+
+static struct pci_driver txgbevf_driver = {
+	.name     = KBUILD_MODNAME,
+	.id_table = txgbevf_pci_tbl,
+	.probe    = txgbevf_probe,
+	.remove   = txgbevf_remove,
+	.shutdown = wxvf_shutdown,
+	/* Power Management Hooks */
+	.driver.pm	= pm_sleep_ptr(&txgbevf_pm_ops)
+};
+
+module_pci_driver(txgbevf_driver);
+
+MODULE_DEVICE_TABLE(pci, txgbevf_pci_tbl);
+MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
+MODULE_DESCRIPTION("WangXun(R) 10/25/40 Gigabit Virtual Function Network Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
new file mode 100644
index 000000000000..2ba9d0cb63d5
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _TXGBEVF_TYPE_H_
+#define _TXGBEVF_TYPE_H_
+
+/* Device IDs */
+#define TXGBEVF_DEV_ID_SP1000                  0x1000
+#define TXGBEVF_DEV_ID_WX1820                  0x2000
+#define TXGBEVF_DEV_ID_AML500F                 0x500F
+#define TXGBEVF_DEV_ID_AML510F                 0x510F
+#define TXGBEVF_DEV_ID_AML5024                 0x5024
+#define TXGBEVF_DEV_ID_AML5124                 0x5124
+#define TXGBEVF_DEV_ID_AML503F                 0x503f
+#define TXGBEVF_DEV_ID_AML513F                 0x513f
+
+#define TXGBEVF_MAX_RX_QUEUES                  4
+#define TXGBEVF_MAX_TX_QUEUES                  4
+
+#endif /* _TXGBEVF_TYPE_H_ */
-- 
2.30.1



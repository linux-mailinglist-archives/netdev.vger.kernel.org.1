Return-Path: <netdev+bounces-201066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794FBAE7F0C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B463A8D0F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7440A2BD5B3;
	Wed, 25 Jun 2025 10:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19329AAF7
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846947; cv=none; b=CQmZLYMy19cGj/VKXmJwWRqb+6bgUOfDp/OT2kPF1Xdrw5Q0UDYDd6tWQins67EmT1vOEYMkP6rbMHlqcZFE4UxBminVu+4VUNpfkq3Ojy3dcZ8KX2c3O9A52YSLULy/uT7GB4OJBligwmgzsAKCoDltajLx5Sn2udvAGzZYm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846947; c=relaxed/simple;
	bh=RXFyn2n0qyBIR7UEWxzN/TZFEwVE6PHzZiXLpdwSdVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ro2qJZgLkyi80x95q6ZBsjzBavoyTYYOnNQSvJRDpaogtfVjD6yN/8/n5BZlp6gmQDQ+mvGuwI8dcFC0VRWPugvirZ3KvUEd8O6Q8C/w9WiHkdKj/kXy4cQ88Iw3LiE9wlJJgTl3ehD8KOwiFPVsyheEfT8o9LoL0/4WKNinO3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: esmtpgz13t1750846883t22193f44
X-QQ-Originating-IP: dffsWKuBlAVRYO0lf63XnhDK/av6dbcHwMayeIESydQ=
Received: from localhost.localdomain ( [60.186.80.242])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Jun 2025 18:21:21 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14228362950089457375
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
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 09/12] net: wangxun: add ngbevf build
Date: Wed, 25 Jun 2025 18:20:55 +0800
Message-Id: <20250625102058.19898-10-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250625102058.19898-1-mengyuanlou@net-swift.com>
References: <20250625102058.19898-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Md0Qe8tK0cV65+mzCcv3bOqXBSr1i7uTqhnQ9agRxBsc05Z3gUbEzjDp
	dAlNIK0iEBcA4V8kCLqbFRpAPpm/q/9XHphc+k43230gY/CWa51sJxEUh1/bC1GO3J+07jA
	bhULNivzyg0hYozfm80o6KgXUpbAjjVPopADC3bK55QU65BVey8w2/IvwZCaMuJrXnqyVeX
	Eyp2JgVYq4Yb4zqAtti/kdj0fxvOTHtpv5RIGrCmd/uj9fga5yfVU0fxCce3oSf3rxlrUOl
	fBvzjClwrzYn80w/gdBpsyKK9fkghyCNyyKM9eCdaDh41rJfod0YqFibCBd4ESwbrnJvK43
	RBuKwy55VWTGG28fo6VSfXBSnX/G1imn8Yvje5kqB/RsBPTe6lU8ERCGK/odIsVxNbvcmht
	7XWaFkMOZ5SWfOspjGePStdw4lFkUU1tJtfRBTvweq0BEBu0cEm6HaWvp/Z5A6zb7Cilzdp
	gaPb3nQs1tP3DgFAYPCrRdrQCJJ89Usc+cm4FERxScfk9xb+kdekRfttSA9NXORJ+m8kXNS
	Baidju/HBpPDi4kw3FJTZ4jSpw3rVlA97biru/T2Xm6FbrQ6tsqDvYfnPu5IjOifOMrrm7r
	9+ssjbwMDTb+F2AiYnsrDlWU0DZ8FGaBowosOHkScNcYcsCAn9rvnTkl4/gvGfU1brjD6bt
	VXhvT8JDETFIe5QOj6YiPm/fX3pwoVAZ9M86vHNMQcHHxCH/DrCjzOF9RfE5SVXSSh3epOO
	tQOjC/JhjXOR4uoZXQ2zzmy7zzSgyD2Sw7X4B1gVXZDAsgZw/ZxDgaHWCrxNXakJe7yWGZk
	GbgDkD+ubpk/aFFbnsWfo6+rdBlaV572YZAY2gsJFr5Nzq1gNJsAQVXegCdfKUR/8hK4eXE
	6vF07wnJB0rQZ9FIoBccPM9TrYntCC8icaf/SRGXtZGaLX32su272VLXRxncrawav66UhCv
	yHTnwr3qpXzyUW12PyhKdZtTHx69nLTHjjnpwVpDgMPZhjcMkPHlVRfe/0oRajVEoNmVmhz
	Y7KqhWfq1S6AiZ2vHrDsAZmj/hff8s4N1ALHn1AWk9tNaO/7b7le3E/FCs2mXgZQQoHQBzp
	hhpicYCnQEXWckBjs5zlCs+l1/YKIXV3r/7/eRBjzTxE8zIwrGZX2oSajNWSI0ANg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add doc build infrastructure for ngbevf driver.
Implement the basic PCI driver loading and unloading interface.
Initialize the id_table which support 1G virtual
functions for Wangxun.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/wangxun/ngbevf.rst               |  16 ++
 drivers/net/ethernet/wangxun/Kconfig          |  15 ++
 drivers/net/ethernet/wangxun/Makefile         |   1 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile  |   9 ++
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 149 ++++++++++++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  24 +++
 7 files changed, 215 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index e93453410772..40ac552641a3 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -60,6 +60,7 @@ Contents:
    wangxun/txgbe
    wangxun/txgbevf
    wangxun/ngbe
+   wangxun/ngbevf
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst b/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
new file mode 100644
index 000000000000..a39e3d5a1038
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==================================================================
+Linux Base Virtual Function Driver for Wangxun(R) Gigabit Ethernet
+==================================================================
+
+WangXun Gigabit Virtual Function Linux driver.
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
index a6ec73e4f300..c548f4e80565 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -82,4 +82,19 @@ config TXGBEVF
 	  To compile this driver as a module, choose M here. MSI-X interrupt
 	  support is required for this driver to work correctly.
 
+config NGBEVF
+	tristate "Wangxun(R) GbE Virtual Function Ethernet support"
+	depends on PCI_MSI
+	select LIBWX
+	help
+	  This driver supports virtual functions for WX1860, WX1860AL.
+
+	  This driver was formerly named ngbevf.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst>.
+
+	  To compile this driver as a module, choose M here. MSI-X interrupt
+	  support is required for this driver to work correctly.
+
 endif # NET_VENDOR_WANGXUN
diff --git a/drivers/net/ethernet/wangxun/Makefile b/drivers/net/ethernet/wangxun/Makefile
index 71371d47a6ee..0a71a710b717 100644
--- a/drivers/net/ethernet/wangxun/Makefile
+++ b/drivers/net/ethernet/wangxun/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_LIBWX) += libwx/
 obj-$(CONFIG_TXGBE) += txgbe/
 obj-$(CONFIG_TXGBEVF) += txgbevf/
 obj-$(CONFIG_NGBE) += ngbe/
+obj-$(CONFIG_NGBEVF) += ngbevf/
diff --git a/drivers/net/ethernet/wangxun/ngbevf/Makefile b/drivers/net/ethernet/wangxun/ngbevf/Makefile
new file mode 100644
index 000000000000..11a4f15e2ce3
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+#
+# Makefile for the Wangxun(R) 1GbE virtual functions driver
+#
+
+obj-$(CONFIG_NGBE) += ngbevf.o
+
+ngbevf-objs := ngbevf_main.o
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
new file mode 100644
index 000000000000..77025e7deeeb
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -0,0 +1,149 @@
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
+#include "ngbevf_type.h"
+
+/* ngbevf_pci_tbl - PCI Device ID Table
+ *
+ * Wildcard entries (PCI_ANY_ID) should come last
+ * Last entry must be all 0s
+ *
+ * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
+ *   Class, Class Mask, private data (not used) }
+ */
+static const struct pci_device_id ngbevf_pci_tbl[] = {
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL_W), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860NCSI), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A1), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL1), 0},
+	/* required last entry */
+	{ .device = 0 }
+};
+
+/**
+ * ngbevf_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in ngbevf_pci_tbl
+ *
+ * Return: return 0 on success, negative on failure
+ *
+ * ngbevf_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring of the adapter private structure,
+ * and a hardware reset occur.
+ **/
+static int ngbevf_probe(struct pci_dev *pdev,
+			const struct pci_device_id __always_unused *ent)
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
+					 NGBEVF_MAX_TX_QUEUES,
+					 NGBEVF_MAX_RX_QUEUES);
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
+	netdev->features |= NETIF_F_HIGHDMA;
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
+ * ngbevf_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * ngbevf_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  The could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void ngbevf_remove(struct pci_dev *pdev)
+{
+	wxvf_remove(pdev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops, wxvf_suspend, wxvf_resume);
+
+static struct pci_driver ngbevf_driver = {
+	.name     = KBUILD_MODNAME,
+	.id_table = ngbevf_pci_tbl,
+	.probe    = ngbevf_probe,
+	.remove   = ngbevf_remove,
+	.shutdown = wxvf_shutdown,
+	/* Power Management Hooks */
+	.driver.pm	= pm_sleep_ptr(&ngbevf_pm_ops)
+};
+
+module_pci_driver(ngbevf_driver);
+
+MODULE_DEVICE_TABLE(pci, ngbevf_pci_tbl);
+MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
+MODULE_DESCRIPTION("WangXun(R) Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
new file mode 100644
index 000000000000..c71a244ec6b9
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _NGBEVF_TYPE_H_
+#define _NGBEVF_TYPE_H_
+
+/* Device IDs */
+#define NGBEVF_DEV_ID_EM_WX1860AL_W             0x0110
+#define NGBEVF_DEV_ID_EM_WX1860A2               0x0111
+#define NGBEVF_DEV_ID_EM_WX1860A2S              0x0112
+#define NGBEVF_DEV_ID_EM_WX1860A4               0x0113
+#define NGBEVF_DEV_ID_EM_WX1860A4S              0x0114
+#define NGBEVF_DEV_ID_EM_WX1860AL2              0x0115
+#define NGBEVF_DEV_ID_EM_WX1860AL2S             0x0116
+#define NGBEVF_DEV_ID_EM_WX1860AL4              0x0117
+#define NGBEVF_DEV_ID_EM_WX1860AL4S             0x0118
+#define NGBEVF_DEV_ID_EM_WX1860NCSI             0x0119
+#define NGBEVF_DEV_ID_EM_WX1860A1               0x011a
+#define NGBEVF_DEV_ID_EM_WX1860AL1              0x011b
+
+#define NGBEVF_MAX_RX_QUEUES                  1
+#define NGBEVF_MAX_TX_QUEUES                  1
+
+#endif /* _NGBEVF_TYPE_H_ */
-- 
2.30.1



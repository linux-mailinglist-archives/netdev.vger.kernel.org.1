Return-Path: <netdev+bounces-204116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E9DAF8F29
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF91584B87
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A02ECD27;
	Fri,  4 Jul 2025 09:51:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDE2ED852
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622711; cv=none; b=T8TZZ5q2JQfpW0dxR4GnltRwmjQIMfRrsP3sDwiPlJKX0g8sRt6eYeMnjwLywifUJN0H0ftGWH9XUoeHZbegtk6KK/UhBmJlhwtTFEqsa/a4C+XuR2lyLpihDnnawYSprcD1cDFaXa4ytNIXssAJ1Jjph+lD5djBv+lAv5KlH1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622711; c=relaxed/simple;
	bh=RXFyn2n0qyBIR7UEWxzN/TZFEwVE6PHzZiXLpdwSdVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4PXTZM3L7BCsHPnOGQEeOR1WHGN/glQzUvsZQk+f4OXdW89kHEKvAF82qkjtY6RjAYo7+ylN1RhLIv8R8cIbCA8i2A6qVQaq3Ukz22sZQ9kw5nh4iuaIFGPmBozp16aoKud6JWQ4q+r0cGTt7eXn4j+RPaB42jw9+q0ylcRLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1751622642t5aedb9ce
X-QQ-Originating-IP: oiIo5TImZuGFTUflIYBIz3MYrqaniNNNJjDhWQooeOg=
Received: from localhost.localdomain ( [156.146.53.122])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 04 Jul 2025 17:50:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5090910045377981012
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
Subject: [PATCH net-next v3 09/12] net: wangxun: add ngbevf build
Date: Fri,  4 Jul 2025 17:49:20 +0800
Message-Id: <20250704094923.652-10-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: MdrRzaNqeqCMcWnm9ByxIN3Fyke/iztpSbch+xtr7wVbdytPY9aFxp9E
	sflRgSm0bi4YOR5MIazFQJwD4ClCmGOCnUlf7kwnj2jvBhyleLBphpj7VdP5a3U4kNcTmmI
	6zq7ZHWyFrup0vgIS8M+0pDY6ksMpusSx0XQyPd+2tkhUD1h0WW9C2vrC5dYxQAxSZkXsMu
	0ICNcnmPG2Vpq8gcZ546jHCQtT3ASMfgIx81SNETsyCOjcQgMS/AiMGEd+Tm3XusQCSq9Bu
	WYY//hujIHhKtCrkx08nJ/7SeRQhECToXZ0y43tZFl6h5GLhjFbJEEJccOQ6p7ZnmORO4D0
	7E67x2GvCRAda0Y6N1KD82KBbEnlAlIWZ2a4XzljJqSKaO0xp2z8DFxrT0pHn9Q+OjJ9bqw
	tYgvsSnHHKBIEGgrLlMbVC91HyPjBoLcHJqmaeJUKR1LBgw3BLXgQ7OD/JTaxkvI18JlJc3
	F1/fl47JAQNmnAdgh4fiWWYOO7VYBK65desn+6cX3hTegiQ+Mnd1q77sPiJeR6GEzLEUTix
	ERb1nptRLggrLjwpnFMKd3DWjiFjvrNGIpOUhcoJaTgkX09dEWPtRrxhcPpTTOPd1qzxMFD
	RQaV033TkGTGugdJ8jkxnUrVGVPqIHyMTqfcCwzKbszGUoaDw+wyiChJ01mNxhhLipcuWHb
	X+xhl47qvZ/Ib6ySUuUMTJ87FL4mw3PuDIhm33oyi9QsfbaRorsCjqacly10BwyTjnzMIVg
	8YfKZWzhT6amgFyJsMWtUTbHh9Sb4N9DEvETUZQhsGFnz5VgGwXIVQFwy6Xkvl7gSeUzsTO
	YCVrQejVEs75diwN0Q56vKEL8kXnpoLG/NKeCopfQ9JhMluznV8Su6mb4lK5OFGKa4umPBb
	fCbtF1UJnvKdtrVry3Fu5tYAKrjdv8ySEX4lclasIfyTxqDtWilAy6GYLTwT1TZaPgloksU
	6zB+0apxSc0xn5aY8OjhyOEVZq9tkwJ6+UEbliXRHsmd6hXE0cHMB7/TuitQeFit9ViuCf5
	EAGlCV/pKvQcmCcEbyAfdszijnPzqZntXdQXgCly16unYbvVId2v/eOP/40U21sbHw4WL1Y
	msF8w1DcgPlY8SZ/HvP2fKVFAh553gK8a49GY1dei+6cGP2FIJDAU3LyILEAF919grUIsvQ
	PPEozR4Vx8Mz+pw=
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



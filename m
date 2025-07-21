Return-Path: <netdev+bounces-208571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E87B0C319
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421D61885622
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23A2BE65E;
	Mon, 21 Jul 2025 11:34:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB1E2BE04E;
	Mon, 21 Jul 2025 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097654; cv=none; b=RpKa/UAuaNO+ZohveHMgmBnCsigFUTmryfqORJ68sfkRXTORNz6+dOpAUKzJgwjmnEOhNCPadKU9ipiKMAQdtKVCvCuIyQP6g07x/9hzRBKA3O555VHVkyDcYRuBAvSab7X166nJgFoTMdpbWckPiaj5PvxBIA/SYM4hhbqxjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097654; c=relaxed/simple;
	bh=uZSfa6ZarJJVp4ixplN5Zas5ypjBwkWGTv6U/H50zdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QF9Bh7aYrusr6wrZCdjd4PuSXSiwyuCK9sboeyFNlGQpPvdglXVNg1KBhA6N8jOdcIG3/eF1XLFAv1UZxI5aVtz80Oiii7ZFulw+iNMgGm7JXQFN2gIOclnCoSoo0PSXEo+KEc9srVX4nesgUGiq/0X1LyQm3Y95R9DKujpR/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097571tb79f57e9
X-QQ-Originating-IP: grWXWpapzJS8mvDKGaDnulyivtQXCKqW/oj5lG8HJiM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:32:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16218708113185260639
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Date: Mon, 21 Jul 2025 19:32:24 +0800
Message-Id: <20250721113238.18615-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDo0YgvfYJuRcH5lBAUhM0aDn8aWsDPigcZe9lRzSCrNrfam2kHUlJS+
	1c4F2wlhOcmd/N9GpMwanltCucDtCwOohdlXc3MvEkT8NAYoTOhH8YiMRKaxfN7ZyHhiXa/
	T3vkqgXk/JEWxk7g44BzmMA1gZE/V633DVdZTd67tLZQAyqjwQRZyZeuk9sKh04xuarNbBF
	65SuWF62qS6mX9hJLJw8GejjQ4KnjwG4CDP0XWec0Ru1G5pBRXnrgx+/z5BskHnEJI86vMl
	IoEBxOh6CVJpmYB0xxfDV1h6+Dw026+Pv9nnK32Ic1sEjdiqMs1LTNmMC2yjaHUUCbG3z9V
	T5JHyGtScHWOodhwthc6OT4EPDEkW1xMV8bR1z46yhYpWjLIBbr6uGXQmNRpMAJCOvBokMX
	GPLPdSCj94ckq34uXVVRZacsJBnyKVsoQR6RGVnl4yWZI4XwIWr+ecCVyNjNlK8b+ro3QS9
	6SCIBmbLvH3eUinqgkxeMkm4p+DoVZ1HPzFp5D7nlb/KfW7Svj9mXHyt5ORwAylZ0UU9f5J
	CmGn5gYg0k/3Oy6VQKXD9+RYS911xADaHsr2JRS1WOFVg2q1mbbW7cua1M/pdJgYeODBuLT
	400WirpShy2xJAn8tYqoHCCvLnbsDWmVCuL6JVpCUVNcFWvQYpOLPuI3aCXivu/+7LHB9T/
	dwvxm0CAA8Eltk2fiHfItIsk+KvilLX0OWbnj2XQT2aXbxCxX1fK7nTPcavnKiimO0jRXna
	wfwipVxqdFC8glzeCY4FT+ltJbOlVgn+0ooeSnRzVUM9G1UHzLxXUD0/j07Sy9SEs1p1R76
	cSj2So2R64MmeEo8RCTxe+e8i3ZG3lF77YUvRiCK1IoDI5kgvJ2h3g89rXBZjXxE/31JyxK
	ooXkkkbUaaYqmsweUMFMSVzRDeab3vwUDIqen56q2VIS+IGH1jA56f0djElY8dsCGllWRYI
	ZCpM5AYI75JuZoI75wVxbIivIlsomAxWcgSu4ymhlaFz/3poKESxJI6Lx1BKKkjiUXH7n9g
	q6MEG0fhLQ1tYLc6KJaOYq/3y8tYO/Uzy2pFyITJ5XEsxK7R1LbUqd46aY1+yUrr88fuCKy
	SadRCy4V2ZW
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Add build options and doc for mucse.
Initialize pci device access for MUCSE devices.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 ++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 +++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   9 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  33 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 226 ++++++++++++++++++
 10 files changed, 341 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 40ac552641a3..0e03c5c10d30 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -61,6 +61,7 @@ Contents:
    wangxun/txgbevf
    wangxun/ngbe
    wangxun/ngbevf
+   mucse/rnpgbe
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
new file mode 100644
index 000000000000..7562fb6b8f61
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
+===========================================================
+
+MUCSE Gigabit Linux driver.
+Copyright (c) 2020 - 2025 MUCSE Co.,Ltd.
+
+Identifying Your Adapter
+========================
+The driver is compatible with devices based on the following:
+
+ * MUCSE(R) Ethernet Controller N500 series
+ * MUCSE(R) Ethernet Controller N210 series
+
+Support
+=======
+ If you have problems with the software or hardware, please contact our
+ customer support team via email at techsupport@mucse.com or check our
+ website at https://www.mucse.com/en/
diff --git a/MAINTAINERS b/MAINTAINERS
index 1bc1698bc5ae..da0d12e77ddc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17033,6 +17033,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.yaml
 F:	drivers/media/i2c/mt9v111.c
 
+MUCSE ETHERNET DRIVER
+M:	Yibo Dong <dong100@mucse.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://www.mucse.com/en/
+F:	Documentation/networking/device_drivers/ethernet/mucse/*
+F:	drivers/net/ethernet/mucse/*
+
 MULTIFUNCTION DEVICES (MFD)
 M:	Lee Jones <lee@kernel.org>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..77c55fa11942 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -202,5 +202,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
 source "drivers/net/ethernet/wiznet/Kconfig"
 source "drivers/net/ethernet/xilinx/Kconfig"
 source "drivers/net/ethernet/xircom/Kconfig"
+source "drivers/net/ethernet/mucse/Kconfig"
 
 endif # ETHERNET
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a..696825bd1211 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -107,3 +107,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
 obj-$(CONFIG_OA_TC6) += oa_tc6.o
+obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
diff --git a/drivers/net/ethernet/mucse/Kconfig b/drivers/net/ethernet/mucse/Kconfig
new file mode 100644
index 000000000000..be0fdf268484
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Mucse network device configuration
+#
+
+config NET_VENDOR_MUCSE
+	bool "Mucse devices"
+	default y
+	help
+	  If you have a network (Ethernet) card from Mucse(R), say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Mucse(R) cards. If you say Y, you will
+	  be asked for your specific card in the following questions.
+
+if NET_VENDOR_MUCSE
+
+config MGBE
+	tristate "Mucse(R) 1GbE PCI Express adapters support"
+	depends on PCI
+	select PAGE_POOL
+	help
+	  This driver supports Mucse(R) 1GbE PCI Express family of
+	  adapters.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called rnpgbe.
+
+endif # NET_VENDOR_MUCSE
+
diff --git a/drivers/net/ethernet/mucse/Makefile b/drivers/net/ethernet/mucse/Makefile
new file mode 100644
index 000000000000..f0bd79882488
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Mucse(R) network device drivers.
+#
+
+obj-$(CONFIG_MGBE) += rnpgbe/
+
diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
new file mode 100644
index 000000000000..0942e27f5913
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2020 - 2025 MUCSE Corporation.
+#
+# Makefile for the MUCSE(R) 1GbE PCI Express ethernet driver
+#
+
+obj-$(CONFIG_MGBE) += rnpgbe.o
+
+rnpgbe-objs := rnpgbe_main.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
new file mode 100644
index 000000000000..224e395d6be3
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_H
+#define _RNPGBE_H
+
+enum rnpgbe_boards {
+	board_n500,
+	board_n210,
+	board_n210L,
+};
+
+struct mucse {
+	struct net_device *netdev;
+	struct pci_dev *pdev;
+	/* board number */
+	u16 bd_number;
+
+	char name[60];
+};
+
+/* Device IDs */
+#ifndef PCI_VENDOR_ID_MUCSE
+#define PCI_VENDOR_ID_MUCSE 0x8848
+#endif /* PCI_VENDOR_ID_MUCSE */
+
+#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
+#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
+#define PCI_DEVICE_ID_N500_VF 0x8309
+#define PCI_DEVICE_ID_N210 0x8208
+#define PCI_DEVICE_ID_N210L 0x820a
+
+#endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
new file mode 100644
index 000000000000..13b49875006b
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/etherdevice.h>
+
+#include "rnpgbe.h"
+
+char rnpgbe_driver_name[] = "rnpgbe";
+
+/* rnpgbe_pci_tbl - PCI Device ID Table
+ *
+ * { PCI_DEVICE(Vendor ID, Device ID),
+ *   driver_data (used for different hw chip) }
+ */
+static struct pci_device_id rnpgbe_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_QUAD_PORT),
+	  .driver_data = board_n500},
+	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N500_DUAL_PORT),
+	  .driver_data = board_n500},
+	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210),
+	  .driver_data = board_n210},
+	{ PCI_DEVICE(PCI_VENDOR_ID_MUCSE, PCI_DEVICE_ID_N210L),
+	  .driver_data = board_n210L},
+	/* required last entry */
+	{0, },
+};
+
+/**
+ * rnpgbe_add_adapter - add netdev for this pci_dev
+ * @pdev: PCI device information structure
+ *
+ * rnpgbe_add_adapter initializes a netdev for this pci_dev
+ * structure. Initializes Bar map, private structure, and a
+ * hardware reset occur.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_add_adapter(struct pci_dev *pdev)
+{
+	struct mucse *mucse = NULL;
+	struct net_device *netdev;
+	static int bd_number;
+
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), 1);
+	if (!netdev)
+		return -ENOMEM;
+
+	mucse = netdev_priv(netdev);
+	mucse->netdev = netdev;
+	mucse->pdev = pdev;
+	mucse->bd_number = bd_number++;
+	snprintf(mucse->name, sizeof(netdev->name), "%s%d",
+		 rnpgbe_driver_name, mucse->bd_number);
+	pci_set_drvdata(pdev, mucse);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @id: entry in rnpgbe_pci_tbl
+ *
+ * rnpgbe_probe initializes a PF adapter identified by a pci_dev
+ * structure. The OS initialization, then call rnpgbe_add_adapter
+ * to initializes netdev.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int err;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	/* hw only support 56-bits dma mask */
+	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting\n");
+		goto err_dma;
+	}
+
+	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
+	if (err) {
+		dev_err(&pdev->dev,
+			"pci_request_selected_regions failed 0x%x\n", err);
+		goto err_pci_req;
+	}
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+	err = rnpgbe_add_adapter(pdev);
+	if (err)
+		goto err_regions;
+
+	return 0;
+err_regions:
+	pci_release_mem_regions(pdev);
+err_dma:
+err_pci_req:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * rnpgbe_rm_adapter - remove netdev for this mucse structure
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_rm_adapter remove a netdev for this mucse structure
+ **/
+static void rnpgbe_rm_adapter(struct mucse *mucse)
+{
+	struct net_device *netdev;
+
+	netdev = mucse->netdev;
+	free_netdev(netdev);
+}
+
+/**
+ * rnpgbe_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  This could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void rnpgbe_remove(struct pci_dev *pdev)
+{
+	struct mucse *mucse = pci_get_drvdata(pdev);
+
+	if (!mucse)
+		return;
+
+	rnpgbe_rm_adapter(mucse);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+/**
+ * rnpgbe_dev_shutdown - Device Shutdown Routine
+ * @pdev: PCI device information struct
+ * @enable_wake: wakeup status
+ **/
+static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
+				bool *enable_wake)
+{
+	struct mucse *mucse = pci_get_drvdata(pdev);
+	struct net_device *netdev = mucse->netdev;
+
+	*enable_wake = false;
+	netif_device_detach(netdev);
+	pci_disable_device(pdev);
+}
+
+/**
+ * rnpgbe_shutdown - Device Shutdown Routine
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_shutdown is called by the PCI subsystem to alert the driver
+ * that os shutdown. Device should setup wakeup state here.
+ **/
+static void rnpgbe_shutdown(struct pci_dev *pdev)
+{
+	bool wake = false;
+
+	rnpgbe_dev_shutdown(pdev, &wake);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pdev, wake);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+
+static struct pci_driver rnpgbe_driver = {
+	.name = rnpgbe_driver_name,
+	.id_table = rnpgbe_pci_tbl,
+	.probe = rnpgbe_probe,
+	.remove = rnpgbe_remove,
+	.shutdown = rnpgbe_shutdown,
+};
+
+/**
+ * rnpgbe_init_module - driver init routine
+ *
+ * rnpgbe_init_module is called when driver insmod
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int __init rnpgbe_init_module(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&rnpgbe_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+module_init(rnpgbe_init_module);
+
+/**
+ * rnpgbe_exit_module - driver remove routine
+ *
+ * rnpgbe_exit_module is called when driver is removed
+ **/
+static void __exit rnpgbe_exit_module(void)
+{
+	pci_unregister_driver(&rnpgbe_driver);
+}
+
+module_exit(rnpgbe_exit_module);
+
+MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
+MODULE_AUTHOR("Mucse Corporation, <mucse@mucse.com>");
+MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



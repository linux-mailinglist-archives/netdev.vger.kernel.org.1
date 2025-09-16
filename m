Return-Path: <netdev+bounces-223490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EEAB5952C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2733448598B
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD92D8797;
	Tue, 16 Sep 2025 11:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132842D7DCE;
	Tue, 16 Sep 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022250; cv=none; b=TyHzOb++/DphaTLh3Lt4r0q7mnkXBvVIqh69KgjNq62UL5GWTjrBQHzANqPzrHEOyAK5nN6r5JGlhm5KGCktIS8mhoYMAdbQQyPhzMewsxu3g2gLBxPCtWxYOZpheUkrA7ErGi/jFzZy2pbppBfxoGr3ngWT6Ri5PX6pL7qNrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022250; c=relaxed/simple;
	bh=bUkNPlsJOvnErhVEFTODmhkURuVkv4kjM1Pc/ER0Oc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkEiudUdQGDagSdvhIHh0L3FVw2oY9ttbLqjuccVLUKXQwox6cLo3yO+jJA4zPuwfabnQkNd0NHRCiFQOzg+uXZWMaaZLJWr+qoiLzh78dv68njhFeK/70qgrVWm07Kmz/ZfviPAyOAkjQ64fG2KShhVBska3ddkWqJDev6cdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1758022212td68af9b6
X-QQ-Originating-IP: DeHNHRu61lRPCqCMkzyR6Zmz+lMP+CmbFg5BzNeqAn4=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 19:30:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15780655444721561935
EX-QQ-RecipientCnt: 30
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
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev,
	joerg@jo-so.de
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v12 1/5] net: rnpgbe: Add build support for rnpgbe
Date: Tue, 16 Sep 2025 19:29:48 +0800
Message-Id: <20250916112952.26032-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250916112952.26032-1-dong100@mucse.com>
References: <20250916112952.26032-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NNy5VkfPTUBBuNNmxhriBz3o3Rr1bZLODHtjF3W1AWtlCENMshpEwtAP
	HLgYOr6H+53DeDbzPHV69nQaPfl8qeF93fXtORoFIAwqO3RJ2WQwvmXDEsu/x4HHGwOJGXH
	/Pn1MtSpVm2539+EAA/U+uzExtgfr7aZg2gSqNh70f0kCQwf3pY5Pn1+HUA/WxFgU38ahvM
	X5UNUSHyPuJh99jdSLOXNOSGAh4bc0rf3VaQoLFj2SdVTjHvc+ytopTI2L4TV6KpvDpClMh
	fO+tK7CKyU9Q8b5rEyCN63kL79tEuiVP81lsZCbsfM0/x0g1U3Zv00bgNwou6gB0E1LNsEV
	hrpEW5r7BlELWI90+UDbCH+keTljeLqikyZzOLATU1Iqa8TgLTHbuvRGDFOAVy+sJn/vkW0
	syTCf1H3T2S2Wu0DpOgkIVmbFRogqM9fJqQfEQCb64csA2SdDMJQMTxnyMj5xvVe1wMZnhF
	ef0zUpKMpdWBN9SptAzivMVvu1Vc00FhNyif8tfI0FNZgiHkoadzaW1NYb2JvvMt4IDAmHg
	Vq8jhq3q6osZ/TGBRlJdZLjuqTyL8kvDUPgJ/uecysi8MxAzgEyQ18Wi3l6SFfaDxDhrsLd
	JWDlw4x5ii6l47zFh6/oxhHPqkJShNsf22spKQ46GdhKq0YxWhnnbrlhbzx+lRdOibeA6HS
	SlN5XrVO5Sp6fSy7eAmMWCt9IKvHGYXZNzT40mYioyarFv+gTX/r1Zl8qenoxW1ilWTc2zN
	SdoEUkq2okgmdhw0U7drBlP/3P11X5//ag59JZmfhL58OyEh16dzpaEU9F11LF0gwLpdpzW
	WwAyQ43wIFa4UxnYPrEnfAQ79EfGBArb4tGP5bDmblbH/54T8aS43KrQBoNBnHQt87lPVK4
	xGlAH7uwztt4m+f3Hga37SZFPUeLqz5zshx7IAn4VsAO3N16fuLwq/Aczom8/N2U1y/XcJv
	dVYPEQ6IoMcQcFuNut6KwAwyyaN6WIKbkat6NV/Q2pa2T6qxZGqd5k+t5J0x0rw+myrh+k+
	uE+XDizI3vlb7Q3K43QRZxFNREQEEsw3gVAxrYn8HM30EYS5x9VGuAch49JOM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Add build options and doc for mucse.
Initialize pci device access for MUCSE devices.

Signed-off-by: Dong Yibo <dong100@mucse.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
 MAINTAINERS                                   |   8 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 +++++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 ++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  18 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 124 ++++++++++++++++++
 10 files changed, 223 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 0b0a3eef6aae..41ff2152b7aa 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -47,6 +47,7 @@ Contents:
    mellanox/mlx5/index
    meta/fbnic
    microsoft/netvsc
+   mucse/rnpgbe
    neterion/s2io
    netronome/nfp
    pensando/ionic
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
index 47bc35743f22..6c1ed4d493eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17304,6 +17304,14 @@ T:	git git://linuxtv.org/media.git
 F:	Documentation/devicetree/bindings/media/i2c/aptina,mt9v111.yaml
 F:	drivers/media/i2c/mt9v111.c
 
+MUCSE ETHERNET DRIVER
+M:	Yibo Dong <dong100@mucse.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://www.mucse.com/en/
+F:	Documentation/networking/device_drivers/ethernet/mucse/
+F:	drivers/net/ethernet/mucse/
+
 MULTIFUNCTION DEVICES (MFD)
 M:	Lee Jones <lee@kernel.org>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index f86d4557d8d7..167388f9c744 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -129,6 +129,7 @@ source "drivers/net/ethernet/microchip/Kconfig"
 source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/microsoft/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
+source "drivers/net/ethernet/mucse/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
 config FEALNX
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 67182339469a..1b8c4df3f594 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
 obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
 obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
+obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
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
index 000000000000..675173fa05f7
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2020 - 2025 MUCSE Corporation.
+#
+# Makefile for the MUCSE(R) network device drivers
+#
+
+obj-$(CONFIG_MGBE) += rnpgbe/
diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
new file mode 100644
index 000000000000..9df536f0d04c
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2020 - 2025 MUCSE Corporation.
+#
+# Makefile for the MUCSE(R) 1GbE PCI Express ethernet driver
+#
+
+obj-$(CONFIG_MGBE) += rnpgbe.o
+rnpgbe-objs := rnpgbe_main.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
new file mode 100644
index 000000000000..3c37fe2534a8
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_H
+#define _RNPGBE_H
+
+enum rnpgbe_boards {
+	board_n500,
+	board_n210
+};
+
+/* Device IDs */
+#define PCI_VENDOR_ID_MUCSE 0x8848
+#define PCI_DEVICE_ID_N500_QUAD_PORT 0x8308
+#define PCI_DEVICE_ID_N500_DUAL_PORT 0x8318
+#define PCI_DEVICE_ID_N210 0x8208
+#define PCI_DEVICE_ID_N210L 0x820a
+#endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
new file mode 100644
index 000000000000..60bbc806f17b
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/pci.h>
+
+#include "rnpgbe.h"
+
+static const char rnpgbe_driver_name[] = "rnpgbe";
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
+	  .driver_data = board_n210},
+	/* required last entry */
+	{0, },
+};
+
+/**
+ * rnpgbe_probe - Device initialization routine
+ * @pdev: PCI device information struct
+ * @id: entry in rnpgbe_pci_tbl
+ *
+ * rnpgbe_probe initializes a PF adapter identified by a pci_dev
+ * structure.
+ *
+ * Return: 0 on success, negative errno on failure
+ **/
+static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int err;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting %d\n", err);
+		goto err_disable_dev;
+	}
+
+	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
+	if (err) {
+		dev_err(&pdev->dev,
+			"pci_request_selected_regions failed %d\n", err);
+		goto err_disable_dev;
+	}
+
+	pci_set_master(pdev);
+	err = pci_save_state(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "pci_save_state failed %d\n", err);
+		goto err_free_regions;
+	}
+
+	return 0;
+err_free_regions:
+	pci_release_mem_regions(pdev);
+err_disable_dev:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * rnpgbe_remove - Device removal routine
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device. This could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void rnpgbe_remove(struct pci_dev *pdev)
+{
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+/**
+ * rnpgbe_dev_shutdown - Device shutdown routine
+ * @pdev: PCI device information struct
+ **/
+static void rnpgbe_dev_shutdown(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+}
+
+/**
+ * rnpgbe_shutdown - Device shutdown routine
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_shutdown is called by the PCI subsystem to alert the driver
+ * that os shutdown. Device should setup wakeup state here.
+ **/
+static void rnpgbe_shutdown(struct pci_dev *pdev)
+{
+	rnpgbe_dev_shutdown(pdev);
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
+module_pci_driver(rnpgbe_driver);
+
+MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
+MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
+MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



Return-Path: <netdev+bounces-233068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E9C0BBF6
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 04:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DB93BB634
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73272D4B5F;
	Mon, 27 Oct 2025 03:29:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB1237713;
	Mon, 27 Oct 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535787; cv=none; b=m8f8Icn+AC1agCbyn8C/m3IlQ9wNj64XmfSxQm6VnxPt1S4qFLWo6hABS7Awy30Y8U9+r1QUcl3+T9i3okANz6yFQuzrTAWoyAmyWL8WvWVpcKIS6mSp6GTdlfDUlZfxaiD6o+iLwiNY7gs5R6mW2E6zjLzuhHS3SROyfgZSglo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535787; c=relaxed/simple;
	bh=s94wgftHHLdCCqBt8p0CT7z0kYG8G/poJcfpk8PhiCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qOz+io8S0Wu2pbKuxVcFDcafF1GvVR0cOVloqNJ+VTUTHTYG41Ea5KeCHPK1HOEHb4z0WcVZG94ifXSqjvJakxwd3hbfkhfN+lOwdifPJL9trJBgrBPMQtKyR8S5rFSgGKW4OHKbIY4mGCNgpudWYW9Ctc9nhs7qgVdratep7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1761535760tbe4b2652
X-QQ-Originating-IP: 2U6VLtkFgD0itdMwQjSAXM4ffl6BG35oWQ/l/4CJgDM=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:29:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11898396523500879523
EX-QQ-RecipientCnt: 18
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v16 1/5] net: rnpgbe: Add build support for rnpgbe
Date: Mon, 27 Oct 2025 11:29:01 +0800
Message-Id: <20251027032905.94147-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251027032905.94147-1-dong100@mucse.com>
References: <20251027032905.94147-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NZDNqKQfev+zCBNfaJAkkuPBnMf7dXSA6ysYmZjDB/vrcrvgyEbUF4+8
	rg8u0moyi2NvaYCETh6UZs+azjlWwhaVCotPz7/AR8hP9wHwjmbYMaJ0L+H+yLBC2Y2inif
	gCDPjAE5ALpqzAFsk2sSZ/LrqnCXZ+c2dU47tWe2TijyeQOW3n5DScDSmZwvmNJBRmu14QK
	l0uLzADMNHU3+GgCg0yp8V7DRv+Wo07pE0bNNDTi9cI3Wf1NYCL2flEjVqliOMgACN0t+04
	BChF9uUj18zpD8PD0Ze463ZhNaKJ1MEHGKDOAejHcXC5IUkR+Lrtp5YQzMUc/CRKlTZ9R9m
	HWvBD8f6gHwRJX3B4QlB/7+80KVCGQ6EdjCtya+mD8vCbYgLqupFUK5ciqt7NWPREjVD24c
	kYiMhDLwIudSdrofS5d3fqICzr0iiARnTtp6ES3VlXopUxBJ3Coj+ft4/1oEs7gS1wLdaaR
	lc98gfhuh7sBKgTHLkuMRNZQ5SvH3VbUmFJtpXZc7NFXBO99kgbNxM7lPqEyPFQEXPOrCzP
	aWOwMZaVSHem+4I59fZpQW5f8TpNSVrm7bOyRXRPFh1IP6so1Yj7BA8/tDfopa1+noY82Bi
	39kWSWjMHcfaLG+0Mjs/dAdGiui6w3QhLox/EtWUz2iASkHx4jFzcO2D3CV3dAkcCSVEkGi
	8Ra/1pS8RDZr107/cj/izJ09o+0dU//NkGACW9cCvvads9fScdOUaRbdYwFE3XXglEtw8+L
	rk9vV3FnGeif8FeQg3R+vv67SMVMqcABbLYnvlg04+FoS2KsKbGCtQ/1VMzXfuS717tTEgx
	B+fMJ4F7++NDfUEUeoEMYclnHIa1bKUpPHK2atc5wiECxekDJsdZtTkEU+PAG9spZOjtWuu
	F2RK994M7ybZBVfBF56VTcPswAyXeNqoiZGfFF4PwTrc6+gIxTN7Qs253Hjxgu0rV0naKj/
	lbwhM8IpzAup3XnbvgKM+cA6M5MnZVCc7vOTxwhlkK/8Jc5ZDIu+EQ1V75yHvLBc2vPatvH
	MY2DuTVlWLbf13RBtM4XXegdOR8H0=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Add build options and doc for mucse.
Initialize pci device access for MUCSE devices.

Signed-off-by: Dong Yibo <dong100@mucse.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  17 +++
 MAINTAINERS                                   |   8 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  33 +++++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 ++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  18 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 120 ++++++++++++++++++
 10 files changed, 214 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 7cfcd183054f..bcc02355f828 100644
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
index 000000000000..d35cf8a46b6c
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Linux Base Driver for MUCSE(R) Gigabit PCI Express Adapters
+===========================================================
+
+Contents
+========
+
+- Identifying Your Adapter
+
+Identifying Your Adapter
+========================
+The driver is compatible with devices based on the following:
+
+ * MUCSE(R) Ethernet Controller N210 series
+ * MUCSE(R) Ethernet Controller N500 series
diff --git a/MAINTAINERS b/MAINTAINERS
index d652f4f27756..395145b37d75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17600,6 +17600,14 @@ T:	git git://linuxtv.org/media.git
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
index aead145dd91d..4a1b368ca7e6 100644
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
index 998dd628b202..2e18df8ca8ec 100644
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
index 000000000000..0b3e853d625f
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -0,0 +1,33 @@
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
index 000000000000..d3439d28c654
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
+#define PCI_VENDOR_ID_MUCSE               0x8848
+#define RNPGBE_DEVICE_ID_N500_QUAD_PORT   0x8308
+#define RNPGBE_DEVICE_ID_N500_DUAL_PORT   0x8318
+#define RNPGBE_DEVICE_ID_N210             0x8208
+#define RNPGBE_DEVICE_ID_N210L            0x820a
+#endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
new file mode 100644
index 000000000000..019e819fb497
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -0,0 +1,120 @@
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
+ * { PCI_VDEVICE(Vendor ID, Device ID),
+ *   private_data (used for different hw chip) }
+ */
+static struct pci_device_id rnpgbe_pci_tbl[] = {
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210), board_n210 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N210L), board_n210 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_DUAL_PORT), board_n500 },
+	{ PCI_VDEVICE(MUCSE, RNPGBE_DEVICE_ID_N500_QUAD_PORT), board_n500 },
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
+	.name     = rnpgbe_driver_name,
+	.id_table = rnpgbe_pci_tbl,
+	.probe    = rnpgbe_probe,
+	.remove   = rnpgbe_remove,
+	.shutdown = rnpgbe_shutdown,
+};
+
+module_pci_driver(rnpgbe_driver);
+
+MODULE_DEVICE_TABLE(pci, rnpgbe_pci_tbl);
+MODULE_AUTHOR("Yibo Dong, <dong100@mucse.com>");
+MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



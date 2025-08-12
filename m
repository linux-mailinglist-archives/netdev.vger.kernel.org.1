Return-Path: <netdev+bounces-212833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0432B2236D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9596D16FE13
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D9A2E9728;
	Tue, 12 Aug 2025 09:41:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B82E282D;
	Tue, 12 Aug 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991663; cv=none; b=YIlhuO3Ld49xbZZ5wGTAkQdoMjdaXKBRmKsCBlEW32XSnBp0diLSNoPF17xc68+CSSWCTDQaCMrmBVw6BHT/5w2YZDfELYM7dO0CR6yt0H+nl74Ad83doPz1XNBHD/1FivXLmkJxXGzrOvP+j8uB8f8j7DgYYcNTc75PKr3QeIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991663; c=relaxed/simple;
	bh=WR9qgg4NBNxEK3bPTeaTds9rxlQwCRfBWU9ox0C7rr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oxOpLbSLJlKhuB1uEkOvHotpmyzHjH3UqN3r3LDLU5xm0Byz7F2jygEnrwNUxjUiEGBSMhIvAf6OpP9pWkBpDp9413fwQ51+9IljLcKhLFCRdmdSCu5Ex9mm6SdJNZKvWspoAI4Oz7nL/IVa8y6kaKSBjc/bR2SFNi1gmCuoVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz7t1754991601t49e25905
X-QQ-Originating-IP: MGTHXkBTR0UtwuqChWnYE1GYPwVpSOAvYFcyoI1kuPY=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 Aug 2025 17:39:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10315789176230566131
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
Subject: [PATCH v3 1/5] net: rnpgbe: Add build support for rnpgbe
Date: Tue, 12 Aug 2025 17:39:33 +0800
Message-Id: <20250812093937.882045-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250812093937.882045-1-dong100@mucse.com>
References: <20250812093937.882045-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MzOrCbSXFQdfH1V97x6ZR4HNpDgs8uKaHGqxjhdXtCmFp/ryrMShdi7M
	GV33za1Hix7KvqKVREOWv7zhxemJnXg6702JMmziqsdQc+jGlHMRVjmDw29wisT8Vpv45aG
	Eqq/J8nV3NNIbQUwJMx69aIVLI665y10ZjSHwqBLUzr2NOF6szXwdBiwU0maPSxBzwu7kgk
	SxNEmRFJlWvs3YUQmxeol2Xypm176Ch1ZceyR0wkwaAxIlKXYKE0KEVFPuQNyqKtDH0UhiH
	Uew2fbsriQ9uR4UzafASkOatLkoARwUKT0FD9xdpXknix5WQ7cQaWTakZUQtGVW9Ik5xosy
	aBdJw54Hx7PDRYJPHsMkCk6IBRsTMQWnTuKL8xxAiaiiiUqHFdmphLVvHn3rPDQLgiIm/KE
	gXw6i1hJxgaMJULD9rjDW1hQ8a5OKifhgbyudjV2AVllk6ffDxHstlfsjwFiyQqx4YsX8Yn
	plIylROG3NF8HNaCH4Hjfv9xfufb7Q9u7fPBxAASI2GHZWPkoRNiUTg38O6pMsDSHASz1Mw
	b48faHHAeRNc7ObH3wWNePqs07gZ88FqcMn1541gqZl5smgwpEj5r10mdNfNqwRi95LKPAk
	Nzpx0OXv8FDDiv7dLfxLQ4T/+VrDQwueigRkW9ayaknWwXvTDRieMApbGN6JlqcqJhb7Oaz
	Grv2nlmfEeauEZlfNSIDQAFY3AeU63fNi5spwTNieXOEkbgr+DePAORO+p/lXHNgTkvt38X
	IT/K5ZIjX+hBqsbTGzrXY/nFPDwGaJBAps8zEtA2VOYOUU80pBjh9AoqSa+21YNBoaCD5GM
	iUka69S9ybF3fSfE0xc7CtwZAl/T1rA+g3iWoZ1qmasEOhDtDtFwrrbv1gsuQRwAywtuo6r
	KEZDFndsi+N/p4+Grv8RqXhdt6kHdAdadKFgZ9sy0EHMA5+tv8kwyrYugDGV1xlOEkoGwTY
	TEpuvaKVBEOYHtlxooQbYhASr/ZPsCjhCQi68n1ZVRpwyyiofWnYHbnjr/uowztDPEhox9u
	vVKE7MPSUlBETOnza3lS2XAjzmrUnQ7NHoL4tj0Q+SdSFhVOt2VLfJi3Z4A9IiWkRh7AxvB
	5hZczg0+SEUWsLt5n2lLxx1ta/fxql80a1g405z5mcwux5Yz+vtRiI=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add build options and doc for mucse.
Initialize pci device access for MUCSE devices.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +++
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   8 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  25 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 161 ++++++++++++++++++
 10 files changed, 267 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 40ac552641a3..c8abadbe15ee 100644
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
index bd62ad58a47f..80c1ae2ae26c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17278,6 +17278,14 @@ T:	git git://linuxtv.org/media.git
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
index 000000000000..835771a5c374
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2020 - 2025 MUCSE Corporation.
+#
+# Makefile for the MUCSE(R) 1GbE PCI Express ethernet driver
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
index 000000000000..23c84454e7c7
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -0,0 +1,25 @@
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
+	u16 bd_number;
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
index 000000000000..c2e099bd2639
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include <linux/types.h>
+#include <linux/module.h>
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
+	  .driver_data = board_n210L},
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
+	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting %d\n", err);
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
+
+	return 0;
+err_dma:
+err_pci_req:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * rnpgbe_remove - Device removal routine
+ * @pdev: PCI device information struct
+ *
+ * rnpgbe_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  This could be caused by a
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
+ * @enable_wake: wakeup status
+ **/
+static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
+				bool *enable_wake)
+{
+	*enable_wake = false;
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
+	bool wake;
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
+ * rnpgbe_init_module - Driver init routine
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
+ * rnpgbe_exit_module - Driver remove routine
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
+MODULE_AUTHOR("Mucse Corporation, <techsupport@mucse.com>");
+MODULE_DESCRIPTION("Mucse(R) 1 Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1



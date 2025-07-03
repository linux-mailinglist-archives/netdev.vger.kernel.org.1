Return-Path: <netdev+bounces-203576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548ABAF676B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CD4B7B6882
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DE121A449;
	Thu,  3 Jul 2025 01:51:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBC1DE3A8;
	Thu,  3 Jul 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507476; cv=none; b=WJAChONdeRk5WByC9T2XBEHulw165IVIJ3YZUU4vcBI6zC3sHDlZXF3hg6xvir55F1uRFusRZZaRt6rafBk0VodH7t/AFh/AsoEGE2Wi3CJa+AG+diXsHxYYtqyob0KM8kwnfvB+b7s5YHbtlSzZuGbKCY6D+mVHExm/UFYKHr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507476; c=relaxed/simple;
	bh=GDBVF8MbBKihHLAEADIj6Yzy4W/NWhpQ/T+e33mdqj0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnyNf4sE+XnvS9+AYm151ipoX4yfErKFkfwK6bJSGpF26Yvgl8DYcOSKVphC2pM355WQgx3kCVjWw5iDN1zvByu7Tx/jiU/L7S4mDfVBUP2es887fKPIeY+vDm5xWdOFAUsnSOS3Lr/jl55ch3xWiCXi7RIqf4BPvBW8c/Kdwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507364t9f52d5e6
X-QQ-Originating-IP: 3WdHkXG3DVFWUdOPnJvBMmcdSR+BRgxfgU/F3IOkH2o=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15554768658210106800
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
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
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 01/15] net: rnpgbe: Add build support for rnpgbe
Date: Thu,  3 Jul 2025 09:48:45 +0800
Message-Id: <20250703014859.210110-2-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N76rkG23tQ5KZRRkwnBTeLkjOVm7NPdia357h369/D5SfMX8o6yAHcZr
	TkF6qllkVUKh+wlwQPVS7al/1B81AtulHlWoiK88NgwMTwxn12rAdLv4G70SWdZQGT6Rm+2
	CVUhQSZ6FDUFEdMPbQgEeUrjAf8Dsg3/aEaxGLq3FLTzMxAIq1fTGAfsHb4X35CsxE+55Xx
	Pm+Fe6bX3DRLugIlmUJgPbEf6yoCud2ubs6uaAfbBrsNGcdFw3yp/5qo873C5uMnS3xcI/W
	Xnb9pNugmtqiFa3z+Efi2/cuzED4jFy9ABvVDTj+3kQ6LQ7ihHfPAGLq/EDPq7UHRJMQAYt
	xnSaMPB90ZeBSSqr9Wme0FAQCXUEa3ByXTLMl2h3e7EjJGT4lSQyY0C5NQ209xpoF21e7aW
	Y6Lc9ZfTqvLl8ucyftO8/6sivUq25dVe0u/Czbf6H9qCJQmRN1nLgEa8lwszvaEL4qZuBn2
	67zgATlVhrqfdbhlM9AB8fe9i8Y1jnq7s+OPhymgqAembjn9bx1Dd1t70w5dkclJgda38zT
	Qhgj9tjkH3vlFIoYLrdj/5MkAxWH9QTKHzk/Xc+pzjym2FZscKMjxsOKx1grnSRRUl29MPh
	O7eARIXsC9hqy8iAdEWJmwKSWwBHX7ZSJ01RT+uJBTVGPFBYdi50eTRsSW+RMK1IAUyM1Hd
	/+55+Sjens7W8QnraxAenvYxh18pEUL+9gcKBkBxi1OfiXRrOB0hIGhcoTmVYV3lBXMqURX
	GZ7PnivpCyPekIHZdFkpNW5pNRJ0NKDgZ8cYcYpwhS/3jR78lOn6tQ7+Zpi0lHTP+NKAPHm
	j62ZNR9ckhVc5oIn1fdHDL+ISTigjQBBuJEtl1SO0/EosDkjtKUYPbTd/QeFP3eD7Ljugan
	3qeBpmmbSEucFMLm/p84g+hXbW18prpv0uxNK+x3pfU92oZKC9Uiriy+uuHfZEm+hZSQKyj
	9W201WJR5vPv7JEJPOoKSRxig3QUDldmkBxxSVl+Ol4hygu6KSsBhoo+syuzDde3BEDETqW
	Q66q3Ii6v1+myIFzNZ/K+sGxr5k09BgoKBht+gyhiAOTGCn3jKZ/C0l1XIrP6I6+zbO7D9M
	Z0jvnOL2+1O
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

Add build options and doc for mucse.
Initialize pci device access for MUCSE devices.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 ++
 MAINTAINERS                                   |  14 +-
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  35 +++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   9 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  35 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 221 ++++++++++++++++++
 10 files changed, 340 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 139b4c75a191..f6db071210d9 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -59,6 +59,7 @@ Contents:
    ti/icssg_prueth
    wangxun/txgbe
    wangxun/ngbe
+   mucse/rnpgbe
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst b/Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
new file mode 100644
index 000000000000..5f0f338dc3d4
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
+ customer support team via email at marketing@mucse.com or check our website
+ at https://www.mucse.com/en/
diff --git a/MAINTAINERS b/MAINTAINERS
index bb9df569a3ff..b43ca711cc5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16001,11 +16001,7 @@ F:	tools/testing/vma/
 
 MEMORY MAPPING - LOCKING
 M:	Andrew Morton <akpm@linux-foundation.org>
-M:	Suren Baghdasaryan <surenb@google.com>
-M:	Liam R. Howlett <Liam.Howlett@oracle.com>
-M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
-R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Shakeel Butt <shakeel.butt@linux.dev>
+M:	Suren Baghdasaryan <surenb@google.com> M:	Liam R. Howlett <Liam.Howlett@oracle.com> M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com> R:	Vlastimil Babka <vbabka@suse.cz> R:	Shakeel Butt <shakeel.butt@linux.dev>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
@@ -16986,6 +16982,14 @@ T:	git git://linuxtv.org/media.git
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
index 000000000000..5825b37fcd50
--- /dev/null
+++ b/drivers/net/ethernet/mucse/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Mucse network device configuration
+#
+
+config NET_VENDOR_MUCSE
+        bool "Mucse devices"
+        default y
+        help
+          If you have a network (Ethernet) card belonging to this class, say Y.
+
+          Note that the answer to this question doesn't directly affect the
+          kernel: saying N will just cause the configurator to skip all
+          the questions about Mucse cards. If you say Y, you will be asked for
+          your specific card in the following questions.
+
+
+if NET_VENDOR_MUCSE
+
+config MGBE
+	tristate "Mucse(R) 1GbE PCI Express adapters support"
+        depends on PCI
+	select PAGE_POOL
+        help
+          This driver supports Mucse(R) 1GbE PCI Express family of
+          adapters.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst>.
+
+          To compile this driver as a module, choose M here. The module
+          will be called rnpgbe.
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
index 000000000000..a44e6b6255d8
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_H
+#define _RNPGBE_H
+
+#define RNPGBE_MAX_QUEUES (8)
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
index 000000000000..b32b70c98b46
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -0,0 +1,221 @@
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
+static const char rnpgbe_driver_string[] =
+	"mucse 1 Gigabit PCI Express Network Driver";
+#define DRV_VERSION "1.0.0"
+const char rnpgbe_driver_version[] = DRV_VERSION;
+static const char rnpgbe_copyright[] =
+	"Copyright (c) 2020-2025 mucse Corporation.";
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
+ * rnpgbe_add_adpater - add netdev for this pci_dev
+ * @pdev: PCI device information structure
+ *
+ * rnpgbe_add_adpater initializes a netdev for this pci_dev
+ * structure. Initializes Bar map, private structure, and a
+ * hardware reset occur.
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int rnpgbe_add_adpater(struct pci_dev *pdev)
+{
+	struct mucse *mucse = NULL;
+	struct net_device *netdev;
+	static int bd_number;
+
+	pr_info("====  add rnpgbe queues:%d ====", RNPGBE_MAX_QUEUES);
+	netdev = alloc_etherdev_mq(sizeof(struct mucse), RNPGBE_MAX_QUEUES);
+	if (!netdev)
+		return -ENOMEM;
+
+	mucse = netdev_priv(netdev);
+	memset((char *)mucse, 0x00, sizeof(struct mucse));
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
+ * structure. The OS initialization, then call rnpgbe_add_adpater
+ * to initializes netdev.
+ *
+ * Returns 0 on success, negative on failure
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
+	err = rnpgbe_add_adpater(pdev);
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
+ * rnpgbe_rm_adpater - remove netdev for this mucse structure
+ * @mucse: pointer to private structure
+ *
+ * rnpgbe_rm_adpater remove a netdev for this mucse structure
+ **/
+static void rnpgbe_rm_adpater(struct mucse *mucse)
+{
+	struct net_device *netdev;
+
+	netdev = mucse->netdev;
+	pr_info("= remove rnpgbe:%s =\n", netdev->name);
+	free_netdev(netdev);
+	pr_info("remove complete\n");
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
+	rnpgbe_rm_adpater(mucse);
+	pci_release_mem_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static void __rnpgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
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
+	__rnpgbe_shutdown(pdev, &wake);
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
+static int __init rnpgbe_init_module(void)
+{
+	int ret;
+
+	pr_info("%s - version %s\n", rnpgbe_driver_string,
+		rnpgbe_driver_version);
+	pr_info("%s\n", rnpgbe_copyright);
+	ret = pci_register_driver(&rnpgbe_driver);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+module_init(rnpgbe_init_module);
+
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



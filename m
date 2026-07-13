Return-Path: <netdev+bounces-307201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rm1mDST1VGruhwAAu9opvQ
	(envelope-from <netdev+bounces-307201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:24:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3CD74C595
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:24:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307201-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307201-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=zte.com.cn (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F49D301FB2F
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD213F39E0;
	Mon, 13 Jul 2026 14:24:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5B42DFF5;
	Mon, 13 Jul 2026 14:24:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952673; cv=none; b=DR32rXTr/LCZ3AISpBR7KgX2ySYFnrd2oOFMQWdS2sr09fy+kZMXTQiVHrz5zAD5Y00DfqCJlFJ+c+tSAE8NwWoAZPEDrVaZQw3JLHg/sRvIh4vOuMEqCtz1xy3Eq+1qUfpdBwkgeu3cPhQdzvlxqJ40O0brS3gjYBxwNfzFs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952673; c=relaxed/simple;
	bh=H3L4rNnMrD8rzF2GXNgaIBbAI5A/HNXlt/muugjeUmw=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=O4A02giuq46NMzu1TbyQI543Mz+Vd2pDcC5al5JgqUMit1m/K2s3rr5zLxOMHytnNuGfVj37gyujW+p4YZNT4cZRDEvLJLQ+Cmy4gcx8YahdjgU5e0s7+g/WxxR3vPnsj4+peINp4kaAW+ar01QoY/+nw4Fr6y6uBwgIV29xFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gzPp43pPdz8XrrM;
	Mon, 13 Jul 2026 22:24:28 +0800 (CST)
Received: from njy2app04.zte.com.cn ([10.40.12.64])
	by mse-fl2.zte.com.cn with SMTP id 66DEOH6G070752;
	Mon, 13 Jul 2026 22:24:17 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 13 Jul 2026 22:24:20 +0800 (CST)
X-Zmail-TransId: 2aff6a54f51474f-c1cf1
X-Mailer: Zmail v1.0
Message-ID: <20260713222420704lmwNL8xT8mgOhTKbqAfRX@zte.com.cn>
In-Reply-To: <202607132221104795CMBHxJGy8iTj3qc36Qw6@zte.com.cn>
References: 202607132221104795CMBHxJGy8iTj3qc36Qw6@zte.com.cn
Date: Mon, 13 Jul 2026 22:24:20 +0800 (CST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <han.junyang@zte.com.cn>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <han.junyang@zte.com.cn>, <ran.ming@zte.com.cn>,
        <han.chengfei@zte.com.cn>, <zhang.yanze@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY4IDEvMl0gZGluZ2hhaTogYWRkIFpURSBuZXR3b3JrIGRyaXZlciBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66DEOH6G070752
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 13 Jul 2026 22:24:28 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A54F51C.000/4gzPp43pPdz8XrrM
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	SUBJ_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307201-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:han.junyang@zte.com.cn,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C3CD74C595

From: Junyang Han <han.junyang@zte.com.cn>

Add basic framework for ZTE DingHai ethernet PF driver, including
Kconfig/Makefile build support and PCIe device probe/remove skeleton.

Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
---
 MAINTAINERS                               |   6 +
 drivers/net/ethernet/Kconfig              |   1 +
 drivers/net/ethernet/Makefile             |   1 +
 drivers/net/ethernet/zte/Kconfig          |  20 +++
 drivers/net/ethernet/zte/Makefile         |   6 +
 drivers/net/ethernet/zte/dinghai/Kconfig  |  34 ++++
 drivers/net/ethernet/zte/dinghai/Makefile |  10 ++
 drivers/net/ethernet/zte/dinghai/en_pf.c  | 195 ++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h  |  52 ++++++
 9 files changed, 325 insertions(+)
 create mode 100644 drivers/net/ethernet/zte/Kconfig
 create mode 100644 drivers/net/ethernet/zte/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
 create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
 create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..73692b09bf7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29440,6 +29440,12 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 F:	sound/hda/codecs/senarytech.c

+ZTE DINGHAI ETHERNET DRIVER
+M:	Junyang Han <han.junyang@zte.com.cn>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/zte/
+
 THE REST
 M:	Linus Torvalds <torvalds@linux-foundation.org>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index b8f70e2a1763..c2b6996b0cfe 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -188,5 +188,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
 source "drivers/net/ethernet/wiznet/Kconfig"
 source "drivers/net/ethernet/xilinx/Kconfig"
 source "drivers/net/ethernet/xircom/Kconfig"
+source "drivers/net/ethernet/zte/Kconfig"

 endif # ETHERNET
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 57344fec6ce0..a34bcbd4df4e 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -104,3 +104,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
 obj-$(CONFIG_OA_TC6) += oa_tc6.o
+obj-$(CONFIG_NET_VENDOR_ZTE) += zte/
diff --git a/drivers/net/ethernet/zte/Kconfig b/drivers/net/ethernet/zte/Kconfig
new file mode 100644
index 000000000000..b95c2fc7db77
--- /dev/null
+++ b/drivers/net/ethernet/zte/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ZTE driver configuration
+#
+
+config NET_VENDOR_ZTE
+    bool "ZTE devices"
+    default y
+    help
+      If you have a network (Ethernet) card belonging to this class, say Y.
+      Note that the answer to this question doesn't directly affect the
+      kernel: saying N will just cause the configurator to skip all
+      the questions about Zte cards. If you say Y, you will be asked
+      for your specific card in the following questions.
+
+if NET_VENDOR_ZTE
+
+source "drivers/net/ethernet/zte/dinghai/Kconfig"
+
+endif # NET_VENDOR_ZTE
diff --git a/drivers/net/ethernet/zte/Makefile b/drivers/net/ethernet/zte/Makefile
new file mode 100644
index 000000000000..cd9929b61559
--- /dev/null
+++ b/drivers/net/ethernet/zte/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the ZTE device drivers
+#
+
+obj-$(CONFIG_DINGHAI) += dinghai/
diff --git a/drivers/net/ethernet/zte/dinghai/Kconfig b/drivers/net/ethernet/zte/dinghai/Kconfig
new file mode 100644
index 000000000000..121be3bf7707
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ZTE DingHai Ethernet driver configuration
+#
+
+config DINGHAI
+    bool "ZTE DingHai Ethernet driver"
+    depends on PCI
+    select NET_DEVLINK
+    help
+      This driver supports ZTE DingHai Ethernet devices.
+
+      DingHai is a high-performance Ethernet controller that supports
+      multiple features including hardware offloading, SR-IOV, and
+      advanced virtualization capabilities.
+
+      If you say Y here, you can select specific driver variants below.
+
+      If unsure, say N.
+
+if DINGHAI
+
+config DINGHAI_PF
+    tristate "ZTE DingHai PF (Physical Function) driver"
+    help
+      This driver supports ZTE DingHai PCI Express Ethernet
+      adapters (PF).
+
+      To compile this driver as a module, choose M here. The module
+      will be named dinghai10e.
+
+      If unsure, say N.
+
+endif # DINGHAI
diff --git a/drivers/net/ethernet/zte/dinghai/Makefile b/drivers/net/ethernet/zte/dinghai/Makefile
new file mode 100644
index 000000000000..f55a8de518be
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for ZTE DingHai Ethernet driver
+#
+
+ccflags-y += -I$(src)
+
+obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
+dinghai10e-y := en_pf.o
+
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
new file mode 100644
index 000000000000..034b8519a71c
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE DingHai Ethernet driver
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <net/devlink.h>
+#include <linux/dma-mapping.h>
+#include "en_pf.h"
+
+MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
+MODULE_DESCRIPTION("ZTE DingHai series Ethernet driver");
+MODULE_LICENSE("GPL");
+
+static const struct devlink_ops dh_pf_devlink_ops = {};
+
+static const struct pci_device_id dh_pf_pci_table[] = {
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID) },
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(pci, dh_pf_pci_table);
+
+void *dh_core_alloc_priv(struct dh_core_dev *dh_dev, size_t size)
+{
+	void *priv = kzalloc(size, GFP_KERNEL);
+
+	if (priv)
+		dh_dev->priv = priv;
+	return priv;
+}
+
+void dh_core_free_priv(struct dh_core_dev *dh_dev)
+{
+	kfree(dh_dev->priv);
+}
+
+static int dh_pf_pci_init(struct dh_core_dev *dev)
+{
+	struct zxdh_pf_device *pf_dev = dev->priv;
+	int ret;
+
+	pci_set_drvdata(dev->pdev, dev);
+
+	ret = pci_enable_device(dev->pdev);
+	if (ret) {
+		dev_err(dev->device, "pci_enable_device failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(64));
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(dev->device, "dma_set_mask_and_coherent failed: %d\n", ret);
+			goto err_pci;
+		}
+	}
+
+	ret = pci_request_selected_regions(dev->pdev,
+					   pci_select_bars(dev->pdev, IORESOURCE_MEM),
+					   "dh-pf");
+	if (ret) {
+		dev_err(dev->device, "pci_request_selected_regions failed: %d\n", ret);
+		goto err_pci;
+	}
+
+	pci_set_master(dev->pdev);
+	ret = pci_save_state(dev->pdev);
+	if (ret) {
+		dev_err(dev->device, "pci_save_state failed: %d\n", ret);
+		goto err_pci_save_state;
+	}
+
+	if (!(pci_resource_flags(dev->pdev, 0) & IORESOURCE_MEM)) {
+		ret = -ENODEV;
+		dev_err(dev->device, "BAR 0 is not an MMIO resource\n");
+		goto err_pci_save_state;
+	}
+
+	pf_dev->pci_ioremap_addr[0] =
+		ioremap(pci_resource_start(dev->pdev, 0),
+			pci_resource_len(dev->pdev, 0));
+	if (!pf_dev->pci_ioremap_addr[0]) {
+		ret = -ENOMEM;
+		dev_err(dev->device, "dh pf pci ioremap failed\n");
+		goto err_pci_save_state;
+	}
+
+	return 0;
+
+err_pci_save_state:
+	pci_release_selected_regions(dev->pdev,
+				     pci_select_bars(dev->pdev, IORESOURCE_MEM));
+err_pci:
+	pci_disable_device(dev->pdev);
+	return ret;
+}
+
+void dh_pf_pci_close(struct dh_core_dev *dev)
+{
+	struct zxdh_pf_device *pf_dev = dev->priv;
+
+	iounmap(pf_dev->pci_ioremap_addr[0]);
+	pci_release_selected_regions(dev->pdev,
+				     pci_select_bars(dev->pdev, IORESOURCE_MEM));
+	pci_disable_device(dev->pdev);
+}
+
+static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct zxdh_pf_device *pf_dev;
+	struct dh_core_dev *dh_dev;
+	struct devlink *devlink;
+	int ret;
+
+	devlink = devlink_alloc(&dh_pf_devlink_ops, sizeof(struct dh_core_dev),
+				&pdev->dev);
+	if (!devlink) {
+		dev_err(&pdev->dev, "dh_pf devlink alloc failed\n");
+		return -ENOMEM;
+	}
+
+	dh_dev = devlink_priv(devlink);
+	dh_dev->device = &pdev->dev;
+	dh_dev->pdev = pdev;
+	dh_dev->devlink = devlink;
+
+	pf_dev = dh_core_alloc_priv(dh_dev, sizeof(*pf_dev));
+	if (!pf_dev) {
+		dev_err(&pdev->dev, "dh_pf_dev alloc failed\n");
+		ret = -ENOMEM;
+		goto err_pf_dev;
+	}
+
+	pf_dev->bar_chan_valid = false;
+	pf_dev->vepa = false;
+	mutex_init(&dh_dev->lock);
+	mutex_init(&pf_dev->irq_lock);
+
+	dh_dev->coredev_type = GET_COREDEV_TYPE(pdev);
+
+	ret = dh_pf_pci_init(dh_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "dh_pf_pci_init failed: %d\n", ret);
+		goto err_cfg_init;
+	}
+
+	devlink_register(devlink);
+
+	return 0;
+
+err_cfg_init:
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&dh_dev->lock);
+	dh_core_free_priv(dh_dev);
+err_pf_dev:
+	devlink_free(devlink);
+	return ret;
+}
+
+static void dh_pf_remove(struct pci_dev *pdev)
+{
+	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
+	struct devlink *devlink = priv_to_devlink(dh_dev);
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	devlink_unregister(devlink);
+	dh_pf_pci_close(dh_dev);
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&dh_dev->lock);
+	dh_core_free_priv(dh_dev);
+	devlink_free(devlink);
+	pci_set_drvdata(pdev, NULL);
+}
+
+static void dh_pf_shutdown(struct pci_dev *pdev)
+{
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+	pci_disable_device(pdev);
+}
+
+static struct pci_driver dh_pf_driver = {
+	.name = "dinghai10e",
+	.id_table = dh_pf_pci_table,
+	.probe = dh_pf_probe,
+	.remove = dh_pf_remove,
+	.shutdown = dh_pf_shutdown,
+};
+
+module_pci_driver(dh_pf_driver);
diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
new file mode 100644
index 000000000000..87fa29b2d13d
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ZTE DingHai Ethernet driver - PF header
+ * Copyright (c) 2022-2026, ZTE Corporation.
+ */
+
+#ifndef __ZXDH_EN_PF_H__
+#define __ZXDH_EN_PF_H__
+
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/slab.h>
+
+#define ZXDH_PF_VENDOR_ID	0x1cf2
+#define ZXDH_PF_DEVICE_ID	0x8040
+#define ZXDH_VF_DEVICE_ID	0x8041
+
+enum dh_coredev_type {
+	DH_COREDEV_PF,
+	DH_COREDEV_VF,
+	DH_COREDEV_SF,
+	DH_COREDEV_MPF
+};
+
+struct devlink;
+
+struct dh_core_dev {
+	struct device *device;
+	enum dh_coredev_type coredev_type;
+	struct pci_dev *pdev;
+	struct devlink *devlink;
+	struct mutex lock; /* Protects device configuration */
+	void *priv;
+};
+
+struct zxdh_pf_device {
+	void __iomem *pci_ioremap_addr[6];
+	bool bar_chan_valid;
+	bool vepa;
+	struct mutex irq_lock; /* Protects IRQ operations */
+};
+
+#define GET_COREDEV_TYPE(pdev) \
+	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)
+
+void *dh_core_alloc_priv(struct dh_core_dev *dh_dev, size_t size);
+void dh_core_free_priv(struct dh_core_dev *dh_dev);
+void dh_pf_pci_close(struct dh_core_dev *dev);
+
+#endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0


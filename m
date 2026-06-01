Return-Path: <netdev+bounces-293575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cy4NwEnHWq6VwkAu9opvQ
	(envelope-from <netdev+bounces-293575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C99061A2EE
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 08:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E219A3006690
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 06:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B7351C27;
	Mon,  1 Jun 2026 06:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F131F99C;
	Mon,  1 Jun 2026 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295422; cv=none; b=t5os19XhZKARkIPZ9WOSN+JD7yVrDxzOcyVuZR9dlpABwQB0+RLzW1OgggCCAPr95OWLXW9iZNDyjaPcwCMTpxehFhkxFWZKOglzu7MThWbB1CezI618YkrISEJd1gWuWQyxJCm18NCq309JTvQH5XPntnfAdaQsBg2gKBKhlvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295422; c=relaxed/simple;
	bh=ktH8fqno6V7PfudIpcDsQz+OXBuwKkY2NAeq/YPtvF0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Q0P5VsTdg2J0msi/TY1js3eN4ko3Sofhxb8XzGaKaP85SpdIo2J5nkjX8mM/zRBJltSSfW4806vfsjONNRrhU9wHxw8QZypbZXoUtgWPqJU/D8vIsYOBAz8JM5MIvIfrhCX8mnjlNnmprLkfSLyuOKj6vtOUgjSXv+S95Krtl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gTPG86XQgz5B1Hf;
	Mon, 01 Jun 2026 14:30:08 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl2.zte.com.cn with SMTP id 6516U0Cx035756;
	Mon, 1 Jun 2026 14:30:00 +0800 (+08)
	(envelope-from han.junyang@zte.com.cn)
Received: from mapi (njb2app06[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 1 Jun 2026 14:30:02 +0800 (CST)
X-Zmail-TransId: 2afe6a1d26ea242-0bd68
X-Mailer: Zmail v1.0
Message-ID: <20260601143002051rSxzNiN9iKNj5gsdema0a@zte.com.cn>
In-Reply-To: <20260601142440024x-1sx0cQucoMxTHjm7ps3@zte.com.cn>
References: 20260601142440024x-1sx0cQucoMxTHjm7ps3@zte.com.cn
Date: Mon, 1 Jun 2026 14:30:02 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY1IDEvMl0gZGluZ2hhaTogYWRkIFpURSBuZXR3b3JrIGRyaXZlciBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6516U0Cx035756
X-TLS: YES
X-ENVELOPE-SENDER: han.junyang@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 01 Jun 2026 14:30:08 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1D26F0.000/4gTPG86XQgz5B1Hf
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293575-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[han.junyang@zte.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:mid,zte.com.cn:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-foundation.org:email]
X-Rspamd-Queue-Id: 5C99061A2EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 drivers/net/ethernet/zte/dinghai/en_pf.c  | 189 ++++++++++++++++++++++
 drivers/net/ethernet/zte/dinghai/en_pf.h  |  66 ++++++++
 9 files changed, 333 insertions(+)
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
index 000000000000..94b5bd9b3c50
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
+    depends on NET_VENDOR_ZTE && PCI
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
index 000000000000..6523bb7574b2
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
@@ -0,0 +1,189 @@
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
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID), 0 },
+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID), 0 },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, dh_pf_pci_table);
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
+	dev_info(&pdev->dev, "dh_pf probe start\n");
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
+	dev_info(&pdev->dev, "dh_pf probe completed\n");
+
+	return 0;
+
+err_cfg_init:
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&dh_dev->lock);
+	dh_core_free_priv(dh_dev);
+err_pf_dev:
+	devlink_free(devlink);
+	return -ENOMEM;
+}
+
+static void dh_pf_remove(struct pci_dev *pdev)
+{
+	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
+	struct devlink *devlink = priv_to_devlink(dh_dev);
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	dev_info(&pdev->dev, "dh_pf remove start\n");
+
+	dh_pf_pci_close(dh_dev);
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&dh_dev->lock);
+	dh_core_free_priv(dh_dev);
+	devlink_free(devlink);
+	pci_set_drvdata(pdev, NULL);
+
+	dev_info(&pdev->dev, "dh_pf remove completed\n");
+}
+
+static void dh_pf_shutdown(struct pci_dev *pdev)
+{
+	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
+	struct devlink *devlink = priv_to_devlink(dh_dev);
+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
+
+	dev_info(&pdev->dev, "dh_pf shutdown start\n");
+
+	dh_pf_pci_close(dh_dev);
+	mutex_destroy(&pf_dev->irq_lock);
+	mutex_destroy(&dh_dev->lock);
+	dh_core_free_priv(dh_dev);
+	devlink_free(devlink);
+	pci_set_drvdata(pdev, NULL);
+
+	dev_info(&pdev->dev, "dh_pf shutdown completed\n");
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
index 000000000000..de46e8b275ca
--- /dev/null
+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
@@ -0,0 +1,66 @@
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
+static inline void *dh_core_alloc_priv(struct dh_core_dev *dh_dev,
+				       size_t size)
+{
+	void *priv = kzalloc(size, GFP_KERNEL);
+
+	if (priv)
+		dh_dev->priv = priv;
+	return priv;
+}
+
+static inline void dh_core_free_priv(struct dh_core_dev *dh_dev)
+{
+	kfree(dh_dev->priv);
+	dh_dev->priv = NULL;
+}
+
+#define GET_COREDEV_TYPE(pdev) \
+	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)
+
+void dh_pf_pci_close(struct dh_core_dev *dev);
+
+#endif /* __ZXDH_EN_PF_H__ */
-- 
2.27.0


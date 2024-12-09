Return-Path: <netdev+bounces-150055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E5E9E8BEE
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE461885257
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41186214A94;
	Mon,  9 Dec 2024 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="YSopkpPE"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A6B214A65
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728414; cv=none; b=oEAfsoRgEvzuTENe9yMKIc7ST+zHB1oonYDGAavMvQDb8oa/Ck5ko3NWqyrtL0ncov5ZmcMJoYYs8HTKTet3ShlvrST05tWSjGVZwP5oIorTP2m85Bhn5hmsn/45+epnU0U6z6cQOKIQBMtQgffoNbkH95TtsqB+0/QvE9eH20w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728414; c=relaxed/simple;
	bh=V5M2XCTtF2WUhiAn56s2q2FFa2WD2c6ZUwvIOmCMRr0=;
	h=Date:Content-Type:Cc:Message-Id:Mime-Version:To:From:Subject; b=IWENfTYvrfR1YPsx+bi5VhyTVES0UoZSFdK9lgAT17J+sFOliTFiMBrhzQFBTzNTvdabigyGEXigXN9VhjclllmR4q8i0/UsD23SaYNow8JtlhVbr+3waMdhlDHfwzMGeXdyur0hX445X+YTW6utr0TxrNbmI4MSRZzh78fqBpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=YSopkpPE; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728266; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2SN57oyadADFxxYC+2pLoDazuGZ9UJRFWo8DrJcUNw8=;
 b=YSopkpPEIuOJeC6YfqZgGqSTaed4rDm4fhKS9XIp2I0bezl+YXnVECE0URUdWok/ZDeraV
 TmcYPRHAmGuYPT4lIwA0PyjmpaWmfsJzqgKKEWJfZisWYnLgxkQ3TqKeKWfa9/onUFN5d5
 F5ic2uSEraWW1yHmCVHsjdZqSPVXFPoYtna8DvYDj64pJEfdAsP4yvJW5Vcpf+r+0Bnk6O
 U1P9KyxBlYZAETlMqcSj9vT8SLcpcbKfJN/GrkI0rMS7GSwcQY6MFL8mS6mW/IlUFuHeuT
 Xyufev0NdPSmYhJpuwDSpwQQ8fEbhQw67X5kJyAulnd4gl8FOGSMfp11izuUZA==
Date: Mon,  9 Dec 2024 15:10:46 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267569808+889e5a+vger.kernel.org+tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-2-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:04 +0800
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
From: "Tian Xin" <tianx@yunsilicon.com>
Subject: [PATCH 01/16] net-next/yunsilicon: Add yunsilicon xsc driver basic framework

From: Xin Tian <tianx@yunsilicon.com>

Add yunsilicon xsc driver basic framework, including xsc_pci driver
and xsc_eth driver

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
 drivers/net/ethernet/yunsilicon/Makefile      |   8 +
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 134 +++++++++
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  16 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  17 ++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    | 278 ++++++++++++++++++
 10 files changed, 499 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 0baac25db..aa6016597 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
 source "drivers/net/ethernet/ibm/Kconfig"
 source "drivers/net/ethernet/intel/Kconfig"
 source "drivers/net/ethernet/xscale/Kconfig"
+source "drivers/net/ethernet/yunsilicon/Kconfig"
 
 config JME
 	tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index c03203439..c16c34d4b 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
 obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
 obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
 obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
+obj-$(CONFIG_NET_VENDOR_YUNSILICON) += yunsilicon/
 obj-$(CONFIG_JME) += jme.o
 obj-$(CONFIG_KORINA) += korina.o
 obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethernet/yunsilicon/Kconfig
new file mode 100644
index 000000000..a387a8dde
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon driver configuration
+#
+
+config NET_VENDOR_YUNSILICON
+	bool "Yunsilicon devices"
+	default y
+	depends on PCI || NET
+	depends on ARM64 || X86_64
+	help
+	  If you have a network (Ethernet or RDMA) device belonging to this
+	  class, say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Yunsilicon devices. If you say Y, you will be
+	  asked for your specific card in the following questions.
+
+if NET_VENDOR_YUNSILICON
+
+source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
+source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
+
+endif # NET_VENDOR_YUNSILICON
diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
new file mode 100644
index 000000000..950fd2663
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Makefile for the Yunsilicon device drivers.
+#
+
+# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
+obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
new file mode 100644
index 000000000..6049c2c65
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CORE_H
+#define XSC_CORE_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+extern unsigned int xsc_log_level;
+
+#define XSC_PCI_VENDOR_ID		0x1f67
+
+#define XSC_MC_PF_DEV_ID		0x1011
+#define XSC_MC_VF_DEV_ID		0x1012
+#define XSC_MC_PF_DEV_ID_DIAMOND	0x1021
+
+#define XSC_MF_HOST_PF_DEV_ID		0x1051
+#define XSC_MF_HOST_VF_DEV_ID		0x1052
+#define XSC_MF_SOC_PF_DEV_ID		0x1053
+
+#define XSC_MS_PF_DEV_ID		0x1111
+#define XSC_MS_VF_DEV_ID		0x1112
+
+#define XSC_MV_HOST_PF_DEV_ID		0x1151
+#define XSC_MV_HOST_VF_DEV_ID		0x1152
+#define XSC_MV_SOC_PF_DEV_ID		0x1153
+
+enum {
+	XSC_LOG_LEVEL_DBG	= 0,
+	XSC_LOG_LEVEL_INFO	= 1,
+	XSC_LOG_LEVEL_WARN	= 2,
+	XSC_LOG_LEVEL_ERR	= 3,
+};
+
+#define xsc_dev_log(condition, level, dev, fmt, ...)			\
+do {									\
+	if (condition)							\
+		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
+} while (0)
+
+#define xsc_core_dbg(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_dbg_once(__dev, format, ...)				\
+	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
+		     __func__, __LINE__, current->pid,			\
+		     ##__VA_ARGS__)
+
+#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
+do {									\
+	if ((mask) & xsc_debug_mask)					\
+		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
+} while (0)
+
+#define xsc_core_err(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_ERR, KERN_ERR,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_err_rl(__dev, format, ...)				\
+	dev_err_ratelimited(&(__dev)->pdev->dev,			\
+			   "%s:%d:(pid %d): " format,			\
+			   __func__, __LINE__, current->pid,		\
+			   ##__VA_ARGS__)
+
+#define xsc_core_warn(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_WARN, KERN_WARNING,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_info(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_INFO, KERN_INFO,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_pr_debug(format, ...)					\
+do {									\
+	if (xsc_log_level <= XSC_LOG_LEVEL_DBG)				\
+		pr_debug(format, ##__VA_ARGS__);		\
+} while (0)
+
+#define assert(__dev, expr)						\
+do {									\
+	if (!(expr)) {							\
+		dev_err(&(__dev)->pdev->dev,				\
+		"Assertion failed! %s, %s, %s, line %d\n",		\
+		#expr, __FILE__, __func__, __LINE__);			\
+	}								\
+} while (0)
+
+enum {
+	XSC_MAX_NAME_LEN = 32,
+};
+
+struct xsc_dev_resource {
+	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
+	int numa_node;
+};
+
+enum xsc_pci_status {
+	XSC_PCI_STATUS_DISABLED,
+	XSC_PCI_STATUS_ENABLED,
+};
+
+struct xsc_priv {
+	char			name[XSC_MAX_NAME_LEN];
+	struct list_head	dev_list;
+	struct list_head	ctx_list;
+	spinlock_t		ctx_lock;	/* protect ctx_list */
+	int			numa_node;
+};
+
+/* our core device */
+struct xsc_core_device {
+	struct pci_dev		*pdev;
+	struct device		*device;
+	struct xsc_priv		priv;
+	struct xsc_dev_resource	*dev_res;
+
+	void __iomem		*bar;
+	int			bar_num;
+
+	struct mutex		pci_status_mutex;	/* protect pci_status */
+	enum xsc_pci_status	pci_status;
+	struct mutex		intf_state_mutex;	/* protect intf_state */
+	unsigned long		intf_state;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
new file mode 100644
index 000000000..30889caa9
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon driver configuration
+#
+
+config YUNSILICON_XSC_ETH
+	tristate "Yunsilicon XSC ethernet driver"
+	default n
+	depends on YUNSILICON_XSC_PCI
+	help
+	  This driver provides ethernet support for
+	  Yunsilicon XSC devices.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called xsc_eth.
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
new file mode 100644
index 000000000..6ac74b27a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+
+ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
+
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
+
+xsc_eth-y := main.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
new file mode 100644
index 000000000..fafa69b8a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon PCI configuration
+#
+
+config YUNSILICON_XSC_PCI
+	tristate "Yunsilicon XSC PCI driver"
+	default n
+	select NET_DEVLINK
+	select PAGE_POOL
+	help
+	  This driver is common for Yunsilicon XSC
+	  ethernet and RDMA drivers.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called xsc_pci.
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
new file mode 100644
index 000000000..b2ae73fb9
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+
+ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
+
+obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
+
+xsc_pci-y := main.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
new file mode 100644
index 000000000..1d26ffa8d
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+
+unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
+module_param_named(log_level, xsc_log_level, uint, 0644);
+MODULE_PARM_DESC(log_level,
+		 "lowest log level to print: 0=debug, 1=info, 2=warning, 3=error. Default=1");
+EXPORT_SYMBOL(xsc_log_level);
+
+static const struct pci_device_id xsc_pci_id_table[] = {
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
+	{ 0 }
+};
+
+static int set_dma_caps(struct pci_dev *pdev)
+{
+	int err = 0;
+
+	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	else
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+
+	if (!err)
+		dma_set_max_seg_size(&pdev->dev, 2u * 1024 * 1024 * 1024);
+
+	return err;
+}
+
+static int xsc_pci_enable_device(struct xsc_core_device *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+	int err = 0;
+
+	mutex_lock(&dev->pci_status_mutex);
+	if (dev->pci_status == XSC_PCI_STATUS_DISABLED) {
+		err = pci_enable_device(pdev);
+		if (!err)
+			dev->pci_status = XSC_PCI_STATUS_ENABLED;
+	}
+	mutex_unlock(&dev->pci_status_mutex);
+
+	return err;
+}
+
+static void xsc_pci_disable_device(struct xsc_core_device *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+
+	mutex_lock(&dev->pci_status_mutex);
+	if (dev->pci_status == XSC_PCI_STATUS_ENABLED) {
+		pci_disable_device(pdev);
+		dev->pci_status = XSC_PCI_STATUS_DISABLED;
+	}
+	mutex_unlock(&dev->pci_status_mutex);
+}
+
+static int xsc_pci_init(struct xsc_core_device *dev, const struct pci_device_id *id)
+{
+	struct pci_dev *pdev = dev->pdev;
+	int err = 0;
+	int bar_num = 0;
+	void __iomem *bar_base = NULL;
+
+	mutex_init(&dev->pci_status_mutex);
+	dev->priv.numa_node = dev_to_node(&pdev->dev);
+	if (dev->priv.numa_node == -1)
+		dev->priv.numa_node = 0;
+
+	/* enable the device */
+	err = xsc_pci_enable_device(dev);
+	if (err) {
+		xsc_core_err(dev, "failed to enable PCI device: err=%d\n", err);
+		goto err_ret;
+	}
+
+	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
+	if (err) {
+		xsc_core_err(dev, "failed to request %s pci_region=%d: err=%d\n",
+			     KBUILD_MODNAME, bar_num, err);
+		goto err_disable;
+	}
+
+	pci_set_master(pdev);
+
+	err = set_dma_caps(pdev);
+	if (err) {
+		xsc_core_err(dev, "failed to set DMA capabilities mask: err=%d\n", err);
+		goto err_clr_master;
+	}
+
+	bar_base = pci_ioremap_bar(pdev, bar_num);
+	if (!bar_base) {
+		xsc_core_err(dev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);
+		goto err_clr_master;
+	}
+
+	err = pci_save_state(pdev);
+	if (err) {
+		xsc_core_err(dev, "pci_save_state failed: err=%d\n", err);
+		goto err_io_unmap;
+	}
+
+	dev->bar_num = bar_num;
+	dev->bar = bar_base;
+
+	return 0;
+
+err_io_unmap:
+	pci_iounmap(pdev, bar_base);
+err_clr_master:
+	pci_clear_master(pdev);
+	pci_release_region(pdev, bar_num);
+err_disable:
+	xsc_pci_disable_device(dev);
+err_ret:
+	return err;
+}
+
+static void xsc_pci_fini(struct xsc_core_device *dev)
+{
+	struct pci_dev *pdev = dev->pdev;
+
+	if (dev->bar)
+		pci_iounmap(pdev, dev->bar);
+	pci_clear_master(pdev);
+	pci_release_region(pdev, dev->bar_num);
+	xsc_pci_disable_device(dev);
+}
+
+static int xsc_priv_init(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv = &dev->priv;
+
+	strscpy(priv->name, dev_name(&dev->pdev->dev), XSC_MAX_NAME_LEN);
+	priv->name[XSC_MAX_NAME_LEN - 1] = 0;
+
+	INIT_LIST_HEAD(&priv->ctx_list);
+	spin_lock_init(&priv->ctx_lock);
+	mutex_init(&dev->intf_state_mutex);
+
+	return 0;
+}
+
+static int xsc_dev_res_init(struct xsc_core_device *dev)
+{
+	struct xsc_dev_resource *dev_res = NULL;
+
+	dev_res = kvzalloc(sizeof(*dev_res), GFP_KERNEL);
+	if (!dev_res)
+		return -ENOMEM;
+
+	dev->dev_res = dev_res;
+	mutex_init(&dev_res->alloc_mutex);
+
+	return 0;
+}
+
+static void xsc_dev_res_cleanup(struct xsc_core_device *dev)
+{
+	kfree(dev->dev_res);
+	dev->dev_res = NULL;
+}
+
+static int xsc_core_dev_init(struct xsc_core_device *dev)
+{
+	int err = 0;
+
+	xsc_priv_init(dev);
+
+	err = xsc_dev_res_init(dev);
+	if (err) {
+		xsc_core_err(dev, "xsc dev res init failed %d\n", err);
+		goto err_res_init;
+	}
+
+	return 0;
+err_res_init:
+	return err;
+}
+
+static void xsc_core_dev_cleanup(struct xsc_core_device *dev)
+{
+	xsc_dev_res_cleanup(dev);
+}
+
+static int xsc_pci_probe(struct pci_dev *pci_dev,
+			 const struct pci_device_id *id)
+{
+	struct xsc_core_device *xdev;
+	int err;
+
+	/* allocate core structure and fill it out */
+	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->pdev = pci_dev;
+	xdev->device = &pci_dev->dev;
+
+	/* init pcie device */
+	pci_set_drvdata(pci_dev, xdev);
+	err = xsc_pci_init(xdev, id);
+	if (err) {
+		xsc_core_err(xdev, "xsc_pci_init failed %d\n", err);
+		goto err_pci_init;
+	}
+
+	err = xsc_core_dev_init(xdev);
+	if (err) {
+		xsc_core_err(xdev, "xsc_core_dev_init failed %d\n", err);
+		goto err_dev_init;
+	}
+
+	return 0;
+err_dev_init:
+	xsc_pci_fini(xdev);
+err_pci_init:
+	pci_set_drvdata(pci_dev, NULL);
+	kfree(xdev);
+
+	return err;
+}
+
+static void xsc_pci_remove(struct pci_dev *pci_dev)
+{
+	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
+
+	xsc_core_dev_cleanup(xdev);
+	xsc_pci_fini(xdev);
+	pci_set_drvdata(pci_dev, NULL);
+	kfree(xdev);
+}
+
+static struct pci_driver xsc_pci_driver = {
+	.name		= "xsc-pci",
+	.id_table	= xsc_pci_id_table,
+	.probe		= xsc_pci_probe,
+	.remove		= xsc_pci_remove,
+};
+
+static int __init xsc_init(void)
+{
+	int err;
+
+	err = pci_register_driver(&xsc_pci_driver);
+	if (err) {
+		pr_err("failed to register pci driver\n");
+		goto err_register;
+	}
+
+	return 0;
+
+err_register:
+	return err;
+}
+
+static void __exit xsc_fini(void)
+{
+	pci_unregister_driver(&xsc_pci_driver);
+}
+
+module_init(xsc_init);
+module_exit(xsc_fini);
+
+MODULE_LICENSE("GPL");
+
-- 
2.43.0


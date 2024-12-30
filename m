Return-Path: <netdev+bounces-154526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66819FE549
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 11:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97344162808
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797181A706F;
	Mon, 30 Dec 2024 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="C9mltit7"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-31.ptr.blmpb.com (va-1-31.ptr.blmpb.com [209.127.230.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFC1A9B4D
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553873; cv=none; b=KG+9sKKGBLCQX7JQ4OGo0KfQ+fxfvpp/bQFeG2KhI9Kv/N8q2msF8dJxV4pNA44SBcYMi7+ChO8L2x6CNEugwylL9/kgyPdzyTN7SXoOtHeahSo0u2Q7uicQ4LiIPXFhhV9KVoLqFTQBTIpe29B3mvlMS9cSntpwlVdidLMFpq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553873; c=relaxed/simple;
	bh=sO5cF9AGoyUv2r/QxS1zIhKAoFFsWWkf0GBUghWKv7U=;
	h=Date:To:From:Mime-Version:Content-Type:Subject:Message-Id:
	 References:In-Reply-To:Cc; b=Np9a5AiMpS6rtiK0RafBUZsg63EHb8GySsqwA5Ka3bYTUV1IjC+Lt4R/8UL8I0BbXXGOrQ1e5wH3Ijlq2CanBge7j7qCOQjo4+EfIrrE0FK+DMzSmJdOJbNpOfi3lgAh4y0qBqwSIS1GO9APlEaXkKYprYENQybOG6/atEfrGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=C9mltit7; arc=none smtp.client-ip=209.127.230.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735553729; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=J+BGTGCFviB8VHgFz9sztaPQRbG/AlTFDMB1rhzDeak=;
 b=C9mltit7JV+FLeamvL+9dXX1dzKBfOQ44a3xAkSRzjKLjlAXm34CilkOXgNtDGAreOCgux
 oHJ5F3GEw2b+BlDP+A+AD3L4pn7aEjDUT1SUPSpQEApZOH3ZE6NZrMmbkZW1lGfH+byBUT
 3jdv5dGmwo4wAZlqwef6x//PdRzgCvWlvn82NSKlg5j5IeCIim0ejhMfE9XuzBaCILSW1Q
 /4qoF94WxOAuLx5s+wdQU5dSXtxcMJA1W8Bj4j6v5M5SFOTc7k38jp17yqCXebHfUfRxbY
 sDLiHVRfDEi/dIW0nPtJnirDE0HxQ2L92bafglu5Fh1Dl95+LBzHHz56W+qd+w==
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Mon, 30 Dec 2024 18:15:27 +0800
Date: Mon, 30 Dec 2024 18:15:27 +0800
X-Lms-Return-Path: <lba+2677272bf+77d152+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2 07/14] net-next/yunsilicon: Device and interface management
Message-Id: <20241230101526.3836531-8-tianx@yunsilicon.com>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
In-Reply-To: <20241230101513.3836531-1-tianx@yunsilicon.com>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1

The xsc device supports both Ethernet and RDMA interfaces.
This patch provides a set of APIs to implement the registration
of new interfaces and handle the interfaces during device
attach/detach or add/remove events.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  59 +++-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/intf.c    | 251 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/intf.h    |  22 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  16 ++
 5 files changed, 345 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 471dafb65..2eb9c3c80 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -226,11 +226,60 @@ struct xsc_eq_table {
 	spinlock_t		lock;
 };
 
+// irq
 struct xsc_irq_info {
 	cpumask_var_t mask;
 	char name[XSC_MAX_IRQ_NAME];
 };
 
+// intf
+enum xsc_dev_event {
+	XSC_DEV_EVENT_SYS_ERROR,
+	XSC_DEV_EVENT_PORT_UP,
+	XSC_DEV_EVENT_PORT_DOWN,
+	XSC_DEV_EVENT_PORT_INITIALIZED,
+	XSC_DEV_EVENT_LID_CHANGE,
+	XSC_DEV_EVENT_PKEY_CHANGE,
+	XSC_DEV_EVENT_GUID_CHANGE,
+	XSC_DEV_EVENT_CLIENT_REREG,
+};
+
+enum {
+	XSC_INTERFACE_ADDED,
+	XSC_INTERFACE_ATTACHED,
+};
+
+enum xsc_interface_state {
+	XSC_INTERFACE_STATE_UP = BIT(0),
+	XSC_INTERFACE_STATE_TEARDOWN = BIT(1),
+};
+
+enum {
+	XSC_INTERFACE_PROTOCOL_IB  = 0,
+	XSC_INTERFACE_PROTOCOL_ETH = 1,
+};
+
+struct xsc_interface {
+	struct list_head list;
+	int protocol;
+
+	void *(*add)(struct xsc_core_device *xdev);
+	void (*remove)(struct xsc_core_device *xdev, void *context);
+	int (*attach)(struct xsc_core_device *xdev, void *context);
+	void (*detach)(struct xsc_core_device *xdev, void *context);
+	void (*event)(struct xsc_core_device *xdev, void *context,
+		      enum xsc_dev_event event, unsigned long param);
+	void *(*get_dev)(void *context);
+};
+
+struct xsc_device_context {
+	struct list_head list;
+	struct xsc_interface *intf;
+	void *context;
+	unsigned long state;
+};
+
+// xsc_core
 struct xsc_dev_resource {
 	struct xsc_qp_table	qp_table;
 	struct xsc_cq_table	cq_table;
@@ -368,11 +417,6 @@ enum xsc_pci_state {
 	XSC_PCI_STATE_ENABLED,
 };
 
-enum xsc_interface_state {
-	XSC_INTERFACE_STATE_UP = BIT(0),
-	XSC_INTERFACE_STATE_TEARDOWN = BIT(1),
-};
-
 struct xsc_priv {
 	char			name[XSC_MAX_NAME_LEN];
 	struct list_head	dev_list;
@@ -388,6 +432,8 @@ struct xsc_core_device {
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
+	void (*event)(struct xsc_core_device *xdev,
+		      enum xsc_dev_event event, unsigned long param);
 	void (*event_handler)(void *adapter);
 
 	void __iomem		*bar;
@@ -432,6 +478,9 @@ struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i);
 int xsc_core_vector2eqn(struct xsc_core_device *xdev, int vector, int *eqn,
 			unsigned int *irqn);
 
+int xsc_register_interface(struct xsc_interface *intf);
+void xsc_unregister_interface(struct xsc_interface *intf);
+
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
 	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 3525d1c74..0f4b17dfa 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o intf.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
new file mode 100644
index 000000000..6f9c1e18b
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (C) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ * Copyright (c) 2007, 2008 Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2006, 2007 Cisco Systems, Inc. All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+#include "intf.h"
+
+LIST_HEAD(intf_list);
+LIST_HEAD(xsc_dev_list);
+DEFINE_MUTEX(xsc_intf_mutex); // protect intf_list and xsc_dev_list
+
+static void xsc_add_device(struct xsc_interface *intf, struct xsc_priv *priv)
+{
+	struct xsc_device_context *dev_ctx;
+	struct xsc_core_device *xdev;
+
+	xdev = container_of(priv, struct xsc_core_device, priv);
+	dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	if (!dev_ctx)
+		return;
+
+	dev_ctx->intf = intf;
+
+	dev_ctx->context = intf->add(xdev);
+	if (dev_ctx->context) {
+		set_bit(XSC_INTERFACE_ADDED, &dev_ctx->state);
+		if (intf->attach)
+			set_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state);
+
+		spin_lock_irq(&priv->ctx_lock);
+		list_add_tail(&dev_ctx->list, &priv->ctx_list);
+		spin_unlock_irq(&priv->ctx_lock);
+	} else {
+		kfree(dev_ctx);
+	}
+}
+
+static struct xsc_device_context *xsc_get_device(struct xsc_interface *intf,
+						 struct xsc_priv *priv)
+{
+	struct xsc_device_context *dev_ctx;
+
+	/* caller of this function has mutex protection */
+	list_for_each_entry(dev_ctx, &priv->ctx_list, list)
+		if (dev_ctx->intf == intf)
+			return dev_ctx;
+
+	return NULL;
+}
+
+static void xsc_remove_device(struct xsc_interface *intf, struct xsc_priv *priv)
+{
+	struct xsc_core_device *xdev = container_of(priv, struct xsc_core_device, priv);
+	struct xsc_device_context *dev_ctx;
+
+	dev_ctx = xsc_get_device(intf, priv);
+	if (!dev_ctx)
+		return;
+
+	spin_lock_irq(&priv->ctx_lock);
+	list_del(&dev_ctx->list);
+	spin_unlock_irq(&priv->ctx_lock);
+
+	if (test_bit(XSC_INTERFACE_ADDED, &dev_ctx->state))
+		intf->remove(xdev, dev_ctx->context);
+
+	kfree(dev_ctx);
+}
+
+int xsc_register_interface(struct xsc_interface *intf)
+{
+	struct xsc_priv *priv;
+
+	if (!intf->add || !intf->remove)
+		return -EINVAL;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_add_tail(&intf->list, &intf_list);
+	list_for_each_entry(priv, &xsc_dev_list, dev_list) {
+		xsc_add_device(intf, priv);
+	}
+	mutex_unlock(&xsc_intf_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_register_interface);
+
+void xsc_unregister_interface(struct xsc_interface *intf)
+{
+	struct xsc_priv *priv;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(priv, &xsc_dev_list, dev_list)
+		xsc_remove_device(intf, priv);
+	list_del(&intf->list);
+	mutex_unlock(&xsc_intf_mutex);
+}
+EXPORT_SYMBOL(xsc_unregister_interface);
+
+static void xsc_attach_interface(struct xsc_interface *intf,
+				 struct xsc_priv *priv)
+{
+	struct xsc_core_device *xdev = container_of(priv, struct xsc_core_device, priv);
+	struct xsc_device_context *dev_ctx;
+
+	dev_ctx = xsc_get_device(intf, priv);
+	if (!dev_ctx)
+		return;
+
+	if (intf->attach) {
+		if (test_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state))
+			return;
+		if (intf->attach(xdev, dev_ctx->context))
+			return;
+		set_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state);
+	} else {
+		if (test_bit(XSC_INTERFACE_ADDED, &dev_ctx->state))
+			return;
+		dev_ctx->context = intf->add(xdev);
+		if (!dev_ctx->context)
+			return;
+		set_bit(XSC_INTERFACE_ADDED, &dev_ctx->state);
+	}
+}
+
+static void xsc_detach_interface(struct xsc_interface *intf,
+				 struct xsc_priv *priv)
+{
+	struct xsc_core_device *xdev = container_of(priv, struct xsc_core_device, priv);
+	struct xsc_device_context *dev_ctx;
+
+	dev_ctx = xsc_get_device(intf, priv);
+	if (!dev_ctx)
+		return;
+
+	if (intf->detach) {
+		if (!test_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state))
+			return;
+		intf->detach(xdev, dev_ctx->context);
+		clear_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state);
+	} else {
+		if (!test_bit(XSC_INTERFACE_ADDED, &dev_ctx->state))
+			return;
+		intf->remove(xdev, dev_ctx->context);
+		clear_bit(XSC_INTERFACE_ADDED, &dev_ctx->state);
+	}
+}
+
+void xsc_attach_device(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv = &xdev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(intf, &intf_list, list) {
+		xsc_attach_interface(intf, priv);
+	}
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+void xsc_detach_device(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv = &xdev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(intf, &intf_list, list)
+		xsc_detach_interface(intf, priv);
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+bool xsc_device_registered(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv;
+	bool found = false;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(priv, &xsc_dev_list, dev_list)
+		if (priv == &xdev->priv)
+			found = true;
+	mutex_unlock(&xsc_intf_mutex);
+
+	return found;
+}
+
+int xsc_register_device(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv = &xdev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_add_tail(&priv->dev_list, &xsc_dev_list);
+	list_for_each_entry(intf, &intf_list, list)
+		xsc_add_device(intf, priv);
+	mutex_unlock(&xsc_intf_mutex);
+
+	return 0;
+}
+
+void xsc_unregister_device(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv = &xdev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry_reverse(intf, &intf_list, list)
+		xsc_remove_device(intf, priv);
+	list_del(&priv->dev_list);
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+void xsc_add_dev_by_protocol(struct xsc_core_device *xdev, int protocol)
+{
+	struct xsc_interface *intf;
+
+	list_for_each_entry(intf, &intf_list, list)
+		if (intf->protocol == protocol) {
+			xsc_add_device(intf, &xdev->priv);
+			break;
+		}
+}
+
+void xsc_remove_dev_by_protocol(struct xsc_core_device *xdev, int protocol)
+{
+	struct xsc_interface *intf;
+
+	list_for_each_entry(intf, &intf_list, list)
+		if (intf->protocol == protocol) {
+			xsc_remove_device(intf, &xdev->priv);
+			break;
+		}
+}
+
+void xsc_dev_list_lock(void)
+{
+	mutex_lock(&xsc_intf_mutex);
+}
+
+void xsc_dev_list_unlock(void)
+{
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+int xsc_dev_list_trylock(void)
+{
+	return mutex_trylock(&xsc_intf_mutex);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/intf.h b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.h
new file mode 100644
index 000000000..d20f47798
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __INTF_H
+#define __INTF_H
+
+#include "common/xsc_core.h"
+
+void xsc_attach_device(struct xsc_core_device *xdev);
+void xsc_detach_device(struct xsc_core_device *xdev);
+bool xsc_device_registered(struct xsc_core_device *xdev);
+int xsc_register_device(struct xsc_core_device *xdev);
+void xsc_unregister_device(struct xsc_core_device *xdev);
+void xsc_add_dev_by_protocol(struct xsc_core_device *xdev, int protocol);
+void xsc_remove_dev_by_protocol(struct xsc_core_device *xdev, int protocol);
+void xsc_dev_list_lock(void);
+void xsc_dev_list_unlock(void);
+int xsc_dev_list_trylock(void);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index e5bc5e841..615305ef3 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -10,6 +10,7 @@
 #include "cq.h"
 #include "eq.h"
 #include "pci_irq.h"
+#include "intf.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -273,10 +274,22 @@ static int xsc_load(struct xsc_core_device *xdev)
 		goto err_irq_eq_create;
 	}
 
+	if (xsc_device_registered(xdev)) {
+		xsc_attach_device(xdev);
+	} else {
+		err = xsc_register_device(xdev);
+		if (err) {
+			pci_err(xdev->pdev, "register device failed %d\n", err);
+			goto err_reg_dev;
+		}
+	}
+
 	set_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
 	mutex_unlock(&xdev->intf_state_mutex);
 
 	return 0;
+err_reg_dev:
+	xsc_irq_eq_destroy(xdev);
 err_irq_eq_create:
 	xsc_hw_cleanup(xdev);
 out:
@@ -286,6 +299,7 @@ static int xsc_load(struct xsc_core_device *xdev)
 
 static int xsc_unload(struct xsc_core_device *xdev)
 {
+	xsc_unregister_device(xdev);
 	mutex_lock(&xdev->intf_state_mutex);
 	if (!test_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state)) {
 		xsc_hw_cleanup(xdev);
@@ -293,6 +307,8 @@ static int xsc_unload(struct xsc_core_device *xdev)
 	}
 
 	clear_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
+	if (xsc_device_registered(xdev))
+		xsc_detach_device(xdev);
 	xsc_irq_eq_destroy(xdev);
 	xsc_hw_cleanup(xdev);
 
-- 
2.43.0


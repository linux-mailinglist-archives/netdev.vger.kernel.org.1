Return-Path: <netdev+bounces-150058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BBC9E8BF1
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1F2818D0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E16C21504C;
	Mon,  9 Dec 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="L2fi327A"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058DB214A7C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728421; cv=none; b=M8RUGbGdegdBATpyQ6pN5ka67v+AkynhGNfFPUerS0lNNwNLHCVpwIV3pxortk8UGaHP+SC2CDoCoXBar/4RHdgO3PFHXHtaGDsuI9rWUX0odfsLJSDacwwTKd8/rgyfJwRhkXKSrEYX60JbSmyjlzrZH8DKTMR5GXjcpzraMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728421; c=relaxed/simple;
	bh=bHu9pzqOnYWTjhnTTqjO49gyOCunsLEzZCNojppEGHw=;
	h=To:From:Message-Id:Content-Type:Cc:Date:Subject:Mime-Version; b=CfeZhF6esEqqsPjzjfwRvw6fDe2I1DtPJCFbKG41SH4Rnech4VnCpnXSMHoIkjXAnWg57Dcg3PA2Z+mlQmkhYrBlatx5H8tVf77ki7gj/L5UEuFLhrcNMxIGGZ5xQOHML51YaedAdp+kbzHtxPHRvi28uUvsNjQquZSnE+eNI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=L2fi327A; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728276; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=MYjlVSr1YHA69fq8JCGDuOX0uYHq6fQl73CS6sdNr1k=;
 b=L2fi327ACHxDwMPiZD36KhO9NnZ8lSOxw36Ckgm0qKlUSsjNa+apiN8I++hC4xIxRecxFP
 yeKy6CfS1T1wyK828V/tJPSXqQ5eOgfJEMtksUKtQA+A9uK3pMwA5RaXvqUVwudeG2sD4Q
 oCjKP94TanQ8/dsfndkhTBGITpqYwx9N6PWLL8kxbyZBzgDZzfmQKX3Vny0IKxDWyaHMBK
 2wonUJj/dWPjQnolDnbcvK3NZw1cWP7m+HJ78utRNcf0D4gmIZ9/QhnQR78KW+Yp7u2CbE
 jTOjVBMAPg6SGLiTesmOQ3XS8ysd7KJ1EWOrhAs/BUAx/v6/GCM6W8CkGsjZJQ==
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
From: "Tian Xin" <tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-8-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267569812+451928+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Date: Mon,  9 Dec 2024 15:10:52 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:13 +0800
Subject: [PATCH 07/16] net-next/yunsilicon: Device and interface management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

From: Xin Tian <tianx@yunsilicon.com>

The xsc device supports both Ethernet and RDMA interfaces.
This patch provides a set of APIs to implement the registration
of new interfaces and handle the interfaces during device
attach/detach or add/remove events.

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  59 +++-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/intf.c    | 279 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/intf.h    |  22 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  16 +
 5 files changed, 373 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index fc8301590..88d4c5654 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -294,11 +294,60 @@ struct xsc_eq_table {
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
+	void *(*add)(struct xsc_core_device *dev);
+	void (*remove)(struct xsc_core_device *dev, void *context);
+	int (*attach)(struct xsc_core_device *dev, void *context);
+	void (*detach)(struct xsc_core_device *dev, void *context);
+	void (*event)(struct xsc_core_device *dev, void *context,
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
@@ -436,11 +485,6 @@ enum xsc_pci_status {
 	XSC_PCI_STATUS_ENABLED,
 };
 
-enum xsc_interface_state {
-	XSC_INTERFACE_STATE_UP = BIT(0),
-	XSC_INTERFACE_STATE_TEARDOWN = BIT(1),
-};
-
 struct xsc_priv {
 	char			name[XSC_MAX_NAME_LEN];
 	struct list_head	dev_list;
@@ -457,6 +501,8 @@ struct xsc_core_device {
 	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 
+	void (*event)(struct xsc_core_device *dev,
+		      enum xsc_dev_event event, unsigned long param);
 	void (*event_handler)(void *adapter);
 
 	void __iomem		*bar;
@@ -501,6 +547,9 @@ struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *dev, int i);
 int xsc_core_vector2eqn(struct xsc_core_device *dev, int vector, int *eqn,
 			unsigned int *irqn);
 
+int xsc_register_interface(struct xsc_interface *intf);
+void xsc_unregister_interface(struct xsc_interface *intf);
+
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
 	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index b0465a2be..7c185e164 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o intf.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
new file mode 100644
index 000000000..c65084079
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (C) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ * Copyright (c) 2006, 2007 Cisco Systems, Inc. All rights reserved.
+ * Copyright (c) 2007, 2008 Mellanox Technologies. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
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
+	struct xsc_core_device *dev;
+
+	dev = container_of(priv, struct xsc_core_device, priv);
+	dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+	if (!dev_ctx)
+		return;
+
+	dev_ctx->intf = intf;
+
+	dev_ctx->context = intf->add(dev);
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
+	struct xsc_device_context *dev_ctx;
+	struct xsc_core_device *dev = container_of(priv, struct xsc_core_device, priv);
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
+		intf->remove(dev, dev_ctx->context);
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
+	struct xsc_device_context *dev_ctx;
+	struct xsc_core_device *dev = container_of(priv, struct xsc_core_device, priv);
+
+	dev_ctx = xsc_get_device(intf, priv);
+	if (!dev_ctx)
+		return;
+
+	if (intf->attach) {
+		if (test_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state))
+			return;
+		if (intf->attach(dev, dev_ctx->context))
+			return;
+		set_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state);
+	} else {
+		if (test_bit(XSC_INTERFACE_ADDED, &dev_ctx->state))
+			return;
+		dev_ctx->context = intf->add(dev);
+		if (!dev_ctx->context)
+			return;
+		set_bit(XSC_INTERFACE_ADDED, &dev_ctx->state);
+	}
+}
+
+static void xsc_detach_interface(struct xsc_interface *intf,
+				 struct xsc_priv *priv)
+{
+	struct xsc_device_context *dev_ctx;
+	struct xsc_core_device *dev = container_of(priv, struct xsc_core_device, priv);
+
+	dev_ctx = xsc_get_device(intf, priv);
+	if (!dev_ctx)
+		return;
+
+	if (intf->detach) {
+		if (!test_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state))
+			return;
+		intf->detach(dev, dev_ctx->context);
+		clear_bit(XSC_INTERFACE_ATTACHED, &dev_ctx->state);
+	} else {
+		if (!test_bit(XSC_INTERFACE_ADDED, &dev_ctx->state))
+			return;
+		intf->remove(dev, dev_ctx->context);
+		clear_bit(XSC_INTERFACE_ADDED, &dev_ctx->state);
+	}
+}
+
+void xsc_attach_device(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv = &dev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(intf, &intf_list, list) {
+		xsc_attach_interface(intf, priv);
+	}
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+void xsc_detach_device(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv = &dev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(intf, &intf_list, list)
+		xsc_detach_interface(intf, priv);
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+bool xsc_device_registered(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv;
+	bool found = false;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry(priv, &xsc_dev_list, dev_list)
+		if (priv == &dev->priv)
+			found = true;
+	mutex_unlock(&xsc_intf_mutex);
+
+	return found;
+}
+
+int xsc_register_device(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv = &dev->priv;
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
+void xsc_unregister_device(struct xsc_core_device *dev)
+{
+	struct xsc_priv *priv = &dev->priv;
+	struct xsc_interface *intf;
+
+	mutex_lock(&xsc_intf_mutex);
+	list_for_each_entry_reverse(intf, &intf_list, list)
+		xsc_remove_device(intf, priv);
+	list_del(&priv->dev_list);
+	mutex_unlock(&xsc_intf_mutex);
+}
+
+void xsc_add_dev_by_protocol(struct xsc_core_device *dev, int protocol)
+{
+	struct xsc_interface *intf;
+
+	list_for_each_entry(intf, &intf_list, list)
+		if (intf->protocol == protocol) {
+			xsc_add_device(intf, &dev->priv);
+			break;
+		}
+}
+
+void xsc_remove_dev_by_protocol(struct xsc_core_device *dev, int protocol)
+{
+	struct xsc_interface *intf;
+
+	list_for_each_entry(intf, &intf_list, list)
+		if (intf->protocol == protocol) {
+			xsc_remove_device(intf, &dev->priv);
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
index 000000000..145ab56a4
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/intf.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef INTF_H
+#define INTF_H
+
+#include "common/xsc_core.h"
+
+void xsc_attach_device(struct xsc_core_device *dev);
+void xsc_detach_device(struct xsc_core_device *dev);
+bool xsc_device_registered(struct xsc_core_device *dev);
+int xsc_register_device(struct xsc_core_device *dev);
+void xsc_unregister_device(struct xsc_core_device *dev);
+void xsc_add_dev_by_protocol(struct xsc_core_device *dev, int protocol);
+void xsc_remove_dev_by_protocol(struct xsc_core_device *dev, int protocol);
+void xsc_dev_list_lock(void);
+void xsc_dev_list_unlock(void);
+int xsc_dev_list_trylock(void);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 168cb7e63..06ed08108 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -10,6 +10,7 @@
 #include "cq.h"
 #include "eq.h"
 #include "pci_irq.h"
+#include "intf.h"
 
 unsigned int xsc_debug_mask;
 module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
@@ -292,10 +293,22 @@ static int xsc_load(struct xsc_core_device *dev)
 		goto err_irq_eq_create;
 	}
 
+	if (xsc_device_registered(dev)) {
+		xsc_attach_device(dev);
+	} else {
+		err = xsc_register_device(dev);
+		if (err) {
+			xsc_core_err(dev, "register device failed %d\n", err);
+			goto err_reg_dev;
+		}
+	}
+
 	set_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
 	mutex_unlock(&dev->intf_state_mutex);
 
 	return 0;
+err_reg_dev:
+	xsc_irq_eq_destroy(dev);
 err_irq_eq_create:
 	xsc_hw_cleanup(dev);
 out:
@@ -305,6 +318,7 @@ static int xsc_load(struct xsc_core_device *dev)
 
 static int xsc_unload(struct xsc_core_device *dev)
 {
+	xsc_unregister_device(dev);
 	mutex_lock(&dev->intf_state_mutex);
 	if (!test_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state)) {
 		xsc_core_warn(dev, "%s: interface is down, NOP\n",
@@ -314,6 +328,8 @@ static int xsc_unload(struct xsc_core_device *dev)
 	}
 
 	clear_bit(XSC_INTERFACE_STATE_UP, &dev->intf_state);
+	if (xsc_device_registered(dev))
+		xsc_detach_device(dev);
 	xsc_irq_eq_destroy(dev);
 	xsc_hw_cleanup(dev);
 
-- 
2.43.0


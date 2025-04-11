Return-Path: <netdev+bounces-181516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF88A854C4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BC3D7A9A84
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A58727E1AC;
	Fri, 11 Apr 2025 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="NYtX6JR6"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F027E1A4
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 06:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354403; cv=none; b=FalEwIm+uIY7mVxxx2iKrwfucUHpdwJTHdcwHekvcCxKB4Rs8B/vUe58ufYCwj0hPhTpW3GdqmxQDJKSm7giDs4SQwuBf15XQ8aqssXgI/ZUhHtF4CMaaKdsT1xLNcKUu14Ccj3kKLmctKkx+WA27G16Z4qNVcQjIBWlJwcFy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354403; c=relaxed/simple;
	bh=EM/rq1y88Z+q0tx3qVgxlkkOAEPmjcgnrdLt2cicOe4=;
	h=To:References:Cc:From:Message-Id:Subject:Content-Type:Date:
	 Mime-Version:In-Reply-To; b=Ll7S31nRV88j2568TclMLpF6iHaJqnE01eb804w05oistbC+/kpmpwaN0Y1VAJz4wTRfdeVKs1+oFczkb0frhluKnlRjjpC5OWZ/Z3o2JJYNzExgNLsTBdRtkzs1+KlltlRMglRwDKLy0WXAXvyY7PGyADTBJB5xupd4UrPJ36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=NYtX6JR6; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744354387; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=RyeucjvJbI3qENFs+ajiDlbyvtoDSyBykK6Ec/J/tfI=;
 b=NYtX6JR64PVxoJ7+QllwCpZWuY3+p56xgqWrD5Ye0gwkLntb/hCTw/f7BtfvxwkWxqCNtl
 SHSG/YMs6iW0wI5WR6P9aGvFPdLrNc5cBs3+3b46VpLpqQ07LpWqlZdBa47KCEH31eufAp
 7ISJi9Oq8IMIQ7FnDtz+wWlMHlON9lfDpQGuz2NWhgJ9AyOe/N4rDa3MbZSUziyM0Tg1Gu
 Wya6STUvOlCyAqXNCy/ceBpQkvuoMRal/z8aoxWiPWpmEOc+H36t3/4EIm2B/ELuo2ejLn
 CSiFW7D6+LVcPCPaRf2+alIWpWbUvAlKt5UgBxH/2ewK1z99NjKFKif5qFiU8g==
To: <netdev@vger.kernel.org>
References: <20250411065246.2303550-1-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250411065302.2303550-7-tianx@yunsilicon.com>
Subject: [PATCH net-next v10 06/14] xsc: Init pci irq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Date: Fri, 11 Apr 2025 14:53:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
In-Reply-To: <20250411065246.2303550-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267f8bc51+8b23d5+vger.kernel.org+tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 11 Apr 2025 14:53:04 +0800

This patch implements the initialization of PCI MSI-X interrupts.
It handles the allocation of MSI-X interrupt vectors, registration
of interrupt requests (IRQs), configuration of interrupt affinity
, and interrupt handlers for different event types, including:

- Completion events (handled via completion queues).
- Command queue (cmdq) events (via xsc_cmd_handler).
- Asynchronous events (via xsc_event_handler).

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   6 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  14 +-
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c | 426 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |  14 +
 5 files changed, 460 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 78a77c708..60dde506e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -347,9 +347,12 @@ struct xsc_dev_resource {
 struct xsc_core_device {
 	struct pci_dev		*pdev;
 	struct device		*device;
+	void			*eth_priv;
 	struct xsc_dev_resource	*dev_res;
 	int			numa_node;
 
+	void (*event_handler)(void *adapter);
+
 	void __iomem		*bar;
 	int			bar_num;
 
@@ -376,6 +379,7 @@ struct xsc_core_device {
 	u16			fw_version_patch;
 	u32			fw_version_tweak;
 	u8			fw_version_extra_flag;
+	cpumask_var_t		xps_cpumask;
 };
 
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
@@ -383,6 +387,8 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
 struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i);
+int xsc_core_vector2eqn(struct xsc_core_device *xdev, int vector, u32 *eqn,
+			unsigned int *irqn);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
 {
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 667319958..3525d1c74 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o pci_irq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index cad807e6b..febbca244 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -9,6 +9,7 @@
 #include "qp.h"
 #include "cq.h"
 #include "eq.h"
+#include "pci_irq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -205,14 +206,25 @@ static int xsc_load(struct xsc_core_device *xdev)
 	err = xsc_hw_setup(xdev);
 	if (err) {
 		pci_err(xdev->pdev, "xsc_hw_setup failed %d\n", err);
-		return err;
+		goto err_out;
+	}
+
+	err = xsc_irq_eq_create(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_irq_eq_create failed %d\n", err);
+		goto err_hw_cleanup;
 	}
 
 	return 0;
+err_hw_cleanup:
+	xsc_hw_cleanup(xdev);
+err_out:
+	return err;
 }
 
 static void xsc_unload(struct xsc_core_device *xdev)
 {
+	xsc_irq_eq_destroy(xdev);
 	xsc_hw_cleanup(xdev);
 }
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
new file mode 100644
index 000000000..f8f95978b
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/interrupt.h>
+#include <linux/notifier.h>
+#include <linux/module.h>
+#ifdef CONFIG_RFS_ACCEL
+#include <linux/cpu_rmap.h>
+#endif
+
+#include "common/xsc_cmd_api.h"
+#include "common/xsc_core.h"
+#include "eq.h"
+#include "pci_irq.h"
+
+enum {
+	XSC_COMP_EQ_SIZE = 1024,
+};
+
+enum xsc_eq_type {
+	XSC_EQ_TYPE_COMP,
+	XSC_EQ_TYPE_ASYNC,
+};
+
+struct xsc_irq {
+	struct atomic_notifier_head nh;
+	cpumask_var_t mask;
+	char name[XSC_MAX_IRQ_NAME];
+};
+
+struct xsc_irq_table {
+	struct xsc_irq *irq;
+	int nvec;
+#ifdef CONFIG_RFS_ACCEL
+	struct cpu_rmap *rmap;
+#endif
+};
+
+static void xsc_free_irq(struct xsc_core_device *xdev, unsigned int vector)
+{
+	unsigned int irqn = 0;
+
+	irqn = pci_irq_vector(xdev->pdev, vector);
+	disable_irq(irqn);
+
+	if (xsc_fw_is_available(xdev))
+		free_irq(irqn, xdev);
+}
+
+static int set_comp_irq_affinity_hint(struct xsc_core_device *xdev, int i)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	struct xsc_eq *eq = xsc_core_eq_get(xdev, i);
+	int vecidx = table->eq_vec_comp_base + i;
+	unsigned int irqn;
+	int ret;
+
+	irqn = pci_irq_vector(xdev->pdev, vecidx);
+	if (!zalloc_cpumask_var(&eq->mask, GFP_KERNEL)) {
+		pci_err(xdev->pdev, "zalloc_cpumask_var rx cpumask failed");
+		return -ENOMEM;
+	}
+
+	if (!zalloc_cpumask_var(&xdev->xps_cpumask, GFP_KERNEL)) {
+		pci_err(xdev->pdev, "zalloc_cpumask_var tx cpumask failed");
+		return -ENOMEM;
+	}
+
+	cpumask_set_cpu(cpumask_local_spread(i, xdev->numa_node),
+			xdev->xps_cpumask);
+	ret = irq_set_affinity_hint(irqn, eq->mask);
+
+	return ret;
+}
+
+static void clear_comp_irq_affinity_hint(struct xsc_core_device *xdev, int i)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	struct xsc_eq *eq = xsc_core_eq_get(xdev, i);
+	int vecidx = table->eq_vec_comp_base + i;
+	int irqn;
+
+	irqn = pci_irq_vector(xdev->pdev, vecidx);
+	irq_set_affinity_hint(irqn, NULL);
+	free_cpumask_var(eq->mask);
+}
+
+static int set_comp_irq_affinity_hints(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	int nvec = table->num_comp_vectors;
+	int err;
+	int i;
+
+	for (i = 0; i < nvec; i++) {
+		err = set_comp_irq_affinity_hint(xdev, i);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	for (i--; i >= 0; i--)
+		clear_comp_irq_affinity_hint(xdev, i);
+	free_cpumask_var(xdev->xps_cpumask);
+
+	return err;
+}
+
+static void clear_comp_irq_affinity_hints(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	int nvec = table->num_comp_vectors;
+	int i;
+
+	for (i = 0; i < nvec; i++)
+		clear_comp_irq_affinity_hint(xdev, i);
+	free_cpumask_var(xdev->xps_cpumask);
+}
+
+static int xsc_alloc_irq_vectors(struct xsc_core_device *xdev)
+{
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+	struct xsc_eq_table *table = &dev_res->eq_table;
+	int nvec = xdev->caps.msix_num;
+	int nvec_base;
+	int err;
+
+	nvec_base = XSC_EQ_VEC_COMP_BASE;
+	if (nvec <= nvec_base) {
+		pci_err(xdev->pdev, "failed to alloc irq vector(%d)\n", nvec);
+		return -ENOMEM;
+	}
+
+	dev_res->irq_info = kcalloc(nvec, sizeof(*dev_res->irq_info),
+				    GFP_KERNEL);
+	if (!dev_res->irq_info)
+		return -ENOMEM;
+
+	nvec = pci_alloc_irq_vectors(xdev->pdev, nvec_base + 1, nvec,
+				     PCI_IRQ_MSIX);
+	if (nvec < 0) {
+		err = nvec;
+		goto err_free_irq_info;
+	}
+
+	table->eq_vec_comp_base = nvec_base;
+	table->num_comp_vectors = nvec - nvec_base;
+	xdev->msix_vec_base = xdev->caps.msix_base;
+
+	return 0;
+
+err_free_irq_info:
+	kfree(dev_res->irq_info);
+	return err;
+}
+
+static void xsc_free_irq_vectors(struct xsc_core_device *xdev)
+{
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+
+	if (!xsc_fw_is_available(xdev))
+		return;
+
+	pci_free_irq_vectors(xdev->pdev);
+	kfree(dev_res->irq_info);
+}
+
+int xsc_core_vector2eqn(struct xsc_core_device *xdev, int vector, u32 *eqn,
+			unsigned int *irqn)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	struct xsc_eq *eq, *n;
+	int err = -ENOENT;
+
+	if (!xdev->caps.msix_enable)
+		return 0;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		if (eq->index == vector) {
+			*eqn = eq->eqn;
+			*irqn = eq->irqn;
+			err = 0;
+			break;
+		}
+	}
+	spin_unlock(&table->lock);
+
+	return err;
+}
+EXPORT_SYMBOL(xsc_core_vector2eqn);
+
+static void free_comp_eqs(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	struct xsc_eq *eq, *n;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		list_del(&eq->list);
+		spin_unlock(&table->lock);
+		if (xsc_destroy_unmap_eq(xdev, eq))
+			pci_err(xdev->pdev, "failed to destroy EQ 0x%x\n",
+				eq->eqn);
+		kfree(eq);
+		spin_lock(&table->lock);
+	}
+	spin_unlock(&table->lock);
+}
+
+static int alloc_comp_eqs(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	char name[XSC_MAX_IRQ_NAME];
+	struct xsc_eq *eq;
+	int ncomp_vec;
+	u32 nent;
+	int err;
+	int i;
+
+	INIT_LIST_HEAD(&table->comp_eqs_list);
+	ncomp_vec = table->num_comp_vectors;
+	nent = XSC_COMP_EQ_SIZE;
+
+	for (i = 0; i < ncomp_vec; i++) {
+		eq = kzalloc(sizeof(*eq), GFP_KERNEL);
+		if (!eq) {
+			err = -ENOMEM;
+			goto err_free;
+		}
+
+		snprintf(name, XSC_MAX_IRQ_NAME, "xsc_comp%d", i);
+		err = xsc_create_map_eq(xdev, eq,
+					i + table->eq_vec_comp_base,
+					nent, name);
+		if (err) {
+			kfree(eq);
+			goto err_free;
+		}
+
+		eq->index = i;
+		spin_lock(&table->lock);
+		list_add_tail(&eq->list, &table->comp_eqs_list);
+		spin_unlock(&table->lock);
+	}
+
+	return 0;
+
+err_free:
+	free_comp_eqs(xdev);
+	return err;
+}
+
+static irqreturn_t xsc_cmd_handler(int irq, void *arg)
+{
+	struct xsc_core_device *xdev = (struct xsc_core_device *)arg;
+	int err;
+
+	disable_irq_nosync(xdev->cmd.irqn);
+	err = xsc_cmd_err_handler(xdev);
+	if (!err)
+		xsc_cmd_resp_handler(xdev);
+	enable_irq(xdev->cmd.irqn);
+
+	return IRQ_HANDLED;
+}
+
+static int xsc_request_irq_for_cmdq(struct xsc_core_device *xdev, u8 vecidx)
+{
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+
+	writel(xdev->msix_vec_base + vecidx,
+	       XSC_REG_ADDR(xdev, xdev->cmd.reg.msix_vec_addr));
+
+	snprintf(dev_res->irq_info[vecidx].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 "xsc_cmd", pci_name(xdev->pdev));
+	xdev->cmd.irqn = pci_irq_vector(xdev->pdev, vecidx);
+	return request_irq(xdev->cmd.irqn, xsc_cmd_handler, 0,
+		dev_res->irq_info[vecidx].name, xdev);
+}
+
+static void xsc_free_irq_for_cmdq(struct xsc_core_device *xdev)
+{
+	xsc_free_irq(xdev, XSC_VEC_CMD);
+}
+
+static irqreturn_t xsc_event_handler(int irq, void *arg)
+{
+	struct xsc_core_device *xdev = (struct xsc_core_device *)arg;
+
+	if (!xdev->eth_priv)
+		return IRQ_NONE;
+
+	if (!xdev->event_handler)
+		return IRQ_NONE;
+
+	xdev->event_handler(xdev->eth_priv);
+
+	return IRQ_HANDLED;
+}
+
+static int xsc_request_irq_for_event(struct xsc_core_device *xdev)
+{
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+
+	snprintf(dev_res->irq_info[XSC_VEC_CMD_EVENT].name,
+		 XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 "xsc_eth_event", pci_name(xdev->pdev));
+	return request_irq(pci_irq_vector(xdev->pdev, XSC_VEC_CMD_EVENT),
+			   xsc_event_handler, 0,
+			   dev_res->irq_info[XSC_VEC_CMD_EVENT].name, xdev);
+}
+
+static void xsc_free_irq_for_event(struct xsc_core_device *xdev)
+{
+	xsc_free_irq(xdev, XSC_VEC_CMD_EVENT);
+}
+
+static int xsc_cmd_enable_msix(struct xsc_core_device *xdev)
+{
+	struct xsc_msix_table_info_mbox_out out;
+	struct xsc_msix_table_info_mbox_in in;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_ENABLE_MSIX);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err) {
+		pci_err(xdev->pdev, "xsc_cmd_exec enable msix failed %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+int xsc_irq_eq_create(struct xsc_core_device *xdev)
+{
+	int err;
+
+	if (xdev->caps.msix_enable == 0)
+		return 0;
+
+	err = xsc_alloc_irq_vectors(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "enable msix failed, err=%d\n", err);
+		goto err_out;
+	}
+
+	err = xsc_start_eqs(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to start EQs, err=%d\n", err);
+		goto err_free_irq_vectors;
+	}
+
+	err = alloc_comp_eqs(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to alloc comp EQs, err=%d\n", err);
+		goto err_stop_eqs;
+	}
+
+	err = xsc_request_irq_for_cmdq(xdev, XSC_VEC_CMD);
+	if (err) {
+		pci_err(xdev->pdev, "failed to request irq for cmdq, err=%d\n",
+			err);
+		goto err_free_comp_eqs;
+	}
+
+	err = xsc_request_irq_for_event(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to request irq for event, err=%d\n",
+			err);
+		goto err_free_irq_cmdq;
+	}
+
+	err = set_comp_irq_affinity_hints(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to alloc affinity hint cpumask, err=%d\n",
+			err);
+		goto err_free_irq_evnt;
+	}
+
+	xsc_cmd_use_events(xdev);
+	err = xsc_cmd_enable_msix(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_cmd_enable_msix failed %d.\n", err);
+		xsc_cmd_use_polling(xdev);
+		goto err_free_irq_evnt;
+	}
+	return 0;
+
+err_free_irq_evnt:
+	xsc_free_irq_for_event(xdev);
+err_free_irq_cmdq:
+	xsc_free_irq_for_cmdq(xdev);
+err_free_comp_eqs:
+	free_comp_eqs(xdev);
+err_stop_eqs:
+	xsc_stop_eqs(xdev);
+err_free_irq_vectors:
+	xsc_free_irq_vectors(xdev);
+err_out:
+	return err;
+}
+
+void xsc_irq_eq_destroy(struct xsc_core_device *xdev)
+{
+	if (xdev->caps.msix_enable == 0)
+		return;
+
+	xsc_stop_eqs(xdev);
+	clear_comp_irq_affinity_hints(xdev);
+	free_comp_eqs(xdev);
+
+	xsc_free_irq_for_event(xdev);
+	xsc_free_irq_for_cmdq(xdev);
+	xsc_free_irq_vectors(xdev);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
new file mode 100644
index 000000000..9a88e5b2c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __XSC_PCI_IRQ_H
+#define __XSC_PCI_IRQ_H
+
+#include "common/xsc_core.h"
+
+int xsc_irq_eq_create(struct xsc_core_device *xdev);
+void xsc_irq_eq_destroy(struct xsc_core_device *xdev);
+
+#endif
-- 
2.43.0


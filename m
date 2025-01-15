Return-Path: <netdev+bounces-158459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B761A11F25
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17057A037D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BE122F3A4;
	Wed, 15 Jan 2025 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="fxO6lbov"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0A20C499
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936588; cv=none; b=ClkWL6SDRt74WYej6Dz45x3UCMP+dfPNXhOTCyQonFaMz0J8MR4PjC6CCwMQ+eCzDKqM3b8OqOfkavp8q1VG+P5hUKSkbmuiZOUIlEAcETg/QM2y3oHsT7q5HqKUQuBqjBKeFMxhqlbmGK4V8xK+TFScRIPOhGoTEdqM54bwem0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936588; c=relaxed/simple;
	bh=MBIejebeeH9de3FU5+tcMv3wVsgkPFZvSAVpoYTWEJA=;
	h=From:Mime-Version:Content-Type:Cc:Subject:Message-Id:To:Date:
	 References:In-Reply-To; b=hAWAHZ7T6Z5AOqfdk/vKkHmyWsAdoCfvxX4Qd+80z8QE1iNMSjRVTUPuHTGHOUWKubBla2VOfn7B8YolMqKA2j1wAnNJ8uLy6BV7EDLqeR7Sk7WD9wConFZm5+n0RlUEuBin7iugsc5ANWEJfaxuAtNrZr+wUuauYzrZKkQJMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=fxO6lbov; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1736936578; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UIaBBR0z41nxjNO+R+dT+CcMTLFmWl4tdMWt4T3V+5Y=;
 b=fxO6lbovLGHrla/0qXdhw76tVmqVvASwNjnnd/dstJVz65LEmzuEQp9gLVdaqzx35GGtso
 n3SY606cLWGuqyCcwwWjQv9xbnAn8ogcmBkYEcMnVtDhfxeuwn8mO2eUzbsQse+4JFz8zo
 OwbtdJGRWs4wgbtgj5OvmVF+jxwF6wfs7xx5zEK+V6wFkHCfw8jabYo/O+EG0+2t6hNXJb
 er1+UhxxWBxKNvna9JdB2UM56UZ3C4omkNP7NtoaOQoGESDEWt4H0gg8Tgk1wop1ZT2/1m
 3K2zfYVpM/t7cBPSwSJ51ty6I7dXdotX6f2XfIDmHXeAg+3wAs50SWHYsuVNBA==
From: "Xin Tian" <tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: [PATCH v3 06/14] net-next/yunsilicon: Add pci irq
Message-Id: <20250115102254.3541496-7-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Date: Wed, 15 Jan 2025 18:22:55 +0800
X-Lms-Return-Path: <lba+267878c80+4dcfaa+vger.kernel.org+tianx@yunsilicon.com>
References: <20250115102242.3541496-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 15 Jan 2025 18:22:55 +0800
In-Reply-To: <20250115102242.3541496-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1

Implement interrupt management and event handling

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   6 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  11 +-
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c | 419 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |  14 +
 5 files changed, 450 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index afd4d4a43..2e6ff6204 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -374,9 +374,12 @@ enum xsc_interface_state {
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
 
@@ -408,6 +411,7 @@ struct xsc_core_device {
 	u16			fw_version_patch;
 	u32			fw_version_tweak;
 	u8			fw_version_extra_flag;
+	cpumask_var_t		xps_cpumask;
 };
 
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
@@ -415,6 +419,8 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
 struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i);
+int xsc_core_vector2eqn(struct xsc_core_device *xdev, int vector, int *eqn,
+			unsigned int *irqn);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
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
index bde6d85d0..0acc3f080 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -9,6 +9,7 @@
 #include "qp.h"
 #include "cq.h"
 #include "eq.h"
+#include "pci_irq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -248,10 +249,18 @@ static int xsc_load(struct xsc_core_device *xdev)
 		goto out;
 	}
 
+	err = xsc_irq_eq_create(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "xsc_irq_eq_create failed %d\n", err);
+		goto err_hw_cleanup;
+	}
+
 	set_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
 	mutex_unlock(&xdev->intf_state_mutex);
 
 	return 0;
+err_hw_cleanup:
+	xsc_hw_cleanup(xdev);
 out:
 	mutex_unlock(&xdev->intf_state_mutex);
 	return err;
@@ -266,7 +275,7 @@ static int xsc_unload(struct xsc_core_device *xdev)
 	}
 
 	clear_bit(XSC_INTERFACE_STATE_UP, &xdev->intf_state);
-
+	xsc_irq_eq_destroy(xdev);
 	xsc_hw_cleanup(xdev);
 
 out:
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
new file mode 100644
index 000000000..56965c576
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
@@ -0,0 +1,419 @@
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
+#include "common/xsc_driver.h"
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
+struct xsc_msix_resource *g_msix_xres;
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
+	int vecidx = table->eq_vec_comp_base + i;
+	struct xsc_eq *eq = xsc_core_eq_get(xdev, i);
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
+	int vecidx = table->eq_vec_comp_base + i;
+	struct xsc_eq *eq = xsc_core_eq_get(xdev, i);
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
+	dev_res->irq_info = kcalloc(nvec, sizeof(*dev_res->irq_info), GFP_KERNEL);
+	if (!dev_res->irq_info)
+		return -ENOMEM;
+
+	nvec = pci_alloc_irq_vectors(xdev->pdev, nvec_base + 1, nvec, PCI_IRQ_MSIX);
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
+	pci_free_irq_vectors(xdev->pdev);
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
+int xsc_core_vector2eqn(struct xsc_core_device *xdev, int vector, int *eqn,
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
+			pci_err(xdev->pdev, "failed to destroy EQ 0x%x\n", eq->eqn);
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
+	int nent;
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
+			goto clean;
+		}
+
+		snprintf(name, XSC_MAX_IRQ_NAME, "xsc_comp%d", i);
+		err = xsc_create_map_eq(xdev, eq,
+					i + table->eq_vec_comp_base, nent, name);
+		if (err) {
+			kfree(eq);
+			goto clean;
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
+clean:
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
+	writel(xdev->msix_vec_base + vecidx, REG_ADDR(xdev, xdev->cmd.reg.msix_vec_addr));
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
+	snprintf(dev_res->irq_info[XSC_VEC_CMD_EVENT].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 "xsc_eth_event", pci_name(xdev->pdev));
+	return request_irq(pci_irq_vector(xdev->pdev, XSC_VEC_CMD_EVENT), xsc_event_handler, 0,
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
+	struct xsc_msix_table_info_mbox_in in;
+	struct xsc_msix_table_info_mbox_out out;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_ENABLE_MSIX);
+
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err) {
+		pci_err(xdev->pdev, "xsc_cmd_exec enable msix failed %d\n", err);
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
+		goto out;
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
+		pci_err(xdev->pdev, "failed to request irq for cmdq, err=%d\n", err);
+		goto err_free_comp_eqs;
+	}
+
+	err = xsc_request_irq_for_event(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to request irq for event, err=%d\n", err);
+		goto err_free_irq_cmdq;
+	}
+
+	err = set_comp_irq_affinity_hints(xdev);
+	if (err) {
+		pci_err(xdev->pdev, "failed to alloc affinity hint cpumask, err=%d\n", err);
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
+out:
+	return err;
+}
+
+int xsc_irq_eq_destroy(struct xsc_core_device *xdev)
+{
+	if (xdev->caps.msix_enable == 0)
+		return 0;
+
+	xsc_stop_eqs(xdev);
+	clear_comp_irq_affinity_hints(xdev);
+	free_comp_eqs(xdev);
+
+	xsc_free_irq_for_event(xdev);
+	xsc_free_irq_for_cmdq(xdev);
+	xsc_free_irq_vectors(xdev);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
new file mode 100644
index 000000000..7b0aae349
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __PCI_IRQ_H
+#define __PCI_IRQ_H
+
+#include "common/xsc_core.h"
+
+int xsc_irq_eq_create(struct xsc_core_device *xdev);
+int xsc_irq_eq_destroy(struct xsc_core_device *xdev);
+
+#endif
-- 
2.43.0


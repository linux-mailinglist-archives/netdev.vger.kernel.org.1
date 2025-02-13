Return-Path: <netdev+bounces-165912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADDDA33B05
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116C016A7BB
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1796120CCE2;
	Thu, 13 Feb 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="DG3PZGqm"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-45.ptr.blmpb.com (lf-2-45.ptr.blmpb.com [101.36.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380120100D
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438276; cv=none; b=XIU+7pzLeb6nc3wcWAR9BlowXSthcOlTnvU/364Ot81JtlmnkgdTdD+F8oi79bVSRLQWQLX/OS+Ig9iL42+AiYDb9mbr2XGekAHU6OEC4v0UE//X3SeLHrahywNtpIFmuKbx8puDkt2/CoADh6U/OyA+uC59bFrcbDLFy6TUj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438276; c=relaxed/simple;
	bh=1bbs7oupm1vWpjGaV/HhXDAx2cXHwWpQ2D2KMaidImU=;
	h=Date:Mime-Version:References:In-Reply-To:Cc:Subject:To:From:
	 Message-Id:Content-Type; b=b8/UajLDlnZvzoHL1WzAfV4D+5Lgsvb8qnyCSp61W+FRXvndDtNTeWNogwtwCIO1uCPWK5O2awcoaFXTcgPzBak2lZjq/4ouGt3oFgswZ30NdBrjKIyaHbMgJimuhfEvKFkrWtXUK6Cp+lzmBwSj12cQMMmBLrbHG01pND7IOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=DG3PZGqm; arc=none smtp.client-ip=101.36.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739438056; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HmNapZ5ZqBOjDZEN1j8XNQXatSFd1jEJFIXLevy6A6s=;
 b=DG3PZGqmuFhUKlwm+pRAFGlRuQ4poBfUm4M2yo60C+5+lyEBxe0VHUH+G1d4XnlVoQrWz0
 /Xx3+gAWb0nLWEASRBHVMi90/6Kr5tUWQ5m1SDkrvGxADjv7GiktfSpmsTulTlCYtNqi1J
 axnFVi2X7nzjgreXsk3stmESfjsaxnqUiQFCwUvRUh0MoLCvq58b69HgNCgnqYxBxeFAl0
 bzYYZV4tkU8mjL/TSh8xw2w95HK/TWqPe5QnfovkxZdtygRZOtAIL7wf2xWLMLlRXmRKID
 tjAjU0iMV6F4vO/l6ZM8ixJHZe4UcaJYpFzk+KEZkk6rz/Ha+8I0IeGm+Ziexg==
Date: Thu, 13 Feb 2025 17:14:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
In-Reply-To: <20250213091402.2067626-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+267adb7e6+fc467c+vger.kernel.org+tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: [PATCH v4 05/14] net-next/yunsilicon: Add eq and alloc
X-Mailer: git-send-email 2.25.1
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250213091412.2067626-6-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 13 Feb 2025 17:14:14 +0800
Content-Type: text/plain; charset=UTF-8

Add eq management and buffer alloc apis

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  39 ++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   | 133 +++++++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |  15 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  | 344 ++++++++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |  49 +++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   2 +
 7 files changed, 583 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 4e19b0989..43bbe9dcd 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -27,6 +27,10 @@
 #define XSC_MV_HOST_VF_DEV_ID		0x1152
 #define XSC_MV_SOC_PF_DEV_ID		0x1153
 
+#define PAGE_SHIFT_4K          12
+#define PAGE_SIZE_4K           (_AC(1, UL) << PAGE_SHIFT_4K)
+#define PAGE_MASK_4K           (~(PAGE_SIZE_4K - 1))
+
 #define XSC_REG_ADDR(dev, offset)	\
 	(((dev)->bar) + ((offset) - 0xA0000000))
 #define XSC_SET_FIELD(value, field)	\
@@ -38,6 +42,10 @@ enum {
 	XSC_MAX_EQ_NAME	= 20
 };
 
+enum {
+	XSC_MAX_IRQ_NAME	= 32
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -177,6 +185,7 @@ struct xsc_cq_table {
 	struct radix_tree_root	tree;
 };
 
+// eq
 struct xsc_eq {
 	struct xsc_core_device	*dev;
 	struct xsc_cq_table	cq_table;
@@ -193,6 +202,26 @@ struct xsc_eq {
 	int			index;
 };
 
+struct xsc_eq_table {
+	void __iomem	       *update_ci;
+	void __iomem	       *update_arm_ci;
+	struct list_head       comp_eqs_list;
+	struct xsc_eq		pages_eq;
+	struct xsc_eq		async_eq;
+	struct xsc_eq		cmd_eq;
+	int			num_comp_vectors;
+	int			eq_vec_comp_base;
+	/* protect EQs list
+	 */
+	spinlock_t		lock;
+};
+
+// irq
+struct xsc_irq_info {
+	cpumask_var_t mask;
+	char name[XSC_MAX_IRQ_NAME];
+};
+
 // hw
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -321,6 +350,8 @@ struct xsc_caps {
 struct xsc_dev_resource {
 	struct xsc_qp_table	qp_table;
 	struct xsc_cq_table	cq_table;
+	struct xsc_eq_table	eq_table;
+	struct xsc_irq_info	*irq_info;
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
 };
@@ -346,6 +377,8 @@ struct xsc_core_device {
 	u8			mac_port;
 	u16			glb_func_id;
 
+	u16			msix_vec_base;
+
 	struct xsc_cmd		cmd;
 	u16			cmdq_ver;
 
@@ -375,6 +408,7 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 				    struct xsc_core_qp *qp);
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
+struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 {
@@ -385,4 +419,9 @@ static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
 			(offset & (PAGE_SIZE - 1));
 }
 
+static inline bool xsc_fw_is_available(struct xsc_core_device *xdev)
+{
+	return xdev->cmd.cmd_status == XSC_CMD_STATUS_NORMAL;
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index 9a4a6e02d..667319958 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,5 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o
-
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o alloc.o eq.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
new file mode 100644
index 000000000..d6be90aba
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/export.h>
+#include <linux/bitmap.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+
+#include "alloc.h"
+
+/* Handling for queue buffers -- we allocate a bunch of memory and
+ * register it in a memory region at HCA virtual address 0.  If the
+ * requested size is > max_direct, we split the allocation into
+ * multiple pages, so we don't require too much contiguous memory.
+ */
+int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
+		  struct xsc_buf *buf)
+{
+	dma_addr_t t;
+
+	buf->size = size;
+	if (size <= max_direct) {
+		buf->nbufs        = 1;
+		buf->npages       = 1;
+		buf->page_shift   = get_order(size) + PAGE_SHIFT;
+		buf->direct.buf   = dma_alloc_coherent(&xdev->pdev->dev,
+						       size,
+						       &t,
+						       GFP_KERNEL | __GFP_ZERO);
+		if (!buf->direct.buf)
+			return -ENOMEM;
+
+		buf->direct.map = t;
+
+		while (t & ((1 << buf->page_shift) - 1)) {
+			--buf->page_shift;
+			buf->npages *= 2;
+		}
+	} else {
+		int i;
+
+		buf->direct.buf  = NULL;
+		buf->nbufs       = (size + PAGE_SIZE - 1) / PAGE_SIZE;
+		buf->npages      = buf->nbufs;
+		buf->page_shift  = PAGE_SHIFT;
+		buf->page_list   = kcalloc(buf->nbufs, sizeof(*buf->page_list),
+					   GFP_KERNEL);
+		if (!buf->page_list)
+			return -ENOMEM;
+
+		for (i = 0; i < buf->nbufs; i++) {
+			buf->page_list[i].buf =
+				dma_alloc_coherent(&xdev->pdev->dev, PAGE_SIZE,
+						   &t, GFP_KERNEL | __GFP_ZERO);
+			if (!buf->page_list[i].buf)
+				goto err_free;
+
+			buf->page_list[i].map = t;
+		}
+
+		if (BITS_PER_LONG == 64) {
+			struct page **pages;
+
+			pages = kmalloc_array(buf->nbufs, sizeof(*pages),
+					      GFP_KERNEL);
+			if (!pages)
+				goto err_free;
+			for (i = 0; i < buf->nbufs; i++) {
+				void *addr = buf->page_list[i].buf;
+
+				if (is_vmalloc_addr(addr))
+					pages[i] = vmalloc_to_page(addr);
+				else
+					pages[i] = virt_to_page(addr);
+			}
+			buf->direct.buf = vmap(pages, buf->nbufs,
+					       VM_MAP, PAGE_KERNEL);
+			kfree(pages);
+			if (!buf->direct.buf)
+				goto err_free;
+		}
+	}
+
+	return 0;
+
+err_free:
+	xsc_buf_free(xdev, buf);
+
+	return -ENOMEM;
+}
+
+void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf)
+{
+	int i;
+
+	if (buf->nbufs == 1) {
+		dma_free_coherent(&xdev->pdev->dev, buf->size, buf->direct.buf,
+				  buf->direct.map);
+	} else {
+		if (BITS_PER_LONG == 64 && buf->direct.buf)
+			vunmap(buf->direct.buf);
+
+		for (i = 0; i < buf->nbufs; i++)
+			if (buf->page_list[i].buf)
+				dma_free_coherent(&xdev->pdev->dev, PAGE_SIZE,
+						  buf->page_list[i].buf,
+						  buf->page_list[i].map);
+		kfree(buf->page_list);
+	}
+}
+
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
+{
+	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
+	int mask = (1 << shift) - 1;
+	u64 addr;
+	int i;
+
+	for (i = 0; i < npages; i++) {
+		if (buf->nbufs == 1)
+			addr = buf->direct.map + (i << PAGE_SHIFT_4K);
+		else
+			addr = buf->page_list[i >> shift].map
+			       + ((i & mask) << PAGE_SHIFT_4K);
+
+		pas[i] = cpu_to_be64(addr);
+	}
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
new file mode 100644
index 000000000..f3d9a6e0a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __ALLOC_H
+#define __ALLOC_H
+
+#include "common/xsc_core.h"
+
+int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
+		  struct xsc_buf *buf);
+void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf);
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages);
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
new file mode 100644
index 000000000..d428732ea
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+
+#include "common/xsc_driver.h"
+#include "common/xsc_core.h"
+#include "qp.h"
+#include "alloc.h"
+#include "eq.h"
+
+enum {
+	XSC_EQE_SIZE		= sizeof(struct xsc_eqe),
+};
+
+enum {
+	XSC_NUM_SPARE_EQE	= 0x80,
+	XSC_NUM_ASYNC_EQE	= 0x100,
+};
+
+static int xsc_cmd_destroy_eq(struct xsc_core_device *xdev, u32 eqn)
+{
+	struct xsc_destroy_eq_mbox_out out;
+	struct xsc_destroy_eq_mbox_in in;
+	int err;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DESTROY_EQ);
+	in.eqn = cpu_to_be32(eqn);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (!err)
+		goto ex;
+
+	if (out.hdr.status)
+		err = xsc_cmd_status_to_err(&out.hdr);
+
+ex:
+	return err;
+}
+
+static struct xsc_eqe *get_eqe(struct xsc_eq *eq, u32 entry)
+{
+	return xsc_buf_offset(&eq->buf, entry * XSC_EQE_SIZE);
+}
+
+static struct xsc_eqe *next_eqe_sw(struct xsc_eq *eq)
+{
+	struct xsc_eqe *eqe = get_eqe(eq, eq->cons_index & (eq->nent - 1));
+
+	return ((eqe->owner_data & XSC_EQE_OWNER) ^
+		!!(eq->cons_index & eq->nent)) ? NULL : eqe;
+}
+
+static void eq_update_ci(struct xsc_eq *eq, int arm)
+{
+	struct xsc_eq_doorbell db = {0};
+
+	db.data0 = XSC_SET_FIELD(cpu_to_le32(eq->cons_index),
+				 XSC_EQ_DB_NEXT_CID) |
+		   XSC_SET_FIELD(cpu_to_le32(eq->eqn), XSC_EQ_DB_EQ_ID);
+	if (arm)
+		db.data0 |= XSC_EQ_DB_ARM;
+	writel(db.data0, XSC_REG_ADDR(eq->dev, eq->doorbell));
+	/* We still want ordering, just not swabbing, so add a barrier */
+	mb();
+}
+
+static void xsc_cq_completion(struct xsc_core_device *xdev, u32 cqn)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	struct xsc_core_cq *cq;
+
+	rcu_read_lock();
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (likely(cq))
+		atomic_inc(&cq->refcount);
+	rcu_read_unlock();
+
+	if (!cq) {
+		pci_err(xdev->pdev, "Completion event for bogus CQ, cqn=%d\n",
+			cqn);
+		return;
+	}
+
+	++cq->arm_sn;
+
+	if (!cq->comp)
+		pci_err(xdev->pdev, "cq->comp is NULL\n");
+	else
+		cq->comp(cq);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+static void xsc_eq_cq_event(struct xsc_core_device *xdev,
+			    u32 cqn, int event_type)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	struct xsc_core_cq *cq;
+
+	spin_lock(&table->lock);
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (likely(cq))
+		atomic_inc(&cq->refcount);
+	spin_unlock(&table->lock);
+
+	if (unlikely(!cq)) {
+		pci_err(xdev->pdev, "Async event for bogus CQ, cqn=%d\n",
+			cqn);
+		return;
+	}
+
+	cq->event(cq, event_type);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+static int xsc_eq_int(struct xsc_core_device *xdev, struct xsc_eq *eq)
+{
+	u32 cqn, qpn, queue_id;
+	struct xsc_eqe *eqe;
+	int eqes_found = 0;
+	int set_ci = 0;
+
+	while ((eqe = next_eqe_sw(eq))) {
+		/* Make sure we read EQ entry contents after we've
+		 * checked the ownership bit.
+		 */
+		rmb();
+		switch (eqe->type) {
+		case XSC_EVENT_TYPE_COMP:
+		case XSC_EVENT_TYPE_INTERNAL_ERROR:
+			/* eqe is changing */
+			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
+							     XSC_EQE_QUEUE_ID));
+			cqn = queue_id;
+			xsc_cq_completion(xdev, cqn);
+			break;
+
+		case XSC_EVENT_TYPE_CQ_ERROR:
+			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
+							     XSC_EQE_QUEUE_ID));
+			cqn = queue_id;
+			xsc_eq_cq_event(xdev, cqn, eqe->type);
+			break;
+		case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
+		case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
+		case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
+			queue_id = le16_to_cpu(XSC_GET_FIELD(eqe->queue_id_data,
+							     XSC_EQE_QUEUE_ID));
+			qpn = queue_id;
+			xsc_qp_event(xdev, qpn, eqe->type);
+			break;
+		default:
+			break;
+		}
+
+		++eq->cons_index;
+		eqes_found = 1;
+		++set_ci;
+
+		/* The HCA will think the queue has overflowed if we
+		 * don't tell it we've been processing events.  We
+		 * create our EQs with XSC_NUM_SPARE_EQE extra
+		 * entries, so we must update our consumer index at
+		 * least that often.
+		 */
+		if (unlikely(set_ci >= XSC_NUM_SPARE_EQE)) {
+			eq_update_ci(eq, 0);
+			set_ci = 0;
+		}
+	}
+
+	eq_update_ci(eq, 1);
+
+	return eqes_found;
+}
+
+static irqreturn_t xsc_msix_handler(int irq, void *eq_ptr)
+{
+	struct xsc_core_device *xdev;
+	struct xsc_eq *eq = eq_ptr;
+
+	xdev = eq->dev;
+	xsc_eq_int(xdev, eq);
+
+	/* MSI-X vectors always belong to us */
+	return IRQ_HANDLED;
+}
+
+static void init_eq_buf(struct xsc_eq *eq)
+{
+	struct xsc_eqe *eqe;
+	int i;
+
+	for (i = 0; i < eq->nent; i++) {
+		eqe = get_eqe(eq, i);
+		eqe->owner_data |= XSC_EQE_OWNER;
+	}
+}
+
+int xsc_create_map_eq(struct xsc_core_device *xdev,
+		      struct xsc_eq *eq, u8 vecidx,
+		      int nent, const char *name)
+{
+	u16 msix_vec_offset = xdev->msix_vec_base + vecidx;
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+	struct xsc_create_eq_mbox_out out;
+	struct xsc_create_eq_mbox_in *in;
+	int hw_npages;
+	int inlen;
+	int err;
+
+	eq->nent = roundup_pow_of_two(roundup(nent, XSC_NUM_SPARE_EQE));
+	err = xsc_buf_alloc(xdev, eq->nent * XSC_EQE_SIZE, PAGE_SIZE, &eq->buf);
+	if (err)
+		return err;
+
+	init_eq_buf(eq);
+
+	hw_npages = DIV_ROUND_UP(eq->nent * XSC_EQE_SIZE, PAGE_SIZE_4K);
+	inlen = sizeof(*in) + sizeof(in->pas[0]) * hw_npages;
+	in = kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		err = -ENOMEM;
+		goto err_buf;
+	}
+	memset(&out, 0, sizeof(out));
+
+	xsc_fill_page_array(&eq->buf, in->pas, hw_npages);
+
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_CREATE_EQ);
+	in->ctx.log_eq_sz = ilog2(eq->nent);
+	in->ctx.vecidx = cpu_to_be16(msix_vec_offset);
+	in->ctx.pa_num = cpu_to_be16(hw_npages);
+	in->ctx.glb_func_id = cpu_to_be16(xdev->glb_func_id);
+	in->ctx.is_async_eq = (vecidx == XSC_EQ_VEC_ASYNC ? 1 : 0);
+
+	err = xsc_cmd_exec(xdev, in, inlen, &out, sizeof(out));
+	if (err)
+		goto err_in;
+
+	if (out.hdr.status) {
+		err = -ENOSPC;
+		goto err_in;
+	}
+
+	snprintf(dev_res->irq_info[vecidx].name, XSC_MAX_IRQ_NAME, "%s@pci:%s",
+		 name, pci_name(xdev->pdev));
+
+	eq->eqn = be32_to_cpu(out.eqn);
+	eq->irqn = pci_irq_vector(xdev->pdev, vecidx);
+	eq->dev = xdev;
+	eq->doorbell = xdev->regs.event_db;
+	eq->index = vecidx;
+
+	err = request_irq(eq->irqn, xsc_msix_handler, 0,
+			  dev_res->irq_info[vecidx].name, eq);
+	if (err)
+		goto err_eq;
+
+	/* EQs are created in ARMED state
+	 */
+	eq_update_ci(eq, 1);
+	kvfree(in);
+	return 0;
+
+err_eq:
+	xsc_cmd_destroy_eq(xdev, eq->eqn);
+
+err_in:
+	kvfree(in);
+
+err_buf:
+	xsc_buf_free(xdev, &eq->buf);
+	return err;
+}
+
+int xsc_destroy_unmap_eq(struct xsc_core_device *xdev, struct xsc_eq *eq)
+{
+	int err;
+
+	if (!xsc_fw_is_available(xdev))
+		return 0;
+
+	free_irq(eq->irqn, eq);
+	err = xsc_cmd_destroy_eq(xdev, eq->eqn);
+	if (err)
+		pci_err(xdev->pdev, "failed to destroy a previously created eq: eqn %d\n",
+			eq->eqn);
+	xsc_buf_free(xdev, &eq->buf);
+
+	return err;
+}
+
+void xsc_eq_init(struct xsc_core_device *xdev)
+{
+	spin_lock_init(&xdev->dev_res->eq_table.lock);
+}
+
+int xsc_start_eqs(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	int err;
+
+	err = xsc_create_map_eq(xdev, &table->async_eq, XSC_EQ_VEC_ASYNC,
+				XSC_NUM_ASYNC_EQE, "xsc_async_eq");
+	if (err)
+		pci_err(xdev->pdev, "failed to create async EQ %d\n", err);
+
+	return err;
+}
+
+void xsc_stop_eqs(struct xsc_core_device *xdev)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+
+	xsc_destroy_unmap_eq(xdev, &table->async_eq);
+}
+
+struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i)
+{
+	struct xsc_eq_table *table = &xdev->dev_res->eq_table;
+	struct xsc_eq *eq_ret = NULL;
+	struct xsc_eq *eq, *n;
+
+	spin_lock(&table->lock);
+	list_for_each_entry_safe(eq, n, &table->comp_eqs_list, list) {
+		if (eq->index == i) {
+			eq_ret = eq;
+			break;
+		}
+	}
+	spin_unlock(&table->lock);
+
+	return eq_ret;
+}
+EXPORT_SYMBOL(xsc_core_eq_get);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
new file mode 100644
index 000000000..640e12733
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __EQ_H
+#define __EQ_H
+
+#include "common/xsc_core.h"
+
+enum {
+	XSC_EQ_VEC_ASYNC		= 0,
+	XSC_VEC_CMD			= 1,
+	XSC_VEC_CMD_EVENT		= 2,
+	XSC_DMA_READ_DONE_VEC		= 3,
+	XSC_EQ_VEC_COMP_BASE,
+};
+
+struct xsc_eqe {
+	u8 type;
+	u8 sub_type;
+	__le16 queue_id_data;
+#define XSC_EQE_QUEUE_ID_SHIFT	0
+#define XSC_EQE_QUEUE_ID_MASK	GENMASK(14, 0)
+
+	u8 err_code;
+	u8 rsvd[2];
+	u8 owner_data;
+#define XSC_EQE_OWNER		BIT(7)
+};
+
+struct xsc_eq_doorbell {
+	__le32 data0;
+#define XSC_EQ_DB_NEXT_CID_SHIFT	0
+#define XSC_EQ_DB_NEXT_CID_MASK		GENMASK(10, 0)
+#define XSC_EQ_DB_EQ_ID_SHIFT		11
+#define XSC_EQ_DB_EQ_ID_MASK		GENMASK(21, 11)
+#define XSC_EQ_DB_ARM			BIT(22)
+};
+
+int xsc_create_map_eq(struct xsc_core_device *xdev,
+		      struct xsc_eq *eq, u8 vecidx,
+		      int nent, const char *name);
+int xsc_destroy_unmap_eq(struct xsc_core_device *xdev, struct xsc_eq *eq);
+void xsc_eq_init(struct xsc_core_device *xdev);
+int xsc_start_eqs(struct xsc_core_device *xdev);
+void xsc_stop_eqs(struct xsc_core_device *xdev);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 68ae2fe93..9b185e2d5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -8,6 +8,7 @@
 #include "hw.h"
 #include "qp.h"
 #include "cq.h"
+#include "eq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -222,6 +223,7 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
 
 	xsc_init_cq_table(xdev);
 	xsc_init_qp_table(xdev);
+	xsc_eq_init(xdev);
 
 	return 0;
 err_cmd_cleanup:
-- 
2.43.0


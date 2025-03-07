Return-Path: <netdev+bounces-172840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29766A564A4
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611F71897855
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981AC20DD50;
	Fri,  7 Mar 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="dIt0+Muv"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-37.ptr.blmpb.com (va-2-37.ptr.blmpb.com [209.127.231.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55820D4F4
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342132; cv=none; b=jXErgKE5wzOfb3yZGEv1r56jucbRVp7ygGCVJdMTFR1cMKeQNenzZ7G4di/SqoT4QfciCs49SHA1obXB1hp8V2TtSAdTWSMTHDw3h+jvxxX4rNIpm9U86pfS6sV3FCybPFxPpP/SDxsJZF+oIfOImBcitdwlAMCxZSzC0163xtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342132; c=relaxed/simple;
	bh=fJuR9uTWboxFc9JAJl/WX+aFzWLONb/dSxtAgJzzrBE=;
	h=References:Cc:Subject:Message-Id:Date:In-Reply-To:To:From:
	 Content-Type:Mime-Version; b=bK2OTcKQcKVYQy+5RvD0TzQCgaF0OL9YlCXVTg4BZey2CkPS+SMcYRws4HRUHVV/ZJlQWEyxCQt5Ve27O4XrLRVAYk8cgX9WnS6GakAaD4MX/GsI80YEicKQjrQzJtU9iJ5veEs94jPjWwgXUZhG3aAjFIZ8JtFlM5cziDDD1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=dIt0+Muv; arc=none smtp.client-ip=209.127.231.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741342119; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=bXF8qN9QAZYZdQlFZYQrHD4CliKGdkPqhYEchvvrJmY=;
 b=dIt0+MuvjT8EKQxJmv6uJX/jL2hQA3DMz4t9hWIf4T4At/rXL724i//lY0kOB69JWg9l99
 B7VP8GVgo3kV38tcHLsOxjzqtcfQchKWxpYr1X9RDltPXj6nVg140N0Z/Pi/VpVHzKozj5
 D6URGKNLEUJSaa44q0zVVInszVXT6OKRkZuSrAuWl5TOIzlmc2o4090u7w1Nt0oMhjA/tu
 bvo1xdZUWOFVBWAv0pKUPHzzplFw9i7MVJoiCN/jFAv5rBOMmfQJRgwpkYkEYinRj0tkaH
 NBMJ1Tz7LaE2NOOavW9iLVvlfeWs6gw+V1T1zAxy3MTysdVr/YYQybKh2xL/mw==
X-Mailer: git-send-email 2.25.1
References: <20250307100824.555320-1-tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
Subject: [PATCH net-next v8 05/14] xsc: Add eq and alloc
Message-Id: <20250307100835.555320-6-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267cac5a5+a6dce2+vger.kernel.org+tianx@yunsilicon.com>
Date: Fri, 07 Mar 2025 18:08:36 +0800
In-Reply-To: <20250307100824.555320-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 07 Mar 2025 18:08:36 +0800
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>

Add eq management and buffer alloc apis

This patch, along with the next one, implements the event handling
mechanism. The hardware uses the event queue (EQ) for event
reporting, notifying the CPU through interrupts, which then
reads and processes events from the EQ.

1. This patch implements the EQ API, including the initialization
of the EQ table, and the creation/destroy, start/stop operations
of the EQ.

2. When creating an event queue, a large amount of DMA memory is
required to store the ring buffer, necessitating multiple DMA page
allocations and unified management. For this purpose, we define
struct xsc_buff and use xsc_buf_alloc/free to allocate and free
memory. The usage of QP and CQ will also rely on these in the future.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  38 ++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   | 130 +++++++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |  17 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  | 340 ++++++++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |  46 +++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   2 +
 7 files changed, 574 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index c5c1dd837..81d1f0e91 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -27,12 +27,20 @@
 #define XSC_MV_HOST_VF_DEV_ID		0x1152
 #define XSC_MV_SOC_PF_DEV_ID		0x1153
 
+#define PAGE_SHIFT_4K			12
+#define PAGE_SIZE_4K			(_AC(1, UL) << PAGE_SHIFT_4K)
+#define PAGE_MASK_4K			(~(PAGE_SIZE_4K - 1))
+
 #define XSC_REG_ADDR(dev, offset)	(((dev)->bar) + ((offset) - 0xA0000000))
 
 enum {
 	XSC_MAX_EQ_NAME	= 20
 };
 
+enum {
+	XSC_MAX_IRQ_NAME	= 32
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -168,6 +176,7 @@ struct xsc_cq_table {
 	struct radix_tree_root	tree;
 };
 
+/* eq */
 struct xsc_eq {
 	struct xsc_core_device	*dev;
 	struct xsc_cq_table	cq_table;
@@ -184,6 +193,25 @@ struct xsc_eq {
 	u16			index;
 };
 
+struct xsc_eq_table {
+	void __iomem		*update_ci;
+	void __iomem		*update_arm_ci;
+	struct list_head	comp_eqs_list;
+	struct xsc_eq		pages_eq;
+	struct xsc_eq		async_eq;
+	struct xsc_eq		cmd_eq;
+	int			num_comp_vectors;
+	int			eq_vec_comp_base;
+	/* protect EQs list */
+	spinlock_t		lock;
+};
+
+/* irq */
+struct xsc_irq_info {
+	cpumask_var_t mask;
+	char name[XSC_MAX_IRQ_NAME];
+};
+
 /* hw */
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -312,6 +340,8 @@ struct xsc_caps {
 struct xsc_dev_resource {
 	struct xsc_qp_table	qp_table;
 	struct xsc_cq_table	cq_table;
+	struct xsc_eq_table	eq_table;
+	struct xsc_irq_info	*irq_info;
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
 };
@@ -328,6 +358,8 @@ struct xsc_core_device {
 	u8			mac_port;
 	u16			glb_func_id;
 
+	u16			msix_vec_base;
+
 	struct xsc_cmd		cmd;
 	u16			cmdq_ver;
 
@@ -352,6 +384,7 @@ int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 				    struct xsc_core_qp *qp);
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
+struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *xdev, int i);
 
 static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
 {
@@ -362,4 +395,9 @@ static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
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
index 000000000..4c561d9fa
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
@@ -0,0 +1,130 @@
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
+int xsc_buf_alloc(struct xsc_core_device *xdev,
+		  unsigned long size,
+		  unsigned long max_direct,
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
+		while (t & GENMASK(buf->page_shift - 1, 0)) {
+			--buf->page_shift;
+			buf->npages *= 2;
+		}
+	} else {
+		struct page **pages;
+		int i;
+
+		buf->direct.buf  = NULL;
+		buf->nbufs       = DIV_ROUND_UP(size, PAGE_SIZE);
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
+		pages = kmalloc_array(buf->nbufs, sizeof(*pages), GFP_KERNEL);
+		if (!pages)
+			goto err_free;
+		for (i = 0; i < buf->nbufs; i++) {
+			void *addr = buf->page_list[i].buf;
+
+			if (is_vmalloc_addr(addr))
+				pages[i] = vmalloc_to_page(addr);
+			else
+				pages[i] = virt_to_page(addr);
+		}
+		buf->direct.buf = vmap(pages, buf->nbufs, VM_MAP, PAGE_KERNEL);
+		kfree(pages);
+		if (!buf->direct.buf)
+			goto err_free;
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
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, unsigned int npages)
+{
+	unsigned int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
+	unsigned int mask = (1 << shift) - 1;
+	u64 addr;
+	int i;
+
+	for (i = 0; i < npages; i++) {
+		if (buf->nbufs == 1)
+			addr = buf->direct.map + (i << PAGE_SHIFT_4K);
+		else
+			addr = buf->page_list[i >> shift].map +
+			       ((i & mask) << PAGE_SHIFT_4K);
+
+		pas[i] = cpu_to_be64(addr);
+	}
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
new file mode 100644
index 000000000..a1c4b92a5
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
@@ -0,0 +1,17 @@
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
+int xsc_buf_alloc(struct xsc_core_device *xdev,
+		  unsigned long size,
+		  unsigned long max_direct,
+		  struct xsc_buf *buf);
+void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf);
+void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, unsigned int npages);
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
new file mode 100644
index 000000000..aa2c0ba61
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
@@ -0,0 +1,340 @@
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
+	struct xsc_destroy_eq_mbox_out out = {0};
+	struct xsc_destroy_eq_mbox_in in = {0};
+	int err;
+
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DESTROY_EQ);
+	in.eqn = cpu_to_be32(eqn);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (!err)
+		return 0;
+
+	if (out.hdr.status)
+		err = xsc_cmd_status_to_err(&out.hdr);
+
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
+	u32 db_val = 0;
+
+	db_val = FIELD_PREP(XSC_EQ_DB_NEXT_CID_MASK, eq->cons_index) |
+		 FIELD_PREP(XSC_EQ_DB_EQ_ID_MASK, eq->eqn);
+	if (arm)
+		db_val |= XSC_EQ_DB_ARM;
+	/* make sure memory is written before device access */
+	wmb();
+	writel(db_val, XSC_REG_ADDR(eq->dev, eq->doorbell));
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
+			queue_id = FIELD_GET(XSC_EQE_QUEUE_ID_MASK,
+					     le16_to_cpu(eqe->queue_id_data));
+			cqn = queue_id;
+			xsc_cq_completion(xdev, cqn);
+			break;
+
+		case XSC_EVENT_TYPE_CQ_ERROR:
+			queue_id = FIELD_GET(XSC_EQE_QUEUE_ID_MASK,
+					     le16_to_cpu(eqe->queue_id_data));
+			cqn = queue_id;
+			xsc_eq_cq_event(xdev, cqn, eqe->type);
+			break;
+		case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
+		case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
+		case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
+			queue_id = FIELD_GET(XSC_EQE_QUEUE_ID_MASK,
+					     le16_to_cpu(eqe->queue_id_data));
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
+		      struct xsc_eq *eq, u16 vecidx,
+		      u32 nent, const char *name)
+{
+	u16 msix_vec_offset = xdev->msix_vec_base + vecidx;
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+	struct xsc_create_eq_mbox_out out;
+	struct xsc_create_eq_mbox_in *in;
+	unsigned int hw_npages;
+	u32 inlen;
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
+		goto err_free_eq_buf;
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
+		goto err_free_in;
+
+	if (out.hdr.status) {
+		err = -ENOSPC;
+		goto err_free_in;
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
+		goto err_destroy_eq;
+
+	/* EQs are created in ARMED state
+	 */
+	eq_update_ci(eq, 1);
+	kvfree(in);
+	return 0;
+
+err_destroy_eq:
+	xsc_cmd_destroy_eq(xdev, eq->eqn);
+
+err_free_in:
+	kvfree(in);
+
+err_free_eq_buf:
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
index 000000000..b863a459b
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
@@ -0,0 +1,46 @@
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
+#define XSC_EQE_QUEUE_ID_MASK	GENMASK(14, 0)
+
+	u8 err_code;
+	u8 rsvd[2];
+	u8 owner_data;
+#define XSC_EQE_OWNER		BIT(7)
+};
+
+/* eq doorbell bitfields */
+#define XSC_EQ_DB_NEXT_CID_SHIFT	0
+#define XSC_EQ_DB_NEXT_CID_MASK		GENMASK(10, 0)
+#define XSC_EQ_DB_EQ_ID_SHIFT		11
+#define XSC_EQ_DB_EQ_ID_MASK		GENMASK(21, 11)
+#define XSC_EQ_DB_ARM			BIT(22)
+
+int xsc_create_map_eq(struct xsc_core_device *xdev,
+		      struct xsc_eq *eq, u16 vecidx,
+		      u32 nent, const char *name);
+int xsc_destroy_unmap_eq(struct xsc_core_device *xdev, struct xsc_eq *eq);
+void xsc_eq_init(struct xsc_core_device *xdev);
+int xsc_start_eqs(struct xsc_core_device *xdev);
+void xsc_stop_eqs(struct xsc_core_device *xdev);
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 03e8f269b..161af95e0 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -8,6 +8,7 @@
 #include "hw.h"
 #include "qp.h"
 #include "cq.h"
+#include "eq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -183,6 +184,7 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
 
 	xsc_init_cq_table(xdev);
 	xsc_init_qp_table(xdev);
+	xsc_eq_init(xdev);
 
 	return 0;
 err_cmd_cleanup:
-- 
2.43.0


Return-Path: <netdev+bounces-170137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F0CA477BD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AE4A3B03FE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 08:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEDB22371B;
	Thu, 27 Feb 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ULo8Ibod"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-14.ptr.blmpb.com (va-1-14.ptr.blmpb.com [209.127.230.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59CC22576C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740644784; cv=none; b=bXMqt6DJDsEs6Tf8er68/U8pGr9ux7Wh35tZTFVA5UfJjuBhP92EABzGGZZt9lcCnUHNoRLGU9W+RkqH7d01xIG1xRHVe4XT8stHTZVX/DnbnIW0iGdPC3cyVLLOFFBcRtBVlLfDoMLeHu0TEiVrMsNKvcQbTKN6l/VXHPO6IA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740644784; c=relaxed/simple;
	bh=scGwMkq+uUZwppBuP8lUTtzyD+XRCCDp7SYGGNkVAT8=;
	h=Date:Mime-Version:To:From:References:Message-Id:In-Reply-To:
	 Content-Type:Cc:Subject; b=sqSIUiiBGXFHNMreTgsKNyzez7M/FpuLjsuMSUxc48a19Aga9fPjMF3x1gzrzP2IhOd6CScUSZOXLNWiAdeHAgc9YqBSNu+v1+BHQbyzZC+7U3kLwUYRLwyJvWyIBfC02oYqm1V0XQrozqbN78ctYuEy3ZZglK3kEHIlOhUY4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ULo8Ibod; arc=none smtp.client-ip=209.127.230.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740644770; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ErAOtxcdlzZRKmJrC2r6C3P108G70DD+iLk2KHcYxWM=;
 b=ULo8IbodHdHrXI0+4w0v4H+tWFIaDm480FVQs4zNke+zbXzwXSr64yiyQBTEgBtKDBd8qX
 CsDzPX9lFd8WSy6is5Cz7wCLL3KXTkPkrBLXb2pb6MY+EbhQji0cIPD9FL+JbvAz0ibwtp
 ZBWY7xKJvRWqzk3qEOJgsJDUiBf4wk9Pn6oiyULO0OVRKfNsnsmtkI/h1kl30dBGY8+tdl
 ZgKOncIK3tJ1qadJPMdthIOUWgDuLbdamU9t9ZfqtYLs5jG9iWj2QRn2vJ3fNUAn4pqr2D
 nMa8DoLiX+ktY8dGXDK5Ol3F9gC1eEpVjnLrwx4ZC1CNRDN8PVx2qj8dmaN4Qw==
Date: Thu, 27 Feb 2025 16:26:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 27 Feb 2025 16:26:07 +0800
To: <netdev@vger.kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
References: <20250227082558.151093-1-tianx@yunsilicon.com>
Message-Id: <20250227082606.151093-5-tianx@yunsilicon.com>
In-Reply-To: <20250227082558.151093-1-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267c021a0+2369eb+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: [PATCH net-next v6 04/14] xsc: Add qp and cq management

Our hardware uses queue pairs (QP) and completion queues (CQ)
for packet transmission and reception. In the PCI driver, all
QP and CQ resources used by all xsc drivers(ethernet and rdma)
are recorded witch radix tree.
This patch defines the QP and CQ structures and initializes
the QP and CQ resource management during PCI initialization.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 157 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 +++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |   1 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  80 +++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  15 ++
 8 files changed, 313 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index b2dd57d96..819f6498e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -29,6 +29,10 @@
 
 #define XSC_REG_ADDR(dev, offset)	(((dev)->bar) + ((offset) - 0xA0000000))
 
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -43,6 +47,143 @@ enum {
 	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
 };
 
+/* alloc */
+struct xsc_buf_list {
+	void			*buf;
+	dma_addr_t		map;
+};
+
+struct xsc_buf {
+	struct xsc_buf_list	direct;
+	struct xsc_buf_list	*page_list;
+	unsigned long		nbufs;
+	unsigned long		npages;
+	unsigned long		page_shift;
+	unsigned long		size;
+};
+
+struct xsc_frag_buf {
+	struct xsc_buf_list	*frags;
+	unsigned long		npages;
+	unsigned long		size;
+	u8			page_shift;
+};
+
+struct xsc_frag_buf_ctrl {
+	struct xsc_buf_list	*frags;
+	u32			sz_m1;
+	u16			frag_sz_m1;
+	u16			strides_offset;
+	u8			log_sz;
+	u8			log_stride;
+	u8			log_frag_strides;
+};
+
+/* qp */
+struct xsc_send_wqe_ctrl_seg {
+	__le32		data0;
+#define XSC_WQE_CTRL_SEG_MSG_OPCODE_MASK	GENMASK(7, 0)
+#define XSC_WQE_CTRL_SEG_WITH_IMM		BIT(8)
+#define XSC_WQE_CTRL_SEG_CSUM_EN_MASK		GENMASK(10, 9)
+#define XSC_WQE_CTRL_SEG_DS_DATA_NUM_MASK	GENMASK(15, 11)
+#define XSC_WQE_CTRL_SEG_WQE_ID_MASK		GENMASK(31, 16)
+
+	__le32		msg_len;
+	__le32		data2;
+#define XSC_WQE_CTRL_SEG_HAS_PPH		BIT(0)
+#define XSC_WQE_CTRL_SEG_SO_TYPE		BIT(1)
+#define XSC_WQE_CTRL_SEG_SO_DATA_SIZE_MASK	GENMASK(15, 2)
+#define XSC_WQE_CTRL_SEG_SO_HDR_LEN_MASK	GENMASK(31, 24)
+
+	__le32		data3;
+#define XSC_WQE_CTRL_SEG_SE			BIT(0)
+#define XSC_WQE_CTRL_SEG_CE			BIT(1)
+};
+
+struct xsc_wqe_data_seg {
+	__le32		data0;
+#define XSC_WQE_DATA_SEG_SEG_LEN_MASK		GENMASK(31, 1)
+
+	__le32		mkey;
+	__le64		va;
+};
+
+struct xsc_core_qp {
+	void			(*event)(struct xsc_core_qp *qp, int type);
+	u32			qpn;
+	atomic_t		refcount;
+	struct completion	free;
+	int			pid;
+	u16			qp_type;
+	u16			eth_queue_type;
+	u16			qp_type_internal;
+	u16			grp_id;
+	u8			mac_id;
+};
+
+struct xsc_qp_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+/* cq */
+enum xsc_event {
+	XSC_EVENT_TYPE_COMP			= 0x0,
+	/* mad */
+	XSC_EVENT_TYPE_COMM_EST			= 0x02,
+	XSC_EVENT_TYPE_CQ_ERROR			= 0x04,
+	XSC_EVENT_TYPE_WQ_CATAS_ERROR		= 0x05,
+	XSC_EVENT_TYPE_INTERNAL_ERROR		= 0x08,
+	/* IBV_EVENT_QP_REQ_ERR */
+	XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR	= 0x10,
+	/* IBV_EVENT_QP_ACCESS_ERR */
+	XSC_EVENT_TYPE_WQ_ACCESS_ERROR		= 0x11,
+};
+
+struct xsc_core_cq {
+	u32			cqn;
+	u32			cqe_sz;
+	u64			arm_db;
+	u64			ci_db;
+	struct xsc_core_device	*xdev;
+	atomic_t		refcount;
+	struct completion	free;
+	unsigned int		vector;
+	unsigned int		irqn;
+	u16			dim_us;
+	u16			dim_pkts;
+	void			(*comp)(struct xsc_core_cq *cq);
+	void			(*event)(struct xsc_core_cq *cq,
+					 enum xsc_event);
+	u32			cons_index;
+	unsigned int		arm_sn;
+	int			pid;
+	u32			reg_next_cid;
+	u32			reg_done_pid;
+	struct xsc_eq		*eq;
+};
+
+struct xsc_cq_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+struct xsc_eq {
+	struct xsc_core_device	*dev;
+	struct xsc_cq_table	cq_table;
+	/* offset from bar0/2 space start */
+	u32			doorbell;
+	u32			cons_index;
+	struct xsc_buf		buf;
+	unsigned int		irqn;
+	u32			eqn;
+	u32			nent;
+	cpumask_var_t		mask;
+	char			name[XSC_MAX_EQ_NAME];
+	struct list_head	list;
+	u16			index;
+};
+
 /* hw */
 struct xsc_reg_addr {
 	u64	tx_db;
@@ -169,6 +310,8 @@ struct xsc_caps {
 
 /* xsc_core */
 struct xsc_dev_resource {
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
 	/* protect buffer allocation according to numa node */
 	struct mutex		alloc_mutex;
 };
@@ -219,4 +362,18 @@ struct xsc_core_device {
 	u8			fw_version_extra_flag;
 };
 
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp);
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp);
+
+static inline void *xsc_buf_offset(struct xsc_buf *buf, unsigned long offset)
+{
+	if (likely(buf->nbufs == 1))
+		return buf->direct.buf + offset;
+	else
+		return buf->page_list[offset >> PAGE_SHIFT].buf +
+			(offset & (PAGE_SIZE - 1));
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
index fea625d54..9a4a6e02d 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -6,4 +6,5 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
 
-xsc_pci-y := main.o cmdq.o hw.o
+xsc_pci-y := main.o cmdq.o hw.o qp.o cq.o
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
new file mode 100644
index 000000000..5cff9025c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+#include "cq.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	struct xsc_core_cq *cq;
+
+	spin_lock(&table->lock);
+
+	cq = radix_tree_lookup(&table->tree, cqn);
+	if (cq)
+		atomic_inc(&cq->refcount);
+
+	spin_unlock(&table->lock);
+
+	if (!cq) {
+		pci_err(xdev->pdev, "Async event for bogus CQ 0x%x\n", cqn);
+		return;
+	}
+
+	cq->event(cq, event_type);
+
+	if (atomic_dec_and_test(&cq->refcount))
+		complete(&cq->free);
+}
+
+void xsc_init_cq_table(struct xsc_core_device *xdev)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+
+	spin_lock_init(&table->lock);
+	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
new file mode 100644
index 000000000..902a7f1f2
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __CQ_H
+#define __CQ_H
+
+#include "common/xsc_core.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type);
+void xsc_init_cq_table(struct xsc_core_device *xdev);
+
+#endif /* __CQ_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
index 898b80216..6fb2440ab 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+
 #include "common/xsc_driver.h"
 #include "hw.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index 4b505fd9a..68ae2fe93 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -6,6 +6,8 @@
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 #include "hw.h"
+#include "qp.h"
+#include "cq.h"
 
 static const struct pci_device_id xsc_pci_id_table[] = {
 	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
@@ -218,6 +220,9 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
 		goto err_cmd_cleanup;
 	}
 
+	xsc_init_cq_table(xdev);
+	xsc_init_qp_table(xdev);
+
 	return 0;
 err_cmd_cleanup:
 	xsc_cmd_cleanup(xdev);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
new file mode 100644
index 000000000..cc79eaf92
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/gfp.h>
+#include <linux/time.h>
+#include <linux/export.h>
+#include <linux/kthread.h>
+
+#include "common/xsc_core.h"
+#include "qp.h"
+
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	int err;
+
+	spin_lock_irq(&table->lock);
+	err = radix_tree_insert(&table->tree, qp->qpn, qp);
+	spin_unlock_irq(&table->lock);
+	if (err)
+		return err;
+
+	atomic_set(&qp->refcount, 1);
+	init_completion(&qp->free);
+	qp->pid = current->pid;
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_create_resource_common);
+
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	unsigned long flags;
+
+	spin_lock_irqsave(&table->lock, flags);
+	radix_tree_delete(&table->tree, qp->qpn);
+	spin_unlock_irqrestore(&table->lock, flags);
+
+	if (atomic_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+	wait_for_completion(&qp->free);
+}
+EXPORT_SYMBOL(xsc_core_destroy_resource_common);
+
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+	struct xsc_core_qp *qp;
+
+	spin_lock(&table->lock);
+
+	qp = radix_tree_lookup(&table->tree, qpn);
+	if (qp)
+		atomic_inc(&qp->refcount);
+
+	spin_unlock(&table->lock);
+
+	if (!qp) {
+		pci_err(xdev->pdev, "Async event for bogus QP 0x%x\n", qpn);
+		return;
+	}
+
+	qp->event(qp, event_type);
+
+	if (atomic_dec_and_test(&qp->refcount))
+		complete(&qp->free);
+}
+
+void xsc_init_qp_table(struct xsc_core_device *xdev)
+{
+	struct xsc_qp_table *table = &xdev->dev_res->qp_table;
+
+	spin_lock_init(&table->lock);
+	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
new file mode 100644
index 000000000..52af8db7c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef __QP_H
+#define __QP_H
+
+#include "common/xsc_core.h"
+
+void xsc_init_qp_table(struct xsc_core_device *xdev);
+void xsc_cleanup_qp_table(struct xsc_core_device *xdev);
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type);
+
+#endif /* __QP_H */
-- 
2.18.4


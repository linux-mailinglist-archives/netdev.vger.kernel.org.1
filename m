Return-Path: <netdev+bounces-152904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2759F6442
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 12:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC68F7A1A05
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903FE161310;
	Wed, 18 Dec 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="UrzxVGXq"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D927726
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519858; cv=none; b=And1GKqM9GXSOs2o4d/Zmm33oxFb13SocWRdjXZIiJD6EmGBTH2D4OCRkliP3VKyuLofK4laYVoOw70cagcBZn7ctUdQFE3jUPREVly6VMyvKI1ErXWxemQTa9T7oBmzqjDJNAQ5YytTcayhyMVfnRTcfMjP/1zxOSCB/2fuIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519858; c=relaxed/simple;
	bh=bteDoInv0x3YMJaXv/ypVlRimNd5rQccIpNv4xTb/8Y=;
	h=To:Cc:From:Content-Type:Date:Message-Id:Mime-Version:In-Reply-To:
	 References:Subject; b=ZOzv01lkPs97OEHHzYEyLDkUx0fDgKBudRvWXbVTHzXvWsOsKbjwMZWGxkjmI2W/ANRqjuuGlIbfM8U2rVjBg8J+GqUiUTGFClt+p01ZHjd2/4x0rnsjGHzxDbRAh7C0uDrS4CTfMk8l2qUr5BHuH6aXh8WnyacjD7GS+3SpXe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=UrzxVGXq; arc=none smtp.client-ip=209.127.231.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519034; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=P/AODC1n9M1PrehyMFIygczXrpvQVIAiW/SXjB5gbYA=;
 b=UrzxVGXqEMk0Wboi4ZM3lwxgdp/12UwOsPlGBk/U442puG0BKGXxsqnmARVWR/R93+uonm
 l1GYpNozO1I+HHe5mL6jhJdlV0XdIpOrjyRODPuFY+fdPH1iO/HornSkeRY7h1C82WhfwB
 TAMjbNgrmwhm9W8dyzYfhl5mA+BJ652SRV0Iog3KTefsj+ODJGCL9X7vnJdzZ0UYtODc5b
 uMgxFONlEN2qKSLp7x42L1SCF7cZE8hrVN29OzhFUfOCB2zxS3HAIP4dD4md+FWl/sNH7M
 MRhrd9iImyZiGPo0eb7vpGMBYj8t6lWfGDfdjjDSGqeAETtEjZuQeCBxY8eh+g==
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
From: "Xin Tian" <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26762a8f8+afeff2+vger.kernel.org+tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Dec 2024 18:50:31 +0800
Message-Id: <20241218105030.2237645-5-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:50:31 +0800
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>
Subject: [PATCH v1 04/16] net-next/yunsilicon: Add qp and cq management
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1

Add qp(queue pair) and cq(completion queue) resource management APIs

 
Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 172 +++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  39 ++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |  14 ++
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |   5 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  79 ++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |  15 ++
 7 files changed, 325 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index a8ac7878b..a68ae708d 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -104,6 +104,10 @@ enum {
 	XSC_MAX_NAME_LEN = 32,
 };
 
+enum {
+	XSC_MAX_EQ_NAME	= 20
+};
+
 enum {
 	XSC_MAX_PORTS	= 2,
 };
@@ -118,8 +122,160 @@ enum {
 	XSC_MAX_UUARS		= XSC_MAX_UAR_PAGES * XSC_BF_REGS_PER_PAGE,
 };
 
+// alloc.c
+struct xsc_buf_list {
+	void		       *buf;
+	dma_addr_t		map;
+};
+
+struct xsc_buf {
+	struct xsc_buf_list	direct;
+	struct xsc_buf_list   *page_list;
+	int			nbufs;
+	int			npages;
+	int			page_shift;
+	int			size;
+};
+
+struct xsc_frag_buf {
+	struct xsc_buf_list	*frags;
+	int			npages;
+	int			size;
+	u8			page_shift;
+};
+
+struct xsc_frag_buf_ctrl {
+	struct xsc_buf_list   *frags;
+	u32			sz_m1;
+	u16			frag_sz_m1;
+	u16			strides_offset;
+	u8			log_sz;
+	u8			log_stride;
+	u8			log_frag_strides;
+};
+
+// xsc_core_qp
+struct xsc_send_wqe_ctrl_seg {
+	__le32		msg_opcode:8;
+	__le32		with_immdt:1;
+	__le32		csum_en:2;
+	__le32		ds_data_num:5;
+	__le32		wqe_id:16;
+	__le32		msg_len;
+	union {
+		__le32		opcode_data;
+		struct {
+			u8		has_pph:1;
+			u8		so_type:1;
+			__le16		so_data_size:14;
+			u8:8;
+			u8		so_hdr_len:8;
+		};
+		struct {
+			__le16		desc_id;
+			__le16		is_last_wqe:1;
+			__le16		dst_qp_id:15;
+		};
+	};
+	__le32		se:1;
+	__le32		ce:1;
+	__le32:30;
+};
+
+struct xsc_wqe_data_seg {
+	union {
+		__le32		in_line:1;
+		struct {
+			__le32:1;
+			__le32		seg_len:31;
+			__le32		mkey;
+			__le64		va;
+		};
+		struct {
+			__le32:1;
+			__le32		len:7;
+			u8		in_line_data[15];
+		};
+	};
+};
+
+struct xsc_core_qp {
+	void (*event)(struct xsc_core_qp *qp, int type);
+	int			qpn;
+	atomic_t		refcount;
+	struct completion	free;
+	int			pid;
+	u16		qp_type;
+	u16		eth_queue_type;
+	u16	qp_type_internal;
+	u16	grp_id;
+	u8	mac_id;
+};
+
+struct xsc_qp_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+// cq
+enum xsc_event {
+	XSC_EVENT_TYPE_COMP               = 0x0,
+	XSC_EVENT_TYPE_COMM_EST           = 0x02,//mad
+	XSC_EVENT_TYPE_CQ_ERROR           = 0x04,
+	XSC_EVENT_TYPE_WQ_CATAS_ERROR     = 0x05,
+	XSC_EVENT_TYPE_INTERNAL_ERROR     = 0x08,
+	XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR = 0x10,//IBV_EVENT_QP_REQ_ERR
+	XSC_EVENT_TYPE_WQ_ACCESS_ERROR    = 0x11,//IBV_EVENT_QP_ACCESS_ERR
+};
+
+struct xsc_core_cq {
+	u32			cqn;
+	int			cqe_sz;
+	u64			arm_db;
+	u64			ci_db;
+	struct xsc_core_device *xdev;
+	atomic_t		refcount;
+	struct completion	free;
+	unsigned int		vector;
+	int			irqn;
+	u16			dim_us;
+	u16			dim_pkts;
+	void (*comp)(struct xsc_core_cq *cq);
+	void (*event)(struct xsc_core_cq *cq, enum xsc_event);
+	u32			cons_index;
+	unsigned int		arm_sn;
+	int			pid;
+	u32		reg_next_cid;
+	u32		reg_done_pid;
+	struct xsc_eq		*eq;
+};
+
+struct xsc_cq_table {
+	spinlock_t		lock; /* protect radix tree */
+	struct radix_tree_root	tree;
+};
+
+struct xsc_eq {
+	struct xsc_core_device   *dev;
+	struct xsc_cq_table	cq_table;
+	u32			doorbell;//offset from bar0/2 space start
+	u32			cons_index;
+	struct xsc_buf		buf;
+	int			size;
+	unsigned int		irqn;
+	u16			eqn;
+	int			nent;
+	cpumask_var_t		mask;
+	char			name[XSC_MAX_EQ_NAME];
+	struct list_head	list;
+	int			index;
+};
+
 struct xsc_dev_resource {
-	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
+	struct xsc_qp_table	qp_table;
+	struct xsc_cq_table	cq_table;
+
+	struct mutex		alloc_mutex; /* protect buffer alocation according to numa node */
 };
 
 struct xsc_reg_addr {
@@ -300,4 +456,18 @@ struct xsc_core_device {
 	u8			fw_version_extra_flag;
 };
 
+int xsc_core_create_resource_common(struct xsc_core_device *xdev,
+				    struct xsc_core_qp *qp);
+void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
+				      struct xsc_core_qp *qp);
+
+static inline void *xsc_buf_offset(struct xsc_buf *buf, int offset)
+{
+	if (likely(BITS_PER_LONG == 64 || buf->nbufs == 1))
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
index 000000000..ed0423ef2
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
+		xsc_core_warn(xdev, "Async event for bogus CQ 0x%x\n", cqn);
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
index 000000000..b223769e9
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CQ_H
+#define XSC_CQ_H
+
+#include "common/xsc_core.h"
+
+void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type);
+void xsc_init_cq_table(struct xsc_core_device *xdev);
+
+#endif /* XSC_CQ_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
index f07b6dec8..45f700129 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -6,6 +6,8 @@
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 #include "hw.h"
+#include "qp.h"
+#include "cq.h"
 
 unsigned int xsc_debug_mask;
 module_param_named(debug_mask, xsc_debug_mask, uint, 0644);
@@ -239,6 +241,9 @@ static int xsc_hw_setup(struct xsc_core_device *xdev)
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
index 000000000..de58a21b5
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/gfp.h>
+#include <linux/time.h>
+#include <linux/export.h>
+#include <linux/kthread.h>
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
+EXPORT_SYMBOL_GPL(xsc_core_create_resource_common);
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
+EXPORT_SYMBOL_GPL(xsc_core_destroy_resource_common);
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
+		xsc_core_warn(xdev, "Async event for bogus QP 0x%x\n", qpn);
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
index 000000000..baba6c7de
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_QP_H
+#define XSC_QP_H
+
+#include "common/xsc_core.h"
+
+void xsc_init_qp_table(struct xsc_core_device *xdev);
+void xsc_cleanup_qp_table(struct xsc_core_device *xdev);
+void xsc_qp_event(struct xsc_core_device *xdev, u32 qpn, int event_type);
+
+#endif /* XSC_QP_H */
-- 
2.43.0


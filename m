Return-Path: <netdev+bounces-150060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD49E8BF5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D81B188601F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71618214A92;
	Mon,  9 Dec 2024 07:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="TbTN09M7"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A28214A85
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728429; cv=none; b=tJxiKA7/Tq6/8wmAbHba0xxNiGRXXbwVatwAwnYCZjTf8aRf3KiS4tjUpnNQ8i7YnOj28CetdYUS3Pfdt6guaEmPC+wnyBGw3Gk/ijdp0rXBDNFcVzzA+27tv+9yQyTKqEvjHcCvnxlf9CoCn5Oe9K87rH5jtX2ZVIA+Ae26XAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728429; c=relaxed/simple;
	bh=OkvYDoLSFq3hjg4GewYxJGmlTtKF3+njyIfiNu9fMkM=;
	h=Cc:Message-Id:Mime-Version:Content-Type:To:Subject:Date:From; b=QOEavI4t8/keHHak9CjgSXJsHcYKv82jpSZFowYohYESCujWNYNmoArk7OXcA3A3KJSMPMY+f+w2XB/7/XPGzgBaOmGcdbBJ0r8+sX4ngC+l5fIj2V7t1qHaG1LbV2jQpNSvAtJvbK9ISbRwfuFVqHlsSmg2yeMSTzenTk0TaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=TbTN09M7; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728283; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=v/L8ZlhZkwQHXXZZV0byruiI1DhwAq7JizIkQqOhIGo=;
 b=TbTN09M7fhQnyLyCIfbFUbaVIB3gMWh1osGmbpKje4fWNmKyCnVzlCnDMhN740lopJn69J
 iLqF+GK0mdJ5bCA1TkG1c/dZ+yJu4QuTyN9SZgFWQjNKipttvbi+hxJiut+2t7EPZqpXBN
 Pa2GKtRTEah5hKhmuMClEEgEMAFNhpYvITrAD3YHwXnxKP2w5xrhv5M5QNIhVV5Y8+E46J
 Is8IPX6kHENishior2Mzsj3Q2SJ9TnRH+7lN8EHZpMRNkps7uFE7SVOumhbFpVejUbrR/a
 LZWOe5dmh/XQgIXHgkjw2CgoXEwsow7grzqminiIMbOmETLOxG4IQrhZJRLk2g==
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
Message-Id: <20241209071101.3392590-11-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Subject: [PATCH 10/16] net-next/yunsilicon: Add eth needed qp and cq apis
Date: Mon,  9 Dec 2024 15:10:55 +0800
From: "Tian Xin" <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+267569819+c70a94+vger.kernel.org+tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Add eth needed qp and cq apis

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  19 ++
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   2 +-
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  | 109 +++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  | 207 ++++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  96 ++++++++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   1 -
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  | 112 ++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  | 110 ++++++++++
 8 files changed, 654 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index c4286df0d..eec6469f0 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -541,13 +541,32 @@ struct xsc_core_device {
 	cpumask_var_t		xps_cpumask;
 };
 
+
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
 				    struct xsc_core_qp *qp);
 void xsc_core_destroy_resource_common(struct xsc_core_device *xdev,
 				      struct xsc_core_qp *qp);
+int xsc_core_eth_create_qp(struct xsc_core_device *xdev,
+			   struct xsc_create_qp_mbox_in *in,
+			   int insize, u32 *p_qpn);
+int xsc_core_eth_modify_qp_status(struct xsc_core_device *xdev, u32 qpn, u16 status);
+int xsc_core_eth_destroy_qp(struct xsc_core_device *xdev, u32 qpn);
+int xsc_core_eth_create_rss_qp_rqs(struct xsc_core_device *xdev,
+				   struct xsc_create_multiqp_mbox_in *in,
+				   int insize, int *p_qpn_base);
+int xsc_core_eth_modify_raw_qp(struct xsc_core_device *xdev,
+			       struct xsc_modify_raw_qp_mbox_in *in);
+int xsc_core_eth_create_cq(struct xsc_core_device *xdev, struct xsc_core_cq *xcq,
+			   struct xsc_create_cq_mbox_in *in, int insize);
+int xsc_core_eth_destroy_cq(struct xsc_core_device *dev, struct xsc_core_cq *xcq);
+
 struct xsc_eq *xsc_core_eq_get(struct xsc_core_device *dev, int i);
 int xsc_core_vector2eqn(struct xsc_core_device *dev, int vector, int *eqn,
 			unsigned int *irqn);
+void xsc_core_fill_page_frag_array(struct xsc_frag_buf *buf, __be64 *pas, int npages);
+int xsc_core_frag_buf_alloc_node(struct xsc_core_device *xdev, int size,
+				 struct xsc_frag_buf *buf, int node);
+void xsc_core_frag_buf_free(struct xsc_core_device *xdev, struct xsc_frag_buf *buf);
 
 int xsc_register_interface(struct xsc_interface *intf);
 void xsc_unregister_interface(struct xsc_interface *intf);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index 6ac74b27a..1aa36573a 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o
\ No newline at end of file
+xsc_eth-y := main.o xsc_eth_wq.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
new file mode 100644
index 000000000..4647f7f7f
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd. All
+ * rights reserved.
+ * Copyright (c) 2013-2015, Mellanox Technologies, Ltd.  All rights reserved.
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
+#include "xsc_eth_wq.h"
+
+u32 xsc_wq_cyc_get_size(struct xsc_wq_cyc *wq)
+{
+	return (u32)wq->fbc.sz_m1 + 1;
+}
+EXPORT_SYMBOL_GPL(xsc_wq_cyc_get_size);
+
+static u32 wq_get_byte_sz(u8 log_sz, u8 log_stride)
+{
+	return ((u32)1 << log_sz) << log_stride;
+}
+
+int xsc_eth_cqwq_create(struct xsc_core_device *xdev, struct xsc_wq_param *param,
+			u8 q_log_size, u8 ele_log_size, struct xsc_cqwq *wq,
+			struct xsc_wq_ctrl *wq_ctrl)
+{
+	u8 log_wq_stride = ele_log_size;
+	u8 log_wq_sz     = q_log_size;
+	int err;
+
+	err = xsc_core_frag_buf_alloc_node(xdev, wq_get_byte_sz(log_wq_sz, log_wq_stride),
+					   &wq_ctrl->buf,
+					   param->buf_numa_node);
+	if (err) {
+		xsc_core_warn(xdev, "xsc_core_frag_buf_alloc_node() failed, %d\n", err);
+		goto err;
+	}
+
+	xsc_init_fbc(wq_ctrl->buf.frags, log_wq_stride, log_wq_sz, &wq->fbc);
+
+	wq_ctrl->xdev = xdev;
+
+	return 0;
+
+err:
+	return err;
+}
+EXPORT_SYMBOL_GPL(xsc_eth_cqwq_create);
+
+int xsc_eth_wq_cyc_create(struct xsc_core_device *xdev, struct xsc_wq_param *param,
+			  u8 q_log_size, u8 ele_log_size, struct xsc_wq_cyc *wq,
+			  struct xsc_wq_ctrl *wq_ctrl)
+{
+	u8 log_wq_stride = ele_log_size;
+	u8 log_wq_sz     = q_log_size;
+	struct xsc_frag_buf_ctrl *fbc = &wq->fbc;
+	int err;
+
+	err = xsc_core_frag_buf_alloc_node(xdev, wq_get_byte_sz(log_wq_sz, log_wq_stride),
+					   &wq_ctrl->buf, param->buf_numa_node);
+	if (err) {
+		xsc_core_warn(xdev, "xsc_core_frag_buf_alloc_node() failed, %d\n", err);
+		goto err;
+	}
+
+	xsc_init_fbc(wq_ctrl->buf.frags, log_wq_stride, log_wq_sz, fbc);
+	wq->sz = xsc_wq_cyc_get_size(wq);
+
+	wq_ctrl->xdev = xdev;
+
+	return 0;
+
+err:
+	return err;
+}
+EXPORT_SYMBOL_GPL(xsc_eth_wq_cyc_create);
+
+void xsc_eth_wq_destroy(struct xsc_wq_ctrl *wq_ctrl)
+{
+	xsc_core_frag_buf_free(wq_ctrl->xdev, &wq_ctrl->buf);
+}
+EXPORT_SYMBOL_GPL(xsc_eth_wq_destroy);
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h
new file mode 100644
index 000000000..b677f1482
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright (c) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd. All
+ * rights reserved.
+ * Copyright (c) 2013-2015, Mellanox Technologies, Ltd.  All rights reserved.
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
+#ifndef __XSC_WQ_H__
+#define __XSC_WQ_H__
+
+#include "common/xsc_core.h"
+
+struct xsc_wq_param {
+	int		buf_numa_node;
+	int		db_numa_node;
+};
+
+struct xsc_wq_ctrl {
+	struct xsc_core_device	*xdev;
+	struct xsc_frag_buf	buf;
+};
+
+struct xsc_wq_cyc {
+	struct xsc_frag_buf_ctrl fbc;
+	u16			sz;
+	u16			wqe_ctr;
+	u16			cur_sz;
+};
+
+struct xsc_cqwq {
+	struct xsc_frag_buf_ctrl fbc;
+	__be32			  *db;
+	u32			  cc; /* consumer counter */
+};
+
+enum xsc_res_type {
+	XSC_RES_UND	= 0,
+	XSC_RES_RQ,
+	XSC_RES_SQ,
+	XSC_RES_MAX,
+};
+
+u32 xsc_wq_cyc_get_size(struct xsc_wq_cyc *wq);
+
+/*api for eth driver*/
+int xsc_eth_cqwq_create(struct xsc_core_device *xdev, struct xsc_wq_param *param,
+			u8 q_log_size, u8 ele_log_size, struct xsc_cqwq *wq,
+			struct xsc_wq_ctrl *wq_ctrl);
+
+int xsc_eth_wq_cyc_create(struct xsc_core_device *xdev, struct xsc_wq_param *param,
+			  u8 q_log_size, u8 ele_log_size, struct xsc_wq_cyc *wq,
+			  struct xsc_wq_ctrl *wq_ctrl);
+void xsc_eth_wq_destroy(struct xsc_wq_ctrl *wq_ctrl);
+
+static inline void xsc_init_fbc_offset(struct xsc_buf_list *frags,
+				       u8 log_stride, u8 log_sz,
+				       u16 strides_offset,
+				       struct xsc_frag_buf_ctrl *fbc)
+{
+	fbc->frags      = frags;
+	fbc->log_stride = log_stride;
+	fbc->log_sz     = log_sz;
+	fbc->sz_m1	= (1 << fbc->log_sz) - 1;
+	fbc->log_frag_strides = PAGE_SHIFT - fbc->log_stride;
+	fbc->frag_sz_m1	= (1 << fbc->log_frag_strides) - 1;
+	fbc->strides_offset = strides_offset;
+}
+
+static inline void xsc_init_fbc(struct xsc_buf_list *frags,
+				u8 log_stride, u8 log_sz,
+				struct xsc_frag_buf_ctrl *fbc)
+{
+	xsc_init_fbc_offset(frags, log_stride, log_sz, 0, fbc);
+}
+
+static inline void *xsc_frag_buf_get_wqe(struct xsc_frag_buf_ctrl *fbc,
+					 u32 ix)
+{
+	unsigned int frag;
+
+	ix  += fbc->strides_offset;
+	frag = ix >> fbc->log_frag_strides;
+
+	return fbc->frags[frag].buf + ((fbc->frag_sz_m1 & ix) << fbc->log_stride);
+}
+
+static inline u32
+xsc_frag_buf_get_idx_last_contig_stride(struct xsc_frag_buf_ctrl *fbc, u32 ix)
+{
+	u32 last_frag_stride_idx = (ix + fbc->strides_offset) | fbc->frag_sz_m1;
+
+	return min_t(u32, last_frag_stride_idx - fbc->strides_offset, fbc->sz_m1);
+}
+
+static inline int xsc_wq_cyc_missing(struct xsc_wq_cyc *wq)
+{
+	return wq->sz - wq->cur_sz;
+}
+
+static inline int xsc_wq_cyc_is_empty(struct xsc_wq_cyc *wq)
+{
+	return !wq->cur_sz;
+}
+
+static inline void xsc_wq_cyc_push(struct xsc_wq_cyc *wq)
+{
+	wq->wqe_ctr++;
+	wq->cur_sz++;
+}
+
+static inline void xsc_wq_cyc_push_n(struct xsc_wq_cyc *wq, u8 n)
+{
+	wq->wqe_ctr += n;
+	wq->cur_sz += n;
+}
+
+static inline void xsc_wq_cyc_pop(struct xsc_wq_cyc *wq)
+{
+	wq->cur_sz--;
+}
+
+static inline u16 xsc_wq_cyc_ctr2ix(struct xsc_wq_cyc *wq, u16 ctr)
+{
+	return ctr & wq->fbc.sz_m1;
+}
+
+static inline u16 xsc_wq_cyc_get_head(struct xsc_wq_cyc *wq)
+{
+	return xsc_wq_cyc_ctr2ix(wq, wq->wqe_ctr);
+}
+
+static inline u16 xsc_wq_cyc_get_tail(struct xsc_wq_cyc *wq)
+{
+	return xsc_wq_cyc_ctr2ix(wq, wq->wqe_ctr - wq->cur_sz);
+}
+
+static inline void *xsc_wq_cyc_get_wqe(struct xsc_wq_cyc *wq, u16 ix)
+{
+	return xsc_frag_buf_get_wqe(&wq->fbc, ix);
+}
+
+static inline u32 xsc_cqwq_ctr2ix(struct xsc_cqwq *wq, u32 ctr)
+{
+	return ctr & wq->fbc.sz_m1;
+}
+
+static inline u32 xsc_cqwq_get_ci(struct xsc_cqwq *wq)
+{
+	return xsc_cqwq_ctr2ix(wq, wq->cc);
+}
+
+static inline u32 xsc_cqwq_get_ctr_wrap_cnt(struct xsc_cqwq *wq, u32 ctr)
+{
+	return ctr >> wq->fbc.log_sz;
+}
+
+static inline u32 xsc_cqwq_get_wrap_cnt(struct xsc_cqwq *wq)
+{
+	return xsc_cqwq_get_ctr_wrap_cnt(wq, wq->cc);
+}
+
+static inline void xsc_cqwq_pop(struct xsc_cqwq *wq)
+{
+	wq->cc++;
+}
+
+static inline u32 xsc_cqwq_get_size(struct xsc_cqwq *wq)
+{
+	return wq->fbc.sz_m1 + 1;
+}
+
+static inline struct xsc_cqe *xsc_cqwq_get_wqe(struct xsc_cqwq *wq, u32 ix)
+{
+	struct xsc_cqe *cqe = xsc_frag_buf_get_wqe(&wq->fbc, ix);
+
+	return cqe;
+}
+
+#endif /* __XSC_WQ_H__ */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
index 0f5df43ea..ca2608b52 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
@@ -127,3 +127,99 @@ void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages)
 	}
 }
 EXPORT_SYMBOL_GPL(xsc_fill_page_array);
+
+void xsc_core_fill_page_frag_array(struct xsc_frag_buf *buf, __be64 *pas, int npages)
+{
+	int i;
+	dma_addr_t addr;
+	int shift = PAGE_SHIFT - PAGE_SHIFT_4K;
+	int mask = (1 << shift) - 1;
+
+	for (i = 0; i < npages; i++) {
+		addr = buf->frags[i >> shift].map + ((i & mask) << PAGE_SHIFT_4K);
+		pas[i] = cpu_to_be64(addr);
+	}
+}
+EXPORT_SYMBOL_GPL(xsc_core_fill_page_frag_array);
+
+static void *xsc_dma_zalloc_coherent_node(struct xsc_core_device *xdev,
+					  size_t size, dma_addr_t *dma_handle,
+					  int node)
+{
+	struct xsc_dev_resource *dev_res = xdev->dev_res;
+	struct device *device = &xdev->pdev->dev;
+	int original_node;
+	void *cpu_handle;
+
+	/* WA for kernels that don't use numa_mem_id in alloc_pages_node */
+	if (node == NUMA_NO_NODE)
+		node = numa_mem_id();
+
+	mutex_lock(&dev_res->alloc_mutex);
+	original_node = dev_to_node(device);
+	set_dev_node(device, node);
+	cpu_handle = dma_alloc_coherent(device, size, dma_handle,
+					GFP_KERNEL);
+	set_dev_node(device, original_node);
+	mutex_unlock(&dev_res->alloc_mutex);
+	return cpu_handle;
+}
+
+int xsc_core_frag_buf_alloc_node(struct xsc_core_device *xdev, int size,
+				 struct xsc_frag_buf *buf, int node)
+{
+	int i;
+
+	buf->size = size;
+	buf->npages = DIV_ROUND_UP(size, PAGE_SIZE);
+	buf->page_shift = PAGE_SHIFT;
+	buf->frags = kcalloc(buf->npages, sizeof(struct xsc_buf_list),
+			     GFP_KERNEL);
+	if (!buf->frags)
+		goto err_out;
+
+	for (i = 0; i < buf->npages; i++) {
+		struct xsc_buf_list *frag = &buf->frags[i];
+		int frag_sz = min_t(int, size, PAGE_SIZE);
+
+		frag->buf = xsc_dma_zalloc_coherent_node(xdev, frag_sz,
+							 &frag->map, node);
+		if (!frag->buf)
+			goto err_free_buf;
+		if (frag->map & ((1 << buf->page_shift) - 1)) {
+			dma_free_coherent(&xdev->pdev->dev, frag_sz,
+					  buf->frags[i].buf, buf->frags[i].map);
+			xsc_core_warn(xdev, "unexpected map alignment: %pad, page_shift=%d\n",
+				      &frag->map, buf->page_shift);
+			goto err_free_buf;
+		}
+		size -= frag_sz;
+	}
+
+	return 0;
+
+err_free_buf:
+	while (i--)
+		dma_free_coherent(&xdev->pdev->dev, PAGE_SIZE, buf->frags[i].buf,
+				  buf->frags[i].map);
+	kfree(buf->frags);
+err_out:
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(xsc_core_frag_buf_alloc_node);
+
+void xsc_core_frag_buf_free(struct xsc_core_device *xdev, struct xsc_frag_buf *buf)
+{
+	int size = buf->size;
+	int i;
+
+	for (i = 0; i < buf->npages; i++) {
+		int frag_sz = min_t(int, size, PAGE_SIZE);
+
+		dma_free_coherent(&xdev->pdev->dev, frag_sz, buf->frags[i].buf,
+				  buf->frags[i].map);
+		size -= frag_sz;
+	}
+	kfree(buf->frags);
+}
+EXPORT_SYMBOL(xsc_core_frag_buf_free);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
index 4fa2830f1..7e06f1031 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
@@ -12,5 +12,4 @@ int xsc_buf_alloc(struct xsc_core_device *xdev, int size, int max_direct,
 		  struct xsc_buf *buf);
 void xsc_buf_free(struct xsc_core_device *xdev, struct xsc_buf *buf);
 void xsc_fill_page_array(struct xsc_buf *buf, __be64 *pas, int npages);
-
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
index 0af15089c..101a1ca77 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
@@ -4,6 +4,7 @@
  */
 
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
 #include "cq.h"
 
 void xsc_cq_event(struct xsc_core_device *xdev, u32 cqn, int event_type)
@@ -37,3 +38,114 @@ void xsc_init_cq_table(struct xsc_core_device *dev)
 	spin_lock_init(&table->lock);
 	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
 }
+
+static int xsc_create_cq(struct xsc_core_device *xdev, u32 *p_cqn,
+			 struct xsc_create_cq_mbox_in *in, int insize)
+{
+	struct xsc_create_cq_mbox_out out;
+	int ret;
+
+	memset(&out, 0, sizeof(out));
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_CREATE_CQ);
+	ret = xsc_cmd_exec(xdev, in, insize, &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(xdev, "failed to create cq, err=%d out.status=%u\n",
+			     ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	*p_cqn = be32_to_cpu(out.cqn) & 0xffffff;
+	return 0;
+}
+
+static int xsc_destroy_cq(struct xsc_core_device *xdev, u32 cqn)
+{
+	struct xsc_destroy_cq_mbox_in in;
+	struct xsc_destroy_cq_mbox_out out;
+	int ret;
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DESTROY_CQ);
+	in.cqn = cpu_to_be32(cqn);
+	ret = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(xdev, "failed to destroy cq, err=%d out.status=%u\n",
+			     ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
+int xsc_core_eth_create_cq(struct xsc_core_device *xdev, struct xsc_core_cq *xcq,
+			   struct xsc_create_cq_mbox_in *in, int insize)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	u32 cqn;
+	int ret;
+	int err;
+
+	ret = xsc_create_cq(xdev, &cqn, in, insize);
+	if (ret) {
+		xsc_core_err(xdev, "xsc_create_cq failed\n");
+		return -ENOEXEC;
+	}
+	xcq->cqn = cqn;
+	xcq->cons_index = 0;
+	xcq->arm_sn = 0;
+	atomic_set(&xcq->refcount, 1);
+	init_completion(&xcq->free);
+
+	spin_lock_irq(&table->lock);
+	ret = radix_tree_insert(&table->tree, xcq->cqn, xcq);
+	spin_unlock_irq(&table->lock);
+	if (ret)
+		goto err_insert_cq;
+	return 0;
+err_insert_cq:
+	err = xsc_destroy_cq(xdev, cqn);
+	if (err)
+		xsc_core_warn(xdev, "failed to destroy cqn=%d, err=%d\n", xcq->cqn, err);
+	return ret;
+}
+EXPORT_SYMBOL(xsc_core_eth_create_cq);
+
+int xsc_core_eth_destroy_cq(struct xsc_core_device *xdev, struct xsc_core_cq *xcq)
+{
+	struct xsc_cq_table *table = &xdev->dev_res->cq_table;
+	struct xsc_core_cq *tmp;
+	int err;
+
+	spin_lock_irq(&table->lock);
+	tmp = radix_tree_delete(&table->tree, xcq->cqn);
+	spin_unlock_irq(&table->lock);
+	if (!tmp) {
+		err = -ENOENT;
+		goto err_delete_cq;
+	}
+
+	if (tmp != xcq) {
+		err = -EINVAL;
+		goto err_delete_cq;
+	}
+
+	err = xsc_destroy_cq(xdev, xcq->cqn);
+	if (err)
+		goto err_destroy_cq;
+
+	if (atomic_dec_and_test(&xcq->refcount))
+		complete(&xcq->free);
+	wait_for_completion(&xcq->free);
+	return 0;
+
+err_destroy_cq:
+	xsc_core_warn(xdev, "failed to destroy cqn=%d, err=%d\n",
+		      xcq->cqn, err);
+	return err;
+err_delete_cq:
+	xsc_core_warn(xdev, "cqn=%d not found in tree, err=%d\n",
+		      xcq->cqn, err);
+	return err;
+}
+EXPORT_SYMBOL(xsc_core_eth_destroy_cq);
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
index bf1190d1e..73f596c49 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/kthread.h>
 #include "common/xsc_core.h"
+#include "common/xsc_driver.h"
 #include "qp.h"
 
 int xsc_core_create_resource_common(struct xsc_core_device *xdev,
@@ -77,3 +78,112 @@ void xsc_init_qp_table(struct xsc_core_device *xdev)
 	spin_lock_init(&table->lock);
 	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
 }
+
+int xsc_core_eth_create_qp(struct xsc_core_device *xdev,
+			   struct xsc_create_qp_mbox_in *in,
+			   int insize, u32 *p_qpn)
+{
+	struct xsc_create_qp_mbox_out out;
+	int ret;
+
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_CREATE_QP);
+	ret = xsc_cmd_exec(xdev, in, insize, &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(xdev, "failed to create sq, err=%d out.status=%u\n",
+			     ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	*p_qpn = be32_to_cpu(out.qpn) & 0xffffff;
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_eth_create_qp);
+
+int xsc_core_eth_modify_qp_status(struct xsc_core_device *xdev, u32 qpn, u16 status)
+{
+	struct xsc_modify_qp_mbox_in in;
+	struct xsc_modify_qp_mbox_out out;
+	int ret = 0;
+
+	in.hdr.opcode = cpu_to_be16(status);
+	in.qpn = cpu_to_be32(qpn);
+	in.no_need_wait = 1;
+
+	ret = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret || out.hdr.status != 0) {
+		xsc_core_err(xdev, "failed to modify qp %u status=%u, err=%d out.status %u\n",
+			     qpn, status, ret, out.hdr.status);
+		ret = -ENOEXEC;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xsc_core_eth_modify_qp_status);
+
+int xsc_core_eth_destroy_qp(struct xsc_core_device *xdev, u32 qpn)
+{
+	struct xsc_destroy_qp_mbox_in in;
+	struct xsc_destroy_qp_mbox_out out;
+	int err;
+
+	err = xsc_core_eth_modify_qp_status(xdev, qpn, XSC_CMD_OP_2RST_QP);
+	if (err) {
+		xsc_core_warn(xdev, "failed to set sq%d status=rst, err=%d\n", qpn, err);
+		return err;
+	}
+
+	memset(&in, 0, sizeof(in));
+	memset(&out, 0, sizeof(out));
+	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_DESTROY_QP);
+	in.qpn = cpu_to_be32(qpn);
+	err = xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(xdev, "failed to destroy sq%d, err=%d out.status=%u\n",
+			     qpn, err, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_eth_destroy_qp);
+
+int xsc_core_eth_modify_raw_qp(struct xsc_core_device *xdev, struct xsc_modify_raw_qp_mbox_in *in)
+{
+	struct xsc_modify_raw_qp_mbox_out out;
+	int ret;
+
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_MODIFY_RAW_QP);
+
+	ret = xsc_cmd_exec(xdev, in, sizeof(struct xsc_modify_raw_qp_mbox_in),
+			   &out, sizeof(struct xsc_modify_raw_qp_mbox_out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(xdev, "failed to modify sq, err=%d out.status=%u\n",
+			     ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_eth_modify_raw_qp);
+
+int xsc_core_eth_create_rss_qp_rqs(struct xsc_core_device *xdev,
+				   struct xsc_create_multiqp_mbox_in *in,
+				   int insize, int *p_qpn_base)
+{
+	int ret;
+	struct xsc_create_multiqp_mbox_out out;
+
+	in->hdr.opcode = cpu_to_be16(XSC_CMD_OP_CREATE_MULTI_QP);
+	ret = xsc_cmd_exec(xdev, in, insize, &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(xdev,
+			     "failed to create rss rq, qp_num=%d, type=%d, err=%d out.status=%u\n",
+			     in->qp_num, in->qp_type, ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	*p_qpn_base = be32_to_cpu(out.qpn_base) & 0xffffff;
+	return 0;
+}
+EXPORT_SYMBOL(xsc_core_eth_create_rss_qp_rqs);
-- 
2.43.0


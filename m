Return-Path: <netdev+bounces-150061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568E59E8BF3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C888A281AE3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56082214A97;
	Mon,  9 Dec 2024 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="C5dei2Kg"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9B214A87
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728431; cv=none; b=i3lwe5qc7HO4qTami2Tt86ZBUrMruDtdkhkQlYQygOPufMNN5vwzrbfQfxzgIKzzGTQQS3Qw+6EqwgqLIBR2id6tXmofTtY2EEld5mXGkkJGi8uPIocVVHlEx5XL04SqOW/I3jE5dUNllFKHt3OyRS7Ow6ys7kWGLImu2u+EAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728431; c=relaxed/simple;
	bh=sRei/QWoxVBNfhHunIWiqpJ7F6+IcvWt7kTtOr8nt5c=;
	h=To:Date:Mime-Version:Content-Type:From:Cc:Subject:Message-Id; b=r6O1LvaMz9thDMcJagrEQ2qSN32zH/qCE23U3wqcWHbJb+TZqnXa5ICD3y/ta12/xLwp+YfW/N2NxHI1g+R51+WgZvePW7h+ZOYnWytCpZve3psuIWH7HQ0eNuYkn+zXbjFwS3FQlsZ+jzT1skBLwkINJ5Bc9q6h3qJ9vUAVSJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=C5dei2Kg; arc=none smtp.client-ip=209.127.231.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728284; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pAxnLvapLG3tmh0tpmzuJJyZiBM3qTN+unDi2MQ2kgU=;
 b=C5dei2Kg8REaaEtWNh6AdfUzZdlXThzDD6V73pVhTaPzqod3h424Vfb5teZ2cUzkKMtYbB
 h7Jj7PBt3fkX8CQO3ZI0M6ZEYw1PywjzNt6u7Lojl4ES6lO1mGAFvzCbUstcPiLfNhXNln
 NLa1GINJueK4mXfgPAxkSiqN2n6JH1gWq0WimrmSxQyAfURA6mxuWGrVqzsAjViWL5imBz
 tMhQY6x9UnEjMoeLCtgy2zbik3x7Ys2MW9KH+zQXPvzI7kWgjYDOrHxb3M794S0l2V4+Xx
 CrEjb3LgZJ6rvdUKQ02AtfLVGCnY+beRZsua3vRyKgy5XmHHepXNMR/L0jo62A==
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Date: Mon,  9 Dec 2024 15:10:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:22 +0800
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26756981b+fad99d+vger.kernel.org+tianx@yunsilicon.com>
From: "Tian Xin" <tianx@yunsilicon.com>
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
Subject: [PATCH 11/16] net-next/yunsilicon: ndo_open and ndo_stop
Message-Id: <20241209071101.3392590-12-tianx@yunsilicon.com>

From: Xin Tian <tianx@yunsilicon.com>

Add ndo_open and ndo_stop

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   48 +
 .../yunsilicon/xsc/common/xsc_device.h        |   35 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1587 ++++++++++++++++-
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |    8 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  145 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  105 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   15 +
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  146 +-
 9 files changed, 2075 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/driver=
s/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index eec6469f0..8a48bc0b1 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -237,6 +237,40 @@ enum xsc_event {
 	XSC_EVENT_TYPE_WQ_ACCESS_ERROR    =3D 0x11,//IBV_EVENT_QP_ACCESS_ERR
 };
=20
+struct xsc_cqe {
+	union {
+		u8		msg_opcode;
+		struct {
+			u8		error_code:7;
+			u8		is_error:1;
+		};
+	};
+	__le32		qp_id:15;
+	u8		rsv1:1;
+	u8		se:1;
+	u8		has_pph:1;
+	u8		type:1;
+	u8		with_immdt:1;
+	u8		csum_err:4;
+	__le32		imm_data;
+	__le32		msg_len;
+	__le32		vni;
+	__le64		ts:48;
+	__le16		wqe_id;
+	__le16		rsv[3];
+	__le16		rsv2:15;
+	u8		owner:1;
+};
+
+union xsc_cq_doorbell {
+	struct{
+	u32	cq_next_cid:16;
+	u32	cq_id:15;
+	u32	arm:1;
+	};
+	u32	val;
+};
+
 struct xsc_core_cq {
 	u32			cqn;
 	int			cqe_sz;
@@ -511,6 +545,8 @@ struct xsc_core_device {
 	int			bar_num;
=20
 	u8			mac_port;
+	u8			pcie_no;
+	u8			pf_id;
 	u16			glb_func_id;
=20
 	u16			msix_vec_base;
@@ -539,6 +575,8 @@ struct xsc_core_device {
 	u32			fw_version_tweak;
 	u8			fw_version_extra_flag;
 	cpumask_var_t		xps_cpumask;
+
+	u8			user_mode;
 };
=20
=20
@@ -595,4 +633,14 @@ static inline void xsc_mask_cpu_by_node(int node, stru=
ct cpumask *dstp)
 	}
 }
=20
+static inline void xsc_set_user_mode(struct xsc_core_device *dev, u8 mode)
+{
+	dev->user_mode =3D mode;
+}
+
+static inline u8 xsc_get_user_mode(struct xsc_core_device *dev)
+{
+	return dev->user_mode;
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h b/driv=
ers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
index 1238cf7a6..c632129d4 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
@@ -6,6 +6,22 @@
 #ifndef XSC_DEVICE_H
 #define XSC_DEVICE_H
=20
+#include <linux/types.h>
+#include <linux/ethtool.h>
+
+/* QP type */
+enum {
+	XSC_QUEUE_TYPE_RDMA_RC		=3D 0,
+	XSC_QUEUE_TYPE_RDMA_MAD		=3D 1,
+	XSC_QUEUE_TYPE_RAW		=3D 2,
+	XSC_QUEUE_TYPE_VIRTIO_NET	=3D 3,
+	XSC_QUEUE_TYPE_VIRTIO_BLK	=3D 4,
+	XSC_QUEUE_TYPE_RAW_TPE		=3D 5,
+	XSC_QUEUE_TYPE_RAW_TSO		=3D 6,
+	XSC_QUEUE_TYPE_RAW_TX		=3D 7,
+	XSC_QUEUE_TYPE_INVALID		=3D 0xFF,
+};
+
 enum xsc_traffic_types {
 	XSC_TT_IPV4,
 	XSC_TT_IPV4_TCP,
@@ -39,4 +55,23 @@ struct xsc_tirc_config {
 	u32 rx_hash_fields;
 };
=20
+enum {
+	XSC_HASH_FUNC_XOR		=3D 0,
+	XSC_HASH_FUNC_TOP		=3D 1,
+	XSC_HASH_FUNC_TOP_SYM	=3D 2,
+	XSC_HASH_FUNC_RSV		=3D 3,
+};
+
+static inline u8 xsc_hash_func_type(u8 hash_func)
+{
+	switch (hash_func) {
+	case ETH_RSS_HASH_TOP:
+		return XSC_HASH_FUNC_TOP;
+	case ETH_RSS_HASH_XOR:
+		return XSC_HASH_FUNC_XOR;
+	default:
+		return XSC_HASH_FUNC_TOP;
+	}
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net=
/ethernet/yunsilicon/xsc/net/Makefile
index 1aa36573a..c36f37cf4 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y +=3D -I$(srctree)/drivers/net/ethernet/yunsilicon=
/xsc
=20
 obj-$(CONFIG_YUNSILICON_XSC_ETH) +=3D xsc_eth.o
=20
-xsc_eth-y :=3D main.o xsc_eth_wq.o
\ No newline at end of file
+xsc_eth-y :=3D main.o xsc_eth_wq.o xsc_eth_txrx.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/e=
thernet/yunsilicon/xsc/net/main.c
index 76bf62519..36b89587e 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -7,12 +7,14 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/irq.h>
 #include "common/xsc_core.h"
 #include "common/xsc_driver.h"
 #include "common/xsc_device.h"
 #include "common/xsc_pp.h"
 #include "xsc_eth_common.h"
 #include "xsc_eth.h"
+#include "xsc_eth_txrx.h"
=20
 static const struct xsc_tirc_config tirc_default_config[XSC_NUM_INDIR_TIRS=
] =3D {
 	[XSC_TT_IPV4] =3D {
@@ -47,11 +49,6 @@ static const struct xsc_tirc_config tirc_default_config[=
XSC_NUM_INDIR_TIRS] =3D {
 	},
 };
=20
-static int xsc_eth_close(struct net_device *netdev)
-{
-	return 0;
-}
-
 static int xsc_get_max_num_channels(struct xsc_core_device *xdev)
 {
 	return min_t(int, xdev->dev_res->eq_table.num_comp_vectors,
@@ -67,22 +64,22 @@ static void xsc_build_default_indir_rqt(u32 *indirectio=
n_rqt, int len,
 		indirection_rqt[i] =3D i % num_channels;
 }
=20
-static void xsc_build_rss_params(struct xsc_rss_params *rss_params, u16 nu=
m_channels)
+static void xsc_build_rss_param(struct xsc_rss_params *rss_param, u16 num_=
channels)
 {
 	enum xsc_traffic_types tt;
=20
-	rss_params->hfunc =3D ETH_RSS_HASH_TOP;
-	netdev_rss_key_fill(rss_params->toeplitz_hash_key,
-			    sizeof(rss_params->toeplitz_hash_key));
+	rss_param->hfunc =3D ETH_RSS_HASH_TOP;
+	netdev_rss_key_fill(rss_param->toeplitz_hash_key,
+			    sizeof(rss_param->toeplitz_hash_key));
=20
-	xsc_build_default_indir_rqt(rss_params->indirection_rqt,
+	xsc_build_default_indir_rqt(rss_param->indirection_rqt,
 				    XSC_INDIR_RQT_SIZE, num_channels);
=20
 	for (tt =3D 0; tt < XSC_NUM_INDIR_TIRS; tt++) {
-		rss_params->rx_hash_fields[tt] =3D
+		rss_param->rx_hash_fields[tt] =3D
 			tirc_default_config[tt].rx_hash_fields;
 	}
-	rss_params->rss_hash_tmpl =3D XSC_HASH_IP_PORTS | XSC_HASH_IP6_PORTS;
+	rss_param->rss_hash_tmpl =3D XSC_HASH_IP_PORTS | XSC_HASH_IP6_PORTS;
 }
=20
 static void xsc_eth_build_nic_params(struct xsc_adapter *adapter, u32 ch_n=
um, u32 tc_num)
@@ -99,7 +96,7 @@ static void xsc_eth_build_nic_params(struct xsc_adapter *=
adapter, u32 ch_num, u3
=20
 	params->rq_max_size =3D BIT(xdev->caps.log_max_qp_depth);
 	params->sq_max_size =3D BIT(xdev->caps.log_max_qp_depth);
-	xsc_build_rss_params(&adapter->rss_param, adapter->nic_param.num_channels=
);
+	xsc_build_rss_param(&adapter->rss_param, adapter->nic_param.num_channels)=
;
=20
 	xsc_core_info(xdev, "mtu=3D%d, num_ch=3D%d(max=3D%d), num_tc=3D%d\n",
 		      params->mtu, params->num_channels,
@@ -118,6 +115,8 @@ static int xsc_eth_netdev_init(struct xsc_adapter *adap=
ter)
 	if (!adapter->txq2sq)
 		goto err_out;
=20
+	mutex_init(&adapter->status_lock);
+
 	adapter->workq =3D create_singlethread_workqueue("xsc_eth");
 	if (!adapter->workq)
 		goto err_free_priv;
@@ -132,8 +131,1568 @@ static int xsc_eth_netdev_init(struct xsc_adapter *a=
dapter)
 	return -ENOMEM;
 }
=20
-static const struct net_device_ops xsc_netdev_ops =3D {
+static void xsc_eth_build_queue_param(struct xsc_adapter *adapter,
+				      struct xsc_queue_attr *attr, u8 type)
+{
+	struct xsc_core_device *xdev =3D adapter->xdev;
+
+	if (adapter->nic_param.sq_size =3D=3D 0)
+		adapter->nic_param.sq_size =3D BIT(xdev->caps.log_max_qp_depth);
+	if (adapter->nic_param.rq_size =3D=3D 0)
+		adapter->nic_param.rq_size =3D BIT(xdev->caps.log_max_qp_depth);
+
+	if (type =3D=3D XSC_QUEUE_TYPE_EQ) {
+		attr->q_type =3D XSC_QUEUE_TYPE_EQ;
+		attr->ele_num =3D XSC_EQ_ELE_NUM;
+		attr->ele_size =3D XSC_EQ_ELE_SZ;
+		attr->ele_log_size =3D order_base_2(XSC_EQ_ELE_SZ);
+		attr->q_log_size =3D order_base_2(XSC_EQ_ELE_NUM);
+	} else if (type =3D=3D XSC_QUEUE_TYPE_RQCQ) {
+		attr->q_type =3D XSC_QUEUE_TYPE_RQCQ;
+		attr->ele_num =3D min_t(int, XSC_RQCQ_ELE_NUM, xdev->caps.max_cqes);
+		attr->ele_size =3D XSC_RQCQ_ELE_SZ;
+		attr->ele_log_size =3D order_base_2(XSC_RQCQ_ELE_SZ);
+		attr->q_log_size =3D order_base_2(attr->ele_num);
+	} else if (type =3D=3D XSC_QUEUE_TYPE_SQCQ) {
+		attr->q_type =3D XSC_QUEUE_TYPE_SQCQ;
+		attr->ele_num =3D min_t(int, XSC_SQCQ_ELE_NUM, xdev->caps.max_cqes);
+		attr->ele_size =3D XSC_SQCQ_ELE_SZ;
+		attr->ele_log_size =3D order_base_2(XSC_SQCQ_ELE_SZ);
+		attr->q_log_size =3D order_base_2(attr->ele_num);
+	} else if (type =3D=3D XSC_QUEUE_TYPE_RQ) {
+		attr->q_type =3D XSC_QUEUE_TYPE_RQ;
+		attr->ele_num =3D adapter->nic_param.rq_size;
+		attr->ele_size =3D xdev->caps.recv_ds_num * XSC_RECV_WQE_DS;
+		attr->ele_log_size =3D order_base_2(attr->ele_size);
+		attr->q_log_size =3D order_base_2(attr->ele_num);
+	} else if (type =3D=3D XSC_QUEUE_TYPE_SQ) {
+		attr->q_type =3D XSC_QUEUE_TYPE_SQ;
+		attr->ele_num =3D adapter->nic_param.sq_size;
+		attr->ele_size =3D xdev->caps.send_ds_num * XSC_SEND_WQE_DS;
+		attr->ele_log_size =3D order_base_2(attr->ele_size);
+		attr->q_log_size =3D order_base_2(attr->ele_num);
+	}
+}
+
+static u32 xsc_rx_get_linear_frag_sz(u32 mtu)
+{
+	u32 byte_count =3D XSC_SW2HW_FRAG_SIZE(mtu);
+
+	return XSC_SKB_FRAG_SZ(byte_count);
+}
+
+static bool xsc_rx_is_linear_skb(u32 mtu)
+{
+	u32 linear_frag_sz =3D xsc_rx_get_linear_frag_sz(mtu);
+
+	return linear_frag_sz <=3D PAGE_SIZE;
+}
+
+static u32 xsc_get_rq_frag_info(struct xsc_rq_frags_info *frags_info, u32 =
mtu)
+{
+	u32 byte_count =3D XSC_SW2HW_FRAG_SIZE(mtu);
+	int frag_stride;
+	int i =3D 0;
+
+	if (xsc_rx_is_linear_skb(mtu)) {
+		frag_stride =3D xsc_rx_get_linear_frag_sz(mtu);
+		frag_stride =3D roundup_pow_of_two(frag_stride);
+
+		frags_info->arr[0].frag_size =3D byte_count;
+		frags_info->arr[0].frag_stride =3D frag_stride;
+		frags_info->num_frags =3D 1;
+		frags_info->wqe_bulk =3D PAGE_SIZE / frag_stride;
+		frags_info->wqe_bulk_min =3D frags_info->wqe_bulk;
+		goto out;
+	}
+
+	if (byte_count <=3D DEFAULT_FRAG_SIZE) {
+		frags_info->arr[0].frag_size =3D DEFAULT_FRAG_SIZE;
+		frags_info->arr[0].frag_stride =3D DEFAULT_FRAG_SIZE;
+		frags_info->num_frags =3D 1;
+	} else if (byte_count <=3D PAGE_SIZE_4K) {
+		frags_info->arr[0].frag_size =3D PAGE_SIZE_4K;
+		frags_info->arr[0].frag_stride =3D PAGE_SIZE_4K;
+		frags_info->num_frags =3D 1;
+	} else if (byte_count <=3D (PAGE_SIZE_4K + DEFAULT_FRAG_SIZE)) {
+		if (PAGE_SIZE < 2 * PAGE_SIZE_4K) {
+			frags_info->arr[0].frag_size =3D PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride =3D PAGE_SIZE_4K;
+			frags_info->arr[1].frag_size =3D PAGE_SIZE_4K;
+			frags_info->arr[1].frag_stride =3D PAGE_SIZE_4K;
+			frags_info->num_frags =3D 2;
+		} else {
+			frags_info->arr[0].frag_size =3D 2 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride =3D 2 * PAGE_SIZE_4K;
+			frags_info->num_frags =3D 1;
+		}
+	} else if (byte_count <=3D 2 * PAGE_SIZE_4K) {
+		if (PAGE_SIZE < 2 * PAGE_SIZE_4K) {
+			frags_info->arr[0].frag_size =3D PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride =3D PAGE_SIZE_4K;
+			frags_info->arr[1].frag_size =3D PAGE_SIZE_4K;
+			frags_info->arr[1].frag_stride =3D PAGE_SIZE_4K;
+			frags_info->num_frags =3D 2;
+		} else {
+			frags_info->arr[0].frag_size =3D 2 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride =3D 2 * PAGE_SIZE_4K;
+			frags_info->num_frags =3D 1;
+		}
+	} else {
+		if (PAGE_SIZE < 4 * PAGE_SIZE_4K) {
+			frags_info->num_frags =3D roundup(byte_count, PAGE_SIZE_4K) / PAGE_SIZE=
_4K;
+			for (i =3D 0; i < frags_info->num_frags; i++) {
+				frags_info->arr[i].frag_size =3D PAGE_SIZE_4K;
+				frags_info->arr[i].frag_stride =3D PAGE_SIZE_4K;
+			}
+		} else {
+			frags_info->arr[0].frag_size =3D 4 * PAGE_SIZE_4K;
+			frags_info->arr[0].frag_stride =3D 4 * PAGE_SIZE_4K;
+			frags_info->num_frags =3D 1;
+		}
+	}
+
+	if (PAGE_SIZE <=3D PAGE_SIZE_4K) {
+		frags_info->wqe_bulk_min =3D 4;
+		frags_info->wqe_bulk =3D max_t(u8, frags_info->wqe_bulk_min, 8);
+	} else if (PAGE_SIZE <=3D 2 * PAGE_SIZE_4K) {
+		frags_info->wqe_bulk =3D 2;
+		frags_info->wqe_bulk_min =3D frags_info->wqe_bulk;
+	} else {
+		frags_info->wqe_bulk =3D
+			PAGE_SIZE / (frags_info->num_frags * frags_info->arr[0].frag_size);
+		frags_info->wqe_bulk_min =3D frags_info->wqe_bulk;
+	}
+
+out:
+	frags_info->log_num_frags =3D order_base_2(frags_info->num_frags);
+
+	return frags_info->num_frags * frags_info->arr[0].frag_size;
+}
+
+static void xsc_build_rq_frags_info(struct xsc_queue_attr *attr,
+				    struct xsc_rq_frags_info *frags_info,
+				    struct xsc_eth_params *params)
+{
+	params->rq_frags_size =3D xsc_get_rq_frag_info(frags_info, params->mtu);
+	frags_info->frags_max_num =3D attr->ele_size / XSC_RECV_WQE_DS;
+}
+
+static void xsc_eth_build_channel_param(struct xsc_adapter *adapter,
+					struct xsc_channel_param *chl_param)
+{
+	xsc_eth_build_queue_param(adapter, &chl_param->rqcq_param.cq_attr,
+				  XSC_QUEUE_TYPE_RQCQ);
+	chl_param->rqcq_param.wq.buf_numa_node =3D dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->sqcq_param.cq_attr,
+				  XSC_QUEUE_TYPE_SQCQ);
+	chl_param->sqcq_param.wq.buf_numa_node =3D dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->sq_param.sq_attr,
+				  XSC_QUEUE_TYPE_SQ);
+	chl_param->sq_param.wq.buf_numa_node =3D dev_to_node(adapter->dev);
+
+	xsc_eth_build_queue_param(adapter, &chl_param->rq_param.rq_attr,
+				  XSC_QUEUE_TYPE_RQ);
+	chl_param->rq_param.wq.buf_numa_node =3D dev_to_node(adapter->dev);
+
+	xsc_build_rq_frags_info(&chl_param->rq_param.rq_attr,
+				&chl_param->rq_param.frags_info,
+				&adapter->nic_param);
+}
+
+static void xsc_eth_cq_error_event(struct xsc_core_cq *xcq, enum xsc_event=
 event)
+{
+	struct xsc_cq *xsc_cq =3D container_of(xcq, struct xsc_cq, xcq);
+	struct xsc_core_device *xdev =3D xsc_cq->xdev;
+
+	if (event !=3D XSC_EVENT_TYPE_CQ_ERROR) {
+		xsc_core_err(xdev, "Unexpected event type %d on CQ %06x\n",
+			     event, xcq->cqn);
+		return;
+	}
+
+	xsc_core_err(xdev, "Eth catch CQ ERROR=EF=BC=9A%x, cqn: %d\n", event, xcq=
->cqn);
+}
+
+static void xsc_eth_completion_event(struct xsc_core_cq *xcq)
+{
+	struct xsc_cq *cq =3D container_of(xcq, struct xsc_cq, xcq);
+	struct xsc_core_device *xdev =3D cq->xdev;
+	struct xsc_rq *rq =3D NULL;
+
+	if (unlikely(!cq->channel)) {
+		xsc_core_warn(xdev, "cq%d->channel is null\n", xcq->cqn);
+		return;
+	}
+
+	rq =3D &cq->channel->qp.rq[0];
+
+	set_bit(XSC_CHANNEL_NAPI_SCHED, &cq->channel->flags);
+
+	if (!test_bit(XSC_ETH_RQ_STATE_ENABLED, &rq->state))
+		xsc_core_warn(xdev, "ch%d_cq%d, napi_flag=3D0x%lx\n",
+			      cq->channel->chl_idx, xcq->cqn, cq->napi->state);
+
+	napi_schedule(cq->napi);
+	cq->event_ctr++;
+}
+
+static int xsc_eth_alloc_cq(struct xsc_channel *c, struct xsc_cq *pcq,
+			    struct xsc_cq_param *pcq_param)
+{
+	int ret;
+	struct xsc_core_device *xdev =3D c->adapter->xdev;
+	struct xsc_core_cq *core_cq =3D &pcq->xcq;
+	u32 i;
+	u8 q_log_size =3D pcq_param->cq_attr.q_log_size;
+	u8 ele_log_size =3D pcq_param->cq_attr.ele_log_size;
+
+	pcq_param->wq.db_numa_node =3D cpu_to_node(c->cpu);
+	pcq_param->wq.buf_numa_node =3D cpu_to_node(c->cpu);
+
+	ret =3D xsc_eth_cqwq_create(xdev, &pcq_param->wq,
+				  q_log_size, ele_log_size, &pcq->wq,
+				  &pcq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	core_cq->cqe_sz =3D pcq_param->cq_attr.ele_num;
+	core_cq->comp =3D xsc_eth_completion_event;
+	core_cq->event =3D xsc_eth_cq_error_event;
+	core_cq->vector =3D c->chl_idx;
+
+	for (i =3D 0; i < xsc_cqwq_get_size(&pcq->wq); i++) {
+		struct xsc_cqe *cqe =3D xsc_cqwq_get_wqe(&pcq->wq, i);
+
+		cqe->owner =3D 1;
+	}
+	pcq->xdev =3D xdev;
+
+	return ret;
+}
+
+static int xsc_eth_set_cq(struct xsc_channel *c,
+			  struct xsc_cq *pcq,
+			  struct xsc_cq_param *pcq_param)
+{
+	int ret =3D XSCALE_RET_SUCCESS;
+	struct xsc_core_device *xdev =3D c->adapter->xdev;
+	struct xsc_create_cq_mbox_in *in;
+	int inlen;
+	int eqn, irqn;
+	int hw_npages;
+
+	hw_npages =3D DIV_ROUND_UP(pcq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+	/*mbox size + pas size*/
+	inlen =3D sizeof(struct xsc_create_cq_mbox_in) +
+		sizeof(__be64) * hw_npages;
+
+	in =3D kvzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return -ENOMEM;
+
+	/*construct param of in struct*/
+	ret =3D xsc_core_vector2eqn(xdev, c->chl_idx, &eqn, &irqn);
+	if (ret)
+		goto err;
+
+	in->ctx.eqn =3D eqn;
+	in->ctx.eqn =3D cpu_to_be16(in->ctx.eqn);
+	in->ctx.log_cq_sz =3D pcq_param->cq_attr.q_log_size;
+	in->ctx.pa_num =3D cpu_to_be16(hw_npages);
+	in->ctx.glb_func_id =3D cpu_to_be16(xdev->glb_func_id);
+
+	xsc_core_fill_page_frag_array(&pcq->wq_ctrl.buf, &in->pas[0], hw_npages);
+
+	ret =3D xsc_core_eth_create_cq(c->adapter->xdev, &pcq->xcq, in, inlen);
+	if (ret =3D=3D 0) {
+		pcq->xcq.irqn =3D irqn;
+		pcq->xcq.eq =3D xsc_core_eq_get(xdev, pcq->xcq.vector);
+	}
+
+err:
+	kvfree(in);
+	xsc_core_info(c->adapter->xdev, "create ch%d cqn%d, eqn=3D%d, func_id=3D%=
d, ret=3D%d\n",
+		      c->chl_idx, pcq->xcq.cqn, eqn, xdev->glb_func_id, ret);
+	return ret;
+}
+
+static void xsc_eth_free_cq(struct xsc_cq *cq)
+{
+	xsc_eth_wq_destroy(&cq->wq_ctrl);
+}
+
+static int xsc_eth_open_cq(struct xsc_channel *c,
+			   struct xsc_cq *pcq,
+			   struct xsc_cq_param *pcq_param)
+{
+	int ret;
+
+	ret =3D xsc_eth_alloc_cq(c, pcq, pcq_param);
+	if (ret)
+		return ret;
+
+	ret =3D xsc_eth_set_cq(c, pcq, pcq_param);
+	if (ret)
+		goto err_set_cq;
+
+	xsc_cq_notify_hw_rearm(pcq);
+
+	pcq->napi =3D &c->napi;
+	pcq->channel =3D c;
+	pcq->rx =3D (pcq_param->cq_attr.q_type =3D=3D XSC_QUEUE_TYPE_RQCQ) ? 1 : =
0;
+
+	return 0;
+
+err_set_cq:
+	xsc_eth_free_cq(pcq);
+	return ret;
+}
+
+static int xsc_eth_close_cq(struct xsc_channel *c, struct xsc_cq *pcq)
+{
+	int ret;
+	struct xsc_core_device *xdev =3D c->adapter->xdev;
+
+	ret =3D xsc_core_eth_destroy_cq(xdev, &pcq->xcq);
+	if (ret) {
+		xsc_core_warn(xdev, "failed to close ch%d cq%d, ret=3D%d\n",
+			      c->chl_idx, pcq->xcq.cqn, ret);
+		return ret;
+	}
+
+	xsc_eth_free_cq(pcq);
+
+	return 0;
+}
+
+static void xsc_free_qp_sq_db(struct xsc_sq *sq)
+{
+	kvfree(sq->db.wqe_info);
+	kvfree(sq->db.dma_fifo);
+}
+
+static void xsc_free_qp_sq(struct xsc_sq *sq)
+{
+	xsc_free_qp_sq_db(sq);
+	xsc_eth_wq_destroy(&sq->wq_ctrl);
+}
+
+static int xsc_eth_alloc_qp_sq_db(struct xsc_sq *sq, int numa)
+{
+	int wq_sz =3D xsc_wq_cyc_get_size(&sq->wq);
+	struct xsc_core_device *xdev =3D sq->cq.xdev;
+	int df_sz =3D wq_sz * xdev->caps.send_ds_num;
+
+	sq->db.dma_fifo =3D kvzalloc_node(array_size(df_sz, sizeof(*sq->db.dma_fi=
fo)),
+					GFP_KERNEL, numa);
+	sq->db.wqe_info =3D kvzalloc_node(array_size(wq_sz, sizeof(*sq->db.wqe_in=
fo)),
+					GFP_KERNEL, numa);
+
+	if (!sq->db.dma_fifo || !sq->db.wqe_info) {
+		xsc_free_qp_sq_db(sq);
+		return -ENOMEM;
+	}
+
+	sq->dma_fifo_mask =3D df_sz - 1;
+
+	return 0;
+}
+
+static void xsc_eth_qp_event(struct xsc_core_qp *qp, int type)
+{
+	struct xsc_rq *rq;
+	struct xsc_sq *sq;
+	struct xsc_core_device *xdev;
+
+	if (qp->eth_queue_type =3D=3D XSC_RES_RQ) {
+		rq =3D container_of(qp, struct xsc_rq, cqp);
+		xdev =3D rq->cq.xdev;
+	} else if (qp->eth_queue_type =3D=3D XSC_RES_SQ) {
+		sq =3D container_of(qp, struct xsc_sq, cqp);
+		xdev =3D sq->cq.xdev;
+	} else {
+		pr_err("%s:Unknown eth qp type %d\n", __func__, type);
+		return;
+	}
+
+	switch (type) {
+	case XSC_EVENT_TYPE_WQ_CATAS_ERROR:
+	case XSC_EVENT_TYPE_WQ_INVAL_REQ_ERROR:
+	case XSC_EVENT_TYPE_WQ_ACCESS_ERROR:
+		xsc_core_err(xdev, "%s:Async event %x on QP %d\n", __func__, type, qp->q=
pn);
+		break;
+	default:
+		xsc_core_err(xdev, "%s: Unexpected event type %d on QP %d\n",
+			     __func__, type, qp->qpn);
+		return;
+	}
+}
+
+static int xsc_eth_open_qp_sq(struct xsc_channel *c,
+			      struct xsc_sq *psq,
+			      struct xsc_sq_param *psq_param,
+			      u32 sq_idx)
+{
+	struct xsc_adapter *adapter =3D c->adapter;
+	struct xsc_core_device *xdev  =3D adapter->xdev;
+	u8 q_log_size =3D psq_param->sq_attr.q_log_size;
+	u8 ele_log_size =3D psq_param->sq_attr.ele_log_size;
+	struct xsc_create_qp_mbox_in *in;
+	struct xsc_modify_raw_qp_mbox_in *modify_in;
+	int hw_npages;
+	int inlen;
+	int ret;
+
+	psq_param->wq.db_numa_node =3D cpu_to_node(c->cpu);
+
+	ret =3D xsc_eth_wq_cyc_create(xdev, &psq_param->wq,
+				    q_log_size, ele_log_size, &psq->wq,
+				    &psq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	hw_npages =3D DIV_ROUND_UP(psq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+	inlen =3D sizeof(struct xsc_create_qp_mbox_in) +
+		sizeof(__be64) * hw_npages;
+
+	in =3D kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ret =3D -ENOMEM;
+		goto err_sq_wq_destroy;
+	}
+	in->req.input_qpn =3D cpu_to_be16(XSC_QPN_SQN_STUB); /*no use for eth*/
+	in->req.qp_type =3D XSC_QUEUE_TYPE_RAW_TSO; /*default sq is tso qp*/
+	in->req.log_sq_sz =3D ilog2(xdev->caps.send_ds_num) + q_log_size;
+	in->req.pa_num =3D cpu_to_be16(hw_npages);
+	in->req.cqn_send =3D cpu_to_be16(psq->cq.xcq.cqn);
+	in->req.cqn_recv =3D in->req.cqn_send;
+	in->req.glb_funcid =3D cpu_to_be16(xdev->glb_func_id);
+
+	xsc_core_fill_page_frag_array(&psq->wq_ctrl.buf,
+				      &in->req.pas[0], hw_npages);
+
+	ret =3D xsc_core_eth_create_qp(xdev, in, inlen, &psq->sqn);
+	if (ret)
+		goto err_sq_in_destroy;
+
+	psq->cqp.qpn =3D psq->sqn;
+	psq->cqp.event =3D xsc_eth_qp_event;
+	psq->cqp.eth_queue_type =3D XSC_RES_SQ;
+
+	ret =3D xsc_core_create_resource_common(xdev, &psq->cqp);
+	if (ret) {
+		xsc_core_err(xdev, "%s:error qp:%d errno:%d\n",
+			     __func__, psq->sqn, ret);
+		goto err_sq_destroy;
+	}
+
+	psq->channel =3D c;
+	psq->ch_ix =3D c->chl_idx;
+	psq->txq_ix =3D psq->ch_ix + sq_idx * adapter->channels.num_chl;
+
+	/*need to querify from hardware*/
+	psq->hw_mtu =3D XSC_ETH_HW_MTU_SEND;
+	psq->stop_room =3D 1;
+
+	ret =3D xsc_eth_alloc_qp_sq_db(psq, psq_param->wq.db_numa_node);
+	if (ret)
+		goto err_sq_common_destroy;
+
+	inlen =3D sizeof(struct xsc_modify_raw_qp_mbox_in);
+	modify_in =3D kvzalloc(inlen, GFP_KERNEL);
+	if (!modify_in) {
+		ret =3D -ENOMEM;
+		goto err_sq_common_destroy;
+	}
+
+	modify_in->req.qp_out_port =3D xdev->pf_id;
+	modify_in->pcie_no =3D xdev->pcie_no;
+	modify_in->req.qpn =3D cpu_to_be16((u16)(psq->sqn));
+	modify_in->req.func_id =3D cpu_to_be16(xdev->glb_func_id);
+	modify_in->req.dma_direct =3D DMA_DIR_TO_MAC;
+	modify_in->req.prio =3D sq_idx;
+	ret =3D xsc_core_eth_modify_raw_qp(xdev, modify_in);
+	if (ret)
+		goto err_sq_modify_in_destroy;
+
+	kvfree(modify_in);
+	kvfree(in);
+
+	xsc_core_info(c->adapter->xdev,
+		      "open sq ok, ch%d_sq%d_qpn=3D%d, state=3D0x%lx, db_numa=3D%d, buf_=
numa=3D%d\n",
+		      c->chl_idx, sq_idx, psq->sqn, psq->state,
+		      psq_param->wq.db_numa_node, psq_param->wq.buf_numa_node);
+
+	return 0;
+
+err_sq_modify_in_destroy:
+	kvfree(modify_in);
+
+err_sq_common_destroy:
+	xsc_core_destroy_resource_common(xdev, &psq->cqp);
+
+err_sq_destroy:
+	xsc_core_eth_destroy_qp(xdev, psq->cqp.qpn);
+
+err_sq_in_destroy:
+	kvfree(in);
+
+err_sq_wq_destroy:
+	xsc_eth_wq_destroy(&psq->wq_ctrl);
+	return ret;
+}
+
+static int xsc_eth_close_qp_sq(struct xsc_channel *c, struct xsc_sq *psq)
+{
+	struct xsc_core_device *xdev =3D c->adapter->xdev;
+	int ret;
+
+	xsc_core_destroy_resource_common(xdev, &psq->cqp);
+
+	ret =3D xsc_core_eth_destroy_qp(xdev, psq->cqp.qpn);
+	if (ret)
+		return ret;
+
+	xsc_free_qp_sq(psq);
+
+	return 0;
+}
+
+static int xsc_eth_open_channel(struct xsc_adapter *adapter,
+				int idx,
+				struct xsc_channel *c,
+				struct xsc_channel_param *chl_param)
+{
+	int ret =3D 0;
+	struct net_device *netdev =3D adapter->netdev;
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	int i, j, eqn, irqn;
+	const struct cpumask *aff;
+
+	c->adapter =3D adapter;
+	c->netdev =3D adapter->netdev;
+	c->chl_idx =3D idx;
+	c->num_tc =3D adapter->nic_param.num_tc;
+
+	/*1rq per channel, and may have multi sqs per channel*/
+	c->qp.rq_num =3D 1;
+	c->qp.sq_num =3D c->num_tc;
+
+	if (xdev->caps.msix_enable) {
+		ret =3D xsc_core_vector2eqn(xdev, c->chl_idx, &eqn, &irqn);
+		if (ret)
+			goto err;
+		aff =3D irq_get_affinity_mask(irqn);
+		c->aff_mask =3D aff;
+		c->cpu =3D cpumask_first(aff);
+	}
+
+	if (c->qp.sq_num > XSC_MAX_NUM_TC || c->qp.rq_num > XSC_MAX_NUM_TC) {
+		ret =3D -EINVAL;
+		goto err;
+	}
+
+	for (i =3D 0; i < c->qp.rq_num; i++) {
+		ret =3D xsc_eth_open_cq(c, &c->qp.rq[i].cq, &chl_param->rqcq_param);
+		if (ret) {
+			j =3D i - 1;
+			goto err_open_rq_cq;
+		}
+	}
+
+	for (i =3D 0; i < c->qp.sq_num; i++) {
+		ret =3D xsc_eth_open_cq(c, &c->qp.sq[i].cq, &chl_param->sqcq_param);
+		if (ret) {
+			j =3D i - 1;
+			goto err_open_sq_cq;
+		}
+	}
+
+	for (i =3D 0; i < c->qp.sq_num; i++) {
+		ret =3D xsc_eth_open_qp_sq(c, &c->qp.sq[i], &chl_param->sq_param, i);
+		if (ret) {
+			j =3D i - 1;
+			goto err_open_sq;
+		}
+	}
+	netif_napi_add(netdev, &c->napi, xsc_eth_napi_poll);
+
+	xsc_core_dbg(adapter->xdev, "open channel%d ok\n", idx);
+	return 0;
+
+err_open_sq:
+	for (; j >=3D 0; j--)
+		xsc_eth_close_qp_sq(c, &c->qp.sq[j]);
+	j =3D (c->qp.rq_num - 1);
+err_open_sq_cq:
+	for (; j >=3D 0; j--)
+		xsc_eth_close_cq(c, &c->qp.sq[j].cq);
+	j =3D (c->qp.rq_num - 1);
+err_open_rq_cq:
+	for (; j >=3D 0; j--)
+		xsc_eth_close_cq(c, &c->qp.rq[j].cq);
+err:
+	xsc_core_warn(adapter->xdev,
+		      "failed to open channel: ch%d, sq_num=3D%d, rq_num=3D%d, err=3D%d\=
n",
+		      idx, c->qp.sq_num, c->qp.rq_num, ret);
+	return ret;
+}
+
+static int xsc_eth_modify_qps_channel(struct xsc_adapter *adapter, struct =
xsc_channel *c)
+{
+	int ret =3D 0;
+	int i;
+
+	for (i =3D 0; i < c->qp.rq_num; i++) {
+		c->qp.rq[i].post_wqes(&c->qp.rq[i]);
+		ret =3D xsc_core_eth_modify_qp_status(adapter->xdev, c->qp.rq[i].rqn,
+						    XSC_CMD_OP_RTR2RTS_QP);
+		if (ret)
+			return ret;
+	}
+
+	for (i =3D 0; i < c->qp.sq_num; i++) {
+		ret =3D xsc_core_eth_modify_qp_status(adapter->xdev, c->qp.sq[i].sqn,
+						    XSC_CMD_OP_RTR2RTS_QP);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int xsc_eth_modify_qps(struct xsc_adapter *adapter,
+			      struct xsc_eth_channels *chls)
+{
+	int ret;
+	int i;
+
+	for (i =3D 0; i < chls->num_chl; i++) {
+		struct xsc_channel *c =3D &chls->c[i];
+
+		ret =3D xsc_eth_modify_qps_channel(adapter, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void xsc_eth_init_frags_partition(struct xsc_rq *rq)
+{
+	struct xsc_wqe_frag_info next_frag =3D {};
+	struct xsc_wqe_frag_info *prev;
+	int i;
+
+	next_frag.di =3D &rq->wqe.di[0];
+	next_frag.offset =3D 0;
+	prev =3D NULL;
+
+	for (i =3D 0; i < xsc_wq_cyc_get_size(&rq->wqe.wq); i++) {
+		struct xsc_rq_frag_info *frag_info =3D &rq->wqe.info.arr[0];
+		struct xsc_wqe_frag_info *frag =3D
+			&rq->wqe.frags[i << rq->wqe.info.log_num_frags];
+		int f;
+
+		for (f =3D 0; f < rq->wqe.info.num_frags; f++, frag++) {
+			if (next_frag.offset + frag_info[f].frag_stride >
+				XSC_RX_FRAG_SZ) {
+				next_frag.di++;
+				next_frag.offset =3D 0;
+				if (prev)
+					prev->last_in_page =3D 1;
+			}
+			*frag =3D next_frag;
+
+			/* prepare next */
+			next_frag.offset +=3D frag_info[f].frag_stride;
+			prev =3D frag;
+		}
+	}
+
+	if (prev)
+		prev->last_in_page =3D 1;
+}
+
+static int xsc_eth_init_di_list(struct xsc_rq *rq, int wq_sz, int cpu)
+{
+	int len =3D wq_sz << rq->wqe.info.log_num_frags;
+
+	rq->wqe.di =3D kvzalloc_node(array_size(len, sizeof(*rq->wqe.di)),
+				   GFP_KERNEL, cpu_to_node(cpu));
+	if (!rq->wqe.di)
+		return -ENOMEM;
+
+	xsc_eth_init_frags_partition(rq);
+
+	return 0;
+}
+
+static void xsc_eth_free_di_list(struct xsc_rq *rq)
+{
+	kvfree(rq->wqe.di);
+}
+
+static bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+{
+	// TBD
+	return true;
+}
+
+static void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
+				  struct xsc_rq *rq, struct xsc_cqe *cqe)
+{
+	// TBD
+}
+
+static void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
+{
+	// TBD
+}
+
+static struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
+					       struct xsc_wqe_frag_info *wi, u32 cqe_bcnt, u8 has_pph)
+{
+	// TBD
+	return NULL;
+}
+
+static struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
+						  struct xsc_wqe_frag_info *wi,
+						  u32 cqe_bcnt, u8 has_pph)
+{
 	// TBD
+	return NULL;
+}
+
+static int xsc_eth_alloc_rq(struct xsc_channel *c,
+			    struct xsc_rq *prq,
+			    struct xsc_rq_param *prq_param)
+{
+	struct xsc_adapter *adapter =3D c->adapter;
+	u8 q_log_size =3D prq_param->rq_attr.q_log_size;
+	struct page_pool_params pagepool_params =3D { 0 };
+	u32 pool_size =3D 1 << q_log_size;
+	u8 ele_log_size =3D prq_param->rq_attr.ele_log_size;
+	int cache_init_sz =3D 0;
+	int wq_sz;
+	int i, f;
+	int ret =3D 0;
+
+	prq_param->wq.db_numa_node =3D cpu_to_node(c->cpu);
+
+	ret =3D xsc_eth_wq_cyc_create(c->adapter->xdev, &prq_param->wq,
+				    q_log_size, ele_log_size, &prq->wqe.wq,
+				    &prq->wq_ctrl);
+	if (ret)
+		return ret;
+
+	wq_sz =3D xsc_wq_cyc_get_size(&prq->wqe.wq);
+
+	prq->wqe.info =3D prq_param->frags_info;
+	prq->wqe.frags =3D kvzalloc_node(array_size((wq_sz << prq->wqe.info.log_n=
um_frags),
+						  sizeof(*prq->wqe.frags)),
+				       GFP_KERNEL,
+				       cpu_to_node(c->cpu));
+	if (!prq->wqe.frags) {
+		ret =3D -ENOMEM;
+		goto err_alloc_frags;
+	}
+
+	ret =3D xsc_eth_init_di_list(prq, wq_sz, c->cpu);
+	if (ret)
+		goto err_init_di;
+
+	prq->buff.map_dir =3D DMA_FROM_DEVICE;
+	cache_init_sz =3D wq_sz << prq->wqe.info.log_num_frags;
+
+	/* Create a page_pool and register it with rxq */
+	pool_size =3D  wq_sz << prq->wqe.info.log_num_frags;
+	pagepool_params.order		=3D XSC_RX_FRAG_SZ_ORDER;
+	pagepool_params.flags		=3D 0; /* No-internal DMA mapping in page_pool */
+	pagepool_params.pool_size	=3D pool_size;
+	pagepool_params.nid		=3D cpu_to_node(c->cpu);
+	pagepool_params.dev		=3D c->adapter->dev;
+	pagepool_params.dma_dir	=3D prq->buff.map_dir;
+
+	prq->page_pool =3D page_pool_create(&pagepool_params);
+	if (IS_ERR(prq->page_pool)) {
+		ret =3D PTR_ERR(prq->page_pool);
+		prq->page_pool =3D NULL;
+		goto err_create_pool;
+	}
+
+	if (c->chl_idx =3D=3D 0)
+		xsc_core_dbg(adapter->xdev,
+			     "page pool: size=3D%d, cpu=3D%d, pool_numa=3D%d, cache_size=3D%d, =
mtu=3D%d, wqe_numa=3D%d\n",
+			     pool_size, c->cpu, pagepool_params.nid,
+			     cache_init_sz, adapter->nic_param.mtu,
+			     prq_param->wq.buf_numa_node);
+
+	for (i =3D 0; i < wq_sz; i++) {
+		struct xsc_eth_rx_wqe_cyc *wqe =3D
+			xsc_wq_cyc_get_wqe(&prq->wqe.wq, i);
+
+		for (f =3D 0; f < prq->wqe.info.num_frags; f++) {
+			u32 frag_size =3D prq->wqe.info.arr[f].frag_size;
+
+			wqe->data[f].seg_len =3D cpu_to_le32(frag_size);
+			wqe->data[f].mkey =3D cpu_to_le32(XSC_INVALID_LKEY);
+		}
+
+		for (; f < prq->wqe.info.frags_max_num; f++) {
+			wqe->data[f].seg_len =3D 0;
+			wqe->data[f].mkey =3D cpu_to_le32(XSC_INVALID_LKEY);
+			wqe->data[f].va =3D 0;
+		}
+	}
+
+	prq->post_wqes =3D xsc_eth_post_rx_wqes;
+	prq->handle_rx_cqe =3D xsc_eth_handle_rx_cqe;
+	prq->dealloc_wqe =3D xsc_eth_dealloc_rx_wqe;
+	prq->wqe.skb_from_cqe =3D xsc_rx_is_linear_skb(adapter->nic_param.mtu) ?
+					xsc_skb_from_cqe_linear :
+					xsc_skb_from_cqe_nonlinear;
+	prq->ix =3D c->chl_idx;
+	prq->frags_sz =3D adapter->nic_param.rq_frags_size;
+
+	return 0;
+
+err_create_pool:
+	xsc_eth_free_di_list(prq);
+err_init_di:
+	kvfree(prq->wqe.frags);
+err_alloc_frags:
+	xsc_eth_wq_destroy(&prq->wq_ctrl);
+	return ret;
+}
+
+static void xsc_free_qp_rq(struct xsc_rq *rq)
+{
+	kvfree(rq->wqe.frags);
+	kvfree(rq->wqe.di);
+
+	if (rq->page_pool)
+		page_pool_destroy(rq->page_pool);
+
+	xsc_eth_wq_destroy(&rq->wq_ctrl);
+}
+
+static int xsc_eth_open_rss_qp_rqs(struct xsc_adapter *adapter,
+				   struct xsc_rq_param *prq_param,
+				   struct xsc_eth_channels *chls,
+				   unsigned int num_chl)
+{
+	int ret =3D 0, err =3D 0;
+	struct xsc_create_multiqp_mbox_in *in;
+	struct xsc_create_qp_request *req;
+	u8 q_log_size =3D prq_param->rq_attr.q_log_size;
+	int paslen =3D 0;
+	struct xsc_rq *prq;
+	struct xsc_channel *c;
+	int rqn_base;
+	int inlen;
+	int entry_len;
+	int i, j, n;
+	int hw_npages;
+
+	for (i =3D 0; i < num_chl; i++) {
+		c =3D &chls->c[i];
+
+		for (j =3D 0; j < c->qp.rq_num; j++) {
+			prq =3D &c->qp.rq[j];
+			ret =3D xsc_eth_alloc_rq(c, prq, prq_param);
+			if (ret)
+				goto err_alloc_rqs;
+
+			hw_npages =3D DIV_ROUND_UP(prq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+			/*support different npages number smoothly*/
+			entry_len =3D sizeof(struct xsc_create_qp_request) +
+				sizeof(__be64) * hw_npages;
+
+			paslen +=3D entry_len;
+		}
+	}
+
+	inlen =3D sizeof(struct xsc_create_multiqp_mbox_in) + paslen;
+	in =3D kvzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ret =3D -ENOMEM;
+		goto err_create_rss_rqs;
+	}
+
+	in->qp_num =3D cpu_to_be16(num_chl);
+	in->qp_type =3D XSC_QUEUE_TYPE_RAW;
+	in->req_len =3D cpu_to_be32(inlen);
+
+	req =3D (struct xsc_create_qp_request *)&in->data[0];
+	n =3D 0;
+	for (i =3D 0; i < num_chl; i++) {
+		c =3D &chls->c[i];
+		for (j =3D 0; j < c->qp.rq_num; j++) {
+			prq =3D &c->qp.rq[j];
+
+			hw_npages =3D DIV_ROUND_UP(prq->wq_ctrl.buf.size, PAGE_SIZE_4K);
+			/* no use for eth */
+			req->input_qpn =3D cpu_to_be16(0);
+			req->qp_type =3D XSC_QUEUE_TYPE_RAW;
+			req->log_rq_sz =3D ilog2(adapter->xdev->caps.recv_ds_num) +
+						q_log_size;
+			req->pa_num =3D cpu_to_be16(hw_npages);
+			req->cqn_recv =3D cpu_to_be16(prq->cq.xcq.cqn);
+			req->cqn_send =3D req->cqn_recv;
+			req->glb_funcid =3D cpu_to_be16(adapter->xdev->glb_func_id);
+
+			xsc_core_fill_page_frag_array(&prq->wq_ctrl.buf, &req->pas[0], hw_npage=
s);
+			n++;
+			req =3D (struct xsc_create_qp_request *)(&in->data[0] + entry_len * n);
+		}
+	}
+
+	ret =3D xsc_core_eth_create_rss_qp_rqs(adapter->xdev, in, inlen, &rqn_bas=
e);
+	kvfree(in);
+	if (ret)
+		goto err_create_rss_rqs;
+
+	n =3D 0;
+	for (i =3D 0; i < num_chl; i++) {
+		c =3D &chls->c[i];
+		for (j =3D 0; j < c->qp.rq_num; j++) {
+			prq =3D &c->qp.rq[j];
+			prq->rqn =3D rqn_base + n;
+			prq->cqp.qpn =3D prq->rqn;
+			prq->cqp.event =3D xsc_eth_qp_event;
+			prq->cqp.eth_queue_type =3D XSC_RES_RQ;
+			ret =3D xsc_core_create_resource_common(adapter->xdev, &prq->cqp);
+			if (ret) {
+				err =3D ret;
+				xsc_core_err(adapter->xdev,
+					     "create resource common error qp:%d errno:%d\n",
+					     prq->rqn, ret);
+				continue;
+			}
+
+			n++;
+		}
+	}
+	if (err)
+		return err;
+
+	adapter->channels.rqn_base =3D rqn_base;
+	xsc_core_info(adapter->xdev, "rqn_base=3D%d, rq_num=3D%d, state=3D0x%lx\n=
",
+		      rqn_base, num_chl, prq->state);
+	return 0;
+
+err_create_rss_rqs:
+	i =3D num_chl;
+err_alloc_rqs:
+	for (--i; i >=3D 0; i--) {
+		c =3D &chls->c[i];
+		for (j =3D 0; j < c->qp.rq_num; j++) {
+			prq =3D &c->qp.rq[j];
+			xsc_free_qp_rq(prq);
+		}
+	}
+	return ret;
+}
+
+static void xsc_eth_free_rx_wqe(struct xsc_rq *rq)
+{
+	u16 wqe_ix;
+	struct xsc_wq_cyc *wq =3D &rq->wqe.wq;
+
+	while (!xsc_wq_cyc_is_empty(wq)) {
+		wqe_ix =3D xsc_wq_cyc_get_tail(wq);
+		rq->dealloc_wqe(rq, wqe_ix);
+		xsc_wq_cyc_pop(wq);
+	}
+}
+
+static int xsc_eth_close_qp_rq(struct xsc_channel *c, struct xsc_rq *prq)
+{
+	int ret;
+	struct xsc_core_device *xdev =3D c->adapter->xdev;
+
+	xsc_core_destroy_resource_common(xdev, &prq->cqp);
+
+	ret =3D xsc_core_eth_destroy_qp(xdev, prq->cqp.qpn);
+	if (ret)
+		return ret;
+
+	xsc_eth_free_rx_wqe(prq);
+	xsc_free_qp_rq(prq);
+
+	return 0;
+}
+
+static void xsc_eth_close_channel(struct xsc_channel *c, bool free_rq)
+{
+	int i;
+
+	for (i =3D 0; i < c->qp.rq_num; i++) {
+		if (free_rq)
+			xsc_eth_close_qp_rq(c, &c->qp.rq[i]);
+		xsc_eth_close_cq(c, &c->qp.rq[i].cq);
+		memset(&c->qp.rq[i], 0, sizeof(struct xsc_rq));
+	}
+
+	for (i =3D 0; i < c->qp.sq_num; i++) {
+		xsc_eth_close_qp_sq(c, &c->qp.sq[i]);
+		xsc_eth_close_cq(c, &c->qp.sq[i].cq);
+	}
+
+	netif_napi_del(&c->napi);
+}
+
+static int xsc_eth_open_channels(struct xsc_adapter *adapter)
+{
+	int ret =3D 0;
+	int i;
+	struct xsc_channel_param *chl_param;
+	struct xsc_eth_channels *chls =3D &adapter->channels;
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	bool free_rq =3D false;
+
+	chls->num_chl =3D adapter->nic_param.num_channels;
+	chls->c =3D kcalloc_node(chls->num_chl, sizeof(struct xsc_channel),
+			       GFP_KERNEL, xdev->priv.numa_node);
+	if (!chls->c) {
+		ret =3D -ENOMEM;
+		goto err;
+	}
+
+	chl_param =3D kvzalloc(sizeof(*chl_param), GFP_KERNEL);
+	if (!chl_param) {
+		ret =3D -ENOMEM;
+		goto err_free_ch;
+	}
+
+	xsc_eth_build_channel_param(adapter, chl_param);
+
+	for (i =3D 0; i < chls->num_chl; i++) {
+		ret =3D xsc_eth_open_channel(adapter, i, &chls->c[i], chl_param);
+		if (ret)
+			goto err_open_channel;
+	}
+
+	ret =3D xsc_eth_open_rss_qp_rqs(adapter, &chl_param->rq_param, chls, chls=
->num_chl);
+	if (ret)
+		goto err_open_channel;
+	free_rq =3D true;
+
+	for (i =3D 0; i < chls->num_chl; i++)
+		napi_enable(&chls->c[i].napi);
+
+	/* flush cache to memory before interrupt and napi_poll running */
+	smp_wmb();
+
+	ret =3D xsc_eth_modify_qps(adapter, chls);
+	if (ret)
+		goto err_modify_qps;
+
+	kvfree(chl_param);
+	xsc_core_info(adapter->xdev, "open %d channels ok\n", chls->num_chl);
+	return 0;
+
+err_modify_qps:
+	i =3D chls->num_chl;
+err_open_channel:
+	for (--i; i >=3D 0; i--)
+		xsc_eth_close_channel(&chls->c[i], free_rq);
+
+	kvfree(chl_param);
+err_free_ch:
+	kfree(chls->c);
+err:
+	chls->num_chl =3D 0;
+	xsc_core_warn(adapter->xdev, "failed to open %d channels, err=3D%d\n",
+		      chls->num_chl, ret);
+	return ret;
+}
+
+static void xsc_eth_close_channels(struct xsc_adapter *adapter)
+{
+	int i;
+	struct xsc_channel *c =3D NULL;
+
+	for (i =3D 0; i < adapter->channels.num_chl; i++) {
+		c =3D &adapter->channels.c[i];
+		xsc_core_dbg(adapter->xdev, "start to close channel%d\n", c->chl_idx);
+
+		xsc_eth_close_channel(c, true);
+	}
+
+	kfree(adapter->channels.c);
+	adapter->channels.num_chl =3D 0;
+}
+
+static void xsc_netdev_set_tcs(struct xsc_adapter *priv, u16 nch, u8 ntc)
+{
+	int tc;
+
+	netdev_reset_tc(priv->netdev);
+
+	if (ntc =3D=3D 1)
+		return;
+
+	netdev_set_num_tc(priv->netdev, ntc);
+
+	/* Map netdev TCs to offset 0
+	 * We have our own UP to TXQ mapping for QoS
+	 */
+	for (tc =3D 0; tc < ntc; tc++)
+		netdev_set_tc_queue(priv->netdev, tc, nch, 0);
+}
+
+static void xsc_eth_build_tx2sq_maps(struct xsc_adapter *adapter)
+{
+	struct xsc_channel *c;
+	struct xsc_sq *psq;
+	int i, tc;
+
+	for (i =3D 0; i < adapter->channels.num_chl; i++) {
+		c =3D &adapter->channels.c[i];
+		for (tc =3D 0; tc < c->num_tc; tc++) {
+			psq =3D &c->qp.sq[tc];
+			adapter->txq2sq[psq->txq_ix] =3D psq;
+		}
+	}
+}
+
+static void xsc_eth_activate_txqsq(struct xsc_channel *c)
+{
+	int tc =3D c->num_tc;
+	struct xsc_sq *psq;
+
+	for (tc =3D 0; tc < c->num_tc; tc++) {
+		psq =3D &c->qp.sq[tc];
+		psq->txq =3D netdev_get_tx_queue(psq->channel->netdev, psq->txq_ix);
+		set_bit(XSC_ETH_SQ_STATE_ENABLED, &psq->state);
+		netdev_tx_reset_queue(psq->txq);
+		netif_tx_start_queue(psq->txq);
+	}
+}
+
+static void xsc_eth_deactivate_txqsq(struct xsc_channel *c)
+{
+	int tc =3D c->num_tc;
+	struct xsc_sq *psq;
+
+	for (tc =3D 0; tc < c->num_tc; tc++) {
+		psq =3D &c->qp.sq[tc];
+		clear_bit(XSC_ETH_SQ_STATE_ENABLED, &psq->state);
+	}
+}
+
+static void xsc_activate_rq(struct xsc_channel *c)
+{
+	int i;
+
+	for (i =3D 0; i < c->qp.rq_num; i++)
+		set_bit(XSC_ETH_RQ_STATE_ENABLED, &c->qp.rq[i].state);
+}
+
+static void xsc_deactivate_rq(struct xsc_channel *c)
+{
+	int i;
+
+	for (i =3D 0; i < c->qp.rq_num; i++)
+		clear_bit(XSC_ETH_RQ_STATE_ENABLED, &c->qp.rq[i].state);
+}
+
+static void xsc_eth_activate_channel(struct xsc_channel *c)
+{
+	xsc_eth_activate_txqsq(c);
+	xsc_activate_rq(c);
+}
+
+static void xsc_eth_deactivate_channel(struct xsc_channel *c)
+{
+	xsc_deactivate_rq(c);
+	xsc_eth_deactivate_txqsq(c);
+}
+
+static void xsc_eth_activate_channels(struct xsc_eth_channels *chs)
+{
+	int i;
+
+	for (i =3D 0; i < chs->num_chl; i++)
+		xsc_eth_activate_channel(&chs->c[i]);
+}
+
+static void xsc_eth_deactivate_channels(struct xsc_eth_channels *chs)
+{
+	int i;
+
+	for (i =3D 0; i < chs->num_chl; i++)
+		xsc_eth_deactivate_channel(&chs->c[i]);
+
+	/* Sync with all NAPIs to wait until they stop using queues. */
+	synchronize_net();
+
+	for (i =3D 0; i < chs->num_chl; i++)
+		/* last doorbell out */
+		napi_disable(&chs->c[i].napi);
+}
+
+static void xsc_eth_activate_priv_channels(struct xsc_adapter *adapter)
+{
+	int num_txqs;
+	struct net_device *netdev =3D adapter->netdev;
+
+	num_txqs =3D adapter->channels.num_chl * adapter->nic_param.num_tc;
+	xsc_netdev_set_tcs(adapter, adapter->channels.num_chl, adapter->nic_param=
.num_tc);
+	netif_set_real_num_tx_queues(netdev, num_txqs);
+	netif_set_real_num_rx_queues(netdev, adapter->channels.num_chl);
+
+	xsc_eth_build_tx2sq_maps(adapter);
+	xsc_eth_activate_channels(&adapter->channels);
+	netif_tx_start_all_queues(adapter->netdev);
+}
+
+static void xsc_eth_deactivate_priv_channels(struct xsc_adapter *adapter)
+{
+	netif_tx_disable(adapter->netdev);
+	xsc_eth_deactivate_channels(&adapter->channels);
+}
+
+static int xsc_eth_sw_init(struct xsc_adapter *adapter)
+{
+	int ret;
+
+	ret =3D xsc_eth_open_channels(adapter);
+	if (ret)
+		return ret;
+
+	xsc_eth_activate_priv_channels(adapter);
+
+	return 0;
+}
+
+static void xsc_eth_sw_deinit(struct xsc_adapter *adapter)
+{
+	xsc_eth_deactivate_priv_channels(adapter);
+
+	return xsc_eth_close_channels(adapter);
+}
+
+static int _xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod,
+				  u16 vport, void *out, int outlen)
+{
+	struct xsc_query_vport_state_in in;
+
+	memset(&in, 0, sizeof(in));
+	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_QUERY_VPORT_STATE);
+	in.vport_number =3D cpu_to_be16(vport);
+	if (vport)
+		in.other_vport =3D 1;
+
+	return xsc_cmd_exec(dev, &in, sizeof(in), out, outlen);
+}
+
+static u8 xsc_query_vport_state(struct xsc_core_device *dev, u16 opmod, u1=
6 vport)
+{
+	struct xsc_query_vport_state_out out;
+
+	memset(&out, 0, sizeof(out));
+	_xsc_query_vport_state(dev, opmod, vport, &out, sizeof(out));
+
+	return out.state;
+}
+
+static bool xsc_eth_get_link_status(struct xsc_adapter *adapter)
+{
+	bool link_up;
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	u16 vport =3D 0;
+
+	link_up =3D xsc_query_vport_state(xdev, XSC_CMD_OP_QUERY_VPORT_STATE, vpo=
rt);
+
+	xsc_core_dbg(adapter->xdev, "link_status=3D%d\n", link_up);
+
+	return link_up ? true : false;
+}
+
+static int xsc_eth_change_link_status(struct xsc_adapter *adapter)
+{
+	bool link_up;
+
+	link_up =3D xsc_eth_get_link_status(adapter);
+
+	if (link_up && !netif_carrier_ok(adapter->netdev)) {
+		netdev_info(adapter->netdev, "Link up\n");
+		netif_carrier_on(adapter->netdev);
+	} else if (!link_up && netif_carrier_ok(adapter->netdev)) {
+		netdev_info(adapter->netdev, "Link down\n");
+		netif_carrier_off(adapter->netdev);
+	}
+
+	return 0;
+}
+
+static void xsc_eth_event_work(struct work_struct *work)
+{
+	int err;
+	struct xsc_event_query_type_mbox_in in;
+	struct xsc_event_query_type_mbox_out out;
+	struct xsc_adapter *adapter =3D container_of(work, struct xsc_adapter, ev=
ent_work);
+
+	if (adapter->status !=3D XSCALE_ETH_DRIVER_OK)
+		return;
+
+	/*query cmd_type cmd*/
+	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_QUERY_EVENT_TYPE);
+
+	err =3D xsc_cmd_exec(adapter->xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(adapter->xdev, "failed to query event type, err=3D%d, statu=
s=3D%d\n",
+			     err, out.hdr.status);
+		goto failed;
+	}
+
+	switch (out.ctx.resp_cmd_type) {
+	case XSC_CMD_EVENT_RESP_CHANGE_LINK:
+		err =3D xsc_eth_change_link_status(adapter);
+		if (err) {
+			xsc_core_err(adapter->xdev, "failed to change linkstatus, err=3D%d\n", =
err);
+			goto failed;
+		}
+
+		xsc_core_dbg(adapter->xdev, "event cmdtype=3D%04x\n", out.ctx.resp_cmd_t=
ype);
+		break;
+	case XSC_CMD_EVENT_RESP_TEMP_WARN:
+		xsc_core_warn(adapter->xdev, "[Minor]nic chip temperature high warning\n=
");
+		break;
+	case XSC_CMD_EVENT_RESP_OVER_TEMP_PROTECTION:
+		xsc_core_warn(adapter->xdev, "[Critical]nic chip was over-temperature\n"=
);
+		break;
+	default:
+		xsc_core_info(adapter->xdev, "unknown event cmdtype=3D%04x\n",
+			      out.ctx.resp_cmd_type);
+		break;
+	}
+
+failed:
+	return;
+}
+
+static void xsc_eth_event_handler(void *arg)
+{
+	struct xsc_adapter *adapter =3D (struct xsc_adapter *)arg;
+
+	queue_work(adapter->workq, &adapter->event_work);
+}
+
+static inline bool xsc_get_pct_drop_config(struct xsc_core_device *dev)
+{
+	return (dev->pdev->device =3D=3D XSC_MC_PF_DEV_ID) ||
+		(dev->pdev->device =3D=3D XSC_MF_SOC_PF_DEV_ID) ||
+		(dev->pdev->device =3D=3D XSC_MS_PF_DEV_ID) ||
+		(dev->pdev->device =3D=3D XSC_MV_SOC_PF_DEV_ID);
+}
+
+static int xsc_eth_enable_nic_hca(struct xsc_adapter *adapter)
+{
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	struct net_device *netdev =3D adapter->netdev;
+	struct xsc_cmd_enable_nic_hca_mbox_in in =3D {};
+	struct xsc_cmd_enable_nic_hca_mbox_out out =3D {};
+	u16 caps =3D 0;
+	u16 caps_mask =3D 0;
+	int err;
+
+	if (xsc_get_user_mode(xdev))
+		return 0;
+
+	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_ENABLE_NIC_HCA);
+
+	in.rss.rss_en =3D 1;
+	in.rss.rqn_base =3D cpu_to_be16(adapter->channels.rqn_base -
+				xdev->caps.raweth_rss_qp_id_base);
+	in.rss.rqn_num =3D cpu_to_be16(adapter->channels.num_chl);
+	in.rss.hash_tmpl =3D cpu_to_be32(adapter->rss_param.rss_hash_tmpl);
+	in.rss.hfunc =3D xsc_hash_func_type(adapter->rss_param.hfunc);
+	caps_mask |=3D BIT(XSC_TBM_CAP_RSS);
+
+	if (netdev->features & NETIF_F_RXCSUM)
+		caps |=3D BIT(XSC_TBM_CAP_HASH_PPH);
+	caps_mask |=3D BIT(XSC_TBM_CAP_HASH_PPH);
+
+	if (xsc_get_pct_drop_config(xdev) && !(netdev->flags & IFF_SLAVE))
+		caps |=3D BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+	caps_mask |=3D BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+
+	memcpy(in.nic.mac_addr, netdev->dev_addr, ETH_ALEN);
+
+	in.nic.caps =3D cpu_to_be16(caps);
+	in.nic.caps_mask =3D cpu_to_be16(caps_mask);
+
+	err =3D xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(xdev, "failed!! err=3D%d, status=3D%d\n", err, out.hdr.stat=
us);
+		return -ENOEXEC;
+	}
+
+	xsc_core_info(xdev, "caps=3D0x%x, caps_mask=3D0x%x\n", caps, caps_mask);
+
+	return 0;
+}
+
+static int xsc_eth_disable_nic_hca(struct xsc_adapter *adapter)
+{
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	struct net_device *netdev =3D adapter->netdev;
+	struct xsc_cmd_disable_nic_hca_mbox_in in =3D {};
+	struct xsc_cmd_disable_nic_hca_mbox_out out =3D {};
+	int err;
+	u16 caps =3D 0;
+
+	if (xsc_get_user_mode(xdev))
+		return 0;
+
+	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_DISABLE_NIC_HCA);
+
+	if (xsc_get_pct_drop_config(xdev) && !(netdev->priv_flags & IFF_BONDING))
+		caps |=3D BIT(XSC_TBM_CAP_PCT_DROP_CONFIG);
+
+	in.nic.caps =3D cpu_to_be16(caps);
+	err =3D xsc_cmd_exec(xdev, &in, sizeof(in), &out, sizeof(out));
+	if (err || out.hdr.status) {
+		xsc_core_err(xdev, "failed!! err=3D%d, status=3D%d\n", err, out.hdr.stat=
us);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
+static void xsc_set_default_xps_cpumasks(struct xsc_adapter *priv,
+					 struct xsc_eth_params *params)
+{
+	struct xsc_core_device *xdev =3D priv->xdev;
+	int num_comp_vectors, irq;
+
+	num_comp_vectors =3D priv->nic_param.comp_vectors;
+	cpumask_clear(xdev->xps_cpumask);
+
+	for (irq =3D 0; irq < num_comp_vectors; irq++) {
+		xsc_mask_cpu_by_node(xdev->priv.numa_node, xdev->xps_cpumask);
+		netif_set_xps_queue(priv->netdev, xdev->xps_cpumask, irq);
+	}
+}
+
+static int xsc_set_port_admin_status(struct xsc_adapter *adapter,
+				     enum xsc_port_status status)
+{
+	struct xsc_event_set_port_admin_status_mbox_in in;
+	struct xsc_event_set_port_admin_status_mbox_out out;
+	int ret =3D 0;
+
+	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_SET_PORT_ADMIN_STATUS);
+	in.admin_status =3D cpu_to_be16(status);
+
+	ret =3D xsc_cmd_exec(adapter->xdev, &in, sizeof(in), &out, sizeof(out));
+	if (ret || out.hdr.status) {
+		xsc_core_err(adapter->xdev, "failed to set port admin status, err=3D%d, =
status=3D%d\n",
+			     ret, out.hdr.status);
+		return -ENOEXEC;
+	}
+
+	return ret;
+}
+
+static int xsc_eth_open(struct net_device *netdev)
+{
+	struct xsc_adapter *adapter =3D netdev_priv(netdev);
+	struct xsc_core_device *xdev =3D adapter->xdev;
+	int ret =3D XSCALE_RET_SUCCESS;
+
+	mutex_lock(&adapter->status_lock);
+	if (adapter->status =3D=3D XSCALE_ETH_DRIVER_OK) {
+		xsc_core_warn(adapter->xdev, "unnormal ndo_open when status=3D%d\n",
+			      adapter->status);
+		goto ret;
+	}
+
+	ret =3D xsc_eth_sw_init(adapter);
+	if (ret)
+		goto ret;
+
+	ret =3D xsc_eth_enable_nic_hca(adapter);
+	if (ret)
+		goto sw_deinit;
+
+	/*INIT_WORK*/
+	INIT_WORK(&adapter->event_work, xsc_eth_event_work);
+	xdev->event_handler =3D xsc_eth_event_handler;
+
+	if (xsc_eth_get_link_status(adapter))	{
+		netdev_info(netdev, "Link up\n");
+		netif_carrier_on(adapter->netdev);
+	} else {
+		netdev_info(netdev, "Link down\n");
+	}
+
+	adapter->status =3D XSCALE_ETH_DRIVER_OK;
+
+	xsc_set_default_xps_cpumasks(adapter, &adapter->nic_param);
+
+	xsc_set_port_admin_status(adapter, XSC_PORT_UP);
+
+	goto ret;
+
+sw_deinit:
+	xsc_eth_sw_deinit(adapter);
+
+ret:
+	mutex_unlock(&adapter->status_lock);
+	xsc_core_info(xdev, "open %s %s, ret=3D%d\n",
+		      netdev->name, ret ? "failed" : "ok", ret);
+	if (ret)
+		return XSCALE_RET_ERROR;
+	else
+		return XSCALE_RET_SUCCESS;
+}
+
+static int xsc_eth_close(struct net_device *netdev)
+{
+	struct xsc_adapter *adapter =3D netdev_priv(netdev);
+	int ret =3D 0;
+
+	mutex_lock(&adapter->status_lock);
+
+	if (!netif_device_present(netdev)) {
+		ret =3D -ENODEV;
+		goto ret;
+	}
+
+	if (adapter->status !=3D XSCALE_ETH_DRIVER_OK)
+		goto ret;
+
+	adapter->status =3D XSCALE_ETH_DRIVER_CLOSE;
+
+	netif_carrier_off(adapter->netdev);
+
+	xsc_eth_sw_deinit(adapter);
+
+	ret =3D xsc_eth_disable_nic_hca(adapter);
+	if (ret)
+		xsc_core_warn(adapter->xdev, "failed to disable nic hca, err=3D%d\n", re=
t);
+
+	xsc_set_port_admin_status(adapter, XSC_PORT_DOWN);
+
+ret:
+	mutex_unlock(&adapter->status_lock);
+	xsc_core_info(adapter->xdev, "close device %s %s, ret=3D%d\n",
+		      adapter->netdev->name, ret ? "failed" : "ok", ret);
+
+	return ret;
+}
+
+static const struct net_device_ops xsc_netdev_ops =3D {
+	.ndo_open		=3D xsc_eth_open,
+	.ndo_stop		=3D xsc_eth_close,
 };
=20
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/ne=
t/ethernet/yunsilicon/xsc/net/xsc_eth.h
index f9bfaa27a..cda0739bd 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -9,6 +9,12 @@
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
=20
+#define XSC_INVALID_LKEY	0x100
+
+#define XSCALE_DRIVER_NAME "xsc_eth"
+#define XSCALE_RET_SUCCESS		0
+#define XSCALE_RET_ERROR		1
+
 enum {
 	XSCALE_ETH_DRIVER_INIT,
 	XSCALE_ETH_DRIVER_OK,
@@ -34,7 +40,9 @@ struct xsc_adapter {
 	struct xsc_rss_params	rss_param;
=20
 	struct workqueue_struct		*workq;
+	struct work_struct		event_work;
=20
+	struct xsc_eth_channels	channels;
 	struct xsc_sq		**txq2sq;
=20
 	u32	status;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/dri=
vers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index 63fb1fcf9..c67f52275 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -6,22 +6,143 @@
 #ifndef XSC_ETH_COMMON_H
 #define XSC_ETH_COMMON_H
=20
+#include "xsc_queue.h"
+
 #define SW_MIN_MTU		64
 #define SW_DEFAULT_MTU		1500
 #define SW_MAX_MTU		9600
=20
 #define XSC_ETH_HW_MTU_SEND	9800		/*need to obtain from hardware*/
 #define XSC_ETH_HW_MTU_RECV	9800		/*need to obtain from hardware*/
+#define XSC_PPH_HEAD_LEN	64
 #define XSC_SW2HW_MTU(mtu)	((mtu) + 14 + 4)
 #define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + 14 + 8 + 4 + XSC_PPH_HEAD_LEN)
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)
=20
+#define XSC_QPN_SQN_STUB		1025
+#define XSC_QPN_RQN_STUB		1024
+
 #define XSC_LOG_INDIR_RQT_SIZE		0x8
=20
 #define XSC_INDIR_RQT_SIZE			BIT(XSC_LOG_INDIR_RQT_SIZE)
 #define XSC_ETH_MIN_NUM_CHANNELS	2
 #define XSC_ETH_MAX_NUM_CHANNELS	XSC_INDIR_RQT_SIZE
=20
+#define XSC_TX_NUM_TC			1
+#define XSC_MAX_NUM_TC			8
+#define XSC_ETH_MAX_TC_TOTAL		(XSC_ETH_MAX_NUM_CHANNELS * XSC_MAX_NUM_TC)
+#define XSC_ETH_MAX_QP_NUM_PER_CH	(XSC_MAX_NUM_TC + 1)
+
+#define XSC_SKB_FRAG_SZ(len)		(SKB_DATA_ALIGN(len) +	\
+					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
+#define XSC_RQCQ_ELE_SZ		32	//size of a rqcq entry
+#define XSC_SQCQ_ELE_SZ		32	//size of a sqcq entry
+#define XSC_RQ_ELE_SZ		XSC_RECV_WQE_BB
+#define XSC_SQ_ELE_SZ		XSC_SEND_WQE_BB
+#define XSC_EQ_ELE_SZ		8	//size of a eq entry
+
+#define XSC_SKB_FRAG_SZ(len)		(SKB_DATA_ALIGN(len) +	\
+					SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define XSC_MIN_SKB_FRAG_SZ		(XSC_SKB_FRAG_SZ(XSC_RX_HEADROOM))
+#define XSC_LOG_MAX_RX_WQE_BULK	\
+			(ilog2(PAGE_SIZE / roundup_pow_of_two(XSC_MIN_SKB_FRAG_SZ)))
+
+#define XSC_MIN_LOG_RQ_SZ		(1 + XSC_LOG_MAX_RX_WQE_BULK)
+#define XSC_DEF_LOG_RQ_SZ		0xa
+#define XSC_MAX_LOG_RQ_SZ		0xd
+
+#define XSC_MIN_LOG_SQ_SZ		0x6
+#define XSC_DEF_LOG_SQ_SZ		0xa
+#define XSC_MAX_LOG_SQ_SZ		0xd
+
+#define XSC_SQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_SQ_SZ)
+#define XSC_RQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_RQ_SZ)
+
+#define XSC_SQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_SQ_SZ)
+#define XSC_RQ_ELE_NUM_DEF	BIT(XSC_DEF_LOG_RQ_SZ)
+
+#define XSC_LOG_RQCQ_SZ		0xb
+#define XSC_LOG_SQCQ_SZ		0xa
+
+#define XSC_RQCQ_ELE_NUM	BIT(XSC_LOG_RQCQ_SZ)
+#define XSC_SQCQ_ELE_NUM	BIT(XSC_LOG_SQCQ_SZ)
+#define XSC_RQ_ELE_NUM		XSC_RQ_ELE_NUM_DEF //ds number of a wqebb
+#define XSC_SQ_ELE_NUM		XSC_SQ_ELE_NUM_DEF //DS number
+#define XSC_EQ_ELE_NUM		XSC_SQ_ELE_NUM_DEF //number of eq entry???
+
+enum xsc_port_status {
+	XSC_PORT_DOWN      =3D 0,
+	XSC_PORT_UP        =3D 1,
+};
+
+enum xsc_queue_type {
+	XSC_QUEUE_TYPE_EQ =3D 0,
+	XSC_QUEUE_TYPE_RQCQ,
+	XSC_QUEUE_TYPE_SQCQ,
+	XSC_QUEUE_TYPE_RQ,
+	XSC_QUEUE_TYPE_SQ,
+	XSC_QUEUE_TYPE_MAX,
+};
+
+struct xsc_queue_attr {
+	u8  q_type;
+	u32 ele_num;
+	u32 ele_size;
+	u8  ele_log_size;
+	u8  q_log_size;
+};
+
+struct xsc_eth_rx_wqe_cyc {
+	DECLARE_FLEX_ARRAY(struct xsc_wqe_data_seg, data);
+};
+
+struct xsc_eq_param {
+	struct xsc_queue_attr eq_attr;
+};
+
+struct xsc_cq_param {
+	struct xsc_wq_param wq;
+	struct cq_cmd {
+		u8 abc[16];
+	} cqc;
+	struct xsc_queue_attr cq_attr;
+};
+
+struct xsc_rq_param {
+	struct xsc_wq_param wq;
+	struct xsc_queue_attr rq_attr;
+	struct xsc_rq_frags_info frags_info;
+};
+
+struct xsc_sq_param {
+	struct xsc_wq_param wq;
+	struct xsc_queue_attr sq_attr;
+};
+
+struct xsc_qp_param {
+	struct xsc_queue_attr qp_attr;
+};
+
+struct xsc_channel_param {
+	struct xsc_cq_param rqcq_param;
+	struct xsc_cq_param sqcq_param;
+	struct xsc_rq_param rq_param;
+	struct xsc_sq_param sq_param;
+	struct xsc_qp_param qp_param;
+};
+
+struct xsc_eth_qp {
+	u16 rq_num;
+	u16 sq_num;
+	struct xsc_rq rq[XSC_MAX_NUM_TC]; /*may be use one only*/
+	struct xsc_sq sq[XSC_MAX_NUM_TC]; /*reserved to tc*/
+};
+
+enum channel_flags {
+	XSC_CHANNEL_NAPI_SCHED =3D 1,
+};
+
 struct xsc_eth_params {
 	u16	num_channels;
 	u16	max_num_ch;
@@ -53,4 +174,28 @@ struct xsc_eth_params {
 	u32	pflags;
 };
=20
+struct xsc_channel {
+	/* data path */
+	struct xsc_eth_qp  qp;
+	struct napi_struct napi;
+	u8	num_tc;
+	int	chl_idx;
+
+	/*relationship*/
+	struct xsc_adapter *adapter;
+	struct net_device *netdev;
+	int	cpu;
+	unsigned long	flags;
+
+	/* data path - accessed per napi poll */
+	const struct cpumask *aff_mask;
+	struct irq_desc *irq_desc;
+} ____cacheline_aligned_in_smp;
+
+struct xsc_eth_channels {
+	struct xsc_channel *c;
+	unsigned int num_chl;
+	u32 rqn_base;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drive=
rs/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
new file mode 100644
index 000000000..55aed6e5e
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "xsc_eth_common.h"
+#include "xsc_eth_txrx.h"
+
+void xsc_cq_notify_hw_rearm(struct xsc_cq *cq)
+{
+	union xsc_cq_doorbell db;
+
+	db.val =3D 0;
+	db.cq_next_cid =3D cpu_to_le32(cq->wq.cc);
+	db.cq_id =3D cpu_to_le32(cq->xcq.cqn);
+	db.arm =3D 0;
+
+	/* ensure doorbell record is visible to device before ringing the doorbel=
l */
+	wmb();
+	writel(db.val, REG_ADDR(cq->xdev, cq->xdev->regs.complete_db));
+}
+
+void xsc_cq_notify_hw(struct xsc_cq *cq)
+{
+	struct xsc_core_device *xdev  =3D cq->xdev;
+	union xsc_cq_doorbell db;
+
+	dma_wmb();
+
+	db.val =3D 0;
+	db.cq_next_cid =3D cpu_to_le32(cq->wq.cc);
+	db.cq_id =3D cpu_to_le32(cq->xcq.cqn);
+
+	writel(db.val, REG_ADDR(xdev, xdev->regs.complete_reg));
+}
+
+static inline bool xsc_channel_no_affinity_change(struct xsc_channel *c)
+{
+	int current_cpu =3D smp_processor_id();
+
+	return cpumask_test_cpu(current_cpu, c->aff_mask);
+}
+
+static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
+{
+	// TBD
+	return true;
+}
+
+static int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
+{
+	// TBD
+	return 0;
+}
+
+int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct xsc_channel *c =3D container_of(napi, struct xsc_channel, napi);
+	struct xsc_eth_params *params =3D &c->adapter->nic_param;
+	struct xsc_rq *rq =3D &c->qp.rq[0];
+	struct xsc_sq *sq =3D NULL;
+	bool busy =3D false;
+	int work_done =3D 0;
+	int tx_budget =3D 0;
+	int i;
+
+	rcu_read_lock();
+
+	clear_bit(XSC_CHANNEL_NAPI_SCHED, &c->flags);
+
+	tx_budget =3D params->sq_size >> 2;
+	for (i =3D 0; i < c->num_tc; i++)
+		busy |=3D xsc_poll_tx_cq(&c->qp.sq[i].cq, tx_budget);
+
+	/* budget=3D0 means: don't poll rx rings */
+	if (likely(budget)) {
+		work_done =3D xsc_poll_rx_cq(&rq->cq, budget);
+		busy |=3D work_done =3D=3D budget;
+	}
+
+	busy |=3D rq->post_wqes(rq);
+
+	if (busy) {
+		if (likely(xsc_channel_no_affinity_change(c))) {
+			rcu_read_unlock();
+			return budget;
+		}
+		if (budget && work_done =3D=3D budget)
+			work_done--;
+	}
+
+	if (unlikely(!napi_complete_done(napi, work_done)))
+		goto out;
+
+	for (i =3D 0; i < c->num_tc; i++) {
+		sq =3D &c->qp.sq[i];
+		xsc_cq_notify_hw_rearm(&sq->cq);
+	}
+
+	xsc_cq_notify_hw_rearm(&rq->cq);
+out:
+	rcu_read_unlock();
+	return work_done;
+}
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drive=
rs/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
new file mode 100644
index 000000000..5c409570f
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_RXTX_H
+#define XSC_RXTX_H
+
+#include "xsc_eth.h"
+
+void xsc_cq_notify_hw_rearm(struct xsc_cq *cq);
+void xsc_cq_notify_hw(struct xsc_cq *cq);
+int xsc_eth_napi_poll(struct napi_struct *napi, int budget);
+
+#endif /* XSC_RXTX_H */
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/=
net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index b2c848995..58fcdd955 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -6,7 +6,152 @@
 #ifndef XSC_QUEUE_H
 #define XSC_QUEUE_H
=20
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 #include "common/xsc_core.h"
+#include "xsc_eth_wq.h"
+
+enum {
+	XSC_SEND_WQE_DS	=3D 16,
+	XSC_SEND_WQE_BB	=3D 64,
+};
+
+enum {
+	XSC_RECV_WQE_DS	=3D 16,
+	XSC_RECV_WQE_BB	=3D 16,
+};
+
+enum {
+	XSC_ETH_RQ_STATE_ENABLED,
+	XSC_ETH_RQ_STATE_AM,
+	XSC_ETH_RQ_STATE_CACHE_REDUCE_PENDING,
+};
+
+#define XSC_SEND_WQEBB_NUM_DS	        (XSC_SEND_WQE_BB / XSC_SEND_WQE_DS)
+#define XSC_LOG_SEND_WQEBB_NUM_DS	ilog2(XSC_SEND_WQEBB_NUM_DS)
+
+#define XSC_RECV_WQEBB_NUM_DS	        (XSC_RECV_WQE_BB / XSC_RECV_WQE_DS)
+#define XSC_LOG_RECV_WQEBB_NUM_DS	ilog2(XSC_RECV_WQEBB_NUM_DS)
+
+/* each ds holds one fragment in skb */
+#define XSC_MAX_RX_FRAGS        4
+#define XSC_RX_FRAG_SZ_ORDER    0
+#define XSC_RX_FRAG_SZ          (PAGE_SIZE << XSC_RX_FRAG_SZ_ORDER)
+#define DEFAULT_FRAG_SIZE       (2048)
+
+enum {
+	XSC_ETH_SQ_STATE_ENABLED,
+	XSC_ETH_SQ_STATE_AM,
+};
+
+struct xsc_dma_info {
+	struct page	*page;
+	dma_addr_t	addr;
+};
+
+struct xsc_page_cache {
+	struct xsc_dma_info	*page_cache;
+	u32	head;
+	u32	tail;
+	u32	sz;
+	u32	resv;
+};
+
+struct xsc_cq {
+	/* data path - accessed per cqe */
+	struct xsc_cqwq	wq;
+
+	/* data path - accessed per napi poll */
+	u16			event_ctr;
+	struct napi_struct	*napi;
+	struct xsc_core_cq	xcq;
+	struct xsc_channel	*channel;
+
+	/* control */
+	struct xsc_core_device	*xdev;
+	struct xsc_wq_ctrl	wq_ctrl;
+	u8			rx;
+} ____cacheline_aligned_in_smp;
+
+struct xsc_wqe_frag_info {
+	struct xsc_dma_info *di;
+	u32 offset;
+	u8 last_in_page;
+	u8 is_available;
+};
+
+struct xsc_rq_frag_info {
+	int frag_size;
+	int frag_stride;
+};
+
+struct xsc_rq_frags_info {
+	struct xsc_rq_frag_info arr[XSC_MAX_RX_FRAGS];
+	u8 num_frags;
+	u8 log_num_frags;
+	u8 wqe_bulk;
+	u8 wqe_bulk_min;
+	u8 frags_max_num;
+};
+
+struct xsc_rq;
+typedef void (*xsc_fp_handle_rx_cqe)(struct xsc_cqwq *cqwq, struct xsc_rq =
*rq,
+				     struct xsc_cqe *cqe);
+typedef bool (*xsc_fp_post_rx_wqes)(struct xsc_rq *rq);
+typedef void (*xsc_fp_dealloc_wqe)(struct xsc_rq *rq, u16 ix);
+typedef struct sk_buff * (*xsc_fp_skb_from_cqe)(struct xsc_rq *rq,
+			  struct xsc_wqe_frag_info *wi, u32 cqe_bcnt, u8 has_pph);
+
+struct xsc_rq {
+	struct xsc_core_qp		cqp;
+	struct {
+		struct xsc_wq_cyc	wq;
+		struct xsc_wqe_frag_info	*frags;
+		struct xsc_dma_info	*di;
+		struct xsc_rq_frags_info	info;
+		xsc_fp_skb_from_cqe	skb_from_cqe;
+	} wqe;
+
+	struct {
+		u16	headroom;
+		u8	map_dir;	/* dma map direction */
+	} buff;
+
+	struct page_pool	*page_pool;
+	struct xsc_wq_ctrl	wq_ctrl;
+	struct xsc_cq		cq;
+	u32	rqn;
+	int	ix;
+
+	unsigned long	state;
+	struct work_struct  recover_work;
+
+	u32 hw_mtu;
+	u32 frags_sz;
+
+	xsc_fp_handle_rx_cqe	handle_rx_cqe;
+	xsc_fp_post_rx_wqes	post_wqes;
+	xsc_fp_dealloc_wqe	dealloc_wqe;
+	struct xsc_page_cache	page_cache;
+} ____cacheline_aligned_in_smp;
+
+enum xsc_dma_map_type {
+	XSC_DMA_MAP_SINGLE,
+	XSC_DMA_MAP_PAGE
+};
+
+struct xsc_sq_dma {
+	dma_addr_t	addr;
+	u32		size;
+	enum xsc_dma_map_type	type;
+};
+
+struct xsc_tx_wqe_info {
+	struct sk_buff *skb;
+	u32 num_bytes;
+	u8  num_wqebbs;
+	u8  num_dma;
+};
=20
 struct xsc_sq {
 	struct xsc_core_qp		cqp;
@@ -23,7 +168,6 @@ struct xsc_sq {
 	/* read only */
 	struct xsc_wq_cyc         wq;
 	u32                        dma_fifo_mask;
-	struct xsc_sq_stats     *stats;
 	struct {
 		struct xsc_sq_dma         *dma_fifo;
 		struct xsc_tx_wqe_info    *wqe_info;
--=20
2.43.0


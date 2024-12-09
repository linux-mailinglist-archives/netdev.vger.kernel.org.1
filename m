Return-Path: <netdev+bounces-150048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A5D9E8BDF
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D088E1629B4
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F7214A67;
	Mon,  9 Dec 2024 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="CpzEMxtZ"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-48.ptr.blmpb.com (va-2-48.ptr.blmpb.com [209.127.231.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C374214A7C
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728297; cv=none; b=phN4hM0YcYjnm2biSzjZLnBQk5jYJAyxw7sFWM09MopsjNhbCL4gtjkGdC50M/T/LW2IfT1sFpiE/ENut29hihP2oGzeGVDOwxBRjTNFj+0bjdS/szx5fBLsRqLw7iosEHVMaN5j+IqQomaMdoRcW30Dhrfhgn3gU0xQG7PUZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728297; c=relaxed/simple;
	bh=vhs7iG228nrQdiE3vgbOo131Eu6RxH1mdyPOe75HzJg=;
	h=From:Content-Type:To:Date:Mime-Version:Message-Id:Cc:Subject; b=nTYK/Bp4zjbBe9DBI5Qw4lChuuZj2JMHjZPvFLDN1bN74O+dVk4wJeFEdqWW6Q8j4wLFJvlLEfJHnx4l3qhICk9qcT9Wgfd5NbKtiC7cnivWSYZmvjBlnyIlzZ9djxIG85o5VK6J8UHj4tubJrf8r0INbpwS4vPPjc43yGBbkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=CpzEMxtZ; arc=none smtp.client-ip=209.127.231.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728288; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=iNybs6aMyxsFaETBZBLhTDAAnrQyY25vtvWH9jBZ3jM=;
 b=CpzEMxtZMWKgER6Z8SK/DMfTkdyOE0mVgUhf1uc/Z0v0WghQQXoYTGk4sNfTBVlUNta/1N
 hpC4pJb6dJb142f8qjg8jfna7eZJ8Jd+a2GIgkU6fl0VJ/QrFhyXJAFO0d6O6zUytERKw/
 X0ALpTg+tjG6qUbqBHyEMzyQ0/4TpggBFjizAbQrSHFPPoWjKSmW4KrGPFWdr0O3nARpR9
 sHfy73dn0RFmM+g3Y14FljrOKZF5+E863D73lCqvo2WR/vzE71vaQiscaoyJYemNPR4X8Y
 UA+HTDwWkCQDm+bs6UUV698Qlo8T7KJczn/xKVPPg40dwli0uConCV8PbHI+kg==
From: "Tian Xin" <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-From: Tian Xin <tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26756981e+b37a26+vger.kernel.org+tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Date: Mon,  9 Dec 2024 15:10:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <20241209071101.3392590-14-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
Subject: [PATCH 13/16] net-next/yunsilicon: Add eth rx
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:25 +0800

From: Xin Tian <tianx@yunsilicon.com>

Add eth rx

Signed-off-by: Xin Tian <tianx@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   9 +
 .../ethernet/yunsilicon/xsc/common/xsc_pph.h  | 176 +++++
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    |  39 +-
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  28 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  | 647 ++++++++++++++++++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  25 -
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  92 ++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |  64 ++
 9 files changed, 1013 insertions(+), 69 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pph.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 8a48bc0b1..979e3b150 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -227,6 +227,10 @@ struct xsc_qp_table {
 };
 
 // cq
+enum {
+	XSC_CQE_OWNER_MASK	= 1,
+};
+
 enum xsc_event {
 	XSC_EVENT_TYPE_COMP               = 0x0,
 	XSC_EVENT_TYPE_COMM_EST           = 0x02,//mad
@@ -643,4 +647,9 @@ static inline u8 xsc_get_user_mode(struct xsc_core_device *dev)
 	return dev->user_mode;
 }
 
+static inline u8 get_cqe_opcode(struct xsc_cqe *cqe)
+{
+	return cqe->msg_opcode;
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pph.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pph.h
new file mode 100644
index 000000000..daf191b6c
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_pph.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021 - 2023, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_PPH_H
+#define XSC_PPH_H
+
+#define XSC_PPH_HEAD_LEN	64
+
+enum {
+	L4_PROTO_NONE	= 0,
+	L4_PROTO_TCP	= 1,
+	L4_PROTO_UDP	= 2,
+	L4_PROTO_ICMP	= 3,
+	L4_PROTO_GRE	= 4,
+};
+
+enum {
+	L3_PROTO_NONE	= 0,
+	L3_PROTO_IP	= 2,
+	L3_PROTO_IP6	= 3,
+};
+
+struct epp_pph {
+	u16 outer_eth_type;              //2 bytes
+	u16 inner_eth_type;              //4 bytes
+
+	u16 rsv1:1;
+	u16 outer_vlan_flag:2;
+	u16 outer_ip_type:2;
+	u16 outer_ip_ofst:5;
+	u16 outer_ip_len:6;                //6 bytes
+
+	u16 rsv2:1;
+	u16 outer_tp_type:3;
+	u16 outer_tp_csum_flag:1;
+	u16 outer_tp_ofst:7;
+	u16 ext_tunnel_type:4;              //8 bytes
+
+	u8 tunnel_ofst;                     //9 bytes
+	u8 inner_mac_ofst;                  //10 bytes
+
+	u32 rsv3:2;
+	u32 inner_mac_flag:1;
+	u32 inner_vlan_flag:2;
+	u32 inner_ip_type:2;
+	u32 inner_ip_ofst:8;
+	u32 inner_ip_len:6;
+	u32 inner_tp_type:2;
+	u32 inner_tp_csum_flag:1;
+	u32 inner_tp_ofst:8;		//14 bytees
+
+	u16 rsv4:1;
+	u16 payload_type:4;
+	u16 payload_ofst:8;
+	u16 pkt_type:3;			//16 bytes
+
+	u16 rsv5:2;
+	u16 pri:3;
+	u16 logical_in_port:11;
+	u16 vlan_info;
+	u8 error_bitmap:8;			//21 bytes
+
+	u8 rsv6:7;
+	u8 recirc_id_vld:1;
+	u16 recirc_id;			//24 bytes
+
+	u8 rsv7:7;
+	u8 recirc_data_vld:1;
+	u32 recirc_data;			//29 bytes
+
+	u8 rsv8:6;
+	u8 mark_tag_vld:2;
+	u16 mark_tag;			//32 bytes
+
+	u8 rsv9:4;
+	u8 upa_to_soc:1;
+	u8 upa_from_soc:1;
+	u8 upa_re_up_call:1;
+	u8 upa_pkt_drop:1;			//33 bytes
+
+	u8 ucdv;
+	u16 rsv10:2;
+	u16 pkt_len:14;			//36 bytes
+
+	u16 rsv11:2;
+	u16 pkt_hdr_ptr:14;		//38 bytes
+
+	u64	 rsv12:5;
+	u64	 csum_ofst:8;
+	u64	 csum_val:29;
+	u64	 csum_plen:14;
+	u64	 rsv11_0:8;			//46 bytes
+
+	u64	 rsv11_1;
+	u64	 rsv11_2;
+	u16 rsv11_3;
+};
+
+#define OUTER_L3_BIT	BIT(3)
+#define OUTER_L4_BIT	BIT(2)
+#define INNER_L3_BIT	BIT(1)
+#define INNER_L4_BIT	BIT(0)
+#define OUTER_BIT		(OUTER_L3_BIT | OUTER_L4_BIT)
+#define INNER_BIT		(INNER_L3_BIT | INNER_L4_BIT)
+#define OUTER_AND_INNER	(OUTER_BIT | INNER_BIT)
+
+#define PACKET_UNKNOWN	BIT(4)
+
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_OFFSET (6UL)
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_MASK (0XF00)
+#define EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_OFFSET (8)
+
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_OFFSET (20UL)
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_MASK (0XFF)
+#define EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_OFFSET (0)
+
+#define XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(PPH_BASE_ADDR)	\
+	((*(u16 *)((u8 *)(PPH_BASE_ADDR) + EPP2SOC_PPH_EXT_TUNNEL_TYPE_OFFSET) & \
+	EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_MASK) >> EPP2SOC_PPH_EXT_TUNNEL_TYPE_BIT_OFFSET)
+
+#define XSC_GET_EPP2SOC_PPH_ERROR_BITMAP(PPH_BASE_ADDR)		\
+	((*(u8 *)((u8 *)(PPH_BASE_ADDR) + EPP2SOC_PPH_EXT_ERROR_BITMAP_OFFSET) & \
+	EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_MASK) >> EPP2SOC_PPH_EXT_ERROR_BITMAP_BIT_OFFSET)
+
+#define PPH_OUTER_IP_TYPE_OFF		(4UL)
+#define PPH_OUTER_IP_TYPE_MASK		(0x3)
+#define PPH_OUTER_IP_TYPE_SHIFT		(11)
+#define PPH_OUTER_IP_TYPE(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_TYPE_OFF)) >> \
+	PPH_OUTER_IP_TYPE_SHIFT) & PPH_OUTER_IP_TYPE_MASK)
+
+#define PPH_OUTER_IP_OFST_OFF		(4UL)
+#define PPH_OUTER_IP_OFST_MASK		(0x1f)
+#define PPH_OUTER_IP_OFST_SHIFT		(6)
+#define PPH_OUTER_IP_OFST(base)		 \
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_OFST_OFF)) >> \
+	PPH_OUTER_IP_OFST_SHIFT) & PPH_OUTER_IP_OFST_MASK)
+
+#define PPH_OUTER_IP_LEN_OFF		(4UL)
+#define PPH_OUTER_IP_LEN_MASK		(0x3f)
+#define PPH_OUTER_IP_LEN_SHIFT		(0)
+#define PPH_OUTER_IP_LEN(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_IP_LEN_OFF)) >> \
+	PPH_OUTER_IP_LEN_SHIFT) & PPH_OUTER_IP_LEN_MASK)
+
+#define PPH_OUTER_TP_TYPE_OFF		(6UL)
+#define PPH_OUTER_TP_TYPE_MASK		(0x7)
+#define PPH_OUTER_TP_TYPE_SHIFT		(12)
+#define PPH_OUTER_TP_TYPE(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_OUTER_TP_TYPE_OFF)) >> \
+	PPH_OUTER_TP_TYPE_SHIFT) & PPH_OUTER_TP_TYPE_MASK)
+
+#define PPH_PAYLOAD_OFST_OFF		(14UL)
+#define PPH_PAYLOAD_OFST_MASK		(0xff)
+#define PPH_PAYLOAD_OFST_SHIFT		(3)
+#define PPH_PAYLOAD_OFST(base)		\
+	((ntohs(*(u16 *)((u8 *)(base) + PPH_PAYLOAD_OFST_OFF)) >> \
+	PPH_PAYLOAD_OFST_SHIFT) & PPH_PAYLOAD_OFST_MASK)
+
+#define PPH_CSUM_OFST_OFF		(38UL)
+#define PPH_CSUM_OFST_MASK		(0xff)
+#define PPH_CSUM_OFST_SHIFT		(51)
+#define PPH_CSUM_OFST(base)		\
+	((be64_to_cpu(*(u64	 *)((u8 *)(base) + PPH_CSUM_OFST_OFF)) >> \
+	PPH_CSUM_OFST_SHIFT) & PPH_CSUM_OFST_MASK)
+
+#define PPH_CSUM_VAL_OFF		(38UL)
+#define PPH_CSUM_VAL_MASK		(0xeffffff)
+#define PPH_CSUM_VAL_SHIFT		(22)
+#define PPH_CSUM_VAL(base)		\
+	((be64_to_cpu(*(u64	 *)((u8 *)(base) + PPH_CSUM_VAL_OFF)) >> \
+	PPH_CSUM_VAL_SHIFT) & PPH_CSUM_VAL_MASK)
+#endif /* XSC_TBM_H */
+
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index decab0ee4..bc24622c6 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index be38c951e..1af4e9948 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -835,38 +835,6 @@ static void xsc_eth_free_di_list(struct xsc_rq *rq)
 	kvfree(rq->wqe.di);
 }
 
-static bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
-{
-	// TBD
-	return true;
-}
-
-static void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
-				  struct xsc_rq *rq, struct xsc_cqe *cqe)
-{
-	// TBD
-}
-
-static void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
-{
-	// TBD
-}
-
-static struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
-					       struct xsc_wqe_frag_info *wi, u32 cqe_bcnt, u8 has_pph)
-{
-	// TBD
-	return NULL;
-}
-
-static struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
-						  struct xsc_wqe_frag_info *wi,
-						  u32 cqe_bcnt, u8 has_pph)
-{
-	// TBD
-	return NULL;
-}
-
 static int xsc_eth_alloc_rq(struct xsc_channel *c,
 			    struct xsc_rq *prq,
 			    struct xsc_rq_param *prq_param)
@@ -876,7 +844,6 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
 	struct page_pool_params pagepool_params = { 0 };
 	u32 pool_size = 1 << q_log_size;
 	u8 ele_log_size = prq_param->rq_attr.ele_log_size;
-	int cache_init_sz = 0;
 	int wq_sz;
 	int i, f;
 	int ret = 0;
@@ -906,7 +873,6 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
 		goto err_init_di;
 
 	prq->buff.map_dir = DMA_FROM_DEVICE;
-	cache_init_sz = wq_sz << prq->wqe.info.log_num_frags;
 
 	/* Create a page_pool and register it with rxq */
 	pool_size =  wq_sz << prq->wqe.info.log_num_frags;
@@ -926,9 +892,8 @@ static int xsc_eth_alloc_rq(struct xsc_channel *c,
 
 	if (c->chl_idx == 0)
 		xsc_core_dbg(adapter->xdev,
-			     "page pool: size=%d, cpu=%d, pool_numa=%d, cache_size=%d, mtu=%d, wqe_numa=%d\n",
-			     pool_size, c->cpu, pagepool_params.nid,
-			     cache_init_sz, adapter->nic_param.mtu,
+			     "page pool: size=%d, cpu=%d, pool_numa=%d, mtu=%d, wqe_numa=%d\n",
+			     pool_size, c->cpu, pagepool_params.nid, adapter->nic_param.mtu,
 			     prq_param->wq.buf_numa_node);
 
 	for (i = 0; i < wq_sz; i++) {
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index b7b8fff61..291ef1483 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -19,6 +19,8 @@
 #define XSC_SW2HW_FRAG_SIZE(mtu)	((mtu) + 14 + 8 + 4 + XSC_PPH_HEAD_LEN)
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	((mtu) + 14 + 256)
 
+#define XSC_RX_MAX_HEAD			(256)
+
 #define XSC_QPN_SQN_STUB		1025
 #define XSC_QPN_RQN_STUB		1024
 
@@ -143,6 +145,24 @@ enum channel_flags {
 	XSC_CHANNEL_NAPI_SCHED = 1,
 };
 
+enum xsc_eth_priv_flag {
+	XSC_PFLAG_RX_NO_CSUM_COMPLETE,
+	XSC_PFLAG_SNIFFER,
+	XSC_PFLAG_DROPLESS_RQ,
+	XSC_PFLAG_RX_COPY_BREAK,
+	XSC_NUM_PFLAGS, /* Keep last */
+};
+
+#define XSC_SET_PFLAG(params, pflag, enable)			\
+	do {							\
+		if (enable)					\
+			(params)->pflags |= BIT(pflag);		\
+		else						\
+			(params)->pflags &= ~(BIT(pflag));	\
+	} while (0)
+
+#define XSC_GET_PFLAG(params, pflag) (!!((params)->pflags & (BIT(pflag))))
+
 struct xsc_eth_params {
 	u16	num_channels;
 	u16	max_num_ch;
@@ -206,4 +226,12 @@ union xsc_send_doorbell {
 	u32 send_data;
 };
 
+union xsc_recv_doorbell {
+	struct{
+		s32  next_pid : 13;
+		u32 qp_num : 15;
+	};
+	u32 recv_data;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
new file mode 100644
index 000000000..b4c8cc783
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -0,0 +1,647 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2021-2024, Shanghai Yunsilicon Technology Co., Ltd. All
+ * rights reserved.
+ * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
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
+#include <linux/net_tstamp.h>
+#include "xsc_eth.h"
+#include "xsc_eth_txrx.h"
+#include "xsc_eth_common.h"
+#include <linux/device.h>
+#include "common/xsc_pp.h"
+#include "common/xsc_pph.h"
+
+#define PAGE_REF_ELEV  (U16_MAX)
+/* Upper bound on number of packets that share a single page */
+#define PAGE_REF_THRSD (PAGE_SIZE / 64)
+
+static inline void xsc_rq_notify_hw(struct xsc_rq *rq)
+{
+	struct xsc_core_device *xdev = rq->cq.xdev;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	union xsc_recv_doorbell doorbell_value;
+	u64 rqwqe_id = wq->wqe_ctr << (ilog2(xdev->caps.recv_ds_num));
+
+	/*reverse wqe index to ds index*/
+	doorbell_value.next_pid = rqwqe_id;
+	doorbell_value.qp_num = rq->rqn;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+	writel(doorbell_value.recv_data, REG_ADDR(xdev, xdev->regs.rx_db));
+}
+
+static inline void xsc_skb_set_hash(struct xsc_adapter *adapter,
+				    struct xsc_cqe *cqe,
+				    struct sk_buff *skb)
+{
+	struct xsc_rss_params *rss = &adapter->rss_param;
+	u32 hash_field;
+	bool l3_hash = false;
+	bool l4_hash = false;
+	int ht = 0;
+
+	if (adapter->netdev->features & NETIF_F_RXHASH) {
+		if (skb->protocol == htons(ETH_P_IP)) {
+			hash_field = rss->rx_hash_fields[XSC_TT_IPV4_TCP];
+			if (hash_field & XSC_HASH_FIELD_SEL_SRC_IP ||
+			    hash_field & XSC_HASH_FIELD_SEL_DST_IP)
+				l3_hash = true;
+
+			if (hash_field & XSC_HASH_FIELD_SEL_SPORT ||
+			    hash_field & XSC_HASH_FIELD_SEL_DPORT)
+				l4_hash = true;
+		} else if (skb->protocol == htons(ETH_P_IPV6)) {
+			hash_field = rss->rx_hash_fields[XSC_TT_IPV6_TCP];
+			if (hash_field & XSC_HASH_FIELD_SEL_SRC_IPV6 ||
+			    hash_field & XSC_HASH_FIELD_SEL_DST_IPV6)
+				l3_hash = true;
+
+			if (hash_field & XSC_HASH_FIELD_SEL_SPORT_V6 ||
+			    hash_field & XSC_HASH_FIELD_SEL_DPORT_V6)
+				l4_hash = true;
+		}
+
+		if (l3_hash && l4_hash)
+			ht = PKT_HASH_TYPE_L4;
+		else if (l3_hash)
+			ht = PKT_HASH_TYPE_L3;
+		if (ht)
+			skb_set_hash(skb, be32_to_cpu(cqe->vni), ht);
+	}
+}
+
+static inline unsigned short from32to16(unsigned int x)
+{
+	/* add up 16-bit and 16-bit for 16+c bit */
+	x = (x & 0xffff) + (x >> 16);
+	/* add up carry.. */
+	x = (x & 0xffff) + (x >> 16);
+	return x;
+}
+
+static inline void xsc_handle_csum(struct xsc_cqe *cqe, struct xsc_rq *rq,
+				   struct sk_buff *skb, struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct net_device *netdev = c->adapter->netdev;
+	struct xsc_dma_info *dma_info = wi->di;
+	int offset_from = wi->offset;
+	struct epp_pph *hw_pph = page_address(dma_info->page) + offset_from;
+
+	if (unlikely((netdev->features & NETIF_F_RXCSUM) == 0))
+		goto csum_none;
+
+	if (unlikely(XSC_GET_EPP2SOC_PPH_ERROR_BITMAP(hw_pph) & PACKET_UNKNOWN))
+		goto csum_none;
+
+	if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+	    (!(cqe->csum_err & OUTER_AND_INNER))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 1;
+		skb->encapsulation = 1;
+	} else if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(cqe->csum_err & OUTER_BIT) && (cqe->csum_err & INNER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 0;
+		skb->encapsulation = 1;
+	} else if (!XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(cqe->csum_err & OUTER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+	}
+
+	goto out;
+
+csum_none:
+	skb->csum = 0;
+	skb->ip_summed = CHECKSUM_NONE;
+out:
+	return;
+}
+
+static inline void xsc_build_rx_skb(struct xsc_cqe *cqe,
+				    u32 cqe_bcnt,
+				    struct xsc_rq *rq,
+				    struct sk_buff *skb,
+				    struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct net_device *netdev = c->netdev;
+	struct xsc_adapter *adapter = c->adapter;
+
+	skb->mac_len = ETH_HLEN;
+
+	skb_record_rx_queue(skb, rq->ix);
+	xsc_handle_csum(cqe, rq, skb, wi);
+
+	skb->protocol = eth_type_trans(skb, netdev);
+	xsc_skb_set_hash(adapter, cqe, skb);
+}
+
+static inline void xsc_complete_rx_cqe(struct xsc_rq *rq,
+				       struct xsc_cqe *cqe,
+				       u32 cqe_bcnt,
+				       struct sk_buff *skb,
+				       struct xsc_wqe_frag_info *wi)
+{
+	xsc_build_rx_skb(cqe, cqe_bcnt, rq, skb, wi);
+}
+
+static inline void xsc_add_skb_frag(struct xsc_rq *rq,
+				    struct sk_buff *skb,
+				    struct xsc_dma_info *di,
+				    u32 frag_offset, u32 len,
+				    unsigned int truesize)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_sync_single_for_cpu(dev, di->addr + frag_offset, len, DMA_FROM_DEVICE);
+	page_ref_inc(di->page);
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			di->page, frag_offset, len, truesize);
+}
+
+static inline void xsc_copy_skb_header(struct device *dev,
+				       struct sk_buff *skb,
+				       struct xsc_dma_info *dma_info,
+				       int offset_from, u32 headlen)
+{
+	void *from = page_address(dma_info->page) + offset_from;
+	/* Aligning len to sizeof(long) optimizes memcpy performance */
+	unsigned int len = ALIGN(headlen, sizeof(long));
+
+	dma_sync_single_for_cpu(dev, dma_info->addr + offset_from, len,
+				DMA_FROM_DEVICE);
+	skb_copy_to_linear_data(skb, from, len);
+}
+
+static inline struct sk_buff *xsc_build_linear_skb(struct xsc_rq *rq, void *va,
+						   u32 frag_size, u16 headroom,
+						   u32 cqe_bcnt)
+{
+	struct sk_buff *skb = build_skb(va, frag_size);
+
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, cqe_bcnt);
+
+	return skb;
+}
+
+struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
+					struct xsc_wqe_frag_info *wi,
+					u32 cqe_bcnt, u8 has_pph)
+{
+	struct xsc_dma_info *di = wi->di;
+	u16 rx_headroom = rq->buff.headroom;
+	int pph_len = has_pph ? XSC_PPH_HEAD_LEN : 0;
+	struct sk_buff *skb;
+	void *va, *data;
+	u32 frag_size;
+
+	va = page_address(di->page) + wi->offset;
+	data = va + rx_headroom + pph_len;
+	frag_size = XSC_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
+
+	dma_sync_single_range_for_cpu(rq->cq.xdev->device, di->addr, wi->offset,
+				      frag_size, DMA_FROM_DEVICE);
+	prefetchw(va); /* xdp_frame data area */
+	prefetch(data);
+
+	skb = xsc_build_linear_skb(rq, va, frag_size, (rx_headroom + pph_len),
+				   (cqe_bcnt - pph_len));
+	if (unlikely(!skb))
+		return NULL;
+
+	/* queue up for recycling/reuse */
+	page_ref_inc(di->page);
+
+	return skb;
+}
+
+struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
+					   struct xsc_wqe_frag_info *wi,
+					   u32 cqe_bcnt, u8 has_pph)
+{
+	struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	struct xsc_wqe_frag_info *head_wi = wi;
+	struct xsc_wqe_frag_info *rx_wi = wi;
+	u16 headlen  = min_t(u32, XSC_RX_MAX_HEAD, cqe_bcnt);
+	u16 frag_headlen = headlen;
+	u16 byte_cnt = cqe_bcnt - headlen;
+	struct sk_buff *skb;
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+	struct net_device *netdev  = c->adapter->netdev;
+	u8 fragcnt = 0;
+	u16 head_offset = head_wi->offset;
+	u16 frag_consumed_bytes = 0;
+	int i = 0;
+
+#ifndef NEED_CREATE_RX_THREAD
+	skb = napi_alloc_skb(rq->cq.napi, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
+#else
+	skb = netdev_alloc_skb(netdev, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
+#endif
+	if (unlikely(!skb))
+		return NULL;
+
+	prefetchw(skb->data);
+
+	if (likely(has_pph)) {
+		headlen = min_t(u32, XSC_RX_MAX_HEAD, (cqe_bcnt - XSC_PPH_HEAD_LEN));
+		frag_headlen = headlen + XSC_PPH_HEAD_LEN;
+		byte_cnt = cqe_bcnt - headlen - XSC_PPH_HEAD_LEN;
+		head_offset += XSC_PPH_HEAD_LEN;
+	}
+
+	if (byte_cnt == 0 && (XSC_GET_PFLAG(&c->adapter->nic_param, XSC_PFLAG_RX_COPY_BREAK))) {
+		for (i = 0; i < rq->wqe.info.num_frags; i++, wi++)
+			wi->is_available = 1;
+		goto ret;
+	}
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, rx_wi++)
+		rx_wi->is_available = 0;
+
+	while (byte_cnt) {
+		/*figure out whether the first fragment can be a page ?*/
+		frag_consumed_bytes =
+			min_t(u16, frag_info->frag_size - frag_headlen, byte_cnt);
+
+		xsc_add_skb_frag(rq, skb, wi->di, wi->offset + frag_headlen,
+				 frag_consumed_bytes, frag_info->frag_stride);
+		byte_cnt -= frag_consumed_bytes;
+
+		/*to protect extend wqe read, drop exceed bytes*/
+		frag_headlen = 0;
+		fragcnt++;
+		if (fragcnt == rq->wqe.info.num_frags) {
+			if (byte_cnt) {
+				netdev_warn(netdev,
+					    "large packet reach the maximum rev-wqe num.\n");
+				netdev_warn(netdev,
+					    "%u bytes dropped: frag_num=%d, headlen=%d, cqe_cnt=%d, frag0_bytes=%d, frag_size=%d\n",
+					    byte_cnt, fragcnt, headlen, cqe_bcnt,
+					    frag_consumed_bytes, frag_info->frag_size);
+			}
+			break;
+		}
+
+		frag_info++;
+		wi++;
+	}
+
+ret:
+	/* copy header */
+	xsc_copy_skb_header(dev, skb, head_wi->di, head_offset, headlen);
+
+	/* skb linear part was allocated with headlen and aligned to long */
+	skb->tail += headlen;
+	skb->len += headlen;
+
+	return skb;
+}
+
+static inline bool xsc_rx_cache_is_empty(struct xsc_page_cache *cache)
+{
+	return cache->head == cache->tail;
+}
+
+static inline bool xsc_page_is_reserved(struct page *page)
+{
+	return page_is_pfmemalloc(page) || page_to_nid(page) != numa_mem_id();
+}
+
+static inline bool xsc_rx_cache_get(struct xsc_rq *rq,
+				    struct xsc_dma_info *dma_info)
+{
+	struct xsc_page_cache *cache = &rq->page_cache;
+	struct xsc_core_device *xdev = rq->cq.xdev;
+
+	if (unlikely(xsc_rx_cache_is_empty(cache)))
+		return false;
+
+	if (page_ref_count(cache->page_cache[cache->head].page) != 1)
+		return false;
+
+	*dma_info = cache->page_cache[cache->head];
+	cache->head = (cache->head + 1) & (cache->sz - 1);
+
+	dma_sync_single_for_device(&xdev->pdev->dev, dma_info->addr,
+				   PAGE_SIZE, DMA_FROM_DEVICE);
+
+	return true;
+}
+
+static inline bool xsc_rx_cache_put(struct xsc_rq *rq,
+				    struct xsc_dma_info *dma_info)
+{
+	struct xsc_page_cache *cache = &rq->page_cache;
+	u32 tail_next = (cache->tail + 1) & (cache->sz - 1);
+
+	if (tail_next == cache->head)
+		return false;
+
+	if (unlikely(xsc_page_is_reserved(dma_info->page)))
+		return false;
+
+	cache->page_cache[cache->tail] = *dma_info;
+	cache->tail = tail_next;
+	return true;
+}
+
+static void xsc_page_dma_unmap(struct xsc_rq *rq, struct xsc_dma_info *dma_info)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_unmap_page(dev, dma_info->addr, XSC_RX_FRAG_SZ, rq->buff.map_dir);
+}
+
+static inline void xsc_put_page(struct xsc_dma_info *dma_info)
+{
+	put_page(dma_info->page);
+}
+
+static void xsc_page_release_dynamic(struct xsc_rq *rq,
+				     struct xsc_dma_info *dma_info, bool recycle)
+{
+	xsc_page_dma_unmap(rq, dma_info);
+	page_pool_recycle_direct(rq->page_pool, dma_info->page);
+}
+
+static inline void xsc_put_rx_frag(struct xsc_rq *rq,
+				   struct xsc_wqe_frag_info *frag, bool recycle)
+{
+	if (frag->last_in_page)
+		xsc_page_release_dynamic(rq, frag->di, recycle);
+}
+
+static inline struct xsc_wqe_frag_info *get_frag(struct xsc_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
+static inline void xsc_free_rx_wqe(struct xsc_rq *rq,
+				   struct xsc_wqe_frag_info *wi, bool recycle)
+{
+	int i;
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, wi++) {
+		if (wi->is_available && recycle)
+			continue;
+		xsc_put_rx_frag(rq, wi, recycle);
+	}
+}
+
+static void xsc_dump_error_rqcqe(struct xsc_rq *rq,
+				 struct xsc_cqe *cqe)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct net_device *netdev  = c->adapter->netdev;
+	u32 ci = xsc_cqwq_get_ci(&rq->cq.wq);
+
+	net_err_ratelimited("Error cqe on dev=%s, cqn=%d, ci=%d, rqn=%d, qpn=%d, error_code=0x%x\n",
+			    netdev->name, rq->cq.xcq.cqn, ci,
+			    rq->rqn, cqe->qp_id, get_cqe_opcode(cqe));
+}
+
+void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
+			   struct xsc_rq *rq, struct xsc_cqe *cqe)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	struct xsc_channel *c = rq->cq.channel;
+	u8 cqe_opcode = get_cqe_opcode(cqe);
+	struct xsc_wqe_frag_info *wi;
+	struct sk_buff *skb;
+	u32 cqe_bcnt;
+	u16 ci;
+
+	ci = xsc_wq_cyc_ctr2ix(wq, cqwq->cc);
+	wi = get_frag(rq, ci);
+	if (unlikely(cqe_opcode & BIT(7))) {
+		xsc_dump_error_rqcqe(rq, cqe);
+		goto free_wqe;
+	}
+
+	cqe_bcnt = le32_to_cpu(cqe->msg_len);
+	if (cqe->has_pph && cqe_bcnt <= XSC_PPH_HEAD_LEN)
+		goto free_wqe;
+
+	if (unlikely(cqe_bcnt > rq->frags_sz)) {
+		if (!XSC_GET_PFLAG(&c->adapter->nic_param, XSC_PFLAG_DROPLESS_RQ))
+			goto free_wqe;
+	}
+
+	cqe_bcnt = min_t(u32, cqe_bcnt, rq->frags_sz);
+	skb = rq->wqe.skb_from_cqe(rq, wi, cqe_bcnt, cqe->has_pph);
+	if (!skb)
+		goto free_wqe;
+
+	xsc_complete_rx_cqe(rq, cqe,
+			    cqe->has_pph == 1 ? cqe_bcnt - XSC_PPH_HEAD_LEN : cqe_bcnt,
+			    skb, wi);
+
+	napi_gro_receive(rq->cq.napi, skb);
+
+free_wqe:
+	xsc_free_rx_wqe(rq, wi, true);
+	xsc_wq_cyc_pop(wq);
+}
+
+int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
+{
+	struct xsc_rq *rq = container_of(cq, struct xsc_rq, cq);
+	struct xsc_cqwq *cqwq = &cq->wq;
+	struct xsc_cqe *cqe;
+	int work_done = 0;
+
+	if (!test_bit(XSC_ETH_RQ_STATE_ENABLED, &rq->state))
+		return 0;
+
+	while ((work_done < budget) && (cqe = xsc_cqwq_get_cqe(cqwq))) {
+		rq->handle_rx_cqe(cqwq, rq, cqe);
+		++work_done;
+
+		xsc_cqwq_pop(cqwq);
+	}
+
+	if (!work_done)
+		goto out;
+
+	xsc_cq_notify_hw(cq);
+	/* ensure cq space is freed before enabling more cqes */
+	wmb();
+
+out:
+
+	return work_done;
+}
+
+static inline int xsc_page_alloc_mapped(struct xsc_rq *rq,
+					struct xsc_dma_info *dma_info)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_info->page = page_pool_dev_alloc_pages(rq->page_pool);
+	if (unlikely(!dma_info->page))
+		return -ENOMEM;
+
+	dma_info->addr = dma_map_page(dev, dma_info->page, 0,
+				      XSC_RX_FRAG_SZ, rq->buff.map_dir);
+	if (unlikely(dma_mapping_error(dev, dma_info->addr))) {
+		page_pool_recycle_direct(rq->page_pool, dma_info->page);
+		dma_info->page = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline int xsc_get_rx_frag(struct xsc_rq *rq,
+				  struct xsc_wqe_frag_info *frag)
+{
+	int err = 0;
+
+	if (!frag->offset && !frag->is_available)
+		/* On first frag (offset == 0), replenish page (dma_info actually).
+		 * Other frags that point to the same dma_info (with a different
+		 * offset) should just use the new one without replenishing again
+		 * by themselves.
+		 */
+		err = xsc_page_alloc_mapped(rq, frag->di);
+
+	return err;
+}
+
+static int xsc_alloc_rx_wqe(struct xsc_rq *rq, struct xsc_eth_rx_wqe_cyc *wqe, u16 ix)
+{
+	struct xsc_wqe_frag_info *frag = get_frag(rq, ix);
+	u64 addr;
+	int i;
+	int err;
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, frag++) {
+		err = xsc_get_rx_frag(rq, frag);
+		if (unlikely(err))
+			goto free_frags;
+
+		addr = cpu_to_le64(frag->di->addr + frag->offset + rq->buff.headroom);
+		wqe->data[i].va = addr;
+	}
+
+	return 0;
+
+free_frags:
+	while (--i >= 0)
+		xsc_put_rx_frag(rq, --frag, true);
+
+	return err;
+}
+
+void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
+{
+	struct xsc_wqe_frag_info *wi = get_frag(rq, ix);
+
+	xsc_free_rx_wqe(rq, wi, false);
+}
+
+static int xsc_alloc_rx_wqes(struct xsc_rq *rq, u16 ix, u8 wqe_bulk)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	struct xsc_eth_rx_wqe_cyc *wqe;
+	int err;
+	int i;
+	int idx;
+
+	for (i = 0; i < wqe_bulk; i++) {
+		idx = xsc_wq_cyc_ctr2ix(wq, (ix + i));
+		wqe = xsc_wq_cyc_get_wqe(wq, idx);
+
+		err = xsc_alloc_rx_wqe(rq, wqe, idx);
+		if (unlikely(err))
+			goto free_wqes;
+	}
+
+	return 0;
+
+free_wqes:
+	while (--i >= 0)
+		xsc_eth_dealloc_rx_wqe(rq, ix + i);
+
+	return err;
+}
+
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u8 wqe_bulk, wqe_bulk_min;
+	int alloc;
+	u16 head;
+	int err;
+
+	wqe_bulk = rq->wqe.info.wqe_bulk;
+	wqe_bulk_min = rq->wqe.info.wqe_bulk_min;
+	if (xsc_wq_cyc_missing(wq) < wqe_bulk)
+		return false;
+
+	do {
+		head = xsc_wq_cyc_get_head(wq);
+
+		alloc = min_t(int, wqe_bulk, xsc_wq_cyc_missing(wq));
+		if (alloc < wqe_bulk && alloc >= wqe_bulk_min)
+			alloc = alloc & 0xfffffffe;
+
+		if (alloc > 0) {
+			err = xsc_alloc_rx_wqes(rq, head, alloc);
+			if (unlikely(err))
+				break;
+
+			xsc_wq_cyc_push_n(wq, alloc);
+		}
+	} while (xsc_wq_cyc_missing(wq) >= wqe_bulk_min);
+
+	dma_wmb();
+
+	/* ensure wqes are visible to device before updating doorbell record */
+	xsc_rq_notify_hw(rq);
+
+	return !!err;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
index 54299ba12..3b8de94b5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
@@ -9,11 +9,6 @@
 
 #define XSC_OPCODE_RAW 7
 
-static inline struct xsc_sq_dma *xsc_dma_get(struct xsc_sq *sq, u32 i)
-{
-	return &sq->db.dma_fifo[i & sq->dma_fifo_mask];
-}
-
 static inline void xsc_dma_push(struct xsc_sq *sq, dma_addr_t addr, u32 size,
 				enum xsc_dma_map_type map_type)
 {
@@ -24,20 +19,6 @@ static inline void xsc_dma_push(struct xsc_sq *sq, dma_addr_t addr, u32 size,
 	dma->type = map_type;
 }
 
-static inline void xsc_tx_dma_unmap(struct device *dev, struct xsc_sq_dma *dma)
-{
-	switch (dma->type) {
-	case XSC_DMA_MAP_SINGLE:
-		dma_unmap_single(dev, dma->addr, dma->size, DMA_TO_DEVICE);
-		break;
-	case XSC_DMA_MAP_PAGE:
-		dma_unmap_page(dev, dma->addr, dma->size, DMA_TO_DEVICE);
-		break;
-	default:
-		break;
-	}
-}
-
 static void xsc_dma_unmap_wqe_err(struct xsc_sq *sq, u8 num_dma)
 {
 	struct xsc_adapter *adapter = sq->channel->adapter;
@@ -168,12 +149,6 @@ static int xsc_txwqe_build_dsegs(struct xsc_sq *sq, struct sk_buff *skb,
 	return -ENOMEM;
 }
 
-static inline bool xsc_wqc_has_room_for(struct xsc_wq_cyc *wq,
-					u16 cc, u16 pc, u16 n)
-{
-	return (xsc_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
-}
-
 static inline void xsc_sq_notify_hw(struct xsc_wq_cyc *wq, u16 pc,
 				    struct xsc_sq *sq)
 {
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
index 55aed6e5e..83e4f04c5 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -41,16 +41,96 @@ static inline bool xsc_channel_no_affinity_change(struct xsc_channel *c)
 	return cpumask_test_cpu(current_cpu, c->aff_mask);
 }
 
-static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
+static void xsc_dump_error_sqcqe(struct xsc_sq *sq,
+				 struct xsc_cqe *cqe)
 {
-	// TBD
-	return true;
+	u32 ci = xsc_cqwq_get_ci(&sq->cq.wq);
+	struct net_device *netdev  = sq->channel->netdev;
+
+	net_err_ratelimited("Err cqe on dev %s cqn=0x%x ci=0x%x sqn=0x%x err_code=0x%x qpid=0x%x\n",
+			    netdev->name, sq->cq.xcq.cqn, ci,
+			    sq->sqn, get_cqe_opcode(cqe), cqe->qp_id);
 }
 
-static int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
+bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
 {
-	// TBD
-	return 0;
+	struct xsc_adapter *adapter;
+	struct device *dev;
+	struct xsc_sq *sq;
+	struct xsc_cqe *cqe;
+	u32 dma_fifo_cc;
+	u32 nbytes = 0;
+	u16 npkts = 0;
+	u16 sqcc;
+	int i = 0;
+
+	sq = container_of(cq, struct xsc_sq, cq);
+	if (!test_bit(XSC_ETH_SQ_STATE_ENABLED, &sq->state))
+		return false;
+
+	adapter = sq->channel->adapter;
+	dev = adapter->dev;
+
+	cqe = xsc_cqwq_get_cqe(&cq->wq);
+	if (!cqe)
+		goto out;
+
+	if (unlikely(get_cqe_opcode(cqe) & BIT(7))) {
+		xsc_dump_error_sqcqe(sq, cqe);
+		return false;
+	}
+
+	sqcc = sq->cc;
+
+	/* avoid dirtying sq cache line every cqe */
+	dma_fifo_cc = sq->dma_fifo_cc;
+	i = 0;
+	do {
+		struct xsc_tx_wqe_info *wi;
+		struct sk_buff *skb;
+		int j;
+		u16 ci;
+
+		xsc_cqwq_pop(&cq->wq);
+
+		ci = xsc_wq_cyc_ctr2ix(&sq->wq, sqcc);
+		wi = &sq->db.wqe_info[ci];
+		skb = wi->skb;
+
+		/*cqe may be overstanding in real test, not by nop in other*/
+		if (unlikely(!skb))
+			continue;
+
+		for (j = 0; j < wi->num_dma; j++) {
+			struct xsc_sq_dma *dma = xsc_dma_get(sq, dma_fifo_cc++);
+
+			xsc_tx_dma_unmap(dev, dma);
+		}
+
+		npkts++;
+		nbytes += wi->num_bytes;
+		sqcc += wi->num_wqebbs;
+		napi_consume_skb(skb, 0);
+
+	} while ((++i <= napi_budget) && (cqe = xsc_cqwq_get_cqe(&cq->wq)));
+
+	xsc_cq_notify_hw(cq);
+
+	/* ensure cq space is freed before enabling more cqes */
+	wmb();
+
+	sq->dma_fifo_cc = dma_fifo_cc;
+	sq->cc = sqcc;
+
+	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
+
+	if (netif_tx_queue_stopped(sq->txq) &&
+	    xsc_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room)) {
+		netif_tx_wake_queue(sq->txq);
+	}
+
+out:
+	return (i == napi_budget);
 }
 
 int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
index 8d98d5645..cfdc25f97 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -20,6 +20,70 @@ enum {
 void xsc_cq_notify_hw_rearm(struct xsc_cq *cq);
 void xsc_cq_notify_hw(struct xsc_cq *cq);
 int xsc_eth_napi_poll(struct napi_struct *napi, int budget);
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq);
+void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
+			   struct xsc_rq *rq, struct xsc_cqe *cqe);
+void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix);
+struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
+					struct xsc_wqe_frag_info *wi, u32 cqe_bcnt, u8 has_pph);
+struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
+					   struct xsc_wqe_frag_info *wi,
+					   u32 cqe_bcnt, u8 has_pph);
+bool xsc_poll_tx_cq(struct xsc_cq *cq, int budget);
+int xsc_poll_rx_cq(struct xsc_cq *cq, int budget);
+
+static inline void xsc_tx_dma_unmap(struct device *dev, struct xsc_sq_dma *dma)
+{
+	switch (dma->type) {
+	case XSC_DMA_MAP_SINGLE:
+		dma_unmap_single(dev, dma->addr, dma->size, DMA_TO_DEVICE);
+		break;
+	case XSC_DMA_MAP_PAGE:
+		dma_unmap_page(dev, dma->addr, dma->size, DMA_TO_DEVICE);
+		break;
+	default:
+		break;
+	}
+}
+
+static inline struct xsc_sq_dma *xsc_dma_get(struct xsc_sq *sq, u32 i)
+{
+	return &sq->db.dma_fifo[i & sq->dma_fifo_mask];
+}
+
+static inline bool xsc_wqc_has_room_for(struct xsc_wq_cyc *wq,
+					u16 cc, u16 pc, u16 n)
+{
+	return (xsc_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
+}
+
+static inline struct xsc_cqe *xsc_cqwq_get_cqe_buff(struct xsc_cqwq *wq, u32 ix)
+{
+	struct xsc_cqe *cqe = xsc_frag_buf_get_wqe(&wq->fbc, ix);
+
+	return cqe;
+}
+
+static inline struct xsc_cqe *xsc_cqwq_get_cqe(struct xsc_cqwq *wq)
+{
+	struct xsc_cqe *cqe;
+	u8 cqe_ownership_bit;
+	u8 sw_ownership_val;
+	u32 ci = xsc_cqwq_get_ci(wq);
+
+	cqe = xsc_cqwq_get_cqe_buff(wq, ci);
+
+	cqe_ownership_bit = cqe->owner & XSC_CQE_OWNER_MASK;
+	sw_ownership_val = xsc_cqwq_get_wrap_cnt(wq) & 1;
+
+	if (cqe_ownership_bit != sw_ownership_val)
+		return NULL;
+
+	/* ensure cqe content is read after cqe ownership bit */
+	dma_rmb();
+
+	return cqe;
+}
 
 netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev);
 
-- 
2.43.0


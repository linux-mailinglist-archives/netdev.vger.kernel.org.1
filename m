Return-Path: <netdev+bounces-165910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48660A33B02
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B24516A73D
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF8E20D4F0;
	Thu, 13 Feb 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="QWmkze8t"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6124206F15
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438222; cv=none; b=dzXOh8bcuJYz3OmxfKSP9UO1d7yfWsAy+4VvzaEQpqma1Jf2O9BxN8JickfMGAOiuy6Wgsd5CJSWItb18WZRyOhEiw8P+LRoaBodDkphUDZ2Y/Lzvj1YnDkZILmuhWm91z5ks55HsOZUxu0AfqMkUQSvxojTCaxx6mHJYGFmKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438222; c=relaxed/simple;
	bh=kh65vV/A+XCCnKSjAIySQl1k/IS1LKCU3ZUSfHCLn9Q=;
	h=Cc:From:Date:Content-Type:Subject:Mime-Version:To:Message-Id:
	 In-Reply-To:References; b=cVOwIHgSP0d7Zu4QjJ3FvQlR7o1DxcnLvBvCk/SVck72g202EzWJIADK3lKWXcbVRhrsscGVtt0K1wcCNUGU0BMSNR1nX7ldLCQZq5bpzvTte2ho8qJsrkYnyu/zB2klR/Y/N1G+Fkr+/UUViRJPFd6Denkc9JDzg5IYKJPtz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=QWmkze8t; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1739438077; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9wUY1QhM/4KfxVgWKJd8L5A/Qkjx1WYtOUwwixvjan8=;
 b=QWmkze8tWpMOU2ulp/MtJEOtL6okzAxG4kfDN8UtSlLnl7RE6k5CGlBdkiIXnZkfDDTeDi
 VUncB9TIqqLUFVaUqv3c1cW4q5T6GGHiDLZChIdqPHkquT/g4t31cMR9i+mRs53exNB+5Y
 CVeanpfrg/ymEabMqHeysD4pzLHSgndvcM1zLPeSFs2Kx4XRZPlOYoPnUiS7qCxrz8El5Q
 6+io52i2aL3idXg2xwCGeJgJLsWty+PMa0GthSux6CF9R5aTmHArM2f9g8EkBPXvhXTfPj
 YEKRqPgvUH4tq1QMSj/yEjuvd9fKE/gfJfIuXfxaEk1OsYWvdAJoeKjgANKMaw==
X-Lms-Return-Path: <lba+267adb7fb+9caaa5+vger.kernel.org+tianx@yunsilicon.com>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Thu, 13 Feb 2025 17:14:35 +0800
Content-Type: text/plain; charset=UTF-8
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Thu, 13 Feb 2025 17:14:34 +0800
X-Mailer: git-send-email 2.25.1
Subject: [PATCH v4 13/14] net-next/yunsilicon: Add eth rx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Message-Id: <20250213091433.2067626-14-tianx@yunsilicon.com>
In-Reply-To: <20250213091402.2067626-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>

Add eth rx

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   5 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  28 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  | 565 +++++++++++++++++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  92 ++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |  28 +
 stBHQOue                                      |   0
 6 files changed, 706 insertions(+), 12 deletions(-)
 create mode 100644 stBHQOue

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 933acb7a1..baba87728 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -519,4 +519,9 @@ static inline u8 xsc_get_user_mode(struct xsc_core_device *xdev)
 	return xdev->user_mode;
 }
 
+static inline u8 get_cqe_opcode(struct xsc_cqe *cqe)
+{
+	return XSC_GET_FIELD(cqe->data0, XSC_CQE_MSG_OPCD);
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index 04f9630a0..7d3d751ff 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -22,6 +22,8 @@
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	\
 	((mtu) + ETH_HLEN + XSC_ETH_RX_MAX_HEAD_ROOM)
 
+#define XSC_RX_MAX_HEAD			(256)
+
 #define XSC_QPN_SQN_STUB		1025
 #define XSC_QPN_RQN_STUB		1024
 
@@ -147,6 +149,24 @@ enum channel_flags {
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
@@ -210,4 +230,12 @@ union xsc_send_doorbell {
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
index 72f33bb53..6d97eb27c 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -5,44 +5,589 @@
  * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
  */
 
+#include <linux/net_tstamp.h>
+#include <linux/device.h>
+
+#include "common/xsc_pp.h"
+#include "xsc_eth.h"
 #include "xsc_eth_txrx.h"
+#include "xsc_eth_common.h"
+#include "xsc_pph.h"
+
+#define PAGE_REF_ELEV  (U16_MAX)
+/* Upper bound on number of packets that share a single page */
+#define PAGE_REF_THRSD (PAGE_SIZE / 64)
+
+static void xsc_rq_notify_hw(struct xsc_rq *rq)
+{
+	struct xsc_core_device *xdev = rq->cq.xdev;
+	union xsc_recv_doorbell doorbell_value;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u64 rqwqe_id;
+
+	rqwqe_id = wq->wqe_ctr << (ilog2(xdev->caps.recv_ds_num));
+	/*reverse wqe index to ds index*/
+	doorbell_value.next_pid = rqwqe_id;
+	doorbell_value.qp_num = rq->rqn;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+	writel(doorbell_value.recv_data, XSC_REG_ADDR(xdev, xdev->regs.rx_db));
+}
+
+static void xsc_skb_set_hash(struct xsc_adapter *adapter,
+			     struct xsc_cqe *cqe,
+			     struct sk_buff *skb)
+{
+	struct xsc_rss_params *rss = &adapter->rss_param;
+	bool l3_hash = false;
+	bool l4_hash = false;
+	u32 hash_field;
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
+static void xsc_handle_csum(struct xsc_cqe *cqe, struct xsc_rq *rq,
+			    struct sk_buff *skb, struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_dma_info *dma_info;
+	struct net_device *netdev;
+	struct epp_pph *hw_pph;
+	struct xsc_channel *c;
+	int offset_from;
+
+	c = rq->cq.channel;
+	netdev = c->adapter->netdev;
+	dma_info = wi->di;
+	offset_from = wi->offset;
+	hw_pph = page_address(dma_info->page) + offset_from;
+
+	if (unlikely((netdev->features & NETIF_F_RXCSUM) == 0))
+		goto csum_none;
+
+	if (unlikely(XSC_GET_EPP2SOC_PPH_ERROR_BITMAP(hw_pph) & PACKET_UNKNOWN))
+		goto csum_none;
+
+	if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+	    (!(XSC_GET_FIELD(cqe->data0, XSC_CQE_CSUM_ERR) &
+	       OUTER_AND_INNER))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 1;
+		skb->encapsulation = 1;
+	} else if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(XSC_GET_FIELD(cqe->data0, XSC_CQE_CSUM_ERR) &
+		      OUTER_BIT) &&
+		    (XSC_GET_FIELD(cqe->data0, XSC_CQE_CSUM_ERR) &
+		     INNER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 0;
+		skb->encapsulation = 1;
+	} else if (!XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(XSC_GET_FIELD(cqe->data0, XSC_CQE_CSUM_ERR) &
+		      OUTER_BIT))) {
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
+static void xsc_build_rx_skb(struct xsc_cqe *cqe,
+			     u32 cqe_bcnt,
+			     struct xsc_rq *rq,
+			     struct sk_buff *skb,
+			     struct xsc_wqe_frag_info *wi)
+{
+	struct xsc_adapter *adapter;
+	struct net_device *netdev;
+	struct xsc_channel *c;
+
+	c = rq->cq.channel;
+	adapter = c->adapter;
+	netdev = c->netdev;
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
+static void xsc_complete_rx_cqe(struct xsc_rq *rq,
+				struct xsc_cqe *cqe,
+				u32 cqe_bcnt,
+				struct sk_buff *skb,
+				struct xsc_wqe_frag_info *wi)
+{
+	xsc_build_rx_skb(cqe, cqe_bcnt, rq, skb, wi);
+}
+
+static void xsc_add_skb_frag(struct xsc_rq *rq,
+			     struct sk_buff *skb,
+			     struct xsc_dma_info *di,
+			     u32 frag_offset, u32 len,
+			     unsigned int truesize)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_sync_single_for_cpu(dev, di->addr + frag_offset,
+				len, DMA_FROM_DEVICE);
+	page_ref_inc(di->page);
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+			di->page, frag_offset, len, truesize);
+}
+
+static void xsc_copy_skb_header(struct device *dev,
+				struct sk_buff *skb,
+				struct xsc_dma_info *dma_info,
+				int offset_from, u32 headlen)
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
+static struct sk_buff *xsc_build_linear_skb(struct xsc_rq *rq, void *va,
+					    u32 frag_size, u16 headroom,
+					    u32 cqe_bcnt)
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
 
 struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
 					struct xsc_wqe_frag_info *wi,
 					u32 cqe_bcnt, u8 has_pph)
 {
-	// TBD
-	return NULL;
+	int pph_len = has_pph ? XSC_PPH_HEAD_LEN : 0;
+	u16 rx_headroom = rq->buff.headroom;
+	struct xsc_dma_info *di = wi->di;
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
 }
 
 struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   struct xsc_wqe_frag_info *wi,
 					   u32 cqe_bcnt, u8 has_pph)
 {
-	// TBD
-	return NULL;
+	struct xsc_rq_frag_info *frag_info = &rq->wqe.info.arr[0];
+	u16 headlen  = min_t(u32, XSC_RX_MAX_HEAD, cqe_bcnt);
+	struct xsc_wqe_frag_info *head_wi = wi;
+	struct xsc_wqe_frag_info *rx_wi = wi;
+	u16 head_offset = head_wi->offset;
+	u16 byte_cnt = cqe_bcnt - headlen;
+	u16 frag_consumed_bytes = 0;
+	u16 frag_headlen = headlen;
+	struct net_device *netdev;
+	struct xsc_channel *c;
+	struct sk_buff *skb;
+	struct device *dev;
+	u8 fragcnt = 0;
+	int i = 0;
+
+	c = rq->cq.channel;
+	dev = c->adapter->dev;
+	netdev = c->adapter->netdev;
+
+	skb = napi_alloc_skb(rq->cq.napi, ALIGN(XSC_RX_MAX_HEAD, sizeof(long)));
+	if (unlikely(!skb))
+		return NULL;
+
+	prefetchw(skb->data);
+
+	if (likely(has_pph)) {
+		headlen = min_t(u32, XSC_RX_MAX_HEAD,
+				(cqe_bcnt - XSC_PPH_HEAD_LEN));
+		frag_headlen = headlen + XSC_PPH_HEAD_LEN;
+		byte_cnt = cqe_bcnt - headlen - XSC_PPH_HEAD_LEN;
+		head_offset += XSC_PPH_HEAD_LEN;
+	}
+
+	if (byte_cnt == 0 &&
+	    (XSC_GET_PFLAG(&c->adapter->nic_param, XSC_PFLAG_RX_COPY_BREAK))) {
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
+			min_t(u16, frag_info->frag_size - frag_headlen,
+			      byte_cnt);
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
+					    byte_cnt, fragcnt,
+					    headlen, cqe_bcnt,
+					    frag_consumed_bytes,
+					    frag_info->frag_size);
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
+static void xsc_page_dma_unmap(struct xsc_rq *rq, struct xsc_dma_info *dma_info)
+{
+	struct xsc_channel *c = rq->cq.channel;
+	struct device *dev = c->adapter->dev;
+
+	dma_unmap_page(dev, dma_info->addr, XSC_RX_FRAG_SZ, rq->buff.map_dir);
+}
+
+static void xsc_page_release_dynamic(struct xsc_rq *rq,
+				     struct xsc_dma_info *dma_info,
+				     bool recycle)
+{
+	xsc_page_dma_unmap(rq, dma_info);
+	page_pool_recycle_direct(rq->page_pool, dma_info->page);
+}
+
+static void xsc_put_rx_frag(struct xsc_rq *rq,
+			    struct xsc_wqe_frag_info *frag, bool recycle)
+{
+	if (frag->last_in_page)
+		xsc_page_release_dynamic(rq, frag->di, recycle);
+}
+
+static struct xsc_wqe_frag_info *get_frag(struct xsc_rq *rq, u16 ix)
+{
+	return &rq->wqe.frags[ix << rq->wqe.info.log_num_frags];
+}
+
+static void xsc_free_rx_wqe(struct xsc_rq *rq,
+			    struct xsc_wqe_frag_info *wi, bool recycle)
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
+	struct net_device *netdev;
+	struct xsc_channel *c;
+	u32 ci;
+
+	c = rq->cq.channel;
+	netdev  = c->adapter->netdev;
+	ci = xsc_cqwq_get_ci(&rq->cq.wq);
+
+	net_err_ratelimited("Error cqe on dev=%s, cqn=%d, ci=%d, rqn=%d, qpn=%d, error_code=0x%x\n",
+			    netdev->name, rq->cq.xcq.cqn, ci,
+			    rq->rqn,
+			    le32_to_cpu(XSC_GET_FIELD(cqe->data0,
+						      XSC_CQE_QP_ID)),
+			    get_cqe_opcode(cqe));
 }
 
 void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
 			   struct xsc_rq *rq, struct xsc_cqe *cqe)
 {
-	// TBD
+	struct xsc_channel *c = rq->cq.channel;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
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
+	if ((cqe->data0 & XSC_CQE_HAS_PPH) && cqe_bcnt <= XSC_PPH_HEAD_LEN)
+		goto free_wqe;
+
+	if (unlikely(cqe_bcnt > rq->frags_sz)) {
+		if (!XSC_GET_PFLAG(&c->adapter->nic_param,
+				   XSC_PFLAG_DROPLESS_RQ))
+			goto free_wqe;
+	}
+
+	cqe_bcnt = min_t(u32, cqe_bcnt, rq->frags_sz);
+	skb = rq->wqe.skb_from_cqe(rq, wi, cqe_bcnt,
+				   !!(cqe->data0 & XSC_CQE_HAS_PPH));
+	if (!skb)
+		goto free_wqe;
+
+	xsc_complete_rx_cqe(rq, cqe,
+			    (cqe->data0 & XSC_CQE_HAS_PPH) ?
+			    cqe_bcnt - XSC_PPH_HEAD_LEN : cqe_bcnt,
+			    skb, wi);
+
+	napi_gro_receive(rq->cq.napi, skb);
+
+free_wqe:
+	xsc_free_rx_wqe(rq, wi, true);
+	xsc_wq_cyc_pop(wq);
 }
 
 int xsc_poll_rx_cq(struct xsc_cq *cq, int budget)
 {
-	// TBD
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
+static int xsc_page_alloc_mapped(struct xsc_rq *rq,
+				 struct xsc_dma_info *dma_info)
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
+static int xsc_get_rx_frag(struct xsc_rq *rq,
+			   struct xsc_wqe_frag_info *frag)
+{
+	int err = 0;
+
+	if (!frag->offset && !frag->is_available)
+		/* On first frag (offset == 0), replenish page (dma_info
+		 * actually). Other frags that point to the same dma_info
+		 * (with a different offset) should just use the new one
+		 * without replenishing again by themselves.
+		 */
+		err = xsc_page_alloc_mapped(rq, frag->di);
+
+	return err;
+}
+
+static int xsc_alloc_rx_wqe(struct xsc_rq *rq,
+			    struct xsc_eth_rx_wqe_cyc *wqe,
+			    u16 ix)
+{
+	struct xsc_wqe_frag_info *frag = get_frag(rq, ix);
+	u64 addr;
+	int err;
+	int i;
+
+	for (i = 0; i < rq->wqe.info.num_frags; i++, frag++) {
+		err = xsc_get_rx_frag(rq, frag);
+		if (unlikely(err))
+			goto free_frags;
+
+		addr = frag->di->addr + frag->offset + rq->buff.headroom;
+		wqe->data[i].va = cpu_to_le64(addr);
+	}
+
 	return 0;
+
+free_frags:
+	while (--i >= 0)
+		xsc_put_rx_frag(rq, --frag, true);
+
+	return err;
 }
 
 void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
 {
-	// TBD
+	struct xsc_wqe_frag_info *wi = get_frag(rq, ix);
+
+	xsc_free_rx_wqe(rq, wi, false);
 }
 
-bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+static int xsc_alloc_rx_wqes(struct xsc_rq *rq, u16 ix, u8 wqe_bulk)
 {
-	// TBD
-	return true;
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	struct xsc_eth_rx_wqe_cyc *wqe;
+	int err;
+	int idx;
+	int i;
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
 }
 
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
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
index 34e09b2a1..5e6959449 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -40,10 +40,98 @@ static bool xsc_channel_no_affinity_change(struct xsc_channel *c)
 	return cpumask_test_cpu(current_cpu, c->aff_mask);
 }
 
+static void xsc_dump_error_sqcqe(struct xsc_sq *sq,
+				 struct xsc_cqe *cqe)
+{
+	struct net_device *netdev = sq->channel->netdev;
+	u32 ci = xsc_cqwq_get_ci(&sq->cq.wq);
+
+	net_err_ratelimited("Err cqe on dev %s cqn=0x%x ci=0x%x sqn=0x%x err_code=0x%x qpid=0x%x\n",
+			    netdev->name, sq->cq.xcq.cqn, ci,
+			    sq->sqn, get_cqe_opcode(cqe),
+			    le32_to_cpu(XSC_GET_FIELD(cqe->data0,
+						      XSC_CQE_QP_ID)));
+}
+
 static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
 {
-	// TBD
-	return true;
+	struct xsc_adapter *adapter;
+	struct xsc_cqe *cqe;
+	struct device *dev;
+	struct xsc_sq *sq;
+	u32 dma_fifo_cc;
+	u32 nbytes = 0;
+	u16 npkts = 0;
+	int i = 0;
+	u16 sqcc;
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
index 68f3347e4..f7ff32148 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -60,4 +60,32 @@ static inline bool xsc_wqc_has_room_for(struct xsc_wq_cyc *wq,
 	return (xsc_wq_cyc_ctr2ix(wq, cc - pc) >= n) || (cc == pc);
 }
 
+static inline struct xsc_cqe *xsc_cqwq_get_cqe_buff(struct xsc_cqwq *wq, u32 ix)
+{
+	struct xsc_cqe *cqe = xsc_frag_buf_get_wqe(&wq->fbc, ix);
+
+	return cqe;
+}
+
+static inline struct xsc_cqe *xsc_cqwq_get_cqe(struct xsc_cqwq *wq)
+{
+	u32 ci = xsc_cqwq_get_ci(wq);
+	u8 cqe_ownership_bit;
+	struct xsc_cqe *cqe;
+	u8 sw_ownership_val;
+
+	cqe = xsc_cqwq_get_cqe_buff(wq, ci);
+
+	cqe_ownership_bit = !!(cqe->data1 & XSC_CQE_OWNER);
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
+
 #endif /* XSC_RXTX_H */
diff --git a/stBHQOue b/stBHQOue
new file mode 100644
index 000000000..e69de29bb
-- 
2.43.0


Return-Path: <netdev+bounces-195549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3583AD11A2
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 11:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B327A3FB4
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 08:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556AB20AF98;
	Sun,  8 Jun 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="RYgcOw5B"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-12.ptr.blmpb.com (sg-1-12.ptr.blmpb.com [118.26.132.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790320A5F3
	for <netdev@vger.kernel.org>; Sun,  8 Jun 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749373180; cv=none; b=CKrP2UXwARne2L6LEPhAvyvWAyJNkdMbk5RA8hXDsH3vnazWLLYVblVE99aT8YJD4l3zGtnMG1w8BdOrCKSFRn6uPuae5gg/v+mfCNHEjWGPxWdHuqN4eNQHBLUZjqn091FqyhsuOVPNe3WWLHXqvC3LNS8e5qC4tUlIp6OaA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749373180; c=relaxed/simple;
	bh=fS6Zp/w7Jsfw+T4AguSL95o5ADEeqiIJhPdxF95sOqo=;
	h=Mime-Version:In-Reply-To:References:To:Cc:From:Message-Id:
	 Content-Type:Subject:Date; b=uZR9ioN26Wk659BSTENvPS/r1Z3RXCb/W1nPbz1h6ceYaeHNh/6sd1oDUTenP8DA8A3pqB0sTubw0OTSp3hflakv7D2/eP9vubTBFhR/rbSAJM/iJgSISxY82tQl9iP12eiZ35AWYDQZ1jjucxYQ4yAN3/P+0qZ3kqqYERzaYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=RYgcOw5B; arc=none smtp.client-ip=118.26.132.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749373170; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=v6+xyXXwJTxjUjmqz5IL9vge1O7FBDj0sZrruthdlt8=;
 b=RYgcOw5BbpgLhDPrVurtg3AuOzn9FUJIIQHrMFsCIgguVjvysovvgAAx45vVgEIOOZRXOJ
 nwt2H6+jYw/+AaCk9e0htXQrWaeSKLMxgnNPaT380vnUh9Izo2QL3mrg8uB8lZ+gaLEIX6
 vLFm/eSqCAJ9moiFxAaRZRCCI/QVKJnmE1JQF2KVweaivDg/vZ6p3FTNgSXuwt+ltBbAqD
 hV9MrU1n6WnHYDbHR6gbwtla0PYz4XIHlNi45pdfWLuzL7zaWOwfEBMCgOnenWCWsfQTbY
 xm56SPhSoUi0mg0w+K5IQJcgAWKfq6AHfNxgBsmeshoExCeBjcqVSbLLp/oDAg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250608085857.3283672-1-tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit
References: <20250608085857.3283672-1-tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250608085926.3283672-14-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Subject: [PATCH net-next v12 13/14] xsc: Add eth reception data path
Date: Sun, 08 Jun 2025 16:59:27 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Sun, 08 Jun 2025 16:59:27 +0800
X-Lms-Return-Path: <lba+2684550f0+ce8048+vger.kernel.org+tianx@yunsilicon.com>

rx data path:
1. The hardware writes incoming packets into the RQ ring buffer and
generates a event queue entry
2. The event handler function(xsc_eth_completion_event in
xsc_eth_events.c) is triggered, invokes napi_schedule() to schedule
a softirq.
3. The kernel triggers the softirq handler net_rx_action, which calls
the driver's NAPI poll function (xsc_eth_napi_poll in xsc_eth_txrx.c).
The driver retrieves CQEs from the Completion Queue (CQ) via
xsc_poll_rx_cq.
4. xsc_eth_build_rx_skb constructs an sk_buff structure, and submits the
SKB to the kernel network stack via napi_gro_receive
5. The driver recycles the RX buffer and notifies the NIC via
xsc_eth_post_rx_wqes to prepare for new packets.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  10 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  | 527 +++++++++++++++++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  13 +
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   1 +
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  19 +-
 5 files changed, 547 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index 4f47dac5c..41abe3d3c 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -22,6 +22,8 @@
 #define XSC_SW2HW_RX_PKT_LEN(mtu)	\
 	((mtu) + ETH_HLEN + XSC_ETH_RX_MAX_HEAD_ROOM)
 
+#define XSC_RX_MAX_HEAD			(256)
+
 #define XSC_QPN_SQN_STUB		1025
 #define XSC_QPN_RQN_STUB		1024
 
@@ -186,4 +188,12 @@ union xsc_send_doorbell {
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
index 13145345e..212e55d78 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
@@ -5,38 +5,547 @@
  * Copyright (c) 2015-2016, Mellanox Technologies. All rights reserved.
  */
 
+#include <linux/net_tstamp.h>
+#include <linux/device.h>
+
+#include "xsc_pp.h"
+#include "xsc_eth.h"
 #include "xsc_eth_txrx.h"
+#include "xsc_eth_common.h"
+#include "xsc_pph.h"
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
+			skb_set_hash(skb, le32_to_cpu(cqe->vni), ht);
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
+	    (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK, le32_to_cpu(cqe->data0)) &
+	       OUTER_AND_INNER))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 1;
+		skb->encapsulation = 1;
+	} else if (XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+				le32_to_cpu(cqe->data0)) &
+		      OUTER_BIT) &&
+		    (FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+			       le32_to_cpu(cqe->data0)) &
+		     INNER_BIT))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->csum_level = 0;
+		skb->encapsulation = 1;
+	} else if (!XSC_GET_EPP2SOC_PPH_EXT_TUNNEL_TYPE(hw_pph) &&
+		   (!(FIELD_GET(XSC_CQE_CSUM_ERR_MASK,
+				le32_to_cpu(cqe->data0)) &
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
-	/* TBD */
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
+	net_prefetchw(va); /* xdp_frame data area */
+	net_prefetch(data);
+
+	skb = xsc_build_linear_skb(rq, va, frag_size, (rx_headroom + pph_len),
+				   (cqe_bcnt - pph_len));
+	if (unlikely(!skb))
+		return NULL;
+
+	return skb;
 }
 
 struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   struct xsc_wqe_frag_info *wi,
 					   u32 cqe_bcnt, u8 has_pph)
 {
-	/* TBD */
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
+	net_prefetchw(skb->data);
+
+	if (likely(has_pph)) {
+		headlen = min_t(u32, XSC_RX_MAX_HEAD,
+				(cqe_bcnt - XSC_PPH_HEAD_LEN));
+		frag_headlen = headlen + XSC_PPH_HEAD_LEN;
+		byte_cnt = cqe_bcnt - headlen - XSC_PPH_HEAD_LEN;
+		head_offset += XSC_PPH_HEAD_LEN;
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
+static void xsc_put_rx_frag(struct xsc_rq *rq,
+			    struct xsc_wqe_frag_info *frag, bool recycle)
+{
+	if (frag->last_in_page)
+		page_pool_recycle_direct(rq->page_pool, frag->di->page);
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
+	net_err_ratelimited("Error cqe on dev=%s, cqn=%d, ci=%d, rqn=%d, qpn=%ld, error_code=0x%x\n",
+			    netdev->name, rq->cq.xcq.cqn, ci,
+			    rq->rqn,
+			    FIELD_GET(XSC_CQE_QP_ID_MASK,
+				      le32_to_cpu(cqe->data0)),
+			    get_cqe_opcode(cqe));
 }
 
 void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
 			   struct xsc_rq *rq, struct xsc_cqe *cqe)
 {
-	/* TBD */
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
+	if ((le32_to_cpu(cqe->data0) & XSC_CQE_HAS_PPH) &&
+	    cqe_bcnt <= XSC_PPH_HEAD_LEN)
+		goto free_wqe;
+
+	if (unlikely(cqe_bcnt > rq->frags_sz))
+		goto free_wqe;
+
+	cqe_bcnt = min_t(u32, cqe_bcnt, rq->frags_sz);
+	skb = rq->wqe.skb_from_cqe(rq, wi, cqe_bcnt,
+				   !!(le32_to_cpu(cqe->data0) &
+				      XSC_CQE_HAS_PPH));
+	if (!skb)
+		goto free_wqe;
+
+	xsc_complete_rx_cqe(rq, cqe,
+			    (le32_to_cpu(cqe->data0) & XSC_CQE_HAS_PPH) ?
+			    cqe_bcnt - XSC_PPH_HEAD_LEN : cqe_bcnt,
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
+	return work_done;
+}
+
+static int xsc_page_alloc_pool(struct xsc_rq *rq,
+			       struct xsc_dma_info *dma_info)
+{
+	dma_info->page = page_pool_dev_alloc_pages(rq->page_pool);
+	if (unlikely(!dma_info->page))
+		return -ENOMEM;
+	dma_info->addr = page_pool_get_dma_addr(dma_info->page);
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
+		err = xsc_page_alloc_pool(rq, frag->di);
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
+			goto err_free_frags;
+
+		addr = frag->di->addr + frag->offset + rq->buff.headroom;
+		wqe->data[i].va = cpu_to_le64(addr);
+	}
+
+	return 0;
+
+err_free_frags:
+	while (--i >= 0)
+		xsc_put_rx_frag(rq, --frag, true);
+
+	return err;
 }
 
 void xsc_eth_dealloc_rx_wqe(struct xsc_rq *rq, u16 ix)
 {
-	/* TBD */
+	struct xsc_wqe_frag_info *wi = get_frag(rq, ix);
+
+	xsc_free_rx_wqe(rq, wi, false);
 }
 
-bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+static int xsc_alloc_rx_wqes(struct xsc_rq *rq, u16 ix, u8 wqe_bulk)
 {
-	/* TBD */
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
+			goto err_free_wqes;
+	}
+
+	return 0;
+
+err_free_wqes:
+	while (--i >= 0)
+		xsc_eth_dealloc_rx_wqe(rq, ix + i);
+
+	return err;
 }
 
+bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
+{
+	struct xsc_wq_cyc *wq = &rq->wqe.wq;
+	u8 wqe_bulk, wqe_bulk_min;
+	int err = 0;
+	int alloc;
+	u16 head;
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
index 9784816c3..3a843b152 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -140,6 +140,7 @@ int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct xsc_channel *c = container_of(napi, struct xsc_channel, napi);
 	struct xsc_eth_params *params = &c->adapter->nic_param;
+	struct xsc_rq *rq = &c->qp.rq[0];
 	struct xsc_sq *sq = NULL;
 	bool busy = false;
 	int work_done = 0;
@@ -152,11 +153,21 @@ int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
 	for (i = 0; i < c->num_tc; i++)
 		busy |= xsc_poll_tx_cq(&c->qp.sq[i].cq, tx_budget);
 
+	/* budget=0 means: don't poll rx rings */
+	if (likely(budget)) {
+		work_done = xsc_poll_rx_cq(&rq->cq, budget);
+		busy |= work_done == budget;
+	}
+
+	busy |= rq->post_wqes(rq);
+
 	if (busy) {
 		if (likely(xsc_channel_no_affinity_change(c))) {
 			rcu_read_unlock();
 			return budget;
 		}
+		if (budget && work_done == budget)
+			work_done--;
 	}
 
 	if (unlikely(!napi_complete_done(napi, work_done)))
@@ -166,6 +177,8 @@ int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
 		sq = &c->qp.sq[i];
 		xsc_cq_notify_hw_rearm(&sq->cq);
 	}
+
+	xsc_cq_notify_hw_rearm(&rq->cq);
 err_out:
 	rcu_read_unlock();
 	return work_done;
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
index f8acc6bbb..d0d303efa 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -31,6 +31,7 @@ struct sk_buff *xsc_skb_from_cqe_linear(struct xsc_rq *rq,
 struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   struct xsc_wqe_frag_info *wi,
 					   u32 cqe_bcnt, u8 has_pph);
+int xsc_poll_rx_cq(struct xsc_cq *cq, int budget);
 
 netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 4c9f183fc..4601eec3b 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -49,19 +49,6 @@ enum {
 	XSC_ETH_SQ_STATE_AM,
 };
 
-struct xsc_dma_info {
-	struct page	*page;
-	dma_addr_t	addr;
-};
-
-struct xsc_page_cache {
-	struct xsc_dma_info	*page_cache;
-	u32	head;
-	u32	tail;
-	u32	sz;
-	u32	resv;
-};
-
 struct xsc_cq {
 	/* data path - accessed per cqe */
 	struct xsc_cqwq	wq;
@@ -85,6 +72,11 @@ struct xsc_wqe_frag_info {
 	u8 is_available;
 };
 
+struct xsc_dma_info {
+	struct page	*page;
+	dma_addr_t	addr;
+};
+
 struct xsc_rq_frag_info {
 	int frag_size;
 	int frag_stride;
@@ -139,7 +131,6 @@ struct xsc_rq {
 	xsc_fp_handle_rx_cqe	handle_rx_cqe;
 	xsc_fp_post_rx_wqes	post_wqes;
 	xsc_fp_dealloc_wqe	dealloc_wqe;
-	struct xsc_page_cache	page_cache;
 } ____cacheline_aligned_in_smp;
 
 enum xsc_dma_map_type {
-- 
2.43.0


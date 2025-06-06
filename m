Return-Path: <netdev+bounces-195403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A315ACFFF8
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686A2188F899
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A940F2874FA;
	Fri,  6 Jun 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="EdiIUbMV"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-35.ptr.blmpb.com (sg-1-35.ptr.blmpb.com [118.26.132.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488227F75A
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204139; cv=none; b=O+AYOrRkIUWxloV5U4o0ZK5xeRHgoXVLrE96TGR6QgwGlnnAMoBIQqAWwQZcfANS0YZUE0ROOHMMcqjFtfIY2pJ+UFyDjVSnG83ljPnnO/DWlYARP/+rQoCXnAHkVM7UdHKHii6/l6oMFdeICrJWklkjrO16lpi7YURd80EpHZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204139; c=relaxed/simple;
	bh=2Y/sPwA1l5IXsmZgZKZJPZgYMsJjv2d3ZHmP9cRUI3g=;
	h=Content-Type:To:Cc:Mime-Version:In-Reply-To:Subject:Date:
	 References:From:Message-Id; b=uPI61+Q81DSndXcEDxw5HZ18TcwK1dP2zAudWXsbl21q1TOZ/NE97E9VhfhTaEtCfK9GwiMS0yBb1jmErKwz5a8GSHcCObUTuYTaOmRXwR51pnrjOm3vVSowOe/mvjj58WS1bZ0rd6Ka9zMGMdxLyTzUvVrZuKHLtP5AVzJkHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=EdiIUbMV; arc=none smtp.client-ip=118.26.132.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1749204129; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=UNUB7bFYUMruWuJdtIy7yqPpeLC8ZgG21KGQLGbiT9k=;
 b=EdiIUbMVY3cUfnMlO0ThFBVmA4lmk0QhoiKD4SQBt42/9sUGhUVel6LzAyFsCImONlxfWy
 qMksjk1RSeKdzcFyIPWlY6IXG9ZxXJIra3L71mgsFpSl0WcMpEqSm7m8qmdmXiRcd9CNlP
 IFicxvscHXvlhG5mEEsk6IaQv1DRgdKTCCRBCMA6tix5QE1IpyF4ZymiBXTZCshdMr8uac
 cZc7HVBzAIcivBZUm24zr5r4Eq7lnhqw6D0CuB+84r1xlyhN6B4LWZ5XrOwqIeqt3uBUOF
 l4VTsEfiQlxeG0Jhw/A7yjTWVZWes52jWHbAlPEgBZC8bcZPdh3bd77kjwVnNQ==
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <pabeni@redhat.com>, <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250606100132.3272115-1-tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Subject: [PATCH net-next v12 12/14] xsc: Add ndo_start_xmit
Date: Fri, 06 Jun 2025 18:02:06 +0800
References: <20250606100132.3272115-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Fri, 06 Jun 2025 18:02:06 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Message-Id: <20250606100204.3272115-13-tianx@yunsilicon.com>
X-Lms-Return-Path: <lba+26842bc9f+8fb503+vger.kernel.org+tianx@yunsilicon.com>

This patch adds core data transmission functionality, focusing
on the ndo_start_xmit interface. The main steps are:

1. Transmission Entry
The entry point selects the appropriate transmit queue (SQ) and
verifies hardware readiness before calling xsc_eth_xmit_frame
for packet transmission.
2. Packet Processing
Supports TCP/UDP GSO, calculates MSS and IHS.
If necessary, performs SKB linearization and handles checksum
offload. Maps data for DMA using dma_map_single and
skb_frag_dma_map.
3. Descriptor Generation
Constructs control (cseg) and data (dseg) segments, including
setting operation codes, segment counts, and DMA addresses.
Hardware Notification & Queue Management:
4. Notifies hardware using a doorbell register and manages
queue flow to avoid overloading.
5. Combines small packets using netdev_xmit_more to reduce
doorbell writes and supports zero-copy transmission for efficiency.

Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Lei Yan <jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |   5 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   2 +-
 .../net/ethernet/yunsilicon/xsc/net/main.c    |   1 +
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   2 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |   8 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  | 315 ++++++++++++++++++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         | 150 ++++++++-
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |  66 ++++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |   7 +
 9 files changed, 552 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c

diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
index 0b54b2d8a..bc938292a 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -490,4 +490,9 @@ static inline u8 xsc_get_user_mode(struct xsc_core_device *xdev)
 	return xdev->user_mode;
 }
 
+static inline u8 get_cqe_opcode(struct xsc_cqe *cqe)
+{
+	return FIELD_GET(XSC_CQE_MSG_OPCD_MASK, le32_to_cpu(cqe->data0));
+}
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
index 104ef5330..7cfc2aaa2 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -6,4 +6,4 @@ ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
 
 obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
 
-xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_rx.o
+xsc_eth-y := main.o xsc_eth_wq.o xsc_eth_txrx.o xsc_eth_tx.o xsc_eth_rx.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/main.c b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
index 3ed995b10..3341d3cf1 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/main.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/main.c
@@ -1683,6 +1683,7 @@ static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
 static const struct net_device_ops xsc_netdev_ops = {
 	.ndo_open		= xsc_eth_open,
 	.ndo_stop		= xsc_eth_close,
+	.ndo_start_xmit		= xsc_eth_xmit_start,
 };
 
 static void xsc_eth_build_nic_netdev(struct xsc_adapter *adapter)
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
index 1b652c192..61354b892 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
@@ -6,6 +6,8 @@
 #ifndef __XSC_ETH_H
 #define __XSC_ETH_H
 
+#include <linux/udp.h>
+
 #include "common/xsc_device.h"
 #include "xsc_eth_common.h"
 
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
index 7b6e180be..4f47dac5c 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
@@ -178,4 +178,12 @@ struct xsc_eth_channels {
 	u32			rqn_base;
 };
 
+union xsc_send_doorbell {
+	struct{
+		s32  next_pid : 16;
+		u32 qp_num : 15;
+	};
+	u32 send_data;
+};
+
 #endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
new file mode 100644
index 000000000..1237433b1
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/tcp.h>
+
+#include "xsc_eth.h"
+#include "xsc_eth_txrx.h"
+
+#define XSC_OPCODE_RAW 7
+
+static void xsc_dma_push(struct xsc_sq *sq, dma_addr_t addr, u32 size,
+			 enum xsc_dma_map_type map_type)
+{
+	struct xsc_sq_dma *dma = xsc_dma_get(sq, sq->dma_fifo_pc++);
+
+	dma->addr = addr;
+	dma->size = size;
+	dma->type = map_type;
+}
+
+static void xsc_dma_unmap_wqe(struct xsc_sq *sq, u8 num_dma)
+{
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct device *dev  = adapter->dev;
+	int i;
+
+	for (i = 0; i < num_dma; i++) {
+		struct xsc_sq_dma *last_pushed_dma;
+
+		last_pushed_dma = xsc_dma_get(sq, --sq->dma_fifo_pc);
+		xsc_tx_dma_unmap(dev, last_pushed_dma);
+	}
+}
+
+static void *xsc_sq_fetch_wqe(struct xsc_sq *sq, size_t size, u16 *pi)
+{
+	struct xsc_wq_cyc *wq = &sq->wq;
+	void *wqe;
+
+	/*caution, sp->pc is default to be zero*/
+	*pi  = xsc_wq_cyc_ctr2ix(wq, sq->pc);
+	wqe = xsc_wq_cyc_get_wqe(wq, *pi);
+	memset(wqe, 0, size);
+
+	return wqe;
+}
+
+static u16 xsc_tx_get_gso_ihs(struct xsc_sq *sq, struct sk_buff *skb)
+{
+	u16 ihs;
+
+	if (skb->encapsulation) {
+		ihs = skb_inner_transport_offset(skb) + inner_tcp_hdrlen(skb);
+	} else {
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
+		else
+			ihs = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	}
+
+	return ihs;
+}
+
+static void xsc_txwqe_build_cseg_csum(struct xsc_sq *sq,
+				      struct sk_buff *skb,
+				      struct xsc_send_wqe_ctrl_seg *cseg)
+{
+	u32 val = le32_to_cpu(cseg->data0);
+
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		if (skb->encapsulation)
+			val |= FIELD_PREP(XSC_WQE_CTRL_SEG_CSUM_EN_MASK,
+					  XSC_ETH_WQE_INNER_AND_OUTER_CSUM);
+		else
+			val |= FIELD_PREP(XSC_WQE_CTRL_SEG_CSUM_EN_MASK,
+					  XSC_ETH_WQE_OUTER_CSUM);
+	} else {
+		val |= FIELD_PREP(XSC_WQE_CTRL_SEG_CSUM_EN_MASK,
+				  XSC_ETH_WQE_NONE_CSUM);
+	}
+	cseg->data0 = cpu_to_le32(val);
+}
+
+static void xsc_txwqe_build_csegs(struct xsc_sq *sq, struct sk_buff *skb,
+				  u16 mss, u16 ihs, u16 headlen,
+				  u8 opcode, u16 ds_cnt, u32 msglen,
+				  struct xsc_send_wqe_ctrl_seg *cseg)
+{
+	struct xsc_core_device *xdev = sq->cq.xdev;
+	int send_wqe_ds_num_log;
+	u32 val = 0;
+
+	send_wqe_ds_num_log = ilog2(xdev->caps.send_ds_num);
+	xsc_txwqe_build_cseg_csum(sq, skb, cseg);
+
+	if (mss != 0) {
+		val |= XSC_WQE_CTRL_SEG_HAS_PPH |
+		       XSC_WQE_CTRL_SEG_SO_TYPE |
+		       FIELD_PREP(XSC_WQE_CTRL_SEG_SO_HDR_LEN_MASK, ihs) |
+		       FIELD_PREP(XSC_WQE_CTRL_SEG_SO_DATA_SIZE_MASK, mss);
+		cseg->data2 = cpu_to_le32(val);
+	}
+
+	val = le32_to_cpu(cseg->data0);
+	val |= FIELD_PREP(XSC_WQE_CTRL_SEG_MSG_OPCODE_MASK, opcode) |
+	       FIELD_PREP(XSC_WQE_CTRL_SEG_WQE_ID_MASK,
+			  sq->pc << send_wqe_ds_num_log) |
+	       FIELD_PREP(XSC_WQE_CTRL_SEG_DS_DATA_NUM_MASK,
+			  ds_cnt - XSC_SEND_WQEBB_CTRL_NUM_DS);
+	cseg->data0 = cpu_to_le32(val);
+	cseg->msg_len = cpu_to_le32(msglen);
+	cseg->data3 = cpu_to_le32(XSC_WQE_CTRL_SEG_CE);
+}
+
+static int xsc_txwqe_build_dsegs(struct xsc_sq *sq, struct sk_buff *skb,
+				 u16 ihs, u16 headlen,
+				 struct xsc_wqe_data_seg *dseg)
+{
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct device *dev = adapter->dev;
+	dma_addr_t dma_addr = 0;
+	u8 num_dma = 0;
+	int i;
+
+	if (headlen) {
+		dma_addr = dma_map_single(dev,
+					  skb->data,
+					  headlen,
+					  DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, dma_addr)))
+			goto err_dma_unmap_wqe;
+
+		dseg->va = cpu_to_le64(dma_addr);
+		dseg->mkey  = cpu_to_le32(be32_to_cpu(sq->mkey_be));
+		dseg->data0 |=
+			cpu_to_le32(FIELD_PREP(XSC_WQE_DATA_SEG_SEG_LEN_MASK,
+					       headlen));
+
+		xsc_dma_push(sq, dma_addr, headlen, XSC_DMA_MAP_SINGLE);
+		num_dma++;
+		dseg++;
+	}
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		int fsz = skb_frag_size(frag);
+
+		dma_addr = skb_frag_dma_map(dev, frag, 0, fsz, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, dma_addr)))
+			goto err_dma_unmap_wqe;
+
+		dseg->va = cpu_to_le64(dma_addr);
+		dseg->mkey = cpu_to_le32(be32_to_cpu(sq->mkey_be));
+		dseg->data0 |=
+			cpu_to_le32(FIELD_PREP(XSC_WQE_DATA_SEG_SEG_LEN_MASK,
+					       fsz));
+
+		xsc_dma_push(sq, dma_addr, fsz, XSC_DMA_MAP_PAGE);
+		num_dma++;
+		dseg++;
+	}
+
+	return num_dma;
+
+err_dma_unmap_wqe:
+	xsc_dma_unmap_wqe(sq, num_dma);
+	return -ENOMEM;
+}
+
+static void xsc_sq_notify_hw(struct xsc_wq_cyc *wq, u16 pc,
+			     struct xsc_sq *sq)
+{
+	struct xsc_adapter *adapter = sq->channel->adapter;
+	struct xsc_core_device *xdev  = adapter->xdev;
+	union xsc_send_doorbell doorbell_value;
+	int send_ds_num_log;
+
+	send_ds_num_log = ilog2(xdev->caps.send_ds_num);
+	/*reverse wqe index to ds index*/
+	doorbell_value.next_pid = pc << send_ds_num_log;
+	doorbell_value.qp_num = sq->sqn;
+
+	/* Make sure that descriptors are written before
+	 * updating doorbell record and ringing the doorbell
+	 */
+	wmb();
+	writel(doorbell_value.send_data, XSC_REG_ADDR(xdev, xdev->regs.tx_db));
+}
+
+static void xsc_txwqe_complete(struct xsc_sq *sq, struct sk_buff *skb,
+			       u8 opcode, u16 ds_cnt,
+			       u8 num_wqebbs, u32 num_bytes, u8 num_dma,
+			       struct xsc_tx_wqe_info *wi)
+{
+	struct xsc_wq_cyc *wq = &sq->wq;
+
+	wi->num_bytes = num_bytes;
+	wi->num_dma = num_dma;
+	wi->num_wqebbs = num_wqebbs;
+	wi->skb = skb;
+
+	netdev_tx_sent_queue(sq->txq, num_bytes);
+
+	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+
+	sq->pc += wi->num_wqebbs;
+
+	if (unlikely(!xsc_wqc_has_room_for(wq, sq->cc, sq->pc, sq->stop_room)))
+		netif_tx_stop_queue(sq->txq);
+
+	if (!netdev_xmit_more() || netif_xmit_stopped(sq->txq))
+		xsc_sq_notify_hw(wq, sq->pc, sq);
+}
+
+static uint32_t xsc_eth_xmit_frame(struct sk_buff *skb,
+				   struct xsc_sq *sq,
+				   struct xsc_tx_wqe *wqe,
+				   u16 pi)
+{
+	struct xsc_core_device *xdev = sq->cq.xdev;
+	struct xsc_send_wqe_ctrl_seg *cseg;
+	struct xsc_wqe_data_seg *dseg;
+	struct xsc_tx_wqe_info *wi;
+	u16 mss, ihs, headlen;
+	u32 num_bytes;
+	u8 num_wqebbs;
+	int num_dma;
+	u16 ds_cnt;
+	u8 opcode;
+
+retry_send:
+	/* Calc ihs and ds cnt, no writes to wqe yet
+	 * ctrl-ds, it would be reduce in ds_data_num */
+	ds_cnt = XSC_SEND_WQEBB_CTRL_NUM_DS;
+
+	if (skb_is_gso(skb)) {
+		opcode		= XSC_OPCODE_RAW;
+		mss		= skb_shinfo(skb)->gso_size;
+		ihs		= xsc_tx_get_gso_ihs(sq, skb);
+		num_bytes	= skb->len +
+				  (skb_shinfo(skb)->gso_segs - 1) * ihs;
+	} else {
+		opcode		= XSC_OPCODE_RAW;
+		mss		= 0;
+		ihs		= 0;
+		num_bytes	= skb->len;
+	}
+
+	/*linear data in skb*/
+	headlen = skb->len - skb->data_len;
+	ds_cnt += !!headlen;
+	ds_cnt += skb_shinfo(skb)->nr_frags;
+
+	/* Check packet size. */
+	if (unlikely(mss == 0 && skb->len > sq->hw_mtu))
+		goto err_drop;
+
+	num_wqebbs = DIV_ROUND_UP(ds_cnt, xdev->caps.send_ds_num);
+	/*if ds_cnt exceed one wqe, drop it*/
+	if (num_wqebbs != 1) {
+		if (skb_linearize(skb))
+			goto err_drop;
+		goto retry_send;
+	}
+
+	/* fill wqe */
+	wi   = (struct xsc_tx_wqe_info *)&sq->db.wqe_info[pi];
+	cseg = &wqe->ctrl;
+	dseg = &wqe->data[0];
+
+	if (unlikely(skb->len == 0))
+		goto err_drop;
+
+	xsc_txwqe_build_csegs(sq, skb, mss, ihs, headlen,
+			      opcode, ds_cnt, skb->len, cseg);
+
+	/*inline header is also use dma to transport*/
+	num_dma = xsc_txwqe_build_dsegs(sq, skb, ihs, headlen, dseg);
+	if (unlikely(num_dma < 0))
+		goto err_drop;
+
+	xsc_txwqe_complete(sq, skb, opcode, ds_cnt, num_wqebbs, num_bytes,
+			   num_dma, wi);
+
+	return NETDEV_TX_OK;
+
+err_drop:
+	dev_kfree_skb_any(skb);
+
+	return NETDEV_TX_OK;
+}
+
+netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct xsc_adapter *adapter = netdev_priv(netdev);
+	struct xsc_tx_wqe *wqe;
+	struct xsc_sq *sq;
+	u32 ds_num;
+	u16 pi;
+
+	if (adapter->status != XSCALE_ETH_DRIVER_OK)
+		return NETDEV_TX_BUSY;
+
+	sq = adapter->txq2sq[skb_get_queue_mapping(skb)];
+	if (unlikely(!sq))
+		return NETDEV_TX_BUSY;
+
+	ds_num = adapter->xdev->caps.send_ds_num;
+	wqe = xsc_sq_fetch_wqe(sq, ds_num * XSC_SEND_WQE_DS, &pi);
+
+	return xsc_eth_xmit_frame(skb, sq, wqe, pi);
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
index 2ed08ee44..9784816c3 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
@@ -20,9 +20,153 @@ void xsc_cq_notify_hw_rearm(struct xsc_cq *cq)
 	writel(db_val, XSC_REG_ADDR(cq->xdev, cq->xdev->regs.complete_db));
 }
 
-int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
+void xsc_cq_notify_hw(struct xsc_cq *cq)
 {
-	/* TBD */
-	return true;
+	struct xsc_core_device *xdev  = cq->xdev;
+	u32 db_val = 0;
+
+	db_val |= FIELD_PREP(XSC_CQ_DB_NEXT_CID_MASK, cq->wq.cc) |
+		  FIELD_PREP(XSC_CQ_DB_CQ_ID_MASK, cq->xcq.cqn);
+
+	/* ensure doorbell record is visible to device
+	 * before ringing the doorbell
+	 */
+	wmb();
+	writel(db_val, XSC_REG_ADDR(xdev, xdev->regs.complete_reg));
 }
 
+static bool xsc_channel_no_affinity_change(struct xsc_channel *c)
+{
+	int current_cpu = smp_processor_id();
+
+	return cpumask_test_cpu(current_cpu, c->aff_mask);
+}
+
+static void xsc_dump_error_sqcqe(struct xsc_sq *sq,
+				 struct xsc_cqe *cqe)
+{
+	struct net_device *netdev = sq->channel->netdev;
+	u32 ci = xsc_cqwq_get_ci(&sq->cq.wq);
+
+	net_err_ratelimited("Err cqe on dev %s cqn=0x%x ci=0x%x sqn=0x%x err_code=0x%x qpid=0x%lx\n",
+			    netdev->name, sq->cq.xcq.cqn, ci,
+			    sq->sqn, get_cqe_opcode(cqe),
+			    FIELD_GET(XSC_CQE_QP_ID_MASK,
+				      le32_to_cpu(cqe->data0)));
+}
+
+static bool xsc_poll_tx_cq(struct xsc_cq *cq, int napi_budget)
+{
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
+}
+
+int xsc_eth_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct xsc_channel *c = container_of(napi, struct xsc_channel, napi);
+	struct xsc_eth_params *params = &c->adapter->nic_param;
+	struct xsc_sq *sq = NULL;
+	bool busy = false;
+	int work_done = 0;
+	int tx_budget = 0;
+	int i;
+
+	rcu_read_lock();
+
+	tx_budget = params->sq_size >> 2;
+	for (i = 0; i < c->num_tc; i++)
+		busy |= xsc_poll_tx_cq(&c->qp.sq[i].cq, tx_budget);
+
+	if (busy) {
+		if (likely(xsc_channel_no_affinity_change(c))) {
+			rcu_read_unlock();
+			return budget;
+		}
+	}
+
+	if (unlikely(!napi_complete_done(napi, work_done)))
+		goto err_out;
+
+	for (i = 0; i < c->num_tc; i++) {
+		sq = &c->qp.sq[i];
+		xsc_cq_notify_hw_rearm(&sq->cq);
+	}
+err_out:
+	rcu_read_unlock();
+	return work_done;
+}
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
index 1f6187093..f8acc6bbb 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
@@ -6,9 +6,20 @@
 #ifndef __XSC_RXTX_H
 #define __XSC_RXTX_H
 
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
 #include "xsc_eth.h"
 
+enum {
+	XSC_ETH_WQE_NONE_CSUM,
+	XSC_ETH_WQE_INNER_CSUM,
+	XSC_ETH_WQE_OUTER_CSUM,
+	XSC_ETH_WQE_INNER_AND_OUTER_CSUM,
+};
+
 void xsc_cq_notify_hw_rearm(struct xsc_cq *cq);
+void xsc_cq_notify_hw(struct xsc_cq *cq);
 int xsc_eth_napi_poll(struct napi_struct *napi, int budget);
 bool xsc_eth_post_rx_wqes(struct xsc_rq *rq);
 void xsc_eth_handle_rx_cqe(struct xsc_cqwq *cqwq,
@@ -21,4 +32,59 @@ struct sk_buff *xsc_skb_from_cqe_nonlinear(struct xsc_rq *rq,
 					   struct xsc_wqe_frag_info *wi,
 					   u32 cqe_bcnt, u8 has_pph);
 
+netdev_tx_t xsc_eth_xmit_start(struct sk_buff *skb, struct net_device *netdev);
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
+	u32 ci = xsc_cqwq_get_ci(wq);
+	u8 cqe_ownership_bit;
+	struct xsc_cqe *cqe;
+	u8 sw_ownership_val;
+
+	cqe = xsc_cqwq_get_cqe_buff(wq, ci);
+
+	cqe_ownership_bit = !!(le32_to_cpu(cqe->data1) & XSC_CQE_OWNER);
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
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
index 643b2c759..4c9f183fc 100644
--- a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
@@ -36,6 +36,8 @@ enum {
 #define XSC_RECV_WQEBB_NUM_DS	        (XSC_RECV_WQE_BB / XSC_RECV_WQE_DS)
 #define XSC_LOG_RECV_WQEBB_NUM_DS	ilog2(XSC_RECV_WQEBB_NUM_DS)
 
+#define XSC_SEND_WQEBB_CTRL_NUM_DS	1
+
 /* each ds holds one fragment in skb */
 #define XSC_MAX_RX_FRAGS        4
 #define XSC_RX_FRAG_SZ_ORDER    0
@@ -158,6 +160,11 @@ struct xsc_tx_wqe_info {
 	u8  num_dma;
 };
 
+struct xsc_tx_wqe {
+	struct xsc_send_wqe_ctrl_seg ctrl;
+	struct xsc_wqe_data_seg data[];
+};
+
 struct xsc_sq {
 	struct xsc_core_qp		cqp;
 	/* dirtied @completion */
-- 
2.43.0


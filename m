Return-Path: <netdev+bounces-221097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C566B4A3B4
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21C417FF06
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26C430F524;
	Tue,  9 Sep 2025 07:34:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC330DEC5;
	Tue,  9 Sep 2025 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403247; cv=none; b=k9Rp3DAfnd18rqsiWiJ7bevKldbdxskPi13Dg0QM/nFVIZhJsVPdDoheletqYWsTb2wfbvDIqIRZNVYsFWkLDXPXs7cx2PMP0PHVy3QMi7ttdd0WLSKGCfLz95cPlgjrEzXKoy+f/wiojY5G397NGDYfqU77x/8j7gEFip/rK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403247; c=relaxed/simple;
	bh=5FMNIiSZBBTXpXTec8AIZmd4GbkghmicIv5a7pA8+tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Twiu9jkHwSQQWY77kTRD9ZS8VOmAIaneli9lVX/8v6xdR23bTNVCn9DrmmickT63USr9j76YPmILXRQk3YnWJkX3bmdDBusP/UF2CT8TwYqUb51J9BKmAKczBnQZSLVjtISnqYtRKE9jVnZZKXXivK9Wl7ONbnysRmC8DslPWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cLb8h1PGsz1R9Jh;
	Tue,  9 Sep 2025 15:31:00 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C58B14013B;
	Tue,  9 Sep 2025 15:34:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 15:34:00 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v05 07/14] hinic3: Queue pair endianness improvements
Date: Tue, 9 Sep 2025 15:33:32 +0800
Message-ID: <90167074ae79a7e90a0fea0e38c32bbe8203231e.1757401320.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757401320.git.zhuyikai1@h-partners.com>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Explicitly use little-endian & big-endian structs to support big
endian hosts.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 15 ++--
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 10 +--
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    | 24 +++---
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 81 ++++++++++---------
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 18 ++---
 5 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index 865ba6878c48..1808d37e7cf7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -75,8 +75,8 @@ static inline u16 hinic3_get_sq_hw_ci(const struct hinic3_io_queue *sq)
 #define DB_CFLAG_DP_RQ   1
 
 struct hinic3_nic_db {
-	u32 db_info;
-	u32 pi_hi;
+	__le32 db_info;
+	__le32 pi_hi;
 };
 
 static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
@@ -84,11 +84,12 @@ static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
 {
 	struct hinic3_nic_db db;
 
-	db.db_info = DB_INFO_SET(DB_SRC_TYPE, TYPE) |
-		     DB_INFO_SET(cflag, CFLAG) |
-		     DB_INFO_SET(cos, COS) |
-		     DB_INFO_SET(queue->q_id, QID);
-	db.pi_hi = DB_PI_HIGH(pi);
+	db.db_info =
+		cpu_to_le32(DB_INFO_SET(DB_SRC_TYPE, TYPE) |
+			    DB_INFO_SET(cflag, CFLAG) |
+			    DB_INFO_SET(cos, COS) |
+			    DB_INFO_SET(queue->q_id, QID));
+	db.pi_hi = cpu_to_le32(DB_PI_HIGH(pi));
 
 	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 860163e9d66c..ac04e3a192ad 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -66,8 +66,8 @@ static void rq_wqe_buf_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
 	struct hinic3_rq_wqe *rq_wqe;
 
 	rq_wqe = get_q_element(&rq->wq.qpages, wqe_idx, NULL);
-	rq_wqe->buf_hi_addr = upper_32_bits(dma_addr);
-	rq_wqe->buf_lo_addr = lower_32_bits(dma_addr);
+	rq_wqe->buf_hi_addr = cpu_to_le32(upper_32_bits(dma_addr));
+	rq_wqe->buf_lo_addr = cpu_to_le32(lower_32_bits(dma_addr));
 }
 
 static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
@@ -279,7 +279,7 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	if (skb_is_nonlinear(skb))
 		hinic3_pull_tail(skb);
 
-	offload_type = rx_cqe->offload_type;
+	offload_type = le32_to_cpu(rx_cqe->offload_type);
 	hinic3_rx_csum(rxq, offload_type, status, skb);
 
 	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
@@ -311,14 +311,14 @@ int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
 	while (likely(nr_pkts < budget)) {
 		sw_ci = rxq->cons_idx & rxq->q_mask;
 		rx_cqe = rxq->cqe_arr + sw_ci;
-		status = rx_cqe->status;
+		status = le32_to_cpu(rx_cqe->status);
 		if (!RQ_CQE_STATUS_GET(status, RXDONE))
 			break;
 
 		/* make sure we read rx_done before packet length */
 		rmb();
 
-		vlan_len = rx_cqe->vlan_len;
+		vlan_len = le32_to_cpu(rx_cqe->vlan_len);
 		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
 		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
 			break;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 1cca21858d40..e7b496d13a69 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -27,21 +27,21 @@
 
 /* RX Completion information that is provided by HW for a specific RX WQE */
 struct hinic3_rq_cqe {
-	u32 status;
-	u32 vlan_len;
-	u32 offload_type;
-	u32 rsvd3;
-	u32 rsvd4;
-	u32 rsvd5;
-	u32 rsvd6;
-	u32 pkt_info;
+	__le32 status;
+	__le32 vlan_len;
+	__le32 offload_type;
+	__le32 rsvd3;
+	__le32 rsvd4;
+	__le32 rsvd5;
+	__le32 rsvd6;
+	__le32 pkt_info;
 };
 
 struct hinic3_rq_wqe {
-	u32 buf_hi_addr;
-	u32 buf_lo_addr;
-	u32 cqe_hi_addr;
-	u32 cqe_lo_addr;
+	__le32 buf_hi_addr;
+	__le32 buf_lo_addr;
+	__le32 cqe_hi_addr;
+	__le32 cqe_lo_addr;
 };
 
 struct hinic3_rx_info {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index f1c745ee3087..8671bc2e1316 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -81,10 +81,10 @@ static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
 
 	dma_info[0].len = skb_headlen(skb);
 
-	wqe_desc->hi_addr = upper_32_bits(dma_info[0].dma);
-	wqe_desc->lo_addr = lower_32_bits(dma_info[0].dma);
+	wqe_desc->hi_addr = cpu_to_le32(upper_32_bits(dma_info[0].dma));
+	wqe_desc->lo_addr = cpu_to_le32(lower_32_bits(dma_info[0].dma));
 
-	wqe_desc->ctrl_len = dma_info[0].len;
+	wqe_desc->ctrl_len = cpu_to_le32(dma_info[0].len);
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		frag = &(skb_shinfo(skb)->frags[i]);
@@ -197,7 +197,8 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		union hinic3_ip ip;
 		u8 l4_proto;
 
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 TUNNEL_FLAG));
 
 		ip.hdr = skb_network_header(skb);
 		if (ip.v4->version == 4) {
@@ -226,7 +227,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
 		}
 	}
 
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+	task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, INNER_L4_EN));
 
 	return 1;
 }
@@ -255,26 +256,28 @@ static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic3_ip *ip,
 	}
 }
 
-static void hinic3_set_tso_info(struct hinic3_sq_task *task, u32 *queue_info,
+static void hinic3_set_tso_info(struct hinic3_sq_task *task, __le32 *queue_info,
 				enum hinic3_l4_offload_type l4_offload,
 				u32 offset, u32 mss)
 {
 	if (l4_offload == HINIC3_L4_OFFLOAD_TCP) {
-		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, TSO);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+		*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, TSO));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 INNER_L4_EN));
 	} else if (l4_offload == HINIC3_L4_OFFLOAD_UDP) {
-		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, UFO);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L4_EN);
+		*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, UFO));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 INNER_L4_EN));
 	}
 
 	/* enable L3 calculation */
-	task->pkt_info0 |= SQ_TASK_INFO0_SET(1, INNER_L3_EN);
+	task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, INNER_L3_EN));
 
-	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF);
+	*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF));
 
 	/* set MSS value */
-	*queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
-	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(mss, MSS);
+	*queue_info &= cpu_to_le32(~SQ_CTRL_QUEUE_INFO_MSS_MASK);
+	*queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(mss, MSS));
 }
 
 static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
@@ -284,7 +287,7 @@ static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
 		csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
 }
 
-static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
+static int hinic3_tso(struct hinic3_sq_task *task, __le32 *queue_info,
 		      struct sk_buff *skb)
 {
 	enum hinic3_l4_offload_type l4_offload;
@@ -305,15 +308,17 @@ static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
 	if (skb->encapsulation) {
 		u32 gso_type = skb_shinfo(skb)->gso_type;
 		/* L3 checksum is always enabled */
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, OUT_L3_EN);
-		task->pkt_info0 |= SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1, OUT_L3_EN));
+		task->pkt_info0 |= cpu_to_le32(SQ_TASK_INFO0_SET(1,
+								 TUNNEL_FLAG));
 
 		l4.hdr = skb_transport_header(skb);
 		ip.hdr = skb_network_header(skb);
 
 		if (gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
 			l4.udp->check = ~csum_magic(&ip, IPPROTO_UDP);
-			task->pkt_info0 |= SQ_TASK_INFO0_SET(1, OUT_L4_EN);
+			task->pkt_info0 |=
+				cpu_to_le32(SQ_TASK_INFO0_SET(1, OUT_L4_EN));
 		}
 
 		ip.hdr = skb_inner_network_header(skb);
@@ -343,13 +348,14 @@ static void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
 	 * 2=select TPID2 in IPSU, 3=select TPID3 in IPSU,
 	 * 4=select TPID4 in IPSU
 	 */
-	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
-			     SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
-			     SQ_TASK_INFO3_SET(1, VLAN_TAG_VALID);
+	task->vlan_offload =
+		cpu_to_le32(SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			    SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
+			    SQ_TASK_INFO3_SET(1, VLAN_TAG_VALID));
 }
 
 static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
-			     u32 *queue_info, struct hinic3_txq *txq)
+			     __le32 *queue_info, struct hinic3_txq *txq)
 {
 	u32 offload = 0;
 	int tso_cs_en;
@@ -440,39 +446,41 @@ static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
 }
 
 static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
-				   u32 queue_info, int nr_descs, u16 owner)
+				   __le32 queue_info, int nr_descs, u16 owner)
 {
 	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
 
 	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
 		wqe_desc->ctrl_len |=
-		    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
-		    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
-		    SQ_CTRL_SET(owner, OWNER);
+			cpu_to_le32(SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+				    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+				    SQ_CTRL_SET(owner, OWNER));
 
 		/* compact wqe queue_info will transfer to chip */
 		wqe_desc->queue_info = 0;
 		return;
 	}
 
-	wqe_desc->ctrl_len |= SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
-			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
-			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
-			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
-			      SQ_CTRL_SET(owner, OWNER);
+	wqe_desc->ctrl_len |=
+		cpu_to_le32(SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
+			    SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			    SQ_CTRL_SET(owner, OWNER));
 
 	wqe_desc->queue_info = queue_info;
-	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1, UC);
+	wqe_desc->queue_info |= cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(1, UC));
 
 	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
 		wqe_desc->queue_info |=
-		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_DEFAULT, MSS);
+		    cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_DEFAULT, MSS));
 	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
 		   HINIC3_TX_MSS_MIN) {
 		/* mss should not be less than 80 */
-		wqe_desc->queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+		wqe_desc->queue_info &=
+		    cpu_to_le32(~SQ_CTRL_QUEUE_INFO_MSS_MASK);
 		wqe_desc->queue_info |=
-		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_MIN, MSS);
+		    cpu_to_le32(SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_MIN, MSS));
 	}
 }
 
@@ -482,12 +490,13 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 {
 	struct hinic3_sq_wqe_combo wqe_combo = {};
 	struct hinic3_tx_info *tx_info;
-	u32 offload, queue_info = 0;
 	struct hinic3_sq_task task;
 	u16 wqebb_cnt, num_sge;
+	__le32 queue_info = 0;
 	u16 saved_wq_prod_idx;
 	u16 owner, pi = 0;
 	u8 saved_sq_owner;
+	u32 offload;
 	int err;
 
 	if (unlikely(skb->len < MIN_SKB_LEN)) {
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 9e505cc19dd5..21dfe879a29a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -58,7 +58,7 @@ enum hinic3_tx_offload_type {
 #define SQ_CTRL_QUEUE_INFO_SET(val, member) \
 	FIELD_PREP(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
 #define SQ_CTRL_QUEUE_INFO_GET(val, member) \
-	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, le32_to_cpu(val))
 
 #define SQ_CTRL_MAX_PLDOFF  221
 
@@ -77,17 +77,17 @@ enum hinic3_tx_offload_type {
 	FIELD_PREP(SQ_TASK_INFO3_##member##_MASK, val)
 
 struct hinic3_sq_wqe_desc {
-	u32 ctrl_len;
-	u32 queue_info;
-	u32 hi_addr;
-	u32 lo_addr;
+	__le32 ctrl_len;
+	__le32 queue_info;
+	__le32 hi_addr;
+	__le32 lo_addr;
 };
 
 struct hinic3_sq_task {
-	u32 pkt_info0;
-	u32 ip_identify;
-	u32 rsvd;
-	u32 vlan_offload;
+	__le32 pkt_info0;
+	__le32 ip_identify;
+	__le32 rsvd;
+	__le32 vlan_offload;
 };
 
 struct hinic3_sq_wqe_combo {
-- 
2.43.0



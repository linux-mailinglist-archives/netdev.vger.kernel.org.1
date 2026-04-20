Return-Path: <netdev+bounces-279628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFDXAQuO5WnXlQEAu9opvQ
	(envelope-from <netdev+bounces-279628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6678442637A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 04:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 413F73047BEF
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0A379979;
	Mon, 20 Apr 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="XEXFfFfn"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E96375AD0;
	Mon, 20 Apr 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651658; cv=none; b=TIVFCsLJhJApk7ETiN9sdB77VBeH8o1hK4jbMcxh+REoq+VXqdu6wd1kGFWKoAHY8NWZbMxvywX6pO3qWUXCies39FFM6+MM3HZ9HufyUspg5Q0x9oTOEUM/2hTJrUb0GpPtnO8cUhYLWv8/PgzrncTajuApojFKOyW/5HZZGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651658; c=relaxed/simple;
	bh=qOd3bnZlFMcOjsJrn9PcHOdjbBuW+DQ7Q16HPRH/eGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rev9Rtgoor3dnW7RyAqG2xkokwCPrIiBEvqp+Lw7aAwOCXDnJpliBPpngX5Hnr5qusISMQRMW5imUxFf2e/jRvyQHrbLRw9DZ+Ybp+r+DOrtm7zF8sRKmpJpjC47n8Juu1J0SkMGA5e6EUCLGhSmCJlWG+NVKG969dfWniFhlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=XEXFfFfn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63K2KEBm8277433, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1776651614;
	bh=CjsHUf7itV/xdWKBobCkgIGE2i0tGSxJ60lvJ6uhGzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XEXFfFfn+TncDb77LOld1pa15tSX12WwdP8oFOgKLA8P/HEL8kiQt02rMlCvKDPxA
	 P1jQbqSKTlok9s4zfrJecb3RLPeJAD2wX7QSoaONbZGKIiVFGIW5S8UtM5/ONWW7Nd
	 EPr8EA0eBvuzzV66xW8bRxF8QXqzpBWQsh97P+VI0at4INU5JybAe5wxpFuTH8Sko1
	 zfYRsjgEMA34exdHshjwYK+r8WUFouEEdvO0bn95VJl54PEYmfurkqpyMsfOZWPIOb
	 0eqhAMJLl0qQj/oraH6eFXnZJ1TV00tC8BZ0n2PttaJr1etdwvS8Co3CIHZ5u9q5Ik
	 3mV0ej2czFZ3w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63K2KEBm8277433
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 10:20:14 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 20 Apr 2026 10:20:13 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Mon, 20 Apr 2026 10:20:13 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [RFC Patch net-next v1 4/9] r8169: add support for multi rx queues
Date: Mon, 20 Apr 2026 10:19:52 +0800
Message-ID: <20260420021957.1756-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260420021957.1756-1-javen_xu@realsil.com.cn>
References: <20260420021957.1756-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-279628-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]
X-Rspamd-Queue-Id: 6678442637A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Javen Xu <javen_xu@realsil.com.cn>

This patch supports for multi rx queues. But we set rx queue num 1 here.
We will add support for rx queue num 8 in rss patch.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 272 +++++++++++++++++-----
 1 file changed, 212 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 05f0cb532a31..52e690eba644 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -73,7 +73,6 @@
 #define R8169_RX_BUF_SIZE	(SZ_16K - 1)
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
@@ -793,6 +792,19 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_rx_ring {
+	u32 index;				/* Rx queue index */
+	u32 cur_rx;				/* Index into the Rx descriptor buffer of next Rx pkt. */
+	u32 dirty_rx;				/* Index into the Rx descriptor buffer for recycling. */
+	u32 num_rx_desc;			/* num of Rx desc */
+	struct RxDesc *RxDescArray;		/* array of Rx Desc*/
+	u32 RxDescAllocSize;			/* memory size per descs of ring */
+	dma_addr_t RxDescPhyAddr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
+	dma_addr_t RxPhyAddr;			/* Rx desc physical address */
+	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
+	u16 rdsar_reg;				/* Receive Descriptor Start Address */
+};
+
 struct rtl8169_tx_ring {
 	u32 index;				/* Tx queue index */
 	u32 cur_tx;				/* Index into the Tx descriptor buffer of next Tx pkt. */
@@ -833,12 +845,9 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
-	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
-	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
-	dma_addr_t RxPhyAddr;
-	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
 	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
 	struct rtl8169_tx_ring tx_ring[R8169_MAX_TX_QUEUES];
 	u16 isr_reg[R8169_MAX_MSIX_VEC];
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
@@ -848,11 +857,13 @@ struct rtl8169_private {
 	u16 tx_lpi_timer;
 	u32 irq_mask;
 	u16 HwSuppNumTxQueues;
+	u16 HwSuppNumRxQueues;
 	u8 min_irq_nvecs;
 	u8 max_irq_nvecs;
 	u8 HwSuppIsrVer;
 	u8 HwCurrIsrVer;
 	u8 irq_nvecs;
+	u8 InitRxDescType;
 	u8 recheck_desc_ownbit;
 	unsigned int features;
 	int irq;
@@ -2728,6 +2739,15 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->RxDescArray, 0x0, ring->RxDescAllocSize);
+	}
+}
+
 static void rtl8169_tx_desc_init(struct rtl8169_private *tp)
 {
 	for (int i = 0; i < tp->num_tx_rings; i++) {
@@ -2750,6 +2770,14 @@ static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 		ring->index = i;
 		netdev_tx_reset_queue(netdev_get_tx_queue(dev, i));
 	}
+
+	for (int i = 0; i < tp->HwSuppNumRxQueues; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		ring->dirty_rx = 0;
+		ring->cur_rx = 0;
+		ring->index = i;
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2810,6 +2838,9 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 
 static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num, u32 tx_num)
 {
+	for (int i = 0; i < tp->HwSuppNumRxQueues; i++)
+		tp->rx_ring[i].num_rx_desc = rx_num;
+
 	for (int i = 0; i < tp->HwSuppNumTxQueues; i++)
 		tp->tx_ring[i].num_tx_desc = tx_num;
 }
@@ -2820,6 +2851,10 @@ static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 	for (int i = 1; i < tp->HwSuppNumTxQueues; i++)
 		tp->tx_ring[i].tdsar_reg = (u16)(TNPDS_Q1_LOW + (i - 1) * 8);
 
+	tp->rx_ring[0].rdsar_reg = RxDescAddrLow;
+	for (int i = 1; i < tp->HwSuppNumRxQueues; i++)
+		tp->rx_ring[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
+
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
 		tp->isr_reg[0] = IntrStatus;
 		tp->imr_reg[0] = IntrMask;
@@ -2845,15 +2880,18 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 		tp->min_irq_nvecs = R8127_MIN_IRQ;
 		tp->max_irq_nvecs = R8127_MAX_IRQ;
 		tp->HwSuppNumTxQueues = R8127_MAX_TX_QUEUES;
+		tp->HwSuppNumRxQueues = R8127_MAX_RX_QUEUES;
 		tp->HwSuppIsrVer = 6;
 		break;
 	default:
 		tp->min_irq_nvecs = 1;
 		tp->max_irq_nvecs = 1;
 		tp->HwSuppNumTxQueues = 1;
+		tp->HwSuppNumRxQueues = 1;
 		tp->HwSuppIsrVer = 1;
 		break;
 	}
+	tp->InitRxDescType = RX_DESC_RING_TYPE_DEAFULT;
 	tp->HwCurrIsrVer = tp->HwSuppIsrVer;
 
 	rtl_setup_mqs_reg(tp);
@@ -2989,14 +3027,18 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 * register to be written before TxDescAddrLow to work.
 	 * Switching from MMIO to I/O access fixes the issue as well.
 	 */
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
 	for (int i = 0; i < tp->num_tx_rings; i++) {
 		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
 
 		RTL_W32(tp, ring->tdsar_reg, ((u64)ring->TxPhyAddr & DMA_BIT_MASK(32)));
 		RTL_W32(tp, ring->tdsar_reg + 4, ((u64)ring->TxPhyAddr >> 32));
 	}
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		RTL_W32(tp, ring->rdsar_reg, ((u64)ring->RxPhyAddr) & DMA_BIT_MASK(32));
+		RTL_W32(tp, ring->rdsar_reg + 4, ((u64)ring->RxPhyAddr >> 32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4332,7 +4374,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
 
@@ -4342,13 +4384,19 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
 	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
 }
 
+static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	rtl8169_mark_to_asic_default(desc);
+}
+
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					  struct RxDesc *desc)
+					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
 	struct page *data;
+	struct RxDesc *desc = ring->RxDescArray + index;
 
 	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
 	if (!data)
@@ -4361,44 +4409,56 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 		return NULL;
 	}
 
+	ring->RxDescPhyAddr[index] = mapping;
 	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
+	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
 }
 
-static void rtl8169_rx_clear(struct rtl8169_private *tp)
+static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
-	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
+	for (i = 0; i < NUM_RX_DESC && ring->Rx_databuff[i]; i++) {
 		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
+			       ring->RxDescPhyAddr[i],
 			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
-		tp->Rx_databuff[i] = NULL;
-		tp->RxDescArray[i].addr = 0;
-		tp->RxDescArray[i].opts1 = 0;
+		__free_pages(ring->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+		ring->Rx_databuff[i] = NULL;
+		ring->RxDescPhyAddr[i] = 0;
+		ring->RxDescArray[i].addr = 0;
+		ring->RxDescArray[i].opts1 = 0;
 	}
 }
 
-static int rtl8169_rx_fill(struct rtl8169_private *tp)
+static void rtl8169_mark_as_last_descriptor_default(struct RxDesc *desc)
+{
+	desc->opts1 |= cpu_to_le32(RingEnd);
+}
+
+static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	rtl8169_mark_as_last_descriptor_default(desc);
+}
+
+static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		struct page *data;
 
-		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
+		data = rtl8169_alloc_rx_data(tp, ring, i);
 		if (!data) {
-			rtl8169_rx_clear(tp);
+			rtl8169_rx_clear(tp, ring);
 			return -ENOMEM;
 		}
-		tp->Rx_databuff[i] = data;
+		ring->Rx_databuff[i] = data;
 	}
 
 	/* mark as last descriptor in the ring */
-	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	rtl8169_mark_as_last_descriptor(tp, &ring->RxDescArray[NUM_RX_DESC - 1]);
 
 	return 0;
 }
@@ -4438,6 +4498,40 @@ static void rtl8169_free_tx_desc(struct rtl8169_private *tp)
 	}
 }
 
+static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		ring->RxDescAllocSize = (ring->num_rx_desc + 1) * sizeof(struct RxDesc);
+		ring->RxDescArray = dma_alloc_coherent(&pdev->dev,
+						       ring->RxDescAllocSize,
+						       &ring->RxPhyAddr,
+						       GFP_KERNEL);
+		if (!ring->RxDescArray)
+			return -1;
+	}
+	return 0;
+}
+
+static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		if (ring->RxDescArray) {
+			dma_free_coherent(&pdev->dev,
+					  ring->RxDescAllocSize,
+					  ring->RxDescArray,
+					  ring->RxPhyAddr);
+			ring->RxDescArray = NULL;
+		}
+	}
+}
 
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
@@ -4445,6 +4539,7 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
 
 	rtl8169_init_ring_indexes(tp);
 	rtl8169_tx_desc_init(tp);
+	rtl8169_rx_desc_init(tp);
 
 	for (int i = 0; i < tp->num_tx_rings; i++) {
 		struct rtl8169_tx_ring *ring = &tp->tx_ring[i];
@@ -4452,9 +4547,14 @@ static int rtl8169_init_ring(struct rtl8169_private *tp)
 		memset(ring->tx_skb, 0x0, sizeof(ring->tx_skb));
 	}
 
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
+		memset(ring->Rx_databuff, 0, sizeof(ring->Rx_databuff));
+		retval = rtl8169_rx_fill(tp, ring);
+	}
 
-	return rtl8169_rx_fill(tp);
+	return retval;
 }
 
 static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp,
@@ -4549,16 +4649,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 	rtl8169_init_ring_indexes(tp);
 }
 
-static void rtl_reset_work(struct rtl8169_private *tp)
+static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 {
-	int i;
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		for (int j = 0; j < ring->num_rx_desc; j++)
+			rtl8169_mark_to_asic(tp, ring->RxDescArray + j);
+	}
+}
 
+static void rtl_reset_work(struct rtl8169_private *tp)
+{
 	netif_stop_queue(tp->dev);
 
 	rtl8169_cleanup(tp);
 
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	rtl8169_rx_desc_reset(tp);
 
 	rtl8169_napi_enable(tp);
 
@@ -5033,9 +5140,11 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
+static inline void rtl8169_rx_csum_default(struct rtl8169_private *tp,
+					   struct sk_buff *skb,
+					   struct RxDesc *desc)
 {
-	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
+	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
 
 	if (status == RxProtoTCP || status == RxProtoUDP)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -5043,22 +5152,67 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
-static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
+static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
+				   struct sk_buff *skb,
+				   struct RxDesc *desc)
+{
+	rtl8169_rx_csum_default(tp, skb, desc);
+}
+
+static u32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	return READ_ONCE(desc->opts1);
+}
+
+static int rtl8169_check_rx_desc_error(struct net_device *dev,
+				       struct rtl8169_private *tp,
+				       u32 status)
+{
+	int ret = 0;
+
+	if (unlikely(status & RxRES)) {
+		if (status & (RxRWT | RxRUNT))
+			dev->stats.rx_length_errors++;
+		if (status & RxCRC)
+			dev->stats.rx_crc_errors++;
+		ret = -1;
+	}
+	return ret;
+}
+
+static inline void rtl8169_set_desc_dma_addr(struct rtl8169_private *tp,
+					     struct RxDesc *desc,
+					     dma_addr_t mapping)
+{
+	desc->addr = cpu_to_le64(mapping);
+}
+
+static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
+		  struct rtl8169_rx_ring *ring, int budget)
 {
 	struct device *d = tp_to_dev(tp);
 	int count;
 
-	for (count = 0; count < budget; count++, tp->cur_rx++) {
-		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
-		struct RxDesc *desc = tp->RxDescArray + entry;
+	for (count = 0; count < budget; count++, ring->cur_rx++) {
+		unsigned int pkt_size, entry = ring->cur_rx % ring->num_rx_desc;
+		struct RxDesc *desc = ring->RxDescArray + entry;
 		struct sk_buff *skb;
 		const void *rx_buf;
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(READ_ONCE(desc->opts1));
-		if (status & DescOwn)
-			break;
+		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
+
+		if (status & DescOwn) {
+			if (!tp->recheck_desc_ownbit)
+				break;
+
+			tp->recheck_desc_ownbit = false;
+			rtl8169_desc_quirk(tp);
+			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
+			if (status & DescOwn)
+				break;
+		}
 
 		/* This barrier is needed to keep us from reading
 		 * any other fields out of the Rx descriptor until
@@ -5066,20 +5220,15 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		 */
 		dma_rmb();
 
-		if (unlikely(status & RxRES)) {
+		if (rtl8169_check_rx_desc_error(dev, tp, status) < 0) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
 					    status);
+
 			dev->stats.rx_errors++;
-			if (status & (RxRWT | RxRUNT))
-				dev->stats.rx_length_errors++;
-			if (status & RxCRC)
-				dev->stats.rx_crc_errors++;
 
 			if (!(dev->features & NETIF_F_RXALL))
 				goto release_descriptor;
-			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
-				goto release_descriptor;
 		}
 
 		pkt_size = status & GENMASK(13, 0);
@@ -5095,14 +5244,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->r8169napi[0].napi, pkt_size);
+		skb = napi_alloc_skb(&tp->r8169napi[ring->index].napi, pkt_size);
 		if (unlikely(!skb)) {
 			dev->stats.rx_dropped++;
 			goto release_descriptor;
 		}
 
-		addr = le64_to_cpu(desc->addr);
-		rx_buf = page_address(tp->Rx_databuff[entry]);
+		addr = ring->RxDescPhyAddr[entry];
+		rx_buf = page_address(ring->Rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
@@ -5111,7 +5260,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
-		rtl8169_rx_csum(skb, status);
+		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
 		rtl8169_rx_vlan_tag(desc, skb);
@@ -5119,11 +5268,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->r8169napi[0].napi, skb);
+		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_mark_to_asic(desc);
+		rtl8169_set_desc_dma_addr(tp, desc, ring->RxDescPhyAddr[entry]);
+		dma_wmb();
+		rtl8169_mark_to_asic(tp, desc);
 	}
 
 	return count;
@@ -5239,7 +5390,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	for (int i = 0; i < tp->num_tx_rings; i++)
 		rtl_tx(dev, tp, &tp->tx_ring[i], budget);
 
-	work_done = rtl_rx(dev, tp, budget);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5371,16 +5523,16 @@ static int rtl8169_close(struct net_device *dev)
 	netif_stop_queue(dev);
 
 	rtl8169_down(tp);
-	rtl8169_rx_clear(tp);
 
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 
 	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	tp->RxDescArray = NULL;
+	rtl8169_free_rx_desc(tp);
+
 	rtl8169_free_tx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
@@ -5411,11 +5563,12 @@ static int rtl_open(struct net_device *dev)
 	 * dma_alloc_coherent provides more.
 	 */
 
-	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
-					     &tp->RxPhyAddr, GFP_KERNEL);
 	if (rtl8169_alloc_tx_desc(tp) < 0)
 		goto err_free_tx_0;
 
+	if (rtl8169_alloc_rx_desc(tp) < 0)
+		goto err_free_rx_1;
+
 	retval = rtl8169_init_ring(tp);
 	if (retval < 0)
 		goto err_free_rx_1;
@@ -5444,11 +5597,10 @@ static int rtl_open(struct net_device *dev)
 	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 err_free_rx_1:
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	tp->RxDescArray = NULL;
+	rtl8169_free_rx_desc(tp);
 err_free_tx_0:
 	rtl8169_free_tx_desc(tp);
 	goto out;
-- 
2.43.0



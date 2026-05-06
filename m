Return-Path: <netdev+bounces-284745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH2WI2f4+mnjUwMAu9opvQ
	(envelope-from <netdev+bounces-284745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:14:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED414D7B92
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 10:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F2D2301933E
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE163E3D85;
	Wed,  6 May 2026 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="EDqd3tJ5"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA33E123A;
	Wed,  6 May 2026 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055249; cv=none; b=BbK2K1VxbHs5PhKjMOFo0pes5DOKBYNMKyPEkRNIkXrP7vdzoBeE7Keux5/dfeEKYRwNBb6IeZT878cHO8zwHADfjCbzYKnFcXyy0cWhh/XLVZPDEIsIgx2Qc4f4iigwTeUVyIKSruuCO+Mt5ZtX2kS0RHhfYueiuCZ5HW9jYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055249; c=relaxed/simple;
	bh=kHPKdduqxf6Q5JsPLrY+FhxD3xEgvrCiQ67Hyxevmlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyN1gNzrzc+wzoxJgREjlijT9miAjTHdxG65HWdhLT9Otv6WEgyqHrlX9qcuMCXw+Za22jfikzVXmdja9mt7qjQTjYIUlMDXVqgZ8/8ynrWvs6P/iMGBQG6CT7Yn7w3SBl1fW+l23zGQdp2u+IWE+c/hpIJudWGPrvPDL5qHVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=EDqd3tJ5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6468DTnsC1854043, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778055210;
	bh=//M5V8hMfKpit/JPmk2oHYg6ZclHr0AUDLEcKiwc5Ao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=EDqd3tJ5Uq8KZ+z9c85BU/9zjsfdPErhTf+BaaUBuv97DE0R9ZzvwFFb0sJ4R+DME
	 musvum1C79o1eHQWBjyne2Sp7QqTAM+uyvdZ2eFIaTB+QmW8Au2MfZ7ZNLROCRN3UI
	 3SCe0xPtqAGhds34RxO5GDpwlmi/OLnI2J3sp9CIj6x5KiMPkSoAoPWjp0Ik4cnPuC
	 F9ew3zHsd/IU569eZXkvIVe3Jw6M9yz4I7DxrEvjtIFiztFgohlbEkGGLFtXAyrUYY
	 zJpNV8xr6CiJSAQTg33gkrS7niF5cTWrW1MsZHcc3KeHJcYjxgdkjlZ33ryyq+Gkkl
	 mEs6uNZXD0xUQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 6468DTnsC1854043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 May 2026 16:13:29 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 6 May 2026 16:13:29 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 6 May 2026 16:13:29 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v1 2/7] r8169: add support for multi rx queues
Date: Wed, 6 May 2026 16:13:20 +0800
Message-ID: <20260506081326.767-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260506081326.767-1-javen_xu@realsil.com.cn>
References: <20260506081326.767-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 8ED414D7B92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-284745-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:dkim,realsil.com.cn:mid]

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for multi rx queues. RSS requires multi rx
queues to receive packets. So we need struct rtl8169_rx_ring for each
queue.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 318 +++++++++++++++++-----
 1 file changed, 251 insertions(+), 67 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ef74ee02c117..bc75dbb9901d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -74,10 +74,11 @@
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
 #define R8169_MAX_MSIX_VEC	32
+#define R8127_MAX_RX_QUEUES	8
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -447,6 +448,7 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	RDSAR_Q1_LOW		= 0x4000,
 };
 
 #define LEDSEL_MASK_8125	0x23f
@@ -731,6 +733,19 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_rx_ring {
+	u32 index;					/* Rx queue index */
+	u32 cur_rx;					/* Index of next Rx pkt. */
+	u32 dirty_rx;					/* Index for recycling. */
+	u32 num_rx_desc;				/* num of Rx desc */
+	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
+	u32 rx_desc_alloc_size;				/* memory size per descs of ring */
+	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
+	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
+	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
+	u16 rdsar_reg;					/* Receive Descriptor Start Address */
+};
+
 struct rtl8169_napi {
 	struct napi_struct napi;
 	void *priv;
@@ -744,6 +759,13 @@ struct rtl8169_irq {
 	char		name[IFNAMSIZ + 10];
 };
 
+enum rx_desc_ring_type {
+	RX_DESC_RING_TYPE_UNKNOWN = 0,
+	RX_DESC_RING_TYPE_DEFAULT,
+	RX_DESC_RING_TYPE_RSS,
+	RX_DESC_RING_TYPE_MAX
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -752,28 +774,28 @@ struct rtl8169_private {
 	struct napi_struct napi;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
-	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
 	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
-	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
 	dma_addr_t TxPhyAddr;
-	dma_addr_t RxPhyAddr;
-	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
 	struct rtl8169_irq irq_tbl[R8169_MAX_MSIX_VEC];
 	struct rtl8169_napi r8169napi[R8169_MAX_MSIX_VEC];
+	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
 	u16 isr_reg[R8169_MAX_MSIX_VEC];
 	u16 imr_reg[R8169_MAX_MSIX_VEC];
 	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	u16 hw_supp_num_rx_queues;
 	u8 min_irq_nvecs;
 	u8 max_irq_nvecs;
 	u8 hw_supp_isr_ver;
 	u8 hw_curr_isr_ver;
 	u8 irq_nvecs;
+	u8 init_rx_desc_type;
+	u8 recheck_desc_ownbit;
 	int irq;
 	struct clk *clk;
 
@@ -2647,9 +2669,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_desc_array, 0x0, ring->rx_desc_alloc_size);
+	}
+}
+
 static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 {
-	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+	tp->dirty_tx = 0;
+	tp->cur_tx = 0;
+
+	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		ring->dirty_rx = 0;
+		ring->cur_rx = 0;
+		ring->index = i;
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2708,8 +2748,18 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl_set_ring_size(struct rtl8169_private *tp, u32 rx_num)
+{
+	for (int i = 0; i < tp->hw_supp_num_rx_queues; i++)
+		tp->rx_ring[i].num_rx_desc = rx_num;
+}
+
 static void rtl_setup_mqs_reg(struct rtl8169_private *tp)
 {
+	tp->rx_ring[0].rdsar_reg = RxDescAddrLow;
+	for (int i = 1; i < tp->hw_supp_num_rx_queues; i++)
+		tp->rx_ring[i].rdsar_reg = (u16)(RDSAR_Q1_LOW + (i - 1) * 8);
+
 	if (tp->mac_version <= RTL_GIGA_MAC_VER_52) {
 		tp->isr_reg[0] = IntrStatus;
 		tp->imr_reg[0] = IntrMask;
@@ -2733,17 +2783,21 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_80:
 		tp->min_irq_nvecs = 1;
 		tp->max_irq_nvecs = 1;
+		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
 		tp->hw_supp_isr_ver = 6;
 		break;
 	default:
 		tp->min_irq_nvecs = 1;
 		tp->max_irq_nvecs = 1;
+		tp->hw_supp_num_rx_queues = 1;
 		tp->hw_supp_isr_ver = 1;
 		break;
 	}
+	tp->init_rx_desc_type = RX_DESC_RING_TYPE_DEFAULT;
 	tp->hw_curr_isr_ver = tp->hw_supp_isr_ver;
 
 	rtl_setup_mqs_reg(tp);
+	rtl_set_ring_size(tp, NUM_RX_DESC);
 }
 
 static void rtl_request_firmware(struct rtl8169_private *tp)
@@ -2877,8 +2931,13 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 */
 	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
 	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		RTL_W32(tp, ring->rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
+		RTL_W32(tp, ring->rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4214,7 +4273,7 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic_default(struct RxDesc *desc)
 {
 	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
 
@@ -4224,13 +4283,19 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
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
+	struct RxDesc *desc = ring->rx_desc_array + index;
 
 	data = alloc_pages_node(node, GFP_KERNEL, get_order(R8169_RX_BUF_SIZE));
 	if (!data)
@@ -4244,55 +4309,111 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	desc->addr = cpu_to_le64(mapping);
-	rtl8169_mark_to_asic(desc);
+	ring->rx_desc_phy_addr[index] = mapping;
+	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
 }
 
-static void rtl8169_rx_clear(struct rtl8169_private *tp)
+static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
-	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
+	for (i = 0; i < NUM_RX_DESC && ring->rx_databuff[i]; i++) {
 		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
+			       ring->rx_desc_phy_addr[i],
 			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
-		tp->Rx_databuff[i] = NULL;
-		tp->RxDescArray[i].addr = 0;
-		tp->RxDescArray[i].opts1 = 0;
+		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+		ring->rx_databuff[i] = NULL;
+		ring->rx_desc_phy_addr[i] = 0;
+		ring->rx_desc_array[i].addr = 0;
+		ring->rx_desc_array[i].opts1 = 0;
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
+		ring->rx_databuff[i] = data;
 	}
 
 	/* mark as last descriptor in the ring */
-	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
+
+	return 0;
+}
+
+static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
 
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		ring->rx_desc_alloc_size = (ring->num_rx_desc + 1) * sizeof(struct RxDesc);
+		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
+							 ring->rx_desc_alloc_size,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array)
+			return -1;
+	}
 	return 0;
 }
 
+static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
+{
+	struct rtl8169_rx_ring *ring;
+	struct pci_dev *pdev = tp->pci_dev;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		if (ring->rx_desc_array) {
+			dma_free_coherent(&pdev->dev,
+					  ring->rx_desc_alloc_size,
+					  ring->rx_desc_array,
+					  ring->rx_phy_addr);
+			ring->rx_desc_array = NULL;
+		}
+	}
+}
+
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	int retval = 0;
+
 	rtl8169_init_ring_indexes(tp);
+	rtl8169_rx_desc_init(tp);
 
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
-	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
-	return rtl8169_rx_fill(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
+		retval = rtl8169_rx_fill(tp, ring);
+	}
+
+	return retval;
 }
 
 static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
@@ -4381,16 +4502,24 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 	rtl8169_init_ring_indexes(tp);
 }
 
-static void rtl_reset_work(struct rtl8169_private *tp)
+static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 {
-	int i;
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
+		for (int j = 0; j < ring->num_rx_desc; j++)
+			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
+	}
+}
+
+static void rtl_reset_work(struct rtl8169_private *tp)
+{
 	netif_stop_queue(tp->dev);
 
 	rtl8169_cleanup(tp);
 
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	rtl8169_rx_desc_reset(tp);
+
 	rtl8169_napi_enable(tp);
 
 	rtl_hw_start(tp);
@@ -4784,6 +4913,11 @@ static void rtl8169_pcierr_interrupt(struct net_device *dev)
 	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 }
 
+static void rtl8169_desc_quirk(struct rtl8169_private *tp)
+{
+	RTL_R8(tp, tp->imr_reg[0]);
+}
+
 static void rtl_tx(struct net_device *dev, struct rtl8169_private *tp,
 		   int budget)
 {
@@ -4836,9 +4970,11 @@ static inline int rtl8169_fragmented_frame(u32 status)
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
@@ -4846,22 +4982,71 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
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
+static bool rtl8169_check_rx_desc_error(struct net_device *dev,
+					struct rtl8169_private *tp,
+					u32 status)
+{
+	if (unlikely(status & RxRES)) {
+		if (status & (RxRWT | RxRUNT))
+			dev->stats.rx_length_errors++;
+		if (status & RxCRC)
+			dev->stats.rx_crc_errors++;
+		return true;
+	}
+	return false;
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
+		struct RxDesc *desc = ring->rx_desc_array + entry;
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
+			/* Workaround for a hardware issue:
+			 * Hardware might trigger RX interrupt before the DMA
+			 * engine fully updates RX desc ownbit in host memory.
+			 * So we do a quirk and re-read to avoid missing RX
+			 * packets.
+			 */
+			tp->recheck_desc_ownbit = false;
+			rtl8169_desc_quirk(tp);
+			status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
+			if (status & DescOwn)
+				break;
+		}
 
 		/* This barrier is needed to keep us from reading
 		 * any other fields out of the Rx descriptor until
@@ -4869,20 +5054,15 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		 */
 		dma_rmb();
 
-		if (unlikely(status & RxRES)) {
+		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
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
@@ -4898,14 +5078,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
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
+		addr = ring->rx_desc_phy_addr[entry];
+		rx_buf = page_address(ring->rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
@@ -4914,7 +5094,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
-		rtl8169_rx_csum(skb, status);
+		rtl8169_rx_csum(tp, skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
 		rtl8169_rx_vlan_tag(desc, skb);
@@ -4922,11 +5102,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->r8169napi[0].napi, skb);
+		napi_gro_receive(&tp->r8169napi[ring->index].napi, skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_mark_to_asic(desc);
+		rtl8169_set_desc_dma_addr(tp, desc, ring->rx_desc_phy_addr[entry]);
+		rtl8169_mark_to_asic(tp, desc);
 	}
 
 	return count;
@@ -4952,6 +5133,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
+	tp->recheck_desc_ownbit = true;
 	napi_schedule(&napi->napi);
 out:
 	rtl_ack_events(tp, status);
@@ -5040,7 +5222,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5168,21 +5351,21 @@ static int rtl8169_close(struct net_device *dev)
 	struct pci_dev *pdev = tp->pci_dev;
 
 	pm_runtime_get_sync(&pdev->dev);
-
 	netif_stop_queue(dev);
+
 	rtl8169_down(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 
 	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
 	tp->TxDescArray = NULL;
-	tp->RxDescArray = NULL;
+
+	rtl8169_free_rx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5211,16 +5394,15 @@ static int rtl_open(struct net_device *dev)
 	 * Rx and Tx descriptors needs 256 bytes alignment.
 	 * dma_alloc_coherent provides more.
 	 */
+
 	tp->TxDescArray = dma_alloc_coherent(&pdev->dev, R8169_TX_RING_BYTES,
 					     &tp->TxPhyAddr, GFP_KERNEL);
 	if (!tp->TxDescArray)
-		goto out;
-
-	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
-					     &tp->RxPhyAddr, GFP_KERNEL);
-	if (!tp->RxDescArray)
 		goto err_free_tx_0;
 
+	if (rtl8169_alloc_rx_desc(tp) < 0)
+		goto err_free_rx_1;
+
 	retval = rtl8169_init_ring(tp);
 	if (retval < 0)
 		goto err_free_rx_1;
@@ -5249,11 +5431,10 @@ static int rtl_open(struct net_device *dev)
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
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
@@ -5767,7 +5948,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 txconfig;
 	u32 xid;
 
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
+				      1,
+				      R8169_MAX_RX_QUEUES);
+
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.43.0



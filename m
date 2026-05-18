Return-Path: <netdev+bounces-289011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAFCFBb3CmpZ+QQAu9opvQ
	(envelope-from <netdev+bounces-289011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:25:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2E56B7FB
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A365302A4E7
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F33F6C4E;
	Mon, 18 May 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="k6qdrJsZ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5A3EE1DC;
	Mon, 18 May 2026 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103193; cv=none; b=oW8646kEpITWrkPO9xKBlAIKm6Kz5KE3YjggifamHGPJLaj6C3BfPk0nvlaZZmX6duygNeey3Px3iSilO9ipASbflVpFtonwTJjy4PfCkyJAwGPEzkkzE9wxitoC1osOdM6k3U/LIQVOCLG5UDGPf/h0EZaWsiYcodZkDSOj49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103193; c=relaxed/simple;
	bh=MRfLksKYpcfKvMjpZXpL1ZALbragUzfYKCGk8Lx9QY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCtq8NBM3Eh3yXcyBPg4UIBoxb7u4MoBeOzWNjTFpDcDpwZmVrdwq39fHYNWEXwMgs7uf9zij5tzZaPugXVRosvSD+Q3DlBDjyyket8LWa+c/RMAVeiDEgchaMP1rP+diuWTH36PdvgRA2v8EPziVA+qPaywa/VzxjMUGBu5pZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=k6qdrJsZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64IBJFIy81831616, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1779103155;
	bh=apwHzhExcAIZzj7vNvasWchSuxrIRe+rKoXy30RoyOE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=k6qdrJsZDwnH80XPhxZAepaWofs22kbhstPckABpA0EH9BGfk8InHPzNx1z6qvJjn
	 N15jB1WOWLaERTDTIrMc+SDfA98MYuwbOnDaZt8KeiNQNpwLXdZewjcQFsbDmteteJ
	 cC9ebCyf7YqWGfObRj+/GCvVd4n3As2uDlNbzHT0C+cUBEg34bukjg7YaukbKPp9/9
	 orjz6Wv1hrW2l7MIGoPl7IzzBbKEE0e14OhmV/J/mNTalHc5r0ezvxeLDzsnP5gM4d
	 KV1gjA+q0eB3E3Rp15dE6XeDe1DVGCRDOtys+CrEJcvrUwSDhnA8t5A/yy6KCverwL
	 VjWedbW8zy1FQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64IBJFIy81831616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 May 2026 19:19:15 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 19:19:14 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 18 May 2026 19:19:14 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v4 2/7] r8169: add support for multi rx queues
Date: Mon, 18 May 2026 19:19:06 +0800
Message-ID: <20260518111912.1603-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260518111912.1603-1-javen_xu@realsil.com.cn>
References: <20260518111912.1603-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: C1B2E56B7FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-289011-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email,realsil.com.cn:mid,realsil.com.cn:dkim]
X-Rspamd-Action: no action

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support for multi rx queues. RSS requires multi rx
queues to receive packets. So we need struct rtl8169_rx_ring for each
queue.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - sort some registers by its number
 - remove some unused definitions, like RX_DESC_RING_TYPE_MAX
 - change recheck_desc_ownbit type
 - remove rdsar_reg in rx_ring struct
 - opts1 are different in rx_desc and rx_desc_rss, move the judgement
   to Patch 5/7

Changes in v3:
 - remove ring->rx_desc_alloc_size, use constant instead

Changes in v4:
 - change rdsar_reg type to unsigned int
 - follow reverse xmas tree, in rtl_set_rx_tx_desc_registers(),
   rtl8169_alloc_rx_data(), rtl8169_alloc_rx_desc(),
   rtl8169_free_rx_desc()
 - add comments on LED_CTRL, remove helper function
---
 drivers/net/ethernet/realtek/r8169_main.c | 260 ++++++++++++++++------
 1 file changed, 197 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 48fcfff8f4ea..4e621c5d8ac7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -74,10 +74,13 @@
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
+#define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
 #define R8169_MAX_MSIX_VEC	32
+#define R8127_MAX_RX_QUEUES	8
+#define R8169_DEFAULT_RX_QUEUES	1
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -444,6 +447,7 @@ enum rtl8125_registers {
 	TxPoll_8125		= 0x90,
 	LEDSEL3			= 0x96,
 	MAC0_BKP		= 0x19e0,
+	RDSAR_Q1_LOW		= 0x4000,
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
@@ -736,6 +740,21 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rx_desc_ring_type {
+	RX_DESC_RING_TYPE_DEFAULT,
+	RX_DESC_RING_TYPE_RSS,
+};
+
+struct rtl8169_rx_ring {
+	u32 index;					/* Rx queue index */
+	u32 cur_rx;					/* Index of next Rx pkt. */
+	u32 dirty_rx;					/* Index for recycling. */
+	struct RxDesc *rx_desc_array;			/* array of Rx Desc*/
+	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];	/* Rx data buffer physical dma address */
+	dma_addr_t rx_phy_addr;				/* Rx desc physical address */
+	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -743,20 +762,18 @@ struct rtl8169_private {
 	struct phy_device *phydev;
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
 	struct napi_struct *rtl8169_napi;
+	struct rtl8169_rx_ring rx_ring[R8169_MAX_RX_QUEUES];
 	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	unsigned int hw_supp_num_rx_queues;
 	enum rtl_isr_version hw_curr_isr_ver;
 	u8 irq_nvecs;
 	int irq;
@@ -2633,9 +2650,27 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_desc_array, 0x0, R8169_RX_RING_BYTES);
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
@@ -2700,9 +2735,11 @@ static void rtl_software_parameter_initialize(struct rtl8169_private *tp)
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
+		tp->hw_supp_num_rx_queues = R8127_MAX_RX_QUEUES;
 		tp->hw_curr_isr_ver = RTL_ISR_VER_8127;
 		break;
 	default:
+		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
 		tp->hw_curr_isr_ver = RTL_ISR_VER_DEFAULT;
 		break;
 	}
@@ -2832,6 +2869,8 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 
 static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 {
+	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
+
 	/*
 	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
 	 * register to be written before TxDescAddrLow to work.
@@ -2839,8 +2878,16 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 */
 	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
 	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+	RTL_W32(tp, RxDescAddrHigh, ((u64) ring->rx_phy_addr) >> 32);
+	RTL_W32(tp, RxDescAddrLow, ((u64) ring->rx_phy_addr) & DMA_BIT_MASK(32));
+
+	for (int i = 1; i < tp->num_rx_rings; i++) {
+		unsigned int rdsar_reg = RDSAR_Q1_LOW + (i - 1) * 8;
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		RTL_W32(tp, rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
+		RTL_W32(tp, rdsar_reg, ((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4187,8 +4234,9 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					  struct RxDesc *desc)
+					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
+	struct RxDesc *desc = ring->rx_desc_array + index;
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
@@ -4206,55 +4254,100 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	desc->addr = cpu_to_le64(mapping);
+	ring->rx_desc_phy_addr[index] = mapping;
 	rtl8169_mark_to_asic(desc);
 
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
+	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
 
 	return 0;
 }
 
+static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct rtl8169_rx_ring *ring;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
+							 R8169_RX_RING_BYTES,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array)
+			return -1;
+	}
+	return 0;
+}
+
+static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct rtl8169_rx_ring *ring;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		if (ring->rx_desc_array) {
+			dma_free_coherent(&pdev->dev,
+					  R8169_RX_RING_BYTES,
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
@@ -4343,16 +4436,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 	rtl8169_init_ring_indexes(tp);
 }
 
-static void rtl_reset_work(struct rtl8169_private *tp)
+static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 {
-	int i;
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
+		for (int j = 0; j < NUM_RX_DESC; j++)
+			rtl8169_mark_to_asic(ring->rx_desc_array + j);
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
 
 	rtl8169_napi_enable(tp);
 	rtl_hw_start(tp);
@@ -4798,9 +4898,10 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
+static inline void rtl8169_rx_csum(struct sk_buff *skb,
+				   struct RxDesc *desc)
 {
-	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
+	u32 status = le32_to_cpu(desc->opts1) & (RxProtoMask | RxCSFailMask);
 
 	if (status == RxProtoTCP || status == RxProtoUDP)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -4808,22 +4909,60 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
-static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget)
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
+static void rtl8169_set_desc_dma_addr(struct RxDesc *desc,
+				      dma_addr_t mapping)
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
+		unsigned int pkt_size, entry = ring->cur_rx % NUM_RX_DESC;
+		struct RxDesc *desc = ring->rx_desc_array + entry;
 		struct sk_buff *skb;
 		const void *rx_buf;
 		dma_addr_t addr;
 		u32 status;
 
 		status = le32_to_cpu(READ_ONCE(desc->opts1));
-		if (status & DescOwn)
-			break;
+
+		if (status & DescOwn) {
+			if (!tp->recheck_desc_ownbit)
+				break;
+
+			/* Workaround for a hardware issue:
+			 * A dummy read to any register forces a PCIe flush. We
+			 * choose LED_CTRL here simply because reading it has no
+			 * side effects. This ensures the descriptor ownbit is
+			 * fully updated in RAM before we recheck it, preventing
+			 * from missing RX packets right before exiting NAPI
+			 * polling loop.
+			 */
+			tp->recheck_desc_ownbit = false;
+			RTL_R8(tp, LED_CTRL);
+			status = le32_to_cpu(READ_ONCE(desc->opts1));
+			if (status & DescOwn)
+				break;
+		}
 
 		/* This barrier is needed to keep us from reading
 		 * any other fields out of the Rx descriptor until
@@ -4831,20 +4970,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		 */
 		dma_rmb();
 
-		if (unlikely(status & RxRES)) {
+		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
 					    status);
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
@@ -4860,14 +4993,14 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 			goto release_descriptor;
 		}
 
-		skb = napi_alloc_skb(&tp->rtl8169_napi[0], pkt_size);
+		skb = napi_alloc_skb(&tp->rtl8169_napi[ring->index], pkt_size);
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
@@ -4876,7 +5009,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
-		rtl8169_rx_csum(skb, status);
+		rtl8169_rx_csum(skb, desc);
 		skb->protocol = eth_type_trans(skb, dev);
 
 		rtl8169_rx_vlan_tag(desc, skb);
@@ -4884,10 +5017,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp, int budget
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
 
-		napi_gro_receive(&tp->rtl8169_napi[0], skb);
+		napi_gro_receive(&tp->rtl8169_napi[ring->index], skb);
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
+		rtl8169_set_desc_dma_addr(desc, ring->rx_desc_phy_addr[entry]);
 		rtl8169_mark_to_asic(desc);
 	}
 
@@ -4917,6 +5051,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		phy_mac_interrupt(tp->phydev);
 
 	rtl_irq_disable(tp);
+	tp->recheck_desc_ownbit = true;
 	napi_schedule(napi);
 out:
 	rtl_ack_events(tp, status);
@@ -4992,7 +5127,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[i], budget);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5120,21 +5256,19 @@ static int rtl8169_close(struct net_device *dev)
 	struct pci_dev *pdev = tp->pci_dev;
 
 	pm_runtime_get_sync(&pdev->dev);
-
 	netif_stop_queue(dev);
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
+	rtl8169_free_rx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5165,13 +5299,11 @@ static int rtl_open(struct net_device *dev)
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
@@ -5198,11 +5330,10 @@ static int rtl_open(struct net_device *dev)
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
@@ -5705,7 +5836,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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



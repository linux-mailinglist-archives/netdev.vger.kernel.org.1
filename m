Return-Path: <netdev+bounces-98245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D39B8D04C5
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 16:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C6A29092B
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ABB17B42E;
	Mon, 27 May 2024 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="OLD9Gj1w"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617E017B408;
	Mon, 27 May 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819737; cv=none; b=WKmM1jZ0cu5T6xXsoDE9e4aykCWxs8LZ+MK/65v4V/4v19IAiFp/Bg4T7pwP6lqBy7rtgHWSbB5N1OS6ZrTv4whmRI5t66I1uLvBnws/4NOD/U3oReXHSg09tdt42pc9D2dBU4FvQA1AfztIhxXPDUn+qJQlHd8f0zCmFm3w/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819737; c=relaxed/simple;
	bh=7Pc+Vo3FNBYgK2OpLuaRpDRsNyAMhdPFi4gM1pbAazw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EzcewGhHAYfBGthDzIIOs8smsIpAJHXD4Nlm8hMTI3F3WPbHITtgyXGMEMLCEOiTspt2achQZNYuSzViIGDW5gxD+vxkOanduafGzUInorx6QIljP96+VtdHY5NBcavKqq6AxkXqQemf0AGNfCvqAwtce0Ewu8X65exrlvugssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=OLD9Gj1w; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 3688260415;
	Mon, 27 May 2024 14:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1716819731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hiOQ8/ye/TAlumJArsn1YKtZ+Y0SMuYKwQl/8eLNSX4=;
	b=OLD9Gj1wgQoy8RQ9C5N9q1VKaejTAVsQYXgo5m89XFj1Gv0Gi8stniepnea8ef8RRN8B4O
	Z9Z6cC15RCp5UCpS2pVQQE+lwTL9w3U3aGq3oX1UTDLQ291Vpfhu19ZQrknpDZ6dkynSdM
	bmE3+yt3iyLHCbo90ps4Qu5nSbJ9BOU=
Received: from frank-G5.. (fttx-pool-217.61.154.6.bambit.de [217.61.154.6])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 2125836014D;
	Mon, 27 May 2024 14:22:10 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net v2] net: ethernet: mtk_eth_soc: handle dma buffer size soc specific
Date: Mon, 27 May 2024 16:21:42 +0200
Message-Id: <20240527142142.126796-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 909db082-f0a2-4ba0-9a81-10d1f1ce0d2f

From: Frank Wunderlich <frank-w@public-files.de>

The mainline MTK ethernet driver suffers long time from rarly but
annoying tx queue timeouts. We think that this is caused by fixed
dma sizes hardcoded for all SoCs.

Use the dma-size implementation from SDK in a per SoC manner.

Fixes: 656e705243fd ("net-next: mediatek: add support for MT7623 ethernet")
Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
sorry for multiple posting in first version

based on SDK:

https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/fac194d6253d339e15c651c052b532a449a04d6e

v2:
- fix unused variable 'addr' in 32bit build
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 105 +++++++++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   9 +-
 2 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index cae46290a7ae..f1ff1be73926 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1131,9 +1131,9 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 {
 	const struct mtk_soc_data *soc = eth->soc;
 	dma_addr_t phy_ring_tail;
-	int cnt = MTK_QDMA_RING_SIZE;
+	int cnt = soc->tx.fq_dma_size;
 	dma_addr_t dma_addr;
-	int i;
+	int i, j, len;
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
 		eth->scratch_ring = eth->sram_base;
@@ -1142,40 +1142,46 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 						       cnt * soc->tx.desc_size,
 						       &eth->phy_scratch_ring,
 						       GFP_KERNEL);
+
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
 
-	eth->scratch_head = kcalloc(cnt, MTK_QDMA_PAGE_SIZE, GFP_KERNEL);
-	if (unlikely(!eth->scratch_head))
-		return -ENOMEM;
+	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
 
-	dma_addr = dma_map_single(eth->dma_dev,
-				  eth->scratch_head, cnt * MTK_QDMA_PAGE_SIZE,
-				  DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
-		return -ENOMEM;
+	for (j = 0; j < DIV_ROUND_UP(soc->tx.fq_dma_size, MTK_FQ_DMA_LENGTH); j++) {
+		len = min_t(int, cnt - j * MTK_FQ_DMA_LENGTH, MTK_FQ_DMA_LENGTH);
+		eth->scratch_head[j] = kcalloc(len, MTK_QDMA_PAGE_SIZE, GFP_KERNEL);
 
-	phy_ring_tail = eth->phy_scratch_ring + soc->tx.desc_size * (cnt - 1);
+		if (unlikely(!eth->scratch_head[j]))
+			return -ENOMEM;
 
-	for (i = 0; i < cnt; i++) {
-		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
-		struct mtk_tx_dma_v2 *txd;
+		dma_addr = dma_map_single(eth->dma_dev,
+					  eth->scratch_head[j], len * MTK_QDMA_PAGE_SIZE,
+					  DMA_FROM_DEVICE);
 
-		txd = eth->scratch_ring + i * soc->tx.desc_size;
-		txd->txd1 = addr;
-		if (i < cnt - 1)
-			txd->txd2 = eth->phy_scratch_ring +
-				    (i + 1) * soc->tx.desc_size;
+		if (unlikely(dma_mapping_error(eth->dma_dev, dma_addr)))
+			return -ENOMEM;
 
-		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
-		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
-			txd->txd3 |= TX_DMA_PREP_ADDR64(addr);
-		txd->txd4 = 0;
-		if (mtk_is_netsys_v2_or_greater(eth)) {
-			txd->txd5 = 0;
-			txd->txd6 = 0;
-			txd->txd7 = 0;
-			txd->txd8 = 0;
+		for (i = 0; i < cnt; i++) {
+			struct mtk_tx_dma_v2 *txd;
+
+			txd = eth->scratch_ring + (j * MTK_FQ_DMA_LENGTH + i) * soc->tx.desc_size;
+			txd->txd1 = dma_addr + i * MTK_QDMA_PAGE_SIZE;
+			if (j * MTK_FQ_DMA_LENGTH + i < cnt)
+				txd->txd2 = eth->phy_scratch_ring +
+					    (j * MTK_FQ_DMA_LENGTH + i + 1) * soc->tx.desc_size;
+
+			txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
+			if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
+				txd->txd3 |= TX_DMA_PREP_ADDR64(dma_addr + i * MTK_QDMA_PAGE_SIZE);
+
+			txd->txd4 = 0;
+			if (mtk_is_netsys_v2_or_greater(eth)) {
+				txd->txd5 = 0;
+				txd->txd6 = 0;
+				txd->txd7 = 0;
+				txd->txd8 = 0;
+			}
 		}
 	}
 
@@ -2457,7 +2463,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (MTK_HAS_CAPS(soc->caps, MTK_QDMA))
 		ring_size = MTK_QDMA_RING_SIZE;
 	else
-		ring_size = MTK_DMA_SIZE;
+		ring_size = soc->tx.dma_size;
 
 	ring->buf = kcalloc(ring_size, sizeof(*ring->buf),
 			       GFP_KERNEL);
@@ -2465,8 +2471,8 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 		goto no_tx_mem;
 
 	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
-		ring->dma = eth->sram_base + ring_size * sz;
-		ring->phys = eth->phy_scratch_ring + ring_size * (dma_addr_t)sz;
+		ring->dma = eth->sram_base + soc->tx.fq_dma_size * sz;
+		ring->phys = eth->phy_scratch_ring + soc->tx.fq_dma_size * (dma_addr_t)sz;
 	} else {
 		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
 					       &ring->phys, GFP_KERNEL);
@@ -2588,6 +2594,7 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
+	const struct mtk_soc_data *soc = eth->soc;
 	struct mtk_rx_ring *ring;
 	int rx_data_len, rx_dma_size, tx_ring_size;
 	int i;
@@ -2595,7 +2602,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
 		tx_ring_size = MTK_QDMA_RING_SIZE;
 	else
-		tx_ring_size = MTK_DMA_SIZE;
+		tx_ring_size = soc->tx.dma_size;
 
 	if (rx_flag == MTK_RX_FLAGS_QDMA) {
 		if (ring_no)
@@ -2610,7 +2617,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		rx_dma_size = MTK_HW_LRO_DMA_SIZE;
 	} else {
 		rx_data_len = ETH_DATA_LEN;
-		rx_dma_size = MTK_DMA_SIZE;
+		rx_dma_size = soc->rx.dma_size;
 	}
 
 	ring->frag_size = mtk_max_frag_size(rx_data_len);
@@ -3139,7 +3146,10 @@ static void mtk_dma_free(struct mtk_eth *eth)
 			mtk_rx_clean(eth, &eth->rx_ring[i], false);
 	}
 
-	kfree(eth->scratch_head);
+	for (i = 0; i < DIV_ROUND_UP(soc->tx.fq_dma_size, MTK_FQ_DMA_LENGTH); i++) {
+		kfree(eth->scratch_head[i]);
+		eth->scratch_head[i] = NULL;
+	}
 }
 
 static bool mtk_hw_reset_check(struct mtk_eth *eth)
@@ -5052,11 +5062,14 @@ static const struct mtk_soc_data mt2701_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
+		.dma_size = MTK_DMA_SIZE(2K),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5076,11 +5089,14 @@ static const struct mtk_soc_data mt7621_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
+		.dma_size = MTK_DMA_SIZE(2K),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5102,11 +5118,14 @@ static const struct mtk_soc_data mt7622_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
+		.dma_size = MTK_DMA_SIZE(2K),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5127,11 +5146,14 @@ static const struct mtk_soc_data mt7623_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
+		.dma_size = MTK_DMA_SIZE(2K),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5150,11 +5172,14 @@ static const struct mtk_soc_data mt7629_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
 		.irq_done_mask = MTK_RX_DONE_INT,
 		.dma_l4_valid = RX_DMA_L4_VALID,
+		.dma_size = MTK_DMA_SIZE(2K),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
 	},
@@ -5176,6 +5201,8 @@ static const struct mtk_soc_data mt7981_data = {
 		.desc_size = sizeof(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
+		.dma_size = MTK_DMA_SIZE(4K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
@@ -5183,6 +5210,7 @@ static const struct mtk_soc_data mt7981_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(1K),
 	},
 };
 
@@ -5202,6 +5230,8 @@ static const struct mtk_soc_data mt7986_data = {
 		.desc_size = sizeof(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
+		.dma_size = MTK_DMA_SIZE(4K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
@@ -5209,6 +5239,7 @@ static const struct mtk_soc_data mt7986_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(1K),
 	},
 };
 
@@ -5228,6 +5259,8 @@ static const struct mtk_soc_data mt7988_data = {
 		.desc_size = sizeof(struct mtk_tx_dma_v2),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
+		.dma_size = MTK_DMA_SIZE(4K),
+		.fq_dma_size = MTK_DMA_SIZE(4K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma_v2),
@@ -5235,6 +5268,7 @@ static const struct mtk_soc_data mt7988_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_V2,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
 		.dma_len_offset = 8,
+		.dma_size = MTK_DMA_SIZE(1K),
 	},
 };
 
@@ -5249,6 +5283,8 @@ static const struct mtk_soc_data rt5350_data = {
 		.desc_size = sizeof(struct mtk_tx_dma),
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
+		.fq_dma_size = MTK_DMA_SIZE(2K),
 	},
 	.rx = {
 		.desc_size = sizeof(struct mtk_rx_dma),
@@ -5256,6 +5292,7 @@ static const struct mtk_soc_data rt5350_data = {
 		.dma_l4_valid = RX_DMA_L4_VALID_PDMA,
 		.dma_max_len = MTK_TX_DMA_BUF_LEN,
 		.dma_len_offset = 16,
+		.dma_size = MTK_DMA_SIZE(2K),
 	},
 };
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 4eab30b44070..f5174f6cb1bb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -32,7 +32,9 @@
 #define MTK_TX_DMA_BUF_LEN	0x3fff
 #define MTK_TX_DMA_BUF_LEN_V2	0xffff
 #define MTK_QDMA_RING_SIZE	2048
-#define MTK_DMA_SIZE		512
+#define MTK_DMA_SIZE(x)		(SZ_##x)
+#define MTK_FQ_DMA_HEAD		32
+#define MTK_FQ_DMA_LENGTH	2048
 #define MTK_RX_ETH_HLEN		(ETH_HLEN + ETH_FCS_LEN)
 #define MTK_RX_HLEN		(NET_SKB_PAD + MTK_RX_ETH_HLEN + NET_IP_ALIGN)
 #define MTK_DMA_DUMMY_DESC	0xffffffff
@@ -1176,6 +1178,8 @@ struct mtk_soc_data {
 		u32	desc_size;
 		u32	dma_max_len;
 		u32	dma_len_offset;
+		u32	dma_size;
+		u32	fq_dma_size;
 	} tx;
 	struct {
 		u32	desc_size;
@@ -1183,6 +1187,7 @@ struct mtk_soc_data {
 		u32	dma_l4_valid;
 		u32	dma_max_len;
 		u32	dma_len_offset;
+		u32	dma_size;
 	} rx;
 };
 
@@ -1264,7 +1269,7 @@ struct mtk_eth {
 	struct napi_struct		rx_napi;
 	void				*scratch_ring;
 	dma_addr_t			phy_scratch_ring;
-	void				*scratch_head;
+	void				*scratch_head[MTK_FQ_DMA_HEAD];
 	struct clk			*clks[MTK_CLK_MAX];
 
 	struct mii_bus			*mii_bus;
-- 
2.34.1



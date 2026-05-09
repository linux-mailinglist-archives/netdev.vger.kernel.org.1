Return-Path: <netdev+bounces-286207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO32EKOG/2nn7QAAu9opvQ
	(envelope-from <netdev+bounces-286207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:10:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9953350128D
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 717DB3017C06
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 19:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF323C9429;
	Sat,  9 May 2026 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="UryjqCBm"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC5351C06;
	Sat,  9 May 2026 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778353799; cv=none; b=UoaOVCmapyMCZrWnC5FPcPXz+SdPF3MQCeqph+evV/KdiNDLK6xEp/7N1JwsxPesj1aGW3hClViUakONWQfLpWeCnNppFfkyNKNp/YvJgB12aNt7XU/N032SAyg01cmXFr54RjpleQKdB76MI+iuuvkG1SG9I7klrsVMgLM6e0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778353799; c=relaxed/simple;
	bh=w9YZGerarw1yRjrWJbtiGDvSv6C490wPZ8wmCIW3Q8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrROwSMykqEyALESxavkLJjK8N9fA2aNiGeqT1ytQ2tO0/uZm07u5vLXaZ+NSLiaMwusb3DVzaxos3ZLrR+m+aCpPPKJ8tX/dj/ZIQCEjUnTByuB267FebkPS2V5fOsbFMNz/RY5MkJHH54s+IT7rUN2raecb9VfZm1iEKMbdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=UryjqCBm; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 8903C4004D;
	Sat,  9 May 2026 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1778353787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJs/6Gu0Hw+eg8n13h4UCU/lNXpfc4w8OZ6atdQW/+4=;
	b=UryjqCBmUTZUwf5irk70hlfNSrYkt5ew3IeyyKFI+QZM9B5cAfOpO4IaJG3fCVkcD3HXDw
	jdCtDpE7cCGSuHJIJKqqzEmYCAlxEKRgcpteZv5Fgc+GfrCPr2Gs+GNKO8jjOzQukicvSJ
	ON03EMeB0AbW56VAkg1q42sGVnXsnT4=
Received: from frank-u24.. (fttx-pool-217.61.152.172.bambit.de [217.61.152.172])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 4858A1226F2;
	Sat,  9 May 2026 19:09:47 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Mason Chang <mason-cw.chang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>
Subject: [net-next v8 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Date: Sat,  9 May 2026 21:09:32 +0200
Message-ID: <20260509190938.169290-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509190938.169290-1-linux@fw-web.de>
References: <20260509190938.169290-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9953350128D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailerdienst.de:s=routing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286207-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,vger.kernel.org,lists.infradead.org,mediatek.com,makrotopia.org];
	DMARC_NA(0.00)[fw-web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@fw-web.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailerdienst.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.982];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailerdienst.de:dkim,fw-web.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,public-files.de:email,mediatek.com:email,mediatek.com:url]
X-Rspamd-Action: no action

From: Mason Chang <mason-cw.chang@mediatek.com>

Add Large Receive Offload support to mediatek ethernet driver and
activate it for MT7988.

Signed-off-by: Mason Chang <mason-cw.chang@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v8:
- fix u32 vs. be32 completely (with sparse check) except one unrelated one

v7:
- fix u32 vs. be32 reported by patchwork check
- add L4 PSH check
  https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/7521c42b0bd5be20d52e20b110daea8c756fc069%5E%21/#F1
- Add HW LRO max 4-depth VLAN support including switch special tag.
  https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/35490cec6a2e5982532935fb0a1c884f7c4efdb0%5E%21/#F2

v6:
- fix some Macro argument '...' may be better as '(...)' to avoid precedence issues for LRO
- drop unused MTK_CTRL_DW0_SDL_MASK

v5:
- fix too long lines reported by checkpatch
  MTK_LRO_RING_RELINQUISH_REQ
  MTK_LRO_RING_RELINQUISH_DONE
  irq handling (MTK_HW_LRO_IRQ + MTK_HW_LRO_RING)

v4:
- fix lro reverse christmas tree and LRO params suggested by andrew
- drop mtk_hwlro_stats_ebl and unused IS_HW_LRO_RING (only used in
  properitary debugfs)

v2:
- drop link to commit for 6.6 patch
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 263 +++++++++++++++++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  53 ++--
 2 files changed, 254 insertions(+), 62 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 908fd88287ac..8035fc2557de 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2793,7 +2793,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 	if (rx_flag == MTK_RX_FLAGS_HWLRO) {
 		rx_data_len = MTK_MAX_LRO_RX_LENGTH;
-		rx_dma_size = MTK_HW_LRO_DMA_SIZE;
+		rx_dma_size = MTK_HW_LRO_DMA_SIZE(eth);
 	} else {
 		rx_data_len = ETH_DATA_LEN;
 		rx_dma_size = soc->rx.dma_size;
@@ -2806,7 +2806,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	if (!ring->data)
 		return -ENOMEM;
 
-	if (mtk_page_pool_enabled(eth)) {
+	if (mtk_page_pool_enabled(eth) && rcu_access_pointer(eth->prog))  {
 		struct page_pool *pp;
 
 		pp = mtk_create_page_pool(eth, &ring->xdp_q, ring_no,
@@ -2952,10 +2952,11 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_
 
 static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 {
-	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
-	int i;
 	u32 ring_ctrl_dw1 = 0, ring_ctrl_dw2 = 0, ring_ctrl_dw3 = 0;
+	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
+	const struct mtk_soc_data *soc = eth->soc;
 	u32 lro_ctrl_dw0 = 0, lro_ctrl_dw3 = 0;
+	int i, val;
 
 	/* set LRO rings to auto-learn modes */
 	ring_ctrl_dw2 |= MTK_RING_AUTO_LERAN_MODE;
@@ -2974,30 +2975,50 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 	ring_ctrl_dw2 |= MTK_RING_MAX_AGG_CNT_L;
 	ring_ctrl_dw3 |= MTK_RING_MAX_AGG_CNT_H;
 
-	for (i = 1; i < MTK_MAX_RX_RING_NUM; i++) {
+	for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++) {
 		mtk_w32(eth, ring_ctrl_dw1, MTK_LRO_CTRL_DW1_CFG(reg_map, i));
 		mtk_w32(eth, ring_ctrl_dw2, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
 		mtk_w32(eth, ring_ctrl_dw3, MTK_LRO_CTRL_DW3_CFG(reg_map, i));
 	}
 
 	/* IPv4 checksum update enable */
-	lro_ctrl_dw0 |= MTK_L3_CKS_UPD_EN;
+	lro_ctrl_dw0 |= MTK_L3_CKS_UPD_EN(eth);
 
 	/* switch priority comparison to packet count mode */
 	lro_ctrl_dw0 |= MTK_LRO_ALT_PKT_CNT_MODE;
 
+	/* enable L4 PSH flag check */
+	lro_ctrl_dw0 |= MTK_LRO_L4_CTRL_PSH_EN;
+
 	/* bandwidth threshold setting */
-	mtk_w32(eth, MTK_HW_LRO_BW_THRE, MTK_PDMA_LRO_CTRL_DW2);
+	mtk_w32(eth, MTK_HW_LRO_BW_THRE, MTK_PDMA_LRO_CTRL_DW2(reg_map));
 
 	/* auto-learn score delta setting */
-	mtk_w32(eth, MTK_HW_LRO_REPLACE_DELTA, MTK_PDMA_LRO_ALT_SCORE_DELTA);
+	mtk_w32(eth, MTK_HW_LRO_REPLACE_DELTA, MTK_PDMA_LRO_ALT_SCORE_DELTA(reg_map));
 
 	/* set refresh timer for altering flows to 1 sec. (unit: 20us) */
 	mtk_w32(eth, (MTK_HW_LRO_TIMER_UNIT << 16) | MTK_HW_LRO_REFRESH_TIME,
 		MTK_PDMA_LRO_ALT_REFRESH_TIMER);
 
-	/* set HW LRO mode & the max aggregation count for rx packets */
-	lro_ctrl_dw3 |= MTK_ADMA_MODE | (MTK_HW_LRO_MAX_AGG_CNT & 0xff);
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		val = mtk_r32(eth, reg_map->pdma.rx_cfg);
+		mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + MTK_MAX_RX_LENGTH) <<
+			MTK_RX_CFG_SDL_OFFSET), reg_map->pdma.rx_cfg);
+
+		lro_ctrl_dw0 |= MTK_PDMA_LRO_SDL << MTK_CTRL_DW0_SDL_OFFSET;
+
+		/* enable cpu reason black list */
+		lro_ctrl_dw0 |= MTK_LRO_CRSN_BNW(eth);
+
+		/* no use PPE cpu reason */
+		mtk_w32(eth, 0xffffffff, MTK_PDMA_LRO_CTRL_DW1(reg_map));
+	} else {
+		/* set HW LRO mode & the max aggregation count for rx packets */
+		lro_ctrl_dw3 |= MTK_ADMA_MODE | (MTK_HW_LRO_MAX_AGG_CNT & 0xff);
+	}
+
+	/* enable max 4-depth VLAN support including switch special tag */
+	lro_ctrl_dw3 |= MTK_LRO_VLAN_VID_CMP_DEPTH | MTK_LRO_VLAN_EN;
 
 	/* the minimal remaining room of SDL0 in RXD for lro aggregation */
 	lro_ctrl_dw3 |= MTK_LRO_MIN_RXD_SDL;
@@ -3005,8 +3026,19 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 	/* enable HW LRO */
 	lro_ctrl_dw0 |= MTK_LRO_EN;
 
-	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3);
-	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, lro_ctrl_dw3, MTK_PDMA_LRO_CTRL_DW3(reg_map));
+	mtk_w32(eth, lro_ctrl_dw0, MTK_PDMA_LRO_CTRL_DW0(reg_map));
+
+	if (mtk_is_netsys_v2_or_greater(eth)) {
+		i = (soc->rx.desc_size == sizeof(struct mtk_rx_dma_v2)) ? 1 : 0;
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)), reg_map->pdma.int_grp);
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 1)),
+			reg_map->pdma.int_grp + 0x4);
+		mtk_m32(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)),
+			MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i + 2)), reg_map->pdma.int_grp3);
+	}
 
 	return 0;
 }
@@ -3014,16 +3046,16 @@ static int mtk_hwlro_rx_init(struct mtk_eth *eth)
 static void mtk_hwlro_rx_uninit(struct mtk_eth *eth)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
-	int i;
 	u32 val;
+	int i;
 
 	/* relinquish lro rings, flush aggregated packets */
-	mtk_w32(eth, MTK_LRO_RING_RELINQUISH_REQ, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, MTK_LRO_RING_RELINQUISH_REQ(eth), MTK_PDMA_LRO_CTRL_DW0(reg_map));
 
 	/* wait for relinquishments done */
 	for (i = 0; i < 10; i++) {
-		val = mtk_r32(eth, MTK_PDMA_LRO_CTRL_DW0);
-		if (val & MTK_LRO_RING_RELINQUISH_DONE) {
+		val = mtk_r32(eth, MTK_PDMA_LRO_CTRL_DW0(reg_map));
+		if (val & MTK_LRO_RING_RELINQUISH_DONE(eth)) {
 			msleep(20);
 			continue;
 		}
@@ -3031,14 +3063,14 @@ static void mtk_hwlro_rx_uninit(struct mtk_eth *eth)
 	}
 
 	/* invalidate lro rings */
-	for (i = 1; i < MTK_MAX_RX_RING_NUM; i++)
+	for (i = 1; i <= MTK_HW_LRO_RING_NUM(eth); i++)
 		mtk_w32(eth, 0, MTK_LRO_CTRL_DW2_CFG(reg_map, i));
 
 	/* disable HW LRO */
-	mtk_w32(eth, 0, MTK_PDMA_LRO_CTRL_DW0);
+	mtk_w32(eth, 0, MTK_PDMA_LRO_CTRL_DW0(reg_map));
 }
 
-static void mtk_hwlro_val_ipaddr(struct mtk_eth *eth, int idx, __be32 ip)
+static void mtk_hwlro_val_ipaddr(struct mtk_eth *eth, int idx, u32 ip)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
 	u32 reg_val;
@@ -3048,7 +3080,7 @@ static void mtk_hwlro_val_ipaddr(struct mtk_eth *eth, int idx, __be32 ip)
 	/* invalidate the IP setting */
 	mtk_w32(eth, (reg_val & ~MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
 
-	mtk_w32(eth, ip, MTK_LRO_DIP_DW0_CFG(idx));
+	mtk_w32(eth, ip, MTK_LRO_DIP_DW0_CFG(reg_map, idx));
 
 	/* validate the IP setting */
 	mtk_w32(eth, (reg_val | MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
@@ -3064,7 +3096,7 @@ static void mtk_hwlro_inval_ipaddr(struct mtk_eth *eth, int idx)
 	/* invalidate the IP setting */
 	mtk_w32(eth, (reg_val & ~MTK_RING_MYIP_VLD), MTK_LRO_CTRL_DW2_CFG(reg_map, idx));
 
-	mtk_w32(eth, 0, MTK_LRO_DIP_DW0_CFG(idx));
+	mtk_w32(eth, 0, MTK_LRO_DIP_DW0_CFG(reg_map, idx));
 }
 
 static int mtk_hwlro_get_ip_cnt(struct mtk_mac *mac)
@@ -3080,6 +3112,65 @@ static int mtk_hwlro_get_ip_cnt(struct mtk_mac *mac)
 	return cnt;
 }
 
+static int mtk_hwlro_add_ipaddr_idx(struct net_device *dev, u32 ip4dst)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	const struct mtk_reg_map *reg_map;
+	struct mtk_eth *eth = mac->hw;
+	u32 reg_val;
+	int i;
+
+	reg_map = eth->soc->reg_map;
+
+	/* check for duplicate IP address in the current DIP list */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
+		if (reg_val == ip4dst)
+			break;
+	}
+
+	if (i < MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "Duplicate IP address at DIP(%d)!\n", i);
+		return -EEXIST;
+	}
+
+	/* find out available DIP index */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(reg_map, i));
+		if (reg_val == 0UL)
+			break;
+	}
+
+	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "DIP index is currently out of resource!\n");
+		return -EBUSY;
+	}
+
+	return i;
+}
+
+static int mtk_hwlro_get_ipaddr_idx(struct net_device *dev, u32 ip4dst)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	struct mtk_eth *eth = mac->hw;
+	u32 reg_val;
+	int i;
+
+	/* find out DIP index that matches the given IP address */
+	for (i = 1; i <= MTK_HW_LRO_DIP_NUM(eth); i++) {
+		reg_val = mtk_r32(eth, MTK_LRO_DIP_DW0_CFG(eth->soc->reg_map, i));
+		if (reg_val == ip4dst)
+			break;
+	}
+
+	if (i >= MTK_HW_LRO_DIP_NUM(eth) + 1) {
+		netdev_warn(dev, "DIP address is not exist!\n");
+		return -ENOENT;
+	}
+
+	return i;
+}
+
 static int mtk_hwlro_add_ipaddr(struct net_device *dev,
 				struct ethtool_rxnfc *cmd)
 {
@@ -3088,18 +3179,22 @@ static int mtk_hwlro_add_ipaddr(struct net_device *dev,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	int hwlro_idx;
+	u32 ip4dst;
 
 	if ((fsp->flow_type != TCP_V4_FLOW) ||
 	    (!fsp->h_u.tcp_ip4_spec.ip4dst) ||
 	    (fsp->location > 1))
 		return -EINVAL;
 
-	mac->hwlro_ip[fsp->location] = htonl(fsp->h_u.tcp_ip4_spec.ip4dst);
-	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
+	ip4dst = ntohl(fsp->h_u.tcp_ip4_spec.ip4dst);
+	hwlro_idx = mtk_hwlro_add_ipaddr_idx(dev, ip4dst);
+	if (hwlro_idx < 0)
+		return hwlro_idx;
 
+	mac->hwlro_ip[fsp->location] = ip4dst;
 	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
 
-	mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[fsp->location]);
+	mtk_hwlro_val_ipaddr(eth, hwlro_idx, ip4dst);
 
 	return 0;
 }
@@ -3112,13 +3207,17 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 	int hwlro_idx;
+	u32 ip4dst;
 
 	if (fsp->location > 1)
 		return -EINVAL;
 
-	mac->hwlro_ip[fsp->location] = 0;
-	hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + fsp->location;
+	ip4dst = mac->hwlro_ip[fsp->location];
+	hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, ip4dst);
+	if (hwlro_idx < 0)
+		return hwlro_idx;
 
+	mac->hwlro_ip[fsp->location] = 0;
 	mac->hwlro_ip_cnt = mtk_hwlro_get_ip_cnt(mac);
 
 	mtk_hwlro_inval_ipaddr(eth, hwlro_idx);
@@ -3126,6 +3225,24 @@ static int mtk_hwlro_del_ipaddr(struct net_device *dev,
 	return 0;
 }
 
+static void mtk_hwlro_netdev_enable(struct net_device *dev)
+{
+	struct mtk_mac *mac = netdev_priv(dev);
+	struct mtk_eth *eth = mac->hw;
+	int i, hwlro_idx;
+
+	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (mac->hwlro_ip[i] == 0)
+			continue;
+
+		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
+		if (hwlro_idx < 0)
+			continue;
+
+		mtk_hwlro_val_ipaddr(eth, hwlro_idx, mac->hwlro_ip[i]);
+	}
+}
+
 static void mtk_hwlro_netdev_disable(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -3133,8 +3250,14 @@ static void mtk_hwlro_netdev_disable(struct net_device *dev)
 	int i, hwlro_idx;
 
 	for (i = 0; i < MTK_MAX_LRO_IP_CNT; i++) {
+		if (mac->hwlro_ip[i] == 0)
+			continue;
+
+		hwlro_idx = mtk_hwlro_get_ipaddr_idx(dev, mac->hwlro_ip[i]);
+		if (hwlro_idx < 0)
+			continue;
+
 		mac->hwlro_ip[i] = 0;
-		hwlro_idx = (mac->id * MTK_MAX_LRO_IP_CNT) + i;
 
 		mtk_hwlro_inval_ipaddr(eth, hwlro_idx);
 	}
@@ -3154,15 +3277,15 @@ static int mtk_hwlro_get_fdir_entry(struct net_device *dev,
 
 	/* only tcp dst ipv4 is meaningful, others are meaningless */
 	fsp->flow_type = TCP_V4_FLOW;
-	fsp->h_u.tcp_ip4_spec.ip4dst = ntohl(mac->hwlro_ip[fsp->location]);
+	fsp->h_u.tcp_ip4_spec.ip4dst = htonl(mac->hwlro_ip[fsp->location]);
 	fsp->m_u.tcp_ip4_spec.ip4dst = 0;
 
 	fsp->h_u.tcp_ip4_spec.ip4src = 0;
-	fsp->m_u.tcp_ip4_spec.ip4src = 0xffffffff;
+	fsp->m_u.tcp_ip4_spec.ip4src = htonl(~0U);
 	fsp->h_u.tcp_ip4_spec.psrc = 0;
-	fsp->m_u.tcp_ip4_spec.psrc = 0xffff;
+	fsp->m_u.tcp_ip4_spec.psrc = htons(~0);
 	fsp->h_u.tcp_ip4_spec.pdst = 0;
-	fsp->m_u.tcp_ip4_spec.pdst = 0xffff;
+	fsp->m_u.tcp_ip4_spec.pdst = htons(~0);
 	fsp->h_u.tcp_ip4_spec.tos = 0;
 	fsp->m_u.tcp_ip4_spec.tos = 0xff;
 
@@ -3314,6 +3437,8 @@ static int mtk_set_features(struct net_device *dev, netdev_features_t features)
 
 	if ((diff & NETIF_F_LRO) && !(features & NETIF_F_LRO))
 		mtk_hwlro_netdev_disable(dev);
+	else if ((diff & NETIF_F_LRO) && (features & NETIF_F_LRO))
+		mtk_hwlro_netdev_enable(dev);
 
 	return 0;
 }
@@ -3371,8 +3496,8 @@ static int mtk_dma_init(struct mtk_eth *eth)
 		return err;
 
 	if (eth->hwlro) {
-		for (i = 1; i < MTK_MAX_RX_RING_NUM; i++) {
-			err = mtk_rx_alloc(eth, i, MTK_RX_FLAGS_HWLRO);
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			err = mtk_rx_alloc(eth, MTK_HW_LRO_RING(eth, i), MTK_RX_FLAGS_HWLRO);
 			if (err)
 				return err;
 		}
@@ -3434,8 +3559,8 @@ static void mtk_dma_free(struct mtk_eth *eth)
 
 	if (eth->hwlro) {
 		mtk_hwlro_rx_uninit(eth);
-		for (i = 1; i < MTK_MAX_RX_RING_NUM; i++)
-			mtk_rx_clean(eth, &eth->rx_ring[i], false);
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++)
+			mtk_rx_clean(eth, &eth->rx_ring[MTK_HW_LRO_RING(eth, i)], false);
 	}
 
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSS)) {
@@ -3630,16 +3755,21 @@ static int mtk_start_dma(struct mtk_eth *eth)
 			val |= MTK_RX_BT_32DWORDS;
 		mtk_w32(eth, val, reg_map->qdma.glo_cfg);
 
-		mtk_w32(eth,
-			MTK_RX_DMA_EN | rx_2b_offset |
-			MTK_RX_BT_32DWORDS | MTK_MULTI_EN,
-			reg_map->pdma.glo_cfg);
+		val = mtk_r32(eth, reg_map->pdma.glo_cfg);
+		val |= MTK_RX_DMA_EN | rx_2b_offset |
+		       MTK_RX_BT_32DWORDS | MTK_MULTI_EN;
+		mtk_w32(eth, val, reg_map->pdma.glo_cfg);
 	} else {
 		mtk_w32(eth, MTK_TX_WB_DDONE | MTK_TX_DMA_EN | MTK_RX_DMA_EN |
 			MTK_MULTI_EN | MTK_PDMA_SIZE_8DWORDS,
 			reg_map->pdma.glo_cfg);
 	}
 
+	if (eth->hwlro && mtk_is_netsys_v3_or_greater(eth)) {
+		val = mtk_r32(eth, reg_map->pdma.glo_cfg);
+		mtk_w32(eth, val | MTK_RX_DMA_LRO_EN, reg_map->pdma.glo_cfg);
+	}
+
 	return 0;
 }
 
@@ -3798,6 +3928,14 @@ static int mtk_open(struct net_device *dev)
 			}
 		}
 
+		if (eth->hwlro) {
+			for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+				napi_enable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+				mtk_rx_irq_enable(eth, MTK_RX_DONE_INT(eth,
+								       MTK_HW_LRO_RING(eth, i)));
+			}
+		}
+
 		refcount_set(&eth->dma_refcnt, 1);
 	} else {
 		refcount_inc(&eth->dma_refcnt);
@@ -3893,6 +4031,14 @@ static int mtk_stop(struct net_device *dev)
 		}
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			mtk_rx_irq_disable(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)));
+			napi_synchronize(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+			napi_disable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+		}
+	}
+
 	cancel_work_sync(&eth->rx_dim.work);
 	cancel_work_sync(&eth->tx_dim.work);
 
@@ -4301,6 +4447,14 @@ static int mtk_napi_init(struct mtk_eth *eth)
 		}
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			rx_napi = &eth->rx_napi[MTK_HW_LRO_RING(eth, i)];
+			rx_napi->eth = eth;
+			rx_napi->rx_ring = &eth->rx_ring[MTK_HW_LRO_RING(eth, i)];
+		}
+	}
+
 	return 0;
 }
 
@@ -5352,6 +5506,7 @@ static int mtk_probe(struct platform_device *pdev)
 {
 	struct resource *res = NULL;
 	struct device_node *mac_np;
+	u8 lro_irq, lro_ring;
 	struct mtk_eth *eth;
 	char *irqname;
 	int err, i;
@@ -5577,6 +5732,23 @@ static int mtk_probe(struct platform_device *pdev)
 						goto err_free_dev;
 				}
 			}
+
+			if (eth->hwlro) {
+				for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+					lro_irq = MTK_HW_LRO_IRQ(eth, i);
+					lro_ring = MTK_HW_LRO_RING(eth, i);
+					irqname = devm_kasprintf(eth->dev, GFP_KERNEL,
+								 "%s LRO RX %d",
+								 dev_name(eth->dev), i);
+					err = devm_request_irq(eth->dev,
+							       eth->irq_pdma[lro_irq],
+							       mtk_handle_irq_rx, IRQF_SHARED,
+							       irqname,
+							       &eth->rx_napi[lro_ring]);
+					if (err)
+						goto err_free_dev;
+				}
+			}
 		} else {
 			irqname = devm_kasprintf(eth->dev, GFP_KERNEL, "%s RX",
 						 dev_name(eth->dev));
@@ -5648,6 +5820,13 @@ static int mtk_probe(struct platform_device *pdev)
 				       mtk_napi_rx);
 	}
 
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++) {
+			netif_napi_add(eth->dummy_dev, &eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi,
+				       mtk_napi_rx);
+		}
+	}
+
 	platform_set_drvdata(pdev, eth);
 	schedule_delayed_work(&eth->reset.monitor_work,
 			      MTK_DMA_MONITOR_TIMEOUT);
@@ -5696,6 +5875,12 @@ static void mtk_remove(struct platform_device *pdev)
 		for (i = 1; i < MTK_RX_RSS_NUM(eth); i++)
 			netif_napi_del(&eth->rx_napi[MTK_RSS_RING(i)].napi);
 	}
+
+	if (eth->hwlro) {
+		for (i = 0; i < MTK_HW_LRO_RING_NUM(eth); i++)
+			netif_napi_del(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
+	}
+
 	mtk_cleanup(eth);
 	free_netdev(eth->dummy_dev);
 	mtk_mdio_cleanup(eth);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 378cf47913ef..f7e7299fef6b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -35,7 +35,7 @@
 #define MTK_DMA_SIZE(x)		(SZ_##x)
 #define MTK_FQ_DMA_HEAD		32
 #define MTK_FQ_DMA_LENGTH	2048
-#define MTK_RX_ETH_HLEN		(ETH_HLEN + ETH_FCS_LEN)
+#define MTK_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
 #define MTK_RX_HLEN		(NET_SKB_PAD + MTK_RX_ETH_HLEN + NET_IP_ALIGN)
 #define MTK_DMA_DUMMY_DESC	0xffffffff
 #define MTK_DEFAULT_MSG_ENABLE	(NETIF_MSG_DRV | \
@@ -63,10 +63,9 @@
 
 #define MTK_QRX_OFFSET		0x10
 
-#define MTK_MAX_RX_RING_NUM	4
-#define MTK_HW_LRO_DMA_SIZE	8
-
-#define	MTK_MAX_LRO_RX_LENGTH		(4096 * 3)
+#define MTK_MAX_RX_RING_NUM	(8)
+#define MTK_HW_LRO_DMA_SIZE(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 64 : 8)
+#define	MTK_MAX_LRO_RX_LENGTH		(4096 * 3 + MTK_MAX_RX_LENGTH)
 #define	MTK_MAX_LRO_IP_CNT		2
 #define	MTK_HW_LRO_TIMER_UNIT		1	/* 20 us */
 #define	MTK_HW_LRO_REFRESH_TIME		50000	/* 1 sec. */
@@ -182,31 +181,39 @@
 #define MTK_CDMM_THRES		0x165c
 
 /* PDMA HW LRO Control Registers */
-#define MTK_PDMA_LRO_CTRL_DW0	0x980
-#define MTK_HW_LRO_RING_NUM(eth)		(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_DIP_NUM(eth)		(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_RING_NUM(eth)	(mtk_is_netsys_v3_or_greater(eth) ? 4 : 3)
+#define MTK_HW_LRO_RING(eth, x)		((x) + (mtk_is_netsys_v3_or_greater(eth) ? 4 : 1))
+#define MTK_HW_LRO_IRQ(eth, x)		((x) + (mtk_is_netsys_v3_or_greater(eth) ? 0 : 1))
+#define MTK_LRO_CRSN_BNW(eth)		BIT((mtk_is_netsys_v3_or_greater(eth) ? 22 : 6))
 #define MTK_LRO_EN			BIT(0)
 #define MTK_NON_LRO_MULTI_EN		BIT(2)
 #define MTK_LRO_DLY_INT_EN		BIT(5)
-#define MTK_L3_CKS_UPD_EN		BIT(7)
-#define MTK_L3_CKS_UPD_EN_V2		BIT(19)
+#define MTK_L3_CKS_UPD_EN(eth)		BIT(mtk_is_netsys_v3_or_greater(eth) ? 19 : 7)
 #define MTK_LRO_ALT_PKT_CNT_MODE	BIT(21)
-#define MTK_LRO_RING_RELINQUISH_REQ	(0x7 << 26)
-#define MTK_LRO_RING_RELINQUISH_REQ_V2	(0xf << 24)
-#define MTK_LRO_RING_RELINQUISH_DONE	(0x7 << 29)
-#define MTK_LRO_RING_RELINQUISH_DONE_V2	(0xf << 28)
-
-#define MTK_PDMA_LRO_CTRL_DW1	0x984
-#define MTK_PDMA_LRO_CTRL_DW2	0x988
-#define MTK_PDMA_LRO_CTRL_DW3	0x98c
+#define MTK_LRO_RING_RELINQUISH_REQ(eth)	(mtk_is_netsys_v3_or_greater(eth) ? \
+						0xf << 24 : 0x7 << 26)
+#define MTK_LRO_RING_RELINQUISH_DONE(eth)	(mtk_is_netsys_v3_or_greater(eth) ? \
+						0xf << 28 : 0x7 << 29)
+
+#define MTK_PDMA_LRO_CTRL_DW0(reg_map)	((reg_map)->pdma.lro_ctrl_dw0)
+#define MTK_PDMA_LRO_CTRL_DW1(reg_map)	((reg_map)->pdma.lro_ctrl_dw0 + 0x04)
+#define MTK_PDMA_LRO_CTRL_DW2(reg_map)	((reg_map)->pdma.lro_ctrl_dw0 + 0x08)
+#define MTK_PDMA_LRO_CTRL_DW3(reg_map)	((reg_map)->pdma.lro_ctrl_dw0 + 0x0c)
+#define MTK_LRO_VLAN_EN			(0xf << 8)
+#define MTK_LRO_VLAN_VID_CMP_DEPTH	(0x3 << 12)
+#define MTK_LRO_L4_CTRL_PSH_EN		BIT(23)
 #define MTK_ADMA_MODE		BIT(15)
 #define MTK_LRO_MIN_RXD_SDL	(MTK_HW_LRO_SDL_REMAIN_ROOM << 16)
 
+#define MTK_CTRL_DW0_SDL_OFFSET	(3)
+
 #define MTK_RX_DMA_LRO_EN	BIT(8)
 #define MTK_MULTI_EN		BIT(10)
 #define MTK_PDMA_SIZE_8DWORDS	(1 << 4)
 
 /* PDMA RSS Control Registers */
-#define MTK_RX_NAPI_NUM			(4)
+#define MTK_RX_NAPI_NUM			(8)
 #define MTK_RX_RSS_NUM(eth)		((eth)->soc->rss_num)
 #define MTK_RSS_RING(x)			(x)
 #define MTK_RSS_EN			BIT(0)
@@ -242,11 +249,10 @@
 #define MTK_PDMA_DELAY_PTIME_MASK	0xff
 
 /* PDMA HW LRO Alter Flow Delta Register */
-#define MTK_PDMA_LRO_ALT_SCORE_DELTA	0xa4c
+#define MTK_PDMA_LRO_ALT_SCORE_DELTA(reg_map)	((reg_map)->pdma.lro_alt_score_delta)
 
 /* PDMA HW LRO IP Setting Registers */
-#define MTK_LRO_RX_RING0_DIP_DW0	0xb04
-#define MTK_LRO_DIP_DW0_CFG(x)		(MTK_LRO_RX_RING0_DIP_DW0 + (x * 0x40))
+#define MTK_LRO_DIP_DW0_CFG(reg_map, x)	((reg_map)->pdma.lro_ring_dip_dw0 + ((x) * 0x40))
 #define MTK_RING_MYIP_VLD		BIT(9)
 
 /* PDMA HW LRO Ring Control Registers */
@@ -1187,7 +1193,8 @@ enum mkt_eth_capabilities {
 
 #define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC2_2P5GPHY | \
 		      MTK_MUX_GMAC2_TO_2P5GPHY | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
-		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_PDMA_INT | MTK_RSS)
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_PDMA_INT | MTK_RSS | \
+		      MTK_HWLRO)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1454,7 +1461,7 @@ struct mtk_mac {
 	struct phylink_config		phylink_config;
 	struct mtk_eth			*hw;
 	struct mtk_hw_stats		*hw_stats;
-	__be32				hwlro_ip[MTK_MAX_LRO_IP_CNT];
+	u32				hwlro_ip[MTK_MAX_LRO_IP_CNT];
 	int				hwlro_ip_cnt;
 	unsigned int			syscfg0;
 	struct notifier_block		device_notifier;
-- 
2.43.0



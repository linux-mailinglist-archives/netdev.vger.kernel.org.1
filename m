Return-Path: <netdev+bounces-76461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5220B86DCEC
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 09:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458001C2153A
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4812D796;
	Fri,  1 Mar 2024 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrRD0e0/"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035369D13
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281229; cv=none; b=AxBfN3uCEo5zZMgO4toiIiBGmpLc7dS2tKzVbbxHpxVSporaSDEK3U8mGpB8Xcgw4yISvSAI0JwQZXHGNDGaXxZE6uNvsid4NkFPYjYUaHEDAzHHXI/GiXf/uCcZTlns82wpKugYjG39aBMYfiA55nEWwCJbn3cYSHnMW+6mmCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281229; c=relaxed/simple;
	bh=hxU1kjptECmUNGWaYfUf7xbpONi96j0oNHRgoVMF5SU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=acPjz50BrBbbJzh5cxLU8Hs7cSb8zYFsWXJxAJ3DMkLHUo6WSrYehovS/RtKjlQkxbgcjDpTySoYAjn7abqtfqkahtYqfWoC7ORYAm8TQvPeClwDozUoXGbi28u/kXwLz/vQIrnBYX5b1KpZcE/Clq8ztdf+AxUdhcbtHcEi4O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rrRD0e0/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=W3Wt5PydOMBj1d+7oPLYJK2mUZttz46r2N8loTO1eA0=; b=rrRD0e0/Iy5M+krXYCNXumLFm7
	k0j5RJmTRqF7QdgO/lzDw6jrIQc71gc2VGG72gOArf6aLwzs3eTctmP3LHpSiaV6qsxvWsvK98ylS
	qectZQswAlK51lWESw3mQwI0uDkh5CxLjYODzdeDYwUs/hquEoOIS1PBaUxKOL0y96aIOzZShM6Rl
	fhG4Bmu4yFYxfQkep5XI5QiFepFTjJxSTokvobg7G0eCt2hlwr0tWBouBZhoof+MfKLFuCzxCAD1a
	tiwPNeDaT12pLqRfpAqczsET3Pv0wZJUai4U7ccLokp86h0q0c+5ayjJU53udc7250wV4I3rH/KlA
	5qhEpC4A==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfy7v-0000000AM7H-0Apo;
	Fri, 01 Mar 2024 08:20:19 +0000
Message-ID: <ddb7f076-06a7-45df-ae98-b4120d9dc275@infradead.org>
Date: Fri, 1 Mar 2024 17:20:11 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH net-next v1] ps3_gelic_net: Use napi routines for RX SKB
To: "David S. Miller" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Convert the PS3 Gelic network driver's RX SK buffers over to
use the napi_alloc_frag_align and napi_build_skb routines.

Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 5ee8e8980393..fb5c015851b8 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -375,14 +375,14 @@ static int gelic_card_init_chain(struct gelic_card *card,
 static int gelic_descr_prepare_rx(struct gelic_card *card,
 				  struct gelic_descr *descr)
 {
-	static const unsigned int rx_skb_size =
-		ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
-		GELIC_NET_RXBUF_ALIGN - 1;
+	static const unsigned int napi_buff_size =
+		round_up(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN);
+	struct device *dev = ctodev(card);
 	dma_addr_t cpu_addr;
-	int offset;
+	void *napi_buff;
 
 	if (gelic_descr_get_status(descr) !=  GELIC_DESCR_DMA_NOT_IN_USE)
-		dev_info(ctodev(card), "%s: ERROR status\n", __func__);
+		dev_info(dev, "%s: ERROR status\n", __func__);
 
 	descr->hw_regs.dmac_cmd_status = 0;
 	descr->hw_regs.result_size = 0;
@@ -390,31 +390,34 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	descr->hw_regs.data_error = 0;
 	descr->hw_regs.payload.dev_addr = 0;
 	descr->hw_regs.payload.size = 0;
+	descr->skb = NULL;
+
+	napi_buff = napi_alloc_frag_align(napi_buff_size,
+					  GELIC_NET_RXBUF_ALIGN);
+
+	if (unlikely(!napi_buff))
+		return -ENOMEM;
 
-	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
-	if (!descr->skb) {
-		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
+	descr->skb = napi_build_skb(napi_buff, napi_buff_size);
+
+	if (unlikely(!descr->skb)) {
+		skb_free_frag(napi_buff);
 		return -ENOMEM;
 	}
 
-	offset = ((unsigned long)descr->skb->data) &
-		(GELIC_NET_RXBUF_ALIGN - 1);
-	if (offset)
-		skb_reserve(descr->skb, GELIC_NET_RXBUF_ALIGN - offset);
-	/* io-mmu-map the skb */
-	cpu_addr = dma_map_single(ctodev(card), descr->skb->data,
-				  GELIC_NET_MAX_FRAME, DMA_FROM_DEVICE);
-	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
-	if (dma_mapping_error(ctodev(card), cpu_addr)) {
-		dev_kfree_skb_any(descr->skb);
+	cpu_addr = dma_map_single(dev, napi_buff, napi_buff_size,
+				  DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(dev, cpu_addr)) {
+		skb_free_frag(napi_buff);
 		descr->skb = NULL;
-		dev_info(ctodev(card),
-			 "%s:Could not iommu-map rx buffer\n", __func__);
+		dev_err_once(dev, "%s:Could not iommu-map rx buffer\n",
+			     __func__);
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 		return -ENOMEM;
 	}
 
-	descr->hw_regs.payload.size = cpu_to_be32(GELIC_NET_MAX_FRAME);
+	descr->hw_regs.payload.size = cpu_to_be32(napi_buff_size);
 	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
 
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index f7d7931e51b7..e8f7de8e7e9b 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -19,10 +19,10 @@
 #define GELIC_NET_RX_DESCRIPTORS        128 /* num of descriptors */
 #define GELIC_NET_TX_DESCRIPTORS        128 /* num of descriptors */
 
-#define GELIC_NET_MAX_FRAME             2312
+#define GELIC_NET_MAX_FRAME             2312U
 #define GELIC_NET_MAX_MTU               2294
 #define GELIC_NET_MIN_MTU               64
-#define GELIC_NET_RXBUF_ALIGN           128
+#define GELIC_NET_RXBUF_ALIGN           128U
 #define GELIC_CARD_RX_CSUM_DEFAULT      1 /* hw chksum */
 #define GELIC_NET_WATCHDOG_TIMEOUT      5*HZ
 #define GELIC_NET_BROADCAST_ADDR        0xffffffffffffL


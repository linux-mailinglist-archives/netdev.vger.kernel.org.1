Return-Path: <netdev+bounces-69017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89738849238
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 02:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6FE1F214F9
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 01:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84279CD;
	Mon,  5 Feb 2024 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g40ZVIcJ"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1627B79CF
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097760; cv=none; b=LJmELGLI+fKSS22o/lvrpN89YB/UJcnDM7hJFGckqn38zD4vrj6ApIf/O7mUV3bjmGfx7TWc0YkRCmnZ/A65LLno6MRJ1ubXziVhiFt7YQ4wUalbMZGEnJ1PiEmtJzuMLJvn1yWRACPhocD/LU8zjpXbnrr6tbQHDlRvMRkgqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097760; c=relaxed/simple;
	bh=t4v/SThxKqBvuY5KiV/FxrdsvrQqRjJYlFQy+QqVJm0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JPMO+a614M2csA+xpiOd9fnUGio0++1jbbNQ7uTb2PASOmX+Ur4e+ean+WuooCkWVPXJ/6FVAORfw32OleNHBGdGCKjpimT6SWLwJzbuQl9a4m5l0PMxAAD4X3FfX+HS8KPbxYROtxAXDBCDekRjQPYlhSVy5FTVDs5ezCubRp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g40ZVIcJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=DPqCE0IQvkt4gx+/+Rj+CdFFygCszeRoTdDptYrL/hs=; b=g40ZVIcJB69MPlwCrnD5uRE8tA
	qBiRORvKFKmvb2GnIu8xRzm9cXBam87kOxBtENyF24WWFc9r88c4K7rmJabpkuFm+R/Qg6e7FpnoK
	kF/oL2g9Mb9TcuPZxfoaEL5JIir21VO+B2OlZbE3RY9o31BifudFlOIp5WV7sJQpDytcjEeeHDvpN
	9wz6ZtfZqlQ2yZMohwLcHummMJ89jOBQM85XtkxLebFTRwqlk5hoglNjToi8oRhrp5d4Z/Iyt04ZL
	wR/Hj1uMNDGgwiI+OJFs57Vp+N3JUkBnC53qRvpwR6STEdEcet/2T/8jWOqsG/kbWeFa4AuvP7p+u
	QdULIixA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWo5m-0000000BXrI-1I9h;
	Mon, 05 Feb 2024 01:48:26 +0000
Message-ID: <2acf3fe5-7206-46d6-adac-0bf40d175d5d@infradead.org>
Date: Mon, 5 Feb 2024 10:48:07 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v2 net] ps3/gelic: Fix SKB allocation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

    Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
    of 6.8-rc1 did not set up the network SKB's correctly, resulting in
    a kernel panic.
    
    This fix changes the way the napi buffer and corresponding SKB are
    allocated and managed.
    
    Reported-by: sambat goson <sombat3960@gmail.com>
    Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
    Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..3ebe903e4b6d 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -375,20 +375,15 @@ static int gelic_card_init_chain(struct gelic_card *card,
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
 
-	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
-	if (!descr->skb) {
-		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
-		return -ENOMEM;
-	}
 	descr->hw_regs.dmac_cmd_status = 0;
 	descr->hw_regs.result_size = 0;
 	descr->hw_regs.valid_size = 0;
@@ -397,24 +392,32 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	descr->hw_regs.payload.size = 0;
 	descr->skb = NULL;
 
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
+	napi_buff = napi_alloc_frag_align(napi_buff_size,
+					  GELIC_NET_RXBUF_ALIGN);
+
+	if (unlikely(!napi_buff))
+		return -ENOMEM;
+
+	descr->skb = napi_build_skb(napi_buff, napi_buff_size);
+
+	if (unlikely(!descr->skb)) {
+		skb_free_frag(napi_buff);
+		return -ENOMEM;
+	}
+
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


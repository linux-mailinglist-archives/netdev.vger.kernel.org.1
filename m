Return-Path: <netdev+bounces-70741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC385037D
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858CF1F22AA8
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836DA2B9D0;
	Sat, 10 Feb 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="POqeQ+sq"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD68493
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707553012; cv=none; b=aJFrdNrdvf2m8Zuv15QAE3qdpPcu1oZusmeuVovuQrAXdrqwVVZ252EpqVDxVk4BJabYurZsumB0D5SlsT4KsZcgUKXZHribZ/Uzag4/X0w4x4JiqYvFzAPNP7N8GXO+CefSIjkttebIt1K2UHvplGdt4eJgti2Pj96erMLyhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707553012; c=relaxed/simple;
	bh=0VvGaetJgoPXEpidzq+/jbv0Tq/b+b5HFJ1+nBQely4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Wj+xYBXjtmz4648jCuEOY5DK0gyWRuxov/yYzWA3kS3KPgT5GTMJIHVu1ob6EP31mtjzJuFZ2qfsc8ulqU33oNPq0MC+ONYxz6YtZjudEIubXNa/WMdTGQnz366mcChE9Ls9Xa1fOjlcrWLfyXEIrDCj7KiXwrRStubW3SZMovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=POqeQ+sq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Subject:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=59E14zXjQOPO7+iA8THFZbOksLal0bm23IEI0vy/ywY=; b=POqeQ+sq7SdHzdeYt6lFVuA6DP
	QqYJRrT+ytb8OclMpb1iyWcB2znpqLAy2qpAfekhdeKYaPR3ymI0hiY9l3ZBzfGGOotgqtWk49sd5
	lbyN/lkVwm0N9EgKQRygiuUYT3arlm7f02LVNVNXkA6w9DTYxTN1cO0jaHDUsLj3si0RM4Rb9W71z
	XJIIJPEIp2MGJYoqCScc+PDi9EJPRIX6anPMCtenORd8exjye8nYu/rgtsTlKrhfpESvNaTW4ddLJ
	QwAAKnegXiJvaB00AoAKhKSCrckxMIjY2oRRbXQqw6sOu3HD5mILkZRo2VRarlhhnWACKy5BdRNU9
	MWPUZ6ew==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYiWe-0000000EHkF-3LtS;
	Sat, 10 Feb 2024 08:16:18 +0000
Message-ID: <4a6ab7b8-0dcc-43b8-a647-9be2a767b06d@infradead.org>
Date: Sat, 10 Feb 2024 17:15:44 +0900
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
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v4 net] ps3/gelic: Fix SKB allocation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures") of
6.8-rc1 did not allocate a network SKB for the gelic_descr, resulting in a
kernel panic when the SKB variable (struct gelic_descr.skb) was accessed.

This fix changes the way the napi buffer and corresponding SKB are
allocated and managed.

Reported-by: sambat goson <sombat3960@gmail.com>
Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..a09b534efa32 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -375,20 +375,14 @@ static int gelic_card_init_chain(struct gelic_card *card,
 static int gelic_descr_prepare_rx(struct gelic_card *card,
 				  struct gelic_descr *descr)
 {
-	static const unsigned int rx_skb_size =
-		ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
-		GELIC_NET_RXBUF_ALIGN - 1;
+	static const unsigned int napi_buff_size =
+		round_up(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN);
 	dma_addr_t cpu_addr;
-	int offset;
+	void *napi_buff;
 
 	if (gelic_descr_get_status(descr) !=  GELIC_DESCR_DMA_NOT_IN_USE)
 		dev_info(ctodev(card), "%s: ERROR status\n", __func__);
 
-	descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
-	if (!descr->skb) {
-		descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
-		return -ENOMEM;
-	}
 	descr->hw_regs.dmac_cmd_status = 0;
 	descr->hw_regs.result_size = 0;
 	descr->hw_regs.valid_size = 0;
@@ -397,24 +391,32 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
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
+	cpu_addr = dma_map_single(ctodev(card), napi_buff, napi_buff_size,
+				  DMA_FROM_DEVICE);
+
 	if (dma_mapping_error(ctodev(card), cpu_addr)) {
-		dev_kfree_skb_any(descr->skb);
+		skb_free_frag(napi_buff);
 		descr->skb = NULL;
-		dev_info(ctodev(card),
-			 "%s:Could not iommu-map rx buffer\n", __func__);
+		dev_err_once(ctodev(card), "%s:Could not iommu-map rx buffer\n",
+			     __func__);
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 		return -ENOMEM;
 	}
 
-	descr->hw_regs.payload.size = cpu_to_be32(GELIC_NET_MAX_FRAME);
+	descr->hw_regs.payload.size = cpu_to_be32(napi_buff_size);
 	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
 
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);


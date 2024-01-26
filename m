Return-Path: <netdev+bounces-66140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88D83D93A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 12:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E767AB36806
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52614AA5;
	Fri, 26 Jan 2024 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UaGeNCGt"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99841BF45
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261144; cv=none; b=Uo8HtPG9tRtwdtXBLpe+wu2c4ezVhb6lrSHRRfMtBk03Ud3Qk3THup+pnHcemlkVFV6xyk7tKbHOc+6YrMMYHNW3WD43UgTSOA6a+ruMUZGcJKz72EZplbxBisk/gWc3G4wewn4BKA59xjnxdyagEnx5unI6hyYLMe1WJ8tg5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261144; c=relaxed/simple;
	bh=O/szxyErE4SVpTzsMD1nzmvzsl6leaj4YKpQfDeSMu0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=PBuMylzVsRUSD6K12qwMC+Zrh1BT99SIIODm0S5FzsQVNtWZKMheRCxoyRC+zS8+DZyz8pWspGgzoJ4BBgxm17YVlmvg+UlzktGS4p6wYMhxMZK6WiwhSfnxdg9rth0kzjnnmS6/9bYwhxIAXyeuoRCzMlcDMc0dy8FGblsUaoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UaGeNCGt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Ap9WzIljNUu3jMuK/ZahQACNZoHaidADRP7tUxBNUMU=; b=UaGeNCGtcR3DiPGH5ZFVPCZR7u
	6yQ9gq9jfZKJA5hf6/AkYeZ9yVqAYOxtXTbab4k9piXLwFkJaGKDPQhD5RjSXIb5HgRwkW7NrBmEF
	QhvUpe/tkH2x8CO6Hmmkxq6Wj+JDWLGZVNERLmfaZ6FXQUA7LEuD2rQKZa/RIuBoT2WWaAYeRbhKB
	kB0NsqBVoBl9CQ/tSa86v+aQ4DMMjaAO/cVSJTWM6qzOKCeYNZp3alupmC46ooB/B6/ml4OK6W8QR
	nc7rWLGiQRdAiw8zASc5JnJpBnamvaj14jiJB/ve9V1UDU5PKkHA1heIYQCzjULhEpZ5MbHCMdfb+
	sHfktXjA==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTISu-0000000D9tb-0yRp;
	Fri, 26 Jan 2024 09:25:37 +0000
Message-ID: <1f5ffc7d-4b2e-4f07-bc7e-97d49ccff28c@infradead.org>
Date: Fri, 26 Jan 2024 18:25:31 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH net] ps3/gelic: Fix SKB allocation
To: sambat goson <sombat3960@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
of 6.8-rc1 did not set up the ps3 gelic network SKB's correctly,
resulting in a kernel panic.
    
This fix changes the way the napi buffer and corresponding SKB are
allocated and managed.
    
Reported-by: sambat goson <sombat3960@gmail.com>
Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
Signed-off-by: Geoff Levand <geoff@infradead.org>

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index d5b75af163d3..1870f173e850 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -375,20 +375,16 @@ static int gelic_card_init_chain(struct gelic_card *card,
 static int gelic_descr_prepare_rx(struct gelic_card *card,
 				  struct gelic_descr *descr)
 {
-	static const unsigned int rx_skb_size =
-		ALIGN(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN) +
-		GELIC_NET_RXBUF_ALIGN - 1;
+	static const unsigned int napi_buff_size =
+		round_up(GELIC_NET_MAX_FRAME, GELIC_NET_RXBUF_ALIGN);
+
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
@@ -397,24 +393,33 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
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
+		GELIC_NET_RXBUF_ALIGN);
+
+	if (unlikely(!napi_buff)) {
+		return -ENOMEM;
+	}
+
+	descr->skb = napi_build_skb(napi_buff, napi_buff_size);
+
+	if (unlikely(!descr->skb)) {
+		skb_free_frag(napi_buff);
+		return -ENOMEM;
+	}
+
+	cpu_addr = dma_map_single(dev, napi_buff, napi_buff_size,
+		DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(dev, cpu_addr)) {
+		skb_free_frag(napi_buff);
 		descr->skb = NULL;
-		dev_info(ctodev(card),
-			 "%s:Could not iommu-map rx buffer\n", __func__);
+		dev_err_once(dev, "%s:Could not iommu-map rx buffer\n",
+			__func__);
 		gelic_descr_set_status(descr, GELIC_DESCR_DMA_NOT_IN_USE);
 		return -ENOMEM;
 	}
 
-	descr->hw_regs.payload.size = cpu_to_be32(GELIC_NET_MAX_FRAME);
+	descr->hw_regs.payload.size = cpu_to_be32(napi_buff_size);
 	descr->hw_regs.payload.dev_addr = cpu_to_be32(cpu_addr);
 
 	gelic_descr_set_status(descr, GELIC_DESCR_DMA_CARDOWNED);


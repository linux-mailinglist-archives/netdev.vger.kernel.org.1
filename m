Return-Path: <netdev+bounces-276736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOu9NTHg1mmsJQgAu9opvQ
	(envelope-from <netdev+bounces-276736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:09:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA33C4AE3
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2EFC300A624
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225153A4F24;
	Wed,  8 Apr 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="0FU0a03W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631513A4F5F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689587; cv=none; b=svFzuYiwIrXCqJ5RWYgppJOGJb+kJEyylHy7pLMrzuL/z9Hxuh6MncJcHLTxuPmr3OwWtoCr6pKlJFTKvUgkRvL0zc9gSD+RtPlUVRG6nHlMBwvuWkTE1OaIlAvSyw4YDbH95wlQ+38bGFKD53CUJ4/4SZ8M9Q4SHUTbV42fBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689587; c=relaxed/simple;
	bh=fXVVTuT2LucDBjgyvLhod33t9NcbQmFzfj2SceXVkGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDePxPSk4sjpi2se+i9xu2HIZYIMjoonW3fF8dG7zEjgtawKGa6kUJarfZuHQVdseyp9zItDnqBJhCpN9IhVTnxYPnJn/2L918tKiWmlzBWujUFu2hHAYHpBllupK65xjwgPxBWIUIzE1/XOMqOC+HTfNmIn+ivcNm39La6GYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=0FU0a03W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b0cda2aeso172876a12.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775689580; x=1776294380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/0tFpaFbzTo1zya3B3vdal6d8UBkMJIZuCoRs4U+Ow=;
        b=0FU0a03WRI75cxkvdthe80YSvRngikXJfXcF/vO0IgMSuzN1ObHZHTcYGWKtBxeO1/
         WnUYSXE9dHLHXtGHBmq4MYoD93oWshmkQ/ttm/mEEJaOQEr4XdWj+w+M5Hi3YFjMAQzv
         +8e1rbJ7vFP8RwEcKfwbkSG7pCQYqtXG4006FZNyco0MrO9aqnZixcE78eMro7SjWDy8
         OsYg8G0Mmsfykz/nSlQo+t0tySBvBcoddRhg4yMouRNj4a/4YHU3d26yNPcn8yTxGWai
         VvGbEBIrcoocNwYwFx48ypLKvOwr4fRlzuIUEr9Er1jKF9FOB6LVLYs5aekOUkSmU8S2
         7B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775689580; x=1776294380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4/0tFpaFbzTo1zya3B3vdal6d8UBkMJIZuCoRs4U+Ow=;
        b=lPUtAtQVj6tZUVFmKC2FpioS9sfuh6T88NXKy0smrTnNRHOsAPE6pbnFpTKPpadCYl
         8XysNl2M+qk5Mi1wfCqkoR6u1kqlnNWbsacU9ejx+s5fishtZtTtl4BnZDDSJRE9NTWl
         GJ2gikT9JFrK+GSFf+VjQYESfR/eCBYyN3F2DJIRAlwpqrxNWycFJ/ImvhW7Weeh8W59
         XSDL/c9W7jRZ6ProfGafw81wo1C4sEbGfh7GdhFp2VnCsHAWfTa6Yiw3RI+5EChRGdUk
         q7N7V9mvsHOIXWvyORVxqexibpkyBo/VwLTu7gGXBG2BOx1Xmey1LHv0RSbOXA2AGVV8
         HwqQ==
X-Gm-Message-State: AOJu0YzozrnN+kqVyLPATtAZKx77QvbBP86a7JbN3nyXX0JHR9Y6tsIZ
	P0QipldIo81dO5qpWeMQusTgvXf67p157vuHl5Q8Szu1YF+/hAL+Fq1rP4u5Hk17PzbpJVHcTYE
	58ZNL9PQ=
X-Gm-Gg: AeBDievdtyDIzI+B6tLxudK/rTwc/Odl9Yp9eKZpXo3kecMb018MSJ4wIihISbOMmNc
	IvL0Vl93Bdc5FC8wZSw6vVP4dBYktYEIMz4Om52g/YfujCK37gIqj4vj0mzhcHL0OdxT2ZEEcyH
	tXUvniHMDIwidG858jwsQtHL7Akj6AMS3iuLt/DWvzGKmQqs+tdAuwRfHvd4lmxcaX2JY2vsQnN
	bQB1eWBeElGmmjWwhLzJlmGJXBzbicOTEMpcLvZOmBnv+F3WQS0L7km5colafJDbPTmbfPJC1EW
	0ZGsyMCb5YdqFmABnMMAArmZTihLzIih4nwQ3H2OGM3VoGmYP2tSW4kRZMdt1KNQlx4BrNOasnr
	6OAhhOHb2QDPC2xvCz7bi7YFSetAXm8Vg46n+1cm+NwpzY1bC2BqpRXve5/LMz/elxoQiA2VS2J
	tzRjg=
X-Received: by 2002:a05:6a21:e098:b0:39c:235:c5d7 with SMTP id adf61e73a8af0-39fc8335cf0mr1635427637.39.1775689580393;
        Wed, 08 Apr 2026 16:06:20 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm19886380a12.26.2026.04.08.16.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 16:06:19 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v10 04/10] net: bnxt: Use dma_unmap_len for TX completion unmapping
Date: Wed,  8 Apr 2026 16:05:53 -0700
Message-ID: <20260408230607.2019402-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408230607.2019402-1-joe@dama.to>
References: <20260408230607.2019402-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276736-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 41FA33C4AE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Store the DMA mapping length in each TX buffer descriptor via
dma_unmap_len_set at submit time, and use dma_unmap_len at completion
time.

This is a no-op for normal packets but prepares for software USO,
where header BDs set dma_unmap_len to 0 because the header buffer
is unmapped collectively rather than per-segment.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v10:
   - Wrapped some long lines. No functional changes.

 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 rfcv2:
   - Use some local variables to shorten long lines. No functional change from
     rfcv1.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 63 +++++++++++++++--------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d1f0969b781c..bc2dac2f137d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -656,6 +656,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto tx_free;
 
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
+	dma_unmap_len_set(tx_buf, len, len);
 	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
 		TX_BD_CNT(last_frag + 2);
 
@@ -720,6 +721,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
 		netmem_dma_unmap_addr_set(skb_frag_netmem(frag), tx_buf,
 					  mapping, mapping);
+		dma_unmap_len_set(tx_buf, len, len);
 
 		txbd->tx_bd_haddr = cpu_to_le64(mapping);
 
@@ -809,7 +811,8 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	u16 hw_cons = txr->tx_hw_cons;
 	unsigned int tx_bytes = 0;
 	u16 cons = txr->tx_cons;
-	skb_frag_t *frag;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 	int tx_pkts = 0;
 	bool rc = false;
 
@@ -844,19 +847,27 @@ static bool __bnxt_tx_int(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			goto next_tx_int;
 		}
 
-		dma_unmap_single(&pdev->dev, dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb), DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len,
+					 DMA_TO_DEVICE);
+		}
+
 		last = tx_buf->nr_frags;
 
 		for (j = 0; j < last; j++) {
-			frag = &skb_shinfo(skb)->frags[j];
 			cons = NEXT_TX(cons);
 			tx_buf = &txr->tx_buf_ring[RING_TX(bp, cons)];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		if (unlikely(is_ts_pkt)) {
 			if (BNXT_CHIP_P5(bp)) {
@@ -3394,6 +3405,8 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 {
 	int i, max_idx;
 	struct pci_dev *pdev = bp->pdev;
+	unsigned int dma_len;
+	dma_addr_t dma_addr;
 
 	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
 
@@ -3404,9 +3417,10 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 
 		if (idx  < bp->tx_nr_rings_xdp &&
 		    tx_buf->action == XDP_REDIRECT) {
-			dma_unmap_single(&pdev->dev,
-					 dma_unmap_addr(tx_buf, mapping),
-					 dma_unmap_len(tx_buf, len),
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len,
 					 DMA_TO_DEVICE);
 			xdp_return_frame(tx_buf->xdpf);
 			tx_buf->action = 0;
@@ -3429,23 +3443,28 @@ static void bnxt_free_one_tx_ring_skbs(struct bnxt *bp,
 			continue;
 		}
 
-		dma_unmap_single(&pdev->dev,
-				 dma_unmap_addr(tx_buf, mapping),
-				 skb_headlen(skb),
-				 DMA_TO_DEVICE);
+		if (dma_unmap_len(tx_buf, len)) {
+			dma_addr = dma_unmap_addr(tx_buf, mapping);
+			dma_len = dma_unmap_len(tx_buf, len);
+
+			dma_unmap_single(&pdev->dev, dma_addr, dma_len,
+					 DMA_TO_DEVICE);
+		}
 
 		last = tx_buf->nr_frags;
 		i += 2;
 		for (j = 0; j < last; j++, i++) {
 			int ring_idx = i & bp->tx_ring_mask;
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[j];
 
 			tx_buf = &txr->tx_buf_ring[ring_idx];
-			netmem_dma_unmap_page_attrs(&pdev->dev,
-						    dma_unmap_addr(tx_buf,
-								   mapping),
-						    skb_frag_size(frag),
-						    DMA_TO_DEVICE, 0);
+			if (dma_unmap_len(tx_buf, len)) {
+				dma_addr = dma_unmap_addr(tx_buf, mapping);
+				dma_len = dma_unmap_len(tx_buf, len);
+
+				netmem_dma_unmap_page_attrs(&pdev->dev,
+							    dma_addr, dma_len,
+							    DMA_TO_DEVICE, 0);
+			}
 		}
 		dev_kfree_skb(skb);
 	}
-- 
2.52.0



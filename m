Return-Path: <netdev+bounces-229307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971DABDA65B
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D88F33BB9C9
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 15:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFBB308F2E;
	Tue, 14 Oct 2025 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NNAwD+ks"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE99304BDC;
	Tue, 14 Oct 2025 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455568; cv=none; b=YqluW1i6IczTME8lBvkIFkBp7n5TFtWxhyV45yXkiE40LmYWPkCWblQ+gvCU67axMcR8HTssJqWurNYBnGSZQJ9irKlTvGrltUInV9+FTlCD5NibpL04rrqQmqaBq8bdllRldW4cO9kjUd6YTmETzLyN1YWhY8i7jKsisIMcjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455568; c=relaxed/simple;
	bh=Rr2bcXQc2OD3O32dxGrPel6Y7nYqzIJiZbUkKT/gxKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W06ZJWhhpPAhW2VAT/iHKb+NP+zZKpHdJqRP/e6FwC0sDZUryOBa6xIIQcn6dmRIddKRkn9xTu4rX8bEbKGbmuEVxId6tsa1SGHZswlR04na4u9h06/DHTcXAmOmTeLKZrF9MsI+zWlbvKhNLuoLtpGhxQXxXQu5j6JAXXtRY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NNAwD+ks; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8DAF24E4108F;
	Tue, 14 Oct 2025 15:26:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 63CB3606EC;
	Tue, 14 Oct 2025 15:26:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D748102F22B6;
	Tue, 14 Oct 2025 17:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760455563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mMovQ+bbPU0CMTaaS4M7chqUufiNQaWCJ6pG3zPjyis=;
	b=NNAwD+ksz22jh0RQAo/Y93jBVdQZcYm+qf9Z0dIWjx3hfAl8JFw/+1JO+W9m7Y4/axdnKC
	o6p0IjpPfcF7SeqgsRcyYIxeX6hzQsG1nWaiFRo24p9IWzAh4ko6kDjAt/bgfA1dMvkvPY
	i1VXLc2o14iKZFla6/PPXVr8Kj7/bD0d+KC1hrfB6no9QiRd78Dtd+O91pY27HD5qMbiNe
	yohfWU35iZKlKoue1096ERDUJ+0Fmk/AhOTgInnJ50Hfr59LRhFU7PLMw/2wqT1Mgwvh/q
	k6hWklYQJEr3fMxfhuoj8XbCwaIMDjAjRAi+fuit431dTWMQiiTF8YItOcTz/g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 14 Oct 2025 17:25:13 +0200
Subject: [PATCH net-next 12/15] net: macb: drop `entry` local variable in
 macb_tx_map()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251014-macb-cleanup-v1-12-31cd266e22cd@bootlin.com>
References: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
In-Reply-To: <20251014-macb-cleanup-v1-0-31cd266e22cd@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The pattern:
   entry = macb_tx_ring_wrap(bp, i);
   tx_skb = &queue->tx_skb[entry];
is the exact definition of:
   macb_tx_skb(queue, i);

The pattern:
   entry = macb_tx_ring_wrap(bp, i);
   desc = macb_tx_desc(queue, entry);
is redundant because macb_tx_desc() calls macb_tx_ring_wrap().

One explicit call to macb_tx_ring_wrap() is still required for checking
if it is the last buffer (TX_WRAP case).

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 6c6bc6aa23c718772b95b398e807f193a38e141a..08e541d8f8e68e38442a538ce352508c5db63f52 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1989,7 +1989,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 				unsigned int hdrlen)
 {
 	dma_addr_t mapping;
-	unsigned int len, entry, i, tx_head = queue->tx_head;
+	unsigned int len, i, tx_head = queue->tx_head;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
 	unsigned int offset, size, count = 0;
@@ -2015,8 +2015,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	offset = 0;
 	while (len) {
-		entry = macb_tx_ring_wrap(bp, tx_head);
-		tx_skb = &queue->tx_skb[entry];
+		tx_skb = macb_tx_skb(queue, tx_head);
 
 		mapping = dma_map_single(&bp->pdev->dev,
 					 skb->data + offset,
@@ -2046,8 +2045,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 		offset = 0;
 		while (len) {
 			size = umin(len, bp->max_tx_length);
-			entry = macb_tx_ring_wrap(bp, tx_head);
-			tx_skb = &queue->tx_skb[entry];
+			tx_skb = macb_tx_skb(queue, tx_head);
 
 			mapping = skb_frag_dma_map(&bp->pdev->dev, frag,
 						   offset, size, DMA_TO_DEVICE);
@@ -2084,9 +2082,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	 * to set the end of TX queue
 	 */
 	i = tx_head;
-	entry = macb_tx_ring_wrap(bp, i);
 	ctrl = MACB_BIT(TX_USED);
-	desc = macb_tx_desc(queue, entry);
+	desc = macb_tx_desc(queue, i);
 	desc->ctrl = ctrl;
 
 	if (lso_ctrl) {
@@ -2106,16 +2103,15 @@ static unsigned int macb_tx_map(struct macb *bp,
 
 	do {
 		i--;
-		entry = macb_tx_ring_wrap(bp, i);
-		tx_skb = &queue->tx_skb[entry];
-		desc = macb_tx_desc(queue, entry);
+		tx_skb = macb_tx_skb(queue, i);
+		desc = macb_tx_desc(queue, i);
 
 		ctrl = (u32)tx_skb->size;
 		if (eof) {
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
 		}
-		if (unlikely(entry == (bp->tx_ring_size - 1)))
+		if (unlikely(macb_tx_ring_wrap(bp, i) == bp->tx_ring_size - 1))
 			ctrl |= MACB_BIT(TX_WRAP);
 
 		/* First descriptor is header descriptor */

-- 
2.51.0



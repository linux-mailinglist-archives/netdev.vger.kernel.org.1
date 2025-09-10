Return-Path: <netdev+bounces-221771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8499B51D51
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4E3BE1D7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82721337699;
	Wed, 10 Sep 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RZN5P6ce"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4A3375C2;
	Wed, 10 Sep 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521002; cv=none; b=ZXD5sGqfBJGmG+JLmlJ+9fU/dzr5aYP+RrOA7C7B75RN0GwQUmJPAbItp3gUPd0Fpe6qfkL6NVtCrPAvqLjLbedV5b4tfkhsSjzB1bERz2Zvo21hSFFQrhcFeNfZHtjfbvbR5KvweaS1f09L6Wv0o0O5apvSXrwXrNnkQVyDN7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521002; c=relaxed/simple;
	bh=BeobAv07xjOjICoXgtgNMpxQ/3t9JQQYycP5qPziRLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFJygzlwqmGb8XvStn3fTPdxWks/SInmvItItdK/Sf+3jy8XCZlQ9u3Z5jdGS0Oe35v5FYjzUsiSdnpSBa0tm0f1jdTHNlt5mU3CHaWSHaPv5FSkWlTXdrjIWYTipHnzIQJnUbCHBR2wFZw6Sv6BAIR7y7VtAHm+gJLOCuxMgu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RZN5P6ce; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BA4FC4E40BBC;
	Wed, 10 Sep 2025 16:16:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB15D606D4;
	Wed, 10 Sep 2025 16:16:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8BC0102F28A8;
	Wed, 10 Sep 2025 18:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757520997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=brKOdnCK4c79eJgxsJqiOYDIVJbIJn3tEsmqO4UvEPQ=;
	b=RZN5P6ceUy23JZd0SwqAYEZJe9ol0o1dLImJ2kAFd3unpcUX6rdZrMgJ5ABPLxXcc9Fqar
	lYMewixIcRO8NHXv3UrdBwM1BTpoMc/BGD/rC0wozyepfzZb5Xbz2xVXNSmS5Yz5EBZFnd
	L7aYK+MtbQlxc5LdpsEhhcXzXv+YW1NlLlG6dS0As6Aj3JNPRLNvoW0RDAeGWeCs6cIR8H
	ZQ1lgANiZI7NoiK55xbaMHg1XX4AbnmGwnGp7zLw/pdq4LLO81G7srU0+uGcipnpDEDprS
	dmFfbQEoHbe6Ua4bG4z6WWqvLBm1s8aszAqtJ6sPcGiLLIHlMAAHhbP2nQNw9A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 10 Sep 2025 18:15:32 +0200
Subject: [PATCH net v5 3/5] net: macb: move ring size computation to
 functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250910-macb-fixes-v5-3-f413a3601ce4@bootlin.com>
References: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
In-Reply-To: <20250910-macb-fixes-v5-0-f413a3601ce4@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Harini Katakam <harini.katakam@xilinx.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

The tx/rx ring size calculation is somewhat complex and partially hidden
behind a macro. Move that out of the {RX,TX}_RING_BYTES() macros and
macb_{alloc,free}_consistent() functions into neat separate functions.

In macb_free_consistent(), we drop the size variable and directly call
the size helpers in the arguments list. In macb_alloc_consistent(), we
keep the size variable that is used by netdev_dbg() calls.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3e634049dadf14d371eac68448f80b111f228dfd..73840808ea801b35a64a296dedc3a91e6e1f9f51 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -51,14 +51,10 @@ struct sifive_fu540_macb_mgmt {
 #define DEFAULT_RX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_RX_RING_SIZE	64
 #define MAX_RX_RING_SIZE	8192
-#define RX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->rx_ring_size)
 
 #define DEFAULT_TX_RING_SIZE	512 /* must be power of 2 */
 #define MIN_TX_RING_SIZE	64
 #define MAX_TX_RING_SIZE	4096
-#define TX_RING_BYTES(bp)	(macb_dma_desc_get_size(bp)	\
-				 * (bp)->tx_ring_size)
 
 /* level of occupied TX descriptors under which we wake up TX process */
 #define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
@@ -2470,11 +2466,20 @@ static void macb_free_rx_buffers(struct macb *bp)
 	}
 }
 
+static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
+}
+
+static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+{
+	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
+}
+
 static void macb_free_consistent(struct macb *bp)
 {
 	struct macb_queue *queue;
 	unsigned int q;
-	int size;
 
 	if (bp->rx_ring_tieoff) {
 		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
@@ -2488,14 +2493,14 @@ static void macb_free_consistent(struct macb *bp)
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
 		if (queue->tx_ring) {
-			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_tx_ring_size_per_queue(bp),
 					  queue->tx_ring, queue->tx_ring_dma);
 			queue->tx_ring = NULL;
 		}
 		if (queue->rx_ring) {
-			size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
-			dma_free_coherent(&bp->pdev->dev, size,
+			dma_free_coherent(&bp->pdev->dev,
+					  macb_rx_ring_size_per_queue(bp),
 					  queue->rx_ring, queue->rx_ring_dma);
 			queue->rx_ring = NULL;
 		}
@@ -2546,7 +2551,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	int size;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
+		size = macb_tx_ring_size_per_queue(bp);
 		queue->tx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->tx_ring_dma,
 						    GFP_KERNEL);
@@ -2564,7 +2569,7 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 
-		size = RX_RING_BYTES(bp) + bp->rx_bd_rd_prefetch;
+		size = macb_rx_ring_size_per_queue(bp);
 		queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev, size,
 						    &queue->rx_ring_dma,
 						    GFP_KERNEL);

-- 
2.51.0



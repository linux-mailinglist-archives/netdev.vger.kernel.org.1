Return-Path: <netdev+bounces-225671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E8B96B26
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6164A0BF7
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DB22E62BF;
	Tue, 23 Sep 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BShCVHW/"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14B2E3B0D;
	Tue, 23 Sep 2025 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643262; cv=none; b=FY61Qb6V2hvElRV3H2/JXF+9Oahiu7JQYJULDUcuIA40cCBXaeZM3uYhJxblU/SdRArr9FofFIR2QhN6U0KKClVIS90NWdTYlQtt1MDPBdAhuVCvlMHGN9zjso9K2Y68r81mWAIgS+Wa3bApqBNIM2WGhkOrzRsO/4spEoLkMFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643262; c=relaxed/simple;
	bh=BeobAv07xjOjICoXgtgNMpxQ/3t9JQQYycP5qPziRLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A9dyo9RSaRDNCXTLIOV/gH2PfzS2/ohmgzJosf3d/AJ2UwxQ8Mbl/pLuwqDxAYLeJHPlhpJasZqRtjOHQHhbIkPscS4CWAQ25zcawA6pC1rQxDFN2SH8xZhruQrJzJ4KCawX14qDQEwD9jIyNQ/e1CKSbCj0b6ueMvzQPX7g+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BShCVHW/; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2EF241A0E8B;
	Tue, 23 Sep 2025 16:00:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0520460690;
	Tue, 23 Sep 2025 16:00:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F980102F1960;
	Tue, 23 Sep 2025 18:00:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758643258; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=brKOdnCK4c79eJgxsJqiOYDIVJbIJn3tEsmqO4UvEPQ=;
	b=BShCVHW/RFBMXPKnRN+GaY+AmU95axdZeEZ+KhHBFHy7HoVBGB63MtFGUlp8gyi7c809PX
	Ks30xvD7eaMbs5uxNQ1GpTG9d6vGHQ4k/jwgvetZiZHFIeS0v390Ked6fDaItMuJjdycwR
	EpxNcTSgNDm1Edr+y+tqV0l8LbtmnqJVzZwjo7Y15qexX9jTYZUt3cTF0Nsw613scLue81
	/c6eUuFSqKOZTHp++xHgoUCb22ToL+6WzJDtHfYoFLIw+wgV9ATtc9TGLKI6Si2+KfktAt
	eojB9RY5XpgUyT2LZq5NcutxOgOALiFxJrHOMnoPoSYginOVgAYmF27pLyR8UQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 23 Sep 2025 18:00:25 +0200
Subject: [PATCH net v6 3/5] net: macb: move ring size computation to
 functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250923-macb-fixes-v6-3-772d655cdeb6@bootlin.com>
References: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
In-Reply-To: <20250923-macb-fixes-v6-0-772d655cdeb6@bootlin.com>
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



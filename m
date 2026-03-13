Return-Path: <netdev+bounces-267577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BjqAVJwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1F2899DF
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77F03114914
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA13E3E3174;
	Fri, 13 Mar 2026 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOMkZ8Qw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fgKzH6Q4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384E3D2FEC
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432901; cv=none; b=bDeExAKVfu9OM6ehg3VW/WQE0PYATOSSrw01lvEnf3lV9XxU2nK9sZd8tMZwUrYAm1iysYmcS87VZQeVpG1BhFpXBzVXXuRQeqjPL2uoDaRI80grzQJx4NF0iGWnTUPl6l40wDWCxP+UvqCVIGjf4lwRJ/DR1K7NGHoKRDCVduU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432901; c=relaxed/simple;
	bh=qpOe0XG/cB2ABjNk17aoqsvjGec8/Z+eDhkEFp09ihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C3T4UZz3VFh4+jMh/nRqJLoC/XAOWL5pKb8V4KCo/1B0QXARErUcx7OOcMaXdHbrolnUl+xJw5t5PKJYdiygxLMOkO6BVTD+aralnsGeZ804NmYxlod4Xj9LjbHtVTs5FPwyJRgHtlFzUIaRiymVh4cXieGnTZgcB5X4GAhmJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LOMkZ8Qw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fgKzH6Q4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/hZTtLNBgxVe8GXrBi2b7FN8EjQwBFmFmShOY41pI4=;
	b=LOMkZ8QwE92MtdyfYNQWd8hl4vnktZ/FeuaDqZsYIlivp7yCiHuAVYZSVldAQhhw3Om4oM
	BBlpweaUjYPoXMZNlW3wg3kldiv1Rk4YM7dyVs6ctJY1U0p1/Hb2faiSUCE2RmrTv5mB16
	2q9Y44lju4VdEX5dfS006oMtfIH9Agw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-3yJ4ple9PzGQ-RSr64z_jw-1; Fri, 13 Mar 2026 16:14:57 -0400
X-MC-Unique: 3yJ4ple9PzGQ-RSr64z_jw-1
X-Mimecast-MFC-AGG-ID: 3yJ4ple9PzGQ-RSr64z_jw_1773432897
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c4d71603so2543504f8f.0
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432896; x=1774037696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/hZTtLNBgxVe8GXrBi2b7FN8EjQwBFmFmShOY41pI4=;
        b=fgKzH6Q4ztH0bc/Ah/KA+gBYhRMBoD8ADjhmc/Da0eYW+IcxyyLH3QwRx4dtG48qg8
         WLxGUyIHehI3cewceYqFJMHrzMB6Fs5YWuTvjZ+uBR8rdDrOPYy1W1/QICXKP5YG2ILX
         tXjPwEUPeD2a7NBOzI9pJ4O1HPMcVgiAg+g9e0xLX/UymT3eAVx9pis3OyO9yzFkb47q
         7hlfMck9a1XOWFyNR5HHih83RFQjbU0UKNk8zTdwCM4+J7lV2BNX0GLUb/elG3nDlKKC
         p+qaX63fFLrpJLPHBRXQgIigfmgQ2HQz2G/p1Iu+4MMXINUaBhf8+B4KHG5mR9SIIOzs
         Hn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432896; x=1774037696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/hZTtLNBgxVe8GXrBi2b7FN8EjQwBFmFmShOY41pI4=;
        b=KSAYw4hHKfT0tQgDZ/3mWBFpGOTKO3dZVG9ojF7wn5cvWz/kMyiSjJD+sGgNJh4tjw
         uonYunOAg8+CVd8zQBmIB42pKkiDpLIRGPRGBppEmqBXL9ME2Olawp84llHEO5WNrmBP
         s5Db8Q2blhZGcdwJWFJTy8Hbexl63tBPZOcUH0cAj8mg0txu7HP8bl9jlQ9RzFRfc2rl
         eY+mSDLhvG9yX3MSMJbRqjjsE/cRdb3Qyek9FxCsvkesRom8qk3fCCkm58LI5zg/cPzQ
         H+TjervHLCmsMBsmj6GED44lrs4I5gBN3gWIgZP//0gdgla41X1i+uIjYgMVimncZtLU
         14jg==
X-Gm-Message-State: AOJu0YwvUMdaqULqrnyhPfOiLYuCew8SJxgV/raYtfzl7Ywp50vZpOJl
	CXOeXe7JLaEAq8fEziSIvO0aQl7iXmv8Op+zOq8WUgunUZNqPj9G2dmoBQgeFiLwEnLgVw7HbWs
	ZgGcxRGjI418GMgnpWrA8MmQ/Ix2n0c34vy+VZItJoDd6hzU5KGREq1h13sm+/HRXtIV9s/sUU4
	VEJb+jKPwtqeEpNH5lL+H5St9xN6lE37eN+GHXCImHCg==
X-Gm-Gg: ATEYQzyVhs8WN3RHaXzp0qvZJ35EM/No7NsaDdPonOQwX43DKsqVczlWq4Qj4MaUy6x
	v0FA3qhKMHTVhnM0U/LAG2+IGZ6jbdZac1cGVWZo9G9SS5pFYmhpzLYczZiGUeJlbHDgI69dqO/
	xhoIHyFAAlD2jir9N4RbLkaV7mLULvBAwovPtp6+IfXlgDTuagbh4UVLTPKZJCOTCLHXmNB6754
	5rH1fkuWUafe73o8SAy2IieTGsYGWOZiUwzPwAycyMz7daQiQzHrpCorzPAtC6cHwD3/QwPsuPv
	c0XYyq7P130NkLeUQhJOiID0qlczy9JyckAMKUN/C26Hd4Y0hzP0rNpFD4S3wINGdwI7bt8WTTk
	nJHQYnXG7MCA7GDPyCUXa3AoeJWLfMyhrLA60rLUfmqIqEKuvHRLqEX+Z+lc=
X-Received: by 2002:a05:600c:350e:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-48555ac7160mr77893075e9.5.1773432895721;
        Fri, 13 Mar 2026 13:14:55 -0700 (PDT)
X-Received: by 2002:a05:600c:350e:b0:483:6d9e:e4f5 with SMTP id 5b1f17b1804b1-48555ac7160mr77892725e9.5.1773432895160;
        Fri, 13 Mar 2026 13:14:55 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855638cebcsm65872115e9.0.2026.03.13.13.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:14:54 -0700 (PDT)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v5 1/8] net: macb: move Rx buffers alloc from link up to open
Date: Fri, 13 Mar 2026 21:14:26 +0100
Message-ID: <20260313201433.2346119-2-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267577-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FD1F2899DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

mog_alloc_rx_buffers(), getting called at open, does not do rx buffer
alloc on GEM. The bulk of the work is done by gem_rx_refill() filling
up all slots with valid buffers.

gem_rx_refill() is called at link up by
gem_init_rings() == bp->macbgem_ops.mog_init_rings().

Move operation to macb_open(), mostly to allow it to fail early and
loudly rather than init the device with Rx mostly broken.

About `bool fail_early`:
 - When called from macb_open(), ring init fails as soon as a queue
   cannot be refilled.
 - When called from macb_hresp_error_task(), we do our best to reinit
   the device: we still iterate over all queues and try refilling all
   even if a previous queue failed.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++++++------
 2 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index c69828b27dae..0acc188fe547 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1195,7 +1195,7 @@ struct macb_queue;
 struct macb_or_gem_ops {
 	int	(*mog_alloc_rx_buffers)(struct macb *bp);
 	void	(*mog_free_rx_buffers)(struct macb *bp);
-	void	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_init_rings)(struct macb *bp, bool fail_early);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5e27e0e87a55..2c36d3844bf5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1474,13 +1474,14 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static void gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_queue *queue)
 {
 	unsigned int		entry;
 	struct sk_buff		*skb;
 	dma_addr_t		paddr;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	int err = 0;
 
 	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
 			bp->rx_ring_size) > 0) {
@@ -1497,6 +1498,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 			if (unlikely(!skb)) {
 				netdev_err(bp->dev,
 					   "Unable to allocate sk_buff\n");
+				err = -ENOMEM;
 				break;
 			}
 
@@ -1546,6 +1548,7 @@ static void gem_rx_refill(struct macb_queue *queue)
 
 	netdev_vdbg(bp->dev, "rx ring: queue: %p, prepared head %d, tail %d\n",
 			queue, queue->rx_prepared_head, queue->rx_tail);
+	return err;
 }
 
 /* Mark DMA descriptors from begin up to and not including end as unused */
@@ -1998,7 +2001,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(dev);
 	netif_carrier_off(dev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(bp, false);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2772,8 +2775,6 @@ static int macb_alloc_consistent(struct macb *bp)
 		if (!queue->tx_skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
-		goto out_err;
 
 	/* Required for tie off descriptor for PM cases */
 	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
@@ -2785,6 +2786,11 @@ static int macb_alloc_consistent(struct macb *bp)
 			goto out_err;
 	}
 
+	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+		goto out_err;
+	if (bp->macbgem_ops.mog_init_rings(bp, true))
+		goto out_err;
+
 	return 0;
 
 out_err:
@@ -2805,11 +2811,13 @@ static void macb_init_tieoff(struct macb *bp)
 	desc->ctrl = 0;
 }
 
-static void gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb *bp, bool fail_early)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	int last_err = 0;
 	unsigned int q;
+	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2825,13 +2833,24 @@ static void gem_init_rings(struct macb *bp)
 		queue->rx_tail = 0;
 		queue->rx_prepared_head = 0;
 
-		gem_rx_refill(queue);
+		/* We get called in two cases:
+		 *  - open: we can propagate alloc errors (so fail early),
+		 *  - HRESP error: cannot propagate, we attempt to reinit
+		 *    all queues in case of failure.
+		 */
+		err = gem_rx_refill(queue);
+		if (err) {
+			last_err = err;
+			if (fail_early)
+				break;
+		}
 	}
 
 	macb_init_tieoff(bp);
+	return last_err;
 }
 
-static void macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb *bp, bool fail_early)
 {
 	int i;
 	struct macb_dma_desc *desc = NULL;
@@ -2848,6 +2867,7 @@ static void macb_init_rings(struct macb *bp)
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	macb_init_tieoff(bp);
+	return 0;
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -3179,7 +3199,6 @@ static int macb_open(struct net_device *dev)
 		goto pm_exit;
 	}
 
-	bp->macbgem_ops.mog_init_rings(bp);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-- 
2.53.0



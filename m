Return-Path: <netdev+bounces-262633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAy3EZh6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:55:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE431D7EC6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F25D0301AAB7
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136A5364952;
	Mon,  2 Mar 2026 11:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCftJ+vy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mZcLoGFy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDD363C6C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452375; cv=none; b=McWa6AZ/szOtxeh7ku2Lr97q5MCdAV52vWJXl0sHG2MVFFXFqyfInTnLl+Jc3CFFmaEbl1VvmNRfgee3+u6VwMoexfFRZb3iN/OZWftmz4SeeQejZzaH9LwkTELTy9RdnkvxPzSrkPSDP24lskpef8wmlgc/YEJ2Gl50+jogM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452375; c=relaxed/simple;
	bh=sDUgJ+Hsfqk/0FZhqM2oZMdoyC2V1zUND8NepEEBEZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEWbaXS+e19/ugSE4826MVLT688boQb8QYghL1lPhpeSKb12RgyH838nBEiw+m+vmxHbH67pTRbV8+U0JdlAIsOsWYeOIi6TaxSPEvVfYnP1KP68oTA51980Z0U8WWOruI6BOUTGliJ7/FCvYSXgxutPoPZ7SQ2TlNov/HxL4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCftJ+vy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mZcLoGFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ad1JGsdqxgnr0B5+QqB8Bpn/MTbrqDdhReIhVLyWdTk=;
	b=VCftJ+vy19pWl9pUh2Vr90T/16rTrLDcpeFOwGkp6iVjyzOtd7Oug4HaNws+ePOecN2llX
	OAJMHXrV46m0FQ7j3aT7c2bP+4I7aATnifmJcoZ6ZFRKDPQ/RdFqt9wwQvhf9jRGV1VaFk
	qpW7Whva6dhc51AUP/8SvJULajbAGgM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ffATj3UMPFG0TlKT2EL-4Q-1; Mon, 02 Mar 2026 06:52:51 -0500
X-MC-Unique: ffATj3UMPFG0TlKT2EL-4Q-1
X-Mimecast-MFC-AGG-ID: ffATj3UMPFG0TlKT2EL-4Q_1772452370
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48071615686so34485285e9.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452369; x=1773057169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad1JGsdqxgnr0B5+QqB8Bpn/MTbrqDdhReIhVLyWdTk=;
        b=mZcLoGFyBJQruwuKqC3+w2syPKvtBU6HFcSk2Pwd4UJzu1/Ev2yTg9iaD4niiTx1Qh
         hAtx9V/fFLJ3Bio2LAV4Xyrnm3mKqfqD01KWwPM5YRVlGbLRKGcxMtY5COO+YeIQ0wlL
         6XQvWRrEBnmjKfY+oj/px6bX6UZ7DEYO4TRc8YPeNO/XQNVSTWSo3LQ69E+ap90lOVnx
         ZuMjT+i8yWIWUkMhcxyVFgy1ooRHPBJMcqNpSdGB2/lHDJegMy6wXZGt7AtNNGFbh/up
         ZjdrvM2K2axwxDzz1QpaAj5Ik2LWQJJ6qdKh0cNJEZl9ftnIhiKilG5pQId6nAPSYP91
         vARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452369; x=1773057169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ad1JGsdqxgnr0B5+QqB8Bpn/MTbrqDdhReIhVLyWdTk=;
        b=mZ+lWn9Cx4m3ilyhEl2ahH+nE3cWvOo1n25RwhxAuUiuMVSNdzPLRB3H1E9DtAQ/sA
         q+PA1J2BiABtAemhTEr7awNGWsA7shEWQShPF0brfLOwJEi4g2iVZV2bxF6H/1vRfWOx
         HT7oCDWeFQ+4T6TZ8S9AiXPj/QQQtQdrH3qM5vOgL2296HPLckGMcM3Bw2lkKN2RLlLA
         zL/gzwfrMONrDv55HpYzVSObuYYfAmsjuYrs+d4Rblt/7h7hWb+W5D0kbc4C+sRh0Uor
         9gz8jRFrS2qkEEVWOavTIaT9RjKbYe2ZsgIKC5Zv+ja3rc+652NE0G2QLZjq/NKAar9I
         jvrg==
X-Gm-Message-State: AOJu0YzMr6lrgRlAq97QL+iOmIkIe3mFpKlq50uwffabWWTg0Kcy6V4r
	ru0fFwB8PzBoNh1YZPg9IJUayWCaZic0A5ebjtBG/Jp6i67svGhUGub0kOOoAuF2SqCRARycvN2
	7twH+qn3yGgJg9Wjdqmv/ADkljcF3jSLcB/yyi6ABlUwYytojs0WNqwrGxiMu0AZwB9bT/r3dwI
	O2/bONRHsaJwPnXX/yRcOELjrYRZvyWdDQ1SubtCN3cQ==
X-Gm-Gg: ATEYQzxpKlIEgxnMsKdzK0uS9SI1hvI1mS/qXjAEFdrOcOme03PlCy8oSONn1rrmFdp
	c1Hmo0iX8ULI4YZoB6+dXmLLX+qvKQUAfwSrL4OV0oJPCXdTU4KKMJn+NLzs8R/8JOYIf+jPrhd
	OBZ5FX5NLltIq68Hx4Ua1NN46uEMxTNXbePHTLVeW/fNHE3XAeD+qCO74J72ZQ0YAmwb7km7qJP
	OFKyM7uqp/+P5M/jjUsDdR96quhoJVlDV5IsSaaVrUj+ADuuVKh83Tgh2e8QmNNVKACgpZgUsjP
	zw51XC8EbJGjkRq/70fGREe63pVNfqvphc4pPBe34Qug2eEO+Xgunzek29K+VkV8Z8CT8oVcLTK
	toEQnC3yU+qON+0krzHgVVlxxjz70SWubb2bKqiXWFFk6QurrydFrS9Y7AqA=
X-Received: by 2002:a05:600c:4592:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-483c9bad6femr206391545e9.12.1772452368948;
        Mon, 02 Mar 2026 03:52:48 -0800 (PST)
X-Received: by 2002:a05:600c:4592:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-483c9bad6femr206390905e9.12.1772452368347;
        Mon, 02 Mar 2026 03:52:48 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm474653265e9.13.2026.03.02.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:47 -0800 (PST)
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
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v3 7/8] net: macb: add XDP support for gem
Date: Mon,  2 Mar 2026 12:52:31 +0100
Message-ID: <20260302115232.1430640-8-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262633-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FE431D7EC6
X-Rspamd-Action: no action

Introduce basic XDP support for macb/gem with the XDP_TX, XDP_PASS,
XDP_DROP, XDP_REDIRECT verdict support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 362 ++++++++++++++++++++---
 2 files changed, 331 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 1ae80938331b..009a44e94726 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -15,6 +15,7 @@
 #include <linux/phy/phy.h>
 #include <linux/workqueue.h>
 #include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #define MACB_GREGS_NBR 16
 #define MACB_GREGS_VERSION 2
@@ -1278,6 +1279,7 @@ struct macb_queue {
 	struct queue_stats stats;
 	struct page_pool	*page_pool;
 	struct sk_buff		*skb;
+	struct xdp_rxq_info	xdp_rxq;
 };
 
 struct ethtool_rx_fs_item {
@@ -1378,6 +1380,7 @@ struct macb {
 
 	struct macb_pm_data pm_data;
 	const struct macb_usrio_config *usrio;
+	struct bpf_prog	__rcu *prog;
 };
 
 #ifdef CONFIG_MACB_USE_HWSTAMP
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fc6ea1391846..152cbf5eb33a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/bpf_trace.h>
 #include <linux/circ_buf.h>
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
@@ -982,6 +983,18 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
+static void macb_tx_release_buff(void *buff, enum macb_tx_buff_type type, int budget)
+{
+	if (type == MACB_TYPE_SKB) {
+		napi_consume_skb(buff, budget);
+	} else {
+		if (!budget)
+			xdp_return_frame(buff);
+		else
+			xdp_return_frame_rx_napi(buff);
+	}
+}
+
 static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 			  int budget)
 {
@@ -996,7 +1009,7 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
 	}
 
 	if (tx_buff->ptr) {
-		napi_consume_skb(tx_buff->ptr, budget);
+		macb_tx_release_buff(tx_buff->ptr, tx_buff->type, budget);
 		tx_buff->ptr = NULL;
 	}
 }
@@ -1060,7 +1073,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	 * network engine about the macb/gem being halted.
 	 */
 	napi_disable(&queue->napi_tx);
-	spin_lock_irqsave(&bp->lock, flags);
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+	spin_lock(&bp->lock);
 
 	/* Make sure nobody is trying to queue up new packets */
 	netif_tx_stop_all_queues(bp->dev);
@@ -1084,6 +1098,10 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
+
+		if (tx_buff->type != MACB_TYPE_SKB)
+			goto unmap;
+
 		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
@@ -1121,6 +1139,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
+unmap:
 		macb_tx_unmap(bp, tx_buff, 0);
 	}
 
@@ -1152,7 +1171,8 @@ static void macb_tx_error_task(struct work_struct *work)
 	netif_tx_start_all_queues(bp->dev);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 
-	spin_unlock_irqrestore(&bp->lock, flags);
+	spin_unlock(&bp->lock);
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 	napi_enable(&queue->napi_tx);
 }
 
@@ -1190,6 +1210,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
 	unsigned long flags;
+	int skb_packets = 0;
 	unsigned int tail;
 	unsigned int head;
 	u16 queue_index;
@@ -1204,6 +1225,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_tx_buff *tx_buff;
 		struct macb_dma_desc *desc;
 		struct sk_buff *skb;
+		void *data = NULL;
 		u32 ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1222,10 +1244,18 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->ptr;
+
+			if (tx_buff->type != MACB_TYPE_SKB) {
+				data = tx_buff->ptr;
+				packets++;
+				goto unmap;
+			}
 
 			/* First, update TX stats if needed */
-			if (skb) {
+			if (tx_buff->ptr) {
+				data = tx_buff->ptr;
+				skb = tx_buff->ptr;
+
 				if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 				    !ptp_one_step_sync(skb))
 					gem_ptp_do_txstamp(bp, skb, desc);
@@ -1237,24 +1267,26 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 				queue->stats.tx_packets++;
 				bp->dev->stats.tx_bytes += skb->len;
 				queue->stats.tx_bytes += skb->len;
+				skb_packets++;
 				packets++;
 				bytes += skb->len;
 			}
 
+unmap:
 			/* Now we can safely release resources */
 			macb_tx_unmap(bp, tx_buff, budget);
 
-			/* skb is set only for the last buffer of the frame.
-			 * WARNING: at this point skb has been freed by
+			/* data is set only for the last buffer of the frame.
+			 * WARNING: at this point the buffer has been freed by
 			 * macb_tx_unmap().
 			 */
-			if (skb)
+			if (data)
 				break;
 		}
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->dev, queue_index),
-				  packets, bytes);
+				  skb_packets, bytes);
 
 	queue->tx_tail = tail;
 	if (__netif_subqueue_stopped(bp->dev, queue_index) &&
@@ -1298,9 +1330,27 @@ static inline int gem_rx_data_len(struct macb *bp, struct macb_queue *queue,
 	return len;
 }
 
+static unsigned int gem_rx_pad(struct macb *bp)
+{
+	if (rcu_access_pointer(bp->prog))
+		return XDP_PACKET_HEADROOM;
+
+	return NET_SKB_PAD;
+}
+
+static unsigned int gem_max_rx_data_size(int base_sz)
+{
+	return SKB_DATA_ALIGN(base_sz + ETH_HLEN + ETH_FCS_LEN);
+}
+
+static unsigned int __gem_total_rx_buffer_size(int data_sz, unsigned int headroom)
+{
+	return SKB_HEAD_ALIGN(data_sz + headroom);
+}
+
 static unsigned int gem_total_rx_buffer_size(struct macb *bp)
 {
-	return SKB_HEAD_ALIGN(bp->rx_buffer_size + NET_SKB_PAD);
+	return __gem_total_rx_buffer_size(bp->rx_buffer_size, gem_rx_pad(bp));
 }
 
 static int gem_rx_refill(struct macb_queue *queue, bool napi)
@@ -1336,7 +1386,8 @@ static int gem_rx_refill(struct macb_queue *queue, bool napi)
 				break;
 			}
 
-			paddr = page_pool_get_dma_addr(page) + NET_SKB_PAD + offset;
+			paddr = page_pool_get_dma_addr(page) +
+				gem_rx_pad(bp) + offset;
 
 			dma_sync_single_for_device(&bp->pdev->dev,
 						   paddr, bp->rx_buffer_size,
@@ -1390,12 +1441,155 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 	 */
 }
 
+static int macb_xdp_submit_frame(struct macb *bp, struct xdp_frame *xdpf,
+				 struct net_device *dev, dma_addr_t addr)
+{
+	struct macb_tx_buff *tx_buff;
+	int cpu = smp_processor_id();
+	struct macb_dma_desc *desc;
+	struct macb_queue *queue;
+	unsigned int next_head;
+	unsigned long flags;
+	u16 queue_index;
+	int err = 0;
+	u32 ctrl;
+
+	queue_index = cpu % bp->num_queues;
+	queue = &bp->queues[queue_index];
+
+	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
+
+	/* This is a hard error, log it. */
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1) {
+		netif_stop_subqueue(dev, queue_index);
+		netdev_dbg(bp->dev, "tx_head = %u, tx_tail = %u\n",
+			   queue->tx_head, queue->tx_tail);
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	/* progs can adjust the head. Sync and set the adjusted one.
+	 * This also implicitly takes into account ip alignment,
+	 * if present.
+	 */
+	addr += xdpf->headroom + sizeof(*xdpf);
+
+	dma_sync_single_for_device(&bp->pdev->dev, addr,
+				   xdpf->len, DMA_BIDIRECTIONAL);
+
+	next_head = queue->tx_head + 1;
+
+	ctrl = MACB_BIT(TX_USED);
+	desc = macb_tx_desc(queue, next_head);
+	desc->ctrl = ctrl;
+
+	desc = macb_tx_desc(queue, queue->tx_head);
+	tx_buff = macb_tx_buff(queue, queue->tx_head);
+	tx_buff->ptr = xdpf;
+	tx_buff->type = MACB_TYPE_XDP_TX;
+	tx_buff->mapping = 0;
+	tx_buff->size = xdpf->len;
+	tx_buff->mapped_as_page = false;
+
+	ctrl = (u32)tx_buff->size;
+	ctrl |= MACB_BIT(TX_LAST);
+
+	if (unlikely(macb_tx_ring_wrap(bp, queue->tx_head) == (bp->tx_ring_size - 1)))
+		ctrl |= MACB_BIT(TX_WRAP);
+
+	/* Set TX buffer descriptor */
+	macb_set_addr(bp, desc, addr);
+	/* desc->addr must be visible to hardware before clearing
+	 * 'TX_USED' bit in desc->ctrl.
+	 */
+	wmb();
+	desc->ctrl = ctrl;
+	queue->tx_head = next_head;
+
+	/* Make newly initialized descriptor visible to hardware */
+	wmb();
+
+	spin_lock(&bp->lock);
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
+	spin_unlock(&bp->lock);
+
+	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
+		netif_stop_subqueue(dev, queue_index);
+
+unlock:
+	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
+
+	return err;
+}
+
+static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
+		       unsigned int *len, unsigned int *headroom,
+		       dma_addr_t addr)
+{
+	struct net_device *dev;
+	struct xdp_frame *xdpf;
+	struct bpf_prog *prog;
+	struct xdp_buff xdp;
+
+	u32 act = XDP_PASS;
+
+	rcu_read_lock();
+
+	prog = rcu_dereference(queue->bp->prog);
+	if (!prog)
+		goto out;
+
+	xdp_init_buff(&xdp, gem_total_rx_buffer_size(queue->bp), &queue->xdp_rxq);
+	xdp_prepare_buff(&xdp, buff_head, *headroom, *len, false);
+	xdp_buff_clear_frags_flag(&xdp);
+	dev = queue->bp->dev;
+
+	act = bpf_prog_run_xdp(prog, &xdp);
+	switch (act) {
+	case XDP_PASS:
+		*len = xdp.data_end - xdp.data;
+		*headroom = xdp.data - xdp.data_hard_start;
+		goto out;
+	case XDP_REDIRECT:
+		if (unlikely(xdp_do_redirect(dev, &xdp, prog))) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	case XDP_TX:
+		xdpf = xdp_convert_buff_to_frame(&xdp);
+		if (unlikely(!xdpf) || macb_xdp_submit_frame(queue->bp, xdpf,
+							     dev, addr)) {
+			act = XDP_DROP;
+			break;
+		}
+		goto out;
+	default:
+		bpf_warn_invalid_xdp_action(dev, prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(dev, prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	page_pool_put_full_page(queue->page_pool,
+				virt_to_head_page(xdp.data), true);
+out:
+	rcu_read_unlock();
+
+	return act;
+}
+
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
+	bool xdp_flush = false;
+	unsigned int headroom;
 	unsigned int entry;
 	struct page *page;
 	void *buff_head;
@@ -1403,11 +1597,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int data_len;
 	int nr_frags;
 
-
 	while (count < budget) {
 		bool rxused, first_frame, last_frame;
 		dma_addr_t addr;
 		u32 ctrl;
+		u32 ret;
 
 		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
 		desc = macb_rx_desc(queue, entry);
@@ -1446,9 +1640,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (data_len < 0)
 			goto free_frags;
 
-		addr += first_frame ? bp->rx_ip_align : 0;
-
-		dma_sync_single_for_cpu(&bp->pdev->dev,	addr, data_len,
+		dma_sync_single_for_cpu(&bp->pdev->dev,
+					addr + (first_frame ? bp->rx_ip_align : 0),
+					data_len,
 					page_pool_get_dma_dir(queue->page_pool));
 
 		if (first_frame) {
@@ -1459,6 +1653,18 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 				queue->stats.rx_dropped++;
 			}
 
+			headroom = bp->rx_headroom;
+
+			if (last_frame) {
+				ret = gem_xdp_run(queue, buff_head, &data_len,
+						  &headroom, addr - gem_rx_pad(bp));
+				if (ret == XDP_REDIRECT)
+					xdp_flush = true;
+
+				if (ret != XDP_PASS)
+					goto next_frame;
+			}
+
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
 			if (unlikely(!queue->skb)) {
 				netdev_err(bp->dev,
@@ -1477,7 +1683,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			skb_reserve(queue->skb, bp->rx_headroom);
+			skb_reserve(queue->skb, headroom);
 			skb_mark_for_recycle(queue->skb);
 			skb_put(queue->skb, data_len);
 		} else {
@@ -1489,15 +1695,11 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 				goto free_frags;
 
 			skb_add_rx_frag(queue->skb, nr_frags, page,
-					buff_head - page_address(page) + NET_SKB_PAD,
+					buff_head - page_address(page) + gem_rx_pad(bp),
 					data_len, gem_total_rx_buffer_size(bp));
 		}
 
 		/* now everything is ready for receiving packet */
-		queue->rx_buff[entry] = NULL;
-
-		netdev_vdbg(bp->dev, "%s %u (len %u)\n", __func__, entry, data_len);
-
 		if (last_frame) {
 			bp->dev->stats.rx_packets++;
 			queue->stats.rx_packets++;
@@ -1525,6 +1727,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
+next_frame:
+		queue->rx_buff[entry] = NULL;
 		continue;
 
 free_frags:
@@ -1543,6 +1747,9 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		queue->rx_buff[entry] = NULL;
 	}
 
+	if (xdp_flush)
+		xdp_do_flush();
+
 	gem_rx_refill(queue, true);
 
 	return count;
@@ -2483,13 +2690,13 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb, struct net_device *dev)
 static void macb_init_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int overhead;
-	size_t size;
 
 	if (!macb_is_gem(bp)) {
 		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		size = mtu + ETH_HLEN + ETH_FCS_LEN;
-		bp->rx_buffer_size = SKB_DATA_ALIGN(size + bp->rx_ip_align);
+		bp->rx_headroom = gem_rx_pad(bp) + bp->rx_ip_align;
+		bp->rx_buffer_size = gem_max_rx_data_size(mtu + bp->rx_ip_align);
+
 		if (gem_total_rx_buffer_size(bp) > PAGE_SIZE) {
 			overhead = bp->rx_headroom +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
@@ -2540,6 +2747,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 
 		kfree(queue->rx_buff);
 		queue->rx_buff = NULL;
+		if (xdp_rxq_info_is_reg(&queue->xdp_rxq))
+			xdp_rxq_info_unreg(&queue->xdp_rxq);
 		page_pool_destroy(queue->page_pool);
 		queue->page_pool = NULL;
 	}
@@ -2696,37 +2905,62 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
-static int gem_create_page_pool(struct macb_queue *queue)
+static int gem_create_page_pool(struct macb_queue *queue, int qid)
 {
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = DMA_FROM_DEVICE,
+		.dma_dir = rcu_access_pointer(queue->bp->prog)
+				? DMA_BIDIRECTIONAL
+				: DMA_FROM_DEVICE,
 		.dev = &queue->bp->pdev->dev,
 		.netdev = queue->bp->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
 	};
 	struct page_pool *pool;
-	int err = 0;
+	int err;
 
 	/* This can happen in the case of HRESP error.
 	 * Do nothing as page pool is already existing.
 	 */
 	if (queue->page_pool)
-		return err;
+		return 0;
 
 	pool = page_pool_create(&pp_params);
 	if (IS_ERR(pool)) {
 		netdev_err(queue->bp->dev, "cannot create rx page pool\n");
 		err = PTR_ERR(pool);
-		pool = NULL;
+		goto clear_pool;
 	}
 
 	queue->page_pool = pool;
 
+	err = xdp_rxq_info_reg(&queue->xdp_rxq, queue->bp->dev, qid,
+			       queue->napi_rx.napi_id);
+	if (err < 0) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq info\n");
+		goto destroy_pool;
+	}
+
+	err = xdp_rxq_info_reg_mem_model(&queue->xdp_rxq, MEM_TYPE_PAGE_POOL,
+					 queue->page_pool);
+	if (err) {
+		netdev_err(queue->bp->dev, "xdp: failed to register rxq memory model\n");
+		goto unreg_info;
+	}
+
+	return 0;
+
+unreg_info:
+	xdp_rxq_info_unreg(&queue->xdp_rxq);
+destroy_pool:
+	page_pool_destroy(pool);
+clear_pool:
+	queue->page_pool = NULL;
+
 	return err;
 }
 
@@ -2768,7 +3002,7 @@ static int gem_init_rings(struct macb *bp, bool fail_early)
 		/* This is a hard failure. In case of HRESP error
 		 * recovery we always reuse the existing page pool.
 		 */
-		last_err = gem_create_page_pool(queue);
+		last_err = gem_create_page_pool(queue, q);
 		if (last_err)
 			break;
 
@@ -3216,11 +3450,24 @@ static int macb_close(struct net_device *dev)
 	return 0;
 }
 
+static bool gem_xdp_valid_mtu(struct macb *bp, int mtu)
+{
+	return __gem_total_rx_buffer_size(gem_max_rx_data_size(mtu + bp->rx_ip_align),
+					  XDP_PACKET_HEADROOM) <= PAGE_SIZE;
+}
+
 static int macb_change_mtu(struct net_device *dev, int new_mtu)
 {
+	struct macb *bp = netdev_priv(dev);
+
 	if (netif_running(dev))
 		return -EBUSY;
 
+	if (rcu_access_pointer(bp->prog) && !gem_xdp_valid_mtu(bp, new_mtu)) {
+		netdev_err(dev, "MTU %d too large for XDP", new_mtu);
+		return -EINVAL;
+	}
+
 	WRITE_ONCE(dev->mtu, new_mtu);
 
 	return 0;
@@ -3238,6 +3485,52 @@ static int macb_set_mac_addr(struct net_device *dev, void *addr)
 	return 0;
 }
 
+static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
+			 struct netlink_ext_ack *extack)
+{
+	struct macb *bp = netdev_priv(dev);
+	struct bpf_prog *old_prog;
+	bool need_update, running;
+	int err = 0;
+
+	if (prog && !gem_xdp_valid_mtu(bp, dev->mtu)) {
+		NL_SET_ERR_MSG_MOD(extack, "MTU too large for XDP");
+		return -EOPNOTSUPP;
+	}
+
+	running = netif_running(dev);
+	need_update = !!bp->prog != !!prog;
+	if (running && need_update)
+		macb_close(dev);
+
+	old_prog = rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held());
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (running && need_update) {
+		err = macb_open(dev);
+		if (err)
+			rcu_assign_pointer(bp->prog, NULL);
+	}
+
+	return err;
+}
+
+static int gem_xdp(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	struct macb *bp = netdev_priv(dev);
+
+	if (!macb_is_gem(bp))
+		return -EOPNOTSUPP;
+
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return gem_xdp_setup(dev, xdp->prog, xdp->extack);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void gem_update_stats(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -4497,6 +4790,7 @@ static const struct net_device_ops macb_netdev_ops = {
 	.ndo_hwtstamp_set	= macb_hwtstamp_set,
 	.ndo_hwtstamp_get	= macb_hwtstamp_get,
 	.ndo_setup_tc		= macb_setup_tc,
+	.ndo_bpf		= gem_xdp,
 };
 
 /* Configure peripheral capabilities according to device tree
@@ -5796,11 +6090,11 @@ static int macb_probe(struct platform_device *pdev)
 		goto err_out_phy_exit;
 
 	if (macb_is_gem(bp)) {
-		bp->rx_headroom = NET_SKB_PAD;
-		if (!(bp->caps & MACB_CAPS_RSC)) {
+		if (!(bp->caps & MACB_CAPS_RSC))
 			bp->rx_ip_align = NET_IP_ALIGN;
-			bp->rx_headroom += NET_IP_ALIGN;
-		}
+
+		dev->xdp_features = NETDEV_XDP_ACT_BASIC |
+				    NETDEV_XDP_ACT_REDIRECT;
 	}
 
 	netif_carrier_off(dev);
-- 
2.52.0



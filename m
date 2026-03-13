Return-Path: <netdev+bounces-267578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODbROFdwtGm2oAAAu9opvQ
	(envelope-from <netdev+bounces-267578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8859E2899E6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD61530186AD
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864E388E59;
	Fri, 13 Mar 2026 20:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJjy7Vqa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pbFY5GQj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559E3E3C5A
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432906; cv=none; b=Ttoe8RS7S5A6GZF1lAKA3LPt3KFoQj3j6+Xv3PZ/2HWBL1umPSyJsf54YtKTCn+wefiWLuFDhhJaxvKkM2fhk11u9U9MWpYB17XUo9GtwNG1LwVvYEPua+y9NUU6G1sn7dRwjgHqcdCa8wF7DzEoLzi3nJYnXiIsDsEdtNIe5ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432906; c=relaxed/simple;
	bh=rYMiBIVwv7d4K1avz3zbeAuXlRu4JtB/4u+OOvFraR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEpmQjtWYg4mmOLLIIhjWof5a8jN7m3oQiDeHEMeNYTS6b8IPtyyOnOsbG3gC3DoCGn9hPbcvuK3JhkrGXEVubD+oJwog8b3Rd145Il+M7wgEq1ksIWWy7XR1bXpRix7eCnQaERIVW4QzfYMWKlqs5sXNYWQfsPIK6ErMkHiYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJjy7Vqa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pbFY5GQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773432902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAH8HhuvGlYnGcoKo17SuCKbRbIXd0vlyzkAfqTCqaU=;
	b=QJjy7VqaEawrCpCcCdpgmxxOkT+5MskI1MmGwbZrSmHOjEIOx5UgYkZ+lJIlCs6TZoIRu4
	7MjQIyBOlzbkWijBQdzq29RBhDsB6OxqAEbHPR+wbGZ0aPG/2LfOXgiTkeashXnxMdTUal
	LJWhW/it9yCC/X4NFAEuwLhO/TuSiwk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-8sU8B7gbOb2svab0oFMtlQ-1; Fri, 13 Mar 2026 16:15:00 -0400
X-MC-Unique: 8sU8B7gbOb2svab0oFMtlQ-1
X-Mimecast-MFC-AGG-ID: 8sU8B7gbOb2svab0oFMtlQ_1773432900
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4853b00f9f5so23231595e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773432898; x=1774037698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAH8HhuvGlYnGcoKo17SuCKbRbIXd0vlyzkAfqTCqaU=;
        b=pbFY5GQjCWkXwsL+PJTORWcSoxg8NWCUoWohhcqhDWsDPB1wr3UB5tvvJIuaQRBYoA
         7ofefiUUDE3qzuikUhP/kg17erKWATpE96d9F+dfwgPZQuaB3zkcsHMWwbsksDO9DoWj
         3lvUWdrefdR24JW5H9qp9x2rfdpSE8WHr90Goxzs2swbP+06/KDZKuQgYNtaVZOYmv2g
         jsF0upCSU0EpkhRY3kL0hB5zpHVcS2n6aP5yaxTzNCd8uljlKPLdf7OwOBqNq9ZIMg0K
         cE+MMQn6dU6TB17f3eN6d+3Ewt4UOMpvae5m34r88jdTJFyV9datXvSJ3ftvkQKHRqfO
         5PBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773432898; x=1774037698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAH8HhuvGlYnGcoKo17SuCKbRbIXd0vlyzkAfqTCqaU=;
        b=j49eZN+X2zQ1fBQfhl8Y/eniqleRkp1Qw9FoVSS/l1SvXcKz+ynP50qNGhafxge1Mg
         Ya0IL4NufrjcNu8VRSLXOw8puVMgdPFkkhMWqYXZvMFvBIZM/lHUZ9VzP4zHW+ZAeffz
         TObcKHWvntIby/8K/XDUpVNS/X3a/zsBgJNQsSgLab+f2QpUKZTQ8FOWyOBEkr2kH+dX
         plXP/l4nKRMrX52+iFeSVk9VdM/anM61a292wf2PFgZAQ3+eXSSfQaDSqd5nVimLBJhz
         ptQIt9ycBSxnn5h1NMB15qP6mjCTPdjf1Vvjv6rtNIRQJv4NDAZwECQn/1sE5aMoFlTK
         5pBA==
X-Gm-Message-State: AOJu0YwwCV12ZI4KNUuTUlGtt7O1idaDVsyCjc5m5vm7VsqLOQZ9ikIz
	IH2lblKujUUQd07COLZCKTR63o54VkyrbhQunjP2DnMlBpm7fguaZ5KgoyTxyhQ9WXs5c70RRNP
	VxbKJFq9qIKHnWnBPpP0OnNI+KQrQg1rH0r2l/WZlpcVNSgmlNzQVCqPs1+yxDfvRm1FRrgsc3W
	tx4Ip455Xceeb29kRgnFZu0E1ig9Jar3JPqEGHehTULw==
X-Gm-Gg: ATEYQzxvdGjQEHfnKgX4UXRwHAcMRurjCMXqaG3/adZdEOF2kigvNA6a0wfzoebmIBQ
	RC5/awcs7ippaKoM5Z5yiUd0YsLv56Tqi+I8XrarvaE5okvL72uiCfaXMTweWc+Cr0yUUO5JG6L
	3rmJdXSw8rifLkf6EKw3klVgG+bWH3RgzxEAM+UHLcez8sYdPQJWs+HD3bhl1KQe5Lp1o5YprUI
	SaRMi0ZHb2tlLcnXD6unDkcUjlXh5J+QTsRF4EoCriu/DlRGnlfyMUuxdVApfnusjo9RWtRgxAv
	lvdP6xa6ziZUX8JymRJbfjkeyhktGR2b2jFXWHMNaBPZTtIV77Y0bNaSaSN/L417TOP80D7YVSO
	O1Np7y73Wx5bVruZQM2EEaDzW9rJEzmWLEpcgMgICtuEsQz1ewiYSKIsxzxc=
X-Received: by 2002:a05:600c:3b25:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-485567029b6mr78657985e9.23.1773432898526;
        Fri, 13 Mar 2026 13:14:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b25:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-485567029b6mr78657425e9.23.1773432897983;
        Fri, 13 Mar 2026 13:14:57 -0700 (PDT)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f255sm335951915e9.12.2026.03.13.13.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:14:55 -0700 (PDT)
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
Subject: [PATCH net-next v5 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Fri, 13 Mar 2026 21:14:27 +0100
Message-ID: <20260313201433.2346119-3-pvalerio@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313201433.2346119-1-pvalerio@redhat.com>
References: <20260313201433.2346119-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267578-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8859E2899E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a preparation commit as the field in later patches will no
longer accomomdate skbuffs, but more generic frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 0acc188fe547..d84ec528c12f 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1277,7 +1277,7 @@ struct macb_queue {
 	unsigned int		rx_tail;
 	unsigned int		rx_prepared_head;
 	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
+	void			**rx_buff;
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2c36d3844bf5..2ed00e200933 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1492,7 +1492,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1511,7 +1511,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1614,7 +1614,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1623,7 +1623,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2623,11 +2623,11 @@ static void gem_free_rx_buffers(struct macb *bp)
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		if (!queue->rx_buff)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
+			skb = queue->rx_buff[i];
 
 			if (!skb)
 				continue;
@@ -2641,8 +2641,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2705,13 +2705,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+		queue->rx_buff = kzalloc(size, GFP_KERNEL);
+		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->dev,
-				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   "Allocated %d RX buff entries at %p\n",
+				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
 }
-- 
2.53.0



Return-Path: <netdev+bounces-269934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI8YC0VdvWl09QIAu9opvQ
	(envelope-from <netdev+bounces-269934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:44:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD6E2DBF85
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6364C307414A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A6D3C6601;
	Fri, 20 Mar 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dlSEES2t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525F93C5559
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017717; cv=none; b=tti9XCtkgo0CHK/DeSGcys9cGRcDUSjOqamYGRjpik9hjP4XBpX2UaNkBjSYKWNsHfkkPoAWu/MWC4nEzeo5yKwQsWT7tCbHIisDOyn5CnoQTz4rUORijyHltTEMUwL+cbc8KzNPGp8DFJzCg5eaQmMOEg4h7gPz1zWZ9/usXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017717; c=relaxed/simple;
	bh=ORkpzv7iiCxiXOhQaUQdLjmDGsPudQzXaVUYF9lrn6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb633jUL7vUcUIOcJwRDuo4TDcP3Ha2WGgG7r+5plJrpBwvDfSJquUGhCZRFi20TY3PDTPefdXPEhDC1UoGYGayOW56PEzSqMm7Qqwjmkj0UVc+MwjK1H486sBRQhcCD66A45pMlXvPFVpRblqseOw9Jd6v4WWdCyAtWYQGsu/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dlSEES2t; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1404602a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774017714; x=1774622514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Blw7GY0uzkKurUX6ypQhQlLBgZS5L/EPKYGZQrzDQcs=;
        b=dlSEES2tzNwJVIPwEQ9qR+FT1ZnrB04wx9XhQO3/p6hPxU92b+lMkEIIh31WClp40p
         Kz6t6ZRE2WLMimvRIG5raiaacfRpLLc0So40naAXp0IK3pBVBm/FvP3OLJIgaequ+p/o
         lqKHm3wYAMxjILv/mdUX3SZQMPZmI1tkYFS6aGnH4dZhXP818qgD1bwfIp7fjNi5cCJJ
         7pxQLyO/r6vHZQp3PIKukujalRvveT5fCJwh9kGyICgSq6XOGKR8Y6jiev5zXgM6xOge
         vEDmA1fkpOTfN7dg1mMNTbcdMeGZzVp8EOdWR9jwlxu0fqrdzOd7FyWPlrjZ2oey7/o9
         JY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774017714; x=1774622514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Blw7GY0uzkKurUX6ypQhQlLBgZS5L/EPKYGZQrzDQcs=;
        b=niRe5lJvTdSysg73i6p9VJD4dDdtz7RjmvIi+XPuRtODcrD/8+j+KZq3BYlRQB8Ule
         HyDJ1HUob2YWmICAbef1ulUULCuInFAtdFW5wxqhBfWkgzuxyFv0ex/cuj7ngz4mer8h
         DiMKfrpwRzs8XzPzaQDq9TfZ6XdzkJDtiuahrpPwjk52lKcNPuJKihyWI3MJqIxSreh8
         V2mR3Y3oRQ8K7S7KO1GOHCKtAvguyRLBK6eEfAqWnnGET66FRIuavfW0ucJc83VwF74s
         HeWyctKfZVQkYU1wfobaojKZRnqcaGNeLKn5AJwqAiOOdURqqPwoVHjj28onsqnrWD90
         U5Xg==
X-Gm-Message-State: AOJu0YxymKuhYQkS0Pti6Bxg36YTDZ1xEOT4sYrj/uYg1PkSCzjJ/pmc
	+rXMJ/c2LLm/i/6kL8lS7NNrQggSbVuvU7kfQoBRx4ftfJXoeF93jTe7Q2xeUoElpVv10CgzVFo
	U42wvW94=
X-Gm-Gg: ATEYQzzNwjznaY8Yd+/j7nUyXepeBT7vwm1i+k8jw4sGDQ9qivLaBt0lYBNb7EExddS
	UAkQFg1ZYEyBdOZfLeE0+TXEuyI1lhVWcVGHigioUcGJX/S1eih30jWb8N7nM8EDCfCF1o2hSRG
	mPqtz3HpHPDBr9IDSPGA/3ciufOE8jonTQm2udb1pNNjR2T5ZjuDg2RI08cmVImgLxDrecetev+
	MLpmv4U4CA44k6kJly6Gawg1D1urc3hrr8C5lvQLS7A2Di5NA65rnaIE+393u2faBuTgRX1gf68
	rU0ik7aASpWY3Y25i8K7VdLN668DwczbOXWIsBRyt/Su1/ONf9b0PDLPQHUTb4nB84gFiA4i8dm
	/NwHqVlmW5a2IwmsPXK9rb20TLG6Ni1UP+qcgATTGq4t2hDS2XJ9XHLQYFXYJIVj2H6ewVylpcb
	TrQZA=
X-Received: by 2002:a17:90b:2c90:b0:35b:a53a:7d0c with SMTP id 98e67ed59e1d1-35bd2cea8a0mr2349103a91.23.1774017714330;
        Fri, 20 Mar 2026 07:41:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc5ff6789sm5799911a91.1.2026.03.20.07.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 07:41:53 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v4 02/12] net: tso: Add tso_dma_map helpers
Date: Fri, 20 Mar 2026 07:41:23 -0700
Message-ID: <20260320144141.260246-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320144141.260246-1-joe@dama.to>
References: <20260320144141.260246-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-269934-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama.to:mid,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 8BD6E2DBF85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adds skb_frag_phys() to skbuff.h, returning the physical address
of a paged fragment's data, which is used by the tso_dma_map helpers
introduced in this commit described below:

tso_dma_map_init(): DMA-maps the linear payload region and all frags
upfront. Prefers the DMA IOVA API for a single contiguous mapping with
one IOTLB sync; falls back to per-region dma_map_phys() otherwise.
Returns 0 on success, cleans up partial mappings on failure.

tso_dma_map_cleanup(): Handles both IOVA and fallback teardown paths.

tso_dma_map_count(): counts how many descriptors the next N bytes of
payload will need. Returns 1 if IOVA is used since the mapping is
contiguous.

tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
On the IOVA path, each segment is a single contiguous chunk. On the
fallback path, indicates when a chunk starts a new DMA mapping so the
driver can set dma_unmap_len on that descriptor for completion-time
unmapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Fix the kdoc for the TSO helpers. No functional changes.

 v3:
   - Added skb_frag_phys helper include/linux/skbuff.h.
   - Added tso_dma_map_use_iova() inline helper in tso.h.
   - Updated the helpers to use the DMA IOVA API and falls back to per-region
     mapping instead.

 include/linux/skbuff.h |  11 ++
 include/net/tso.h      |  21 ++++
 net/core/tso.c         | 273 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9cc98f850f1d..d8630eb366c5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3758,6 +3758,17 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 	return ptr + skb_frag_off(frag);
 }
 
+/**
+ * skb_frag_phys - gets the physical address of the data in a paged fragment
+ * @frag: the paged fragment buffer
+ *
+ * Returns: the physical address of the data within @frag.
+ */
+static inline phys_addr_t skb_frag_phys(const skb_frag_t *frag)
+{
+	return page_to_phys(skb_frag_page(frag)) + skb_frag_off(frag);
+}
+
 /**
  * skb_frag_page_copy() - sets the page in a fragment from another fragment
  * @fragto: skb fragment where page is set
diff --git a/include/net/tso.h b/include/net/tso.h
index 8f8d9d74e873..f78a470a7277 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -68,4 +68,25 @@ struct tso_dma_map {
 	} frags[MAX_SKB_FRAGS];
 };
 
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
+/**
+ * tso_dma_map_use_iova - check if this map used the DMA IOVA path
+ * @map: the map to check
+ *
+ * Return: true if the IOVA API was used for this mapping. When true,
+ * the driver must call tso_dma_map_cleanup() at completion time instead
+ * of doing per-region DMA unmaps.
+ */
+static inline bool tso_dma_map_use_iova(struct tso_dma_map *map)
+{
+	return dma_use_iova(&map->iova_state);
+}
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..8d3cfbd52e84 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,275 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
 	return hdr_len;
 }
 EXPORT_SYMBOL(tso_start);
+
+static int tso_dma_iova_try(struct device *dev, struct tso_dma_map *map,
+			    phys_addr_t phys, size_t linear_len, size_t total_len,
+			    size_t *offset)
+{
+	const struct sk_buff *skb;
+	unsigned int nr_frags;
+	int i;
+
+	if (!dma_iova_try_alloc(dev, &map->iova_state, phys, total_len))
+		return 1;
+
+	skb = map->skb;
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	if (linear_len) {
+		if (dma_iova_link(dev, &map->iova_state,
+				  phys, *offset, linear_len,
+				  DMA_TO_DEVICE, 0))
+			goto iova_fail;
+		map->linear_len = linear_len;
+		*offset += linear_len;
+	}
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int frag_len = skb_frag_size(frag);
+
+		if (dma_iova_link(dev, &map->iova_state,
+				  skb_frag_phys(frag), *offset,
+				  frag_len, DMA_TO_DEVICE, 0)) {
+			map->nr_frags = i;
+			goto iova_fail;
+		}
+		map->frags[i].len = frag_len;
+		*offset += frag_len;
+		map->nr_frags = i + 1;
+	}
+
+	if (dma_iova_sync(dev, &map->iova_state, 0, total_len))
+		goto iova_fail;
+
+	return 0;
+
+iova_fail:
+	dma_iova_destroy(dev, &map->iova_state, *offset,
+			 DMA_TO_DEVICE, 0);
+	memset(&map->iova_state, 0, sizeof(map->iova_state));
+
+	/* reset map state */
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+
+	return 1;
+}
+
+/**
+ * tso_dma_map_init - DMA-map GSO payload regions
+ * @map: map struct to initialize
+ * @dev: device for DMA mapping
+ * @skb: the GSO skb
+ * @hdr_len: per-segment header length in bytes
+ *
+ * DMA-maps the linear payload (after headers) and all frags.
+ * Prefers the DMA IOVA API (one contiguous mapping, one IOTLB sync);
+ * falls back to per-region dma_map_phys() when IOVA is not available.
+ * Positions the iterator at byte 0 of the payload.
+ *
+ * Return: 0 on success, -ENOMEM on DMA mapping failure (partial mappings
+ * are cleaned up internally).
+ */
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len)
+{
+	unsigned int linear_len = skb_headlen(skb) - hdr_len;
+	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
+	size_t total_len = skb->len - hdr_len;
+	size_t offset = 0;
+	phys_addr_t phys;
+	int i;
+
+	if (!total_len)
+		return 0;
+
+	map->dev = dev;
+	map->skb = skb;
+	map->hdr_len = hdr_len;
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->iova_offset = 0;
+	map->total_len = total_len;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+	memset(&map->iova_state, 0, sizeof(map->iova_state));
+
+	if (linear_len)
+		phys = virt_to_phys(skb->data + hdr_len);
+	else
+		phys = skb_frag_phys(&skb_shinfo(skb)->frags[0]);
+
+	if (tso_dma_iova_try(dev, map, phys, linear_len, total_len, &offset)) {
+		/* IOVA path failed, map state was reset. Fallback to
+		 * per-region dma_map_phys()
+		 */
+		if (linear_len) {
+			map->linear_dma = dma_map_phys(dev, phys, linear_len,
+						       DMA_TO_DEVICE, 0);
+			if (dma_mapping_error(dev, map->linear_dma))
+				return -ENOMEM;
+			map->linear_len = linear_len;
+		}
+
+		for (i = 0; i < nr_frags; i++) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			unsigned int frag_len = skb_frag_size(frag);
+
+			map->frags[i].len = frag_len;
+			map->frags[i].dma = dma_map_phys(dev, skb_frag_phys(frag),
+							 frag_len, DMA_TO_DEVICE, 0);
+			if (dma_mapping_error(dev, map->frags[i].dma)) {
+				tso_dma_map_cleanup(map);
+				return -ENOMEM;
+			}
+			map->nr_frags = i + 1;
+		}
+	}
+
+	if (linear_len == 0 && nr_frags > 0)
+		map->frag_idx = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(tso_dma_map_init);
+
+/**
+ * tso_dma_map_cleanup - unmap all DMA regions in a tso_dma_map
+ * @map: the map to clean up
+ *
+ * Handles both IOVA and fallback paths. For IOVA, calls
+ * dma_iova_destroy(). For fallback, unmaps each region individually.
+ */
+void tso_dma_map_cleanup(struct tso_dma_map *map)
+{
+	int i;
+
+	if (dma_use_iova(&map->iova_state)) {
+		dma_iova_destroy(map->dev, &map->iova_state, map->total_len,
+				 DMA_TO_DEVICE, 0);
+		memset(&map->iova_state, 0, sizeof(map->iova_state));
+		map->linear_len = 0;
+		map->nr_frags = 0;
+		return;
+	}
+
+	if (map->linear_len)
+		dma_unmap_phys(map->dev, map->linear_dma, map->linear_len,
+			       DMA_TO_DEVICE, 0);
+
+	for (i = 0; i < map->nr_frags; i++)
+		dma_unmap_phys(map->dev, map->frags[i].dma, map->frags[i].len,
+			       DMA_TO_DEVICE, 0);
+
+	map->linear_len = 0;
+	map->nr_frags = 0;
+}
+EXPORT_SYMBOL(tso_dma_map_cleanup);
+
+/**
+ * tso_dma_map_count - count descriptors for a payload range
+ * @map: the payload map
+ * @len: number of payload bytes in this segment
+ *
+ * Counts how many contiguous DMA region chunks the next @len bytes
+ * will span, without advancing the iterator. On the IOVA path this
+ * is always 1 (contiguous). On the fallback path, uses region sizes
+ * from the current position.
+ *
+ * Return: the number of descriptors needed for @len bytes of payload.
+ */
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len)
+{
+	unsigned int offset = map->offset;
+	int idx = map->frag_idx;
+	unsigned int count = 0;
+
+	if (!len)
+		return 0;
+
+	if (dma_use_iova(&map->iova_state))
+		return 1;
+
+	while (len > 0) {
+		unsigned int region_len, chunk;
+
+		if (idx == -1)
+			region_len = map->linear_len;
+		else
+			region_len = map->frags[idx].len;
+
+		chunk = min(len, region_len - offset);
+		len -= chunk;
+		count++;
+		offset = 0;
+		idx++;
+	}
+
+	return count;
+}
+EXPORT_SYMBOL(tso_dma_map_count);
+
+/**
+ * tso_dma_map_next - yield the next DMA address range
+ * @map: the payload map
+ * @addr: output DMA address
+ * @chunk_len: output chunk length
+ * @mapping_len: full DMA mapping length when this chunk starts a new
+ *               mapping region, or 0 when continuing a previous one.
+ *               On the IOVA path this is always 0 (driver must not
+ *               do per-region unmaps; use tso_dma_map_cleanup instead).
+ * @seg_remaining: bytes left in current segment
+ *
+ * Yields the next (dma_addr, chunk_len) pair and advances the iterator.
+ * On the IOVA path, the entire payload is contiguous so each segment
+ * is always a single chunk.
+ *
+ * Return: true if a chunk was yielded, false when @seg_remaining is 0.
+ */
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining)
+{
+	unsigned int region_len, chunk;
+
+	if (!seg_remaining)
+		return false;
+
+	/* IOVA path: contiguous DMA range, no region boundaries */
+	if (dma_use_iova(&map->iova_state)) {
+		*addr = map->iova_state.addr + map->iova_offset;
+		*chunk_len = seg_remaining;
+		*mapping_len = 0;
+		map->iova_offset += seg_remaining;
+		return true;
+	}
+
+	/* Fallback path: per-region iteration */
+
+	if (map->frag_idx == -1) {
+		region_len = map->linear_len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->linear_dma + map->offset;
+		*mapping_len = (map->offset == 0) ? region_len : 0;
+	} else {
+		region_len = map->frags[map->frag_idx].len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->frags[map->frag_idx].dma + map->offset;
+		*mapping_len = (map->offset == 0) ? region_len : 0;
+	}
+
+	*chunk_len = chunk;
+	map->offset += chunk;
+
+	if (map->offset >= region_len) {
+		map->frag_idx++;
+		map->offset = 0;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(tso_dma_map_next);
-- 
2.52.0



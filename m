Return-Path: <netdev+bounces-276187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBFyC0l/1Wn36wcAu9opvQ
	(envelope-from <netdev+bounces-276187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:03:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254AE3B5304
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 00:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0264B300FEE7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2637F73E;
	Tue,  7 Apr 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mXwIJ+8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877A337F015
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 22:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775599408; cv=none; b=fS2YuEMqfhsvaT7PXcND/h26XDN3NxOsL5D8WUPHlPdMkDLhaiER9eA0eS+Ii7eaVIyoZAJl+JvXslfqdYMy0PHRuT/q+ohUVWLkAQ+xU2KYQgeLWOeBLoUQ7TUxcQulBWA11edsN7ZifsxMhEi8fqbtLO65/xdKYzSx+I9NNKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775599408; c=relaxed/simple;
	bh=5GFETYoU02nG7EWR5eh5kmOoAIFHa6l4ll5PYIX6DtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3yYwQfaxhgj76E2qTQkHvAazybrHFuYzInMb27WtINpV3b8rJNqhWu9QxRdOm0NDkYncMPJqSG2Z3qZNRU2NqM6G6Nf+J9c21pqnWs98azZS1xhMDVRCBEW32PSillFTR5VUsGQ/nuilUAyhe73PY0ULtYBNrAK6cUSUM1qTb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mXwIJ+8F; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82cdb4ab547so2745817b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 15:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775599405; x=1776204205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+AOsn3XglOC6/p9r47PNMALxzWgbZtcj0yKtfwqA2Ns=;
        b=mXwIJ+8FJiyiqA0HVLZTIbIbodZ8HFncSzRTFwxqOUcCoIyD5hNBErQw8SsYBbrQFL
         xa5rpzsZZzH8MJUEuV02ijDxOus7RPnQ/3PezRgSMe9+WeH9qdDlI+y+VY0MAHZg3B8O
         83jZw7bs4WYR9l7mR1eGZMf+cbUEajhJNZEe9n0wlnJW4tvgz9J/iqEO/JZk3f3NhbN6
         cyFiKBIQHe+s2jmXJ2BAOaEPbIV8AAEg3gt5REp+FGjXS4BIfjuM1se+4WSj9liJrSaE
         NuSMLyDrxGzqaJpDxchnaVxkDD0UxN2Dg8+utspaE+AvYgUbZyjB9LfDsCkC+x+GfT5b
         f5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775599405; x=1776204205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+AOsn3XglOC6/p9r47PNMALxzWgbZtcj0yKtfwqA2Ns=;
        b=eefci8Qto7x9EcFCPmBCN1vvMovNXV99HvLHT5U0zB05EBlJOmw4zwX7etZOOTSpKk
         dpgAIw26I//zwfZ8yGHRa4742Umq84Pqym5bR0p7S8woyW1fkQymAm/Zn0s/bAjz62GG
         cJqUjFzP5hbUrdIMwcygTnba2wL+Qyao2CBlWKVnv1WDcwuK6HCRnIkJWq/Uh1ijM/iW
         2q/XiZg/zsyu/sNKN2KMZ8VviNSJu6kBtOPOled3VpqllvdBqUenz9/PrhKk3PpERNal
         Xeo5TN32gRU5UhcN2ziwWZh5V1Iw9sASpxbUJtdkWEn59wM8v1/rAy0yanTZlYqyWQD4
         979g==
X-Gm-Message-State: AOJu0YxbDnrXjMMv3sSFqkvOR+FUXs4iIFupN3qeGYMcfuKoifsVE/vz
	h5f5EOH84+27jHWSMYCIWG2kIDYGfbQjhi5e71INtoBdrCL1yiwmZiJzu7Z2GS6xDk98Aa9Sxgv
	NGzHp
X-Gm-Gg: AeBDieuowrqeA3DBXDaogjEC1GNJZnWYI694XFNLqKamJfmJW0YySHyPkpN9GJnoIZA
	Bbz1T3ys6fa3ulBskHiPKhWwEGrhxGjm0iFNbQPZ7nRVn6X9TGEVPgCd890+6z+p8gHkExBw8QG
	43VgTPmE9MhBY3mBc9cdpcw0XFmRbL32fq/sFs6Zd+Ht6AQqXa6RJ87vA9FE62ZGOnCDox5+/J/
	/HHNFbl+2cHoTTJ8wLbGlxRcjqtmcpx5W9CQ9KvyAe2wLnu79XTaQs3g0dZ+ggdt6gVq0euRRTd
	+g1xW309EwPieAi5XSA1TWVGMJSUZn9c06rffW/ZkAc6WeCeSt+iqHJjHK78p71h8dkXvtUDZ7G
	8wjlClbnlfRE09SJH+qHXMYvqeVX1IBT9dQUZuD7FFPJ1MTOX9jbq8Q3hDl5sr6ulBKumxG5oFx
	7+kOM=
X-Received: by 2002:a05:6a00:14c3:b0:829:88e7:c88b with SMTP id d2e1a72fcca58-82d0da8edccmr18324783b3a.19.1775599405361;
        Tue, 07 Apr 2026 15:03:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b21c92sm19850197b3a.11.2026.04.07.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 15:03:24 -0700 (PDT)
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
Subject: [net-next v9 01/10] net: tso: Introduce tso_dma_map and helpers
Date: Tue,  7 Apr 2026 15:02:57 -0700
Message-ID: <20260407220313.3990909-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407220313.3990909-1-joe@dama.to>
References: <20260407220313.3990909-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-276187-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 254AE3B5304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
GSO payload data and tso_dma_map_completion_state.

The tso_dma_map combines DMA mapping storage with iterator state, allowing
drivers to walk pre-mapped DMA regions linearly. Includes fields for
the DMA IOVA path (iova_state, iova_offset, total_len) and a fallback
per-region path (linear_dma, frags[], frag_idx, offset).

The tso_dma_map_completion_state makes the IOVA completion state opaque
for drivers. Drivers are expected to allocate this and use the added
helpers to update the completion state.

Adds skb_frag_phys() to skbuff.h, returning the physical address
of a paged fragment's data, which is used by the tso_dma_map helpers
introduced in this commit described below.

The added TSO DMA map helpers are:

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

tso_dma_map_completion_save(): updates the completion state. Drivers
will call this at xmit time.

tso_dma_map_complete(): tears down the mapping at completion time and
returns true if the IOVA path was used. If it was not used, this is a
no-op and returns false.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v9:
   - Fix typo in commit message.
   - Fix kdoc.
   - Initialize tso_dma_map before early return in tso_dma_map_init
     (suggested by AI).

 v7:
   - Squashed the struct and helpers (patch 1 and 2 from v6) into this one
     patch.
   - Added tso_dma_map_completion_state and helpers
     tso_dma_map_completion_save and tso_dma_map_complete to operate on the
     struct and keep the DMA IOVA completely opaque from drivers.
   - Removed unnecessary duplicated code in tso_dma_map_next and
     tso_dma_map_cleanup.

 v4:
   - Fix the kdoc for the TSO helpers. No functional changes.

 v3:
   - struct tso_dma_map extended to track IOVA state and
     a fallback per-region path.
   - Added skb_frag_phys helper include/linux/skbuff.h.
   - Added tso_dma_map_use_iova() inline helper in tso.h.
   - Updated the helpers to use the DMA IOVA API and falls back to per-region
     mapping instead.

 include/linux/skbuff.h |  11 ++
 include/net/tso.h      | 100 +++++++++++++++
 net/core/tso.c         | 269 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 26fe18bcfad8..2bcf78a4de7b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3763,6 +3763,17 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
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
index e7e157ae0526..da82aabd1d48 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -3,6 +3,7 @@
 #define _TSO_H
 
 #include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
 #include <net/ip.h>
 
 #define TSO_HEADER_SIZE		256
@@ -28,4 +29,103 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size);
 int tso_start(struct sk_buff *skb, struct tso_t *tso);
 
+/**
+ * struct tso_dma_map - DMA mapping state for GSO payload
+ * @dev: device used for DMA mapping
+ * @skb: the GSO skb being mapped
+ * @hdr_len: per-segment header length
+ * @iova_state: DMA IOVA state (when IOMMU available)
+ * @iova_offset: global byte offset into IOVA range (IOVA path only)
+ * @total_len: total payload length
+ * @frag_idx: current region (-1 = linear, 0..nr_frags-1 = frag)
+ * @offset: byte offset within current region
+ * @linear_dma: DMA address of the linear payload
+ * @linear_len: length of the linear payload
+ * @nr_frags: number of frags successfully DMA-mapped
+ * @frags: per-frag DMA address and length
+ *
+ * DMA-maps the payload regions of a GSO skb (linear data + frags).
+ * Prefers the DMA IOVA API for a single contiguous mapping with one
+ * IOTLB sync; falls back to per-region dma_map_phys() otherwise.
+ */
+struct tso_dma_map {
+	struct device		*dev;
+	const struct sk_buff	*skb;
+	unsigned int		hdr_len;
+	/* IOVA path */
+	struct dma_iova_state	iova_state;
+	size_t			iova_offset;
+	size_t			total_len;
+	/* Fallback path if IOVA path fails */
+	int			frag_idx;
+	unsigned int		offset;
+	dma_addr_t		linear_dma;
+	unsigned int		linear_len;
+	unsigned int		nr_frags;
+	struct {
+		dma_addr_t	dma;
+		unsigned int	len;
+	} frags[MAX_SKB_FRAGS];
+};
+
+/**
+ * struct tso_dma_map_completion_state - Completion-time cleanup state
+ * @iova_state: DMA IOVA state (when IOMMU available)
+ * @total_len: total payload length of the IOVA mapping
+ *
+ * Drivers store this on their SW ring at xmit time via
+ * tso_dma_map_completion_save(), then call tso_dma_map_complete() at
+ * completion time.
+ */
+struct tso_dma_map_completion_state {
+	struct dma_iova_state iova_state;
+	size_t total_len;
+};
+
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
+/**
+ * tso_dma_map_completion_save - save state needed for completion-time cleanup
+ * @map: the xmit-time DMA map
+ * @cstate: driver-owned storage that persists until completion
+ *
+ * Should be called at xmit time to update the completion state and later passed
+ * to tso_dma_map_complete().
+ */
+static inline void
+tso_dma_map_completion_save(const struct tso_dma_map *map,
+			    struct tso_dma_map_completion_state *cstate)
+{
+	cstate->iova_state = map->iova_state;
+	cstate->total_len = map->total_len;
+}
+
+/**
+ * tso_dma_map_complete - tear down mapping at completion time
+ * @dev: the device that owns the mapping
+ * @cstate: state saved by tso_dma_map_completion_save()
+ *
+ * Return: true if the IOVA path was used and the mapping has been
+ * destroyed; false if the fallback per-region path was used and the
+ * driver must unmap via its normal completion path.
+ */
+static inline bool
+tso_dma_map_complete(struct device *dev,
+		     struct tso_dma_map_completion_state *cstate)
+{
+	if (dma_use_iova(&cstate->iova_state)) {
+		dma_iova_destroy(dev, &cstate->iova_state, cstate->total_len,
+				 DMA_TO_DEVICE, 0);
+		return true;
+	}
+
+	return false;
+}
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..f2e625e7b64f 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,271 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
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
+	if (!total_len)
+		return 0;
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
+	} else {
+		if (map->linear_len)
+			dma_unmap_phys(map->dev, map->linear_dma, map->linear_len,
+				       DMA_TO_DEVICE, 0);
+
+		for (i = 0; i < map->nr_frags; i++)
+			dma_unmap_phys(map->dev, map->frags[i].dma, map->frags[i].len,
+				       DMA_TO_DEVICE, 0);
+	}
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
+	} else {
+		region_len = map->frags[map->frag_idx].len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->frags[map->frag_idx].dma + map->offset;
+	}
+
+	*mapping_len = (map->offset == 0) ? region_len : 0;
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



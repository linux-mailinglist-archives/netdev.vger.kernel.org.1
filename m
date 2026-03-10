Return-Path: <netdev+bounces-266334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIekBwiMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE425839E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9913D31724A1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E973EAC77;
	Tue, 10 Mar 2026 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="a1aRl5RA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354ED3CFF75
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177769; cv=none; b=hbTHFoH37vMcTNLZVDxqlcG3cOJ4DG/Uz59yy8rjliWOZT1RYaV3S8HSXGOoOXTBfLLR94WQ7JVPXJLL38Ml6t7rB36Lha9iTA1/5ZZeuACPnjtdrMaUXZQMoFREbqUUoDUZVKPUMo0tO7svp9yj//kTGlxoYLdU6eDI0UFCYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177769; c=relaxed/simple;
	bh=KPVuKItZd1MhwLbF0SvCW6nyq/QrT40WF9DJe9SLVVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG2ZWNsb5SW8b+7FpHhcNNHpo1PvPh5CO0pN05IKMKbZ5Lu0faIIdmpxNlrrfhh40F3mdqUFAOxNfOcAj6mmrmaEMPtuzosfBEFrB7NWJnCyZcO18bQykgE2bVmJzQ6/dyn1GY7UZNNgBrNlwF21EbyGJsLmc0AR5az986T/GmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=a1aRl5RA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-359894e17b8so6916398a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177766; x=1773782566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im3H2jdH9CTQLzHqJHTpkhsVYCfPOcqP+VrdKZHbyAg=;
        b=a1aRl5RAfE8J5vxCEc+8wuXY29QYEcNJvSAXsaY5+ZR1AlWD1aUFlkpUzMX53eNpSt
         zuO42pGwkzzBi1iHXq+MGEYfMUc1867JImm/ZFy6HU+W+2OdqrAnbpf9Tq5qJEZacrEC
         CvgMnEIg2CfEfbh7NtLR1ldYo5onZSBf3odvEsPK3fhXQbLuJ6/Tjtqk+d/EPb6RfEQi
         Nz3DhYCDPfk1GmIXmj18y6kJXBQ9CkDOck+cEyVpN26epXMe9KJOvx0KNRDEBXi4ZSMU
         nOsLAXtYv7U1UyoSCi61ZPeCBwETx1AoSzC+gtt9cd7Exn40OFny4HPVr2PFh/So59oB
         7zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177766; x=1773782566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=im3H2jdH9CTQLzHqJHTpkhsVYCfPOcqP+VrdKZHbyAg=;
        b=dAB41dBFbAiIrS4LkiXOjypXs0SUNNIY3+NozUMSGthFMuPTBO+wjUPLRHrsoNi+hs
         KfHSR3Jg9mPQL51ia7twnl+VkML+xOOAAqlWTcFRBlefa4bmYXFR0BSaiDZYZFJ62aUh
         MFJIJ8cnEC0P+aZHn19kTiBSt/1fPw15OgGCozNPpy5ovgv+TLRmf2G602yYO7TYrqnZ
         EbzxAdpvQAI4iqQCEkU/oP7Js6cQuYak4ExytQ7+GLs/Fy64iRnMoEwYJagAW86cU3zb
         Q769/wnJyDvuhqzqoSbj0YwaE9z4HTgbqd4izUGG0T/Ft4aZNsROO3/xDFiBcb+9MdWj
         hCJA==
X-Gm-Message-State: AOJu0YzJpXUdVwBQ1NMA/Cm+k74HlCU/gTlNcz4E3B07y+sTMmXUWFAG
	BtSt5YFy5WFStkERF+Xu7/w1dt6KXz4P/yK2yKHw69QMX/2uZHS4QYfZydvYCN3QvTG6fK3Z2u1
	hu8/B1T8=
X-Gm-Gg: ATEYQzzCRUWELSvVegGJt2Z9HJjS6cr7/Qkxl/O3Prhv+fSllKd3W7W/QjiC8xkxMpN
	nT4lA2a80Hevi2UYMFqsFZhttGP5AJEUG22rcI5eMYiHBGoO/XTRDkMbIQVr0CfLqaR8mERzndk
	N1w5/t/hN85qWyBUxb/NA//DqOwGYAC3Wz7Rrr0CyWPit+X7Rprrm/G/kEd9S+Yq0FRkZGNhBF4
	lYXgwJ9Elbe4Z+Pk9qcNx88+c79CrMhC3p1hzeL2FjKs1yY7/xm1cfmeH4TAIOhU23rWVDtn6Dl
	PyYQxMQew9NYAi8Cc6b2vR9cPYgBiiV3YPrlelTsKQjnATZeLTC1DuPg71M0Vyya43utxcUOJKQ
	G2aFxtY5cxZanlyUpIxNqSRuYizaMMBNqSkYTwRYCjmmugAYvZsJkYcBQZ18exKYS8e34rIJV93
	KL3Yc=
X-Received: by 2002:a17:90b:380a:b0:359:fd9a:c513 with SMTP id 98e67ed59e1d1-35a012c383emr247308a91.24.1773177765930;
        Tue, 10 Mar 2026 14:22:45 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02474a97sm37744a91.11.2026.03.10.14.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:45 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 02/10] net: tso: Add tso_dma_map helpers
Date: Tue, 10 Mar 2026 14:21:50 -0700
Message-ID: <20260310212209.2263939-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310212209.2263939-1-joe@dama.to>
References: <20260310212209.2263939-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DEE425839E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

Add helpers to initialize, iterate, and clean up a tso_dma_map:

tso_dma_map_init(): DMA-maps the linear payload region and all frags
upfront into the tso_dma_map struct. Returns 0 on success, cleans up
partial mappings on failure.

tso_dma_map_cleanup(): unmaps all DMA regions. Used on error paths.

tso_dma_map_count(): counts how many descriptors the next N bytes of
payload will need, without advancing the iterator.

tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
Indicates when a chunk starts a new DMA mapping so the driver can set
dma_unmap_len on that BD for completion-time unmapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 include/net/tso.h |   8 +++
 net/core/tso.c    | 165 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index 9a508e60ee19..dcb93c7fb917 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -65,4 +65,12 @@ struct tso_dma_map {
 	} frags[MAX_SKB_FRAGS];
 };
 
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(const struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..48348ad94501 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,167 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
 	return hdr_len;
 }
 EXPORT_SYMBOL(tso_start);
+
+/**
+ * tso_dma_map_init - DMA-map GSO payload regions
+ * @map: map struct to initialize
+ * @dev: device for DMA mapping
+ * @skb: the GSO skb
+ * @hdr_len: per-segment header length in bytes
+ *
+ * DMA-maps the linear payload (after headers) and all frags.
+ * Positions the iterator at byte 0 of the payload.
+ *
+ * Returns 0 on success, -ENOMEM on DMA mapping failure (partial mappings
+ * are cleaned up internally).
+ */
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len)
+{
+	unsigned int linear_len = skb_headlen(skb) - hdr_len;
+	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
+	int i;
+
+	map->dev = dev;
+	map->skb = skb;
+	map->hdr_len = hdr_len;
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+
+	if (linear_len > 0) {
+		map->linear_dma = dma_map_single(dev, skb->data + hdr_len,
+						 linear_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, map->linear_dma))
+			return -ENOMEM;
+		map->linear_len = linear_len;
+	}
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		map->frags[i].len = skb_frag_size(frag);
+		map->frags[i].dma = skb_frag_dma_map(dev, frag, 0,
+						     map->frags[i].len,
+						     DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, map->frags[i].dma)) {
+			tso_dma_map_cleanup(map);
+			return -ENOMEM;
+		}
+		map->nr_frags = i + 1;
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
+ * Unmaps linear payload and all mapped frags. Used on error paths.
+ * Success paths use the driver's completion path to handle unmapping.
+ */
+void tso_dma_map_cleanup(struct tso_dma_map *map)
+{
+	int i;
+
+	if (map->linear_len)
+		dma_unmap_single(map->dev, map->linear_dma, map->linear_len,
+				 DMA_TO_DEVICE);
+
+	for (i = 0; i < map->nr_frags; i++)
+		dma_unmap_page(map->dev, map->frags[i].dma, map->frags[i].len,
+			       DMA_TO_DEVICE);
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
+ * will span, without advancing the iterator. Uses frag sizes from
+ * the current position.
+ *
+ * Returns the number of descriptors needed for @len bytes of payload.
+ */
+unsigned int tso_dma_map_count(const struct tso_dma_map *map, unsigned int len)
+{
+	unsigned int offset = map->offset;
+	int idx = map->frag_idx;
+	unsigned int count = 0;
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
+ * @mapping_len: output full mapping length when this is the first BD of
+ *               a DMA mapping (driver should set dma_unmap_len to this),
+ *               or 0 when continuing a previous mapping
+ * @seg_remaining: bytes left in current segment
+ *
+ * Yields the next (dma_addr, chunk_len) pair and advances the iterator.
+ *
+ * Returns true if a chunk was yielded, false when @seg_remaining is 0.
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



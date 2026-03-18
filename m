Return-Path: <netdev+bounces-269165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPRuOnj6umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:18:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658ED2C1ECA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF113169D5A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54A17993;
	Wed, 18 Mar 2026 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dhtOmgRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A83F65F7
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861234; cv=none; b=gf475I2ilgNJBzC2VVdFDPWqRRzRFVMJxgCoCmQA0ZxbuGtRiLcnhDjas+T8J6ZCoERBOXhSHm0+aPa2dqsFpQcvnnqhUqUlIZaJCe5G0m1pYTlUMSPl2WxsX7AIJ2VMixAvhkRa4viJrGrmj4Fq+5a7HAY05HyLLPcSC95nXng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861234; c=relaxed/simple;
	bh=mp3r3PQUzbU5Pid6sex6ed/lR7nGMR2Z2Hyqv6AVIiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsyysqYHTDLWPONs/Vie5fvrcjePFRCadbtDVmxAYwz5rvMM6hWk1aQAkBitZBReUSLUL0oggjDSJunRpW0OLrweOymhAgJWFVtLtQqg/hX7LLqnkwMYVgpTCfIej1PMUN0PfuypMq8EsxUvemrpsnL/J05Mur4RlBsLWPlWyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dhtOmgRW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so297560a91.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861230; x=1774466030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyW4DXhgZ+K7msZw3KHg+eG6+4FAmWnBU3tCC9UDX5E=;
        b=dhtOmgRWnudU031vBw4fIZ5IcLdxMQsHdtbJ3MugjcyUqeM13/sAnBXeoZbSsHEKxa
         K8DSxq5DL0JXvY8kPMNizsrX6YS3wXIfgQprZgnzL/Oakvsm2sTP1FTeuSKv3LhLzd86
         ai4x4OtWDH0VDfhUxXZQjNNWLE1j212J3OxjcdrnYHbVReW6VlSwy92pCd1YMwXDkxdP
         WcgggO/KqIa0dkjWFr4EK4ZHZPhPSz1x2inTgoSR/aZgBGC3Wnd3ejrjErhIMi9Dxeen
         N7pPwvl4tZwnfDnx0+SNOqzUUVUhwP5JfnTPWPFt/OoWG+8wUXkBehUHW/R9rI9hRZeH
         CSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861230; x=1774466030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyW4DXhgZ+K7msZw3KHg+eG6+4FAmWnBU3tCC9UDX5E=;
        b=V2Eri+LXmSzf0LHfG28RIKpAeM7O7OfPS0u6zSxxOzgRLUKdNJ7IA+hE6yJPHzvUXz
         W5lCEUPaZgWtkJSgzKu57qovfGmAOTbEFR0lLKAqHwHTIEyayFcHPHwTi2vN+J7aR0x8
         7bcIcWXz64PEF38CZCbe6dM409HeJ60XyHnDtZqE7fLNDEB88DBBMqFd3XK/05zkbXZ8
         dAaet8PBW6a9bYbtzIyLcwO4WOVjGiDh1P6WIwvtSBgs6/LtZ+E6pUxbAE+wvVyjUayu
         f2Nu6zuHBCUbYYnMhjeKrcDdVBKIpqnBowXWbn2WqeaBRtgMFFJ5mrcf6pKG1W+U2U6v
         QoDw==
X-Gm-Message-State: AOJu0YzV/D6VQDqX6vPSZwdAv3Xges9e0aZ1lEvrHLfb3J+/b11eBPmh
	TtvSV4lK2Bs0WqWUW7WqMWTzhXhK+8RpVzPJdwaiZLBNc49ry0kOlSCQqctQqAMOR8JPuQIA2BQ
	ryfWzWh0=
X-Gm-Gg: ATEYQzxQ3svuIM+6NqSOlU5MyuPAgJHcUlqTH649m8rd0WWXfc6hVTDRCDjgwvOl2GJ
	urqyYDqcQrd9LFS9Y89ufbi6AnsQB6y/CZjUdE5TT3f1vISHZHlQJnEpOn3w/BAsccI0KNBihIL
	JVfCBbeP5i/fMPj0vWneiaYYANxxM1JvOj49uxFv2xiWacCxmt8Z6aIZ9UHz7l2wrkdstyzPnXT
	HXBCDDIWgUgRD1+KO0OsF5K4KGF/O0ilMjLtqODYYRU65oqr3T3DUL7liIuSLPyAieOoB/vSCB8
	hmBsjS8YKKziQ+D1pKs4LVy7H9GXSewjAcJ6uiUYIM9KoGBOqcT0vl2xlcYC2FStbllzYLpogC/
	Q/77lxAeoySy4ewSI9eaYGay52qk0F/TPVJTD2gwOaF41g3bLFkmIX/aFCtt6FPLOaEhU2J9EyX
	SLFa/JlOI1Og7A4w==
X-Received: by 2002:a17:90b:4fd0:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35bb9eef84amr3835962a91.19.1773861230354;
        Wed, 18 Mar 2026 12:13:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc62e44ccsm357233a91.5.2026.03.18.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:49 -0700 (PDT)
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
Subject: [net-next v3 08/12] net: bnxt: Implement software USO
Date: Wed, 18 Mar 2026 12:13:13 -0700
Message-ID: <20260318191325.1819881-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269165-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 658ED2C1ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement bnxt_sw_udp_gso_xmit() using the core tso_dma_map API and
the pre-allocated TX inline buffer for per-segment headers.

The xmit path:
1. Calls tso_start() to initialize TSO state
2. Stack-allocates a tso_dma_map and calls tso_dma_map_init() to
   DMA-map the linear payload and all frags upfront.
3. For each segment:
   - Copies and patches headers via tso_build_hdr() into the
     pre-allocated tx_inline_buf (DMA-synced per segment)
   - Counts payload BDs via tso_dma_map_count()
   - Emits long BD (header) + ext BD + payload BDs
   - Payload BDs use tso_dma_map_next() which yields (dma_addr,
     chunk_len, mapping_len) tuples.

Header BDs set dma_unmap_len=0 since the inline buffer is pre-allocated
and unmapped only at ring teardown.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v3:
   - Added iova_state and iova_total_len to struct bnxt_sw_tx_bd.
   - Stores iova_state on the last segment's tx_buf during xmit.

 rfcv2:
   - set the unmap len on the last descriptor, so that when completions fire
     only the last completion unmaps the region.

 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 206 ++++++++++++++++++
 2 files changed, 210 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 593b78672be8..0afa0b731063 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -11,6 +11,8 @@
 #ifndef BNXT_H
 #define BNXT_H
 
+#include <linux/dma-mapping.h>
+
 #define DRV_MODULE_NAME		"bnxt_en"
 
 /* DO NOT CHANGE DRV_VER_* defines
@@ -897,6 +899,8 @@ struct bnxt_sw_tx_bd {
 		u16			rx_prod;
 		u16			txts_prod;
 	};
+	struct dma_iova_state	iova_state;
+	size_t			iova_total_len;
 };
 
 #define BNXT_SW_GSO_MID		1
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index b296769ee4fe..1d4df9a17565 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -19,11 +19,217 @@
 #include "bnxt.h"
 #include "bnxt_gso.h"
 
+static u32 bnxt_sw_gso_lhint(unsigned int len)
+{
+	if (len <= 512)
+		return TX_BD_FLAGS_LHINT_512_AND_SMALLER;
+	else if (len <= 1023)
+		return TX_BD_FLAGS_LHINT_512_TO_1023;
+	else if (len <= 2047)
+		return TX_BD_FLAGS_LHINT_1024_TO_2047;
+	else
+		return TX_BD_FLAGS_LHINT_2048_AND_LARGER;
+}
+
 netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 				 struct bnxt_tx_ring_info *txr,
 				 struct netdev_queue *txq,
 				 struct sk_buff *skb)
 {
+	struct bnxt_sw_tx_bd *last_unmap_buf = NULL;
+	unsigned int hdr_len, mss, num_segs;
+	unsigned int last_unmap_len = 0;
+	struct pci_dev *pdev = bp->pdev;
+	dma_addr_t last_unmap_addr = 0;
+	unsigned int total_payload;
+	int i, bds_needed, slots;
+	struct tso_dma_map map;
+	u32 vlan_tag_flags = 0;
+	struct tso_t tso;
+	u16 cfa_action;
+	u16 prod;
+
+	hdr_len = tso_start(skb, &tso);
+	mss = skb_shinfo(skb)->gso_size;
+	total_payload = skb->len - hdr_len;
+	num_segs = DIV_ROUND_UP(total_payload, mss);
+
+	/* Zero the csum fields so tso_build_hdr will propagate zeroes into
+	 * every segment header. HW csum offload will recompute from scratch.
+	 */
+	udp_hdr(skb)->check = 0;
+	if (!tso.ipv6)
+		ip_hdr(skb)->check = 0;
+
+	if (unlikely(num_segs <= 1))
+		return NETDEV_TX_OK;
+
+	/* Upper bound on the number of descriptors needed.
+	 *
+	 * Each segment uses 1 long BD + 1 ext BD + payload BDs, which is
+	 * at most num_segs + nr_frags (each frag boundary crossing adds at
+	 * most 1 extra BD).
+	 */
+	bds_needed = 3 * num_segs + skb_shinfo(skb)->nr_frags + 1;
+
+	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+		return NETDEV_TX_BUSY;
+	}
+
+	slots = BNXT_SW_USO_MAX_SEGS - (txr->tx_inline_prod - txr->tx_inline_cons);
+
+	if (unlikely(slots < num_segs)) {
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+		return NETDEV_TX_BUSY;
+	}
+
+	if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
+		goto drop;
+
+	cfa_action = bnxt_xmit_get_cfa_action(skb);
+	if (skb_vlan_tag_present(skb)) {
+		vlan_tag_flags = TX_BD_CFA_META_KEY_VLAN |
+				 skb_vlan_tag_get(skb);
+		if (skb->vlan_proto == htons(ETH_P_8021Q))
+			vlan_tag_flags |= 1 << TX_BD_CFA_META_TPID_SHIFT;
+	}
+
+	prod = txr->tx_prod;
+
+	for (i = 0; i < num_segs; i++) {
+		unsigned int seg_payload = min_t(unsigned int, mss,
+						 total_payload - i * mss);
+		u16 slot = (txr->tx_inline_prod + i) &
+			   (BNXT_SW_USO_MAX_SEGS - 1);
+		struct bnxt_sw_tx_bd *tx_buf;
+		unsigned int mapping_len;
+		dma_addr_t this_hdr_dma;
+		unsigned int chunk_len;
+		unsigned int offset;
+		dma_addr_t dma_addr;
+		struct tx_bd *txbd;
+		void *this_hdr;
+		int bd_count;
+		__le32 csum;
+		bool last;
+		u32 flags;
+
+		last = (i == num_segs - 1);
+		offset = slot * TSO_HEADER_SIZE;
+		this_hdr = txr->tx_inline_buf + offset;
+		this_hdr_dma = txr->tx_inline_dma + offset;
+
+		tso_build_hdr(skb, this_hdr, &tso, seg_payload, last);
+
+		dma_sync_single_for_device(&pdev->dev, this_hdr_dma,
+					   hdr_len, DMA_TO_DEVICE);
+
+		bd_count = tso_dma_map_count(&map, seg_payload);
+
+		tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+
+		tx_buf->skb = skb;
+		tx_buf->nr_frags = bd_count;
+		tx_buf->is_push = 0;
+		tx_buf->is_ts_pkt = 0;
+
+		dma_unmap_addr_set(tx_buf, mapping, this_hdr_dma);
+		dma_unmap_len_set(tx_buf, len, 0);
+
+		tx_buf->is_sw_gso = last ? BNXT_SW_GSO_LAST : BNXT_SW_GSO_MID;
+
+		/* Store IOVA state on the last segment for completion */
+		if (last && tso_dma_map_use_iova(&map)) {
+			tx_buf->iova_state = map.iova_state;
+			tx_buf->iova_total_len = map.total_len;
+		}
+
+		flags = (hdr_len << TX_BD_LEN_SHIFT) |
+			TX_BD_TYPE_LONG_TX_BD |
+			TX_BD_CNT(2 + bd_count);
+
+		flags |= bnxt_sw_gso_lhint(hdr_len + seg_payload);
+
+		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+		txbd->tx_bd_haddr = cpu_to_le64(this_hdr_dma);
+		txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod,
+						   2 + bd_count);
+
+		csum = cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM |
+				   TX_BD_FLAGS_IP_CKSUM);
+
+		prod = NEXT_TX(prod);
+		bnxt_init_ext_bd(bp, txr, prod, csum,
+				 vlan_tag_flags, cfa_action);
+
+		/* set dma_unmap_len on the LAST BD touching each
+		 * region. Since completions are in-order, the last segment
+		 * completes after all earlier ones, so the unmap is safe.
+		 */
+		while (tso_dma_map_next(&map, &dma_addr, &chunk_len,
+					&mapping_len, seg_payload)) {
+			prod = NEXT_TX(prod);
+			txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+			tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+			txbd->tx_bd_haddr = cpu_to_le64(dma_addr);
+			dma_unmap_addr_set(tx_buf, mapping, dma_addr);
+			dma_unmap_len_set(tx_buf, len, 0);
+			tx_buf->skb = NULL;
+			tx_buf->is_sw_gso = 0;
+
+			if (mapping_len) {
+				if (last_unmap_buf) {
+					dma_unmap_addr_set(last_unmap_buf,
+							   mapping,
+							   last_unmap_addr);
+					dma_unmap_len_set(last_unmap_buf,
+							  len,
+							  last_unmap_len);
+				}
+				last_unmap_addr = dma_addr;
+				last_unmap_len = mapping_len;
+			}
+			last_unmap_buf = tx_buf;
+
+			flags = chunk_len << TX_BD_LEN_SHIFT;
+			txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
+			txbd->tx_bd_opaque = 0;
+
+			seg_payload -= chunk_len;
+		}
+
+		txbd->tx_bd_len_flags_type |=
+			cpu_to_le32(TX_BD_FLAGS_PACKET_END);
+
+		prod = NEXT_TX(prod);
+	}
+
+	if (last_unmap_buf) {
+		dma_unmap_addr_set(last_unmap_buf, mapping, last_unmap_addr);
+		dma_unmap_len_set(last_unmap_buf, len, last_unmap_len);
+	}
+
+	txr->tx_inline_prod += num_segs;
+
+	netdev_tx_sent_queue(txq, skb->len);
+
+	WRITE_ONCE(txr->tx_prod, prod);
+	/* Sync BDs before doorbell */
+	wmb();
+	bnxt_db_write(bp, &txr->tx_db, prod);
+
+	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
+		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
+				   bp->tx_wake_thresh);
+
+	return NETDEV_TX_OK;
+
+drop:
 	dev_kfree_skb_any(skb);
 	dev_core_stats_tx_dropped_inc(bp->dev);
 	return NETDEV_TX_OK;
-- 
2.52.0



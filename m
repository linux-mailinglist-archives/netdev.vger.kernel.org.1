Return-Path: <netdev+bounces-270674-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BshGH+NwWlxTwQAu9opvQ
	(envelope-from <netdev+bounces-270674-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:59:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58D2FBBB8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC6DB30215E1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BE3D5248;
	Mon, 23 Mar 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="PshxxD8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52330F95C
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291161; cv=none; b=sdPXGRw0mInClI8kObTfrN2gLkBi1imvagYuRxdCbv9O/b4gK+cfNIRmfwaCkWfmCUHk7ZrPX/6c9wRzmrbEjmtBuDHSUV3OU52WvS6E+IravJfjJnJ6dCy0dZdgD6TUps92ws9RjjG9NmeSEPXckeXZdIIH+hDZz/uRRmK7WzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291161; c=relaxed/simple;
	bh=6OQYTaplNa+p6S6ZKyj+mOGB6gpqujBNRQyQhKRILLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJmfN0+HMFmV1TmqfgOJlom/Gq06qfTLBZj0YSz+5GCDBie9trcI4qKsnbO7Km/eAt7Hbil5mRtzXDaoKXgHu9692vNePhJ4ytXpHYDR3EzjvEHXvjlk1evgO29mehMGEhT5ykAgKgbGv1qp2o3cNchvJY9YBN1Vp1gA+3pPxO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=PshxxD8q; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1486588a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291155; x=1774895955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0ANdeu4YxwYUS4LGM6HD7gbAYQZSyCIuBlfXxAUbOA=;
        b=PshxxD8qo0sPtuI7YtA3mAVQBRq4CFF2fehRHZ/UtFNpv2SVrAl50dET6SN8JMTy5Y
         xAy0QIF9L+ZibcJ6L16t+vDnPUKfqlMOhnyFSOSuT9yPX6F6fWzPEosfxtEeLA+CW7rV
         3IifV5OEc73WgI0u7j9dCS/z/pZkIg488VcUJ2fGgUw/mloV1eqk+2MJ9fk9a68IYdmE
         jk5f9BTtyRJDbnO1H2Yde5c1/VI7NbfvIwzgoeOfp0ZN6Eq0NfaFQDuoj19kRJ4yHUqF
         ogdYdsMrDPvgZmVA15FXRhTUKqoPRBDG3koh0Kuwb4vssw3y0TYtUulvyEWu1KmIdVOt
         XeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291155; x=1774895955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0ANdeu4YxwYUS4LGM6HD7gbAYQZSyCIuBlfXxAUbOA=;
        b=QBFS7NogzC0AL8Sf/fNjDXmJl3D8sU59iAHzTh3hN1q6rIGlvkASxWNTlsD43VIT7G
         HNDgQlgBZIINV0N4xZV4MKf6ZWFJlVvYq1r21347RSvq5RYWJc7UkyBPWCIxCIdTzIeL
         nBDe9ckTbgLuVcFVmWsf0CdDvDTYubAb2xRanQUR6Pis/hOZuiXgYP/fq7uMLtJhUaIC
         UYLAtKWZ83MNJzjOYLCl0JYaE/LDC7607OpZi2/iO81do7RpHTh7SF5sxkjmuh/4OKVj
         kTSXl1+jmxgUDKSPDEhmxsQb+C5YI+8Y+r9Kph8cpY0NsDjlJAOQJvmvVu+kfBm2EGQx
         EDfQ==
X-Gm-Message-State: AOJu0Yy5f1I+23sYIlHSZVm4m90BA9IQkpU72bu21CGcx/d63RYmVqMz
	rugZu4yUJW8zVBHOs5hjNAxYuFvRAjmOUD9/9+da3B+ZZqu5zaIDDQoVTqoJC81CZ8yiXpXKCRD
	6CFWvUdU=
X-Gm-Gg: ATEYQzyeuNk8ACDN8l0kMIwVR9BA6iLQACSburdpriEyn9Nnnyp/DIS7OyZuRmI+tcd
	3IlhG+lS0HKFtku27m0TRylXsv6rxo8ZLgfm7g9Zbp1hRabo5SdHELOddTgvKPtre7sN7+6xNtv
	Jt1/Y+QGGsRZJcKfbsrmSwKxxiBAGQkZZ+DrA6GeGx4tjEXuqNyT08LY0NEjnrsHIfcc0VorzHP
	fjiF/aEWulaINWc5mfEWKj2Cq44o1k/WarWDDtZ+HkZ0CsSTsyskpvuHKB8uNgpRQhpBNaRUcW6
	PteW+LZCcNlfgQY23fxoACDKAJ20JIIMeGPt5JRWGXofW8TCxyTtamkdOhBxMDeLD3QEIUGstNj
	mtxInN/Dj/LF0OOXkH2nI5P8ggQDbhrbR8STQs15sY3M+Wq6d7388rttuDcRpgAwGL3gDa+FIUG
	9ScP3gIBH7AAKQo/o=
X-Received: by 2002:a17:902:dacb:b0:2b0:9a61:91a with SMTP id d9443c01a7336-2b09a610a7cmr48336195ad.35.1774291155073;
        Mon, 23 Mar 2026 11:39:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c4f1sm116470225ad.59.2026.03.23.11.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:14 -0700 (PDT)
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
Subject: [net-next v5 08/12] net: bnxt: Implement software USO
Date: Mon, 23 Mar 2026 11:38:33 -0700
Message-ID: <20260323183844.3146982-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270674-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,broadcom.com:email,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 5D58D2FBBB8
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
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v5:
   - Added __maybe_unused to last_unmap_len and last_unmap_addr to silence a
     build warning when CONFIG_NEED_DMA_MAP_STATE is disabled. No functional
     changes.
   - Added Pavan's Reviewed-by.

 v4:
   - Fixed the early return issue Pavan pointed out when num_segs <= 1; use the
     drop label instead of returning.

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
index 18b08789b3a4..865546f3bfce 100644
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
index b296769ee4fe..9c30ee063ef5 100644
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
+	unsigned int last_unmap_len __maybe_unused = 0;
+	dma_addr_t last_unmap_addr __maybe_unused = 0;
+	struct bnxt_sw_tx_bd *last_unmap_buf = NULL;
+	unsigned int hdr_len, mss, num_segs;
+	struct pci_dev *pdev = bp->pdev;
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
+		goto drop;
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



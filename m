Return-Path: <netdev+bounces-272289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD3NMDTHxWmgBgUAu9opvQ
	(envelope-from <netdev+bounces-272289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:54:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8472A33D460
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 00:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF518306016A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD13E3BF68C;
	Thu, 26 Mar 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="J9vwX0oF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355733C3BF3
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774569187; cv=none; b=r5DiX0qzktk4FDqaDM8QTE5SdT3lejONAtC45yhjTqewEQVFGn3krr5QsyOU1PWG/BtG7jBemNq0mhwjvFWKkUbsdN7mVzbzJm3IIBG3TzVK6qrPp09czL3TP6+p9sBqpefiovcVtmItpbYylK4/3Lh2R7uO8DssoE+0V9F51aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774569187; c=relaxed/simple;
	bh=g0ZMY/mYiaYad0AEOxJY66TQHgpI8nIFWwm5NwbmfBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8yx6gYljdNKVQZ8T/OCKr/s+ANXIM+h8162lAu77sqr8CC8UjUss2wlHobIQ2tPdizqSPqNCXTtrt5HM12UrNVp3sShA9/xKyr+tOnWE+URyvKLIrCk2zyZLePY/XzwwuzgmA/djNLxq5ae3Sc1zFBkPY7kuxCfIJK4RTmPGHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=J9vwX0oF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76864f4e58so41579a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774569185; x=1775173985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lO3C5A6DOvNenEaFdW0PEXT4Y2qjfVt93hz9LU/SBU=;
        b=J9vwX0oF2/gu7NI3T+sLoOH5036UU7sr9ww5bnmi/dcWRHG5UjVTJNo6G2eWyggggw
         Nz3114a8+lY/T6/eRGliz/eB8YGbwRb8lwRf6clFiyIspHdAvJPvEJBDNDKEQmEczCh9
         6q1BW1lOD9zdt4UWAurMbrBnC85o1Lf5I/Nqmv67cw8a4y86J3J0CPPZ5Zh33MLIWWeg
         j74/enyiOb+fCgbvuBdhpNFdLvfA+3nYnC9J6Jni7i/ytEBHUlmb20gdiCb9CGxojybK
         /8ZjzYScDktz4ZR85MeJ8KyOcj+hQdvdmztYripBoabADK5ACFlTdrZVYhY7Q9EJgX6a
         ZB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774569185; x=1775173985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9lO3C5A6DOvNenEaFdW0PEXT4Y2qjfVt93hz9LU/SBU=;
        b=hWtP7+uQAv1A9T/dHV0sD9MTlupsQNiLiSCbA3R26d30mJpIhXNTYpet364A1InTiz
         l+CvBtutI6KMo3t1EN1BqMu5lPLH1GnZ+nhQlY+N5iV9Mq77kEbEw1osllhwHKnjCLe0
         rzPwkz9a6iqOVaD/ov9GRkIVzhqVKV8okCCmMjSV8+kEB/tDx27NxvvLz3XJMw5efSKg
         Gzv4Cx2keQOuSDgRa9rHSBP23RIHbaHRgrJqIz0T9xtlKF6nAoWl2KKY+AzQPhQXVeZX
         1jMPopBWA1IBwqUMwW1Uh4A1zBZ/axJk02vs2kPH8Z8HCsiLHONH7+tSRcqsfNauKixy
         Asow==
X-Gm-Message-State: AOJu0YyjJeknVrc6BXm+W7rsNR1TTLy7s6jcn9i5K1eoEEDntGOS7VId
	/fkiYUFuAeaRlEfRsqNGyLluhFXJNugBblQuentur0TSHDLbQMStYeXaGfboNtlkeljrwSA7EnU
	pci8/jDI=
X-Gm-Gg: ATEYQzywsR8S0Ejeou+hZ56Z/2Rivb2DU7zZ2jWbtBCmjD0sA3tbln7rJXWz+Jc4K1r
	IP/x8tRATF+93mVWcBqAcRstX2bZ1hgsf3EsqsGCJXxzgX7qG0mIIRUNOGN+mRVjs5NicnfGdCI
	fBZVMTJpEngh4kXEdMOAbrOxXUgBRbP/cOtWEizeaRnmf/k4ZrZE4P44k3EKPQCYBnV2S0HznzM
	XpXF2imd8sORZWcA7Hr0pYmyC0Y/9RiJmKDYF0/Hrp5JD/c3KQyePinQF6clO4h5deGPmkso/cu
	VHADoR36kYIT005MeGE/yHvfx42mX8QkwXVC7VQH84MJ6VrGh4FoXvN5YtBD3CVBEh4+4A6B2Xg
	fmo4P/GnCSmRxE1ezhMDnGVvCK3Ami37rAypP7dsd5wQrab6oKVupwRUxQ/Ko73v8ayar8PHWtt
	VvHxXq
X-Received: by 2002:a05:6a20:6a10:b0:39b:835f:1730 with SMTP id adf61e73a8af0-39c877f8f90mr617127637.15.1774569184978;
        Thu, 26 Mar 2026 16:53:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c767382c2a6sm3053581a12.12.2026.03.26.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 16:53:04 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: andrew+netdev@lunn.ch,
	horms@kernel.org,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v6 08/12] net: bnxt: Implement software USO
Date: Thu, 26 Mar 2026 16:52:27 -0700
Message-ID: <20260326235238.2940471-9-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326235238.2940471-1-joe@dama.to>
References: <20260326235238.2940471-1-joe@dama.to>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272289-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,dama.to:email,dama.to:mid,broadcom.com:email]
X-Rspamd-Queue-Id: 8472A33D460
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
 v6:
   - Addressed Paolo's feedback where the IOVA API could fail transiently,
     leaving stale state in iova_state. Fix this by always copying the state,
     noting that dma_iova_try_alloc is called unconditionally in the
     tso_dma_map_init function (via tso_dma_iova_try), which zeroes the state
     even if the API can't be used.
   - Since this was a very minor change, I retained Pavan's Reviewed-by.

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
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 210 ++++++++++++++++++
 2 files changed, 214 insertions(+)

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
index b296769ee4fe..7c198847a771 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -19,11 +19,221 @@
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
+		/* Store IOVA state on the last segment for completion.
+		 * Always copy so that a stale iova_state from a prior
+		 * occupant of this ring slot cannot be misread by
+		 * dma_use_iova() in the completion path.
+		 */
+		if (last) {
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



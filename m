Return-Path: <netdev+bounces-266340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OA/AxeMsGkukgIAu9opvQ
	(envelope-from <netdev+bounces-266340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0DF2583AD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 22:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CAAC301510C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C413EF0B4;
	Tue, 10 Mar 2026 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Wk0QDSrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9083ECBC0
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177784; cv=none; b=BfF51sRAQBl81R+ixwbUhLN1WjHkyEvG9WjFIwazEsVfqaMyhkfj6oGV8y5r1QL/FJyXM+YcS1YF+4IBmX4CkcXUUArUGgzKmnzy0fYkLHKQoSMb+JWsfuelDDRV1gn1pivRta3rkAFVen7rbbrJUbaH8PGB7AUiGhaLfhgDdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177784; c=relaxed/simple;
	bh=BaUtoEWMQpk5ovKqSSc1aGuA065Nrd2hnKz65PUI5t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJFRXuK8u2Us/MbLI6GLXZDO4ScD8iRj4fKufSyK5y6cV+EqikaR7pgw28zQmf3Yb0vOba72CAO0KO5MXVf/Ie0JFJJivSD6m6ZPGlym/0clinulC+p9Yh4+ngA1OPaB9UlshQP9FqNz6w2wsiTYAwm3oBm9/+vcybdiIdnX990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Wk0QDSrD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829afe24fb5so2850280b3a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773177777; x=1773782577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVckl09vUBwvyljY3VB64ywIjSrbX81UmflTIAeRTvw=;
        b=Wk0QDSrDV3z4V5XGC5cMc1BoMgAAuStbRkziAyjrU1GwKKjexjAh4kfDuY7GlplNTk
         r6XPbVc8P7Uv8thgqtefF1AWEU8nzfZ+o9vk0B+5uRVgk0dllni5o/dQZ4Lias1PpsmJ
         NPsTJhECdoc9k9hbIRi9O9YqZDOpKbDG7yWiNHAB0UuFdp+qHo2DDbZXBLGX5iiobaxS
         +4OHjVJW4ctVmHvcWCpxjeDJ88WhtT2QmAg+YahD9cf4exbiFZuNu8g8e85qhiC/bOJF
         YAlUf4fP2L7X1/ttFV1IjvxMp61n/Y+lSlWKUg/uVhtPNhb+Z87ejEnYSeplkmeGIkJU
         K4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773177777; x=1773782577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVckl09vUBwvyljY3VB64ywIjSrbX81UmflTIAeRTvw=;
        b=kWc7JRdx2pm2PDD4snMlcwYMzMo2zOY4WUQif+78ReZzpNxmjHEwhTIXIySyCtMn9l
         lkvRdsBezRCpF3iIwzTNEawv7aWwu5gbYZGiQ0SmGuJiv3ZIuz5YX8HE3ySy4M93iD/q
         I2CFOTarm1Tg4CqJglm1ihrxL8QdF+jAp4e/QlRngQIo9pdCWLIFx7FmNLy82MY8JDMI
         G/dqcinXGEcdcmeakDjd0nP3wp0IRb/a+WnP3AvNfyC/cZSmBpoNFf6NzCP9POzd6AM2
         9pTfcaBMTS/wN9tBaLlmL01QPov7pcBqU1DQd5bUshjSZz2Z7XOJQuXR0OXWOqmQgprh
         S1lQ==
X-Gm-Message-State: AOJu0YyuDnG9b3S10gVbJLPC5NHGNty19L61gjjvGdLPyc31LkV2YsoL
	mZcDovqHz5P8erla9KPdIbL03aoNIcZWIO1BcGLhkI8baVMadY7MPaoN+HwJ5ASj3+cdYonF8+G
	0i9h7VkI=
X-Gm-Gg: ATEYQzy2kOwW4Xv9/j1322rDcT14QvvDarZqL1OuEKIBnZTNTad0dWw+qB1M81quUpt
	tBQY7xlDuQo+UV883oalJ6qRSwmisctdsOVRpymUPMrymJ2I4h13sameE+cBpCd24okd4zHnUMs
	V59xbzBYcjz8gYWqbjBjGSyu6KKrZe3OkM97/YcbqAH1OCjY+nKJO+XXE5CjIEoNSG25WAZo+/t
	ewL8cwNm348cSzWMTN6d1YK1QeIFs+kf+/uH7xmriSF0xgYtSow78AkZC0bl45NYNoI/xfsM+s3
	QDwvPJkd0/n7mHQVF2txbjdly+kSsKVex+nb7FK9OklmZGBA8VBnOcFIpXzaZVDLdUY9jzbKvOg
	DKHOu9XhP3zkx8IXnsiWx345gjY96ul3ALzfbo0DOtOF57CTghNZ0ZmKaMJMO7vBpfh72v+5T7W
	bAOwuW
X-Received: by 2002:a05:6a00:4298:b0:824:4a22:ec16 with SMTP id d2e1a72fcca58-829f708a071mr296499b3a.34.1773177776857;
        Tue, 10 Mar 2026 14:22:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3b14sm200136b3a.20.2026.03.10.14.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 14:22:56 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next 08/10] net: bnxt: Implement software USO
Date: Tue, 10 Mar 2026 14:21:56 -0700
Message-ID: <20260310212209.2263939-9-joe@dama.to>
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
X-Rspamd-Queue-Id: CF0DF2583AD
X-Rspamd-Server: lfdr
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
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-266340-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,dama-to.20230601.gappssmtp.com:dkim,dama.to:mid,dama.to:email]
X-Rspamd-Action: no action

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
     chunk_len, mapping_len) tuples; mapping_len is set as
     dma_unmap_len on the first BD of each DMA mapping so the
     completion path can unmap per-BD

Header BDs set dma_unmap_len=0 since the inline buffer is pre-allocated
and unmapped only at ring teardown.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index b296769ee4fe..fe1f791681e1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -19,11 +19,169 @@
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
+	unsigned int hdr_len, mss, num_segs;
+	struct pci_dev *pdev = bp->pdev;
+	unsigned int total_payload;
+	struct tso_dma_map map;
+	u32 vlan_tag_flags = 0;
+	int i, bds_needed;
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
+		dma_addr_t this_hdr_dma = txr->tx_inline_dma + i * hdr_len;
+		void *this_hdr = txr->tx_inline_buf + i * hdr_len;
+		struct bnxt_sw_tx_bd *tx_buf;
+		unsigned int mapping_len;
+		unsigned int chunk_len;
+		dma_addr_t dma_addr;
+		struct tx_bd *txbd;
+		int bd_count;
+		__le32 csum;
+		bool last;
+		u32 flags;
+
+		last = (i == num_segs - 1);
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
+		while (tso_dma_map_next(&map, &dma_addr, &chunk_len,
+					&mapping_len, seg_payload)) {
+			prod = NEXT_TX(prod);
+			txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+			tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+			txbd->tx_bd_haddr = cpu_to_le64(dma_addr);
+			dma_unmap_addr_set(tx_buf, mapping, dma_addr);
+			dma_unmap_len_set(tx_buf, len, mapping_len);
+			tx_buf->skb = NULL;
+			tx_buf->is_sw_gso = 0;
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



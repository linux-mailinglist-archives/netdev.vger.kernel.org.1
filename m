Return-Path: <netdev+bounces-284113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNLhNTU0+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:05:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F64C5174
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81F23030289
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FAA3FFADA;
	Mon,  4 May 2026 23:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T+tNgef2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0464014A0
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939185; cv=none; b=XBsRWUDstvImPyAM+n0K6pKQLX7UzWQAe0H6joXNIcagNT5eTZg3MVy09PKF5W5SWpagl+VBq4Z1lGO/qEPUz30cw3J1Uxn1F2iIe2CfkNlOehlbs6kCMO7PO55irJiRgv6UZ+X+IivtJCz6Oc7KxiFwPXF3oxtkAqATgtkTdgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939185; c=relaxed/simple;
	bh=4Nax/WggEARP343W6/PHIAPVEwx7EDr2gRgCv1xnhXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JY4YgS9VDkcKNaR9Agkx6emVgOkrYf5TtJXMOsnvexdmwJCWJVSU0oLrtzUgsqXTY4/Tuu36VMHSs2tO6ghaRfHFQiC/r+rE0deEcp9mW/iMZjrPKybYSTD19alYMOsPFsS0APozvwcswHDWq7xb3c6uLlOOju+YW73pJj0yLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T+tNgef2; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8b4aeddfacaso50178306d6.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939183; x=1778543983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yecDymPBt53ZbA4LloaYSJZE2aV97HHgaD1JJ0dUwHA=;
        b=TcLMrrLJmjssgqeUoi4BDDKX07GpX4nDjBFl2dGRZ6Mnd1/oUV2ZK7rnb982ozbexz
         xge4PkY8z2YPviJ4dnaX44WI7h5Tjxh3C84UGsxozSAq0FsOoKXZ+OLGEauulgS8GSIq
         7oLRENhY0CuDAfhTqoQmqSfgfF2QZXitVFENiA7+XubHFSnbeCG3IX2BuU6goMvlv2xF
         4VKlI+8c+0tQeq+fYOtIC9bLXslWXkloYJqnxl1HICn9PbF5u3aSKNovet550lGL8VCr
         0OWnykujzCs3UyVKUqR0m55i9aOTIhLLqkwKrKO9EM/RlBLg5aUqr+7URFzVe1aIMuQ5
         NDTQ==
X-Gm-Message-State: AOJu0YzENCIQ30237F6YeQjewWWVhbTKn9B2VDCtS6FkkF6tf4sQtJPe
	di/Q9Z6d5LVivSlv+SjJbraprUEPhPd5mJvTG/sNeBlh8hB5/bTxr0GuI2kzs8XJBOhxY+WcH4D
	fohHiFuQY6Ei69qlKpg3hjLAkEdYhUjOhMZHgel8RqHo4OUN52J9rv527Ha/W8ALl7JJlvplDKq
	/B7zR7dUEWKQPYpgBRcwQMaoMRgkxJ6c5//PkhGV0rKdOrwd4aqIY12a5Jpg8kFb3gpPX9NTSAc
	74zIyThKXk=
X-Gm-Gg: AeBDievBFBVX3l78JcwaBzAynCbS1Njvbaqwc4jojogjgNaMmsdsCXux+54xbva0d0f
	8oGBFAAtkbVEajCS7i/MknLokVJpktyKSvuPn6fQFiFBaC+68uFX83xjPaFCLswIqH/szfXNuxv
	W1MOBT5I6b2Nw6CEobO8M6t3JZ2QT/riGcpIRy2CFSbSOw+D73nFB7xZ9+zPaS1xbvrvKBkHXOR
	33I1vNUGRaRN5UJdMtwY328eq7Y/xtcSkE8y2p663lZd3qy8zXkJ4ywwk1FAWF3UHkLMf1T+yuw
	Yt/OjUsmY4tskR3bNlAAFNPPkc4KuCLtBXV7r0tdr8qIRSJrm39O8MipLh554wRYh8Fl8dC7UYu
	gqMMUexh7Zf6fkN+hOtfvxxrCLXXlLP/Jn+xcJ3wTt83boHC/x6vxyUMWaR9oKC//dgO86J7ZC6
	12CzdQB8j4TiW3c0U0yzbk7EDxsog/7KFeFVAm9ezKUT5/GzCE3ry+ANJcQBISk8VSirc=
X-Received: by 2002:a05:6214:54c2:b0:8ac:d13c:3ab4 with SMTP id 6a1803df08f44-8b668a1fae5mr188734366d6.37.1777939182667;
        Mon, 04 May 2026 16:59:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53bdfb6a2sm10602446d6.25.2026.05.04.16.59.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8b552610488so61215106d6.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939181; x=1778543981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yecDymPBt53ZbA4LloaYSJZE2aV97HHgaD1JJ0dUwHA=;
        b=T+tNgef2w0vB22MuHSXqd+Qz6LFzQsTuirtBp23A8rxHuiMMOy7tQec7VGtIgf4nBh
         sugmZG/G7RIUyLlRUwo6HJadUBgiBUlRCb0DjCbEEw59MX2nkohVbdCPP/1dXOES+vbx
         tCr0HFvHLeUvMtVkTUx5FABvmuEfQ6Und5Un8=
X-Received: by 2002:a05:6214:4012:b0:8b1:f069:3f67 with SMTP id 6a1803df08f44-8b667e6b1a9mr203167006d6.27.1777939181215;
        Mon, 04 May 2026 16:59:41 -0700 (PDT)
X-Received: by 2002:a05:6214:4012:b0:8b1:f069:3f67 with SMTP id 6a1803df08f44-8b667e6b1a9mr203166826d6.27.1777939180790;
        Mon, 04 May 2026 16:59:40 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:40 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 15/15] bnxt_en: Add kTLS retransmission support
Date: Mon,  4 May 2026 16:58:36 -0700
Message-ID: <20260504235836.3019499-16-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 5F4F64C5174
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284113-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

If TCP retransmits a TLS packet that requires encryption by the NIC, the
TCP sequence number will go backwards and the hardware will require some
assistance from the driver.  The driver needs to retrieve the TLS record
that covers the byte sequence of the retransmitted packet.  If the
retransmitted packet does not include the tag, the hardware can simply
encrypt the packet using the informtaion in the TLS record.

The driver provides the TLS record information for the retransmitted
packet in the presync TX BD.  The presync TX BD introduced in the last
patch is treated very much like a TX push BD with inline data.  The only
exception is that no SKB will be stored for the presync TX BD.

Retransmission that includes the TLS tag will be handled in future
patches.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_ktls.c    | 126 +++++++++++++++++-
 4 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f3fae3ad8aa1..d9a52f9c7307 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -499,7 +499,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	txq = netdev_get_tx_queue(dev, i);
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
-	prod = txr->tx_prod;
 
 #if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
 	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
@@ -532,6 +531,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(!skb))
 		return NETDEV_TX_OK;
 
+	prod = txr->tx_prod;
 	length = skb->len;
 	len = skb_headlen(skb);
 	last_frag = skb_shinfo(skb)->nr_frags;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e0880b8c4b73..696dfe522c7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1188,6 +1188,8 @@ struct bnxt_cmn_sw_stats {
 enum bnxt_ktls_data_counters {
 	BNXT_KTLS_TX_PKTS = 0,
 	BNXT_KTLS_TX_BYTES,
+	BNXT_KTLS_TX_OOO_PKTS,
+	BNXT_KTLS_TX_DROP_NO_SYNC,
 
 	BNXT_KTLS_MAX_DATA_COUNTERS,
 };
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 66b323e94140..769058a6ec31 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -359,6 +359,8 @@ static const char *const bnxt_ring_drv_stats_arr[] = {
 static const char *const bnxt_ktls_data_stats[] = {
 	[BNXT_KTLS_TX_PKTS]		= "tx_tls_encrypted_packets",
 	[BNXT_KTLS_TX_BYTES]		= "tx_tls_encrypted_bytes",
+	[BNXT_KTLS_TX_OOO_PKTS]		= "tx_tls_ooo_packets",
+	[BNXT_KTLS_TX_DROP_NO_SYNC]	= "tx_tls_drop_no_sync",
 };
 
 /* kTLS control plane counter strings indexed by enum bnxt_ktls_ctrl_counters */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
index 919c996df503..3477753cbe25 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ktls.c
@@ -286,6 +286,116 @@ int bnxt_ktls_init(struct bnxt *bp)
 	return 0;
 }
 
+static void bnxt_ktls_pre_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			       u32 kid, struct crypto_prefix_cmd *pre_cmd)
+{
+	struct bnxt_sw_tx_bd *tx_buf;
+	struct tx_bd_presync *psbd;
+	u32 bd_space, space;
+	u8 *pcmd;
+	u16 prod;
+
+	prod = txr->tx_prod;
+	tx_buf = &txr->tx_buf_ring[RING_TX(bp, prod)];
+
+	psbd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	psbd->tx_bd_len_flags_type = CRYPTO_PRESYNC_BD_CMD;
+	psbd->tx_bd_kid = cpu_to_le32(BNXT_KID_HW(kid));
+	psbd->tx_bd_opaque =
+		SET_TX_OPAQUE(bp, txr, prod, CRYPTO_PREFIX_CMD_BDS + 1);
+
+	prod = NEXT_TX(prod);
+	pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	space = bd_space * sizeof(struct tx_bd);
+	if (space >= CRYPTO_PREFIX_CMD_SIZE) {
+		memcpy(pcmd, pre_cmd, CRYPTO_PREFIX_CMD_SIZE);
+		prod += CRYPTO_PREFIX_CMD_BDS;
+	} else {
+		memcpy(pcmd, pre_cmd, space);
+		prod += bd_space;
+		pcmd = (void *)&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		memcpy(pcmd, (u8 *)pre_cmd + space,
+		       CRYPTO_PREFIX_CMD_SIZE - space);
+		prod += CRYPTO_PREFIX_CMD_BDS - bd_space;
+	}
+	txr->tx_prod = prod;
+	tx_buf->is_push = 1;
+	tx_buf->inline_data_bds = CRYPTO_PREFIX_CMD_BDS - 1;
+}
+
+static int bnxt_ktls_tx_ooo(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    struct sk_buff *skb, u32 payload_len, u32 seq,
+			    struct tls_context *tls_ctx)
+{
+	struct bnxt_sw_stats *sw_stats = txr->tx_cpr->sw_stats;
+	struct tls_offload_context_tx *tx_tls_ctx;
+	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
+	u32 hdr_tcp_seq, end_seq, total_bds;
+	struct crypto_prefix_cmd pcmd = {};
+	struct tls_record_info *record;
+	unsigned long flags;
+	bool fwd = false;
+	u64 rec_sn;
+	u8 *hdr;
+	int rc;
+
+	tx_tls_ctx = tls_offload_ctx_tx(tls_ctx);
+	kctx_tx = __tls_driver_ctx(tls_ctx, TLS_OFFLOAD_CTX_DIR_TX);
+	end_seq = seq + skb->len - skb_tcp_all_headers(skb);
+	if (unlikely(after(seq, kctx_tx->tcp_seq_no) ||
+		     after(end_seq, kctx_tx->tcp_seq_no))) {
+		fwd = true;
+		pcmd.flags = CRYPTO_PREFIX_CMD_FLAGS_UPDATE_IN_ORDER_VAR_LE;
+	}
+
+	spin_lock_irqsave(&tx_tls_ctx->lock, flags);
+	record = tls_get_record(tx_tls_ctx, seq, &rec_sn);
+	if (!record || !record->num_frags) {
+		rc = -EPROTO;
+		sw_stats->tls.counters[BNXT_KTLS_TX_DROP_NO_SYNC]++;
+		goto unlock_exit;
+	}
+	hdr_tcp_seq = tls_record_start_seq(record);
+	hdr = skb_frag_address_safe(&record->frags[0]);
+
+	total_bds = CRYPTO_PRESYNC_BDS + skb_shinfo(skb)->nr_frags + 2;
+	if (bnxt_tx_avail(bp, txr) < total_bds) {
+		rc = -ENOSPC;
+		goto unlock_exit;
+	}
+
+	/* retransmission includes tag bytes */
+	if (before(record->end_seq - tls_ctx->prot_info.tag_size,
+		   seq + payload_len)) {
+		/* retransmission includes tag bytes */
+		rc = -EOPNOTSUPP;
+		goto unlock_exit;
+	}
+	pcmd.header_tcp_seq_num = cpu_to_le32(hdr_tcp_seq);
+	pcmd.start_tcp_seq_num = cpu_to_le32(seq);
+	pcmd.end_tcp_seq_num = cpu_to_le32(seq + payload_len - 1);
+	if (tls_ctx->prot_info.version == TLS_1_2_VERSION) {
+		u32 nonce_bytes = tls_ctx->prot_info.iv_size;
+		u32 retrans_off = seq - hdr_tcp_seq;
+
+		if (retrans_off > 5 && retrans_off < 5 + nonce_bytes)
+			nonce_bytes = retrans_off - 5;
+		memcpy(pcmd.explicit_nonce, hdr + 5, nonce_bytes);
+	}
+	memcpy(&pcmd.record_seq_num[0], &rec_sn, sizeof(rec_sn));
+
+	rc = 0;
+	bnxt_ktls_pre_xmit(bp, txr, kctx_tx->kid, &pcmd);
+
+	if (fwd)
+		kctx_tx->tcp_seq_no = end_seq;
+
+unlock_exit:
+	spin_unlock_irqrestore(&tx_tls_ctx->lock, flags);
+	return rc;
+}
+
 struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			       struct sk_buff *skb, __le32 *lflags, u32 *kid)
 {
@@ -294,6 +404,7 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	struct bnxt_ktls_offload_ctx_tx *kctx_tx;
 	struct tls_context *tls_ctx;
 	u32 seq, payload_len;
+	int rc;
 
 	if (!IS_ENABLED(CONFIG_TLS_DEVICE) || !ktls ||
 	    !tls_is_skb_tx_device_offloaded(skb))
@@ -313,9 +424,18 @@ struct sk_buff *bnxt_ktls_xmit(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
 		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;
 	} else {
-		skb = tls_encrypt_skb(skb);
-		if (!skb)
-			return NULL;
+		sw_stats->tls.counters[BNXT_KTLS_TX_OOO_PKTS]++;
+
+		rc = bnxt_ktls_tx_ooo(bp, txr, skb, payload_len, seq, tls_ctx);
+		if (rc)
+			return tls_encrypt_skb(skb);
+
+		*kid = BNXT_KID_HW(kctx_tx->kid);
+		*lflags |= cpu_to_le32(TX_BD_FLAGS_CRYPTO_EN |
+				       BNXT_TX_KID_LO(*kid));
+		sw_stats->tls.counters[BNXT_KTLS_TX_PKTS]++;
+		sw_stats->tls.counters[BNXT_KTLS_TX_BYTES] += payload_len;
+		return skb;
 	}
 	return skb;
 }
-- 
2.51.0



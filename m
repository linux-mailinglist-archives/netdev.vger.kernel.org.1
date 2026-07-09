Return-Path: <netdev+bounces-306375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OarKH7oKUGpbsQIAu9opvQ
	(envelope-from <netdev+bounces-306375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E255E735971
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=EsZOqO1A;
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306375-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306375-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88E8C303E9CD
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395D3E0C42;
	Thu,  9 Jul 2026 20:54:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD803E075F
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:54:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630484; cv=none; b=V6f89sVPu+cb16+LK4dr2VbX4lm5iGS34yIi1cjuBh9wXhAo8thZ3Xu5szkyhTzS4MIC/QiOTsJ3cxUtrzdQfUski6CJD6CIzgBPTwXfY1sSyt7aEcol+RZ2ntl/wm/iXvE8Qy6d4PV9nf2PFniZbXtS60xcoCoLKEdObfkwc5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630484; c=relaxed/simple;
	bh=kQ8M8mjvFrapl01au+v9lpAyiEZbigezksxJIAhy2Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCjBSjsDBWDBjo9hybRuVIQ+CVnGYKSdbQJ30q3Gltv8T9iG43iw5ghXg4uFoWKy5CuIh4hyorGsBfNFwph7qvcy3ze4Ur669+pUhxiNL09lxZf+lnwrPwzla+QrfVTc583PmcpPtJWDUWl97dRPtyoANYk5yvKhdBt8fZW+xrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EsZOqO1A; arc=none smtp.client-ip=209.85.160.45
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-448b89f700fso125545fac.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783630481; x=1784235281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kJvIT5WUujZpVV/WUzpOXZTunWbYDYnBARUOjBAMerE=;
        b=EsZOqO1Ajwq+ytxuUGIepX78Hg2PcDRwAT3XysEMuzESZqFk8PA+ObsCWYgmFP64mh
         88bfS14BIs+Mcz7sZEdX6FPXfBtV3+RtBIq2zRcz9qOlj3V99UPt79JQUR2M4ibnth5H
         RQmvxlH8St2misXWhsNuxdt2ZJ0ucTX1c9zVSYn5JKMsCBJvnJtZdJufSPoOJfpnVwyG
         k3EvG/bMf38d/2qQ3B/BsA0FyWG+dczIazqfXdLQbB01Rdfzu/tWnNPcXLo38tAHdhIj
         N0PfWyHmn+75h/Ka+1tgsMVoKAagZWhINi/zulLQ7HmtN3iGOZWyxWH8jal7Cpz0fc5V
         94TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630481; x=1784235281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJvIT5WUujZpVV/WUzpOXZTunWbYDYnBARUOjBAMerE=;
        b=fCzYzv8nRx++eC27y6730nhHqiokFSREnOZ2hwYX09yOvSSW3YPO9Vo7bk1gEcbEh+
         I87uQjZlBEwS/TXKGaigZOOiuWWulqKBMU/5RnO7KJFwFd6mC6FAj5MWSnxBWa6FToQl
         U774/QKxqErOjIeRpNLHK3ZZ80yBaIqDv/KhXORmPUpF7Gcm//j+RKDBHAeH8JazLjRu
         FuGrgT/4qt+/Hg+YtHGfkl8O12RL6znvB0mGhKjXuXpnHAeT2LXgEh7f6b4TMqc/d9yV
         RMTCw9Kt34ixNaG634VHUrJxayHbIIvt1XiGpiDhDBugl7zs7lhiXoz1pGifhqr+sRDg
         LMwg==
X-Gm-Message-State: AOJu0Yydq97I116tIJUzkpCOUP2rLC8GOe3OlUKpYG9dKMq+Opm15ubL
	56zZs95n9zmog3NjBPF8UqiwTG/uXaz0V80otwsHx0iExPnDYYn2n51v8pm3HTOXXpRNBLE90sd
	c1g2xUmZE488Cgw8OOpJpUbAjbJpoCu+S308XGhpDAkV4gZAyow/3Y6LofWWNN0/ysqpqlxAtQ0
	3VmbTisxXhUdSrbZME5mMkP389akw5MahZLski3fEeKeoG9Vs=
X-Gm-Gg: AfdE7cmR9Ds5xy57HzoOaXe6KxT5gfgEgb7yvqVLv0e9E2pOJcVWrvC0VYkdAwK9e7h
	IPPGwCjJo7rdnMMoGo7cyxRlpNtOcEzKi5vtSZ1xiK2Iqg2IziwoUig0TtfF5Vc/9qYTZhy7MX1
	2mHzk89H4/GrFIaV6HYTBG2y5zdeYuEWYSepmUprKd0Lt2caJJp6X3hdVFmmBl4ZJ3ZjkcggIyj
	bw5ASXrahTLRSN6vrdg3MkZ6Bsaiuw8VcUaxwdIVsc6PVEVWaJXW8SqgExZ3xiOKDAm0O9GHetb
	HKVNN3fmLcEAtaFzruyba3NXDkahK2DDWh+EKT99JF8LZO59aSLQZBb/WtPY4djlejmocuEdBbl
	FFm+U2+9XauzyQLuqkH39bjwdMXrAFunfTQmc9QzESfd+bB0nogtTyfNBwjPKOI+Gj73v2y0V43
	yNNiB4hADz0J1RnnAtm7qROjvcvsQi0hPom7LR6qefKUrDs74uHoJbvOR3Sa2rcvgL7Ae0um/cG
	DnMhg27S+K88fdFv2XG59BELmmgIuZKa7IUHsk6SAMUdNQI1rR3GoXxsJaavEglGjB9tzSSeS8u
	QWUht8tpMd78RVIOO2bbyvhUpQ8jx0KZ804=
X-Received: by 2002:a05:6870:d1ca:b0:448:558c:d839 with SMTP id 586e51a60fabf-45163d9ba1cmr6025319fac.40.1783630481311;
        Thu, 09 Jul 2026 13:54:41 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-451916d5cebsm3059283fac.15.2026.07.09.13.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:54:40 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	andrew.gospodarek@broadcom.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v15 5/9] tls: prep helpers and refactors for HW offload KeyUpdate
Date: Thu,  9 Jul 2026 14:53:21 -0600
Message-Id: <20260709205325.1591196-6-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709205325.1591196-1-rjethwani@purestorage.com>
References: <20260709205325.1591196-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,broadcom.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-306375-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:borisp@nvidia.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:andrew.gospodarek@broadcom.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,purestorage.com:from_mime,purestorage.com:email,purestorage.com:mid,purestorage.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E255E735971

Preparatory refactors for TX and RX HW rekey support; no functional
change.

  - Hoist cipher_context / tls_crypto_context above
    tls_offload_context_tx so they can be embedded in offload
    contexts.

  - Add tls_tx_cipher_ctx() accessor and factor tls_sw_ctx_tx_init()
    so the TX path can redirect to a temporary SW context during
    rekey.

  - Split tls_set_device_offload() into a dispatcher and
    tls_set_device_offload_initial(); a _rekey() sibling follows.

  - Factor tls_device_dev_add_tx() and tls_device_commit_start_marker()
    so the rekey completion path can reuse them.

  - Move crypto_aead_setauthsize() into the !*aead block so a fresh
    AEAD is correctly configured when RX HW rekey allocates one.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 include/net/tls.h    |  38 +++++++-----
 net/tls/tls.h        |   1 +
 net/tls/tls_device.c | 139 ++++++++++++++++++++++++++-----------------
 net/tls/tls_sw.c     |  33 +++++-----
 4 files changed, 127 insertions(+), 84 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index e57bef58851e..eb258bcd62bc 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -155,6 +155,22 @@ struct tls_record_info {
 	skb_frag_t frags[MAX_SKB_FRAGS];
 };
 
+struct cipher_context {
+	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
+	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
+};
+
+union tls_crypto_context {
+	struct tls_crypto_info info;
+	union {
+		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
+		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
+		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
+		struct tls12_crypto_info_sm4_gcm sm4_gcm;
+		struct tls12_crypto_info_sm4_ccm sm4_ccm;
+	};
+};
+
 #define TLS_DRIVER_STATE_SIZE_TX	16
 struct tls_offload_context_tx {
 	struct crypto_aead *aead_send;
@@ -195,22 +211,6 @@ enum tls_context_flags {
 	TLS_RX_DEV_CLOSED = 2,
 };
 
-struct cipher_context {
-	char iv[TLS_MAX_IV_SIZE + TLS_MAX_SALT_SIZE];
-	char rec_seq[TLS_MAX_REC_SEQ_SIZE];
-};
-
-union tls_crypto_context {
-	struct tls_crypto_info info;
-	union {
-		struct tls12_crypto_info_aes_gcm_128 aes_gcm_128;
-		struct tls12_crypto_info_aes_gcm_256 aes_gcm_256;
-		struct tls12_crypto_info_chacha20_poly1305 chacha20_poly1305;
-		struct tls12_crypto_info_sm4_gcm sm4_gcm;
-		struct tls12_crypto_info_sm4_ccm sm4_ccm;
-	};
-};
-
 struct tls_prot_info {
 	u16 version;
 	u16 cipher_type;
@@ -392,6 +392,12 @@ static inline struct tls_sw_context_tx *tls_sw_ctx_tx(
 	return (struct tls_sw_context_tx *)tls_ctx->priv_ctx_tx;
 }
 
+static inline struct cipher_context *tls_tx_cipher_ctx(
+		const struct tls_context *tls_ctx)
+{
+	return (struct cipher_context *)&tls_ctx->tx;
+}
+
 static inline struct tls_offload_context_tx *
 tls_offload_ctx_tx(const struct tls_context *tls_ctx)
 {
diff --git a/net/tls/tls.h b/net/tls/tls.h
index 5a6ee1ea00f8..bf46d3471da6 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -157,6 +157,7 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
 int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx);
 void tls_sw_splice_eof(struct socket *sock);
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx);
 void tls_sw_release_resources_tx(struct sock *sk);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index f22f8a550c82..7a98d2f6cbd3 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -138,6 +138,41 @@ static struct net_device *get_netdev_for_sock(struct sock *sk)
 	return lowest_dev;
 }
 
+static int tls_device_dev_add_tx(struct sock *sk, struct net_device *netdev,
+				 struct tls_crypto_info *crypto_info,
+				 u32 write_seq)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	char *rec_seq;
+	int rc;
+
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	DEBUG_NET_WARN_ON_ONCE(!cipher_desc || !cipher_desc->offloadable);
+
+	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
+					     crypto_info, write_seq);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
+				     write_seq, rec_seq, rc);
+	return rc;
+}
+
+static void tls_device_commit_start_marker(struct sock *sk,
+					struct tls_offload_context_tx *offload_ctx,
+					struct tls_record_info *start_marker_record)
+{
+	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
+	start_marker_record->len = 0;
+	start_marker_record->num_frags = 0;
+	list_add_tail_rcu(&start_marker_record->list, &offload_ctx->records_list);
+
+	/* TLS offload is greatly simplified if we don't send
+	 * SKBs where only part of the payload needs to be encrypted.
+	 * So mark the last skb in the write queue as end of record.
+	 */
+	tcp_write_collapse_fence(sk);
+}
+
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1068,57 +1103,31 @@ static struct tls_offload_context_tx *alloc_offload_ctx_tx(struct tls_context *c
 	return offload_ctx;
 }
 
-int tls_set_device_offload(struct sock *sk)
+static int tls_set_device_offload_initial(struct sock *sk,
+					  struct tls_context *ctx,
+					  struct net_device *netdev,
+					  struct tls_crypto_info *crypto_info,
+					  const struct tls_cipher_desc *cipher_desc)
 {
+	struct tls_prot_info *prot = &ctx->prot_info;
 	struct tls_record_info *start_marker_record;
 	struct tls_offload_context_tx *offload_ctx;
-	const struct tls_cipher_desc *cipher_desc;
-	struct tls_crypto_info *crypto_info;
-	struct tls_prot_info *prot;
-	struct net_device *netdev;
-	struct tls_context *ctx;
 	char *iv, *rec_seq;
 	int rc;
 
-	ctx = tls_get_ctx(sk);
-	prot = &ctx->prot_info;
-
-	if (ctx->priv_ctx_tx)
-		return -EEXIST;
-
-	netdev = get_netdev_for_sock(sk);
-	if (!netdev) {
-		pr_err_ratelimited("%s: netdev not found\n", __func__);
-		return -EINVAL;
-	}
-
-	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
-		rc = -EOPNOTSUPP;
-		goto release_netdev;
-	}
-
-	crypto_info = &ctx->crypto_send.info;
-	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
-	if (!cipher_desc || !cipher_desc->offloadable) {
-		rc = -EINVAL;
-		goto release_netdev;
-	}
+	iv = crypto_info_iv(crypto_info, cipher_desc);
+	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
 
 	rc = init_prot_info(prot, crypto_info, cipher_desc);
 	if (rc)
-		goto release_netdev;
-
-	iv = crypto_info_iv(crypto_info, cipher_desc);
-	rec_seq = crypto_info_rec_seq(crypto_info, cipher_desc);
+		return rc;
 
 	memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
 	memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
 
 	start_marker_record = kmalloc_obj(*start_marker_record);
-	if (!start_marker_record) {
-		rc = -ENOMEM;
-		goto release_netdev;
-	}
+	if (!start_marker_record)
+		return -ENOMEM;
 
 	offload_ctx = alloc_offload_ctx_tx(ctx);
 	if (!offload_ctx) {
@@ -1130,20 +1139,11 @@ int tls_set_device_offload(struct sock *sk)
 	if (rc)
 		goto free_offload_ctx;
 
-	start_marker_record->end_seq = tcp_sk(sk)->write_seq;
-	start_marker_record->len = 0;
-	start_marker_record->num_frags = 0;
-	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
+	tls_device_commit_start_marker(sk, offload_ctx, start_marker_record);
 
 	clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
 	ctx->push_pending_record = tls_device_push_pending_record;
 
-	/* TLS offload is greatly simplified if we don't send
-	 * SKBs where only part of the payload needs to be encrypted.
-	 * So mark the last skb in the write queue as end of record.
-	 */
-	tcp_write_collapse_fence(sk);
-
 	/* Avoid offloading if the device is down
 	 * We don't want to offload new flows after
 	 * the NETDEV_DOWN event
@@ -1159,11 +1159,8 @@ int tls_set_device_offload(struct sock *sk)
 	}
 
 	ctx->priv_ctx_tx = offload_ctx;
-	rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
-					     &ctx->crypto_send.info,
-					     tcp_sk(sk)->write_seq);
-	trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
-				     tcp_sk(sk)->write_seq, rec_seq, rc);
+	rc = tls_device_dev_add_tx(sk, netdev, crypto_info,
+				   tcp_sk(sk)->write_seq);
 	if (rc)
 		goto release_lock;
 
@@ -1175,7 +1172,6 @@ int tls_set_device_offload(struct sock *sk)
 	 * by the netdev's xmit function.
 	 */
 	smp_store_release(&sk->sk_validate_xmit_skb, tls_validate_xmit_skb);
-	dev_put(netdev);
 
 	return 0;
 
@@ -1188,6 +1184,43 @@ int tls_set_device_offload(struct sock *sk)
 	ctx->priv_ctx_tx = NULL;
 free_marker_record:
 	kfree(start_marker_record);
+	return rc;
+}
+
+int tls_set_device_offload(struct sock *sk)
+{
+	const struct tls_cipher_desc *cipher_desc;
+	struct tls_crypto_info *crypto_info;
+	struct net_device *netdev;
+	struct tls_context *ctx;
+	int rc;
+
+	ctx = tls_get_ctx(sk);
+
+	if (ctx->priv_ctx_tx)
+		return -EEXIST;
+
+	netdev = get_netdev_for_sock(sk);
+	if (!netdev) {
+		pr_err_ratelimited("%s: netdev not found\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
+		rc = -EOPNOTSUPP;
+		goto release_netdev;
+	}
+
+	crypto_info = &ctx->crypto_send.info;
+	cipher_desc = get_cipher_desc(crypto_info->cipher_type);
+	if (!cipher_desc || !cipher_desc->offloadable) {
+		rc = -EINVAL;
+		goto release_netdev;
+	}
+
+	rc = tls_set_device_offload_initial(sk, ctx, netdev, crypto_info,
+					    cipher_desc);
+
 release_netdev:
 	dev_put(netdev);
 	return rc;
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 383eab5150ce..b8e06b751efe 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -555,11 +555,11 @@ static int tls_do_encryption(struct sock *sk,
 		break;
 	}
 
-	memcpy(&rec->iv_data[iv_offset], tls_ctx->tx.iv,
+	memcpy(&rec->iv_data[iv_offset], tls_tx_cipher_ctx(tls_ctx)->iv,
 	       prot->iv_size + prot->salt_size);
 
 	tls_xor_iv_with_seq(prot, rec->iv_data + iv_offset,
-			    tls_ctx->tx.rec_seq);
+			    tls_tx_cipher_ctx(tls_ctx)->rec_seq);
 
 	sge->offset += prot->prepend_size;
 	sge->length -= prot->prepend_size;
@@ -610,7 +610,7 @@ static int tls_do_encryption(struct sock *sk,
 
 	/* Unhook the record from context if encryption is not failure */
 	ctx->open_rec = NULL;
-	tls_advance_record_sn(sk, prot, &tls_ctx->tx);
+	tls_advance_record_sn(sk, prot, tls_tx_cipher_ctx(tls_ctx));
 	return rc;
 }
 
@@ -676,7 +676,7 @@ static int tls_push_record(struct sock *sk, int flags,
 	sg_chain(rec->sg_aead_out, 2, &msg_en->sg.data[i]);
 
 	tls_make_aad(rec->aad_space, msg_pl->sg.size + prot->tail_size,
-		     tls_ctx->tx.rec_seq, record_type, prot);
+		     tls_tx_cipher_ctx(tls_ctx)->rec_seq, record_type, prot);
 
 	tls_fill_prepend(tls_ctx,
 			 page_address(sg_page(&msg_en->sg.data[i])) +
@@ -2369,6 +2369,15 @@ static void tx_work_handler(struct work_struct *work)
 	}
 }
 
+void tls_sw_ctx_tx_init(struct sock *sk, struct tls_sw_context_tx *sw_ctx)
+{
+	crypto_init_wait(&sw_ctx->async_wait);
+	atomic_set(&sw_ctx->encrypt_pending, 1);
+	INIT_LIST_HEAD(&sw_ctx->tx_list);
+	INIT_DELAYED_WORK(&sw_ctx->tx_work.work, tx_work_handler);
+	sw_ctx->tx_work.sk = sk;
+}
+
 static bool tls_is_tx_ready(struct tls_sw_context_tx *ctx)
 {
 	struct tls_rec *rec;
@@ -2420,11 +2429,7 @@ static struct tls_sw_context_tx *init_ctx_tx(struct tls_context *ctx, struct soc
 		sw_ctx_tx = ctx->priv_ctx_tx;
 	}
 
-	crypto_init_wait(&sw_ctx_tx->async_wait);
-	atomic_set(&sw_ctx_tx->encrypt_pending, 1);
-	INIT_LIST_HEAD(&sw_ctx_tx->tx_list);
-	INIT_DELAYED_WORK(&sw_ctx_tx->tx_work.work, tx_work_handler);
-	sw_ctx_tx->tx_work.sk = sk;
+	tls_sw_ctx_tx_init(sk, sw_ctx_tx);
 
 	return sw_ctx_tx;
 }
@@ -2551,6 +2556,10 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			*aead = NULL;
 			goto free_priv;
 		}
+
+		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
+		if (rc)
+			goto free_aead;
 	}
 
 	ctx->push_pending_record = tls_sw_push_pending_record;
@@ -2567,12 +2576,6 @@ int tls_sw_ctx_init(struct sock *sk, int tx,
 			goto free_aead;
 	}
 
-	if (!new_crypto_info) {
-		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
-		if (rc)
-			goto free_aead;
-	}
-
 	if (!tx && !new_crypto_info) {
 		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);
 
-- 
2.25.1



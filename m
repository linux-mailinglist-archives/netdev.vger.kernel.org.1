Return-Path: <netdev+bounces-301046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jo9qBckSOWp1mQcAu9opvQ
	(envelope-from <netdev+bounces-301046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:47:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D36AED3A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CySggEjO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301046-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301046-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55402302A4F4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2696E377EBA;
	Mon, 22 Jun 2026 10:45:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C10377EBC;
	Mon, 22 Jun 2026 10:45:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125111; cv=none; b=qvwLoh1F/NKEs1XOr1z31jIDuDQw6lpo/3ZUK3UPvjXNHiT3ybr3aA0QvsohfIOcO9tOaIqdFPnZqSWdmTwa7Ytj69MvjpN9ngEfJTZF6GeZRYcMwNF1Z4k4/YjSniixVfdfksC+ROGClwUPV0ShTmfIF8bYqVYerEkn1oae+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125111; c=relaxed/simple;
	bh=BysBD/KiCO2kzwS8UjYAEXCaQLi08XyqkdzCcqQ9jiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgdX1gczfq2I9eIVWryb00MYswbHbJfh1cRyEHv9X+NG1zXMVE6vtcyLmEqztitXWKmVTx0VXzIcuStJGTw7+l86u5DHQppqDJb8t0IumXWQQvwgmvG6XLySMCJmuKhfjF+Sh+ufXnbKE5Znn+jRblM8aXwhT3dcRgwF9xpyNLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CySggEjO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29711F00A3A;
	Mon, 22 Jun 2026 10:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125109;
	bh=+BNaWJI0mtv2ppA8Vy396ETUGmIt5K1VDkVdiNfbH3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CySggEjONBlMs6WRAxjHZA2U3l+lE+FShbOeSkmOU7NiLgFCVPKoGwg/eBCgGlzRu
	 k+SA+MlfoH1ukkPdSzCPUFdq8g2/lw8vfbx4hXpRQbq490p6VIX4aZWEaNkAIh0+7D
	 MfL/CNBEGLpVSff3nanWWRe7RCtI/srAl1lzz4DJSDDAhWgBR78J77oGjzhO50UnuZ
	 c3pjtvX7E0IvFM/B0jrzQgX7s32yyHOcREsYAVz4GkWf9TKfXM4ppDJYHDtD2Bn6D/
	 LGly8gwyh1zcFlZGT2g+d2G2QqrtqBahc9A+zc15lm6W2jahz6ZOmHBHSBwr4F9RZD
	 UyE1el/mmjy7A==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 10/17] tls: use protocol ops via tls_context
Date: Mon, 22 Jun 2026 18:43:30 +0800
Message-ID: <48b1e0873abc726e87c16f89c19f2f66f78864f1.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782123118.git.tanggeliang@kylinos.cn>
References: <cover.1782123118.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:hare@suse.de,m:tanggeliang@kylinos.cn,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:yangang@kylinos.cn,m:qiang.zhang@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,queasysnail.net,suse.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301046-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 745D36AED3A

From: Geliang Tang <tanggeliang@kylinos.cn>

Currently, TLS code directly calls TCP-specific functions (e.g.,
tcp_rate_check_app_limited, tcp_read_done, tcp_epollin_ready, etc.)
and accesses TCP-specific fields (e.g., TCP_SKB_CB(skb)->seq).
This makes it hard to support other protocols like MPTCP.

Introduce a struct tls_prot_ops pointer in tls_context, which is
initialized during tls_init based on the socket protocol (TCP or
MPTCP). All protocol-dependent operations are now invoked via this
ops pointer, allowing each protocol to provide its own implementation.

Also add proper module reference counting for the ops owner.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/tls.h  |  2 ++
 net/tls/tls_main.c | 15 ++++++++++++++-
 net/tls/tls_strp.c | 26 ++++++++++++++++++--------
 net/tls/tls_sw.c   |  6 ++++--
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index 500fe87b50d2..9270de42787b 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -280,6 +280,8 @@ struct tls_context {
 	int (*sk_read_sock)(struct sock *sk, read_descriptor_t *desc,
 			    sk_read_actor_t recv_actor);
 
+	const struct tls_prot_ops *ops;
+
 	union tls_crypto_context crypto_send;
 	union tls_crypto_context crypto_recv;
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 296d133fa61f..b45890e75c9e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -201,7 +201,7 @@ int tls_push_sg(struct sock *sk,
 	ctx->splicing_pages = true;
 	while (1) {
 		/* is sending application-limited? */
-		tcp_rate_check_app_limited(sk);
+		ctx->ops->check_app_limited(sk);
 		p = sg_page(sg);
 retry:
 		bvec_set_page(&bvec, p, size, offset);
@@ -340,6 +340,11 @@ void tls_ctx_free(struct sock *sk, struct tls_context *ctx)
 	if (!ctx)
 		return;
 
+	if (ctx->ops) {
+		module_put(ctx->ops->owner);
+		ctx->ops = NULL;
+	}
+
 	memzero_explicit(&ctx->crypto_send, sizeof(ctx->crypto_send));
 	memzero_explicit(&ctx->crypto_recv, sizeof(ctx->crypto_recv));
 	mutex_destroy(&ctx->tx_lock);
@@ -1079,6 +1084,7 @@ static struct tls_prot_ops *tls_prot_ops_find(int protocol)
 
 static int tls_init(struct sock *sk)
 {
+	struct tls_prot_ops *ops;
 	struct tls_context *ctx;
 	int rc = 0;
 
@@ -1101,10 +1107,17 @@ static int tls_init(struct sock *sk)
 		goto out;
 	}
 
+	ops = tls_prot_ops_find(sk->sk_protocol);
+	if (!ops || !try_module_get(ops->owner)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
 	ctx->tx_max_payload_len = TLS_MAX_PAYLOAD_SIZE;
 	ctx->sk_read_sock = sk->sk_socket->ops->read_sock;
+	ctx->ops = ops;
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 9945d17b2f8c..48eb4b692f47 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -120,6 +120,7 @@ struct sk_buff *tls_strp_msg_detach(struct tls_sw_context_rx *ctx)
 int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 {
 	struct tls_strparser *strp = &ctx->strp;
+	struct tls_context *tls_ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *skb;
 
 	if (strp->copy_mode)
@@ -132,7 +133,7 @@ int tls_strp_msg_cow(struct tls_sw_context_rx *ctx)
 	tls_strp_anchor_free(strp);
 	strp->anchor = skb;
 
-	tcp_read_done(strp->sk, strp->stm.full_len);
+	tls_ctx->ops->read_done(strp->sk, strp->stm.full_len);
 	strp->copy_mode = 1;
 
 	return 0;
@@ -390,6 +391,7 @@ static int tls_strp_read_copyin(struct tls_strparser *strp)
 
 static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct skb_shared_info *shinfo;
 	struct page *page;
 	int need_spc, len;
@@ -398,7 +400,7 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	 * to read the data out. Otherwise the connection will stall.
 	 * Without pressure threshold of INT_MAX will never be ready.
 	 */
-	if (likely(qshort && !tcp_epollin_ready(strp->sk, INT_MAX)))
+	if (likely(qshort && !ctx->ops->epollin_ready(strp->sk)))
 		return 0;
 
 	shinfo = skb_shinfo(strp->anchor);
@@ -434,12 +436,13 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 {
 	unsigned int len = strp->stm.offset + strp->stm.full_len;
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *first, *skb;
 	u32 seq;
 
 	first = skb_shinfo(strp->anchor)->frag_list;
 	skb = first;
-	seq = TCP_SKB_CB(first)->seq;
+	seq = ctx->ops->get_skb_seq(first);
 
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
@@ -449,7 +452,7 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 		len -= skb->len;
 		skb = skb->next;
 
-		if (TCP_SKB_CB(skb)->seq != seq)
+		if (ctx->ops->get_skb_seq(skb) != seq)
 			return false;
 		if (skb_cmp_decrypted(first, skb))
 			return false;
@@ -460,11 +463,11 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 
 static void tls_strp_load_anchor_with_queue(struct tls_strparser *strp, int len)
 {
-	struct tcp_sock *tp = tcp_sk(strp->sk);
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
 	struct sk_buff *first;
 	u32 offset;
 
-	first = tcp_recv_skb(strp->sk, tp->copied_seq, &offset);
+	first = ctx->ops->recv_skb(strp->sk, &offset);
 	if (WARN_ON_ONCE(!first))
 		return;
 
@@ -565,6 +568,11 @@ void tls_strp_check_rcv(struct tls_strparser *strp, bool announce)
 /* Lower sock lock held */
 void tls_strp_data_ready(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
+	if (!ctx)
+		return;
+
 	/* This check is needed to synchronize with do_tls_strp_work.
 	 * do_tls_strp_work acquires a process lock (lock_sock) whereas
 	 * the lock held here is bh_lock_sock. The two locks can be
@@ -572,7 +580,7 @@ void tls_strp_data_ready(struct tls_strparser *strp)
 	 * allows a thread in BH context to safely check if the process
 	 * lock is held. In this case, if the lock is held, queue work.
 	 */
-	if (sock_owned_by_user_nocheck(strp->sk)) {
+	if (ctx->ops->lock_is_held(strp->sk)) {
 		queue_work(tls_strp_wq, &strp->work);
 		return;
 	}
@@ -597,10 +605,12 @@ static void tls_strp_work(struct work_struct *w)
  */
 void tls_strp_msg_consume(struct tls_strparser *strp)
 {
+	struct tls_context *ctx = tls_get_ctx(strp->sk);
+
 	WARN_ON(!strp->stm.full_len);
 
 	if (likely(!strp->copy_mode))
-		tcp_read_done(strp->sk, strp->stm.full_len);
+		ctx->ops->read_done(strp->sk, strp->stm.full_len);
 	else
 		tls_strp_flush_anchor_copy(strp);
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 35fb0c3c965a..71ab9763b1ed 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2171,7 +2171,8 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	/* Linearize header to local buffer */
-	ret = skb_copy_bits(skb, strp->stm.offset, header, prot->prepend_size);
+	ret = tls_ctx->ops->skb_get_header(skb, strp->stm.offset, header,
+					   prot->prepend_size);
 	if (ret < 0)
 		goto read_failure;
 
@@ -2202,7 +2203,8 @@ int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb)
 	}
 
 	tls_device_rx_resync_new_rec(strp->sk, data_len + TLS_HEADER_SIZE,
-				     TCP_SKB_CB(skb)->seq + strp->stm.offset);
+				     tls_ctx->ops->get_skb_seq(skb) +
+				     strp->stm.offset);
 	return data_len + TLS_HEADER_SIZE;
 
 read_failure:
-- 
2.53.0



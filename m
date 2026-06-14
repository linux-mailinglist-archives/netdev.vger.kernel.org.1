Return-Path: <netdev+bounces-299120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4C7AsgGLmp8ogQAu9opvQ
	(envelope-from <netdev+bounces-299120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 996D5680302
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BQolPJ9O;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7219A3006806
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514D2DF136;
	Sun, 14 Jun 2026 01:41:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A942BEC23;
	Sun, 14 Jun 2026 01:41:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401274; cv=none; b=J8XYJ1WcWc3vKNJLY9GxCmCjsxPW424APD01JcVFQm0e1/2aNDLuxUNrS+hm6wveLE9d9vSSusG1keKJeRwq4X59vpTLIxJItf4uMUUX2x0zuDBHwDUO4sL2V2lKSIqceZtivcqJMwTQhZu8A/RM4zZuGpYexGgQ3HfqccfdrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401274; c=relaxed/simple;
	bh=7nwOVxaTopSgBAvZMH/AQWNOx5hAxldSKHj41/hZn3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2wfQVC6qqIHO4Ny2pIPLPjH1iVe64sumcJAorRDIFyc0F31zT+q9buJ3QNaS2a4iU1m+ZFfamHFgeHvQRykf++Io3trphRWlX1PDa+LkJZ0ppCqYPFSlFnUfNnRzPdTjkRj2X6HrrpzWfpr4Th2KHVulUlCJ8Pz9qNHp2KIim4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQolPJ9O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62381F00A3D;
	Sun, 14 Jun 2026 01:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401272;
	bh=XGaEtV+jKgvr/BcLJkjdFwj1ffjQNqsC/myBRwYPaJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BQolPJ9OYa6yjpyJwGhJ4hbpWWylqv0Aivkj3ePDtdPva05VQLciF0w2Cz5BpTX/e
	 wMaX3gocgd/oQk30cUQOBPXThzxyyVkcX+lyfshEEhrc2BseredsVao7TZPnqlfO+W
	 K59ifiZdNPSND0adNQXwN7hnics08PfgVp+DGIJgfyDdgeq8OAeu7Q1D6cY/sWAEck
	 SLUDnQWESAwvdnd7WVUcwiVCuVM4aFIYCpdy8sNxV+R589z+zrqzOa2GHtRa0fZP0s
	 fVM1YHr+iY1NeMMFrPFrluMwdf9PBW9lcIVuAANZkpZGIZMuI3hGEn/HVGwOenbHHb
	 jiLxqmAfqRCJw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/5] tls: remove dead sockmap (psock) handling from the SW path
Date: Sat, 13 Jun 2026 18:40:57 -0700
Message-ID: <20260614014102.461064-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614014102.461064-1-kuba@kernel.org>
References: <20260614014102.461064-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299120-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 996D5680302

TLS and sockmap are now mutually exclusive. Try to delete the code
from sendmsg and recvmsg path which is now obviously dead.

The main goal is to delete enough code for AI security scanners
to no longer bother us with sockmap related bugs. At the same
time retain the code in case someone has the cycles to fix
all of this and make the integration work, again.

If the integration does not get restored we can wipe the rest
of the skmsg code from TLS in two or three releases.

The changes on the Tx side are deeper since that's where most
of the bugs are, Rx side simply takes the data from sockmap
and gives it to the user. On Tx split record handling and
rolling back the iterator were the two problem areas.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/skmsg.h |   9 -
 net/core/skmsg.c      |  52 +-----
 net/tls/tls_main.c    |   8 +-
 net/tls/tls_sw.c      | 399 +++---------------------------------------
 4 files changed, 31 insertions(+), 437 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 19f4f253b4f9..ca0ec9c8608e 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -544,15 +544,6 @@ static inline void psock_progs_drop(struct sk_psock_progs *progs)
 	psock_set_prog(&progs->skb_verdict, NULL);
 }
 
-int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb);
-
-static inline bool sk_psock_strp_enabled(struct sk_psock *psock)
-{
-	if (!psock)
-		return false;
-	return !!psock->saved_data_ready;
-}
-
 /* for tcp only, sk is locked */
 static inline ssize_t sk_psock_msg_inq(struct sock *sk)
 {
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e1850caf1a71..73ae12f25940 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -7,7 +7,6 @@
 
 #include <net/sock.h>
 #include <net/tcp.h>
-#include <net/tls.h>
 #include <trace/events/sock.h>
 
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
@@ -992,41 +991,6 @@ static int sk_psock_skb_redirect(struct sk_psock *from, struct sk_buff *skb)
 	return 0;
 }
 
-static void sk_psock_tls_verdict_apply(struct sk_buff *skb,
-				       struct sk_psock *from, int verdict)
-{
-	switch (verdict) {
-	case __SK_REDIRECT:
-		sk_psock_skb_redirect(from, skb);
-		break;
-	case __SK_PASS:
-	case __SK_DROP:
-	default:
-		break;
-	}
-}
-
-int sk_psock_tls_strp_read(struct sk_psock *psock, struct sk_buff *skb)
-{
-	struct bpf_prog *prog;
-	int ret = __SK_PASS;
-
-	rcu_read_lock();
-	prog = READ_ONCE(psock->progs.stream_verdict);
-	if (likely(prog)) {
-		skb->sk = psock->sk;
-		skb_dst_drop(skb);
-		skb_bpf_redirect_clear(skb);
-		ret = bpf_prog_run_pin_on_cpu(prog, skb);
-		ret = sk_psock_map_verd(ret, skb_bpf_redirect_fetch(skb));
-		skb->sk = NULL;
-	}
-	sk_psock_tls_verdict_apply(skb, psock, ret);
-	rcu_read_unlock();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(sk_psock_tls_strp_read);
-
 static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				  int verdict)
 {
@@ -1167,13 +1131,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (likely(psock)) {
-		if (tls_sw_has_ctx_rx(sk)) {
-			psock->saved_data_ready(sk);
-		} else {
-			read_lock_bh(&sk->sk_callback_lock);
-			strp_data_ready(&psock->strp);
-			read_unlock_bh(&sk->sk_callback_lock);
-		}
+		read_lock_bh(&sk->sk_callback_lock);
+		strp_data_ready(&psock->strp);
+		read_unlock_bh(&sk->sk_callback_lock);
 	}
 	rcu_read_unlock();
 }
@@ -1275,12 +1235,6 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 	trace_sk_data_ready(sk);
 
 	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (psock && tls_sw_has_ctx_rx(sk)) {
-		psock->saved_data_ready(sk);
-		rcu_read_unlock();
-		return;
-	}
 	sock = READ_ONCE(sk->sk_socket);
 	if (likely(sock))
 		ops = READ_ONCE(sock->ops);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8e7ba018988d..8c588cdab733 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -402,7 +402,6 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	struct tls_sw_context_rx *ctx;
 	struct tls_context *tls_ctx;
 	struct sock *sk = sock->sk;
-	struct sk_psock *psock;
 	__poll_t mask = 0;
 	u8 shutdown;
 	int state;
@@ -416,17 +415,12 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 
 	tls_ctx = tls_get_ctx(sk);
 	ctx = tls_sw_ctx_rx(tls_ctx);
-	psock = sk_psock_get(sk);
 
 	if ((skb_queue_empty_lockless(&ctx->rx_list) &&
-	     !tls_strp_msg_ready(ctx) &&
-	     sk_psock_queue_empty(psock)) ||
+	     !tls_strp_msg_ready(ctx)) ||
 	    READ_ONCE(ctx->key_update_pending))
 		mask &= ~(EPOLLIN | EPOLLRDNORM);
 
-	if (psock)
-		sk_psock_put(sk, psock);
-
 	return mask;
 }
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5a4300c943a1..9324e4ed20a3 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -614,136 +614,17 @@ static int tls_do_encryption(struct sock *sk,
 	return rc;
 }
 
-static int tls_split_open_record(struct sock *sk, struct tls_rec *from,
-				 struct tls_rec **to, struct sk_msg *msg_opl,
-				 struct sk_msg *msg_oen, u32 split_point,
-				 u32 tx_overhead_size, u32 *orig_end)
-{
-	u32 i, j, bytes = 0, apply = msg_opl->apply_bytes;
-	struct scatterlist *sge, *osge, *nsge;
-	u32 orig_size = msg_opl->sg.size;
-	struct scatterlist tmp = { };
-	struct sk_msg *msg_npl;
-	struct tls_rec *new;
-	int ret;
-
-	new = tls_get_rec(sk);
-	if (!new)
-		return -ENOMEM;
-	ret = sk_msg_alloc(sk, &new->msg_encrypted, msg_opl->sg.size +
-			   tx_overhead_size, 0);
-	if (ret < 0) {
-		tls_free_rec(sk, new);
-		return ret;
-	}
-
-	*orig_end = msg_opl->sg.end;
-	i = msg_opl->sg.start;
-	sge = sk_msg_elem(msg_opl, i);
-	while (apply && sge->length) {
-		if (sge->length > apply) {
-			u32 len = sge->length - apply;
-
-			get_page(sg_page(sge));
-			sg_set_page(&tmp, sg_page(sge), len,
-				    sge->offset + apply);
-			sge->length = apply;
-			bytes += apply;
-			apply = 0;
-		} else {
-			apply -= sge->length;
-			bytes += sge->length;
-		}
-
-		sk_msg_iter_var_next(i);
-		if (i == msg_opl->sg.end)
-			break;
-		sge = sk_msg_elem(msg_opl, i);
-	}
-
-	msg_opl->sg.end = i;
-	msg_opl->sg.curr = i;
-	msg_opl->sg.copybreak = 0;
-	msg_opl->apply_bytes = 0;
-	msg_opl->sg.size = bytes;
-
-	msg_npl = &new->msg_plaintext;
-	msg_npl->apply_bytes = apply;
-	msg_npl->sg.size = orig_size - bytes;
-
-	j = msg_npl->sg.start;
-	nsge = sk_msg_elem(msg_npl, j);
-	if (tmp.length) {
-		memcpy(nsge, &tmp, sizeof(*nsge));
-		sk_msg_iter_var_next(j);
-		nsge = sk_msg_elem(msg_npl, j);
-	}
-
-	osge = sk_msg_elem(msg_opl, i);
-	while (osge->length) {
-		memcpy(nsge, osge, sizeof(*nsge));
-		sg_unmark_end(nsge);
-		sk_msg_iter_var_next(i);
-		sk_msg_iter_var_next(j);
-		if (i == *orig_end)
-			break;
-		osge = sk_msg_elem(msg_opl, i);
-		nsge = sk_msg_elem(msg_npl, j);
-	}
-
-	msg_npl->sg.end = j;
-	msg_npl->sg.curr = j;
-	msg_npl->sg.copybreak = 0;
-
-	*to = new;
-	return 0;
-}
-
-static void tls_merge_open_record(struct sock *sk, struct tls_rec *to,
-				  struct tls_rec *from, u32 orig_end)
-{
-	struct sk_msg *msg_npl = &from->msg_plaintext;
-	struct sk_msg *msg_opl = &to->msg_plaintext;
-	struct scatterlist *osge, *nsge;
-	u32 i, j;
-
-	i = msg_opl->sg.end;
-	sk_msg_iter_var_prev(i);
-	j = msg_npl->sg.start;
-
-	osge = sk_msg_elem(msg_opl, i);
-	nsge = sk_msg_elem(msg_npl, j);
-
-	if (sg_page(osge) == sg_page(nsge) &&
-	    osge->offset + osge->length == nsge->offset) {
-		osge->length += nsge->length;
-		put_page(sg_page(nsge));
-	}
-
-	msg_opl->sg.end = orig_end;
-	msg_opl->sg.curr = orig_end;
-	msg_opl->sg.copybreak = 0;
-	msg_opl->apply_bytes = msg_opl->sg.size + msg_npl->sg.size;
-	msg_opl->sg.size += msg_npl->sg.size;
-
-	sk_msg_free(sk, &to->msg_encrypted);
-	sk_msg_xfer_full(&to->msg_encrypted, &from->msg_encrypted);
-
-	kfree(from);
-}
-
 static int tls_push_record(struct sock *sk, int flags,
 			   unsigned char record_type)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
-	struct tls_rec *rec = ctx->open_rec, *tmp = NULL;
-	u32 i, split_point, orig_end;
+	struct tls_rec *rec = ctx->open_rec;
 	struct sk_msg *msg_pl, *msg_en;
 	struct aead_request *req;
-	bool split;
 	int rc;
+	u32 i;
 
 	if (!rec)
 		return 0;
@@ -751,38 +632,6 @@ static int tls_push_record(struct sock *sk, int flags,
 	msg_pl = &rec->msg_plaintext;
 	msg_en = &rec->msg_encrypted;
 
-	split_point = msg_pl->apply_bytes;
-	split = split_point && split_point < msg_pl->sg.size;
-	if (unlikely((!split &&
-		      msg_pl->sg.size +
-		      prot->overhead_size > msg_en->sg.size) ||
-		     (split &&
-		      split_point +
-		      prot->overhead_size > msg_en->sg.size))) {
-		split = true;
-		split_point = msg_en->sg.size;
-	}
-	if (split) {
-		rc = tls_split_open_record(sk, rec, &tmp, msg_pl, msg_en,
-					   split_point, prot->overhead_size,
-					   &orig_end);
-		if (rc < 0)
-			return rc;
-		/* This can happen if above tls_split_open_record allocates
-		 * a single large encryption buffer instead of two smaller
-		 * ones. In this case adjust pointers and continue without
-		 * split.
-		 */
-		if (!msg_pl->sg.size) {
-			tls_merge_open_record(sk, rec, tmp, orig_end);
-			msg_pl = &rec->msg_plaintext;
-			msg_en = &rec->msg_encrypted;
-			split = false;
-		}
-		sk_msg_trim(sk, msg_en, msg_pl->sg.size +
-			    prot->overhead_size);
-	}
-
 	rec->tx_flags = flags;
 	req = &rec->aead_req;
 
@@ -840,155 +689,26 @@ static int tls_push_record(struct sock *sk, int flags,
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
 			       msg_pl->sg.size + prot->tail_size, i);
 	if (rc < 0) {
-		if (rc != -EINPROGRESS) {
+		if (rc != -EINPROGRESS)
 			tls_err_abort(sk, -EBADMSG);
-			if (split) {
-				tls_ctx->pending_open_record_frags = true;
-				tls_merge_open_record(sk, rec, tmp, orig_end);
-			}
-		}
 		ctx->async_capable = 1;
 		return rc;
-	} else if (split) {
-		msg_pl = &tmp->msg_plaintext;
-		msg_en = &tmp->msg_encrypted;
-		sk_msg_trim(sk, msg_en, msg_pl->sg.size + prot->overhead_size);
-		tls_ctx->pending_open_record_frags = true;
-		ctx->open_rec = tmp;
 	}
 
 	return tls_tx_records(sk, flags);
 }
 
 static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
-			       bool full_record, u8 record_type,
-			       ssize_t *copied, int flags)
+			       u8 record_type, ssize_t *copied, int flags)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
-	struct sk_msg msg_redir = { };
-	struct sk_psock *psock;
-	struct sock *sk_redir;
-	struct tls_rec *rec;
-	bool enospc, policy, redir_ingress;
-	int err = 0, send;
-	u32 delta = 0;
+	int err;
 
-	policy = !(flags & MSG_SENDPAGE_NOPOLICY);
-	psock = sk_psock_get(sk);
-	if (!psock || !policy) {
-		err = tls_push_record(sk, flags, record_type);
-		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
-			*copied -= sk_msg_free(sk, msg);
-			tls_free_open_rec(sk);
-			err = -sk->sk_err;
-		}
-		if (psock)
-			sk_psock_put(sk, psock);
-		return err;
+	err = tls_push_record(sk, flags, record_type);
+	if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
+		*copied -= sk_msg_free(sk, msg);
+		tls_free_open_rec(sk);
+		err = -sk->sk_err;
 	}
-more_data:
-	enospc = sk_msg_full(msg);
-	if (psock->eval == __SK_NONE) {
-		delta = msg->sg.size;
-		psock->eval = sk_psock_msg_verdict(sk, psock, msg);
-		delta -= msg->sg.size;
-
-		if ((s32)delta > 0) {
-			/* It indicates that we executed bpf_msg_pop_data(),
-			 * causing the plaintext data size to decrease.
-			 * Therefore the encrypted data size also needs to
-			 * correspondingly decrease. We only need to subtract
-			 * delta to calculate the new ciphertext length since
-			 * ktls does not support block encryption.
-			 */
-			struct sk_msg *enc = &ctx->open_rec->msg_encrypted;
-
-			sk_msg_trim(sk, enc, enc->sg.size - delta);
-		}
-	}
-	if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
-	    !enospc && !full_record) {
-		err = -ENOSPC;
-		goto out_err;
-	}
-	msg->cork_bytes = 0;
-	send = msg->sg.size;
-	if (msg->apply_bytes && msg->apply_bytes < send)
-		send = msg->apply_bytes;
-
-	switch (psock->eval) {
-	case __SK_PASS:
-		err = tls_push_record(sk, flags, record_type);
-		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
-			*copied -= sk_msg_free(sk, msg);
-			tls_free_open_rec(sk);
-			err = -sk->sk_err;
-			goto out_err;
-		}
-		break;
-	case __SK_REDIRECT:
-		redir_ingress = psock->redir_ingress;
-		sk_redir = psock->sk_redir;
-		memcpy(&msg_redir, msg, sizeof(*msg));
-		if (msg->apply_bytes < send)
-			msg->apply_bytes = 0;
-		else
-			msg->apply_bytes -= send;
-		sk_msg_return_zero(sk, msg, send);
-		msg->sg.size -= send;
-		release_sock(sk);
-		err = tcp_bpf_sendmsg_redir(sk_redir, redir_ingress,
-					    &msg_redir, send, flags);
-		lock_sock(sk);
-		if (err < 0) {
-			/* Regardless of whether the data represented by
-			 * msg_redir is sent successfully, we have already
-			 * uncharged it via sk_msg_return_zero(). The
-			 * msg->sg.size represents the remaining unprocessed
-			 * data, which needs to be uncharged here.
-			 */
-			sk_mem_uncharge(sk, msg->sg.size);
-			*copied -= sk_msg_free_nocharge(sk, &msg_redir);
-			msg->sg.size = 0;
-		}
-		if (msg->sg.size == 0)
-			tls_free_open_rec(sk);
-		break;
-	case __SK_DROP:
-	default:
-		sk_msg_free_partial(sk, msg, send);
-		if (msg->apply_bytes < send)
-			msg->apply_bytes = 0;
-		else
-			msg->apply_bytes -= send;
-		if (msg->sg.size == 0)
-			tls_free_open_rec(sk);
-		*copied -= (send + delta);
-		err = -EACCES;
-	}
-
-	if (likely(!err)) {
-		bool reset_eval = !ctx->open_rec;
-
-		rec = ctx->open_rec;
-		if (rec) {
-			msg = &rec->msg_plaintext;
-			if (!msg->apply_bytes)
-				reset_eval = true;
-		}
-		if (reset_eval) {
-			psock->eval = __SK_NONE;
-			if (psock->sk_redir) {
-				sock_put(psock->sk_redir);
-				psock->sk_redir = NULL;
-			}
-		}
-		if (rec)
-			goto more_data;
-	}
- out_err:
-	sk_psock_put(sk, psock);
 	return err;
 }
 
@@ -1008,7 +728,7 @@ static int tls_sw_push_pending_record(struct sock *sk, int flags)
 	if (!copied)
 		return 0;
 
-	return bpf_exec_tx_verdict(msg_pl, sk, true, TLS_RECORD_TYPE_DATA,
+	return bpf_exec_tx_verdict(msg_pl, sk, TLS_RECORD_TYPE_DATA,
 				   &copied, flags);
 }
 
@@ -1156,7 +876,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			copied += try_to_copy;
 
 			sk_msg_sg_copy_set(msg_pl, first);
-			ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
+			ret = bpf_exec_tx_verdict(msg_pl, sk,
 						  record_type, &copied,
 						  msg->msg_flags);
 			if (ret) {
@@ -1164,13 +884,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ctx->open_rec && ret == -ENOSPC) {
-					if (msg_pl->cork_bytes) {
-						ret = 0;
-						goto send_end;
-					}
-					goto rollback_iter;
-				} else if (ret != -EAGAIN)
+				else if (ret != -EAGAIN)
 					goto send_end;
 			}
 
@@ -1181,11 +895,6 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			}
 
 			continue;
-rollback_iter:
-			copied -= try_to_copy;
-			sk_msg_sg_copy_clear(msg_pl, first);
-			iov_iter_revert(&msg->msg_iter,
-					msg_pl->sg.size - orig_size);
 fallback_to_reg_send:
 			sk_msg_trim(sk, msg_pl, orig_size);
 		}
@@ -1221,7 +930,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 		copied += try_to_copy;
 copied:
 		if (full_record || eor) {
-			ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
+			ret = bpf_exec_tx_verdict(msg_pl, sk,
 						  record_type, &copied,
 						  msg->msg_flags);
 			if (ret) {
@@ -1229,11 +938,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 					num_async++;
 				else if (ret == -ENOMEM)
 					goto wait_for_memory;
-				else if (ret != -EAGAIN) {
-					if (ret == -ENOSPC)
-						ret = 0;
+				else if (ret != -EAGAIN)
 					goto send_end;
-				}
 			}
 
 			/* Transmit if any encryptions have completed */
@@ -1335,8 +1041,8 @@ void tls_sw_splice_eof(struct socket *sock)
 	if (msg_pl->sg.size == 0)
 		goto unlock;
 
-	/* Check the BPF advisor and perform transmission. */
-	ret = bpf_exec_tx_verdict(msg_pl, sk, false, TLS_RECORD_TYPE_DATA,
+	/* Perform transmission. */
+	ret = bpf_exec_tx_verdict(msg_pl, sk, TLS_RECORD_TYPE_DATA,
 				  &copied, 0);
 	switch (ret) {
 	case 0:
@@ -1372,8 +1078,7 @@ void tls_sw_splice_eof(struct socket *sock)
  * consumed via sock_error().
  */
 static int
-tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
-		bool released, bool has_copied)
+tls_rx_rec_wait(struct sock *sk, bool nonblock, bool released, bool has_copied)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
@@ -1388,9 +1093,6 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	timeo = sock_rcvtimeo(sk, nonblock);
 
 	while (!tls_strp_msg_ready(ctx)) {
-		if (!sk_psock_queue_empty(psock))
-			return 0;
-
 		if (sk->sk_err) {
 			if (has_copied)
 				return -READ_ONCE(sk->sk_err);
@@ -1434,9 +1136,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		add_wait_queue(sk_sleep(sk), &wait);
 		sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		ret = sk_wait_event(sk, &timeo,
-				    tls_strp_msg_ready(ctx) ||
-				    !sk_psock_queue_empty(psock),
-				    &wait);
+				    tls_strp_msg_ready(ctx), &wait);
 		sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
 		remove_wait_queue(sk_sleep(sk), &wait);
 
@@ -1446,7 +1146,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	}
 
 	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
-		return tls_rx_rec_wait(sk, psock, nonblock, false, has_copied);
+		return tls_rx_rec_wait(sk, nonblock, false, has_copied);
 
 	return 1;
 }
@@ -2096,7 +1796,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	ssize_t decrypted = 0, async_copy_bytes = 0;
-	struct sk_psock *psock;
 	unsigned char control = 0;
 	size_t flushed_at = 0;
 	struct strp_msg *rxm;
@@ -2109,7 +1808,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	bool is_peek = flags & MSG_PEEK;
 	bool rx_more = false;
 	bool released = true;
-	bool bpf_strp_enabled;
 	bool zc_capable;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
@@ -2118,8 +1816,6 @@ int tls_sw_recvmsg(struct sock *sk,
 	err = tls_rx_reader_lock(sk, ctx, flags & MSG_DONTWAIT);
 	if (err < 0)
 		return err;
-	psock = sk_psock_get(sk);
-	bpf_strp_enabled = sk_psock_strp_enabled(psock);
 
 	/* If crypto failed the connection is broken */
 	err = ctx->async_wait.err;
@@ -2140,27 +1836,16 @@ int tls_sw_recvmsg(struct sock *sk,
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	len = len - copied;
 
-	zc_capable = !bpf_strp_enabled && !is_kvec && !is_peek &&
-		ctx->zc_capable;
+	zc_capable = !is_kvec && !is_peek && ctx->zc_capable;
 	decrypted = 0;
 	while (len && (decrypted + copied < target || tls_strp_msg_ready(ctx))) {
 		struct tls_decrypt_arg darg;
 		int to_decrypt, chunk;
 
-		err = tls_rx_rec_wait(sk, psock, flags & MSG_DONTWAIT,
+		err = tls_rx_rec_wait(sk, flags & MSG_DONTWAIT,
 				      released, !!(decrypted + copied));
-		if (err <= 0) {
-			if (psock) {
-				chunk = sk_msg_recvmsg(sk, psock, msg, len,
-						       flags);
-				if (chunk > 0) {
-					decrypted += chunk;
-					len -= chunk;
-					continue;
-				}
-			}
+		if (err <= 0)
 			goto recv_end;
-		}
 
 		memset(&darg.inargs, 0, sizeof(darg.inargs));
 
@@ -2174,7 +1859,7 @@ int tls_sw_recvmsg(struct sock *sk,
 			darg.zc = true;
 
 		/* Do not use async mode if record is non-data */
-		if (tlm->control == TLS_RECORD_TYPE_DATA && !bpf_strp_enabled)
+		if (tlm->control == TLS_RECORD_TYPE_DATA)
 			darg.async = ctx->async_capable;
 		else
 			darg.async = false;
@@ -2230,18 +1915,6 @@ int tls_sw_recvmsg(struct sock *sk,
 				continue;
 			}
 
-			if (bpf_strp_enabled) {
-				released = true;
-				err = sk_psock_tls_strp_read(psock, skb);
-				if (err != __SK_PASS) {
-					rxm->offset = rxm->offset + rxm->full_len;
-					rxm->full_len = 0;
-					if (err == __SK_DROP)
-						consume_skb(skb);
-					continue;
-				}
-			}
-
 			if (partially_consumed)
 				chunk = len;
 
@@ -2304,8 +1977,6 @@ int tls_sw_recvmsg(struct sock *sk,
 
 end:
 	tls_rx_reader_unlock(sk, ctx);
-	if (psock)
-		sk_psock_put(sk, psock);
 	return copied ? : err;
 }
 
@@ -2332,7 +2003,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 	} else {
 		struct tls_decrypt_arg darg;
 
-		err = tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
+		err = tls_rx_rec_wait(sk, flags & SPLICE_F_NONBLOCK,
 				      true, false);
 		if (err <= 0)
 			goto splice_read_end;
@@ -2417,7 +2088,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
-			err = tls_rx_rec_wait(sk, NULL, true, released, !!copied);
+			err = tls_rx_rec_wait(sk, true, released, !!copied);
 			if (err <= 0)
 				goto read_sock_end;
 
@@ -2473,16 +2144,8 @@ bool tls_sw_sock_is_readable(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
-	bool ingress_empty = true;
-	struct sk_psock *psock;
 
-	rcu_read_lock();
-	psock = sk_psock(sk);
-	if (psock)
-		ingress_empty = list_empty(&psock->ingress_msg);
-	rcu_read_unlock();
-
-	return !ingress_empty || tls_strp_msg_ready(ctx) ||
+	return tls_strp_msg_ready(ctx) ||
 		!skb_queue_empty(&ctx->rx_list);
 }
 
@@ -2565,7 +2228,6 @@ static void tls_data_ready(struct sock *sk)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
-	struct sk_psock *psock;
 	gfp_t alloc_save;
 
 	trace_sk_data_ready(sk);
@@ -2574,13 +2236,6 @@ static void tls_data_ready(struct sock *sk)
 	sk->sk_allocation = GFP_ATOMIC;
 	tls_strp_data_ready(&ctx->strp);
 	sk->sk_allocation = alloc_save;
-
-	psock = sk_psock_get(sk);
-	if (psock) {
-		if (!list_empty(&psock->ingress_msg))
-			ctx->saved_data_ready(sk);
-		sk_psock_put(sk, psock);
-	}
 }
 
 void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
-- 
2.54.0



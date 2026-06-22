Return-Path: <netdev+bounces-301037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dyy/KwISOWo+mQcAu9opvQ
	(envelope-from <netdev+bounces-301037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:44:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0F6AECBD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:44:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Lt3Y9+Jy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301037-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301037-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0F07300CDBD
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FA13947B0;
	Mon, 22 Jun 2026 10:44:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CDE36403B;
	Mon, 22 Jun 2026 10:44:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125054; cv=none; b=UW/PkXRLZlYh7tPUo4uLwL8EUv632FPB1fwCqkRmdEm3LlEt5Ryct32zZYQF6GZ+WeXrcE+SXhXRpdiSDZg9yrLQCg1HUJUgW8L+lRD2wp3Iaa/TKMwk0nOzHuxcBTj5NOmnGrs6DjrYMt0SPD6O/gf2RLWCmHbkaxgqfacMufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125054; c=relaxed/simple;
	bh=8n7LlVOuJlHzPRVuig1AXQ7RVkmp7CZcsBBL4ZlYS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/RcwT9c0KEX0u9ZYsPqLYHU35CZshx+hQSaDPjsjpx2ZEZyD3s3Ok89K4Z5KebIgNryIjaiqbGE4NhaT9Q0MmnhjjPp1mXN8mAvBqnnhVZgZrtnhFZIM2RwvKyoK1onk674BlxgYlnALxzTPQZqsNJ0zBdXagsNxyz4NQlA480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lt3Y9+Jy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E611F00A3A;
	Mon, 22 Jun 2026 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125053;
	bh=LS5C8oveC/OFKMD1yPkh69Cz4bn65BQ165iFbZz6YYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lt3Y9+JyhTJNPAjlKeaDkgxKdK7NOoHxphdMINgVH0gfFRU3EF1ghEs5/JUavIioE
	 y6OZY4FYER+WraRbX7h0/vhzZaBBUwEQU8pe2wWrIkOGv7+f7JEreQi9Yv6eSouccv
	 a2eb3PJZfUqWl9SeL1rM7UMC3I2lsE3NS8xR1r7eLa6Q4RlLjHSuSHHqqLD6xIs5xh
	 mfQEpMinjYIk9HriXPdfrc099Ypx3ZuegNb1RGT5oZALZ8iSkNYH6r5JWb6RlSh2bs
	 xEO1lZeM8W/ZUboJvOAmB8QZS7ENJv6esBQqlZQnWSnqFiIAqXP6d7MfDx4HXr5SqA
	 2xuBI4AFWRLZw==
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
Subject: [RFC net-next 01/17] tls: make tls_ctx_create and update_sk_prot static
Date: Mon, 22 Jun 2026 18:43:21 +0800
Message-ID: <a2117d4bad71c2f2cb114adb2c9faafe797d0c65.1782123118.git.tanggeliang@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-301037-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45D0F6AECBD

From: Geliang Tang <tanggeliang@kylinos.cn>

The TLS TOE (TCP offload engine) support has been removed. As a result,
tls_ctx_create() and update_sk_prot() are no longer used outside of
tls_main.c.

Make them static and remove their prototypes from tls.h. This avoids
exporting unnecessary symbols and cleans up the internal API.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls.h      | 2 --
 net/tls/tls_main.c | 4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 60a37bdaaa25..68dfe109808e 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -136,9 +136,7 @@ struct tls_rec {
 int __net_init tls_proc_init(struct net *net);
 void __net_exit tls_proc_fini(struct net *net);
 
-struct tls_context *tls_ctx_create(struct sock *sk);
 void tls_ctx_free(struct sock *sk, struct tls_context *ctx);
-void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 8c588cdab733..9675c75bc50c 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -126,7 +126,7 @@ static struct proto_ops tls_proto_ops[TLS_NUM_PROTS][TLS_NUM_CONFIG][TLS_NUM_CON
 static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 			 const struct proto *base);
 
-void update_sk_prot(struct sock *sk, struct tls_context *ctx)
+static void update_sk_prot(struct sock *sk, struct tls_context *ctx)
 {
 	int ip_ver = sk->sk_family == AF_INET6 ? TLSV6 : TLSV4;
 
@@ -913,7 +913,7 @@ static int tls_disconnect(struct sock *sk, int flags)
 	return -EOPNOTSUPP;
 }
 
-struct tls_context *tls_ctx_create(struct sock *sk)
+static struct tls_context *tls_ctx_create(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tls_context *ctx;
-- 
2.53.0



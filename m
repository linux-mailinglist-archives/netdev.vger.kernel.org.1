Return-Path: <netdev+bounces-301048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fx83BxkTOWqTmQcAu9opvQ
	(envelope-from <netdev+bounces-301048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:48:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A429E6AEDA1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:48:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O26V+GNv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301048-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301048-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C93F030699D2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD102D8379;
	Mon, 22 Jun 2026 10:45:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513222425B;
	Mon, 22 Jun 2026 10:45:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125123; cv=none; b=kHMN/p7Ydj9wVmzUpxZlRe1sVufT7ZoJelDU3agPSuthIQ2SQ2P7H5WaIJJgTEoVzXvvkV2PZKNyOCLw1CZiud1X5zenTPfumOpaX0XAYEFMx/1guR32j3sS4pFvfdzRIvMdv3zifslXrza1w074se61EMis8/NRgF5GV6ODtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125123; c=relaxed/simple;
	bh=N/6VknjjXpbN1MD/FqnHTdAkw9Tm/5ZBaUYYE2rQ+nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTTz4SS6Yem6UhwiNU3RCx2ccwnSQRd3ew2TLhO11B8G5W9PBNpJHtRvlQjr+DnTq7SLTCT09nYxxCDj9XHGvHIUFdYJbD8WbuhzWt0FCYMEI18JMQaXjL5bFqKlmKduJiyrozZE3YmG3MM0cs9SJGzkK0n3P6VKrpOFX4Otj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O26V+GNv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B4A1F00A3A;
	Mon, 22 Jun 2026 10:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125122;
	bh=3nAMPLkbHtZkUggX5mvXpgfHri8dhjwekxzXl9N1Kro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O26V+GNvu+PIgRGPM32bn7o4/c2iFMNS4z7TvamYqFbZihAaJmEmi+Rvgy+bi+V5s
	 b8APqHraU69Dl+lJBCjGCclv9JVF6WHf8YleaUWYOHe58YeZFTbmGk3M5NuhqBml1o
	 xdiWLIaknxSMbqDjigFDKNCq/CQSEC4MObc29DyoErQ4TvMLoDdc6oWlrNhdpmBtsz
	 8SkpMEZHeDYalk+Do/00cmGYGF7ERt2IUIchZSeSEItS1lhJjd3R63bk/D6f1sISyI
	 gaOFkEUhu4IHn9n1IIuTnHCiIkNCm+SP9UPSqlcWT4Yh/WJiWwcKU6UwwbkgcvxBNi
	 5z/gprzQhPQmw==
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
Subject: [RFC net-next 12/17] tls: add mptcp support for sk_poll
Date: Mon, 22 Jun 2026 18:43:32 +0800
Message-ID: <57bd0d017b79b2dd63ae71ed071dc946a00b63a2.1782123118.git.tanggeliang@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-301048-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A429E6AEDA1

From: Geliang Tang <tanggeliang@kylinos.cn>

The tls_sk_poll() function currently uses tcp_poll() unconditionally
to obtain the base poll mask, which works only for TCP. This prevents
TLS over MPTCP from working correctly with poll().

Make the poll function protocol-aware by selecting the appropriate
poll function based on sk->sk_protocol. For TCP it calls tcp_poll(),
for MPTCP it calls mptcp_poll() (guarded by CONFIG_MPTCP). Any other
protocol returns 0.

Also export mptcp_poll() symbol so that the TLS module can use it.

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 include/net/mptcp.h  |  9 +++++++++
 net/mptcp/protocol.c |  5 +++--
 net/tls/tls_main.c   | 17 ++++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index ba2257986b13..b0a172c38891 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -239,6 +239,9 @@ static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 }
 
 void mptcp_active_detect_blackhole(struct sock *sk, bool expired);
+
+__poll_t mptcp_poll(struct file *file, struct socket *sock,
+		    struct poll_table_struct *wait);
 #else
 
 static inline void mptcp_init(void)
@@ -316,6 +319,12 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
 
 static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
+
+static inline __poll_t mptcp_poll(struct file *file, struct socket *sock,
+				  struct poll_table_struct *wait)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f4cd7a6e5770..169bd468f212 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4446,8 +4446,8 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	return 0;
 }
 
-static __poll_t mptcp_poll(struct file *file, struct socket *sock,
-			   struct poll_table_struct *wait)
+__poll_t mptcp_poll(struct file *file, struct socket *sock,
+		    struct poll_table_struct *wait)
 {
 	struct sock *sk = sock->sk;
 	struct mptcp_sock *msk;
@@ -4494,6 +4494,7 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 
 	return mask;
 }
+EXPORT_SYMBOL_GPL(mptcp_poll);
 
 static struct sk_buff *mptcp_recv_skb(struct sock *sk, u32 *off)
 {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 170ccbb9d36d..fa9fda3480da 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -416,6 +416,21 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
 		tls_ctx_free(sk, ctx);
 }
 
+static __poll_t tls_proto_poll(struct file *file, struct socket *sock,
+			       struct poll_table_struct *wait)
+{
+	switch (sock->sk->sk_protocol) {
+	case IPPROTO_TCP:
+		return tcp_poll(file, sock, wait);
+#ifdef CONFIG_MPTCP
+	case IPPROTO_MPTCP:
+		return mptcp_poll(file, sock, wait);
+#endif
+	default:
+		return 0;
+	}
+}
+
 static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 			    struct poll_table_struct *wait)
 {
@@ -426,7 +441,7 @@ static __poll_t tls_sk_poll(struct file *file, struct socket *sock,
 	u8 shutdown;
 	int state;
 
-	mask = tcp_poll(file, sock, wait);
+	mask = tls_proto_poll(file, sock, wait);
 
 	state = inet_sk_state_load(sk);
 	shutdown = READ_ONCE(sk->sk_shutdown);
-- 
2.53.0



Return-Path: <netdev+bounces-38120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6157B9828
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BF0B61C20970
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E210949;
	Wed,  4 Oct 2023 22:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jiSk9x1p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4A25115
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 22:37:40 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61CD1980
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 15:37:14 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso2921365e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696459032; x=1697063832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klQ+Gzxu4nDh7F401Tk3HK013Gim0WNAZ0BwppdVTjk=;
        b=jiSk9x1p657rALG5ycnYjPlYWfJXzD59ZgNWyTzhpxJbUsbfiR45KSGU5r9NMFtbEp
         zbQWiD2QfpVpLWk0u7va8Z6wVF1IbO54UO/10VwSDjrad0ZpSJmK8MwYwBa6LaeF9OkP
         ccfqwvwE7fuOCgeMUfJvuhQEkZDrpvz4+A75qDQbLa60Uc3ap2uVA58VkogUBXiYXDNI
         9q9MxhxKHxrIPyLuEKixqLRjjeJ3SCA8pHniElsX4FRofEyNvk+TBEU/b4LnUtbzoccV
         JABI7DXlzenw87IF5lfGu/oKA/iizrXq5sbvSM8IS2p2Bl8h5KKWsrwpq6S/ayT3n8tp
         T+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696459032; x=1697063832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klQ+Gzxu4nDh7F401Tk3HK013Gim0WNAZ0BwppdVTjk=;
        b=jefgnVbloNI08VBdufzFDMRAgGBHBSVPTVs+zRZpC/k9BxGUR9t3iHy+j0LioT4kTj
         tg5JM3Y3OyWrIZ5VMYYPO3o4KMiWOzjwUC+F8SE1pQoQlcVV6lnVYF8dcB0WilhnoB1C
         s9Z/vwDUqqvYpeJZf8ASpmfJvJzSAy8O/fBcz21nSuHbzCsyiVpQAC+2FoT3XBTj9ptD
         2p3V0HqHY7go8OB+mDIiJSpOJW1aKIf0egeyP9Oly7mBFR8Gwd3LiBHNJIxoo5niDt/m
         DQMfrgnnJ4JTOQzXitasOb62cxPpWqEqxB3n4z3kSCAGq0DeFOuarZt2s55EBcRglQYX
         /F7g==
X-Gm-Message-State: AOJu0Ywl1sAL16MZrkZ9rmuJEHk0L4rrbPK0ZSWcYQqbePzxWn7pY4Rp
	rLVYAepr8PAtzu6C55h5psZPEQ==
X-Google-Smtp-Source: AGHT+IFfQr2FMj9eXkaS2s7e7jXmTFcou22eJEvAgA6xUjKnQJezJuCfvwI+j4I3WTcUjeu2oSF1jg==
X-Received: by 2002:a05:600c:d1:b0:405:3a3d:6f42 with SMTP id u17-20020a05600c00d100b004053a3d6f42mr3316843wmm.39.1696459032372;
        Wed, 04 Oct 2023 15:37:12 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0031ff89af0e4sm181412wrt.99.2023.10.04.15.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 15:37:11 -0700 (PDT)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Andy Lutomirski <luto@amacapital.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Bob Gilligan <gilligan@arista.com>,
	Dan Carpenter <error27@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Donald Cassidy <dcassidy@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	"Gaillardetz, Dominik" <dgaillar@ciena.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Ivan Delalande <colona@arista.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	"Nassiri, Mohammad" <mnassiri@ciena.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <simon.horman@corigine.com>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org
Subject: [PATCH v13 net-next 20/23] net/tcp: Add static_key for TCP-AO
Date: Wed,  4 Oct 2023 23:36:24 +0100
Message-ID: <20231004223629.166300-21-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004223629.166300-1-dima@arista.com>
References: <20231004223629.166300-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Similarly to TCP-MD5, add a static key to TCP-AO that is patched out
when there are no keys on a machine and dynamically enabled with the
first setsockopt(TCP_AO) adds a key on any socket. The static key is as
well dynamically disabled later when the socket is destructed.

The lifetime of enabled static key here is the same as ao_info: it is
enabled on allocation, passed over from full socket to twsk and
destructed when ao_info is scheduled for destruction.

Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h    | 24 +++++++++++++++--------
 include/net/tcp_ao.h |  2 ++
 net/ipv4/tcp_ao.c    | 22 +++++++++++++++++++++
 net/ipv4/tcp_input.c | 46 +++++++++++++++++++++++++++++---------------
 net/ipv4/tcp_ipv4.c  | 25 +++++++++++++-----------
 net/ipv6/tcp_ipv6.c  | 25 +++++++++++++-----------
 6 files changed, 98 insertions(+), 46 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d91ddeca1652..5215f4ff4a1c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2248,14 +2248,18 @@ static inline void tcp_get_current_key(const struct sock *sk,
 #if defined(CONFIG_TCP_AO) || defined(CONFIG_TCP_MD5SIG)
 	const struct tcp_sock *tp = tcp_sk(sk);
 #endif
-#ifdef CONFIG_TCP_AO
-	struct tcp_ao_info *ao;
 
-	ao = rcu_dereference_protected(tp->ao_info, lockdep_sock_is_held(sk));
-	if (ao) {
-		out->ao_key = READ_ONCE(ao->current_key);
-		out->type = TCP_KEY_AO;
-		return;
+#ifdef CONFIG_TCP_AO
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
+		struct tcp_ao_info *ao;
+
+		ao = rcu_dereference_protected(tp->ao_info,
+					       lockdep_sock_is_held(sk));
+		if (ao) {
+			out->ao_key = READ_ONCE(ao->current_key);
+			out->type = TCP_KEY_AO;
+			return;
+		}
 	}
 #endif
 #ifdef CONFIG_TCP_MD5SIG
@@ -2284,7 +2288,8 @@ static inline bool tcp_key_is_md5(const struct tcp_key *key)
 static inline bool tcp_key_is_ao(const struct tcp_key *key)
 {
 #ifdef CONFIG_TCP_AO
-	if (key->type == TCP_KEY_AO)
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    key->type == TCP_KEY_AO)
 		return true;
 #endif
 	return false;
@@ -2678,6 +2683,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	struct tcp_ao_info *ao_info;
 	struct tcp_ao_key *ao_key;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	ao_info = rcu_dereference_check(tcp_sk(sk)->ao_info,
 					lockdep_sock_is_held(sk));
 	if (!ao_info)
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 746bf078e59c..ba5b8c409e99 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -151,6 +151,8 @@ do {									\
 
 #ifdef CONFIG_TCP_AO
 /* TCP-AO structures and functions */
+#include <linux/jump_label.h>
+extern struct static_key_false_deferred tcp_ao_needed;
 
 struct tcp4_ao_context {
 	__be32		saddr;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index afd5943a9972..9e8016157a37 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -17,6 +17,8 @@
 #include <net/ipv6.h>
 #include <net/icmp.h>
 
+DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_ao_needed, HZ);
+
 int tcp_ao_calc_traffic_key(struct tcp_ao_key *mkt, u8 *key, void *ctx,
 			    unsigned int len, struct tcp_sigpool *hp)
 {
@@ -50,6 +52,9 @@ bool tcp_ao_ignore_icmp(const struct sock *sk, int type, int code)
 	bool ignore_icmp = false;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return false;
+
 	/* RFC5925, 7.8:
 	 * >> A TCP-AO implementation MUST default to ignore incoming ICMPv4
 	 * messages of Type 3 (destination unreachable), Codes 2-4 (protocol
@@ -185,6 +190,9 @@ static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
 	struct tcp_ao_key *key;
 	struct tcp_ao_info *ao;
 
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return NULL;
+
 	ao = rcu_dereference_check(tcp_sk(sk)->ao_info,
 				   lockdep_sock_is_held(sk));
 	if (!ao)
@@ -276,6 +284,7 @@ void tcp_ao_destroy_sock(struct sock *sk, bool twsk)
 	}
 
 	kfree_rcu(ao, rcu);
+	static_branch_slow_dec_deferred(&tcp_ao_needed);
 }
 
 void tcp_ao_time_wait(struct tcp_timewait_sock *tcptw, struct tcp_sock *tp)
@@ -1177,6 +1186,11 @@ int tcp_ao_copy_all_matching(const struct sock *sk, struct sock *newsk,
 		goto free_and_exit;
 	}
 
+	if (!static_key_fast_inc_not_disabled(&tcp_ao_needed.key.key)) {
+		ret = -EUSERS;
+		goto free_and_exit;
+	}
+
 	key_head = rcu_dereference(hlist_first_rcu(&new_ao->head));
 	first_key = hlist_entry_safe(key_head, struct tcp_ao_key, node);
 
@@ -1604,6 +1618,10 @@ static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
 
 	tcp_ao_link_mkt(ao_info, key);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			ret = -EUSERS;
+			goto err_free_sock;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
@@ -1872,6 +1890,10 @@ static int tcp_ao_info_cmd(struct sock *sk, unsigned short int family,
 	if (new_rnext)
 		WRITE_ONCE(ao_info->rnext_key, new_rnext);
 	if (first) {
+		if (!static_branch_inc(&tcp_ao_needed.key)) {
+			err = -EUSERS;
+			goto out;
+		}
 		sk_gso_disable(sk);
 		rcu_assign_pointer(tcp_sk(sk)->ao_info, ao_info);
 	}
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 2ce768e1d914..e432b6da1135 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3542,41 +3542,55 @@ static inline bool tcp_may_update_window(const struct tcp_sock *tp,
 		(ack_seq == tp->snd_wl1 && (nwin > tp->snd_wnd || !nwin));
 }
 
-/* If we update tp->snd_una, also update tp->bytes_acked */
-static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
+static void tcp_snd_sne_update(struct tcp_sock *tp, u32 ack)
 {
-	u32 delta = ack - tp->snd_una;
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao;
-#endif
 
-	sock_owned_by_me((struct sock *)tp);
-	tp->bytes_acked += delta;
-#ifdef CONFIG_TCP_AO
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return;
+
 	ao = rcu_dereference_protected(tp->ao_info,
 				       lockdep_sock_is_held((struct sock *)tp));
 	if (ao && ack < tp->snd_una)
 		ao->snd_sne++;
 #endif
+}
+
+/* If we update tp->snd_una, also update tp->bytes_acked */
+static void tcp_snd_una_update(struct tcp_sock *tp, u32 ack)
+{
+	u32 delta = ack - tp->snd_una;
+
+	sock_owned_by_me((struct sock *)tp);
+	tp->bytes_acked += delta;
+	tcp_snd_sne_update(tp, ack);
 	tp->snd_una = ack;
 }
 
+static void tcp_rcv_sne_update(struct tcp_sock *tp, u32 seq)
+{
+#ifdef CONFIG_TCP_AO
+	struct tcp_ao_info *ao;
+
+	if (!static_branch_unlikely(&tcp_ao_needed.key))
+		return;
+
+	ao = rcu_dereference_protected(tp->ao_info,
+				       lockdep_sock_is_held((struct sock *)tp));
+	if (ao && seq < tp->rcv_nxt)
+		ao->rcv_sne++;
+#endif
+}
+
 /* If we update tp->rcv_nxt, also update tp->bytes_received */
 static void tcp_rcv_nxt_update(struct tcp_sock *tp, u32 seq)
 {
 	u32 delta = seq - tp->rcv_nxt;
-#ifdef CONFIG_TCP_AO
-	struct tcp_ao_info *ao;
-#endif
 
 	sock_owned_by_me((struct sock *)tp);
 	tp->bytes_received += delta;
-#ifdef CONFIG_TCP_AO
-	ao = rcu_dereference_protected(tp->ao_info,
-				       lockdep_sock_is_held((struct sock *)tp));
-	if (ao && seq < tp->rcv_nxt)
-		ao->rcv_sne++;
-#endif
+	tcp_rcv_sne_update(tp, seq);
 	WRITE_ONCE(tp->rcv_nxt, seq);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 772fc6347302..cb314a28010f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1023,18 +1023,20 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
-	/* FIXME: the segment to-be-acked is not verified yet */
-	ao_info = rcu_dereference(tcptw->ao_info);
-	if (ao_info) {
-		const struct tcp_ao_hdr *aoh;
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
+		/* FIXME: the segment to-be-acked is not verified yet */
+		ao_info = rcu_dereference(tcptw->ao_info);
+		if (ao_info) {
+			const struct tcp_ao_hdr *aoh;
 
-		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh)) {
-			inet_twsk_put(tw);
-			return;
+			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh)) {
+				inet_twsk_put(tw);
+				return;
+			}
+
+			if (aoh)
+				key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
 		}
-
-		if (aoh)
-			key.ao_key = tcp_ao_established_key(ao_info, aoh->rnext_keyid, -1);
 	}
 	if (key.ao_key) {
 		struct tcp_ao_key *rnext_key;
@@ -1080,7 +1082,8 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 					     tcp_sk(sk)->snd_nxt;
 
 #ifdef CONFIG_TCP_AO
-	if (tcp_rsk_used_ao(req)) {
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    tcp_rsk_used_ao(req)) {
 		const union tcp_md5_addr *addr;
 		const struct tcp_ao_hdr *aoh;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7ae70d6db07d..e71708dc011c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1151,17 +1151,19 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info *ao_info;
 
-	/* FIXME: the segment to-be-acked is not verified yet */
-	ao_info = rcu_dereference(tcptw->ao_info);
-	if (ao_info) {
-		const struct tcp_ao_hdr *aoh;
+	if (static_branch_unlikely(&tcp_ao_needed.key)) {
 
-		/* Invalid TCP option size or twice included auth */
-		if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
-			goto out;
-		if (aoh) {
-			key.ao_key = tcp_ao_established_key(ao_info,
-							    aoh->rnext_keyid, -1);
+		/* FIXME: the segment to-be-acked is not verified yet */
+		ao_info = rcu_dereference(tcptw->ao_info);
+		if (ao_info) {
+			const struct tcp_ao_hdr *aoh;
+
+			/* Invalid TCP option size or twice included auth */
+			if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
+				goto out;
+			if (aoh)
+				key.ao_key = tcp_ao_established_key(ao_info,
+						aoh->rnext_keyid, -1);
 		}
 	}
 	if (key.ao_key) {
@@ -1203,7 +1205,8 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	struct tcp_key key = {};
 
 #ifdef CONFIG_TCP_AO
-	if (tcp_rsk_used_ao(req)) {
+	if (static_branch_unlikely(&tcp_ao_needed.key) &&
+	    tcp_rsk_used_ao(req)) {
 		const struct in6_addr *addr = &ipv6_hdr(skb)->saddr;
 		const struct tcp_ao_hdr *aoh;
 		int l3index;
-- 
2.42.0



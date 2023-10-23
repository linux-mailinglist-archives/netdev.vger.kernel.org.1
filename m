Return-Path: <netdev+bounces-43616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3329C7D402B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DFB4B20F74
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EC8224FD;
	Mon, 23 Oct 2023 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="EFQ7kxS6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD3224C4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:22:58 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C2810E3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:22:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso56062171fa.2
        for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1698088967; x=1698693767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0aaSc1IOtw0MVJOdbhyug9jf6AOQ6WtzoETwRHLe9Q=;
        b=EFQ7kxS6D1P+imrgE38kTYTe8n9WWl1G4VNW9jDN0KSoGFOb+GPpjOtFx5fpDF91ec
         Ei9HOCexsrLsH/Vdoq9ZL4OyGgv5z6swS2x4Z4Ojg2gumgKvwuQC9mCkaovDrLxncv4d
         u7+swcI++K9MTAwCHmTcvKV6H6CMBEt766pm7cFCXWhgGcutlJcfBUp6ySOmPUGMbOwM
         PRhiTU5cCwZrR4zs1SesM3mXBV7p8KYJtiNCkjd7YykEtoJvoWi7kHjq60LKGJ3Rkj/B
         EFtCsuj0yHDvRDBuA+H63In3b9o0I5Dw7CgFDcJrhQbD4M+1b61nTX0Zi4KKgC+tO3WI
         GRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088967; x=1698693767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0aaSc1IOtw0MVJOdbhyug9jf6AOQ6WtzoETwRHLe9Q=;
        b=Gf9CPHcdnaxc3k1uQof7YO227PQdX3eFa0/3H4AKEsYLR/muce/tkXMbye7TVHrRZh
         W/dS+PJR7YEeTT7mUcU4MUIrKsAmcJCNq+yC8VclTI1dwY8byqvtjcR70lE7V6Yt8N8I
         MM1Y4slweFSc0DriZGBxHWVcG1ocJby76azgFggvlsQqU7/fWSC/RARxvMdGzNasExxT
         QSYN/tnYcui/X8eADWJwv+fbbeNHze+MbqBbRCOxxbp6fbLaGV8zGQe/ygdc5I9CtLyt
         y1CnsPt479K4tB+qmac62BqWOfE/uS4NGn+gC96i+DKpVkUDvK8I4AkWrb/hl/badXcf
         0Uig==
X-Gm-Message-State: AOJu0Yw6XE0IyIqPPt2vrV/+2gha4+umizhaZFkY5gFaHPfaqHT4lOzZ
	t7hGbIQGaouViPLk+YfzCqU38w==
X-Google-Smtp-Source: AGHT+IFrOSoQDEIVipZoZzuDxk9FhywH4ySN5YUJlVGloYRst3mbWzyb4YBXUFR6c7+Q/8f8RBrvdg==
X-Received: by 2002:a2e:b059:0:b0:2c5:f54:2497 with SMTP id d25-20020a2eb059000000b002c50f542497mr7026429ljl.39.1698088967520;
        Mon, 23 Oct 2023 12:22:47 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b00407460234f9sm10142088wmb.21.2023.10.23.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:22:46 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	"Tetreault, Francois" <ftetreau@ciena.com>,
	netdev@vger.kernel.org
Subject: [PATCH v16 net-next 11/23] net/tcp: Sign SYN-ACK segments with TCP-AO
Date: Mon, 23 Oct 2023 20:22:03 +0100
Message-ID: <20231023192217.426455-12-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023192217.426455-1-dima@arista.com>
References: <20231023192217.426455-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to RST segments, wire SYN-ACKs to TCP-AO.
tcp_rsk_used_ao() is handy here to check if the request socket used AO
and needs a signature on the outgoing segments.

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/tcp.h     |  3 ++
 include/net/tcp_ao.h  |  6 ++++
 net/ipv4/tcp_ao.c     | 22 +++++++++++++
 net/ipv4/tcp_ipv4.c   |  1 +
 net/ipv4/tcp_output.c | 72 +++++++++++++++++++++++++++++++++----------
 net/ipv6/tcp_ao.c     | 22 +++++++++++++
 net/ipv6/tcp_ipv6.c   |  1 +
 7 files changed, 111 insertions(+), 16 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f9df97b3a767..9ef9fcf88c5b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2219,6 +2219,9 @@ struct tcp_request_sock_ops {
 					struct request_sock *req,
 					int sndid, int rcvid);
 	int (*ao_calc_key)(struct tcp_ao_key *mkt, u8 *key, struct request_sock *sk);
+	int (*ao_synack_hash)(char *ao_hash, struct tcp_ao_key *mkt,
+			      struct request_sock *req, const struct sk_buff *skb,
+			      int hash_offset, u32 sne);
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	__u32 (*cookie_init_seq)(const struct sk_buff *skb,
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index d2c1ee8bf7b0..1d69978e349a 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -147,6 +147,9 @@ int tcp_ao_prepare_reset(const struct sock *sk, struct sk_buff *skb,
 int tcp_v4_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 struct tcp_ao_key *tcp_v4_ao_lookup(const struct sock *sk, struct sock *addr_sk,
 				    int sndid, int rcvid);
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *mkt,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 int tcp_v4_ao_calc_key_sk(struct tcp_ao_key *mkt, u8 *key,
 			  const struct sock *sk,
 			  __be32 sisn, __be32 disn, bool send);
@@ -181,6 +184,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 		       const struct sock *sk, const struct sk_buff *skb,
 		       const u8 *tkey, int hash_offset, u32 sne);
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne);
 void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 68d81704e14e..de3710758d55 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -568,6 +568,28 @@ int tcp_v4_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 			       tkey, hash_offset, sne);
 }
 
+int tcp_v4_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne)
+{
+	void *hash_buf = NULL;
+	int err;
+
+	hash_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
+	if (!hash_buf)
+		return -ENOMEM;
+
+	err = tcp_v4_ao_calc_key_rsk(ao_key, hash_buf, req);
+	if (err)
+		goto out;
+
+	err = tcp_ao_hash_skb(AF_INET, ao_hash, ao_key, req_to_sk(req), skb,
+			      hash_buf, hash_offset, sne);
+out:
+	kfree(hash_buf);
+	return err;
+}
+
 struct tcp_ao_key *tcp_v4_ao_lookup_rsk(const struct sock *sk,
 					struct request_sock *req,
 					int sndid, int rcvid)
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2bd56b57f3c9..bdf0224ae827 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1681,6 +1681,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v4_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v4_ao_calc_key_rsk,
+	.ao_synack_hash	=	tcp_v4_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v4_init_sequence,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 63a690107ed4..e8ccad50f1c5 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -886,7 +886,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 				       struct request_sock *req,
 				       unsigned int mss, struct sk_buff *skb,
 				       struct tcp_out_options *opts,
-				       const struct tcp_md5sig_key *md5,
+				       const struct tcp_key *key,
 				       struct tcp_fastopen_cookie *foc,
 				       enum tcp_synack_type synack_type,
 				       struct sk_buff *syn_skb)
@@ -894,8 +894,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
 
-#ifdef CONFIG_TCP_MD5SIG
-	if (md5) {
+	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
 		remaining -= TCPOLEN_MD5SIG_ALIGNED;
 
@@ -906,8 +905,11 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		 */
 		if (synack_type != TCP_SYNACK_COOKIE)
 			ireq->tstamp_ok &= !ireq->sack_ok;
+	} else if (tcp_key_is_ao(key)) {
+		opts->options |= OPTION_AO;
+		remaining -= tcp_ao_len(key->ao_key);
+		ireq->tstamp_ok &= !ireq->sack_ok;
 	}
-#endif
 
 	/* We always send an MSS option. */
 	opts->mss = mss;
@@ -3671,7 +3673,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct tcp_sock *tp = tcp_sk(sk);
-	struct tcp_md5sig_key *md5 = NULL;
 	struct tcp_out_options opts;
 	struct tcp_key key = {};
 	struct sk_buff *skb;
@@ -3725,18 +3726,48 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 			tcp_rsk(req)->snt_synack = tcp_skb_timestamp_us(skb);
 	}
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_lock();
-	md5 = tcp_rsk(req)->af_specific->req_md5_lookup(sk, req_to_sk(req));
-	if (md5)
-		key.type = TCP_KEY_MD5;
 #endif
+	if (tcp_rsk_used_ao(req)) {
+#ifdef CONFIG_TCP_AO
+		struct tcp_ao_key *ao_key = NULL;
+		u8 maclen = tcp_rsk(req)->maclen;
+		u8 keyid = tcp_rsk(req)->ao_keyid;
+
+		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
+							    keyid, -1);
+		/* If there is no matching key - avoid sending anything,
+		 * especially usigned segments. It could try harder and lookup
+		 * for another peer-matching key, but the peer has requested
+		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
+		 */
+		if (unlikely(!ao_key || tcp_ao_maclen(ao_key) != maclen)) {
+			u8 key_maclen = ao_key ? tcp_ao_maclen(ao_key) : 0;
+
+			rcu_read_unlock();
+			kfree_skb(skb);
+			net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
+					     keyid, maclen, key_maclen);
+			return NULL;
+		}
+		key.ao_key = ao_key;
+		key.type = TCP_KEY_AO;
+#endif
+	} else {
+#ifdef CONFIG_TCP_MD5SIG
+		key.md5_key = tcp_rsk(req)->af_specific->req_md5_lookup(sk,
+					req_to_sk(req));
+		if (key.md5_key)
+			key.type = TCP_KEY_MD5;
+#endif
+	}
 	skb_set_hash(skb, READ_ONCE(tcp_rsk(req)->txhash), PKT_HASH_TYPE_L4);
 	/* bpf program will be interested in the tcp_flags */
 	TCP_SKB_CB(skb)->tcp_flags = TCPHDR_SYN | TCPHDR_ACK;
-	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts, md5,
-					     foc, synack_type,
-					     syn_skb) + sizeof(*th);
+	tcp_header_size = tcp_synack_options(sk, req, mss, skb, &opts,
+					     &key, foc, synack_type, syn_skb)
+					+ sizeof(*th);
 
 	skb_push(skb, tcp_header_size);
 	skb_reset_transport_header(skb);
@@ -3756,15 +3787,24 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	/* RFC1323: The window in SYN & SYN/ACK segments is never scaled. */
 	th->window = htons(min(req->rsk_rcv_wnd, 65535U));
-	tcp_options_write(th, NULL, NULL, &opts, &key);
+	tcp_options_write(th, NULL, tcp_rsk(req), &opts, &key);
 	th->doff = (tcp_header_size >> 2);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_OUTSEGS);
 
-#ifdef CONFIG_TCP_MD5SIG
 	/* Okay, we have all we need - do the md5 hash if needed */
-	if (md5)
+	if (tcp_key_is_md5(&key)) {
+#ifdef CONFIG_TCP_MD5SIG
 		tcp_rsk(req)->af_specific->calc_md5_hash(opts.hash_location,
-					       md5, req_to_sk(req), skb);
+					key.md5_key, req_to_sk(req), skb);
+#endif
+	} else if (tcp_key_is_ao(&key)) {
+#ifdef CONFIG_TCP_AO
+		tcp_rsk(req)->af_specific->ao_synack_hash(opts.hash_location,
+					key.ao_key, req, skb,
+					opts.hash_location - (u8 *)th, 0);
+#endif
+	}
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 	rcu_read_unlock();
 #endif
 
diff --git a/net/ipv6/tcp_ao.c b/net/ipv6/tcp_ao.c
index c9a6fa84f6ce..99753e12c08c 100644
--- a/net/ipv6/tcp_ao.c
+++ b/net/ipv6/tcp_ao.c
@@ -144,3 +144,25 @@ int tcp_v6_parse_ao(struct sock *sk, int cmd,
 {
 	return tcp_parse_ao(sk, cmd, AF_INET6, optval, optlen);
 }
+
+int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
+			  struct request_sock *req, const struct sk_buff *skb,
+			  int hash_offset, u32 sne)
+{
+	void *hash_buf = NULL;
+	int err;
+
+	hash_buf = kmalloc(tcp_ao_digest_size(ao_key), GFP_ATOMIC);
+	if (!hash_buf)
+		return -ENOMEM;
+
+	err = tcp_v6_ao_calc_key_rsk(ao_key, hash_buf, req);
+	if (err)
+		goto out;
+
+	err = tcp_ao_hash_skb(AF_INET6, ao_hash, ao_key, req_to_sk(req), skb,
+			      hash_buf, hash_offset, sne);
+out:
+	kfree(hash_buf);
+	return err;
+}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e2fee6c464bf..c88b90552c47 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -839,6 +839,7 @@ const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops = {
 #ifdef CONFIG_TCP_AO
 	.ao_lookup	=	tcp_v6_ao_lookup_rsk,
 	.ao_calc_key	=	tcp_v6_ao_calc_key_rsk,
+	.ao_synack_hash =	tcp_v6_ao_synack_hash,
 #endif
 #ifdef CONFIG_SYN_COOKIES
 	.cookie_init_seq =	cookie_v6_init_sequence,
-- 
2.42.0



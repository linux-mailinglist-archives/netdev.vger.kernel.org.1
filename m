Return-Path: <netdev+bounces-27779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0C77D333
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BDE1C20DFF
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C8E19892;
	Tue, 15 Aug 2023 19:15:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18619891
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 19:15:20 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0495C1980
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:15:17 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so52264115e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1692126915; x=1692731715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6J1bByRjPegO+0wzvVIFtgk8o6BL03TlwNO7VElBHs=;
        b=dwtkCf7sn0gW+w3Mg0lD7mXxHhvIeccEDX0FbuKYpPEfk0bTrO4Z32XFPEv5VzUKtX
         QzDzMDc/fjEn3Rm1LNvPazIXaUH95HLGq8DVrUQ3DjfTJLJQ2mu/PDkGj07F6yucP6fI
         eTOTKf7nECHQiy0fQ9wsLWVFbfJtS7x8oW9ZELg/JCXAxppvXiPKEnqrnLDzLdkuf0Wv
         /QqecOGM+HWCcCOdDAnSGDdr0prRBKrMsObD0Mh95QonlQUIl16DtXYXwrsRnOEry67B
         y7jGs6fnvpYltD3uEMo1wC9QQyRVWao5DJ7jzQsRExvX7YWDxuetVhB+KdroW6CCYGN7
         Dtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692126915; x=1692731715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6J1bByRjPegO+0wzvVIFtgk8o6BL03TlwNO7VElBHs=;
        b=kfoHwNNMKQABt9xpt7AH62DdtcOCNuIBnfLRRxBQBM/+y9SDK8gXeouTrwTF/7MSnG
         4i+3iX5fb2N4gUDdT+zE5pfli/eQOTgo+4i5fQLxXliBIyylvLzqzzoEAE8D803m1yed
         1NXx7nJdn92e81bdC6xNqSvhupZjKlWiUAkMg22xNorIIqD6e62Qr4BaQsJEXUWsFnaw
         EB9qp4PvYuK2/7wPfqeq6CWTDAd14Qk/tUPSc6fNk6piwAMn0JWd3RnHh6xLYCf8JcoQ
         zQ95+LMxY+BDdziUDTNFHoEwYOem9+dviKiaopP22vCdc0TIIVW+N1/TdXtT7Id9qvcy
         /KeQ==
X-Gm-Message-State: AOJu0YzeuXbpAGW3mfjtk9szuz0aH9x+GIYbrfbJuSvBLTdRJPWQM28S
	Wuo7v7woLTDvjj+EbSrzdQpsgg==
X-Google-Smtp-Source: AGHT+IGd5EEt5Ul+bWrOPb4Ft4ckTz9spPYn3NOT3cT1OT3djo6auZzFXEaBU1j+iR5BHJeoyIJOYA==
X-Received: by 2002:a05:600c:280b:b0:3fe:16c8:65fa with SMTP id m11-20020a05600c280b00b003fe16c865famr10643645wmb.4.1692126915490;
        Tue, 15 Aug 2023 12:15:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q9-20020a1ce909000000b003fbbe41fd78sm18779737wmc.10.2023.08.15.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 12:15:15 -0700 (PDT)
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
Subject: [PATCH v10 net-next 07/23] net/tcp: Add tcp_parse_auth_options()
Date: Tue, 15 Aug 2023 20:14:36 +0100
Message-ID: <20230815191455.1872316-8-dima@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815191455.1872316-1-dima@arista.com>
References: <20230815191455.1872316-1-dima@arista.com>
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Introduce a helper that:
(1) shares the common code with TCP-MD5 header options parsing
(2) looks for hash signature only once for both TCP-MD5 and TCP-AO
(3) fails with -EEXIST if any TCP sign option is present twice, see
    RFC5925 (2.2):
    ">> A single TCP segment MUST NOT have more than one TCP-AO in its
    options sequence. When multiple TCP-AOs appear, TCP MUST discard
    the segment."

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/net/dropreason-core.h |  6 ++++++
 include/net/tcp.h             | 24 ++++++++++++++++++++-
 include/net/tcp_ao.h          | 17 ++++++++++++++-
 net/ipv4/tcp.c                |  3 ++-
 net/ipv4/tcp_input.c          | 39 ++++++++++++++++++++++++++---------
 net/ipv4/tcp_ipv4.c           | 15 +++++++++-----
 net/ipv6/tcp_ipv6.c           | 11 ++++++----
 7 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index f291a3b0f9e5..05255bffa2c8 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -20,6 +20,7 @@
 	FN(IP_NOPROTO)			\
 	FN(SOCKET_RCVBUFF)		\
 	FN(PROTO_MEM)			\
+	FN(TCP_AUTH_HDR)		\
 	FN(TCP_MD5NOTFOUND)		\
 	FN(TCP_MD5UNEXPECTED)		\
 	FN(TCP_MD5FAILURE)		\
@@ -140,6 +141,11 @@ enum skb_drop_reason {
 	 * drop out of udp_memory_allocated.
 	 */
 	SKB_DROP_REASON_PROTO_MEM,
+	/**
+	 * @SKB_DROP_REASON_TCP_AUTH_HDR: TCP-MD5 or TCP-AO hashes are met
+	 * twice or set incorrectly.
+	 */
+	SKB_DROP_REASON_TCP_AUTH_HDR,
 	/**
 	 * @SKB_DROP_REASON_TCP_MD5NOTFOUND: no MD5 hash and one expected,
 	 * corresponding to LINUX_MIB_TCPMD5NOTFOUND
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 73e6730fc3e6..a09b5b53a834 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -427,7 +427,6 @@ int tcp_mmap(struct file *file, struct socket *sock,
 void tcp_parse_options(const struct net *net, const struct sk_buff *skb,
 		       struct tcp_options_received *opt_rx,
 		       int estab, struct tcp_fastopen_cookie *foc);
-const u8 *tcp_parse_md5sig_option(const struct tcphdr *th);
 
 /*
  *	BPF SKB-less helpers
@@ -2574,6 +2573,29 @@ static inline u64 tcp_transmit_time(const struct sock *sk)
 	return 0;
 }
 
+static inline int tcp_parse_auth_options(const struct tcphdr *th,
+		const u8 **md5_hash, const struct tcp_ao_hdr **aoh)
+{
+	const u8 *md5_tmp, *ao_tmp;
+	int ret;
+
+	ret = tcp_do_parse_auth_options(th, &md5_tmp, &ao_tmp);
+	if (ret)
+		return ret;
+
+	if (md5_hash)
+		*md5_hash = md5_tmp;
+
+	if (aoh) {
+		if (!ao_tmp)
+			*aoh = NULL;
+		else
+			*aoh = (struct tcp_ao_hdr *)(ao_tmp - 2);
+	}
+
+	return 0;
+}
+
 static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 				   int family)
 {
diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index cd85d292f78e..e685ad9db949 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -148,7 +148,9 @@ int tcp_v6_ao_hash_skb(char *ao_hash, struct tcp_ao_key *key,
 int tcp_v6_parse_ao(struct sock *sk, int cmd, sockptr_t optval, int optlen);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
-
+void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
+		      struct tcp_request_sock *treq,
+		      unsigned short int family);
 #else /* CONFIG_TCP_AO */
 
 static inline struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
@@ -170,4 +172,17 @@ static inline void tcp_ao_connect_init(struct sock *sk)
 }
 #endif
 
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+int tcp_do_parse_auth_options(const struct tcphdr *th,
+			      const u8 **md5_hash, const u8 **ao_hash);
+#else
+static inline int tcp_do_parse_auth_options(const struct tcphdr *th,
+		const u8 **md5_hash, const u8 **ao_hash)
+{
+	*md5_hash = NULL;
+	*ao_hash = NULL;
+	return 0;
+}
+#endif
+
 #endif /* _TCP_AO_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4d0536ff75d8..9a6a8b79dad4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4383,7 +4383,8 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	l3index = sdif ? dif : 0;
 
 	hash_expected = tcp_md5_do_lookup(sk, l3index, saddr, family);
-	hash_location = tcp_parse_md5sig_option(th);
+	if (tcp_parse_auth_options(th, &hash_location, NULL))
+		return SKB_DROP_REASON_TCP_AUTH_HDR;
 
 	/* We've parsed the options - do we have a hash? */
 	if (!hash_expected && !hash_location)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0df208d6fa44..de6d55f46aa8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4211,39 +4211,58 @@ static bool tcp_fast_parse_options(const struct net *net,
 	return true;
 }
 
-#ifdef CONFIG_TCP_MD5SIG
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 /*
- * Parse MD5 Signature option
+ * Parse Signature options
  */
-const u8 *tcp_parse_md5sig_option(const struct tcphdr *th)
+int tcp_do_parse_auth_options(const struct tcphdr *th,
+			      const u8 **md5_hash, const u8 **ao_hash)
 {
 	int length = (th->doff << 2) - sizeof(*th);
 	const u8 *ptr = (const u8 *)(th + 1);
+	unsigned int minlen = TCPOLEN_MD5SIG;
+
+	if (IS_ENABLED(CONFIG_TCP_AO))
+		minlen = sizeof(struct tcp_ao_hdr) + 1;
+
+	*md5_hash = NULL;
+	*ao_hash = NULL;
 
 	/* If not enough data remaining, we can short cut */
-	while (length >= TCPOLEN_MD5SIG) {
+	while (length >= minlen) {
 		int opcode = *ptr++;
 		int opsize;
 
 		switch (opcode) {
 		case TCPOPT_EOL:
-			return NULL;
+			return 0;
 		case TCPOPT_NOP:
 			length--;
 			continue;
 		default:
 			opsize = *ptr++;
 			if (opsize < 2 || opsize > length)
-				return NULL;
-			if (opcode == TCPOPT_MD5SIG)
-				return opsize == TCPOLEN_MD5SIG ? ptr : NULL;
+				return -EINVAL;
+			if (opcode == TCPOPT_MD5SIG) {
+				if (opsize != TCPOLEN_MD5SIG)
+					return -EINVAL;
+				if (unlikely(*md5_hash || *ao_hash))
+					return -EEXIST;
+				*md5_hash = ptr;
+			} else if (opcode == TCPOPT_AO) {
+				if (opsize <= sizeof(struct tcp_ao_hdr))
+					return -EINVAL;
+				if (unlikely(*md5_hash || *ao_hash))
+					return -EEXIST;
+				*ao_hash = ptr;
+			}
 		}
 		ptr += opsize - 2;
 		length -= opsize;
 	}
-	return NULL;
+	return 0;
 }
-EXPORT_SYMBOL(tcp_parse_md5sig_option);
+EXPORT_SYMBOL(tcp_do_parse_auth_options);
 #endif
 
 /* Sorry, PAWS as specified is broken wrt. pure-ACKs -DaveM
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0750e8160a54..31169971cc56 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -670,7 +670,9 @@ EXPORT_SYMBOL(tcp_v4_send_check);
  *	Exception: precedence violation. We do not implement it in any case.
  */
 
-#ifdef CONFIG_TCP_MD5SIG
+#ifdef CONFIG_TCP_AO
+#define OPTION_BYTES MAX_TCP_OPTION_SPACE
+#elif defined(CONFIG_TCP_MD5SIG)
 #define OPTION_BYTES TCPOLEN_MD5SIG_ALIGNED
 #else
 #define OPTION_BYTES sizeof(__be32)
@@ -685,8 +687,8 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 	} rep;
 	struct ip_reply_arg arg;
 #ifdef CONFIG_TCP_MD5SIG
+	const __u8 *md5_hash_location = NULL;
 	struct tcp_md5sig_key *key = NULL;
-	const __u8 *hash_location = NULL;
 	unsigned char newhash[16];
 	int genhash;
 	struct sock *sk1 = NULL;
@@ -727,8 +729,11 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
 #ifdef CONFIG_TCP_MD5SIG
+	/* Invalid TCP option size or twice included auth */
+	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, NULL))
+		return;
+
 	rcu_read_lock();
-	hash_location = tcp_parse_md5sig_option(th);
 	if (sk && sk_fullsock(sk)) {
 		const union tcp_md5_addr *addr;
 		int l3index;
@@ -739,7 +744,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		l3index = tcp_v4_sdif(skb) ? inet_iif(skb) : 0;
 		addr = (union tcp_md5_addr *)&ip_hdr(skb)->saddr;
 		key = tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
-	} else if (hash_location) {
+	} else if (md5_hash_location) {
 		const union tcp_md5_addr *addr;
 		int sdif = tcp_v4_sdif(skb);
 		int dif = inet_iif(skb);
@@ -771,7 +776,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 
 		genhash = tcp_v4_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || memcmp(md5_hash_location, newhash, 16) != 0)
 			goto out;
 
 	}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 146b586839f5..5c1880d5f5bc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -989,7 +989,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	u32 seq = 0, ack_seq = 0;
 	struct tcp_md5sig_key *key = NULL;
 #ifdef CONFIG_TCP_MD5SIG
-	const __u8 *hash_location = NULL;
+	const __u8 *md5_hash_location = NULL;
 	unsigned char newhash[16];
 	int genhash;
 	struct sock *sk1 = NULL;
@@ -1011,8 +1011,11 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 
 	net = sk ? sock_net(sk) : dev_net(skb_dst(skb)->dev);
 #ifdef CONFIG_TCP_MD5SIG
+	/* Invalid TCP option size or twice included auth */
+	if (tcp_parse_auth_options(th, &md5_hash_location, NULL))
+		return;
+
 	rcu_read_lock();
-	hash_location = tcp_parse_md5sig_option(th);
 	if (sk && sk_fullsock(sk)) {
 		int l3index;
 
@@ -1021,7 +1024,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 		 */
 		l3index = tcp_v6_sdif(skb) ? tcp_v6_iif_l3_slave(skb) : 0;
 		key = tcp_v6_md5_do_lookup(sk, &ipv6h->saddr, l3index);
-	} else if (hash_location) {
+	} else if (md5_hash_location) {
 		int dif = tcp_v6_iif_l3_slave(skb);
 		int sdif = tcp_v6_sdif(skb);
 		int l3index;
@@ -1050,7 +1053,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			goto out;
 
 		genhash = tcp_v6_md5_hash_skb(newhash, key, NULL, skb);
-		if (genhash || memcmp(hash_location, newhash, 16) != 0)
+		if (genhash || memcmp(md5_hash_location, newhash, 16) != 0)
 			goto out;
 	}
 #endif
-- 
2.41.0



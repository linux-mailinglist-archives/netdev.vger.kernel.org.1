Return-Path: <netdev+bounces-33084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C781279CB66
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A4D2816A7
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C237716414;
	Tue, 12 Sep 2023 09:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7E16413
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:46 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF18E7A
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8109d3a3bbso699582276.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510265; x=1695115065; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8lW7e0a1WddkHFyNSkaoDBG9QXc/+quLSBbDaMtDkw=;
        b=gv46rtiFNMgcWnl+96p6ccH+GiYz2nFh/JRsqEoOctR13hnqiF1d0x+lSfk8+kd94k
         ZiuDyCZ4xaKbCG6HvoE0rhSA9s12bxEMwuZRAr26XWuvTyNPX6FJHbohVkJEenTJv9Ik
         Zyt0uA6fuYYDfDnqYkNCIH11TXtMixv8tBEtAbUSeH6N1LG3LzqfFnbUOejcd1a7Vi5O
         4RBbGgCEGYGjixJ/PxhQPI2Al0waDhuvxxAUL9J3vWww67Y7B5tBfUu1a2IOzEc0+QGt
         iz58vtKN5iiIj3oBXkGFsiW3v9wg80DZKwKjYYjRoFKAnOV7q3ZcojaQ0yhxbO0/lGJt
         KsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510265; x=1695115065;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8lW7e0a1WddkHFyNSkaoDBG9QXc/+quLSBbDaMtDkw=;
        b=sC/6bNa+wGdtrOCxSCDNT5oJCh82F0xJ7fPbAyQbtC2KafAWYpZIO4fY8vUoarLlSL
         N0jLPpfM3bZbiuPX9H0KJgpvLcg7xInBOJVa6vN/RuAjKJwz+bnpu7ZNpMx123uY6K9J
         /KlHKnUtJC38nHv/EvOxmBdkmf5+DgxfOYCUNgud2wjo1r01//urhxm+5gIhaTeCiSJV
         paEH8kYYva3hPGznmYJh27+ypx16oLOPwDZl68oUmvF3Hu1yx2L1jTO4lRgUv+1bsoyz
         BkJ4F8kbhVGiytnpy4Bs0Imr88YIYlB4v2CqU9jRipOwP/rVML9rjsOEs0o2ki7eES/P
         fp0A==
X-Gm-Message-State: AOJu0YxaAaORuFVEsL1Aaws1NPd7JVmgLeTi7Z6Y3ku2eJlgfLq/gsZN
	olnam0CaWwJMa0xHG6aGowR4sYzcy+yMTw==
X-Google-Smtp-Source: AGHT+IFpFLLTfSTMOImOkGAYasU/xnXVRZA215yw4HnDz1Nx3Z+ovwQw8YNVl78/oD1oSIXOeHbqufYCFl7yXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1707:b0:d7b:9830:c172 with SMTP
 id by7-20020a056902170700b00d7b9830c172mr288981ybb.0.1694510265267; Tue, 12
 Sep 2023 02:17:45 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:21 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-2-edumazet@google.com>
Subject: [PATCH net-next 01/10] udp: introduce udp->udp_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

According to syzbot, it is time to use proper atomic flags
for various UDP flags.

Add udp_flags field, and convert udp->corkflag to first
bit in it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 28 +++++++++++++++++++++-------
 net/ipv4/udp.c      | 12 ++++++------
 net/ipv6/udp.c      |  6 +++---
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 43c1fb2d2c21afc01abdf20e4b9c03f04932c19b..23f0693e0d9cc4212ab7c7dc982561a2807b14f0 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -32,14 +32,20 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 	return (num + net_hash_mix(net)) & mask;
 }
 
+enum {
+	UDP_FLAGS_CORK,		/* Cork is required */
+};
+
 struct udp_sock {
 	/* inet_sock has to be the first member */
 	struct inet_sock inet;
 #define udp_port_hash		inet.sk.__sk_common.skc_u16hashes[0]
 #define udp_portaddr_hash	inet.sk.__sk_common.skc_u16hashes[1]
 #define udp_portaddr_node	inet.sk.__sk_common.skc_portaddr_node
+
+	unsigned long	 udp_flags;
+
 	int		 pending;	/* Any pending frames ? */
-	unsigned int	 corkflag;	/* Cork is required */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 	unsigned char	 no_check6_tx:1,/* Send zero UDP6 checksums on TX? */
 			 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
@@ -51,6 +57,11 @@ struct udp_sock {
 			 gro_enabled:1,	/* Request GRO aggregation */
 			 accept_udp_l4:1,
 			 accept_udp_fraglist:1;
+/* indicator bits used by pcflag: */
+#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
+#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
+#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
+	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
@@ -62,12 +73,6 @@ struct udp_sock {
 	 */
 	__u16		 pcslen;
 	__u16		 pcrlen;
-/* indicator bits used by pcflag: */
-#define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
-#define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x4		/* set via udplite setsocktopt        */
-	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
-	__u8		 unused[3];
 	/*
 	 * For encapsulation sockets.
 	 */
@@ -95,6 +100,15 @@ struct udp_sock {
 	int		forward_threshold;
 };
 
+#define udp_test_bit(nr, sk)			\
+	test_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_set_bit(nr, sk)			\
+	set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_clear_bit(nr, sk)			\
+	clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_assign_bit(nr, sk, val)		\
+	assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
+
 #define UDP_MAX_SEGMENTS	(1 << 6UL)
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f39b9c8445808deee2c777cbb828474ff105d322..9709f8a532dc3d0e62a1cdb126ea7dc3cebd7da9 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1051,7 +1051,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	u8 tos, scope;
 	__be16 dport;
 	int err, is_udplite = IS_UDPLITE(sk);
-	int corkreq = READ_ONCE(up->corkflag) || msg->msg_flags&MSG_MORE;
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 	struct sk_buff *skb;
 	struct ip_options_data opt_copy;
@@ -1315,11 +1315,11 @@ void udp_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || READ_ONCE(up->corkflag))
+	if (!up->pending || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-	if (up->pending && !READ_ONCE(up->corkflag))
+	if (up->pending && !udp_test_bit(CORK, sk))
 		udp_push_pending_frames(sk);
 	release_sock(sk);
 }
@@ -2658,9 +2658,9 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case UDP_CORK:
 		if (val != 0) {
-			WRITE_ONCE(up->corkflag, 1);
+			udp_set_bit(CORK, sk);
 		} else {
-			WRITE_ONCE(up->corkflag, 0);
+			udp_clear_bit(CORK, sk);
 			lock_sock(sk);
 			push_pending_frames(sk);
 			release_sock(sk);
@@ -2783,7 +2783,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case UDP_CORK:
-		val = READ_ONCE(up->corkflag);
+		val = udp_test_bit(CORK, sk);
 		break;
 
 	case UDP_ENCAP:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a4688cacb2f40667c9ddc10f81ade2fe..0c6973cd22ce4cdcc846eb94029f4281e900da40 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1332,7 +1332,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int addr_len = msg->msg_namelen;
 	bool connected = false;
 	int ulen = len;
-	int corkreq = READ_ONCE(up->corkflag) || msg->msg_flags&MSG_MORE;
+	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int err;
 	int is_udplite = IS_UDPLITE(sk);
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
@@ -1644,11 +1644,11 @@ static void udpv6_splice_eof(struct socket *sock)
 	struct sock *sk = sock->sk;
 	struct udp_sock *up = udp_sk(sk);
 
-	if (!up->pending || READ_ONCE(up->corkflag))
+	if (!up->pending || udp_test_bit(CORK, sk))
 		return;
 
 	lock_sock(sk);
-	if (up->pending && !READ_ONCE(up->corkflag))
+	if (up->pending && !udp_test_bit(CORK, sk))
 		udp_v6_push_pending_frames(sk);
 	release_sock(sk);
 }
-- 
2.42.0.283.g2d96d420d3-goog



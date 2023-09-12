Return-Path: <netdev+bounces-33300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443FC79D5A5
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E71C20B05
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDB18C30;
	Tue, 12 Sep 2023 16:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABD18C2C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:28 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A01717
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fc7afa4beso68182107b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534537; x=1695139337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPIMxkfXwhhBLTlda7uyveo4ZerWd8hPga+5XhlbL4Y=;
        b=paO3gpWd+Xdzqiv0cKWFW+wMgO3Lp2/BxFkeENhoWtQBKQ69GhVUovETpTnrjpizK3
         aoo0je72YagwgOrgKQPVFCpll/6eN28VaGUNlsaZ3zDGQIhi89S98mOkH9AA1qLKE2ns
         5tYmrl2PAipxBHnFfs3y6jZ0/OY9go9ke4FH2S2KFcvmVaZyG1vY1OEGjxXFAHMAX54y
         8SZ++Tuy6FM7yyASY5iF12nmd2uo/foZVOg3Um8VdWKuv9xdDaRFcFhSnm4D1u7ceF2r
         LE3mHezzGuXfsXprQLO+4ySVJiMWfwQCYX3i4AiVDH/mAnKflVyHzNAvYAUJAmpJ96nT
         6Vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534537; x=1695139337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPIMxkfXwhhBLTlda7uyveo4ZerWd8hPga+5XhlbL4Y=;
        b=omaXN0LtVnNo9w1dndkJUW6BSpK0uyN2nU+D1fPynLqDQVDHPBwTj+dqRrytCerdIH
         PRLU7u6kfMCLDDS2JBFWhg67AykVt+m6/y4wPI6wEvKK4uLm7ULrInYhjazqU5kGIrKk
         TXPpFPCNL15n/ZkaN2BKqmIrC2lDvosv/f37Hp5VK9fMJ7X7No7Pahh895dNuPk3ySa4
         fntoL8dt4RXDzzj+Hr+Ghx7CvsnCiMF7zcD8n6B4XGPXy7CNuBZ07A5IudIbKaKawq60
         zw3daMhUhaUqhQJZVa6sJzghQ10zu7/XKhzKVhLAwaGwGziZ42f2NRtk77gts+wuzTlb
         Y5Sg==
X-Gm-Message-State: AOJu0YxXw2JCHhROkLjebcpnj/bltPgiTb8EJZZPgJUTiyvMEy1pMKgm
	5dZw/y+o3tW7w9fKfcfdEbXAholrgKaOzA==
X-Google-Smtp-Source: AGHT+IGVHv/hm6HC/BAalptbQxaS+Ki72QJb63zrElxIWQlpjUwNVgsE+nSQpJwWASm9IAHHADuZ9BerLSy3oQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8451:0:b0:d4b:df05:3500 with SMTP id
 r17-20020a258451000000b00d4bdf053500mr297824ybm.11.1694534537809; Tue, 12 Sep
 2023 09:02:17 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:00 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-3-edumazet@google.com>
Subject: [PATCH net-next 02/14] ipv6: lockless IPV6_MULTICAST_LOOP implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Add inet6_{test|set|clear|assign}_bit() helpers.

Note that I am using bits from inet->inet_flags,
this might change in the future if we need more flags.

While solving data-races accessing np->mc_loop,
this patch also allows to implement lockless accesses
to np->mcast_hops in the following patch.

Also constify sk_mc_loop() argument.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h            | 18 ++++++++++++++----
 include/net/inet_sock.h         |  1 +
 include/net/sock.h              |  2 +-
 net/core/sock.c                 |  4 ++--
 net/ipv6/af_inet6.c             |  2 +-
 net/ipv6/ipv6_sockglue.c        | 18 ++++++++----------
 net/ipv6/ndisc.c                |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  8 ++------
 8 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index c2e0870713849fbbf1a8ec2d60cca80caab0cb98..68cf1ca949141e419abf2031db2b42105b821ab0 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -218,11 +218,9 @@ struct ipv6_pinfo {
 #if defined(__BIG_ENDIAN_BITFIELD)
 	/* Packed in 16bits. */
 	__s16			mcast_hops:9;
-	__u16			__unused_2:6,
-				mc_loop:1;
+	__u16			__unused_2:7,
 #else
-	__u16			mc_loop:1,
-				__unused_2:6;
+	__u16			__unused_2:7;
 	__s16			mcast_hops:9;
 #endif
 	int			ucast_oif;
@@ -283,6 +281,18 @@ struct ipv6_pinfo {
 	struct inet6_cork	cork;
 };
 
+/* We currently use available bits from inet_sk(sk)->inet_flags,
+ * this could change in the future.
+ */
+#define inet6_test_bit(nr, sk)			\
+	test_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet6_set_bit(nr, sk)			\
+	set_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet6_clear_bit(nr, sk)			\
+	clear_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet6_assign_bit(nr, sk, val)		\
+	assign_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags, val)
+
 /* WARNING: don't change the layout of the members in {raw,udp,tcp}6_sock! */
 struct raw6_sock {
 	/* inet_sock has to be the first member of raw6_sock */
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 2de0e4d4a027889706323b7ee4b96e406101bff4..b5a9dca92fb45425c032bdf08bfa88cad77926b8 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -268,6 +268,7 @@ enum {
 	INET_FLAGS_NODEFRAG	= 17,
 	INET_FLAGS_BIND_ADDRESS_NO_PORT = 18,
 	INET_FLAGS_DEFER_CONNECT = 19,
+	INET_FLAGS_MC6_LOOP	= 20,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/sock.h b/include/net/sock.h
index b770261fbdaf59d4d1c0b30adb2592c56442e9e3..9e1c17e56971f8714d421d58e408bf3face421b0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2239,7 +2239,7 @@ static inline void sock_confirm_neigh(struct sk_buff *skb, struct neighbour *n)
 	}
 }
 
-bool sk_mc_loop(struct sock *sk);
+bool sk_mc_loop(const struct sock *sk);
 
 static inline bool sk_can_gso(const struct sock *sk)
 {
diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd6481a3fc28d796db785439f0446703b..b2a9b5630bb513d5e5b99a6b7d3cef54af3a4b6f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -759,7 +759,7 @@ static int sock_getbindtodevice(struct sock *sk, sockptr_t optval,
 	return ret;
 }
 
-bool sk_mc_loop(struct sock *sk)
+bool sk_mc_loop(const struct sock *sk)
 {
 	if (dev_recursion_level())
 		return false;
@@ -771,7 +771,7 @@ bool sk_mc_loop(struct sock *sk)
 		return inet_test_bit(MC_LOOP, sk);
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		return inet6_sk(sk)->mc_loop;
+		return inet6_test_bit(MC6_LOOP, sk);
 #endif
 	}
 	WARN_ON_ONCE(1);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 368824fe9719f92b46512f3f78446fe5bc802ef7..bbd4aa1b96d09d346c521dab2194045123e7a5a6 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -217,7 +217,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	inet_sk(sk)->pinet6 = np = inet6_sk_generic(sk);
 	np->hop_limit	= -1;
 	np->mcast_hops	= IPV6_DEFAULT_MCASTHOPS;
-	np->mc_loop	= 1;
+	inet6_set_bit(MC6_LOOP, sk);
 	np->mc_all	= 1;
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	np->repflow	= net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ESTABLISHED;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index f27993a1470dddd876f34f65c1f171c576eca272..755fac85a120de44272f685529b579e7118d306b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -424,6 +424,13 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(np->hop_limit, val);
 		return 0;
+	case IPV6_MULTICAST_LOOP:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val != valbool)
+			return -EINVAL;
+		inet6_assign_bit(MC6_LOOP, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -755,15 +762,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		retv = 0;
 		break;
 
-	case IPV6_MULTICAST_LOOP:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val != valbool)
-			goto e_inval;
-		np->mc_loop = valbool;
-		retv = 0;
-		break;
-
 	case IPV6_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1367,7 +1365,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case IPV6_MULTICAST_LOOP:
-		val = np->mc_loop;
+		val = inet6_test_bit(MC6_LOOP, sk);
 		break;
 
 	case IPV6_MULTICAST_IF:
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index b554fd40bdc3787eb3bafa1d9923076d6078217e..679443d7ecb586af17fa22f9ecf573318a6ac49d 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1996,7 +1996,7 @@ static int __net_init ndisc_net_init(struct net *net)
 	np = inet6_sk(sk);
 	np->hop_limit = 255;
 	/* Do not loopback ndisc messages */
-	np->mc_loop = 0;
+	inet6_clear_bit(MC6_LOOP, sk);
 
 	return 0;
 }
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index da5af28ff57b5254c0ec8976c4180113037c96a0..3c2251cabd0439834ca0fc2b8bbf0ecc6cfe9266 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1298,17 +1298,13 @@ static void set_sock_size(struct sock *sk, int mode, int val)
 static void set_mcast_loop(struct sock *sk, u_char loop)
 {
 	/* setsockopt(sock, SOL_IP, IP_MULTICAST_LOOP, &loop, sizeof(loop)); */
-	lock_sock(sk);
 	inet_assign_bit(MC_LOOP, sk, loop);
 #ifdef CONFIG_IP_VS_IPV6
-	if (sk->sk_family == AF_INET6) {
-		struct ipv6_pinfo *np = inet6_sk(sk);
-
+	if (READ_ONCE(sk->sk_family) == AF_INET6) {
 		/* IPV6_MULTICAST_LOOP */
-		np->mc_loop = loop ? 1 : 0;
+		inet6_assign_bit(MC6_LOOP, sk, loop);
 	}
 #endif
-	release_sock(sk);
 }
 
 /*
-- 
2.42.0.283.g2d96d420d3-goog



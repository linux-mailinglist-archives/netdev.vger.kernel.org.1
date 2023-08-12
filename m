Return-Path: <netdev+bounces-27025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1191D779E99
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA646280551
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E74C1868;
	Sat, 12 Aug 2023 09:33:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD37485
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:33:58 +0000 (UTC)
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE41213B
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:33:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-6418b47bad1so17487776d6.2
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832836; x=1692437636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ylySmqox54zfVizVbbss+ivuk/GqNM8lbXTUV9gC/c=;
        b=eXPQxCd7Lq0ivmzG8ecUu8ZVgTOtVH0DeSECOndEuW7F/uBwlQ82/AcilMBF6RSYY+
         bovcHY/RSH7aVja+7y0q3/dyMhAbD6CbgBABJt+XWT86IC4PHYUNPxbxvvLmfUEFrYnd
         ItCB2uPeHo0h/h1x2MKltW9+WuFJ80MdSMhKhAkT5nWZ0hi3fTmaaexirPDdugIf2RaK
         d+lsDubtmHz3pvwnJ4KthCG+g8AGW1xa6AE4+RjK0lAaKgxon5CVjpZ6JV4K/l7Sj8Y4
         jBYo6849p4RQDe3O2njUMbw1XaVfUE9ngVWe3BaPmItFYcNGuN3e0Ju6K8tyIIFZgGrD
         4HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832836; x=1692437636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ylySmqox54zfVizVbbss+ivuk/GqNM8lbXTUV9gC/c=;
        b=c4H8N7hWO+EzNIk4rdRgBEZNVkGLapxRD4Xo83baXDvmy+OhRcCOR0RuYLr2mcGU67
         225I28uuRMmuOEG9cqVi5CU5o039GlKxKDf2C1/tPFhCzcqwIjEY+/FUqlaGTycpPW0A
         UUODnw966MB/jjg3WsliuAATwTxRj4KRNmxQZ2fG0k3ourrPFuhdYKa35G4HkvgPlLew
         XLHQoIrmVEseDgkFuf2G8VeOvXrEjoPH3qAodg9GVFw7rsSsAecCvnJ9qqWngpOOM63h
         37Wb+E5hKtbYwflxLkqSObJ1SEXTfigjSqrgK1Y7QS/zULVsmqFo+0ow+ekfMze6MJL8
         oqAA==
X-Gm-Message-State: AOJu0YzPPtFFju0KuI5T0mSQNIynT6XSMfOUfUC3TVdw+WbDvlXGkDhJ
	B5YvodGBkkYCqyCOwosRiMjHugZ1n/Ea0A==
X-Google-Smtp-Source: AGHT+IFt7urtSgFJ662KCIpIZ+k9SjxT9nQ07g4uec4eW4idij/mvaHjMfCNbb4pUuYj2Wy56dSv3rpz5I7FaA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:5644:b0:63f:bfb1:3a38 with SMTP
 id mh4-20020a056214564400b0063fbfb13a38mr55664qvb.12.1691832836022; Sat, 12
 Aug 2023 02:33:56 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:36 +0000
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812093344.3561556-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-8-edumazet@google.com>
Subject: [PATCH v3 net-next 07/15] inet: move inet->mc_loop to inet->inet_frags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IP_MULTICAST_LOOP socket option can now be set/read
without locking the socket.

v3: fix build bot error reported in ipvs set_mcast_loop()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h         |  2 +-
 net/core/sock.c                 |  2 +-
 net/ipv4/af_inet.c              |  2 +-
 net/ipv4/inet_diag.c            |  2 +-
 net/ipv4/ip_sockglue.c          | 16 ++++++++--------
 net/ipv4/udp_tunnel_core.c      |  2 +-
 net/ipv6/af_inet6.c             |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  4 +---
 net/sctp/socket.c               |  2 +-
 9 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index ad1895e32e7d9bbad4ce210bda9698328e026b18..6c4eeca59f608ff18e5f05dec33700189d6e2198 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -231,7 +231,6 @@ struct inet_sock {
 	__u8			mc_ttl;
 	__u8			pmtudisc;
 	__u8			is_icsk:1,
-				mc_loop:1,
 				transparent:1,
 				mc_all:1,
 				nodefrag:1;
@@ -271,6 +270,7 @@ enum {
 	INET_FLAGS_RECVERR_RFC4884 = 10,
 	INET_FLAGS_FREEBIND	= 11,
 	INET_FLAGS_HDRINCL	= 12,
+	INET_FLAGS_MC_LOOP	= 13,
 };
 
 /* cmsg flags for inet */
diff --git a/net/core/sock.c b/net/core/sock.c
index 525619776c6f4945552d5c4117c5742fe7e14f5e..22d94394335fb75f12da65368e87c5a65167cc0e 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -767,7 +767,7 @@ bool sk_mc_loop(struct sock *sk)
 		return true;
 	switch (sk->sk_family) {
 	case AF_INET:
-		return inet_sk(sk)->mc_loop;
+		return inet_test_bit(MC_LOOP, sk);
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		return inet6_sk(sk)->mc_loop;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a42ae7a6a7aa17cf15faf4a9674241bc38e59e42..80e2a3c897a540c76b979355957b81a024bd8259 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -350,7 +350,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
 	inet->uc_ttl	= -1;
-	inet->mc_loop	= 1;
+	inet_set_bit(MC_LOOP, sk);
 	inet->mc_ttl	= 1;
 	inet->mc_all	= 1;
 	inet->mc_index	= 0;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 98f3eb0ce16ab32daccf3c2407630622e9cdb71d..cc797261893b902f626b5a36074e4b4bf7535063 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -186,7 +186,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.is_icsk	= inet->is_icsk;
 	inet_sockopt.freebind	= inet_test_bit(FREEBIND, sk);
 	inet_sockopt.hdrincl	= inet_test_bit(HDRINCL, sk);
-	inet_sockopt.mc_loop	= inet->mc_loop;
+	inet_sockopt.mc_loop	= inet_test_bit(MC_LOOP, sk);
 	inet_sockopt.transparent = inet->transparent;
 	inet_sockopt.mc_all	= inet->mc_all;
 	inet_sockopt.nodefrag	= inet->nodefrag;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 763456fd4f4faac8e46d649a281f178be05a7cef..be569032b612bef1277e802400a1ee6ec20e877a 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -993,6 +993,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -ENOPROTOOPT;
 		inet_assign_bit(HDRINCL, sk, val);
 		return 0;
+	case IP_MULTICAST_LOOP:
+		if (optlen < 1)
+			return -EINVAL;
+		inet_assign_bit(MC_LOOP, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1083,11 +1088,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->mc_ttl = val;
 		break;
-	case IP_MULTICAST_LOOP:
-		if (optlen < 1)
-			goto e_inval;
-		inet->mc_loop = !!val;
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1579,6 +1579,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_HDRINCL:
 		val = inet_test_bit(HDRINCL, sk);
 		goto copyval;
+	case IP_MULTICAST_LOOP:
+		val = inet_test_bit(MC_LOOP, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1653,9 +1656,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MULTICAST_TTL:
 		val = inet->mc_ttl;
 		break;
-	case IP_MULTICAST_LOOP:
-		val = inet->mc_loop;
-		break;
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) inet->uc_index);
 		break;
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 5f8104cf082d0e25a204f1d7ae5c27d9961914ea..9b18f371af0d49bd3ee9a440f222d03efd8a4911 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -63,7 +63,7 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 	struct sock *sk = sock->sk;
 
 	/* Disable multicast loopback */
-	inet_sk(sk)->mc_loop = 0;
+	inet_clear_bit(MC_LOOP, sk);
 
 	/* Enable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
 	inet_inc_convert_csum(sk);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 138270e59ea6e2f30fcd75440609f92306bd4975..4a34a4ba62b229991307ebed74ac7cd9f3a943ba 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -229,7 +229,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	 */
 	inet->uc_ttl	= -1;
 
-	inet->mc_loop	= 1;
+	inet_set_bit(MC_LOOP, sk);
 	inet->mc_ttl	= 1;
 	inet->mc_index	= 0;
 	RCU_INIT_POINTER(inet->mc_list, NULL);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 264f2f87a43760a459dbb3c3fe5354d89799c1cb..da5af28ff57b5254c0ec8976c4180113037c96a0 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1297,11 +1297,9 @@ static void set_sock_size(struct sock *sk, int mode, int val)
  */
 static void set_mcast_loop(struct sock *sk, u_char loop)
 {
-	struct inet_sock *inet = inet_sk(sk);
-
 	/* setsockopt(sock, SOL_IP, IP_MULTICAST_LOOP, &loop, sizeof(loop)); */
 	lock_sock(sk);
-	inet->mc_loop = loop ? 1 : 0;
+	inet_assign_bit(MC_LOOP, sk, loop);
 #ifdef CONFIG_IP_VS_IPV6
 	if (sk->sk_family == AF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 6e3d28aa587cdb64f7a1ac384fa28a34d4c6739c..04b390892827b8abbb7e7433d71f4f54dd1dac21 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9482,7 +9482,7 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 	newinet->inet_id = get_random_u16();
 
 	newinet->uc_ttl = inet->uc_ttl;
-	newinet->mc_loop = 1;
+	inet_set_bit(MC_LOOP, newsk);
 	newinet->mc_ttl = 1;
 	newinet->mc_index = 0;
 	newinet->mc_list = NULL;
-- 
2.41.0.640.ga95def55d0-goog



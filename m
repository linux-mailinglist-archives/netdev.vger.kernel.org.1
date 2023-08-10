Return-Path: <netdev+bounces-26287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED695777623
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBF02811E5
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AAF20F91;
	Thu, 10 Aug 2023 10:39:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383A51EA7B
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:55 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171AA2728
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d5e792a163dso814692276.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691663991; x=1692268791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JO9l6Nt15/gF5cYiZN4Ce3Sq2EDG2Iri9gA5vRy+vh0=;
        b=lx5B1QUTXRBnf3qX5+jEJFZDqU0Czm+Fc2jTwcGyfrItRkLfE40+Nev9AnpwyE4Wlj
         E4U4ta/JYSEsvlt8QRdrgDEkluM47U1wBRG70O88QjceJlsuWuNNQTjoM7sPW8xlrfe7
         +Ju6Uzh+yqL9g7tIrojcc5E67Ph4kL/P9DyS22gGmsJxmree+Ksw2f7Lg9fSGXNaeMmn
         ejXuoqJ1fDJwIKkFUycjSdjFrSRj0DsGJtAkccHR+uSAUln6tMla0Mbt3H8t7aBFss0L
         rzgSRoID6d6FF/4zhPBzPZLBi6OFwBym9Yx4w+tuUogtV4S3EBCTQPO/g1++GzE1KPhG
         dFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663991; x=1692268791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JO9l6Nt15/gF5cYiZN4Ce3Sq2EDG2Iri9gA5vRy+vh0=;
        b=Xzos+fwcTa09Dqr5j7M6euwtjkmhWGkRx29mIycmnlltvKw0itTBjGUh6o1cyWMM7H
         bYmbVuRh1+JA+oq4ul2+NGuwd6wQbvfM4bo9jizN6l6IjYhwGy+IxpPDnwZJONdhYJ6v
         54mN1KDi3aHi5KwgqHcdf13TwQSe3VbRguPkMAyNg4WcytCvhZCp1l4otGf2Cl/yyJZt
         E1GFc5GYjnI+qtDtm4z3kTfD6vg+LhnLbCDYvna6paQc1zNLZ+CnsRyeT2Ll8igQj1Zi
         PLb1sqMsVYEN9erIHHrRkLsPjnk6KOlfZNUooKCAZAUrkWU9Mk0EVvi7hc4Y9AGFlif7
         Ai8Q==
X-Gm-Message-State: AOJu0YztMhc9eDM6xaf2QjvdHz+nHx/kMqgSjZDMQUD48UdYA/CazZBR
	+DQCGwQYvUZuRst49ywLutYAQsR0i/B7pA==
X-Google-Smtp-Source: AGHT+IHNVpiIQAPQ8f16daqVQdGE4vwJTyK5DRU0Y3DwLk8EBwhE940I57U0xFwGKc5puLIa4U6DFcnY5sG3jw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4294:0:b0:d45:daf4:1fc5 with SMTP id
 p142-20020a254294000000b00d45daf41fc5mr29321yba.3.1691663991115; Thu, 10 Aug
 2023 03:39:51 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:19 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-8-edumazet@google.com>
Subject: [PATCH net-next 07/15] inet: move inet->mc_loop to inet->inet_frags
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_sock.h    |  2 +-
 net/core/sock.c            |  2 +-
 net/ipv4/af_inet.c         |  2 +-
 net/ipv4/inet_diag.c       |  2 +-
 net/ipv4/ip_sockglue.c     | 16 ++++++++--------
 net/ipv4/udp_tunnel_core.c |  2 +-
 net/ipv6/af_inet6.c        |  2 +-
 net/sctp/socket.c          |  2 +-
 8 files changed, 15 insertions(+), 15 deletions(-)

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
index 51f7d94eccf7c78d25f8acf9a24ce0828b4f56f4..b0862a54c1e6a9263bcaf775fd38a88f45124c55 100644
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



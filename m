Return-Path: <netdev+bounces-27951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F6577DBF0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19811C20F59
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16428DDAE;
	Wed, 16 Aug 2023 08:16:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CDEDDB0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:04 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC091FF9
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58d37b541a2so836227b3.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173761; x=1692778561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DDFT5fqF5m0mnPP5/nDzq9VPztx6GSkyaFaDWG9+BV8=;
        b=35G4I+syEU1Vkrzf5MpSaGdiVXpmR+q8Lwmh/4fCVwgSxut9cQBvdz+0E4y99H33QX
         1n/zU7K44FjzrYxNkwe+LLrC7fSEx9gnGz0wSqE7ofJOnOhs6SU9wUNPUSJdYkz5l7x+
         P2oUjT5As3QGXGzED+zSopaiaUjIgkj1pznVSNWJR9cB66ORhmpEtiR0NVCFvolh28NC
         1EjTeGprOLgP9Rsx8AVwEJgnrlWX3y+7miKufITICDbyXo91c++ZiG/6nlauhXmWs2c6
         udjvTAmqCx7GvaSh/7rWchnSC5HiQz6S4tKbW7joPxT6FzIIZcZQACQ1zfqsmMr2xXR4
         C1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173761; x=1692778561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDFT5fqF5m0mnPP5/nDzq9VPztx6GSkyaFaDWG9+BV8=;
        b=jh1haCvdSlTKLoAXYF498Fp7XV2jPGVdLwpzUblESmN97HNVqH60CUgGz7XvkRSGxW
         zCJxEZiwpz38B/pud5ez0mKg2su8SC6cI+MhFLR7rol2E+txFANGqteChcR8hzR3nLyr
         Y+c2d5grE2BN9XvIOEzK1VtzIXJ6aUZIpumiScaF7+iCQtUcZcKVeaW9+kKNsLMx0joK
         qFrz4iYN7XwcrDys1BMzNZSrUwQbWHYkhHxXzBZQPqMyN6xXOGt2GWwg7Uqu5CwobyTx
         8L1X5gXEwWFzWb9akvYK9msO+gbrR5h9D+4Z43wfhvCnujeUjqD6Z7IYR9V75ZVz3xx4
         JsiA==
X-Gm-Message-State: AOJu0Yy4RaS44JIrfYhRWhyuaEGiKnMQWYsFrTh7A5tgjszjpSxG0RwF
	6A8PDDzcVS8pUnt0AEbiFl7ZaGxsaJpU1A==
X-Google-Smtp-Source: AGHT+IF3mTZRhDN/tQo7zFCNF4T3OeWw2kgR2/yjCkHGhzNyuf9SVdgb3iPN3TqOe6Nx8rOImsTItfYIuV5Xxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1828:b0:d48:c04:f256 with SMTP
 id cf40-20020a056902182800b00d480c04f256mr12922ybb.11.1692173761174; Wed, 16
 Aug 2023 01:16:01 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:38 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-7-edumazet@google.com>
Subject: [PATCH v4 net-next 06/15] inet: move inet->hdrincl to inet->inet_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IP_HDRINCL socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/inet_sock.h |  4 ++--
 net/ipv4/af_inet.c      |  2 +-
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_output.c    |  5 +++--
 net/ipv4/ip_sockglue.c  | 18 ++++++++----------
 net/ipv4/raw.c          | 10 +++-------
 net/ipv4/route.c        |  8 ++++----
 net/ipv6/af_inet6.c     |  2 +-
 net/ipv6/ip6_output.c   |  5 +++--
 net/ipv6/raw.c          | 16 +++++-----------
 10 files changed, 31 insertions(+), 41 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index d6ba963534b4a5aa5dc6f88b94dd36f260be765b..ad1895e32e7d9bbad4ce210bda9698328e026b18 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -231,7 +231,6 @@ struct inet_sock {
 	__u8			mc_ttl;
 	__u8			pmtudisc;
 	__u8			is_icsk:1,
-				hdrincl:1,
 				mc_loop:1,
 				transparent:1,
 				mc_all:1,
@@ -271,6 +270,7 @@ enum {
 	INET_FLAGS_RECVERR	= 9,
 	INET_FLAGS_RECVERR_RFC4884 = 10,
 	INET_FLAGS_FREEBIND	= 11,
+	INET_FLAGS_HDRINCL	= 12,
 };
 
 /* cmsg flags for inet */
@@ -397,7 +397,7 @@ static inline __u8 inet_sk_flowi_flags(const struct sock *sk)
 {
 	__u8 flags = 0;
 
-	if (inet_sk(sk)->transparent || inet_sk(sk)->hdrincl)
+	if (inet_sk(sk)->transparent || inet_test_bit(HDRINCL, sk))
 		flags |= FLOWI_FLAG_ANYSRC;
 	return flags;
 }
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c59da65f19d234fcaaf79abf6a80daaa53e27afc..5785fe9de58c2ef1ba8248afbfd3ef06aee4d107 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -338,7 +338,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	if (SOCK_RAW == sock->type) {
 		inet->inet_num = protocol;
 		if (IPPROTO_RAW == protocol)
-			inet->hdrincl = 1;
+			inet_set_bit(HDRINCL, sk);
 	}
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_no_pmtu_disc))
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 5a96f4f28eca6ae6e84cb3761531309e8da0be09..98f3eb0ce16ab32daccf3c2407630622e9cdb71d 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -185,7 +185,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.recverr	= inet_test_bit(RECVERR, sk);
 	inet_sockopt.is_icsk	= inet->is_icsk;
 	inet_sockopt.freebind	= inet_test_bit(FREEBIND, sk);
-	inet_sockopt.hdrincl	= inet->hdrincl;
+	inet_sockopt.hdrincl	= inet_test_bit(HDRINCL, sk);
 	inet_sockopt.mc_loop	= inet->mc_loop;
 	inet_sockopt.transparent = inet->transparent;
 	inet_sockopt.mc_all	= inet->mc_all;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index f28c87533a46567dca565a9cd47789cdefe9ac07..8f396eada1b6e61ab174473e9859bc62a10a0d1c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1039,7 +1039,7 @@ static int __ip_append_data(struct sock *sk,
 			}
 		}
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
-		if (inet->hdrincl)
+		if (inet_test_bit(HDRINCL, sk))
 			return -EPERM;
 		if (rt->dst.dev->features & NETIF_F_SG &&
 		    getfrag == ip_generic_getfrag)
@@ -1467,7 +1467,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		 * so icmphdr does not in skb linear region and can not get icmp_type
 		 * by icmp_hdr(skb)->type.
 		 */
-		if (sk->sk_type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_type == SOCK_RAW &&
+		    !inet_test_bit(HDRINCL, sk))
 			icmp_type = fl4->fl4_icmp_type;
 		else
 			icmp_type = icmp_hdr(skb)->type;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 6af84310631288c07f26c19734c5abc0fd82dc23..763456fd4f4faac8e46d649a281f178be05a7cef 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -988,6 +988,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet_assign_bit(FREEBIND, sk, val);
 		return 0;
+	case IP_HDRINCL:
+		if (sk->sk_type != SOCK_RAW)
+			return -ENOPROTOOPT;
+		inet_assign_bit(HDRINCL, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1052,13 +1057,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->uc_ttl = val;
 		break;
-	case IP_HDRINCL:
-		if (sk->sk_type != SOCK_RAW) {
-			err = -ENOPROTOOPT;
-			break;
-		}
-		inet->hdrincl = val ? 1 : 0;
-		break;
 	case IP_NODEFRAG:
 		if (sk->sk_type != SOCK_RAW) {
 			err = -ENOPROTOOPT;
@@ -1578,6 +1576,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_FREEBIND:
 		val = inet_test_bit(FREEBIND, sk);
 		goto copyval;
+	case IP_HDRINCL:
+		val = inet_test_bit(HDRINCL, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1625,9 +1626,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		       inet->uc_ttl);
 		break;
 	}
-	case IP_HDRINCL:
-		val = inet->hdrincl;
-		break;
 	case IP_NODEFRAG:
 		val = inet->nodefrag;
 		break;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index f4c27dc5714bd4be7bbd4a8e5b614c9426e6b987..4b5db5d1edc279df1fd7412af2845a7a79c95ec8 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -251,7 +251,7 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 		const struct iphdr *iph = (const struct iphdr *)skb->data;
 		u8 *payload = skb->data + (iph->ihl << 2);
 
-		if (inet->hdrincl)
+		if (inet_test_bit(HDRINCL, sk))
 			payload = skb->data;
 		ip_icmp_error(sk, skb, err, 0, info, payload);
 	}
@@ -491,12 +491,8 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (len > 0xFFFF)
 		goto out;
 
-	/* hdrincl should be READ_ONCE(inet->hdrincl)
-	 * but READ_ONCE() doesn't work with bit fields.
-	 * Doing this indirectly yields the same result.
-	 */
-	hdrincl = inet->hdrincl;
-	hdrincl = READ_ONCE(hdrincl);
+	hdrincl = inet_test_bit(HDRINCL, sk);
+
 	/*
 	 *	Check the flags.
 	 */
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 92fede388d52052ee3bd2337298b8cb0608dc362..a4e153dd615ba9321d8252a5026acafaa294a149 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -515,13 +515,12 @@ static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
 	__u8 scope = RT_SCOPE_UNIVERSE;
 
 	if (sk) {
-		const struct inet_sock *inet = inet_sk(sk);
-
 		oif = sk->sk_bound_dev_if;
 		mark = READ_ONCE(sk->sk_mark);
 		tos = ip_sock_rt_tos(sk);
 		scope = ip_sock_rt_scope(sk);
-		prot = inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol;
+		prot = inet_test_bit(HDRINCL, sk) ? IPPROTO_RAW :
+						    sk->sk_protocol;
 	}
 
 	flowi4_init_output(fl4, oif, mark, tos & IPTOS_RT_MASK, scope,
@@ -555,7 +554,8 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 	flowi4_init_output(fl4, sk->sk_bound_dev_if, READ_ONCE(sk->sk_mark),
 			   ip_sock_rt_tos(sk) & IPTOS_RT_MASK,
 			   ip_sock_rt_scope(sk),
-			   inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   inet_test_bit(HDRINCL, sk) ?
+				IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk),
 			   daddr, inet->inet_saddr, 0, 0, sk->sk_uid);
 	rcu_read_unlock();
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 3ec0359d5c1f1da0f4786a5cdfc9c74eccaec245..ed9d207080ac871690b2fec43676a2c1c7ea74ce 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -205,7 +205,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	if (SOCK_RAW == sock->type) {
 		inet->inet_num = protocol;
 		if (IPPROTO_RAW == protocol)
-			inet->hdrincl = 1;
+			inet_set_bit(HDRINCL, sk);
 	}
 
 	sk->sk_destruct		= inet6_sock_destruct;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index bc96559bbf0f8d27e2afc05696a13da6b4c1f33c..f8a1f6bb3f87251836fe6a478f16ef948239ed93 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1591,7 +1591,7 @@ static int __ip6_append_data(struct sock *sk,
 			}
 		}
 	} else if ((flags & MSG_SPLICE_PAGES) && length) {
-		if (inet_sk(sk)->hdrincl)
+		if (inet_test_bit(HDRINCL, sk))
 			return -EPERM;
 		if (rt->dst.dev->features & NETIF_F_SG &&
 		    getfrag == ip_generic_getfrag)
@@ -1995,7 +1995,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 		struct inet6_dev *idev = ip6_dst_idev(skb_dst(skb));
 		u8 icmp6_type;
 
-		if (sk->sk_socket->type == SOCK_RAW && !inet_sk(sk)->hdrincl)
+		if (sk->sk_socket->type == SOCK_RAW &&
+		   !inet_test_bit(HDRINCL, sk))
 			icmp6_type = fl6->fl6_icmp_type;
 		else
 			icmp6_type = icmp6_hdr(skb)->icmp6_type;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ea16734f5e1f7f81d329c337efbd02ab466b7ec2..0eae7661a85c4487a64384c6054a3fb827387ce7 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -291,7 +291,6 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 	       struct inet6_skb_parm *opt,
 	       u8 type, u8 code, int offset, __be32 info)
 {
-	struct inet_sock *inet = inet_sk(sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	int err;
 	int harderr;
@@ -315,7 +314,7 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 	}
 	if (np->recverr) {
 		u8 *payload = skb->data;
-		if (!inet->hdrincl)
+		if (!inet_test_bit(HDRINCL, sk))
 			payload += offset;
 		ipv6_icmp_error(sk, skb, err, 0, ntohl(info), payload);
 	}
@@ -406,7 +405,7 @@ int rawv6_rcv(struct sock *sk, struct sk_buff *skb)
 							 skb->len,
 							 inet->inet_num, 0));
 
-	if (inet->hdrincl) {
+	if (inet_test_bit(HDRINCL, sk)) {
 		if (skb_checksum_complete(skb)) {
 			atomic_inc(&sk->sk_drops);
 			kfree_skb_reason(skb, SKB_DROP_REASON_SKB_CSUM);
@@ -762,12 +761,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	/* hdrincl should be READ_ONCE(inet->hdrincl)
-	 * but READ_ONCE() doesn't work with bit fields.
-	 * Doing this indirectly yields the same result.
-	 */
-	hdrincl = inet->hdrincl;
-	hdrincl = READ_ONCE(hdrincl);
+	hdrincl = inet_test_bit(HDRINCL, sk);
 
 	/*
 	 *	Get and verify the address.
@@ -1000,7 +994,7 @@ static int do_rawv6_setsockopt(struct sock *sk, int level, int optname,
 	case IPV6_HDRINCL:
 		if (sk->sk_type != SOCK_RAW)
 			return -EINVAL;
-		inet_sk(sk)->hdrincl = !!val;
+		inet_assign_bit(HDRINCL, sk, val);
 		return 0;
 	case IPV6_CHECKSUM:
 		if (inet_sk(sk)->inet_num == IPPROTO_ICMPV6 &&
@@ -1068,7 +1062,7 @@ static int do_rawv6_getsockopt(struct sock *sk, int level, int optname,
 
 	switch (optname) {
 	case IPV6_HDRINCL:
-		val = inet_sk(sk)->hdrincl;
+		val = inet_test_bit(HDRINCL, sk);
 		break;
 	case IPV6_CHECKSUM:
 		/*
-- 
2.41.0.694.ge786442a9b-goog



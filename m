Return-Path: <netdev+bounces-34587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1857A4CD0
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026701C20F92
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B161F5EC;
	Mon, 18 Sep 2023 15:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC11CF8D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:40:36 +0000 (UTC)
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F367B10FC
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:37:07 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26f591c1a2cso3461043a91.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051240; x=1695656040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yHFG2aamSVSIP4wMY/Dd6czY/oZJOXPcTqfqejczIUQ=;
        b=VsDBOz/wOYQuEBy4PosQvXVhDx1/y3X5ZQpurZKLNLHvQWhTw5hETq49U7kCuU/x4P
         EhQkSpg3WiRQ7n7WFC8hKxltohLTVPIw5PrcRXpcyw25KnnkTF988sSzknnBcOcPZoKL
         iITbAYK+aldblks1y1jf8yD/DjqjMSEZl7eZWwL8c2cMcyli2s1hQ8TejLN4TM/2DGdE
         0j8WzNTPqe/SAJCapfXeOWSagSvNYfZmaKGf12hmdXCpL0eOqZHi1Cy5HzC6mscKY22e
         9jkyWABYVxyvrxkI8Mi0LseFoB3S4WPqUWs3wvN045Psw0sPxj3+qJa1qh49BKtzV0kv
         QnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051240; x=1695656040;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHFG2aamSVSIP4wMY/Dd6czY/oZJOXPcTqfqejczIUQ=;
        b=qBrvidJA7ZcTow2M6PYyA/S1vE6uyfsA4v9ey+ZegME8ukjKRLC8siRFcAXsZzWIUm
         GJ8qk89Ay2WGVLhGiq67gCNpNR9qHVGjHO9PtYoEJ6vOcjG13aH/+vz9fW37nJ0QALg2
         yI5M3pzORoakrLw2Y6S5fcjZe1+aZrs50IKJZ+SaZVe0ED+R4e0A0HaVGJAbP0sw9gBg
         Y+iAJpGmqY0HVzrLuXxv/1PS/jx6LC3Egmo1DDwd1R1hBRccd0/ZJf/vi6T3ur2vIvhG
         lvdwKrIfgiMu2rxpe4kYsLpDZHmzp5ehHyK7L9tWoebERKTkURRjdQ2u/T+DW1TLBcrq
         Vv0A==
X-Gm-Message-State: AOJu0YwfBNDPrhXtzGGz2s6ahrLRXyGS5t+uSjJr7rUkQiPMkg2f6Ou0
	rqOZwD9hzQVHM30zeuaYgHQQRAERirt1sg==
X-Google-Smtp-Source: AGHT+IEc57fFheAdPFNhhddOzbOHXqDtFdYpjhaHWq25nav1rzgmbq1kdCBaJ58cNGqvjxS6cMpch5i3yvW3Eg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:fc01:0:b0:d10:5b67:843c with SMTP id
 v1-20020a25fc01000000b00d105b67843cmr214181ybd.4.1695047002689; Mon, 18 Sep
 2023 07:23:22 -0700 (PDT)
Date: Mon, 18 Sep 2023 14:23:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230918142321.1794107-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: lockless IPV6_ADDR_PREFERENCES implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We have data-races while reading np->srcprefs

Switch the field to a plain byte, add READ_ONCE()
and WRITE_ONCE() annotations where needed,
and IPV6_ADDR_PREFERENCES setsockopt() can now be lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  2 +-
 include/net/ip6_route.h  |  5 ++---
 include/net/ipv6.h       | 20 +++++++-------------
 net/ipv6/ip6_output.c    |  2 +-
 net/ipv6/ipv6_sockglue.c | 19 ++++++++++---------
 net/ipv6/route.c         |  2 +-
 6 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 09253825c99c7a94c4c8a3f176f0ceecd0b166bc..e400ff757f136e72e81277d48063551e445b4970 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -243,7 +243,7 @@ struct ipv6_pinfo {
 	} rxopt;
 
 	/* sockopt flags */
-	__u8			srcprefs:3;	/* 001: prefer temporary address
+	__u8			srcprefs;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index b1ea49900b4ae17cb3436f884e26f5ae3a7a761c..28b0657902615157c4cbd836cc70e0767cf49a4d 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -53,13 +53,12 @@ struct route_info {
  */
 static inline int rt6_srcprefs2flags(unsigned int srcprefs)
 {
-	/* No need to bitmask because srcprefs have only 3 bits. */
-	return srcprefs << 3;
+	return (srcprefs & IPV6_PREFER_SRC_MASK) << 3;
 }
 
 static inline unsigned int rt6_flags2srcprefs(int flags)
 {
-	return (flags >> 3) & 7;
+	return (flags >> 3) & IPV6_PREFER_SRC_MASK;
 }
 
 static inline bool rt6_need_strict(const struct in6_addr *daddr)
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index bd115980809f386a7d38a5471d8d636f25ce1eba..b3444c8a6f744c17052a9fa1c85d54c6b08a1889 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1306,10 +1306,13 @@ static inline void ip6_sock_set_recverr(struct sock *sk)
 	inet6_set_bit(RECVERR6, sk);
 }
 
-static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
+#define IPV6_PREFER_SRC_MASK (IPV6_PREFER_SRC_TMP | IPV6_PREFER_SRC_PUBLIC | \
+			      IPV6_PREFER_SRC_COA)
+
+static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
 {
+	unsigned int prefmask = ~IPV6_PREFER_SRC_MASK;
 	unsigned int pref = 0;
-	unsigned int prefmask = ~0;
 
 	/* check PUBLIC/TMP/PUBTMP_DEFAULT conflicts */
 	switch (val & (IPV6_PREFER_SRC_PUBLIC |
@@ -1359,20 +1362,11 @@ static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
 		return -EINVAL;
 	}
 
-	inet6_sk(sk)->srcprefs = (inet6_sk(sk)->srcprefs & prefmask) | pref;
+	WRITE_ONCE(inet6_sk(sk)->srcprefs,
+		   (READ_ONCE(inet6_sk(sk)->srcprefs) & prefmask) | pref);
 	return 0;
 }
 
-static inline int ip6_sock_set_addr_preferences(struct sock *sk, int val)
-{
-	int ret;
-
-	lock_sock(sk);
-	ret = __ip6_sock_set_addr_preferences(sk, val);
-	release_sock(sk);
-	return ret;
-}
-
 static inline void ip6_sock_set_recvpktinfo(struct sock *sk)
 {
 	lock_sock(sk);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e5d9eeb990fd4549be753fdaaf1e6c6c21d3f8d..951ba8089b5b44c589f1b497e645ffc15a86c7c8 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1113,7 +1113,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		rcu_read_lock();
 		from = rt ? rcu_dereference(rt->from) : NULL;
 		err = ip6_route_get_saddr(net, from, &fl6->daddr,
-					  sk ? inet6_sk(sk)->srcprefs : 0,
+					  sk ? READ_ONCE(inet6_sk(sk)->srcprefs) : 0,
 					  &fl6->saddr);
 		rcu_read_unlock();
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index e9dc6f881bb92db267903a71f3f3e4de4c557819..7d661735cb9d519ab4691979f30365acda0a28c3 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -505,6 +505,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet6_assign_bit(SNDFLOW, sk, valbool);
 		return 0;
+	case IPV6_ADDR_PREFERENCES:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		return ip6_sock_set_addr_preferences(sk, val);
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -964,11 +968,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		retv = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 
-	case IPV6_ADDR_PREFERENCES:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		retv = __ip6_sock_set_addr_preferences(sk, val);
-		break;
 	case IPV6_RECVFRAGSIZE:
 		np->rxopt.bits.recvfragsize = valbool;
 		retv = 0;
@@ -1415,23 +1414,25 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	}
 
 	case IPV6_ADDR_PREFERENCES:
+		{
+		u8 srcprefs = READ_ONCE(np->srcprefs);
 		val = 0;
 
-		if (np->srcprefs & IPV6_PREFER_SRC_TMP)
+		if (srcprefs & IPV6_PREFER_SRC_TMP)
 			val |= IPV6_PREFER_SRC_TMP;
-		else if (np->srcprefs & IPV6_PREFER_SRC_PUBLIC)
+		else if (srcprefs & IPV6_PREFER_SRC_PUBLIC)
 			val |= IPV6_PREFER_SRC_PUBLIC;
 		else {
 			/* XXX: should we return system default? */
 			val |= IPV6_PREFER_SRC_PUBTMP_DEFAULT;
 		}
 
-		if (np->srcprefs & IPV6_PREFER_SRC_COA)
+		if (srcprefs & IPV6_PREFER_SRC_COA)
 			val |= IPV6_PREFER_SRC_COA;
 		else
 			val |= IPV6_PREFER_SRC_HOME;
 		break;
-
+		}
 	case IPV6_MINHOPCOUNT:
 		val = READ_ONCE(np->min_hopcount);
 		break;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9d8dfc7423e49af6df6ddc95ddf235b0b2b758ef..b132feae3393f313b48fb84fc56e2c2aad37608a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -2622,7 +2622,7 @@ static struct dst_entry *ip6_route_output_flags_noref(struct net *net,
 	if (!any_src)
 		flags |= RT6_LOOKUP_F_HAS_SADDR;
 	else if (sk)
-		flags |= rt6_srcprefs2flags(inet6_sk(sk)->srcprefs);
+		flags |= rt6_srcprefs2flags(READ_ONCE(inet6_sk(sk)->srcprefs));
 
 	return fib6_rule_lookup(net, fl6, NULL, flags, ip6_pol_route_output);
 }
-- 
2.42.0.459.ge4e396fd5e-goog



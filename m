Return-Path: <netdev+bounces-33299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC2279D5A2
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFC281E4F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF118C3E;
	Tue, 12 Sep 2023 16:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35918C3C
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:18 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1D01716
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b957fd276so5257909276.0
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534536; x=1695139336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18cv7HmUKHtg7YyG5IMUuADgJYGkn4jNiQYrKm573Fw=;
        b=qxIHXWoXHb4d0E7xtq08OLIoLa+QqT80sbFmd0pcFr9t8zdL/UmqcXyKmbwv2SY0Ch
         zDmjOQDqSPg4wFnJ60vmI7oTYCjUvldhRAS9ZJR+lV7hN9stqLJEM0vFSMBcKwQqy2OQ
         2CzILwsUUpKDjKJv2Ft4Om+GmVS79EQPBuvdjBGj5+Rd0S9R3KUdDmdKG8Nx6uL5YOyb
         9nLkCVodyMozKcVB3uToN2qWjI2q5fDKQwjEuVCKKNdLSLWlgksuQDpxK4hXMpydpQFn
         b8n8Z8kSz1b7FHYEJdoWKY/B/fQJClPA+Mi8wjTVKJSvzW1ltT7UkW224/N/+r+POHQ6
         iilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534536; x=1695139336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18cv7HmUKHtg7YyG5IMUuADgJYGkn4jNiQYrKm573Fw=;
        b=NC7vPYa1oJ958AaIKTXYXDc1hXoQDpWBN1hOdRNyQdXzHkzoOx5gcDAYa2aGo6DIeX
         m35AqQYCYABzUjbdwLQLn0cDIxXmHA6LL8T40+7tadwCJAFsr+Po/qWXqmsJDRF29l3F
         jFIlFXZwl+8WflUl89QmX3YrDumGjvzsaCz+9vC10Dhpg3fzMDLRfIEF7MWShCsVZuQz
         ucfhPejRzPE4HO1zLgvsD/XzshMhVXgXiOxyNE4PDzVXBo+V9L/nMncB4wLEbbHqODl8
         2FpghPcQWjzlP2ULsRT9qes04dLfe+t5TjN6H8vM74zmMtuyGtoU4CrIBXZeW/4W5kgf
         b51g==
X-Gm-Message-State: AOJu0Yw+lLiLdS3I4J5n/xrpw4/7/aeDisXg74AF4zqvIjw4wYFoTFrx
	Ol2qb3pacajB2A+Q8hoUJu7BOKrFuDosmQ==
X-Google-Smtp-Source: AGHT+IHT0D38REdFhQ21lfkuNw5xGdLfiGGMaSgJVt2+qMaVLw/HZukRfhDby7y3MxniS8HMjCcLIhR4DXXO1A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:34c3:0:b0:d7b:9185:e23d with SMTP id
 b186-20020a2534c3000000b00d7b9185e23dmr252480yba.6.1694534536318; Tue, 12 Sep
 2023 09:02:16 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:01:59 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-2-edumazet@google.com>
Subject: [PATCH net-next 01/14] ipv6: lockless IPV6_UNICAST_HOPS implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some np->hop_limit accesses are racy, when socket lock is not held.

Add missing annotations and switch to full lockless implementation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     | 12 +-----------
 include/net/ipv6.h       |  2 +-
 net/ipv6/ip6_output.c    |  2 +-
 net/ipv6/ipv6_sockglue.c | 20 +++++++++++---------
 net/ipv6/mcast.c         |  2 +-
 net/ipv6/ndisc.c         |  2 +-
 6 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index af8a771a053c51eed297516f927a5fd003315ef4..c2e0870713849fbbf1a8ec2d60cca80caab0cb98 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -213,17 +213,7 @@ struct ipv6_pinfo {
 	__be32			flow_label;
 	__u32			frag_size;
 
-	/*
-	 * Packed in 16bits.
-	 * Omit one shift by putting the signed field at MSB.
-	 */
-#if defined(__BIG_ENDIAN_BITFIELD)
-	__s16			hop_limit:9;
-	__u16			__unused_1:7;
-#else
-	__u16			__unused_1:7;
-	__s16			hop_limit:9;
-#endif
+	s16			hop_limit;
 
 #if defined(__BIG_ENDIAN_BITFIELD)
 	/* Packed in 16bits. */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0675be0f3fa0efc55575bb5b2569dc8a1dbb9f24..61007db0036482e27121747add0eec77f912b54a 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -911,7 +911,7 @@ static inline int ip6_sk_dst_hoplimit(struct ipv6_pinfo *np, struct flowi6 *fl6,
 	if (ipv6_addr_is_multicast(&fl6->daddr))
 		hlimit = np->mcast_hops;
 	else
-		hlimit = np->hop_limit;
+		hlimit = READ_ONCE(np->hop_limit);
 	if (hlimit < 0)
 		hlimit = ip6_dst_hoplimit(dst);
 	return hlimit;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 54fc4c711f2c545f2ca625d6b0e09f2bb8e6d513..1e16d56d8c38ac51bd999038ae4e8478bf2f5f8c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -309,7 +309,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	 *	Fill in the IPv6 header
 	 */
 	if (np)
-		hlimit = np->hop_limit;
+		hlimit = READ_ONCE(np->hop_limit);
 	if (hlimit < 0)
 		hlimit = ip6_dst_hoplimit(dst);
 
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 0e2a0847b387f0f6f50211b89f92ac1e00a0b07a..f27993a1470dddd876f34f65c1f171c576eca272 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -415,6 +415,16 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	if (ip6_mroute_opt(optname))
 		return ip6_mroute_setsockopt(sk, optname, optval, optlen);
 
+	/* Handle options that can be set without locking the socket. */
+	switch (optname) {
+	case IPV6_UNICAST_HOPS:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val > 255 || val < -1)
+			return -EINVAL;
+		WRITE_ONCE(np->hop_limit, val);
+		return 0;
+	}
 	if (needs_rtnl)
 		rtnl_lock();
 	sockopt_lock_sock(sk);
@@ -733,14 +743,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	}
-	case IPV6_UNICAST_HOPS:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val > 255 || val < -1)
-			goto e_inval;
-		np->hop_limit = val;
-		retv = 0;
-		break;
 
 	case IPV6_MULTICAST_HOPS:
 		if (sk->sk_type == SOCK_STREAM)
@@ -1347,7 +1349,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		struct dst_entry *dst;
 
 		if (optname == IPV6_UNICAST_HOPS)
-			val = np->hop_limit;
+			val = READ_ONCE(np->hop_limit);
 		else
 			val = np->mcast_hops;
 
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 5ce25bcb9974de97f26635d0d3d54695af3070a7..6a33a50687bcf7201e75574f03e619fe89636068 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1716,7 +1716,7 @@ static void ip6_mc_hdr(const struct sock *sk, struct sk_buff *skb,
 
 	hdr->payload_len = htons(len);
 	hdr->nexthdr = proto;
-	hdr->hop_limit = inet6_sk(sk)->hop_limit;
+	hdr->hop_limit = READ_ONCE(inet6_sk(sk)->hop_limit);
 
 	hdr->saddr = *saddr;
 	hdr->daddr = *daddr;
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 553c8664e0a7a37d7858393ab6a30616ab13a3bf..b554fd40bdc3787eb3bafa1d9923076d6078217e 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -500,7 +500,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 					      csum_partial(icmp6h,
 							   skb->len, 0));
 
-	ip6_nd_hdr(skb, saddr, daddr, inet6_sk(sk)->hop_limit, skb->len);
+	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
 	rcu_read_lock();
 	idev = __in6_dev_get(dst->dev);
-- 
2.42.0.283.g2d96d420d3-goog



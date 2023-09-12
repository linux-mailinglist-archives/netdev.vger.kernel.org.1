Return-Path: <netdev+bounces-33311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B152279D5CC
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A62A281E66
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2421DDC3;
	Tue, 12 Sep 2023 16:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02B18C16
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:36 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A0E1713
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5958487ca15so62496067b3.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534555; x=1695139355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q16FZwEagPC8mxu1UiXiEFjw1FudmlK63LZ8Kds0oUg=;
        b=J93YEx69gQ4tlj8nVZgBvkWmWWP0kdmIhNCq4bW0EfcQpNfS8sNC1VpcRlvUcaEpkB
         8TOghbelOkOnbAbBr+0goDt01INnZ8X2jOadIiSu0h4+atYE90BsWGY0oXXe7QOoErpk
         KpzYUiVMUB13/Rgc2tB1hemgyinmr+SGmCVRm6fbRpbABziAKRMLJn4Ue2WbGEenNBki
         MSPliuM3uObNjGz3qaQ+cyaiJG2Nxc12AUcuxE48KRbOSdJ9jymBY1Xj6PjJM5kPe6d9
         P5KZIC/9pk4RD+MzzcQ57MCcq8anVwXLo/Tb4idbh+FdhpMzNTFHuHhmkOz4lC6l4YK0
         5GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534555; x=1695139355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q16FZwEagPC8mxu1UiXiEFjw1FudmlK63LZ8Kds0oUg=;
        b=LmBxayjwzLIfznwGXZgeMlAZioITXKZjGIqpGprG2Z+z+HnV6Iq8gWwXfH/gv9JKvX
         KlOZ0QWznQDHbWtXCp2VHCBl3xs3QeuhdeTCWp7H3mcac7orlTRTTsQza+CRdayE6AO7
         48X52YAWhwj55sRg56dgbdqIWuSYrSKdF7Afi2iPoOfWLaudG4zrgEcJqxA9+4kMGePJ
         CtOL48Ln+EjDxPRWYw5EJfj9qdGiequRauzsqNkSF2TU6VdY4S1XViuKVmrDXfpTbeL4
         yqrVNA/mVI/3M9O8/Fd0uqo1hKSeC8yg0eMIwm/Flk8YVHd/X8/Pg+uXb4zmDhzrRiAx
         S/6g==
X-Gm-Message-State: AOJu0YzgPCGyB+t2XT2yTDqbZXRFLYBsKvyFJZoZkApU1G7WHVXfTANH
	GADtDENcAhDLQu3R8s7MBAVzDqN6mUHX9w==
X-Google-Smtp-Source: AGHT+IFVqbyfsuDkQAk0IlZ1kiqnR19pd5V5+d5CNfibo/53B8W9nrvanwWLdyJvLUwZqwGEFQzZp+JMsk21zA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d44c:0:b0:d78:2f82:b8de with SMTP id
 m73-20020a25d44c000000b00d782f82b8demr300631ybf.6.1694534554841; Tue, 12 Sep
 2023 09:02:34 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:11 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-14-edumazet@google.com>
Subject: [PATCH net-next 13/14] ipv6: lockless IPV6_MTU_DISCOVER implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Most np->pmtudisc reads are racy.

Move this 3bit field on a full byte, add annotations
and make IPV6_MTU_DISCOVER setsockopt() lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h            |  5 ++---
 include/net/ip6_route.h         | 14 +++++++++-----
 net/ipv6/ip6_output.c           |  4 ++--
 net/ipv6/ipv6_sockglue.c        | 17 ++++++++---------
 net/ipv6/raw.c                  |  2 +-
 net/ipv6/udp.c                  |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 7 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index f288a35f157f73ded445639c30f3365047fd9ddc..10f521a6a9c8a881b4677d53597929622ae95b67 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -243,13 +243,12 @@ struct ipv6_pinfo {
 	} rxopt;
 
 	/* sockopt flags */
-	__u16			sndflow:1,
-				pmtudisc:3,
-				padding:1,	/* 1 bit hole */
+	__u8			sndflow:1,
 				srcprefs:3;	/* 001: prefer temporary address
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
+	__u8			pmtudisc;
 	__u8			min_hopcount;
 	__u8			tclass;
 	__be32			rcv_flowinfo;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index b32539bb0fb05c67b5849bb219be59fabe5bb51c..b1ea49900b4ae17cb3436f884e26f5ae3a7a761c 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -266,7 +266,7 @@ static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 	const struct dst_entry *dst = skb_dst(skb);
 	unsigned int mtu;
 
-	if (np && np->pmtudisc >= IPV6_PMTUDISC_PROBE) {
+	if (np && READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE) {
 		mtu = READ_ONCE(dst->dev->mtu);
 		mtu -= lwtunnel_headroom(dst->lwtstate, mtu);
 	} else {
@@ -277,14 +277,18 @@ static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 
 static inline bool ip6_sk_accept_pmtu(const struct sock *sk)
 {
-	return inet6_sk(sk)->pmtudisc != IPV6_PMTUDISC_INTERFACE &&
-	       inet6_sk(sk)->pmtudisc != IPV6_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet6_sk(sk)->pmtudisc);
+
+	return pmtudisc != IPV6_PMTUDISC_INTERFACE &&
+	       pmtudisc != IPV6_PMTUDISC_OMIT;
 }
 
 static inline bool ip6_sk_ignore_df(const struct sock *sk)
 {
-	return inet6_sk(sk)->pmtudisc < IPV6_PMTUDISC_DO ||
-	       inet6_sk(sk)->pmtudisc == IPV6_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet6_sk(sk)->pmtudisc);
+
+	return pmtudisc < IPV6_PMTUDISC_DO ||
+	       pmtudisc == IPV6_PMTUDISC_OMIT;
 }
 
 static inline const struct in6_addr *rt6_nexthop(const struct rt6_info *rt,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f87d8491d7e273f167b7b144a7e134783e1b80f6..7e5d9eeb990fd4549be753fdaaf1e6c6c21d3f8d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1436,10 +1436,10 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
-		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
+		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
 	else
-		mtu = np->pmtudisc >= IPV6_PMTUDISC_PROBE ?
+		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 			READ_ONCE(rt->dst.dev->mtu) : dst_mtu(xfrm_dst_path(&rt->dst));
 
 	frag_size = READ_ONCE(np->frag_size);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index c22a492e05360b68ef6868707e363f2ce84a4c35..85ea42644dcbbe3ed8f625e51ffc6d55ada40156 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -493,6 +493,13 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet6_assign_bit(RTALERT_ISOLATE, sk, valbool);
 		return 0;
+	case IPV6_MTU_DISCOVER:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val < IPV6_PMTUDISC_DONT || val > IPV6_PMTUDISC_OMIT)
+			return -EINVAL;
+		WRITE_ONCE(np->pmtudisc, val);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -941,14 +948,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = ip6_ra_control(sk, val);
 		break;
-	case IPV6_MTU_DISCOVER:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val < IPV6_PMTUDISC_DONT || val > IPV6_PMTUDISC_OMIT)
-			goto e_inval;
-		np->pmtudisc = val;
-		retv = 0;
-		break;
 	case IPV6_FLOWINFO_SEND:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -1374,7 +1373,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_MTU_DISCOVER:
-		val = np->pmtudisc;
+		val = READ_ONCE(np->pmtudisc);
 		break;
 
 	case IPV6_RECVERR:
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 71f6bdccfa1f39290e1b573ff8c647d91fd007a4..47372cceb98f6e606346b74230b03e76e303822c 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -307,7 +307,7 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 	harderr = icmpv6_err_convert(type, code, &err);
 	if (type == ICMPV6_PKT_TOOBIG) {
 		ip6_sk_update_pmtu(skb, sk, info);
-		harderr = (np->pmtudisc == IPV6_PMTUDISC_DO);
+		harderr = (READ_ONCE(np->pmtudisc) == IPV6_PMTUDISC_DO);
 	}
 	if (type == NDISC_REDIRECT) {
 		ip6_sk_redirect(skb, sk);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 65f6217d36cb7c862f1511a058a7a5973c40cef8..97fabbd7e7aa8bf66bfe21a98f97d4408af13d2b 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -598,7 +598,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		if (!ip6_sk_accept_pmtu(sk))
 			goto out;
 		ip6_sk_update_pmtu(skb, sk, info);
-		if (np->pmtudisc != IPV6_PMTUDISC_DONT)
+		if (READ_ONCE(np->pmtudisc) != IPV6_PMTUDISC_DONT)
 			harderr = 1;
 	}
 	if (type == NDISC_REDIRECT) {
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index df1b33b61059eef1e86baefc63e138108a50a081..5820a8156c4701bb163f569d735c389d7a8e3820 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1341,7 +1341,7 @@ static void set_mcast_pmtudisc(struct sock *sk, int val)
 		struct ipv6_pinfo *np = inet6_sk(sk);
 
 		/* IPV6_MTU_DISCOVER */
-		np->pmtudisc = val;
+		WRITE_ONCE(np->pmtudisc, val);
 	}
 #endif
 	release_sock(sk);
-- 
2.42.0.283.g2d96d420d3-goog



Return-Path: <netdev+bounces-35485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A877A9B2D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB8A31C209E7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F718C3B;
	Thu, 21 Sep 2023 17:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBDE1641D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB28B9B4
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:41:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdac026f7so18668537b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318108; x=1695922908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrBBHPQ1Mbxs5uHbpE2nLXIPq/c5M9zFULQnuzPmERg=;
        b=r1bzyR98ukP9UQqH0hYUUrHB1EH6rULmAyiUsgHytQ3URdNVS+yfPIn93asgYiSp1i
         JBPFZ2fvjwu8vfBtOEjTtWOvfj7osia1vvhURftND7jUGFUs4KJxs0NKAKJOXJ58qRy0
         jvJ0gg1pNFF9cIsBMSedKJQf3l3Y+FSvxUolw2SXViewZ61P8iCNM4Br2A771V2WOCdo
         kZ822ETucUrlD1EzRlWv3k7lCcpX3+OCNDF2ZsuI6t3styl8a/vyDFFWY1IB/6DNZn+Q
         /YmfkoiOGOPmHCyHg8voYDk5jU+ObEB7FxK7c4C4/fv1Ou79Ve4c9Mkbfqd7IxhMJuT4
         P2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318108; x=1695922908;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SrBBHPQ1Mbxs5uHbpE2nLXIPq/c5M9zFULQnuzPmERg=;
        b=dCuEkaSnYnb2uTOhjbGK4ZFkZNNjbK3MgXwKDJ54mOdVqFQWGhEh5qyNpwc5YJpt3z
         vgJl5+5RFNMNvb9VDlWWWk/P+Ch2vuCEnN51qVHZt5Fo7t6whsf5JkoHWEd06edt6rtZ
         gj9xkBj9lZkHpyFY1e31J2pFJQoKRTSH2rlj97qhUY8IbtR0qcaMF1yOyyvJ1pSsA8mX
         08QHCLgiShjqVLpEQ6VDmHLHIHAWNLShB9A9Pkh+sVwPm0VNukzlJKbwBPuYWQKAVGPi
         1u2nANp0DwLp80Yt3T1qoPpO2sDFvlxyuW2RWuSDVIklu0lp5/kUsLnjQutU4InGMfz/
         3TOw==
X-Gm-Message-State: AOJu0Yzg19CZL0QkeeS+Fp1vmTih7QebUBdAzuonledfftXZa//WNnEe
	IApNS59TnpMMdC3sIZjTWF3Yk8g0pNBXEw==
X-Google-Smtp-Source: AGHT+IGwrMVDeFTpP0QVmGcHxkZIOG2WDZftfPqG9SHfpiRxOM1So17MliB53003LpToS5/Ogj0TVwVcpy+qUg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:987:b0:d84:e73f:6f8c with SMTP
 id bv7-20020a056902098700b00d84e73f6f8cmr88457ybb.6.1695303029173; Thu, 21
 Sep 2023 06:30:29 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:15 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-3-edumazet@google.com>
Subject: [PATCH net-next 2/8] inet: implement lockless IP_MTU_DISCOVER
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->pmtudisc can be read locklessly.

Implement proper lockless reads and writes to inet->pmtudisc

ip_sock_set_mtu_discover() can now be called from arbitrary
contexts.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h                | 13 ++++++++-----
 net/ipv4/ip_output.c            |  7 ++++---
 net/ipv4/ip_sockglue.c          | 17 ++++++-----------
 net/ipv4/ping.c                 |  2 +-
 net/ipv4/raw.c                  |  2 +-
 net/ipv4/udp.c                  |  2 +-
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 7 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 3489a1cca5e7bc315ba646f6bc125b2b6ded9416..46933a0d98eac2db40c2e88006125588b8f8143e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -434,19 +434,22 @@ int ip_dont_fragment(const struct sock *sk, const struct dst_entry *dst)
 
 static inline bool ip_sk_accept_pmtu(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc != IP_PMTUDISC_INTERFACE &&
-	       inet_sk(sk)->pmtudisc != IP_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet_sk(sk)->pmtudisc);
+
+	return pmtudisc != IP_PMTUDISC_INTERFACE &&
+	       pmtudisc != IP_PMTUDISC_OMIT;
 }
 
 static inline bool ip_sk_use_pmtu(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc < IP_PMTUDISC_PROBE;
+	return READ_ONCE(inet_sk(sk)->pmtudisc) < IP_PMTUDISC_PROBE;
 }
 
 static inline bool ip_sk_ignore_df(const struct sock *sk)
 {
-	return inet_sk(sk)->pmtudisc < IP_PMTUDISC_DO ||
-	       inet_sk(sk)->pmtudisc == IP_PMTUDISC_OMIT;
+	u8 pmtudisc = READ_ONCE(inet_sk(sk)->pmtudisc);
+
+	return pmtudisc < IP_PMTUDISC_DO || pmtudisc == IP_PMTUDISC_OMIT;
 }
 
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index adad16f1e872ce20941a087b3965fdb040868d4e..2be281f184a5fe5a695ccd51fabe69fa45bea0b8 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1387,8 +1387,8 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct ip_options *opt = NULL;
 	struct rtable *rt = (struct rtable *)cork->dst;
 	struct iphdr *iph;
+	u8 pmtudisc, ttl;
 	__be16 df = 0;
-	__u8 ttl;
 
 	skb = __skb_dequeue(queue);
 	if (!skb)
@@ -1418,8 +1418,9 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	/* DF bit is set when we want to see DF on outgoing frames.
 	 * If ignore_df is set too, we still allow to fragment this frame
 	 * locally. */
-	if (inet->pmtudisc == IP_PMTUDISC_DO ||
-	    inet->pmtudisc == IP_PMTUDISC_PROBE ||
+	pmtudisc = READ_ONCE(inet->pmtudisc);
+	if (pmtudisc == IP_PMTUDISC_DO ||
+	    pmtudisc == IP_PMTUDISC_PROBE ||
 	    (skb->len <= dst_mtu(&rt->dst) &&
 	     ip_dont_fragment(sk, &rt->dst)))
 		df = htons(IP_DF);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 4ad3003378ae6b186513000264f77b54a7babe6d..6d874cc03c8b4e88d79ebc50a6db105606b6ae60 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -622,9 +622,7 @@ int ip_sock_set_mtu_discover(struct sock *sk, int val)
 {
 	if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 		return -EINVAL;
-	lock_sock(sk);
-	inet_sk(sk)->pmtudisc = val;
-	release_sock(sk);
+	WRITE_ONCE(inet_sk(sk)->pmtudisc, val);
 	return 0;
 }
 EXPORT_SYMBOL(ip_sock_set_mtu_discover);
@@ -1050,6 +1048,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet->mc_ttl, val);
 		return 0;
+	case IP_MTU_DISCOVER:
+		return ip_sock_set_mtu_discover(sk, val);
 	}
 
 	err = 0;
@@ -1107,11 +1107,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
-	case IP_MTU_DISCOVER:
-		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
-			goto e_inval;
-		inet->pmtudisc = val;
-		break;
 	case IP_UNICAST_IF:
 	{
 		struct net_device *dev = NULL;
@@ -1595,6 +1590,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MULTICAST_TTL:
 		val = READ_ONCE(inet->mc_ttl);
 		goto copyval;
+	case IP_MTU_DISCOVER:
+		val = READ_ONCE(inet->pmtudisc);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1634,9 +1632,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = inet->tos;
 		break;
-	case IP_MTU_DISCOVER:
-		val = inet->pmtudisc;
-		break;
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 4dd809b7b18867154df42bc28809b886913e253c..50d12b0c8d46fdcd9b448c3ebc90395ebf426075 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -551,7 +551,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 		case ICMP_DEST_UNREACH:
 			if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
 				ipv4_sk_update_pmtu(skb, sk, info);
-				if (inet_sock->pmtudisc != IP_PMTUDISC_DONT) {
+				if (READ_ONCE(inet_sock->pmtudisc) != IP_PMTUDISC_DONT) {
 					err = EMSGSIZE;
 					harderr = 1;
 					break;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4b5db5d1edc279df1fd7412af2845a7a79c95ec8..ade1aecd7c71184d753a28a67bc9b30087247db4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -239,7 +239,7 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 		if (code > NR_ICMP_UNREACH)
 			break;
 		if (code == ICMP_FRAG_NEEDED) {
-			harderr = inet->pmtudisc != IP_PMTUDISC_DONT;
+			harderr = READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT;
 			err = EMSGSIZE;
 		} else {
 			err = icmp_err_convert[code].errno;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c3ff984b63547daf0ecfb4ab96956aee2f8d589d..731a723dc80816f0b5b0803d7397f7e9e8cd8b09 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -750,7 +750,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 	case ICMP_DEST_UNREACH:
 		if (code == ICMP_FRAG_NEEDED) { /* Path MTU discovery */
 			ipv4_sk_update_pmtu(skb, sk, info);
-			if (inet->pmtudisc != IP_PMTUDISC_DONT) {
+			if (READ_ONCE(inet->pmtudisc) != IP_PMTUDISC_DONT) {
 				err = EMSGSIZE;
 				harderr = 1;
 				break;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3eed1670224888acf639cff06537ddf2505461bb..4f6c795588fbdbf084154025b8172e0fd2ea7384 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1335,7 +1335,7 @@ static void set_mcast_pmtudisc(struct sock *sk, int val)
 
 	/* setsockopt(sock, SOL_IP, IP_MTU_DISCOVER, &val, sizeof(val)); */
 	lock_sock(sk);
-	inet->pmtudisc = val;
+	WRITE_ONCE(inet->pmtudisc, val);
 #ifdef CONFIG_IP_VS_IPV6
 	if (sk->sk_family == AF_INET6) {
 		struct ipv6_pinfo *np = inet6_sk(sk);
-- 
2.42.0.459.ge4e396fd5e-goog



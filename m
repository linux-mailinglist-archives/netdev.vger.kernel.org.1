Return-Path: <netdev+bounces-33301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED8A79D5A6
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC561C20DAF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABB319BAB;
	Tue, 12 Sep 2023 16:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FC18C32
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:28 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0946A171E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b50b45481so52131297b3.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534539; x=1695139339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fo+xEOyRzWOzIWC/MzpqX+IHqMyx9/A2BKEL1X7QSY=;
        b=gHrt5ehvp6Oe8OxCrmtwGvbpWWThBEf+NGXqdQ3E266WAIvuFzdjsqq2laOgDxTTRO
         Nrf3eTmIkD5YjN40cRWD/nWJnQCBK8FPnrhd8OhoN1yJ3VfHEvLOfvTRjDynoP3fyPMe
         OXNbGSOMfSdq1M8uM3HEOA6g9YA4Mq3NgXgRfWNpbaitgjmueTnBut67xp/BYQsFm4e/
         33Y9EuILn/gPTmQeovbcQ8dGktD/UBus5/cgnay7DZ+f3KaBeqVgSAOaEzggez5FJ7K7
         ihhGFPNbWDqZsYDCBlMN4HLIGcReIDGr/7zO/bRXNOTKJx1+Smaz+bGtZFvn4Wn1XTbs
         mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534539; x=1695139339;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Fo+xEOyRzWOzIWC/MzpqX+IHqMyx9/A2BKEL1X7QSY=;
        b=wW1Ls62odOu4GdE2gXkeeBsALQ4a6Shxp18zHIH8aftCr3FJFQv8Q+i1nTL5i1/InS
         JwtHQ32JT9o6oITSLsYiRH6TXky+dn6OdspaNWHLTB70KG1pdAxEn6l6Zsy7PqeoiBIS
         oTEQyE8ZlNAlPVVRijKTuSVkRb2OwOa23Ei+pjCSqk+63RuhEs8V6WZnVgHxl3OFC2Vi
         eE8tjJdC1xxwtRGr0U5LOzgGSYEznvT7pTxZZ5OmdiOAQbFp91LsPsHEu906cigc+jEq
         eZSBUMB7PRgza99Dqy5+S4ciFjS7GAMF7BvZ+aOMrIe256Q3FUS6APsQc7liR/v+X3Qt
         NC5g==
X-Gm-Message-State: AOJu0YywtM+uCJmVvNJ09n7SaIVZb+bMp7rRhVnW+u2SBWqZ5kCfpt64
	z/0C3IHDa/XSJ91JIjFPoL6NpjzZYiKaZA==
X-Google-Smtp-Source: AGHT+IG6mC8Xc5CvvHZO5i23yCMnVmALzLLjUyYTrlRiEpPE306Oz2pzrzSr3Q2wbRNLdvDjdIsgjQarFpiidg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c40b:0:b0:565:9bee:22e0 with SMTP id
 j11-20020a81c40b000000b005659bee22e0mr318012ywi.0.1694534539160; Tue, 12 Sep
 2023 09:02:19 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:01 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-4-edumazet@google.com>
Subject: [PATCH net-next 03/14] ipv6: lockless IPV6_MULTICAST_HOPS implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This fixes data-races around np->mcast_hops,
and make IPV6_MULTICAST_HOPS lockless.

Note that np->mcast_hops is never negative,
thus can fit an u8 field instead of s16.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h            |  9 +--------
 include/net/ipv6.h              |  2 +-
 net/dccp/ipv6.c                 |  2 +-
 net/ipv6/ipv6_sockglue.c        | 28 +++++++++++++++-------------
 net/ipv6/tcp_ipv6.c             |  3 ++-
 net/netfilter/ipvs/ip_vs_sync.c |  2 +-
 6 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 68cf1ca949141e419abf2031db2b42105b821ab0..9cc278b5e4f42ce097e57ecd95a50479a947fd82 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -214,15 +214,8 @@ struct ipv6_pinfo {
 	__u32			frag_size;
 
 	s16			hop_limit;
+	u8			mcast_hops;
 
-#if defined(__BIG_ENDIAN_BITFIELD)
-	/* Packed in 16bits. */
-	__s16			mcast_hops:9;
-	__u16			__unused_2:7,
-#else
-	__u16			__unused_2:7;
-	__s16			mcast_hops:9;
-#endif
 	int			ucast_oif;
 	int			mcast_oif;
 
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 61007db0036482e27121747add0eec77f912b54a..0af1a7565a3602e4deb68762267cba454750341e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -909,7 +909,7 @@ static inline int ip6_sk_dst_hoplimit(struct ipv6_pinfo *np, struct flowi6 *fl6,
 	int hlimit;
 
 	if (ipv6_addr_is_multicast(&fl6->daddr))
-		hlimit = np->mcast_hops;
+		hlimit = READ_ONCE(np->mcast_hops);
 	else
 		hlimit = READ_ONCE(np->hop_limit);
 	if (hlimit < 0)
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 33f6ccf6ba77b9bcc24054b09857aaee4bb71acf..83617a16b98e70aa577c08a394df63e006e53e9e 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -676,7 +676,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo)
 			np->mcast_oif = inet6_iif(opt_skb);
 		if (np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim)
-			np->mcast_hops = ipv6_hdr(opt_skb)->hop_limit;
+			WRITE_ONCE(np->mcast_hops, ipv6_hdr(opt_skb)->hop_limit);
 		if (np->rxopt.bits.rxflow || np->rxopt.bits.rxtclass)
 			np->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(opt_skb));
 		if (np->repflow)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 755fac85a120de44272f685529b579e7118d306b..5fff19a87c75518358bae067dfeb227d6738bb03 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -431,6 +431,16 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet6_assign_bit(MC6_LOOP, sk, valbool);
 		return 0;
+	case IPV6_MULTICAST_HOPS:
+		if (sk->sk_type == SOCK_STREAM)
+			return retv;
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		if (val > 255 || val < -1)
+			return -EINVAL;
+		WRITE_ONCE(np->mcast_hops,
+			   val == -1 ? IPV6_DEFAULT_MCASTHOPS : val);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -751,16 +761,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-	case IPV6_MULTICAST_HOPS:
-		if (sk->sk_type == SOCK_STREAM)
-			break;
-		if (optlen < sizeof(int))
-			goto e_inval;
-		if (val > 255 || val < -1)
-			goto e_inval;
-		np->mcast_hops = (val == -1 ? IPV6_DEFAULT_MCASTHOPS : val);
-		retv = 0;
-		break;
 
 	case IPV6_UNICAST_IF:
 	{
@@ -1180,7 +1180,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 				put_cmsg(&msg, SOL_IPV6, IPV6_PKTINFO, sizeof(src_info), &src_info);
 			}
 			if (np->rxopt.bits.rxhlim) {
-				int hlim = np->mcast_hops;
+				int hlim = READ_ONCE(np->mcast_hops);
+
 				put_cmsg(&msg, SOL_IPV6, IPV6_HOPLIMIT, sizeof(hlim), &hlim);
 			}
 			if (np->rxopt.bits.rxtclass) {
@@ -1197,7 +1198,8 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 				put_cmsg(&msg, SOL_IPV6, IPV6_2292PKTINFO, sizeof(src_info), &src_info);
 			}
 			if (np->rxopt.bits.rxohlim) {
-				int hlim = np->mcast_hops;
+				int hlim = READ_ONCE(np->mcast_hops);
+
 				put_cmsg(&msg, SOL_IPV6, IPV6_2292HOPLIMIT, sizeof(hlim), &hlim);
 			}
 			if (np->rxopt.bits.rxflow) {
@@ -1349,7 +1351,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		if (optname == IPV6_UNICAST_HOPS)
 			val = READ_ONCE(np->hop_limit);
 		else
-			val = np->mcast_hops;
+			val = READ_ONCE(np->mcast_hops);
 
 		if (val < 0) {
 			rcu_read_lock();
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3a88545a265d6bd064ecc41d33c9541a75fe0f4d..54db5fab318bc68cf9efbe6f26dacba614fa8562 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1542,7 +1542,8 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 		if (np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo)
 			np->mcast_oif = tcp_v6_iif(opt_skb);
 		if (np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim)
-			np->mcast_hops = ipv6_hdr(opt_skb)->hop_limit;
+			WRITE_ONCE(np->mcast_hops,
+				   ipv6_hdr(opt_skb)->hop_limit);
 		if (np->rxopt.bits.rxflow || np->rxopt.bits.rxtclass)
 			np->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(opt_skb));
 		if (np->repflow)
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 3c2251cabd0439834ca0fc2b8bbf0ecc6cfe9266..df1b33b61059eef1e86baefc63e138108a50a081 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -1322,7 +1322,7 @@ static void set_mcast_ttl(struct sock *sk, u_char ttl)
 		struct ipv6_pinfo *np = inet6_sk(sk);
 
 		/* IPV6_MULTICAST_HOPS */
-		np->mcast_hops = ttl;
+		WRITE_ONCE(np->mcast_hops, ttl);
 	}
 #endif
 	release_sock(sk);
-- 
2.42.0.283.g2d96d420d3-goog



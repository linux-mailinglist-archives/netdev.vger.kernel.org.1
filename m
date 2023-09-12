Return-Path: <netdev+bounces-33305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A01FD79D5BA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A48D281BEB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6419BD8;
	Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2A19BD1
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D671705
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e857a3fd5so5666155276.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534547; x=1695139347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Go5+halomp0Z0L+lMJKDRIP5UMOR4Xlh0q3IxRvsj58=;
        b=henzFSaFrLkv+QnQZuZdHrbGL+OBcYTBRzRd476+hTgys209umVgQQvQg5VgIzCSWJ
         YAChh1SHxKRrDHMQu8yZVmFO3hanGxBeVMlukP4ib/uX7Iu3ic6F6Y1L2ypw7gZR3TVE
         7KVlPqY7C1v/Fosc2DTQuZdocL9Txr7yeu4tcx4JTGpX9oKucaer6wqn08iPItFx5bh9
         MV+Y5qBJdRYU87Lpx/8jRL2+aev26KUat5SzQ8hBXRR0nvX54gScYTh3p70bODt6NjWi
         Rjxvt63uW490Th0md+7MGMfSvI6M/C9UlWEgTGaEJKEH7mS0TtGm9L0+EQsLpSk0X1yd
         POHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534547; x=1695139347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go5+halomp0Z0L+lMJKDRIP5UMOR4Xlh0q3IxRvsj58=;
        b=J3eCFG779bH5K9cYfcd32uj946iyACDykLidfcBN+0RlqtJkytEMCIYI4hVXPA5+dr
         x8sFIips85qNeGpMDWPZLwqYZnhCc0LFbD/bJ/dtRHwAL9q63oKkrQkg9KR8QXjZxltC
         kk+VENnGqiFqiwWNygFi1PkTXIZ5Wx8mnOFDGXgR+3oMXLKf97rJG1vVJ9AZV36Ig77+
         V3rWGMeGKDq+YywQaGkmlRsJgmK/pY7v0qTlMUFudspdjiRaYZcm38lWeV8HPUtGgCm1
         vGTr2QA7wmEqZlepfDrkSgGJchkDuhaoKQg80ScnDeUkZsui/3OWDdX/p5OTjSjyENWx
         G7Rg==
X-Gm-Message-State: AOJu0YyIpgjGRGlN36w039KIdioF8fUEDaIuOt/6WfwNBBFiImbcIFsK
	Ls5QJ6zSi8exhSRWfwOG1oeRZ5u36NM5Bg==
X-Google-Smtp-Source: AGHT+IGsX3Jk6CYipHSnDi22JwQIArvC4tJKGSL4s2A6Z61vi3z0QV8ZJU2FB8R5maUmGgcBFXdwjc3Wt0R1rw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ce0e:0:b0:d7b:9fad:6b9e with SMTP id
 x14-20020a25ce0e000000b00d7b9fad6b9emr279243ybe.1.1694534547106; Tue, 12 Sep
 2023 09:02:27 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:06 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-9-edumazet@google.com>
Subject: [PATCH net-next 08/14] ipv6: lockless IPV6_AUTOFLOWLABEL implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move np->autoflowlabel and np->autoflowlabel_set in inet->inet_flags,
to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  2 --
 include/net/inet_sock.h  |  2 ++
 include/net/ipv6.h       |  2 +-
 net/ipv6/ip6_output.c    | 12 +++++-------
 net/ipv6/ipv6_sockglue.c | 11 +++++------
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index d88e91b7f0a319a816488025ef213c4fb90ed359..e3be5dc21b7d27080b398f1425bf11145896a4f3 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -253,8 +253,6 @@ struct ipv6_pinfo {
 						 * 100: prefer care-of address
 						 */
 				dontfrag:1,
-				autoflowlabel:1,
-				autoflowlabel_set:1,
 				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 97e70a97dae888e6ab93c6446f4f3ba58cd8583e..f1af64a4067310258a3bc45b84ad3fd093bddbab 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -271,6 +271,8 @@ enum {
 	INET_FLAGS_MC6_LOOP	= 20,
 	INET_FLAGS_RECVERR6_RFC4884 = 21,
 	INET_FLAGS_MC6_ALL	= 22,
+	INET_FLAGS_AUTOFLOWLABEL_SET = 23,
+	INET_FLAGS_AUTOFLOWLABEL = 24,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 0af1a7565a3602e4deb68762267cba454750341e..fe1978a288630a20ba03dc3a36e22938495082e4 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -428,7 +428,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 			   int flags);
 int ip6_flowlabel_init(void);
 void ip6_flowlabel_cleanup(void);
-bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np);
+bool ip6_autoflowlabel(struct net *net, const struct sock *sk);
 
 static inline void fl6_sock_release(struct ip6_flowlabel *fl)
 {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ab7ede4a731a96fe6dce3205df29b298c923acc7..47aa42f93ccda8b49ed6ecd7a7a07703ae147928 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -232,12 +232,11 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(ip6_output);
 
-bool ip6_autoflowlabel(struct net *net, const struct ipv6_pinfo *np)
+bool ip6_autoflowlabel(struct net *net, const struct sock *sk)
 {
-	if (!np->autoflowlabel_set)
+	if (!inet6_test_bit(AUTOFLOWLABEL_SET, sk))
 		return ip6_default_np_autolabel(net);
-	else
-		return np->autoflowlabel;
+	return inet6_test_bit(AUTOFLOWLABEL, sk);
 }
 
 /*
@@ -314,7 +313,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 		hlimit = ip6_dst_hoplimit(dst);
 
 	ip6_flow_hdr(hdr, tclass, ip6_make_flowlabel(net, skb, fl6->flowlabel,
-				ip6_autoflowlabel(net, np), fl6));
+				ip6_autoflowlabel(net, sk), fl6));
 
 	hdr->payload_len = htons(seg_len);
 	hdr->nexthdr = proto;
@@ -1938,7 +1937,6 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	struct sk_buff *skb, *tmp_skb;
 	struct sk_buff **tail_skb;
 	struct in6_addr *final_dst;
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6hdr *hdr;
 	struct ipv6_txoptions *opt = v6_cork->opt;
@@ -1981,7 +1979,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 
 	ip6_flow_hdr(hdr, v6_cork->tclass,
 		     ip6_make_flowlabel(net, skb, fl6->flowlabel,
-					ip6_autoflowlabel(net, np), fl6));
+					ip6_autoflowlabel(net, sk), fl6));
 	hdr->hop_limit = v6_cork->hop_limit;
 	hdr->nexthdr = proto;
 	hdr->saddr = fl6->saddr;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 7a181831f226c67813446145f8f58fa58908e3ae..d5d428a695f728d96a7d075d86f806cc3f926e0a 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -474,6 +474,10 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet6_assign_bit(MC6_ALL, sk, valbool);
 		return 0;
+	case IPV6_AUTOFLOWLABEL:
+		inet6_assign_bit(AUTOFLOWLABEL, sk, valbool);
+		inet6_set_bit(AUTOFLOWLABEL_SET, sk);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -970,11 +974,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		np->dontfrag = valbool;
 		retv = 0;
 		break;
-	case IPV6_AUTOFLOWLABEL:
-		np->autoflowlabel = valbool;
-		np->autoflowlabel_set = 1;
-		retv = 0;
-		break;
 	case IPV6_RECVFRAGSIZE:
 		np->rxopt.bits.recvfragsize = valbool;
 		retv = 0;
@@ -1447,7 +1446,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_AUTOFLOWLABEL:
-		val = ip6_autoflowlabel(sock_net(sk), np);
+		val = ip6_autoflowlabel(sock_net(sk), sk);
 		break;
 
 	case IPV6_RECVFRAGSIZE:
-- 
2.42.0.283.g2d96d420d3-goog



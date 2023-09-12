Return-Path: <netdev+bounces-33309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2679D5CF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56891C211C1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82D1DA4C;
	Tue, 12 Sep 2023 16:02:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E641DA44
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:32 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555A010E5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5924b2aac52so62414367b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534551; x=1695139351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIQDRNxWEYx1lcEte5i9942BDfHQeeghDPjGKktQw5E=;
        b=Hpa3r5R9FXzbRzrL1mqzPHjTsOormpemlsgSE/wpC1x3r0K7sGOr6KyShZTG6ZHnh0
         leLKF3P6MtJIHq20LkEWuKy93rEZYFvnpGXEsfWc9gaHbr3b7wka0QT5n2S10+ZY62v/
         7T3gkZmooUQW7ne6ZB59FnAg8gfp9r7F/PFHsIDXnIFr2CGAaEcS7KJzh5fTrbbQE3s4
         bQVIqVVwsT/7B/p5QcWuvKVNQ0rDdgKSR9IKO0y4mehQ8A2Pp7tmyfgfkIwLPSR+WFik
         a+pqWA5hjYSz4ARIj/MFjonn7oQQ9UbpoMvjEHsUu4/sHRuXbDbwgHbSX2VqGqhjoCBb
         TWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534551; x=1695139351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YIQDRNxWEYx1lcEte5i9942BDfHQeeghDPjGKktQw5E=;
        b=AfwrOmOxHjWRTo4RQEdQBtmMAP3HQmcvAelgiRtaQorQVsSqpxeCCiUy7mP0nHmHek
         ONGN+FtG4DROebDvW9/xdBj20G80p5ZDeklsqSe1iJywbEG5HNxTtjWjTzqL9cxQCV3h
         nLsaMAUVEuNo/1vPf1BOswffOtc9VWN/UAzQf3LYqY9e7aS4NM1Es4DvMJy24RLvFIos
         pRalYRRe4wvjGVIsPoxtpJWY4VwC8VmWZUGlc10Tl83JfJ11atN5eu4y7HUQ0WnjKyQl
         3sjhuJRAtfEsMBOfETj9AvWQMPxKquobubNAqAl3u6gPuFixDLtV7XJDLSwAKfIexAdm
         8GaQ==
X-Gm-Message-State: AOJu0YxSGBnIvjeYKe76SmXoYvV2nsHwLRvx4l36tA6hLF9KBz3+EUvl
	EqK0vc9+kd/BioZluLX5p5qPEfDC8IJ5Xg==
X-Google-Smtp-Source: AGHT+IHR0tgssNVl43T/NXsBNDESa5EWNK/8aWWaLgiI42EjcBi6JSplLdmwkvRVuc6STM6qVR9w/bM0hh/Wqg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7604:0:b0:58c:9db5:82e5 with SMTP id
 r4-20020a817604000000b0058c9db582e5mr355074ywc.3.1694534551601; Tue, 12 Sep
 2023 09:02:31 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:09 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-12-edumazet@google.com>
Subject: [PATCH net-next 11/14] ipv6: move np->repflow to atomic flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move np->repflow to inet->inet_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  1 -
 include/net/inet_sock.h  |  1 +
 net/dccp/ipv6.c          |  2 +-
 net/ipv6/af_inet6.c      |  3 ++-
 net/ipv6/ip6_flowlabel.c |  8 ++++----
 net/ipv6/tcp_ipv6.c      | 14 ++++++--------
 6 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 53f4f1b97a787ac01fc274a8057494a28fa270fd..e62413371ea40cbd9f13aa6ac6b6be41a6831237 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -244,7 +244,6 @@ struct ipv6_pinfo {
 
 	/* sockopt flags */
 	__u16			sndflow:1,
-				repflow:1,
 				pmtudisc:3,
 				padding:1,	/* 1 bit hole */
 				srcprefs:3,	/* 001: prefer temporary address
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 3b79bc759ff478f96d729f2669c6963bbe768ba1..5d61c7dc6577827740254f0e9aa288065f1bda7f 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -275,6 +275,7 @@ enum {
 	INET_FLAGS_AUTOFLOWLABEL = 24,
 	INET_FLAGS_DONTFRAG	= 25,
 	INET_FLAGS_RECVERR6	= 26,
+	INET_FLAGS_REPFLOW	= 27,
 };
 
 /* cmsg flags for inet */
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index e6c3d84c2b9ec2df9b89ab0879991b3b312d0b6f..d7e63eea705dfe5c40d374301f93987e1c34748b 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -679,7 +679,7 @@ static int dccp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 			WRITE_ONCE(np->mcast_hops, ipv6_hdr(opt_skb)->hop_limit);
 		if (np->rxopt.bits.rxflow || np->rxopt.bits.rxtclass)
 			np->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(opt_skb));
-		if (np->repflow)
+		if (inet6_test_bit(REPFLOW, sk))
 			np->flow_label = ip6_flowlabel(ipv6_hdr(opt_skb));
 		if (ipv6_opt_accepted(sk, opt_skb,
 				      &DCCP_SKB_CB(opt_skb)->header.h6)) {
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 372fb7b9112c8dfed09b6ddfdb37016a1a668494..48737363377fef32f471075fd3f000bc742fd4e4 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -220,7 +220,8 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	inet6_set_bit(MC6_LOOP, sk);
 	inet6_set_bit(MC6_ALL, sk);
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
-	np->repflow	= net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ESTABLISHED;
+	inet6_assign_bit(REPFLOW, sk, net->ipv6.sysctl.flowlabel_reflect &
+				     FLOWLABEL_REFLECT_ESTABLISHED);
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
 	sk->sk_txrehash = READ_ONCE(net->core.sysctl_txrehash);
 
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index b3ca4beb4405aa9dc4ce610abda9a46ac3ceb5fb..eca07e10e21fcf11b3a8ebe6353f38789b87bdaf 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -513,7 +513,7 @@ int ipv6_flowlabel_opt_get(struct sock *sk, struct in6_flowlabel_req *freq,
 		return 0;
 	}
 
-	if (np->repflow) {
+	if (inet6_test_bit(REPFLOW, sk)) {
 		freq->flr_label = np->flow_label;
 		return 0;
 	}
@@ -551,10 +551,10 @@ static int ipv6_flowlabel_put(struct sock *sk, struct in6_flowlabel_req *freq)
 	if (freq->flr_flags & IPV6_FL_F_REFLECT) {
 		if (sk->sk_protocol != IPPROTO_TCP)
 			return -ENOPROTOOPT;
-		if (!np->repflow)
+		if (!inet6_test_bit(REPFLOW, sk))
 			return -ESRCH;
 		np->flow_label = 0;
-		np->repflow = 0;
+		inet6_clear_bit(REPFLOW, sk);
 		return 0;
 	}
 
@@ -626,7 +626,7 @@ static int ipv6_flowlabel_get(struct sock *sk, struct in6_flowlabel_req *freq,
 
 		if (sk->sk_protocol != IPPROTO_TCP)
 			return -ENOPROTOOPT;
-		np->repflow = 1;
+		inet6_set_bit(REPFLOW, sk);
 		return 0;
 	}
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index b5954b136b57306429690594238f7a01b0cf15de..201caf88bb99e4ff87048fab3d89b6ea22269df3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -548,7 +548,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 				    &ireq->ir_v6_rmt_addr);
 
 		fl6->daddr = ireq->ir_v6_rmt_addr;
-		if (np->repflow && ireq->pktopts)
+		if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
 			fl6->flowlabel = ip6_flowlabel(ipv6_hdr(ireq->pktopts));
 
 		tclass = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflect_tos) ?
@@ -797,7 +797,7 @@ static void tcp_v6_init_req(struct request_sock *req,
 	    (ipv6_opt_accepted(sk_listener, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	     np->rxopt.bits.rxinfo ||
 	     np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
-	     np->rxopt.bits.rxohlim || np->repflow)) {
+	     np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listener))) {
 		refcount_inc(&skb->users);
 		ireq->pktopts = skb;
 	}
@@ -1055,10 +1055,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 	if (sk) {
 		oif = sk->sk_bound_dev_if;
 		if (sk_fullsock(sk)) {
-			const struct ipv6_pinfo *np = tcp_inet6_sk(sk);
-
 			trace_tcp_send_reset(sk, skb);
-			if (np->repflow)
+			if (inet6_test_bit(REPFLOW, sk))
 				label = ip6_flowlabel(ipv6h);
 			priority = sk->sk_priority;
 			txhash = sk->sk_txhash;
@@ -1247,7 +1245,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 		newnp->mcast_oif   = inet_iif(skb);
 		newnp->mcast_hops  = ip_hdr(skb)->ttl;
 		newnp->rcv_flowinfo = 0;
-		if (np->repflow)
+		if (inet6_test_bit(REPFLOW, sk))
 			newnp->flow_label = 0;
 
 		/*
@@ -1320,7 +1318,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	newnp->mcast_oif  = tcp_v6_iif(skb);
 	newnp->mcast_hops = ipv6_hdr(skb)->hop_limit;
 	newnp->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(skb));
-	if (np->repflow)
+	if (inet6_test_bit(REPFLOW, sk))
 		newnp->flow_label = ip6_flowlabel(ipv6_hdr(skb));
 
 	/* Set ToS of the new socket based upon the value of incoming SYN.
@@ -1546,7 +1544,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 				   ipv6_hdr(opt_skb)->hop_limit);
 		if (np->rxopt.bits.rxflow || np->rxopt.bits.rxtclass)
 			np->rcv_flowinfo = ip6_flowinfo(ipv6_hdr(opt_skb));
-		if (np->repflow)
+		if (inet6_test_bit(REPFLOW, sk))
 			np->flow_label = ip6_flowlabel(ipv6_hdr(opt_skb));
 		if (ipv6_opt_accepted(sk, opt_skb, &TCP_SKB_CB(opt_skb)->header.h6)) {
 			tcp_v6_restore_cb(opt_skb);
-- 
2.42.0.283.g2d96d420d3-goog



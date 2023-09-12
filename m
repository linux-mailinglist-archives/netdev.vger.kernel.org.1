Return-Path: <netdev+bounces-33308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941F279D5CA
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292A71C21049
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBBD19BD1;
	Tue, 12 Sep 2023 16:02:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3E31DA44
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:31 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20B10E5
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7edc01fdc9so5612723276.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534550; x=1695139350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysQgihV0//JudA26yKxZrS4Mtnoy+fgClTta7/QQJdM=;
        b=jKE3+KXRM9JOB6PLMpcm/GLlLo8v1E3XP44IPCG6pGFDacA8gamQWEv24y4E/jyCp+
         iFA2qzJPQQN1tanDpekrgnMnUSOBFqH5DSxQM1YSGxpjep1eLmITdC4YYH53N2FQBSU5
         Eiy0D/jlghTj3a5HIPRIz9JXifvfmdllVV/yBwAbATVQMNZMaVRZ1n0vIiMQMOn/6PFe
         iwsl9JJkb8X8xEFhVv83Y2vvo4Q6NPPvDHGcWKikIy/9DSAmCTZQF3cRWJRGTApoXOi+
         dBGL86YUFfeWwDzvhnlLq5NbqtF3mms59LJBm5XmxVkMxlywSMNokEsEOY9W2UhgyhpM
         La0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534550; x=1695139350;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysQgihV0//JudA26yKxZrS4Mtnoy+fgClTta7/QQJdM=;
        b=qZCvgRaIUfHMrKcDRONZcBG72HBNZznFlUS/FfgD83wjG0eoBFg1Y8/+AXBMmJOzZy
         g/JK7Wky/o1IywjyyGOTonT6sfyEN9x+Tt2xnaAduEQ1NXgcN1/9mwAMDO/oba2NR7Hu
         GHplvs0rhpc18UPmdOwD99xJndQjFT04KFdp7Q4gQ6GxmzM87Dn+p/dwTtnq+x/LZtHx
         odNboGgJHfr7Sijo22z6zikhKXvFYkk0dpZ2YBV3V37oODmlWRZicgzJhLhKa7OY34W+
         lMGg9j4/0JruGIVe0/lKsIoyGcVOLnQ/AVKVwpeZS1InCJvQmtYRETCNqv8FGRkO2sEt
         rtYA==
X-Gm-Message-State: AOJu0YwBWTEoKX88F+guO55CSfB+RLsKyqapG+0F4BXhJfdpinVPBjdF
	Hv1nuN2ifclDUkBYkb7Y/oJRD4r/bTkwOg==
X-Google-Smtp-Source: AGHT+IGDVXGHSGGmE+tLsKLaVVTHml/AhqgEN45t+hruvoHC8LdjrnPku7ZYztj+07aA1TD9bMcn8C2YAevqJg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:c7d1:0:b0:d7f:7561:925b with SMTP id
 w200-20020a25c7d1000000b00d7f7561925bmr275821ybe.2.1694534550129; Tue, 12 Sep
 2023 09:02:30 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:08 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-11-edumazet@google.com>
Subject: [PATCH net-next 10/14] ipv6: lockless IPV6_RECVERR implemetation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

np->recverr is moved to inet->inet_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  3 +--
 include/net/inet_sock.h  |  1 +
 include/net/ipv6.h       |  4 +---
 net/dccp/ipv6.c          |  2 +-
 net/ipv4/ping.c          |  2 +-
 net/ipv6/datagram.c      |  6 ++----
 net/ipv6/ipv6_sockglue.c | 17 ++++++++---------
 net/ipv6/raw.c           | 10 +++++-----
 net/ipv6/tcp_ipv6.c      |  2 +-
 net/ipv6/udp.c           |  6 +++---
 net/sctp/ipv6.c          |  4 +---
 11 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 57d563f1d4b1707264f0d79406c4c139cc0fa525..53f4f1b97a787ac01fc274a8057494a28fa270fd 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -243,8 +243,7 @@ struct ipv6_pinfo {
 	} rxopt;
 
 	/* sockopt flags */
-	__u16			recverr:1,
-	                        sndflow:1,
+	__u16			sndflow:1,
 				repflow:1,
 				pmtudisc:3,
 				padding:1,	/* 1 bit hole */
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index ac75324e9e1eafe68cee7b0581e472cbb4f49aa3..3b79bc759ff478f96d729f2669c6963bbe768ba1 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -274,6 +274,7 @@ enum {
 	INET_FLAGS_AUTOFLOWLABEL_SET = 23,
 	INET_FLAGS_AUTOFLOWLABEL = 24,
 	INET_FLAGS_DONTFRAG	= 25,
+	INET_FLAGS_RECVERR6	= 26,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index d2cf7e176f2b97dac957e65b75d5e69a39c546b5..51c94fddd8039f980eb5a14441936623fd9b7a5d 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1298,9 +1298,7 @@ static inline int ip6_sock_set_v6only(struct sock *sk)
 
 static inline void ip6_sock_set_recverr(struct sock *sk)
 {
-	lock_sock(sk);
-	inet6_sk(sk)->recverr = true;
-	release_sock(sk);
+	inet6_set_bit(RECVERR6, sk);
 }
 
 static inline int __ip6_sock_set_addr_preferences(struct sock *sk, int val)
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 83617a16b98e70aa577c08a394df63e006e53e9e..e6c3d84c2b9ec2df9b89ab0879991b3b312d0b6f 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -185,7 +185,7 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		goto out;
 	}
 
-	if (!sock_owned_by_user(sk) && np->recverr) {
+	if (!sock_owned_by_user(sk) && inet6_test_bit(RECVERR6, sk)) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	} else {
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 75e0aee35eb787a6c9f70394294b30490c980a64..bc01ad5fc01ab97f71f7704a671eaf644ec040be 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -581,7 +581,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 	 *	4.1.3.3.
 	 */
 	if ((family == AF_INET && !inet_test_bit(RECVERR, sk)) ||
-	    (family == AF_INET6 && !inet6_sk(sk)->recverr)) {
+	    (family == AF_INET6 && !inet6_test_bit(RECVERR6, sk))) {
 		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
 			goto out;
 	} else {
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index e81892814935fb3934fbf0e6f9defc702ec29152..74673a5eff319f23871e64584a33f5299fa7b521 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -305,11 +305,10 @@ static void ipv6_icmp_error_rfc4884(const struct sk_buff *skb,
 void ipv6_icmp_error(struct sock *sk, struct sk_buff *skb, int err,
 		     __be16 port, u32 info, u8 *payload)
 {
-	struct ipv6_pinfo *np  = inet6_sk(sk);
 	struct icmp6hdr *icmph = icmp6_hdr(skb);
 	struct sock_exterr_skb *serr;
 
-	if (!np->recverr)
+	if (!inet6_test_bit(RECVERR6, sk))
 		return;
 
 	skb = skb_clone(skb, GFP_ATOMIC);
@@ -344,12 +343,11 @@ EXPORT_SYMBOL_GPL(ipv6_icmp_error);
 
 void ipv6_local_error(struct sock *sk, int err, struct flowi6 *fl6, u32 info)
 {
-	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct sock_exterr_skb *serr;
 	struct ipv6hdr *iph;
 	struct sk_buff *skb;
 
-	if (!np->recverr)
+	if (!inet6_test_bit(RECVERR6, sk))
 		return;
 
 	skb = alloc_skb(sizeof(struct ipv6hdr), GFP_ATOMIC);
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 33dd4dd872e6bca2ee18a634283640007adcc692..ec10b45c49c15f9655466a529046f741f8b9fc69 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -481,6 +481,13 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 	case IPV6_DONTFRAG:
 		inet6_assign_bit(DONTFRAG, sk, valbool);
 		return 0;
+	case IPV6_RECVERR:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		inet6_assign_bit(RECVERR6, sk, valbool);
+		if (!val)
+			skb_errqueue_purge(&sk->sk_error_queue);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -943,14 +950,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		np->pmtudisc = val;
 		retv = 0;
 		break;
-	case IPV6_RECVERR:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		np->recverr = valbool;
-		if (!val)
-			skb_errqueue_purge(&sk->sk_error_queue);
-		retv = 0;
-		break;
 	case IPV6_FLOWINFO_SEND:
 		if (optlen < sizeof(int))
 			goto e_inval;
@@ -1380,7 +1379,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_RECVERR:
-		val = np->recverr;
+		val = inet6_test_bit(RECVERR6, sk);
 		break;
 
 	case IPV6_FLOWINFO_SEND:
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index cc9673c1809fb238f6d9ab6915116cf0dd6eb593..71f6bdccfa1f39290e1b573ff8c647d91fd007a4 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -291,6 +291,7 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 	       struct inet6_skb_parm *opt,
 	       u8 type, u8 code, int offset, __be32 info)
 {
+	bool recverr = inet6_test_bit(RECVERR6, sk);
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	int err;
 	int harderr;
@@ -300,7 +301,7 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 	   2. Socket is connected (otherwise the error indication
 	      is useless without recverr and error is hard.
 	 */
-	if (!np->recverr && sk->sk_state != TCP_ESTABLISHED)
+	if (!recverr && sk->sk_state != TCP_ESTABLISHED)
 		return;
 
 	harderr = icmpv6_err_convert(type, code, &err);
@@ -312,14 +313,14 @@ static void rawv6_err(struct sock *sk, struct sk_buff *skb,
 		ip6_sk_redirect(skb, sk);
 		return;
 	}
-	if (np->recverr) {
+	if (recverr) {
 		u8 *payload = skb->data;
 		if (!inet_test_bit(HDRINCL, sk))
 			payload += offset;
 		ipv6_icmp_error(sk, skb, err, 0, ntohl(info), payload);
 	}
 
-	if (np->recverr || harderr) {
+	if (recverr || harderr) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	}
@@ -587,7 +588,6 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 			struct flowi6 *fl6, struct dst_entry **dstp,
 			unsigned int flags, const struct sockcm_cookie *sockc)
 {
-	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipv6hdr *iph;
 	struct sk_buff *skb;
@@ -668,7 +668,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 error:
 	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
 error_check:
-	if (err == -ENOBUFS && !np->recverr)
+	if (err == -ENOBUFS && !inet6_test_bit(RECVERR6, sk))
 		err = 0;
 	return err;
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 54db5fab318bc68cf9efbe6f26dacba614fa8562..b5954b136b57306429690594238f7a01b0cf15de 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -508,7 +508,7 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 			tcp_ld_RTO_revert(sk, seq);
 	}
 
-	if (!sock_owned_by_user(sk) && np->recverr) {
+	if (!sock_owned_by_user(sk) && inet6_test_bit(RECVERR6, sk)) {
 		WRITE_ONCE(sk->sk_err, err);
 		sk_error_report(sk);
 	} else {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d904c5450a07bf1df10d94ee6bb9b2a8fb9381b5..65f6217d36cb7c862f1511a058a7a5973c40cef8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -619,7 +619,7 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		goto out;
 	}
 
-	if (!np->recverr) {
+	if (!inet6_test_bit(RECVERR6, sk)) {
 		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
 			goto out;
 	} else {
@@ -1281,7 +1281,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 send:
 	err = ip6_send_skb(skb);
 	if (err) {
-		if (err == -ENOBUFS && !inet6_sk(sk)->recverr) {
+		if (err == -ENOBUFS && !inet6_test_bit(RECVERR6, sk)) {
 			UDP6_INC_STATS(sock_net(sk),
 				       UDP_MIB_SNDBUFERRORS, is_udplite);
 			err = 0;
@@ -1606,7 +1606,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		up->pending = 0;
 
 	if (err > 0)
-		err = np->recverr ? net_xmit_errno(err) : 0;
+		err = inet6_test_bit(RECVERR6, sk) ? net_xmit_errno(err) : 0;
 	release_sock(sk);
 
 out:
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 43f2731bf590e5757b7ad2d3a92a12e4098e0d47..42b5b853ea01c767e1fe878772eeabe5c05adb6d 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -128,7 +128,6 @@ static void sctp_v6_err_handle(struct sctp_transport *t, struct sk_buff *skb,
 {
 	struct sctp_association *asoc = t->asoc;
 	struct sock *sk = asoc->base.sk;
-	struct ipv6_pinfo *np;
 	int err = 0;
 
 	switch (type) {
@@ -149,9 +148,8 @@ static void sctp_v6_err_handle(struct sctp_transport *t, struct sk_buff *skb,
 		break;
 	}
 
-	np = inet6_sk(sk);
 	icmpv6_err_convert(type, code, &err);
-	if (!sock_owned_by_user(sk) && np->recverr) {
+	if (!sock_owned_by_user(sk) && inet6_test_bit(RECVERR6, sk)) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	} else {
-- 
2.42.0.283.g2d96d420d3-goog



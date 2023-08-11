Return-Path: <netdev+bounces-26656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 170D477884F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B18B1C210C4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01C53A9;
	Fri, 11 Aug 2023 07:36:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1183C5394
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:29 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7830312B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589a45c1b0fso21827087b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739387; x=1692344187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRWyeSjBOXnE5S0I3kfZhyx8v+VjIdV7Vug1EFnyDWw=;
        b=6duQuizymVFwGNVi0BT29lj3KOWRSA97mP+r3wFvvQSWSGC9o9gj8u/XhpKFOV8rAS
         B2jBeFEwJDSn7NZhYms/Z+JkzQms4LuwHMQ1S9Pe/8hPfz9oq4IL63Yc0xDUW8y1Chp1
         QDganDwBjgiNuh51V2CFmweO/B7pDo+/anCzPR44YXqvgcjaKtQTPMcp4YScA7BTvhsR
         bQcHbc898AqttGujyENcBQkAG8Xj+JOi5RgCJEI4fRdbJtCNkPHGkgIyQ4d41CVQJRPA
         tr96RJF9Zm5/VkXu33pt/RwTCxfpOqbbs1AybCvS2F07fn4kCvdCqWSKEYJwcTJmLweI
         Wyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739387; x=1692344187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRWyeSjBOXnE5S0I3kfZhyx8v+VjIdV7Vug1EFnyDWw=;
        b=WcnFXUUETe+2+2mU+8leorXcCWLV0pq4JE6FnNb9Pn/od1cNU4SUNz0YqFVMl8zu4h
         K0UP/tbO7Tk4s7Apcs8zhSHmGzsX2mZSSiWLqWXdvgybyy05AfMAtDvRReWdH4cn+Sym
         LG3jMDJFW4gDd09OyYp2wCO0RnCGQvm5CmXh3plAeZRSMhJYjHk76+xAWR3Oh9qFHJVi
         XbE+kMFZZlfyYXFoiEeMzO0wT6W3Am+IW75nBvtTwEeTbBe8pvcFf7T1JoibvXZhyx2z
         xhVBIbkCSO5CX5RmLojWLF3qAJNBDDvBqifOOdodAJZeCEffho21VxI+6iK5JVTAJ3w8
         RkbQ==
X-Gm-Message-State: AOJu0YxrbrYTMbvGkWTEVgodroXSVk1J294V+JLlJ45FnViVznlr4JzR
	YUVEr4qsfGItbd8396e4Nt4vd3p9xPs/vg==
X-Google-Smtp-Source: AGHT+IEXCgWDigo7InCLwIua0gLpfd37JrksupUCACXaoTTFZMg/a+Jm1jfm8ly6Bg842cZb7hN2/mAVEG1jBA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ad15:0:b0:583:a3c1:6b5a with SMTP id
 l21-20020a81ad15000000b00583a3c16b5amr16460ywh.4.1691739387802; Fri, 11 Aug
 2023 00:36:27 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:09 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/15] inet: move inet->recverr to inet->inet_flags
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

IP_RECVERR socket option can now be set/get without locking the socket.

This patch potentially avoid data-races around inet->recverr.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h |  5 +++--
 net/dccp/ipv4.c         |  4 +---
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_sockglue.c  | 23 ++++++++++-------------
 net/ipv4/ping.c         |  2 +-
 net/ipv4/raw.c          | 14 ++++++++------
 net/ipv4/tcp_ipv4.c     |  5 ++---
 net/ipv4/udp.c          |  5 +++--
 net/sctp/input.c        |  2 +-
 9 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index e3b35b0015f335fefa350fd81797a9466ba32f32..552188aa5a2d2f968b1d95e963d48a063ec4fd59 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -230,8 +230,7 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			recverr:1,
-				is_icsk:1,
+	__u8			is_icsk:1,
 				freebind:1,
 				hdrincl:1,
 				mc_loop:1,
@@ -270,6 +269,8 @@ enum {
 	INET_FLAGS_ORIGDSTADDR	= 6,
 	INET_FLAGS_CHECKSUM	= 7,
 	INET_FLAGS_RECVFRAGSIZE	= 8,
+
+	INET_FLAGS_RECVERR	= 9,
 };
 
 /* cmsg flags for inet */
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 8e919cfe6e2333d066b0ce08b752c1c89dc8fe64..8dd6837c476a96071f39ef63b517a15b7b1e8cb0 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -247,7 +247,6 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	const u8 offset = iph->ihl << 2;
 	const struct dccp_hdr *dh;
 	struct dccp_sock *dp;
-	struct inet_sock *inet;
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
 	struct sock *sk;
@@ -361,8 +360,7 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	 *							--ANK (980905)
 	 */
 
-	inet = inet_sk(sk);
-	if (!sock_owned_by_user(sk) && inet->recverr) {
+	if (!sock_owned_by_user(sk) && inet_test_bit(RECVERR, sk)) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	} else { /* Only an error on timeout */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f7426926a10413b42ec3b99d97f59445b6d1becc..25d5f76b66bd82be2c2abc6bd5206ec54f736be6 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -182,7 +182,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	r->idiag_inode = sock_i_ino(sk);
 
 	memset(&inet_sockopt, 0, sizeof(inet_sockopt));
-	inet_sockopt.recverr	= inet->recverr;
+	inet_sockopt.recverr	= inet_test_bit(RECVERR, sk);
 	inet_sockopt.is_icsk	= inet->is_icsk;
 	inet_sockopt.freebind	= inet->freebind;
 	inet_sockopt.hdrincl	= inet->hdrincl;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 69b87518348aa5697edc6d88679384f00681f539..8283d862a9dbb5040db4e419e9dff31bbd3cff81 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -446,12 +446,11 @@ EXPORT_SYMBOL_GPL(ip_icmp_error);
 
 void ip_local_error(struct sock *sk, int err, __be32 daddr, __be16 port, u32 info)
 {
-	struct inet_sock *inet = inet_sk(sk);
 	struct sock_exterr_skb *serr;
 	struct iphdr *iph;
 	struct sk_buff *skb;
 
-	if (!inet->recverr)
+	if (!inet_test_bit(RECVERR, sk))
 		return;
 
 	skb = alloc_skb(sizeof(struct iphdr), GFP_ATOMIC);
@@ -617,9 +616,7 @@ EXPORT_SYMBOL(ip_sock_set_freebind);
 
 void ip_sock_set_recverr(struct sock *sk)
 {
-	lock_sock(sk);
-	inet_sk(sk)->recverr = true;
-	release_sock(sk);
+	inet_set_bit(RECVERR, sk);
 }
 EXPORT_SYMBOL(ip_sock_set_recverr);
 
@@ -978,6 +975,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet_assign_bit(RECVFRAGSIZE, sk, val);
 		return 0;
+	case IP_RECVERR:
+		inet_assign_bit(RECVERR, sk, val);
+		if (!val)
+			skb_queue_purge(&sk->sk_error_queue);
+		return 0;
 	}
 
 	err = 0;
@@ -1064,11 +1066,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->pmtudisc = val;
 		break;
-	case IP_RECVERR:
-		inet->recverr = !!val;
-		if (!val)
-			skb_queue_purge(&sk->sk_error_queue);
-		break;
 	case IP_RECVERR_RFC4884:
 		if (val < 0 || val > 1)
 			goto e_inval;
@@ -1575,6 +1572,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_RECVFRAGSIZE:
 		val = inet_test_bit(RECVFRAGSIZE, sk);
 		goto copyval;
+	case IP_RECVERR:
+		val = inet_test_bit(RECVERR, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1649,9 +1649,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		}
 		break;
 	}
-	case IP_RECVERR:
-		val = inet->recverr;
-		break;
 	case IP_RECVERR_RFC4884:
 		val = inet->recverr_rfc4884;
 		break;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 7e8702cb6634465f5e319a10e8f845093a354f47..75e0aee35eb787a6c9f70394294b30490c980a64 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -580,7 +580,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 	 *      RFC1122: OK.  Passes ICMP errors back to application, as per
 	 *	4.1.3.3.
 	 */
-	if ((family == AF_INET && !inet_sock->recverr) ||
+	if ((family == AF_INET && !inet_test_bit(RECVERR, sk)) ||
 	    (family == AF_INET6 && !inet6_sk(sk)->recverr)) {
 		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
 			goto out;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e6e813f4aa317c3a5f242776a889610ccc1aa72f..f4c27dc5714bd4be7bbd4a8e5b614c9426e6b987 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -203,8 +203,9 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 	struct inet_sock *inet = inet_sk(sk);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
-	int err = 0;
 	int harderr = 0;
+	bool recverr;
+	int err = 0;
 
 	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
 		ipv4_sk_update_pmtu(skb, sk, info);
@@ -218,7 +219,8 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 	   2. Socket is connected (otherwise the error indication
 	      is useless without ip_recverr and error is hard.
 	 */
-	if (!inet->recverr && sk->sk_state != TCP_ESTABLISHED)
+	recverr = inet_test_bit(RECVERR, sk);
+	if (!recverr && sk->sk_state != TCP_ESTABLISHED)
 		return;
 
 	switch (type) {
@@ -245,7 +247,7 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 		}
 	}
 
-	if (inet->recverr) {
+	if (recverr) {
 		const struct iphdr *iph = (const struct iphdr *)skb->data;
 		u8 *payload = skb->data + (iph->ihl << 2);
 
@@ -254,7 +256,7 @@ static void raw_err(struct sock *sk, struct sk_buff *skb, u32 info)
 		ip_icmp_error(sk, skb, err, 0, info, payload);
 	}
 
-	if (inet->recverr || harderr) {
+	if (recverr || harderr) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	}
@@ -413,7 +415,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	kfree_skb(skb);
 error:
 	IP_INC_STATS(net, IPSTATS_MIB_OUTDISCARDS);
-	if (err == -ENOBUFS && !inet->recverr)
+	if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
 		err = 0;
 	return err;
 }
@@ -645,7 +647,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			ip_flush_pending_frames(sk);
 		else if (!(msg->msg_flags & MSG_MORE)) {
 			err = ip_push_pending_frames(sk, &fl4);
-			if (err == -ENOBUFS && !inet->recverr)
+			if (err == -ENOBUFS && !inet_test_bit(RECVERR, sk))
 				err = 0;
 		}
 		release_sock(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5b18a048f613e9ab2807c4774882df6320754a8d..2a662d5f3072f5eef5398314ac9a91703ac816bb 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -477,7 +477,6 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct tcphdr *th = (struct tcphdr *)(skb->data + (iph->ihl << 2));
 	struct tcp_sock *tp;
-	struct inet_sock *inet;
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
 	struct sock *sk;
@@ -625,8 +624,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 	 *							--ANK (980905)
 	 */
 
-	inet = inet_sk(sk);
-	if (!sock_owned_by_user(sk) && inet->recverr) {
+	if (!sock_owned_by_user(sk) &&
+	    inet_test_bit(RECVERR, sk)) {
 		WRITE_ONCE(sk->sk_err, err);
 		sk_error_report(sk);
 	} else	{ /* Only an error on timeout */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 4b791133989c0abe4f869ef0c56649c9d671db1a..0794a2c46a568d644cc488c1d7f6ee676180a5bd 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -779,7 +779,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 						  (u8 *)(uh+1));
 		goto out;
 	}
-	if (!inet->recverr) {
+	if (!inet_test_bit(RECVERR, sk)) {
 		if (!harderr || sk->sk_state != TCP_ESTABLISHED)
 			goto out;
 	} else
@@ -962,7 +962,8 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 send:
 	err = ip_send_skb(sock_net(sk), skb);
 	if (err) {
-		if (err == -ENOBUFS && !inet->recverr) {
+		if (err == -ENOBUFS &&
+		    !inet_test_bit(RECVERR, sk)) {
 			UDP_INC_STATS(sock_net(sk),
 				      UDP_MIB_SNDBUFERRORS, is_udplite);
 			err = 0;
diff --git a/net/sctp/input.c b/net/sctp/input.c
index 2613c4d74b1699aad9e480663600841059fc0d6b..17fcaa9b0df9452bbfe7c3bb4b2d300e6ca6ce40 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -581,7 +581,7 @@ static void sctp_v4_err_handle(struct sctp_transport *t, struct sk_buff *skb,
 	default:
 		return;
 	}
-	if (!sock_owned_by_user(sk) && inet_sk(sk)->recverr) {
+	if (!sock_owned_by_user(sk) && inet_test_bit(RECVERR, sk)) {
 		sk->sk_err = err;
 		sk_error_report(sk);
 	} else {  /* Only an error on timeout */
-- 
2.41.0.640.ga95def55d0-goog



Return-Path: <netdev+bounces-26658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7A7778852
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D45282040
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F6B53A7;
	Fri, 11 Aug 2023 07:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0735663
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:32 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5E412B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6412374defso1506509276.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739391; x=1692344191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyxn5b3TIfafD38S7S6Mn57Wq2E43yuHlDpiSSe5C5Y=;
        b=bK6Musd5gVwdfglF0u3yrNHAyZufA7YdIlcxI/TnXoZ8LlgRqqrUvsx5NxDrqT91DZ
         cbsBhqBu3+2KlANnlSV4kVT4qjeSR+9ruFIunWyQlCvsTsx1dlHMyGyyWqwrgtKCSXQn
         o8h0Gj5hhyDr2az2lGQnmXpDVlBMAcc3YPiBHxxJdCx1Wps8r6xfPcSuqoOzK/qolZZZ
         gkG/wvWUBGvoQzF7eoRpknu5CskCIf8o5wxezRl/AXJc+dLxH3FUTbJy+5N9t4Va0gBX
         iixSYjTmGIKqNFslZRLFjvzlyRhMs9jzqxrkSv+UT8qDv+T1u3BvYQ1j7yGttnWzeYh1
         IQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739391; x=1692344191;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gyxn5b3TIfafD38S7S6Mn57Wq2E43yuHlDpiSSe5C5Y=;
        b=bbf9/8eRKy4FXNEB9tm6d2Y+xGyrGRuSEhmix0R9sEsfVj2hE0iYUV3nrPF9f7A3PK
         sI77Hnn3njU2/CyMAuqf1eMrlj6oaHRCiSiQuuheWXj4BAyqVSyLVU0q1hjAsv3mUTMa
         pSuz0atrWcWghU7DDmnsoT9e85h6uTG3WggUySm0Ul4vsBoo7QwwRdWJ73ADMbOf0orS
         71ifzEfED9Hhpj6Z1jUi20zZ1FfGPq7DatfkGteZJp8avhY5AyrqsoDlQSFJSiI199ab
         G5ZjtKGGVmvuhOfJkY0h3BcQlHEwaVCEPPAQ2D2htUAhZSCvIjboFbQhVOJ04nAMbcQA
         fAIg==
X-Gm-Message-State: AOJu0Yxj6M0QFKjyo7iE+yhaH/q2jq4gt2yjn38FXYvVlTJsxVwXhj3R
	viaU8wUrCWGAVhnY3KqGubTsRtLjH2FHwg==
X-Google-Smtp-Source: AGHT+IFMgg6tybo3HYLMNTce+1Y/PR9hGOnuiRdMVl3p2gJEBSL8clXTD4/ntLpJEYRqdmPTjbRQjB1ksT2kdQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:4c7:b0:d0f:a0a6:8e87 with SMTP
 id v7-20020a05690204c700b00d0fa0a68e87mr13710ybs.2.1691739390824; Fri, 11 Aug
 2023 00:36:30 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:11 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/15] inet: move inet->freebind to inet->inet_flags
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

IP_FREEBIND socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h  |  5 +++--
 include/net/ipv6.h       |  3 ++-
 net/ipv4/inet_diag.c     |  2 +-
 net/ipv4/ip_sockglue.c   | 21 +++++++++------------
 net/ipv6/ipv6_sockglue.c |  4 ++--
 net/mptcp/sockopt.c      |  8 +++++---
 net/sctp/protocol.c      |  2 +-
 7 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index c01f1f64a8617582c68079048f74e0db606e1834..d6ba963534b4a5aa5dc6f88b94dd36f260be765b 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -231,7 +231,6 @@ struct inet_sock {
 	__u8			mc_ttl;
 	__u8			pmtudisc;
 	__u8			is_icsk:1,
-				freebind:1,
 				hdrincl:1,
 				mc_loop:1,
 				transparent:1,
@@ -271,6 +270,7 @@ enum {
 
 	INET_FLAGS_RECVERR	= 9,
 	INET_FLAGS_RECVERR_RFC4884 = 10,
+	INET_FLAGS_FREEBIND	= 11,
 };
 
 /* cmsg flags for inet */
@@ -423,7 +423,8 @@ static inline bool inet_can_nonlocal_bind(struct net *net,
 					  struct inet_sock *inet)
 {
 	return READ_ONCE(net->ipv4.sysctl_ip_nonlocal_bind) ||
-		inet->freebind || inet->transparent;
+		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
+		inet->transparent;
 }
 
 static inline bool inet_addr_valid_or_nonlocal(struct net *net,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 2acc4c808d45d1c1bb1c5076e79842e136203e4c..5f513503e7d568c189a7b14439612f4e27ba539b 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -937,7 +937,8 @@ static inline bool ipv6_can_nonlocal_bind(struct net *net,
 					  struct inet_sock *inet)
 {
 	return net->ipv6.sysctl.ip_nonlocal_bind ||
-		inet->freebind || inet->transparent;
+		test_bit(INET_FLAGS_FREEBIND, &inet->inet_flags) ||
+		inet->transparent;
 }
 
 /* Sysctl settings for net ipv6.auto_flowlabels */
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 6255d6fdbc80d82904583a8fc6c439a25e875a0b..5a96f4f28eca6ae6e84cb3761531309e8da0be09 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -184,7 +184,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	memset(&inet_sockopt, 0, sizeof(inet_sockopt));
 	inet_sockopt.recverr	= inet_test_bit(RECVERR, sk);
 	inet_sockopt.is_icsk	= inet->is_icsk;
-	inet_sockopt.freebind	= inet->freebind;
+	inet_sockopt.freebind	= inet_test_bit(FREEBIND, sk);
 	inet_sockopt.hdrincl	= inet->hdrincl;
 	inet_sockopt.mc_loop	= inet->mc_loop;
 	inet_sockopt.transparent = inet->transparent;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index f75f44ad7b11ac169b343b3c26d744cdc81d747c..6af84310631288c07f26c19734c5abc0fd82dc23 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -608,9 +608,7 @@ EXPORT_SYMBOL(ip_sock_set_tos);
 
 void ip_sock_set_freebind(struct sock *sk)
 {
-	lock_sock(sk);
-	inet_sk(sk)->freebind = true;
-	release_sock(sk);
+	inet_set_bit(FREEBIND, sk);
 }
 EXPORT_SYMBOL(ip_sock_set_freebind);
 
@@ -985,6 +983,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet_assign_bit(RECVERR_RFC4884, sk, val);
 		return 0;
+	case IP_FREEBIND:
+		if (optlen < 1)
+			return -EINVAL;
+		inet_assign_bit(FREEBIND, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1310,12 +1313,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		inet->mc_all = val;
 		break;
 
-	case IP_FREEBIND:
-		if (optlen < 1)
-			goto e_inval;
-		inet->freebind = !!val;
-		break;
-
 	case IP_IPSEC_POLICY:
 	case IP_XFRM_POLICY:
 		err = -EPERM;
@@ -1578,6 +1575,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_RECVERR_RFC4884:
 		val = inet_test_bit(RECVERR_RFC4884, sk);
 		goto copyval;
+	case IP_FREEBIND:
+		val = inet_test_bit(FREEBIND, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1737,9 +1737,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		len -= msg.msg_controllen;
 		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
-	case IP_FREEBIND:
-		val = inet->freebind;
-		break;
 	case IP_TRANSPARENT:
 		val = inet->transparent;
 		break;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index ca377159967c8aa9c18a80f9b189f4ef41398d01..3eb38436f8d431ca37200869bfe57ec33b46bf8b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -641,7 +641,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		if (optlen < sizeof(int))
 			goto e_inval;
 		/* we also don't have a separate freebind bit for IPV6 */
-		inet_sk(sk)->freebind = valbool;
+		inet_assign_bit(FREEBIND, sk, valbool);
 		retv = 0;
 		break;
 
@@ -1334,7 +1334,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_FREEBIND:
-		val = inet_sk(sk)->freebind;
+		val = inet_test_bit(FREEBIND, sk);
 		break;
 
 	case IPV6_RECVORIGDSTADDR:
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index a3f1fe810cc961bf689fe8edda49d227a3170f91..1f3331f9f7c85f3b2a1e8dc03cf80be73af4ed0d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -419,7 +419,8 @@ static int mptcp_setsockopt_v6(struct mptcp_sock *msk, int optname,
 			inet_sk(sk)->transparent = inet_sk(ssock->sk)->transparent;
 			break;
 		case IPV6_FREEBIND:
-			inet_sk(sk)->freebind = inet_sk(ssock->sk)->freebind;
+			inet_assign_bit(FREEBIND, sk,
+					inet_test_bit(FREEBIND, ssock->sk));
 			break;
 		}
 
@@ -704,7 +705,8 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 
 	switch (optname) {
 	case IP_FREEBIND:
-		issk->freebind = inet_sk(sk)->freebind;
+		inet_assign_bit(FREEBIND, ssock->sk,
+				inet_test_bit(FREEBIND, sk));
 		break;
 	case IP_TRANSPARENT:
 		issk->transparent = inet_sk(sk)->transparent;
@@ -1442,7 +1444,7 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	__tcp_sock_set_nodelay(ssk, !!msk->nodelay);
 
 	inet_sk(ssk)->transparent = inet_sk(sk)->transparent;
-	inet_sk(ssk)->freebind = inet_sk(sk)->freebind;
+	inet_assign_bit(FREEBIND, ssk, inet_test_bit(FREEBIND, sk));
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 33c0895e101c08d042f16adad7d6ea5ff2bc05c0..2185f44198deb002bc8ed7f1b0f3fe02d6bb9f09 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -360,7 +360,7 @@ static int sctp_v4_available(union sctp_addr *addr, struct sctp_sock *sp)
 	ret = inet_addr_type_table(net, addr->v4.sin_addr.s_addr, tb_id);
 	if (addr->v4.sin_addr.s_addr != htonl(INADDR_ANY) &&
 	   ret != RTN_LOCAL &&
-	   !sp->inet.freebind &&
+	   !inet_test_bit(FREEBIND, sk) &&
 	    !READ_ONCE(net->ipv4.sysctl_ip_nonlocal_bind))
 		return 0;
 
-- 
2.41.0.640.ga95def55d0-goog



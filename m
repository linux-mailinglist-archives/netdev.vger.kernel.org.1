Return-Path: <netdev+bounces-27028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2263779E9D
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44381C2037B
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FC3186F;
	Sat, 12 Aug 2023 09:34:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C7846F
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:34:02 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B421DA
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589cd098d24so12244447b3.0
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832840; x=1692437640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc6VKNSAckgNWZosN6mMNxyNHjiECRk8cLPId5XK1EI=;
        b=GdXNfqtZHyLmxq4F+r+lCdNp0j1wOONgGkdy7054IAlKL7vLGkvGth9O/UUi4lnrIc
         la0ZOruWGF4S+Pn0RY8N2IsP8nF16Lcumuo5z4fxet+YMGURsPYNsVd/Lb821mDYZ+za
         E+v9iZnv39m2OgSlJ3dcZnCUy+OIsdSmCZexlEagePGPIe2fTcbGm4rAKTzRAnE7KrrH
         pCBp5YO5yf2qACJniMHPqek+Zzu7IgEL9kRyR8BZXVTWKHv60LwIwmUV1vMh87puuPnE
         ymKhc4Uh+hEh/HFabSnys5SDdSTMYpFwJajsB1dBWQLDGhcNtD+HifBRu/e42M4xl9tO
         8YRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832840; x=1692437640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zc6VKNSAckgNWZosN6mMNxyNHjiECRk8cLPId5XK1EI=;
        b=aMjMaQWz76jB/75Ey/E3zit0tAheUlfjOZzuT9B2Ouy5mPEEhcE5/+wvMeKfgDXp6t
         3rJOdli6l4GhLeOML00hNwqqJPWsxXBK19FK2tSJgTpouGs/mu9s+PRgtknf2r95l8Gv
         WlzhbIPgtNSw5hl0m19J2d8oeQmWZmzQY70siZ3LptTOjPMm6qmsDqtOc4p4DK2hxOR3
         qTss57DZJSqps2fEeRL9l7X85I7TlbpAB0Bx6zrzB2WHtPWjcJ0LwX7yzYZTRlBkC49A
         r6Tst2RhEW0NlX/Awocx4f57iJ5S0oufyOkBfXCpYZaJ05XO1HhRVhINnCH4bbccuRag
         FPOg==
X-Gm-Message-State: AOJu0YxMcjn5fgGZjDeKmUTKYIBrw3L+SeX+jaOE7dvwU7crKafzqZGM
	h04IJe+r/7BnZxbAPudwTbTkHNj4xWaPeA==
X-Google-Smtp-Source: AGHT+IF8gAZQLGLuoiJTiEfA4sVFW47cbjxB8dxYs1XjZkDxofOFAwM0b5sJ1HqYpl+fCM9ne1dVbCrtU9LtgA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b71d:0:b0:584:6210:2e42 with SMTP id
 v29-20020a81b71d000000b0058462102e42mr68388ywh.4.1691832840532; Sat, 12 Aug
 2023 02:34:00 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:39 +0000
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812093344.3561556-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-11-edumazet@google.com>
Subject: [PATCH v3 net-next 10/15] inet: move inet->is_icsk to inet->inet_flags
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

We move single bit fields to inet->inet_flags to avoid races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_connection_sock.h | 4 ++--
 include/net/inet_sock.h            | 5 ++---
 net/ipv4/af_inet.c                 | 2 +-
 net/ipv4/cipso_ipv4.c              | 4 ++--
 net/ipv4/inet_diag.c               | 2 +-
 net/ipv4/ip_sockglue.c             | 4 ++--
 net/ipv6/af_inet6.c                | 2 +-
 net/ipv6/ipv6_sockglue.c           | 4 ++--
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c2b15f7e551617b06863a3b52056348d9c53bb12..7402918b015636bd668ae4ebb53b3f73d1cd34a6 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -341,9 +341,9 @@ static inline bool inet_csk_in_pingpong_mode(struct sock *sk)
 	return inet_csk(sk)->icsk_ack.pingpong >= TCP_PINGPONG_THRESH;
 }
 
-static inline bool inet_csk_has_ulp(struct sock *sk)
+static inline bool inet_csk_has_ulp(const struct sock *sk)
 {
-	return inet_sk(sk)->is_icsk && !!inet_csk(sk)->icsk_ulp_ops;
+	return inet_test_bit(IS_ICSK, sk) && !!inet_csk(sk)->icsk_ulp_ops;
 }
 
 #endif /* _INET_CONNECTION_SOCK_H */
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index cefd9a60dc6d8432cc685716c2e556be7a7dc2ec..38f7fc1c4dacfb4ecacbbb38ae484ed06f2638e2 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -201,7 +201,6 @@ struct rtable;
  * @inet_id - ID counter for DF pkts
  * @tos - TOS
  * @mc_ttl - Multicasting TTL
- * @is_icsk - is this an inet_connection_sock?
  * @uc_index - Unicast outgoing device index
  * @mc_index - Multicast device index
  * @mc_list - Group array
@@ -230,8 +229,7 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			is_icsk:1,
-				nodefrag:1;
+	__u8			nodefrag:1;
 	__u8			bind_address_no_port:1,
 				defer_connect:1; /* Indicates that fastopen_connect is set
 						  * and cookie exists so we defer connect
@@ -271,6 +269,7 @@ enum {
 	INET_FLAGS_MC_LOOP	= 13,
 	INET_FLAGS_MC_ALL	= 14,
 	INET_FLAGS_TRANSPARENT	= 15,
+	INET_FLAGS_IS_ICSK	= 16,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c15aae4a386097b66a8908e2dcf23c549200e86f..7655574b2de152fad70b258e779fcdadfb283f32 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -325,7 +325,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 		sk->sk_reuse = SK_CAN_REUSE;
 
 	inet = inet_sk(sk);
-	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
+	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
 	inet->nodefrag = 0;
 
diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
index 79ae7204e8edb973764e53349d3270dda78e18c4..d048aa83329386b0bbe4c68d4dee2c86871f8efb 100644
--- a/net/ipv4/cipso_ipv4.c
+++ b/net/ipv4/cipso_ipv4.c
@@ -1881,7 +1881,7 @@ int cipso_v4_sock_setattr(struct sock *sk,
 
 	old = rcu_dereference_protected(sk_inet->inet_opt,
 					lockdep_sock_is_held(sk));
-	if (sk_inet->is_icsk) {
+	if (inet_test_bit(IS_ICSK, sk)) {
 		sk_conn = inet_csk(sk);
 		if (old)
 			sk_conn->icsk_ext_hdr_len -= old->opt.optlen;
@@ -2051,7 +2051,7 @@ void cipso_v4_sock_delattr(struct sock *sk)
 	sk_inet = inet_sk(sk);
 
 	hdr_delta = cipso_v4_delopt(&sk_inet->inet_opt);
-	if (sk_inet->is_icsk && hdr_delta > 0) {
+	if (inet_test_bit(IS_ICSK, sk) && hdr_delta > 0) {
 		struct inet_connection_sock *sk_conn = inet_csk(sk);
 		sk_conn->icsk_ext_hdr_len -= hdr_delta;
 		sk_conn->icsk_sync_mss(sk, sk_conn->icsk_pmtu_cookie);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 45fefd2f31fd7b921d796b0317b72b8858ca9c5b..ada198fc1a92bfbaa1abe691da24489edf281f22 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -183,7 +183,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 
 	memset(&inet_sockopt, 0, sizeof(inet_sockopt));
 	inet_sockopt.recverr	= inet_test_bit(RECVERR, sk);
-	inet_sockopt.is_icsk	= inet->is_icsk;
+	inet_sockopt.is_icsk	= inet_test_bit(IS_ICSK, sk);
 	inet_sockopt.freebind	= inet_test_bit(FREEBIND, sk);
 	inet_sockopt.hdrincl	= inet_test_bit(HDRINCL, sk);
 	inet_sockopt.mc_loop	= inet_test_bit(MC_LOOP, sk);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 3f5323a230b3d84048838cb03d648b213bd95fab..dac471ed067b4ba276fc0a9379750df54ea8987c 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1034,7 +1034,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			break;
 		old = rcu_dereference_protected(inet->inet_opt,
 						lockdep_sock_is_held(sk));
-		if (inet->is_icsk) {
+		if (inet_test_bit(IS_ICSK, sk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (sk->sk_family == PF_INET ||
@@ -1209,7 +1209,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		struct ip_mreqn mreq;
 
 		err = -EPROTO;
-		if (inet_sk(sk)->is_icsk)
+		if (inet_test_bit(IS_ICSK, sk))
 			break;
 
 		if (optlen < sizeof(struct ip_mreq))
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 4a34a4ba62b229991307ebed74ac7cd9f3a943ba..fea7918ad6ef351afc6bfb45d54aae8d658d4b55 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -200,7 +200,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 		sk->sk_reuse = SK_CAN_REUSE;
 
 	inet = inet_sk(sk);
-	inet->is_icsk = (INET_PROTOSW_ICSK & answer_flags) != 0;
+	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
 	if (SOCK_RAW == sock->type) {
 		inet->inet_num = protocol;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index eb334122512c2a7b41dc5f6bc83aaa3c2b946a06..d19577a94bcc6120e85dafb2768521e6567c0511 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -102,7 +102,7 @@ int ip6_ra_control(struct sock *sk, int sel)
 struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 					   struct ipv6_txoptions *opt)
 {
-	if (inet_sk(sk)->is_icsk) {
+	if (inet_test_bit(IS_ICSK, sk)) {
 		if (opt &&
 		    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) &&
 		    inet_sk(sk)->inet_daddr != LOOPBACK4_IPV6) {
@@ -831,7 +831,7 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 
 		retv = -EPROTO;
-		if (inet_sk(sk)->is_icsk)
+		if (inet_test_bit(IS_ICSK, sk))
 			break;
 
 		retv = -EFAULT;
-- 
2.41.0.640.ga95def55d0-goog



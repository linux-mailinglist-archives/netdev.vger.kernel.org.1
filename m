Return-Path: <netdev+bounces-27955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15D77DBFF
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307BE28182E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09261F9ED;
	Wed, 16 Aug 2023 08:16:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E917FFBEE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:09 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69049AB
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589e3ac6d76so48593257b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173767; x=1692778567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B3xUmMooQLn9dBdjG4tSQDo4hLXNCKYOHNFlElyc5gw=;
        b=yp1cH+bXGdViUGLBEiTu6kmSY9cT/dBDGNTaACaD/yaF7fw78NW8PX6mbTQwC56S7h
         hLTWAppZWiQL8B53sXHTu+PkANKU0V+qt4yYOPv2Tij5xWKmizSgk3q3lb4xPCH9K4xl
         6I8+/Gac3mNaeTHyfBJZ0SCZbTjo76NiiGDyHJumPTwbRJD405352r9WtXH9GMuiGKCG
         wpeUwnHphjTnp1TVI8i433Im4hbReGmZgJu4g2tAixuF1y0e3PcZOnskaiBy79d4/cSF
         cLN8Sj6LR+vYjYoGm0OouBEFOOOh3NTyj2d4kxgWYfowqohZGVCr5g3TP1pqhAdrRxRX
         4IsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173767; x=1692778567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3xUmMooQLn9dBdjG4tSQDo4hLXNCKYOHNFlElyc5gw=;
        b=OYZcuYKbhX8t/TsEwiTFBjVYydeEHEZ1Rg/g5Q7+K3HNCO2PC/PHfbu0Tw1PzCgy/P
         nsPQaPsg+ZVsMxuTCSqgcINqm8aQoQec6/sig+jcjCQBHX5coOKP2DFFCO2jVrJ6xS6V
         4QX+hy3j+1Y0e8ikAtyw5EDJGQBxOJYDezPbZCU9tqdhXs/W7RgyXLDdt7dqp1mvAEnH
         qSyTlihJwObw9QOhoQL/YDrg6EAsMMvnT2BjeB58n1WtRIgO4B4vsRR9wpCg0P5h4uAv
         W30tKcKa8HcwZHRAAuOb/ZPuZfUgOmq2P6VlHdTPMvE4qQaxKn6rrYVTo6Y8sXtdemEY
         LIcg==
X-Gm-Message-State: AOJu0Yy/nEHdkSNhDjkNLGn5okm9VSxeQYV1NxjGllu4Lou4R7rDKT7O
	ldefgKF3LPbVUcb01zIYOJpFy6c8YbNPvg==
X-Google-Smtp-Source: AGHT+IHdxEuuMvOxzPZkTrj+/JsUqUsiJQ1tPS5tkyUeFDb0gpIyXSvrl9xh3GT4Exzrwt2aEp77GdPtMnfxdg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ae48:0:b0:576:f61f:adbc with SMTP id
 g8-20020a81ae48000000b00576f61fadbcmr11004ywk.1.1692173767728; Wed, 16 Aug
 2023 01:16:07 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:42 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-11-edumazet@google.com>
Subject: [PATCH v4 net-next 10/15] inet: move inet->is_icsk to inet->inet_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We move single bit fields to inet->inet_flags to avoid races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
index be3c858a2ebb7ec9f3e7ec956c9d0d9020642d9c..5d2fcc137b8814bf43eb72b1159446093f7da755 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -342,9 +342,9 @@ static inline bool inet_csk_in_pingpong_mode(struct sock *sk)
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
index 47c9cdd7687f96356eec251f9bc38d1b327b5375..0f46b71f8a9899c64fb3ffcb80ec88c3a90868e2 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -331,7 +331,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
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
index 8e9d4c1f0e837cb0ba32af244576461c90d9d97a..d8c56c7aba96082976d7cf8dc26ab369a10549ca 100644
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
2.41.0.694.ge786442a9b-goog



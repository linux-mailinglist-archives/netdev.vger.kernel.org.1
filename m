Return-Path: <netdev+bounces-27956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B06577DC01
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F31C208DC
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5321FBFD;
	Wed, 16 Aug 2023 08:16:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F2FBEE
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:11 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE0E94
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so6883550276.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173769; x=1692778569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMECegR8LhaLV5eklOXB1c4J9xFTRtVRaQnWpzPocz0=;
        b=ZDrJb9I7kUrQv0+zAKg1NS+Wtd+nNJsgG05QYEeFDhSpiTOGo5NkSgvTPZwCFnzo3U
         Pi7TwneplqyJUYiHvfYkuaKRkPHRaftGP/qQzsiqjN3LQ9Psdxhm1VzP3nKV6aniUl1I
         eZBXaT5Knn63A1Ybpv3Vs3sZVn+BRpSdyyKADKwJnEx4ipyFCzQrsYM/Twgm5ym2qilx
         t17Bakw613acTxZxZDwpnRBWxWAPuJQno5dLXM7EgVFsP6nTraIHm9jBX923XucX1l/S
         vhJ+ELU+6T9dNXgEmnI4yhxyTGMJCKcn4+tcLrd8H4k5KagT2LVScgI7KCkLamSMrHSe
         0ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173769; x=1692778569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMECegR8LhaLV5eklOXB1c4J9xFTRtVRaQnWpzPocz0=;
        b=NZt+TmKLv+EMRQ9M45NT2dGshpCfrheC90NdS9aHVlOIagy3fwp6/JziqOd4n1ZKnF
         p1rUqrxGTUfasE2iOhrZuV5qTSgLkjVM/UinIZnjQMbE3j3QsS8cD0AXCLUvNsMg6RLf
         qXZ6Xnsn6jbk3qqTgTZtpCzu/FT6+JBg3tJm9DyoMtP/aXBUr6HzJC66SzF/vejrxjLu
         FOsJZ3kvvnUgXNk4rrBH5DqCTtnJ08bxB0UpB89aFmeLcajlvTs6zzz4pcavVqw0Im3L
         IhxBpn30nXGd0R9vHE6bc4+8ZFzm1nhy8h07ZnbEtj+nXMSKlW3lfwdbmag4e9U2XvHF
         9HRg==
X-Gm-Message-State: AOJu0Yw3mgkM1hinRq96zyolXIXMxRu56AX8OlYp92h2Gv8uHfU+gih4
	Svi+uP6hOgrRNERc9wLHChtXvrKmd+UdnA==
X-Google-Smtp-Source: AGHT+IEeXJjmVCMVA8FOpFduJEtOAl6/Zi54Grzh/72Bv226ZC3bCYlNPsprVgPpDxh9EN46VmUAH4PBPMzLpQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ad0f:0:b0:d07:9d79:881c with SMTP id
 y15-20020a25ad0f000000b00d079d79881cmr13242ybi.11.1692173769514; Wed, 16 Aug
 2023 01:16:09 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:43 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-12-edumazet@google.com>
Subject: [PATCH v4 net-next 11/15] inet: move inet->nodefrag to inet->inet_flags
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

IP_NODEFRAG socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/inet_sock.h             |  2 +-
 net/ipv4/af_inet.c                  |  2 +-
 net/ipv4/inet_diag.c                |  2 +-
 net/ipv4/ip_sockglue.c              | 18 ++++++++----------
 net/ipv4/netfilter/nf_defrag_ipv4.c |  2 +-
 net/netfilter/ipvs/ip_vs_core.c     |  4 ++--
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 38f7fc1c4dacfb4ecacbbb38ae484ed06f2638e2..0e6e1b017efb1f738be1682448675ecece43c1f7 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -229,7 +229,6 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			nodefrag:1;
 	__u8			bind_address_no_port:1,
 				defer_connect:1; /* Indicates that fastopen_connect is set
 						  * and cookie exists so we defer connect
@@ -270,6 +269,7 @@ enum {
 	INET_FLAGS_MC_ALL	= 14,
 	INET_FLAGS_TRANSPARENT	= 15,
 	INET_FLAGS_IS_ICSK	= 16,
+	INET_FLAGS_NODEFRAG	= 17,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 0f46b71f8a9899c64fb3ffcb80ec88c3a90868e2..2fb9948b5230bf21ee73437f3990ad30c4fe7ea5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -333,7 +333,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	inet = inet_sk(sk);
 	inet_assign_bit(IS_ICSK, sk, INET_PROTOSW_ICSK & answer_flags);
 
-	inet->nodefrag = 0;
+	inet_clear_bit(NODEFRAG, sk);
 
 	if (SOCK_RAW == sock->type) {
 		inet->inet_num = protocol;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index ada198fc1a92bfbaa1abe691da24489edf281f22..39606caad484a99a78beae399e38e56584f23f28 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -189,7 +189,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.mc_loop	= inet_test_bit(MC_LOOP, sk);
 	inet_sockopt.transparent = inet_test_bit(TRANSPARENT, sk);
 	inet_sockopt.mc_all	= inet_test_bit(MC_ALL, sk);
-	inet_sockopt.nodefrag	= inet->nodefrag;
+	inet_sockopt.nodefrag	= inet_test_bit(NODEFRAG, sk);
 	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
 	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
 	inet_sockopt.defer_connect = inet->defer_connect;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index dac471ed067b4ba276fc0a9379750df54ea8987c..ec946c13ea206dde3c5634d6dcd07aab7090cad8 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1015,6 +1015,11 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet_assign_bit(TRANSPARENT, sk, val);
 		return 0;
+	case IP_NODEFRAG:
+		if (sk->sk_type != SOCK_RAW)
+			return -ENOPROTOOPT;
+		inet_assign_bit(NODEFRAG, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1079,13 +1084,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->uc_ttl = val;
 		break;
-	case IP_NODEFRAG:
-		if (sk->sk_type != SOCK_RAW) {
-			err = -ENOPROTOOPT;
-			break;
-		}
-		inet->nodefrag = val ? 1 : 0;
-		break;
 	case IP_BIND_ADDRESS_NO_PORT:
 		inet->bind_address_no_port = val ? 1 : 0;
 		break;
@@ -1586,6 +1584,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TRANSPARENT:
 		val = inet_test_bit(TRANSPARENT, sk);
 		goto copyval;
+	case IP_NODEFRAG:
+		val = inet_test_bit(NODEFRAG, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1633,9 +1634,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		       inet->uc_ttl);
 		break;
 	}
-	case IP_NODEFRAG:
-		val = inet->nodefrag;
-		break;
 	case IP_BIND_ADDRESS_NO_PORT:
 		val = inet->bind_address_no_port;
 		break;
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index a9ba7de092c42895e01d808beeab18affe196abc..265b39bc435b4c7f356a7e92705e43353adb426a 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -66,7 +66,7 @@ static unsigned int ipv4_conntrack_defrag(void *priv,
 	struct sock *sk = skb->sk;
 
 	if (sk && sk_fullsock(sk) && (sk->sk_family == PF_INET) &&
-	    inet_sk(sk)->nodefrag)
+	    inet_test_bit(NODEFRAG, sk))
 		return NF_ACCEPT;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index cb83ca506c5c9de43012b1e66b9a4619ffda7de4..3230506ae3ffd8c120f0c96b07d78a7b58a4aaac 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1346,7 +1346,7 @@ ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 	if (unlikely(sk && hooknum == NF_INET_LOCAL_OUT &&
 		     af == AF_INET)) {
 
-		if (sk->sk_family == PF_INET && inet_sk(sk)->nodefrag)
+		if (sk->sk_family == PF_INET && inet_test_bit(NODEFRAG, sk))
 			return NF_ACCEPT;
 	}
 
@@ -1946,7 +1946,7 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
 	if (unlikely(sk && hooknum == NF_INET_LOCAL_OUT &&
 		     af == AF_INET)) {
 
-		if (sk->sk_family == PF_INET && inet_sk(sk)->nodefrag)
+		if (sk->sk_family == PF_INET && inet_test_bit(NODEFRAG, sk))
 			return NF_ACCEPT;
 	}
 
-- 
2.41.0.694.ge786442a9b-goog



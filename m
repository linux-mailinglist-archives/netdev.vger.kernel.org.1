Return-Path: <netdev+bounces-33090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4A579CB80
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC38F2817C8
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7AD168CB;
	Tue, 12 Sep 2023 09:17:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2525CBA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:57 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FD7E79
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5958487ca15so58048607b3.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510275; x=1695115075; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dKfAVTtvO5VH8mdihBaH2N5Bes6+5AX58UWnD66mdI=;
        b=EOEMzMCrRdwG6da/mISHEda43QRATCk4qLJS2fPQC1K3OLl/keBw+9pkyJ7KCfpQKg
         SmbszPEYWRDQ61N2W/C3mlzwomi8uv4Snf4Pxyrw32+ZGQQwRv6aD+in14gPS7LYtR+k
         P/RSnfkRfzoJsPFkGwnUaxma2j2sLUVhQnnZIMQ0gH3Gavr/mK3rsy/qNdEYg6ofymTI
         39gRrV2qFmtuoDTduK/eaoATMH/r2unERYmGX5oRwpfIJ8qSlKKlXOopsbQ89XeNZFLR
         L66v648HZcfIkfFqN2ND6icOn1h5/eIW4SAg0Ln3NJNeXeEJ0rn4hyPw3uwP0YroXL+d
         DINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510275; x=1695115075;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dKfAVTtvO5VH8mdihBaH2N5Bes6+5AX58UWnD66mdI=;
        b=l3jCMaq0lZiLYDgpuvXBaCRP5t3/DqGBItt2Nq/zJQWij1Ill7rilJVAhdIhnZMiDM
         gEe/dgC77O2tagztMBGS7MKfn4XTz8ukfilpRJDogLjFCK2cDcI705SOAgk6JYvKgg4e
         DT6h5bGmIjr0zO4eA+b/U79JVUbL7kOxgPeu4bxJflmJoqx1aHKYL6EM6wKjkuCUasmT
         n6WJduixxNRAAO4c/e7eTyxKICffkEUHSNlDU3rgSyiRtUfWpnyEWD4A6lHVoeDcOHWP
         35/yos8P4aaxZcDO+orUK6ERqVMtSeJPq1L+HtyEIbl9Mzd8vPTZoVlxNB3AVmRfAbnw
         3shg==
X-Gm-Message-State: AOJu0YzYlFbiBFVmLRlOlHFhHbxT7khB4l0By38swiYkupdPo7OSzzgA
	00EVPcdrdbkSkjnlK4meoPc0tZEdyLFnmA==
X-Google-Smtp-Source: AGHT+IG36SMHytQNTYBOwD7rXyz+maU4pwWXXRIZMjNvN01BAG2pD1GSwGGhGMH6WyHqZalh2zAqwal6ym+sDw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ac0e:0:b0:58c:74ec:3394 with SMTP id
 k14-20020a81ac0e000000b0058c74ec3394mr329133ywh.5.1694510275799; Tue, 12 Sep
 2023 02:17:55 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:27 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-8-edumazet@google.com>
Subject: [PATCH net-next 07/10] udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move udp->encap_enabled to udp->udp_flags.

Add udp_test_and_set_bit() helper to allow lockless
udp_tunnel_encap_enable() implementation.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h        |  9 ++++-----
 include/net/udp_tunnel.h   |  9 +++------
 net/ipv4/udp.c             | 10 +++-------
 net/ipv4/udp_tunnel_core.c |  2 +-
 net/ipv6/udp.c             |  2 +-
 5 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index bb2b87adfbea9b8b8539a2d5a86f8f1208c84bff..0cf83270a4a28cfe726744bd6d1d1892978ae60a 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -39,6 +39,7 @@ enum {
 	UDP_FLAGS_GRO_ENABLED,	/* Request GRO aggregation */
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
+	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
 };
 
 struct udp_sock {
@@ -52,11 +53,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 encap_enabled:1; /* This socket enabled encap
-					   * processing; UDP tunnels and
-					   * different encapsulation layer set
-					   * this
-					   */
+
 /* indicator bits used by pcflag: */
 #define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
 #define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
@@ -104,6 +101,8 @@ struct udp_sock {
 	test_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_set_bit(nr, sk)			\
 	set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
+#define udp_test_and_set_bit(nr, sk)		\
+	test_and_set_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_clear_bit(nr, sk)			\
 	clear_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags)
 #define udp_assign_bit(nr, sk, val)		\
diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 0ca9b7a11baf5ccba18b4e3a7ef41e94c4ab2ab6..29251c3519cf0c73ed5512db57c495c0326b3549 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -174,16 +174,13 @@ static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
 }
 #endif
 
-static inline void udp_tunnel_encap_enable(struct socket *sock)
+static inline void udp_tunnel_encap_enable(struct sock *sk)
 {
-	struct udp_sock *up = udp_sk(sock->sk);
-
-	if (up->encap_enabled)
+	if (udp_test_and_set_bit(ENCAP_ENABLED, sk))
 		return;
 
-	up->encap_enabled = 1;
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sock->sk->sk_family == PF_INET6)
+	if (READ_ONCE(sk->sk_family) == PF_INET6)
 		ipv6_stub->udpv6_encap_enable();
 #endif
 	udp_encap_enable();
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 75ba86a87bb6266f1054da0d631049ff279b21c7..637a4faf9aff6389274bfb5ace1fc81dcb2db13f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2618,7 +2618,7 @@ void udp_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (up->encap_enabled)
+		if (udp_test_bit(ENCAP_ENABLED, sk))
 			static_branch_dec(&udp_encap_needed_key);
 	}
 }
@@ -2685,9 +2685,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			fallthrough;
 		case UDP_ENCAP_L2TPINUDP:
 			up->encap_type = val;
-			lock_sock(sk);
-			udp_tunnel_encap_enable(sk->sk_socket);
-			release_sock(sk);
+			udp_tunnel_encap_enable(sk);
 			break;
 		default:
 			err = -ENOPROTOOPT;
@@ -2710,14 +2708,12 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_GRO:
-		lock_sock(sk);
 
 		/* when enabling GRO, accept the related GSO packet type */
 		if (valbool)
-			udp_tunnel_encap_enable(sk->sk_socket);
+			udp_tunnel_encap_enable(sk);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
 		udp_assign_bit(ACCEPT_L4, sk, valbool);
-		release_sock(sk);
 		break;
 
 	/*
diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 9b18f371af0d49bd3ee9a440f222d03efd8a4911..1e7e4aecdc48a217a04544bb991bd1a8b8fe5ae4 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -78,7 +78,7 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
 	udp_sk(sk)->gro_receive = cfg->gro_receive;
 	udp_sk(sk)->gro_complete = cfg->gro_complete;
 
-	udp_tunnel_encap_enable(sock);
+	udp_tunnel_encap_enable(sk);
 }
 EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 2c3281879b6dfdf04bf219cf9b13c1c59f732a0d..90688877e90049e45a164322119b2d411dd3e65e 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1670,7 +1670,7 @@ void udpv6_destroy_sock(struct sock *sk)
 			if (encap_destroy)
 				encap_destroy(sk);
 		}
-		if (up->encap_enabled) {
+		if (udp_test_bit(ENCAP_ENABLED, sk)) {
 			static_branch_dec(&udpv6_encap_needed_key);
 			udp_encap_disable();
 		}
-- 
2.42.0.283.g2d96d420d3-goog



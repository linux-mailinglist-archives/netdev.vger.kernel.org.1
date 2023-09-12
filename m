Return-Path: <netdev+bounces-33085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DAB79CB67
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AEE1C20D5B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCC1641F;
	Tue, 12 Sep 2023 09:17:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082116413
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:48 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B50A9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74829dd58fso5421214276.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510267; x=1695115067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOn34jhac3ARudjRvSDjDGjNJbkGPEtud6KvpnC4NgQ=;
        b=m8jAZCNd3qWREsDG1aALoU2aHrO59Jz2DO/5YjzC6PePgX4Ma1qyE/D7gFoagqqNgh
         jCi6/FshMkDGhrO8GtwIBzhQ/e4Vx+YI3qiE9tTQ/1qlbtpxpL1PBmepa4bH/tYTHQhX
         UjwfZwoWRB2yCnEMcASp53EopY+iafRM5k1C3uBNG4roIoZoi5orDo/8uslvIceRNACY
         aGTFQdok821M3cZQnUlcpvY3d3fLnsdstBRcFxINzTAuMNBZTyTBOfLqYdkx+T2qIBRW
         3Owxly2K3k+56n3kUdC9WW4Zk86aGohl5Ev/x5nmKJBTF+6+zdmdioTdC1ZfugT4vDg6
         OUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510267; x=1695115067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOn34jhac3ARudjRvSDjDGjNJbkGPEtud6KvpnC4NgQ=;
        b=LNCm5kQztxL6TI5NXk67/EoOvYp6YiwLZqP0BietZK9Qt7WfAc0qxNJmRPpJXGD9YX
         TOCM+ZTBo2Pee0ZeH4rZmxHTTQUaGfx4NQib13xwht+hoKRBIH2qvqHHUvHUTK7B+wHp
         nDJqylqB9qZh5n5iH4GkFM+c0N12AWk78AVTi1h2nUtVuNF/gxQoC5MgbCzknisRU51W
         0itOS+F2aE4eClFIFD8Y9sXY8zMnRpaxIV2OTxOOxfTUDIR5Jxkx5rb/bvfq6V449JJP
         yTuZJZX8d19a7Ortca82yKgHcnP4kNO9TDQ1gUiB88nmGUAcm1hTJBYEB0OHciocXFox
         2U4A==
X-Gm-Message-State: AOJu0YyvRsCN3qPSijZkPLvQRY2/Gd46mTYLX/gZlJm3tEOM0IYVm4Kx
	hqXUkgtCVRN9SWcs5SGEvF1vwJELcuCRDA==
X-Google-Smtp-Source: AGHT+IFXMrbfRIjZYzZzPetdUihaK3ezNhoNsR3qhjwJK9501JPedAaIKSz/OOkHxuyqSSuWTxvc2+vDHgoaxg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:f904:0:b0:d7e:8dee:7813 with SMTP id
 q4-20020a25f904000000b00d7e8dee7813mr281171ybe.8.1694510267022; Tue, 12 Sep
 2023 02:17:47 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:22 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-3-edumazet@google.com>
Subject: [PATCH net-next 02/10] udp: move udp->no_check6_tx to udp->udp_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that udp->no_check6_tx can be read locklessly.
Use one atomic bit from udp->udp_flags

Fixes: 1c19448c9ba6 ("net: Make enabling of zero UDP6 csums more restrictive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 10 +++++-----
 net/ipv4/udp.c      |  4 ++--
 net/ipv6/udp.c      |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 23f0693e0d9cc4212ab7c7dc982561a2807b14f0..e3f2a6c7ac1d1bb37720420ce4cb0dc223926866 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -34,6 +34,7 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 
 enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
+	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
 };
 
 struct udp_sock {
@@ -47,8 +48,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 no_check6_tx:1,/* Send zero UDP6 checksums on TX? */
-			 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
+	unsigned char	 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
 			 encap_enabled:1, /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
@@ -115,7 +115,7 @@ struct udp_sock {
 
 static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 {
-	udp_sk(sk)->no_check6_tx = val;
+	udp_assign_bit(NO_CHECK6_TX, sk, val);
 }
 
 static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
@@ -123,9 +123,9 @@ static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
 	udp_sk(sk)->no_check6_rx = val;
 }
 
-static inline bool udp_get_no_check6_tx(struct sock *sk)
+static inline bool udp_get_no_check6_tx(const struct sock *sk)
 {
-	return udp_sk(sk)->no_check6_tx;
+	return udp_test_bit(NO_CHECK6_TX, sk);
 }
 
 static inline bool udp_get_no_check6_rx(struct sock *sk)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 9709f8a532dc3d0e62a1cdb126ea7dc3cebd7da9..0c6998291c99d70d7d1f7e98af241642f75c1c22 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2694,7 +2694,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_TX:
-		up->no_check6_tx = valbool;
+		udp_set_no_check6_tx(sk, valbool);
 		break;
 
 	case UDP_NO_CHECK6_RX:
@@ -2791,7 +2791,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_TX:
-		val = up->no_check6_tx;
+		val = udp_get_no_check6_tx(sk);
 		break;
 
 	case UDP_NO_CHECK6_RX:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0c6973cd22ce4cdcc846eb94029f4281e900da40..469df0ca561f762f31deea1ca1836d49be7a9f3c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1241,7 +1241,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			kfree_skb(skb);
 			return -EINVAL;
 		}
-		if (udp_sk(sk)->no_check6_tx) {
+		if (udp_get_no_check6_tx(sk)) {
 			kfree_skb(skb);
 			return -EINVAL;
 		}
@@ -1262,7 +1262,7 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 
 	if (is_udplite)
 		csum = udplite_csum(skb);
-	else if (udp_sk(sk)->no_check6_tx) {   /* UDP csum disabled */
+	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
 		skb->ip_summed = CHECKSUM_NONE;
 		goto send;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) { /* UDP hardware csum */
-- 
2.42.0.283.g2d96d420d3-goog



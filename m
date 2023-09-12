Return-Path: <netdev+bounces-33086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8A79CB6D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15802817DF
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F131642B;
	Tue, 12 Sep 2023 09:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E6416413
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:50 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E6FAA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-594e5e2e608so60750727b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510269; x=1695115069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4FdgqCSTB+icCtSMY2+CX+QLFoCUNO0lrSoNXO19uRk=;
        b=NKIqWIxzelunOZt4SmcfEWVsvu1ac34QjwqTuwIYgccuWZ9S3zWQXfjqcYnz81YpXa
         lRcLkEw1qVQOhdxUik8edtN4PcgwOyl7Pb/zzozB73+3l/Okudgkn1hKJa7dWgi2pThp
         NSKaRP2pXLfxJC8yupGBuzxnWC5STOJq53bnIy/ru9tWYc2SK5JDHDUeELuEgn5eVkL8
         w/YlA2jblEJ43AEiFMj6O49IfjcjskYP3tDC/NzTlbn49gNIhOSn97hu2XafSQzA39dm
         WlzW8wcbfVl/7v1aXYZNHxGIREra2Wtykz+9y1/ntqXwPfkKRoHg2ujfKLSWzZ7mz05K
         UsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510269; x=1695115069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4FdgqCSTB+icCtSMY2+CX+QLFoCUNO0lrSoNXO19uRk=;
        b=Lcj5f9khd4G1FyqbRFKydZWuxnQmPmeBnrBCP6UKzkRPgKpNstJH1A9F5DBYbNQSSD
         vbiwnXYlNRzaiOFkE47hdtc8hAzUrfAk9umo23+Fr+6adu7UxLiQlGc1xvGl3sQi+WKK
         RhqZop1uJ4zSp2eiEBX1GwXdcT/6de6BzegIQoikF3hCfy+jSuASV2HK7l7iEOeYiN+J
         a9Gc7bYVl8K7p+q6hsL1rRVIqI8eLxbN7od/46pCXt4KVhdszpqV6tWg18sjplswpZeY
         TZitrZIDxCncFGcwRBaVy+iMJPhbWiWtibikHBHJ+0B+gMpwtNLfduDfz6/+0ct03iZE
         GOzg==
X-Gm-Message-State: AOJu0YzViBdImqnH3HPt9I4+Lw+0cUGbfKhbmpMIknZkQt1HIKntaLng
	7DSBmiW2t8plhTRgHDljdFYiE/QB9XO5PA==
X-Google-Smtp-Source: AGHT+IHHAXHXKblud7JMfjjWv3C4DTFaoyZ4VWhAx+id+zZESJwug6Ma5gBvAuIZSLFEPjQlExtxdQjh9LOEyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:af48:0:b0:58c:8552:458d with SMTP id
 x8-20020a81af48000000b0058c8552458dmr263383ywj.3.1694510268787; Tue, 12 Sep
 2023 02:17:48 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:23 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-4-edumazet@google.com>
Subject: [PATCH net-next 03/10] udp: move udp->no_check6_rx to udp->udp_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that udp->no_check6_rx can be read locklessly.
Use one atomic bit from udp->udp_flags.

Fixes: 1c19448c9ba6 ("net: Make enabling of zero UDP6 csums more restrictive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 10 +++++-----
 net/ipv4/udp.c      |  4 ++--
 net/ipv6/udp.c      |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index e3f2a6c7ac1d1bb37720420ce4cb0dc223926866..8d4c3835b1b219da9c830f53f09aa0511840a1d4 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -35,6 +35,7 @@ static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
 enum {
 	UDP_FLAGS_CORK,		/* Cork is required */
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
+	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
 };
 
 struct udp_sock {
@@ -48,8 +49,7 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 no_check6_rx:1,/* Allow zero UDP6 checksums on RX? */
-			 encap_enabled:1, /* This socket enabled encap
+	unsigned char	 encap_enabled:1, /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
 					   * this
@@ -120,7 +120,7 @@ static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 
 static inline void udp_set_no_check6_rx(struct sock *sk, bool val)
 {
-	udp_sk(sk)->no_check6_rx = val;
+	udp_assign_bit(NO_CHECK6_RX, sk, val);
 }
 
 static inline bool udp_get_no_check6_tx(const struct sock *sk)
@@ -128,9 +128,9 @@ static inline bool udp_get_no_check6_tx(const struct sock *sk)
 	return udp_test_bit(NO_CHECK6_TX, sk);
 }
 
-static inline bool udp_get_no_check6_rx(struct sock *sk)
+static inline bool udp_get_no_check6_rx(const struct sock *sk)
 {
-	return udp_sk(sk)->no_check6_rx;
+	return udp_test_bit(NO_CHECK6_RX, sk);
 }
 
 static inline void udp_cmsg_recv(struct msghdr *msg, struct sock *sk,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0c6998291c99d70d7d1f7e98af241642f75c1c22..cb32826a1db20006ce9c21e66a9347f41b228da2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2698,7 +2698,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		up->no_check6_rx = valbool;
+		udp_set_no_check6_rx(sk, valbool);
 		break;
 
 	case UDP_SEGMENT:
@@ -2795,7 +2795,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case UDP_NO_CHECK6_RX:
-		val = up->no_check6_rx;
+		val = udp_get_no_check6_rx(sk);
 		break;
 
 	case UDP_SEGMENT:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 469df0ca561f762f31deea1ca1836d49be7a9f3c..6e1ea3029260ec6e4992cf7e01c0202fabd94017 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -858,7 +858,7 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 		/* If zero checksum and no_check is not on for
 		 * the socket then skip it.
 		 */
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			continue;
 		if (!first) {
 			first = sk;
@@ -980,7 +980,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		if (unlikely(rcu_dereference(sk->sk_rx_dst) != dst))
 			udp6_sk_rx_dst_set(sk, dst);
 
-		if (!uh->check && !udp_sk(sk)->no_check6_rx) {
+		if (!uh->check && !udp_get_no_check6_rx(sk)) {
 			if (refcounted)
 				sock_put(sk);
 			goto report_csum_error;
@@ -1002,7 +1002,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest, udptable);
 	if (sk) {
-		if (!uh->check && !udp_sk(sk)->no_check6_rx)
+		if (!uh->check && !udp_get_no_check6_rx(sk))
 			goto report_csum_error;
 		return udp6_unicast_rcv_skb(sk, skb, uh);
 	}
-- 
2.42.0.283.g2d96d420d3-goog



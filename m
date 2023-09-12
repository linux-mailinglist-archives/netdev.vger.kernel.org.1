Return-Path: <netdev+bounces-33093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFB79CB85
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33C3281AB1
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16AD171BA;
	Tue, 12 Sep 2023 09:18:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F617748
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:18:01 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39024AA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:18:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ea08906b3so5279499276.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510280; x=1695115080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQO3MjDVMk8ceY+ts7M1nzRlA+A1grugSv4Jt36+Qfk=;
        b=IpZVm73891//XlD0OrI/k6fME6/yBJ5YLnHLVIj4lZI196SrEeCfoU6I2BH67ZeolS
         W3DZDVuUjJsKQ+ftNJkm1YgNGSR/byvRweHBSfECKF52uvgYACgFKCgsIpopzuLLKruo
         xTOyxDBUPdN7yQMYxLlIz/vasf5YK9WAJDI8UXadFroP+s4hlMaZ0IF1Wnb3xAa88uKU
         sRxaaFHVYm+OYETkb891hbvLcu2e+fbLMvvigO5Ll4RTmY1f+x7oYF8LDdcc4723QJmS
         dtJ+9jIbcbyjAHL8cB3pySWYdqy+58NB23Q9dMG1m2bKR5nI2HxjOWTvVcHZsTFbEu9c
         nz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510280; x=1695115080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQO3MjDVMk8ceY+ts7M1nzRlA+A1grugSv4Jt36+Qfk=;
        b=kg7LotpTLnLo/yjjiA+2Bwfb1pJVS4KtZDKZgJyjdlYTzp6giha7oR3Ci9nqzUEfkA
         YF/HdciaddFhWd0iZIIc17+cZF+APz+Be4Y9NKDuYmm+z8Q5gR4OemyTU2bwpNdo5lSh
         bgGMjHijzRLPilqQu1hIAfT5A3JQBsukp3CLsB26GTfM6ba+FZ+EbZHOVbYrm/R6vAr5
         KthAB/MIl1a9ZmgsjApH1k7fm37C5mm0D/XBMjgWXl55xEpxIRArC1bC1YNWSgzCyQsa
         DvqfiJ0ZNvMlYt0Sfym/Jb3vbxAvcaVQ52xB3Isb+pKZJjZUbRhM3M5qhhJ/JrxuN83r
         PKPw==
X-Gm-Message-State: AOJu0YwEE0jWVW4aUpNqBGU9BmRU3by5Qm5DPoB3jIxEvFecVuFrQF7d
	mc+WjU22BNsW6PruGQe3eefuHkFSb8RYzA==
X-Google-Smtp-Source: AGHT+IG2/MaNMrU4nv4cpp5poWWWKi3MlynGPjVJjDRu4B/y0KfA0uKrayq1ziXYPytIy4zl57fWQ/15srfb3Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1682:b0:d73:bcb7:7282 with SMTP
 id bx2-20020a056902168200b00d73bcb77282mr294169ybb.8.1694510280554; Tue, 12
 Sep 2023 02:18:00 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:30 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-11-edumazet@google.com>
Subject: [PATCH net-next 10/10] udplite: fix various data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

udp->pcflag, udp->pcslen and udp->pcrlen reads/writes are racy.

Move udp->pcflag to udp->udp_flags for atomicity,
and add READ_ONCE()/WRITE_ONCE() annotations for pcslen and pcrlen.

Fixes: ba4e58eca8aa ("[NET]: Supporting UDP-Lite (RFC 3828) in Linux")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h   |  6 ++----
 include/net/udplite.h | 14 +++++++++-----
 net/ipv4/udp.c        | 21 +++++++++++----------
 net/ipv6/udp.c        |  9 +++++----
 4 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 58156edec009636f2616b8a735945658d2982054..d04188714dca14da25aa57083488cd28c34c41ba 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -40,6 +40,8 @@ enum {
 	UDP_FLAGS_ACCEPT_FRAGLIST,
 	UDP_FLAGS_ACCEPT_L4,
 	UDP_FLAGS_ENCAP_ENABLED, /* This socket enabled encap */
+	UDP_FLAGS_UDPLITE_SEND_CC, /* set via udplite setsockopt */
+	UDP_FLAGS_UDPLITE_RECV_CC, /* set via udplite setsockopt */
 };
 
 struct udp_sock {
@@ -54,10 +56,6 @@ struct udp_sock {
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
 
-/* indicator bits used by pcflag: */
-#define UDPLITE_SEND_CC  0x1  		/* set via udplite setsockopt         */
-#define UDPLITE_RECV_CC  0x2		/* set via udplite setsocktopt        */
-	__u8		 pcflag;        /* marks socket as UDP-Lite if > 0    */
 	/*
 	 * Following member retains the information to create a UDP header
 	 * when the socket is uncorked.
diff --git a/include/net/udplite.h b/include/net/udplite.h
index bd33ff2b8f426de24640cb7e821a28873a813260..786919d29f8de7664b5e8cabab00692ecf4b9089 100644
--- a/include/net/udplite.h
+++ b/include/net/udplite.h
@@ -66,14 +66,18 @@ static inline int udplite_checksum_init(struct sk_buff *skb, struct udphdr *uh)
 /* Fast-path computation of checksum. Socket may not be locked. */
 static inline __wsum udplite_csum(struct sk_buff *skb)
 {
-	const struct udp_sock *up = udp_sk(skb->sk);
 	const int off = skb_transport_offset(skb);
+	const struct sock *sk = skb->sk;
 	int len = skb->len - off;
 
-	if ((up->pcflag & UDPLITE_SEND_CC) && up->pcslen < len) {
-		if (0 < up->pcslen)
-			len = up->pcslen;
-		udp_hdr(skb)->len = htons(up->pcslen);
+	if (udp_test_bit(UDPLITE_SEND_CC, sk)) {
+		u16 pcslen = READ_ONCE(udp_sk(sk)->pcslen);
+
+		if (pcslen < len) {
+			if (pcslen > 0)
+				len = pcslen;
+			udp_hdr(skb)->len = htons(pcslen);
+		}
 	}
 	skb->ip_summed = CHECKSUM_NONE;     /* no HW support for checksumming */
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2eeab4af17a13de5a25a2da64259b8dc2fe3d047..c3ff984b63547daf0ecfb4ab96956aee2f8d589d 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2120,7 +2120,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * 	UDP-Lite specific tests, ignored on UDP sockets
 	 */
-	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+		u16 pcrlen = READ_ONCE(up->pcrlen);
 
 		/*
 		 * MIB statistics other than incrementing the error count are
@@ -2133,7 +2134,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		 * delivery of packets with coverage values less than a value
 		 * provided by the application."
 		 */
-		if (up->pcrlen == 0) {          /* full coverage was set  */
+		if (pcrlen == 0) {          /* full coverage was set  */
 			net_dbg_ratelimited("UDPLite: partial coverage %d while full coverage %d requested\n",
 					    UDP_SKB_CB(skb)->cscov, skb->len);
 			goto drop;
@@ -2144,9 +2145,9 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 		 * that it wants x while sender emits packets of smaller size y.
 		 * Therefore the above ...()->partial_cov statement is essential.
 		 */
-		if (UDP_SKB_CB(skb)->cscov  <  up->pcrlen) {
+		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
 			net_dbg_ratelimited("UDPLite: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, up->pcrlen);
+					    UDP_SKB_CB(skb)->cscov, pcrlen);
 			goto drop;
 		}
 	}
@@ -2729,8 +2730,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			val = 8;
 		else if (val > USHRT_MAX)
 			val = USHRT_MAX;
-		up->pcslen = val;
-		up->pcflag |= UDPLITE_SEND_CC;
+		WRITE_ONCE(up->pcslen, val);
+		udp_set_bit(UDPLITE_SEND_CC, sk);
 		break;
 
 	/* The receiver specifies a minimum checksum coverage value. To make
@@ -2743,8 +2744,8 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 			val = 8;
 		else if (val > USHRT_MAX)
 			val = USHRT_MAX;
-		up->pcrlen = val;
-		up->pcflag |= UDPLITE_RECV_CC;
+		WRITE_ONCE(up->pcrlen, val);
+		udp_set_bit(UDPLITE_RECV_CC, sk);
 		break;
 
 	default:
@@ -2808,11 +2809,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 	/* The following two cannot be changed on UDP sockets, the return is
 	 * always 0 (which corresponds to the full checksum coverage of UDP). */
 	case UDPLITE_SEND_CSCOV:
-		val = up->pcslen;
+		val = READ_ONCE(up->pcslen);
 		break;
 
 	case UDPLITE_RECV_CSCOV:
-		val = up->pcrlen;
+		val = READ_ONCE(up->pcrlen);
 		break;
 
 	default:
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0e79d189613bef41e3ba39c463b19761d2fa3d34..f60ba429543526b7ade2666c36dd51828ffe54a9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -727,16 +727,17 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	/*
 	 * UDP-Lite specific tests, ignored on UDP sockets (see net/ipv4/udp.c).
 	 */
-	if ((up->pcflag & UDPLITE_RECV_CC)  &&  UDP_SKB_CB(skb)->partial_cov) {
+	if (udp_test_bit(UDPLITE_RECV_CC, sk) && UDP_SKB_CB(skb)->partial_cov) {
+		u16 pcrlen = READ_ONCE(up->pcrlen);
 
-		if (up->pcrlen == 0) {          /* full coverage was set  */
+		if (pcrlen == 0) {          /* full coverage was set  */
 			net_dbg_ratelimited("UDPLITE6: partial coverage %d while full coverage %d requested\n",
 					    UDP_SKB_CB(skb)->cscov, skb->len);
 			goto drop;
 		}
-		if (UDP_SKB_CB(skb)->cscov  <  up->pcrlen) {
+		if (UDP_SKB_CB(skb)->cscov < pcrlen) {
 			net_dbg_ratelimited("UDPLITE6: coverage %d too small, need min %d\n",
-					    UDP_SKB_CB(skb)->cscov, up->pcrlen);
+					    UDP_SKB_CB(skb)->cscov, pcrlen);
 			goto drop;
 		}
 	}
-- 
2.42.0.283.g2d96d420d3-goog



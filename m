Return-Path: <netdev+bounces-33089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52579CB7D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A2228168E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966B1640A;
	Tue, 12 Sep 2023 09:17:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA75CBA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:17:55 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8019AA
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7e8e12df78so4665170276.3
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694510274; x=1695115074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vGT7kTvCfvhHKjYM59Py00A7FCv98WkPWWa9uRvQrVk=;
        b=EROIsGHsMa291uIp8y6oaRMRLu0RXR3uEe6iAn+hSBSTJ8Vc/w51qZhrIcPXZW7ae7
         xzJS6VPCOd5Odpp0en8dXjrX3bgB2lNt3ZRifBJZT4s4EzZNHKeSEme08ClGGYyyPWQy
         Pu0kaHstzHevgRHjwKtmoF3hQ0PaV88erF70lRILpnX+633IrV29cjnfJ6DWSdl0ssIr
         0RrdD6lEzaE3s13jhTO5AgYYh3ZWJqqcPRpBLm9OJOUjB+ZlA6cUOAHZJI2Jpo+x83E5
         X564HvjA0gFl60cvM2ACu9ZC5AGZvfPRDvSuTHMgD9xIGdo39taQMxFPMt+KJYkBIMLy
         F3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694510274; x=1695115074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGT7kTvCfvhHKjYM59Py00A7FCv98WkPWWa9uRvQrVk=;
        b=Kyz1/gjEQCJi1PDRacORLSoSfA3OIEJVWy5qTAeVFbaYBHtsPQQ7ioIlylgWfDul/t
         8fzPCopOMjxe8csXs0Z0X6GiIINWWIMidtghL6L1vSqD1LdtzfQZYpjeZ/6LFv0w1kJK
         5VjEATzCmIgkDnsUclafksUbp+9BvjOr+zkiGKG2r8/ZQgOb3V31QetWrE/QGI8NfYh/
         gfJoJjUxeXsnE7g46a1Lj09LDBceKTmuRhbp8g3ohmXzKxWbKxA1zW15cgpLRo/UQKX2
         uXiJqbDxiowsusXhnbOPsBRdCh86AhNwyj9bQ6wTjOV2E+/qXPrNs2outxzuRihEMGZi
         AWHw==
X-Gm-Message-State: AOJu0Yz18LOVCWm0bokIqB9LFP9GP+NC6HZchl2dUjfBzREJHLOY2OLf
	rO0+LYK+5v4YLknjVEuN8aD+BtTwRM+yDA==
X-Google-Smtp-Source: AGHT+IFPiQYIHPF1E34suS7Au0VBLaRBy2wNIvAiLcIPeZBYcytTnfrp5Ih7HkoxT+4gzNh8gLOoa4OMcvIA8w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:adc3:0:b0:d80:14ed:d28f with SMTP id
 d3-20020a25adc3000000b00d8014edd28fmr278126ybe.8.1694510274228; Tue, 12 Sep
 2023 02:17:54 -0700 (PDT)
Date: Tue, 12 Sep 2023 09:17:26 +0000
In-Reply-To: <20230912091730.1591459-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912091730.1591459-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912091730.1591459-7-edumazet@google.com>
Subject: [PATCH net-next 06/10] udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These are read locklessly, move them to udp_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h | 16 +++++++++-------
 net/ipv4/udp.c      |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index b344bd2e41fc9f4abf953c29c644b11438b0057d..bb2b87adfbea9b8b8539a2d5a86f8f1208c84bff 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -37,6 +37,8 @@ enum {
 	UDP_FLAGS_NO_CHECK6_TX, /* Send zero UDP6 checksums on TX? */
 	UDP_FLAGS_NO_CHECK6_RX, /* Allow zero UDP6 checksums on RX? */
 	UDP_FLAGS_GRO_ENABLED,	/* Request GRO aggregation */
+	UDP_FLAGS_ACCEPT_FRAGLIST,
+	UDP_FLAGS_ACCEPT_L4,
 };
 
 struct udp_sock {
@@ -50,13 +52,11 @@ struct udp_sock {
 
 	int		 pending;	/* Any pending frames ? */
 	__u8		 encap_type;	/* Is this an Encapsulation socket? */
-	unsigned char	 encap_enabled:1, /* This socket enabled encap
+	unsigned char	 encap_enabled:1; /* This socket enabled encap
 					   * processing; UDP tunnels and
 					   * different encapsulation layer set
 					   * this
 					   */
-			 accept_udp_l4:1,
-			 accept_udp_fraglist:1;
 /* indicator bits used by pcflag: */
 #define UDPLITE_BIT      0x1  		/* set by udplite proto init function */
 #define UDPLITE_SEND_CC  0x2  		/* set via udplite setsockopt         */
@@ -149,10 +149,12 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 	if (!skb_is_gso(skb))
 		return false;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 && !udp_sk(sk)->accept_udp_l4)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	    !udp_test_bit(ACCEPT_L4, sk))
 		return true;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST && !udp_sk(sk)->accept_udp_fraglist)
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST &&
+	    !udp_test_bit(ACCEPT_FRAGLIST, sk))
 		return true;
 
 	return false;
@@ -160,8 +162,8 @@ static inline bool udp_unexpected_gso(struct sock *sk, struct sk_buff *skb)
 
 static inline void udp_allow_gso(struct sock *sk)
 {
-	udp_sk(sk)->accept_udp_l4 = 1;
-	udp_sk(sk)->accept_udp_fraglist = 1;
+	udp_set_bit(ACCEPT_L4, sk);
+	udp_set_bit(ACCEPT_FRAGLIST, sk);
 }
 
 #define udp_portaddr_for_each_entry(__sk, list) \
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index db43907b9a3e8d8f05c98e6a873415e6731261f4..75ba86a87bb6266f1054da0d631049ff279b21c7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2716,7 +2716,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 		if (valbool)
 			udp_tunnel_encap_enable(sk->sk_socket);
 		udp_assign_bit(GRO_ENABLED, sk, valbool);
-		up->accept_udp_l4 = valbool;
+		udp_assign_bit(ACCEPT_L4, sk, valbool);
 		release_sock(sk);
 		break;
 
-- 
2.42.0.283.g2d96d420d3-goog



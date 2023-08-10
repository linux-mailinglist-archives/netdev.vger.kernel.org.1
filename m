Return-Path: <netdev+bounces-26288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C058777624
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2991C215AA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8839A20F9C;
	Thu, 10 Aug 2023 10:39:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4620F99
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:39:55 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2EE271E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5867fe87d16so11119287b3.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691663993; x=1692268793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j4bJPC2UWUjJlPtvrIOKtJMhW7JgogvkvDW44KseFV0=;
        b=G7gDqW5ZPV63SeGF0GIztAdKaiPEO1zwfwlTeQepne8e5eaHeaebTiNTn+gFFuDOYt
         wKYREXqw3vrZgQrh5GhQr1sjvtUJra/gETk7mQnBFfVStcZOiZv0Jvg7XtwQaPIlM/yT
         QzcXiEeLPjq+NtIYSo1rdQpC7V/4JaCJNm1p/842BVGGj3BySf8r0MMEHA23FFmJWele
         jQ6O6deYZ/lHaPs8Si4tXaqvwT14ySc92/LfDlLm7F72Eub/31WOKcabTZGenFkoRSkQ
         TveO5nAUcV5FTXGF0+ilchfs3PjhsQuFnlYqhlyR5arY1UK4cETme80jxUdHjGMo46ZL
         hXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691663993; x=1692268793;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4bJPC2UWUjJlPtvrIOKtJMhW7JgogvkvDW44KseFV0=;
        b=ksAVP9Y3jgbxnxFWCkDeBFavFKNfgsEWPI2uvNx4OPDUdf7Phjo+NahNigP9GNUTAX
         u7LiXO9ZboZwtbBLGGXM8Gu2wkbLIy5YqjDi+IfZlo/R98Q5zLCo7hpLPy4Ic58BeNiq
         Teyw3v9if8vQ0PtDKLXfkXHJy1gGEkUR52BxDhzWU+c2h9y2aG9bzbzkfU1LtQYjpU+R
         lzcepO+jKR0cPizzMrovHKBlgZX/dPBE9nYqHYFPnjR8/q0HI0m3qO30omPYIQa20dVh
         gBt4oDpCVo4TejWw0g2qHeqxzkWasCY+81vu1coWqrs2gCJWKRnf2TB/uZZbW8uJgjTX
         IMCA==
X-Gm-Message-State: AOJu0YxQBwAtouYyZA48xtdjHUIS0Jami5QEOI9Mj14jfcKmHHHj4mQD
	bNFK0PGPglv1SJZoHqee99rbt1FDEQ/Duw==
X-Google-Smtp-Source: AGHT+IG4Lx3aXxtRTG5m9AXCINViTUxJr5QzLWiKlzL2dV757LcPo4IzI0XjCGLfc3tndIWnqM8NSpdvKAApeQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ab61:0:b0:d44:be8a:ca39 with SMTP id
 u88-20020a25ab61000000b00d44be8aca39mr29300ybi.7.1691663993066; Thu, 10 Aug
 2023 03:39:53 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:20 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-9-edumazet@google.com>
Subject: [PATCH net-next 08/15] inet: move inet->mc_all to inet->inet_frags
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

IP_MULTICAST_ALL socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_sock.h |  2 +-
 net/ipv4/af_inet.c      |  2 +-
 net/ipv4/igmp.c         |  2 +-
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_sockglue.c  | 22 +++++++++++-----------
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 6c4eeca59f608ff18e5f05dec33700189d6e2198..fffd34fa6a7cb92a98e29bd6b36ccf907b5e3a6d 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -232,7 +232,6 @@ struct inet_sock {
 	__u8			pmtudisc;
 	__u8			is_icsk:1,
 				transparent:1,
-				mc_all:1,
 				nodefrag:1;
 	__u8			bind_address_no_port:1,
 				defer_connect:1; /* Indicates that fastopen_connect is set
@@ -271,6 +270,7 @@ enum {
 	INET_FLAGS_FREEBIND	= 11,
 	INET_FLAGS_HDRINCL	= 12,
 	INET_FLAGS_MC_LOOP	= 13,
+	INET_FLAGS_MC_ALL	= 14,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 80e2a3c897a540c76b979355957b81a024bd8259..c15aae4a386097b66a8908e2dcf23c549200e86f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -352,7 +352,7 @@ static int inet_create(struct net *net, struct socket *sock, int protocol,
 	inet->uc_ttl	= -1;
 	inet_set_bit(MC_LOOP, sk);
 	inet->mc_ttl	= 1;
-	inet->mc_all	= 1;
+	inet_set_bit(MC_ALL, sk);
 	inet->mc_index	= 0;
 	inet->mc_list	= NULL;
 	inet->rcv_tos	= 0;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 48ff5f13e7979dc00da60b466ee2e74ddce0891b..0c9e768e5628b1c8fd7e87bebe528762ea4a6e1e 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -2658,7 +2658,7 @@ int ip_mc_sf_allow(const struct sock *sk, __be32 loc_addr, __be32 rmt_addr,
 		     (sdif && pmc->multi.imr_ifindex == sdif)))
 			break;
 	}
-	ret = inet->mc_all;
+	ret = inet_test_bit(MC_ALL, sk);
 	if (!pmc)
 		goto unlock;
 	psl = rcu_dereference(pmc->sflist);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index cc797261893b902f626b5a36074e4b4bf7535063..e009dab80c3546c5222c587531acd394f2eeff0d 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -188,7 +188,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.hdrincl	= inet_test_bit(HDRINCL, sk);
 	inet_sockopt.mc_loop	= inet_test_bit(MC_LOOP, sk);
 	inet_sockopt.transparent = inet->transparent;
-	inet_sockopt.mc_all	= inet->mc_all;
+	inet_sockopt.mc_all	= inet_test_bit(MC_ALL, sk);
 	inet_sockopt.nodefrag	= inet->nodefrag;
 	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
 	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index be569032b612bef1277e802400a1ee6ec20e877a..2f27c30a4eccca5d23b70851daeb5115bcc1de16 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -998,6 +998,14 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet_assign_bit(MC_LOOP, sk, val);
 		return 0;
+	case IP_MULTICAST_ALL:
+		if (optlen < 1)
+			return -EINVAL;
+		if (val != 0 && val != 1)
+			return -EINVAL;
+		inet_assign_bit(MC_ALL, sk, val);
+		return 0;
+
 	}
 
 	err = 0;
@@ -1303,14 +1311,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		else
 			err = ip_set_mcast_msfilter(sk, optval, optlen);
 		break;
-	case IP_MULTICAST_ALL:
-		if (optlen < 1)
-			goto e_inval;
-		if (val != 0 && val != 1)
-			goto e_inval;
-		inet->mc_all = val;
-		break;
-
 	case IP_IPSEC_POLICY:
 	case IP_XFRM_POLICY:
 		err = -EPERM;
@@ -1582,6 +1582,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_MULTICAST_LOOP:
 		val = inet_test_bit(MC_LOOP, sk);
 		goto copyval;
+	case IP_MULTICAST_ALL:
+		val = inet_test_bit(MC_ALL, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1694,9 +1697,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		else
 			err = ip_get_mcast_msfilter(sk, optval, optlen, len);
 		goto out;
-	case IP_MULTICAST_ALL:
-		val = inet->mc_all;
-		break;
 	case IP_PKTOPTIONS:
 	{
 		struct msghdr msg;
-- 
2.41.0.640.ga95def55d0-goog



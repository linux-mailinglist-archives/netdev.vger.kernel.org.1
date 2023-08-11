Return-Path: <netdev+bounces-26661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB0E77885C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D6F282025
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2D63AB;
	Fri, 11 Aug 2023 07:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4D1FDB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:37 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EB412B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589a89598ecso21489687b3.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739395; x=1692344195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KC8RKz9us2GareLA53AAabGR+hAFqFb1dFQgL27Q7VQ=;
        b=u/gWFElcFBOIbdroybSHlXiXA90VBQlLmdARdnaK5MEfbDkyQI9okVfniPKLOs/3GT
         YL1fabZlsK+pt6BUhVv5QhyYpQI+0mbcue4Fg9WGu/+pQeRJTMkdD9PM887MeMdqyGAf
         O+HjwL7xXvlCZVBO9US1VkkNxUECqqr7NSZFeH65CcG8kjFR8a90pGM1xZv6uT9qn6vV
         zU44JP/KY/Wd+oFhiVkGk2SSUh7vMwJuc0aUgiCeuTbxwHqx0OvTNkwYIzaD9NMJbSsw
         yOyQ2S50N6z+phfzZ7kB/KKwtIRxBrEK34gch5eGHUyXUmsw39biVsA5oi+1ktugWd5l
         jHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739395; x=1692344195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KC8RKz9us2GareLA53AAabGR+hAFqFb1dFQgL27Q7VQ=;
        b=QNz3PVAkJBwn9WF5iurH9mOx1syUP7NZgWsP3IrQmn3wzMYe8/XbW/K3lYfJdwCNnD
         S3NOH+sYoL3S2W/I//yMH/kM1+SRbYFpQGorYpuZ8dMSipArRCIvr7L5zFJyEHfeGY14
         V/zqxfloJaCxgZzehHm3mavnVvUMfeXpooOrCuxl2aj+hDeiNJ1cah/R0h4unJXyIv7n
         VUOzQkX1JzGo71P8a6F4Ou5wiMstWYHbCdXURXjB62SnT0Ce81DrahP9BH18QfXaHmNR
         ZJNQrPyojE+7RFxhT+ZyAopCoo54WA0n/j03fYNmu53iLozVH0HMw6pUrh+dh4Uwli+Q
         H7Xw==
X-Gm-Message-State: AOJu0YxOTIQ/L2TQo3uW1dNeGm8iQFz34NwjR7hYNhfxvDE5Zt3ARgIT
	kJzXZ81DXBr668yUHHsisaFIWyVvvPOcrw==
X-Google-Smtp-Source: AGHT+IE5Z0Nu2hFs74UEZagjik8CuXvuKQEPXs68pc/RmRYP6jP3GPZbCX2xKPgcyTTGqkpiTu4ikWlPZDk24A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ce53:0:b0:d06:3c3c:17eb with SMTP id
 x80-20020a25ce53000000b00d063c3c17ebmr12704ybe.5.1691739395386; Fri, 11 Aug
 2023 00:36:35 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:14 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-9-edumazet@google.com>
Subject: [PATCH v2 net-next 08/15] inet: move inet->mc_all to inet->inet_frags
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
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
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



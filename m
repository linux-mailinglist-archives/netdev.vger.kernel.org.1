Return-Path: <netdev+bounces-33304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A138779D5B9
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AB7281AF0
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433619BD2;
	Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56019BCC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BBB10FC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:26 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-412ede7897aso57136691cf.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534545; x=1695139345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpjZcek8rbp9hkfDbODMf5rzHgLfQsI9LlUf8P+2vA4=;
        b=QjfuqGN0Xm0z5j5FboBTPDcEfKJMdQlP3v4RPIujQW3jjup9H9RLhXkPplmb7JaqSE
         8yXaFDqL7j/EnUYRJo/JypF8NtnTNHfBj9ByE8C/b1SSScX3pIY/KU/Ogge55ZpzsWDN
         qmfF+AhPeN7ZqE0A2hBFJ9mTJ9ehhLcwwDY3JkYIbGyNB6z4yIZR0Q9LI6sv2fSv8hg/
         Kdw7eNE4BsScm3jYcICW4EOI8UxT6bfLtq3DHaWN9gjNUnLDg0G33iRF2+5oBQrhDtBD
         /kVA6F2Mrba9gHkOrDnJ3S075MmUIGTu4lLAWnBpKr6UCxaqxX5F9JLLWnLnDTLuDRpG
         bufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534545; x=1695139345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpjZcek8rbp9hkfDbODMf5rzHgLfQsI9LlUf8P+2vA4=;
        b=HyUJDl0LIinom7yROOM/z55wwiw9Mzccd60kaIWKlyFn9gQAptSE7zCsFSTAwokBzT
         jBQvpcX82xNCHzsaHZ50KxC23L1MWR0gWbfmRePYLER8Kk/mX1aSBev3u8NdDB2gu06P
         77kMGFHq6PA7EPzRfSLGrX5vcDllfRuqUbI7z3KsXXHs2eRWICSu69cFI7Gpn44Xrjtg
         HvLE4a/CR26R1T4muWYPGRc2CgQYB16ksJVc4aL+CIvH3ou0tjpoSplgf9ol9ycDIQZG
         YHPcLdqp3ck9th/KFnfJYe7HUEFvqTtbvmU0pJq5QiKNdZokOMnqumCGESRh1CnJY5uo
         V29Q==
X-Gm-Message-State: AOJu0YxXk1ATvZkohX314//PSROSOgvOUmnE3f3qS8HhgYNjnk93qT+R
	EhJTSsvuKqTtAHJBi2GcnYO34Tkr5lNCUw==
X-Google-Smtp-Source: AGHT+IHjHU4vGnwY9GxR04g0Lw24E3HVsBpgjTRy/MKJ/VCbvPiH3EJpeI4m4Gbd1CFlMw8LsO3IrQiAEgGZ2A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1a29:b0:403:c200:cd07 with SMTP
 id f41-20020a05622a1a2900b00403c200cd07mr255592qtb.4.1694534545654; Tue, 12
 Sep 2023 09:02:25 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:05 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-8-edumazet@google.com>
Subject: [PATCH net-next 07/14] ipv6: lockless IPV6_MULTICAST_ALL implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move np->mc_all to an atomic flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     |  1 -
 include/net/inet_sock.h  |  1 +
 net/ipv6/af_inet6.c      |  2 +-
 net/ipv6/ipv6_sockglue.c | 14 ++++++--------
 net/ipv6/mcast.c         |  2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 0d2b0a1b2daeaee51a03624adab5a385cc852cc7..d88e91b7f0a319a816488025ef213c4fb90ed359 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -255,7 +255,6 @@ struct ipv6_pinfo {
 				dontfrag:1,
 				autoflowlabel:1,
 				autoflowlabel_set:1,
-				mc_all:1,
 				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 8cf1f7b442348bef83cc3d9648521a01667efae7..97e70a97dae888e6ab93c6446f4f3ba58cd8583e 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -270,6 +270,7 @@ enum {
 	INET_FLAGS_DEFER_CONNECT = 19,
 	INET_FLAGS_MC6_LOOP	= 20,
 	INET_FLAGS_RECVERR6_RFC4884 = 21,
+	INET_FLAGS_MC6_ALL	= 22,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index bbd4aa1b96d09d346c521dab2194045123e7a5a6..372fb7b9112c8dfed09b6ddfdb37016a1a668494 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -218,7 +218,7 @@ static int inet6_create(struct net *net, struct socket *sock, int protocol,
 	np->hop_limit	= -1;
 	np->mcast_hops	= IPV6_DEFAULT_MCASTHOPS;
 	inet6_set_bit(MC6_LOOP, sk);
-	np->mc_all	= 1;
+	inet6_set_bit(MC6_ALL, sk);
 	np->pmtudisc	= IPV6_PMTUDISC_WANT;
 	np->repflow	= net->ipv6.sysctl.flowlabel_reflect & FLOWLABEL_REFLECT_ESTABLISHED;
 	sk->sk_ipv6only	= net->ipv6.sysctl.bindv6only;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index b65e73ac2ccdee79aa293948d3ba9853966e1e2d..7a181831f226c67813446145f8f58fa58908e3ae 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -469,6 +469,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		inet6_assign_bit(RECVERR6_RFC4884, sk, valbool);
 		return 0;
+	case IPV6_MULTICAST_ALL:
+		if (optlen < sizeof(int))
+			return -EINVAL;
+		inet6_assign_bit(MC6_ALL, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -890,13 +895,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			retv = ipv6_sock_ac_drop(sk, mreq.ipv6mr_ifindex, &mreq.ipv6mr_acaddr);
 		break;
 	}
-	case IPV6_MULTICAST_ALL:
-		if (optlen < sizeof(int))
-			goto e_inval;
-		np->mc_all = valbool;
-		retv = 0;
-		break;
-
 	case MCAST_JOIN_GROUP:
 	case MCAST_LEAVE_GROUP:
 		if (in_compat_syscall())
@@ -1372,7 +1370,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_MULTICAST_ALL:
-		val = np->mc_all;
+		val = inet6_test_bit(MC6_ALL, sk);
 		break;
 
 	case IPV6_UNICAST_IF:
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 6a33a50687bcf7201e75574f03e619fe89636068..483f797ae44d538009184b5e53ad7755d73bab4a 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -642,7 +642,7 @@ bool inet6_mc_check(const struct sock *sk, const struct in6_addr *mc_addr,
 	}
 	if (!mc) {
 		rcu_read_unlock();
-		return np->mc_all;
+		return inet6_test_bit(MC6_ALL, sk);
 	}
 	psl = rcu_dereference(mc->sflist);
 	if (!psl) {
-- 
2.42.0.283.g2d96d420d3-goog



Return-Path: <netdev+bounces-26655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FFA77884D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4291281B65
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0124C9E;
	Fri, 11 Aug 2023 07:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68D5394
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:27 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C3712B
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-569e7aec37bso20928677b3.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739386; x=1692344186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VwS8Cvlehl+VmfVUaIIwQk6PZ0aCIHf6oHrE1s1s7WQ=;
        b=3Z+ATvubC/aUq2fNtwaDXCb/4x2G8uom1z9B8oLk4Jb0Z/6qnYGbE34Mo/ILZDP19H
         Z0QdiONLe2paXIg4dNHgDFyHIR5BhOU78iV/zdZlToPCsmNDldCSfWQAxEmZqeR3S1XP
         yvYcD+Mh3YejzmTn3Uk9npMuPj8nDNvb8sxkyIbVKbrcULEdWQfAhZGoibIyxzGZMlFE
         0r2DCAM0qD+FADFSMZX4s5KqADRTkgOXTwcofV6OMw+q97VGm5vTdP4GLsdDLxS+CP2F
         YGeL9XlgoynbOUP9stGIneYArDl2e7isb5sbidjzcvYEAuFvGgAheervYdHHHuVLx32F
         seWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739386; x=1692344186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwS8Cvlehl+VmfVUaIIwQk6PZ0aCIHf6oHrE1s1s7WQ=;
        b=JtjDNazq0S4SRwK5Ro4TB7q2/mWlQ1dsv4dte3LBJW8GdVXAF2oPkMZyfIK9uon0cS
         B9ivOvRuShlfOllHdW4J4Id0p82uZg/lK3J0C4+o/1+Dax/0xykH+HqEG5Uvh2AzhIIl
         gZYF4lghqwXMYgIkKrYE9w1a7fD0AFXWZdXN1NkOyjJFnoGKSP3wE/M+3uQKfxr5t1DJ
         N8H0s5HOPOAQiN9GgO4eHUJ2TzrWD+RqsBzYNDVWFzflCYcPF8yVHM3BNQeGwF6+/Kr8
         +Aq4OmPFyLngyPJ9m26FVGNafrV3E/A1vrfTXE/yQQaB4J5f/55w6aQy6OtrB6kBs6PT
         d9SQ==
X-Gm-Message-State: AOJu0YyZy0EVwXkNl8gpDmhIodUDEUvOZIW68hIqurSUoRLQ7RF35Slb
	yqPX6D5OqehMgLOzAToxHYQmll63LEBI6Q==
X-Google-Smtp-Source: AGHT+IFWpG5W/Se5CzOSxRxqsQxOxW4wAcuiS1NpRE/Is2hRWD5YBWCoZnqSVynZ7f6qIZVkWMt6eXiN0OhOTw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b659:0:b0:584:4158:7f86 with SMTP id
 h25-20020a81b659000000b0058441587f86mr18820ywk.1.1691739386047; Fri, 11 Aug
 2023 00:36:26 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:08 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-3-edumazet@google.com>
Subject: [PATCH v2 net-next 02/15] inet: set/get simple options locklessly
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

Now we have inet->inet_flags, we can set following options
without having to hold the socket lock:

IP_PKTINFO, IP_RECVTTL, IP_RECVTOS, IP_RECVOPTS, IP_RETOPTS,
IP_PASSSEC, IP_RECVORIGDSTADDR, IP_RECVFRAGSIZE.

ip_sock_set_pktinfo() no longer hold the socket lock.

Similarly we can get the following options whithout holding
the socket lock:

IP_PKTINFO, IP_RECVTTL, IP_RECVTOS, IP_RECVOPTS, IP_RETOPTS,
IP_PASSSEC, IP_RECVORIGDSTADDR, IP_CHECKSUM, IP_RECVFRAGSIZE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 net/ipv4/ip_sockglue.c | 118 ++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 56 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 66f55f3db5ec88e1c771847444eba1d554aca8dc..69b87518348aa5697edc6d88679384f00681f539 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -636,9 +636,7 @@ EXPORT_SYMBOL(ip_sock_set_mtu_discover);
 
 void ip_sock_set_pktinfo(struct sock *sk)
 {
-	lock_sock(sk);
 	inet_set_bit(PKTINFO, sk);
-	release_sock(sk);
 }
 EXPORT_SYMBOL(ip_sock_set_pktinfo);
 
@@ -952,6 +950,36 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	if (ip_mroute_opt(optname))
 		return ip_mroute_setsockopt(sk, optname, optval, optlen);
 
+	/* Handle options that can be set without locking the socket. */
+	switch (optname) {
+	case IP_PKTINFO:
+		inet_assign_bit(PKTINFO, sk, val);
+		return 0;
+	case IP_RECVTTL:
+		inet_assign_bit(TTL, sk, val);
+		return 0;
+	case IP_RECVTOS:
+		inet_assign_bit(TOS, sk, val);
+		return 0;
+	case IP_RECVOPTS:
+		inet_assign_bit(RECVOPTS, sk, val);
+		return 0;
+	case IP_RETOPTS:
+		inet_assign_bit(RETOPTS, sk, val);
+		return 0;
+	case IP_PASSSEC:
+		inet_assign_bit(PASSSEC, sk, val);
+		return 0;
+	case IP_RECVORIGDSTADDR:
+		inet_assign_bit(ORIGDSTADDR, sk, val);
+		return 0;
+	case IP_RECVFRAGSIZE:
+		if (sk->sk_type != SOCK_RAW && sk->sk_type != SOCK_DGRAM)
+			return -EINVAL;
+		inet_assign_bit(RECVFRAGSIZE, sk, val);
+		return 0;
+	}
+
 	err = 0;
 	if (needs_rtnl)
 		rtnl_lock();
@@ -991,27 +1019,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			kfree_rcu(old, rcu);
 		break;
 	}
-	case IP_PKTINFO:
-		inet_assign_bit(PKTINFO, sk, val);
-		break;
-	case IP_RECVTTL:
-		inet_assign_bit(TTL, sk, val);
-		break;
-	case IP_RECVTOS:
-		inet_assign_bit(TOS, sk, val);
-		break;
-	case IP_RECVOPTS:
-		inet_assign_bit(RECVOPTS, sk, val);
-		break;
-	case IP_RETOPTS:
-		inet_assign_bit(RETOPTS, sk, val);
-		break;
-	case IP_PASSSEC:
-		inet_assign_bit(PASSSEC, sk, val);
-		break;
-	case IP_RECVORIGDSTADDR:
-		inet_assign_bit(ORIGDSTADDR, sk, val);
-		break;
 	case IP_CHECKSUM:
 		if (val) {
 			if (!(inet_test_bit(CHECKSUM, sk))) {
@@ -1025,11 +1032,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			}
 		}
 		break;
-	case IP_RECVFRAGSIZE:
-		if (sk->sk_type != SOCK_RAW && sk->sk_type != SOCK_DGRAM)
-			goto e_inval;
-		inet_assign_bit(RECVFRAGSIZE, sk, val);
-		break;
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
@@ -1544,6 +1546,37 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	if (len < 0)
 		return -EINVAL;
 
+	/* Handle options that can be read without locking the socket. */
+	switch (optname) {
+	case IP_PKTINFO:
+		val = inet_test_bit(PKTINFO, sk);
+		goto copyval;
+	case IP_RECVTTL:
+		val = inet_test_bit(TTL, sk);
+		goto copyval;
+	case IP_RECVTOS:
+		val = inet_test_bit(TOS, sk);
+		goto copyval;
+	case IP_RECVOPTS:
+		val = inet_test_bit(RECVOPTS, sk);
+		goto copyval;
+	case IP_RETOPTS:
+		val = inet_test_bit(RETOPTS, sk);
+		goto copyval;
+	case IP_PASSSEC:
+		val = inet_test_bit(PASSSEC, sk);
+		goto copyval;
+	case IP_RECVORIGDSTADDR:
+		val = inet_test_bit(ORIGDSTADDR, sk);
+		goto copyval;
+	case IP_CHECKSUM:
+		val = inet_test_bit(CHECKSUM, sk);
+		goto copyval;
+	case IP_RECVFRAGSIZE:
+		val = inet_test_bit(RECVFRAGSIZE, sk);
+		goto copyval;
+	}
+
 	if (needs_rtnl)
 		rtnl_lock();
 	sockopt_lock_sock(sk);
@@ -1578,33 +1611,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
-	case IP_PKTINFO:
-		val = inet_test_bit(PKTINFO, sk);
-		break;
-	case IP_RECVTTL:
-		val = inet_test_bit(TTL, sk);
-		break;
-	case IP_RECVTOS:
-		val = inet_test_bit(TOS, sk);
-		break;
-	case IP_RECVOPTS:
-		val = inet_test_bit(RECVOPTS, sk);
-		break;
-	case IP_RETOPTS:
-		val = inet_test_bit(RETOPTS, sk);
-		break;
-	case IP_PASSSEC:
-		val = inet_test_bit(PASSSEC, sk);
-		break;
-	case IP_RECVORIGDSTADDR:
-		val = inet_test_bit(ORIGDSTADDR, sk);
-		break;
-	case IP_CHECKSUM:
-		val = inet_test_bit(CHECKSUM, sk);
-		break;
-	case IP_RECVFRAGSIZE:
-		val = inet_test_bit(RECVFRAGSIZE, sk);
-		break;
 	case IP_TOS:
 		val = inet->tos;
 		break;
@@ -1754,7 +1760,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		return -ENOPROTOOPT;
 	}
 	sockopt_release_sock(sk);
-
+copyval:
 	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
 		unsigned char ucval = (unsigned char)val;
 		len = 1;
-- 
2.41.0.640.ga95def55d0-goog



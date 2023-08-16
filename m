Return-Path: <netdev+bounces-27959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F2977DC04
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EF41C20FA0
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA80FBEC;
	Wed, 16 Aug 2023 08:16:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527FB101CA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:17 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E826C94
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d63e5f828a0so7158900276.0
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173775; x=1692778575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SSSjGvn7TXOEkG6AWWxlrdNVmPkEOiGfw1zWv/cEec=;
        b=eiAeXNKuW8/jRWZK4/Mn2A+8eOAHzm8lXxrS9Rwfq28XY80/M/D2FZjWgdiyhOi2dc
         U5x4LYdS8mO/WzPmqcidYqxHwa5aLfe6vPqxIS9Zkwie9sZGYyA8So8q1GWuQa80g4WG
         Hmt0chG/iCqKgD0VddS1G9Nx9Lil1whYWmYpbvga4WFGGu7YeW4x9xXktEilRsXWI5p9
         Eb/FwKMHGAwvedGm92yHoFAnOi2RVz/fLglenGcHzNgncrHoAkD0GHYQQPXG8W8zKp+h
         h8dBj+WVZyj8zoblGCgvh5VNfn3sY/z4bRLJHrParaRZCjbR5S/g58mgmwxJmOsV7zJE
         sB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173775; x=1692778575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SSSjGvn7TXOEkG6AWWxlrdNVmPkEOiGfw1zWv/cEec=;
        b=WVENSeu9J8l9FCEJDz3MfH5bdEXtnrZDs10oCB4dh4K5vl/gWHm0lqM0/YpmrYmqPa
         Y7Z/XBqO4tyxT/4A/ABUa3mdtUIgp3FNNhG4EEXuzd1CU22Xy91d22KfqsDVgeCJD7lm
         VbMMf9x6hYiO0c7bC5+MVqwE/l8TL07N+CwmJAfX64/jpPigg9+Z6NMqlh0t4tphWc4l
         099QqRtPbGUlPCVuQz0OPNTfz9/4XfYN9SsJ2s3c2otxwYlmFZRLeVLCM48XdwLwiw/v
         7Onsv/DKIY9IHcr+ZTyIn0lNTTUG+a/bhbbSKVmMua6qQXQY8VmvfFdhM9BsvVmnLH0p
         neoQ==
X-Gm-Message-State: AOJu0YxU+rmFTAJRRFS1TqFmColfEvWqz1F0bqGKXpq6L78dm/CwMZfs
	vZpCzZe93qerljH+3rMtZ5Uul/mstENzsg==
X-Google-Smtp-Source: AGHT+IG4Qa5buDCrmPx4Ih2I3qHFxMMkC8Wxla33aylq6g+g9WmzwPzKwjO6fzUNyHAAAUR8T7ZAgZPaDpk/sQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:9f88:0:b0:d5d:6bfe:76d6 with SMTP id
 u8-20020a259f88000000b00d5d6bfe76d6mr16622ybq.8.1692173775245; Wed, 16 Aug
 2023 01:16:15 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:46 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-15-edumazet@google.com>
Subject: [PATCH v4 net-next 14/15] inet: implement lockless IP_TTL
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

ip_select_ttl() is racy, because it reads inet->uc_ttl
without proper locking.

Add READ_ONCE()/WRITE_ONCE() annotations while
allowing IP_TTL socket option to be set/read without
holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c | 27 ++++++++++++---------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 8f396eada1b6e61ab174473e9859bc62a10a0d1c..ce6257860a4019d01e28d57d3ce4981fe79d0a0e 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL_GPL(ip_local_out);
 static inline int ip_select_ttl(const struct inet_sock *inet,
 				const struct dst_entry *dst)
 {
-	int ttl = inet->uc_ttl;
+	int ttl = READ_ONCE(inet->uc_ttl);
 
 	if (ttl < 0)
 		ttl = ip4_dst_hoplimit(dst);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cfa65a0b0900f2f77bfd800f105ea079e2afff7c..dbb2d2342ebf0c1f1366ee6b6b2158a6118b2659 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1023,6 +1023,13 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_BIND_ADDRESS_NO_PORT:
 		inet_assign_bit(BIND_ADDRESS_NO_PORT, sk, val);
 		return 0;
+	case IP_TTL:
+		if (optlen < 1)
+			return -EINVAL;
+		if (val != -1 && (val < 1 || val > 255))
+			return -EINVAL;
+		WRITE_ONCE(inet->uc_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1080,13 +1087,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
 		break;
-	case IP_TTL:
-		if (optlen < 1)
-			goto e_inval;
-		if (val != -1 && (val < 1 || val > 255))
-			goto e_inval;
-		inet->uc_ttl = val;
-		break;
 	case IP_MTU_DISCOVER:
 		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 			goto e_inval;
@@ -1590,6 +1590,11 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_BIND_ADDRESS_NO_PORT:
 		val = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 		goto copyval;
+	case IP_TTL:
+		val = READ_ONCE(inet->uc_ttl);
+		if (val < 0)
+			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1629,14 +1634,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = inet->tos;
 		break;
-	case IP_TTL:
-	{
-		struct net *net = sock_net(sk);
-		val = (inet->uc_ttl == -1 ?
-		       READ_ONCE(net->ipv4.sysctl_ip_default_ttl) :
-		       inet->uc_ttl);
-		break;
-	}
 	case IP_MTU_DISCOVER:
 		val = inet->pmtudisc;
 		break;
-- 
2.41.0.694.ge786442a9b-goog



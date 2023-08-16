Return-Path: <netdev+bounces-27957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A7977DC02
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520AD280E7F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55195FC0C;
	Wed, 16 Aug 2023 08:16:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E12C8F3
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:13 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316E94
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d683c5f5736so3325673276.3
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173771; x=1692778571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LOAMP0wjVfGeiV0fUnlGMk+eOY521wWGzxFCXcBqHHQ=;
        b=ScrVW5Zd7scOsepFUurjjh0GpqCLiEXohGGVJTsFrlJghBn4HjpUDQKk1SFfsihxVK
         Od7V/wCwtG6J4VdVG83BDBK3OnHxkxb4uBSjPTE06JSQ/WpWyphVUQVwmSmDhYAdq9rN
         sB0MxxoAAMqEwk/fjVkqWee+k6EjY7kKiTNcVU8HiMmVZmEEwJHu4hKX91wsWWM27bfd
         AeGRogtHDx1AsWAsW0dfU8xubfwyNgoUiycGP9p385rHByK9yCUC9PUtk0VfIaWfR5fc
         4CiAywPXJzbtVRr4hkV0Lk8UJl30zJL+SgG6QFQYnrGo+n5wyjP2TUhYC/S/ZMbTblaP
         EPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173771; x=1692778571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOAMP0wjVfGeiV0fUnlGMk+eOY521wWGzxFCXcBqHHQ=;
        b=Zpz0nw5AcdHlCTXTqNeE/zkBi7DnYVl6VXcGjMOUXUs3S5F9eSMqy5JWbcK8s8tkeC
         VLtd48DRvAU2gdFGby3/HCK1Ef66gC+TyoN74dSEm+1RWwr6ywG9mdnnMqOkBaHhRhGr
         eEJTp3R5tFiT8gErj+hARcAcvgciDPuwYR8b0uTIGZacDFHTiubYwr7fwvMiEBnfvOHl
         Rzmxq36IvluRkj7mJBJX+ns+GLeNtWnW6rXRE89IPbFoWS4dkcjw0MLnUkPCUewXCYv5
         eZB1BBdhED38DoCq7y7vyn4lHLQjNJ9GvUh9rmEOT8P2Vx8pb1H9JOTpbfqGhD88/z1N
         2FnA==
X-Gm-Message-State: AOJu0Yy/UKN45ayrBaLGQIorT02oje2/ie+FlEKgLzWA9xk7k0/tQhNP
	lW+kyKyCQaQe7pOxUDl58Jgq5MQ8lVSDSQ==
X-Google-Smtp-Source: AGHT+IEqHJhEHHYA7MKjkVTnEqy0Zy6O+A+FhzUH8y1LQr0tqqkLL/pk7MdS8mn+SkF4mt6FAoAeo/czBiqziw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:2c5:0:b0:d0d:1563:58f2 with SMTP id
 188-20020a2502c5000000b00d0d156358f2mr12268ybc.2.1692173771295; Wed, 16 Aug
 2023 01:16:11 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:44 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-13-edumazet@google.com>
Subject: [PATCH v4 net-next 12/15] inet: move inet->bind_address_no_port to inet->inet_flags
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

IP_BIND_ADDRESS_NO_PORT socket option can now be set/read
without locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/inet_sock.h |  4 ++--
 net/ipv4/af_inet.c      |  2 +-
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/ip_sockglue.c  | 12 ++++++------
 net/ipv6/af_inet6.c     |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0e6e1b017efb1f738be1682448675ecece43c1f7..5eca2e70cbb2c16d26caa7f219ae53fe066ea3bd 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -229,8 +229,7 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			bind_address_no_port:1,
-				defer_connect:1; /* Indicates that fastopen_connect is set
+	__u8			defer_connect:1; /* Indicates that fastopen_connect is set
 						  * and cookie exists so we defer connect
 						  * until first data frame is written
 						  */
@@ -270,6 +269,7 @@ enum {
 	INET_FLAGS_TRANSPARENT	= 15,
 	INET_FLAGS_IS_ICSK	= 16,
 	INET_FLAGS_NODEFRAG	= 17,
+	INET_FLAGS_BIND_ADDRESS_NO_PORT = 18,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 2fb9948b5230bf21ee73437f3990ad30c4fe7ea5..26e7cd9cb059165f32eaecf4c1bf7252fe64ccee 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -529,7 +529,7 @@ int __inet_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		inet->inet_saddr = 0;  /* Use device */
 
 	/* Make sure we are allowed to bind here. */
-	if (snum || !(inet->bind_address_no_port ||
+	if (snum || !(inet_test_bit(BIND_ADDRESS_NO_PORT, sk) ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
 		err = sk->sk_prot->get_port(sk, snum);
 		if (err) {
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 39606caad484a99a78beae399e38e56584f23f28..128966dea5540caaa94f6b87db4d3960d177caac 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -190,7 +190,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.transparent = inet_test_bit(TRANSPARENT, sk);
 	inet_sockopt.mc_all	= inet_test_bit(MC_ALL, sk);
 	inet_sockopt.nodefrag	= inet_test_bit(NODEFRAG, sk);
-	inet_sockopt.bind_address_no_port = inet->bind_address_no_port;
+	inet_sockopt.bind_address_no_port = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
 	inet_sockopt.defer_connect = inet->defer_connect;
 	if (nla_put(skb, INET_DIAG_SOCKOPT, sizeof(inet_sockopt),
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index ec946c13ea206dde3c5634d6dcd07aab7090cad8..cfa65a0b0900f2f77bfd800f105ea079e2afff7c 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1020,6 +1020,9 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -ENOPROTOOPT;
 		inet_assign_bit(NODEFRAG, sk, val);
 		return 0;
+	case IP_BIND_ADDRESS_NO_PORT:
+		inet_assign_bit(BIND_ADDRESS_NO_PORT, sk, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1084,9 +1087,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		inet->uc_ttl = val;
 		break;
-	case IP_BIND_ADDRESS_NO_PORT:
-		inet->bind_address_no_port = val ? 1 : 0;
-		break;
 	case IP_MTU_DISCOVER:
 		if (val < IP_PMTUDISC_DONT || val > IP_PMTUDISC_OMIT)
 			goto e_inval;
@@ -1587,6 +1587,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_NODEFRAG:
 		val = inet_test_bit(NODEFRAG, sk);
 		goto copyval;
+	case IP_BIND_ADDRESS_NO_PORT:
+		val = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1634,9 +1637,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		       inet->uc_ttl);
 		break;
 	}
-	case IP_BIND_ADDRESS_NO_PORT:
-		val = inet->bind_address_no_port;
-		break;
 	case IP_MTU_DISCOVER:
 		val = inet->pmtudisc;
 		break;
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index d8c56c7aba96082976d7cf8dc26ab369a10549ca..368824fe9719f92b46512f3f78446fe5bc802ef7 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -399,7 +399,7 @@ static int __inet6_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len,
 		sk->sk_ipv6only = 1;
 
 	/* Make sure we are allowed to bind here. */
-	if (snum || !(inet->bind_address_no_port ||
+	if (snum || !(inet_test_bit(BIND_ADDRESS_NO_PORT, sk) ||
 		      (flags & BIND_FORCE_ADDRESS_NO_PORT))) {
 		err = sk->sk_prot->get_port(sk, snum);
 		if (err) {
-- 
2.41.0.694.ge786442a9b-goog



Return-Path: <netdev+bounces-26667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D8477886A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730601C20DBA
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B96FCF;
	Fri, 11 Aug 2023 07:36:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7B6FBB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D11E73
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5868992ddd4so22015607b3.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739406; x=1692344206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UMLpUluLENDH4N9gmhtp92yEoh+7NGF0JnjDU+TsY=;
        b=jPn3wMTZOBfoGSGLMrfgcizvMgzD48jJ5pPGzY8lQzTlNkCQVRCMoO4BI6RG1k1ioQ
         anR4PX2dNw99qTGhYZbps15Y/o8x2rNtzLdv6yUwtD7R75NwM7Kk20OT8CZMgj6uxErH
         H2qDy9jE78ETPxN7MD0YXQr8/yK3vF8CpbDzZ7D20MzEwQ0OTJ8NbqWRgZ6brMdwdqS3
         SDvl5u1whunaSiuAw28hgmcxr1hGubFDcxtjzru89CgiCCfE9oUfg3fFSoI8J6p44t+H
         MK8VU/Djf9QLyghT14MQUb/DyBMKqPb89dsNSkrWvSv49c6P1Cqmb7nkbsSmv5Fc0GBW
         B83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739406; x=1692344206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UMLpUluLENDH4N9gmhtp92yEoh+7NGF0JnjDU+TsY=;
        b=iXqxxTq6Lg2UthOxCel8XpM4+1Q/tEWCgflKRcexck8xkcoFrL7ZV4V18MOI+D//L4
         uSbcowT1WBcDrezfwbChctR9fWgibaE2InPlmt7S8czud8PqmBd2bEPfUpD8CBEjGTWU
         HTsk5zeiz5yQVr2g3g/l32wKqpbHaLhLX13bQ3kEU83HrDcyv6e5jWUb2owgjE+vaHoB
         bLRT1lNfxHYxg8oDa7fBjnVKrKu58GUA+GcBYy4D5nTxlp5s+mS4AuSk/Q1o4qNAVudu
         fNsYGaDFc+gdHJN4E5c/TndaCBUnB2I7AinvV8tpHZZ3ELrrOeB5Caj5w/QZaNs8WjjR
         JYwA==
X-Gm-Message-State: AOJu0YwJXbNcjxuoazWy/t2JdT8G2Alnavh/kS6eTdxRysBXS/l4p2zV
	n/UQEtIy0HhIPzHDRDe9e17RwX+GnvUMcg==
X-Google-Smtp-Source: AGHT+IGgqZOZI//tvdqzPujonP8TBSqfbeDB1WvHHujYeOsv4jD9eIcpSKZKlo4BUj6G7q3EK2jnvghXCE1l6A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d7d2:0:b0:d4f:d7a5:ba3b with SMTP id
 o201-20020a25d7d2000000b00d4fd7a5ba3bmr12532ybg.8.1691739406392; Fri, 11 Aug
 2023 00:36:46 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:20 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/15] inet: implement lockless IP_TTL
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

ip_select_ttl() is racy, because it reads inet->uc_ttl
without proper locking.

Add READ_ONCE()/WRITE_ONCE() annotations while
allowing IP_TTL socket option to be set/read without
holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
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
2.41.0.640.ga95def55d0-goog



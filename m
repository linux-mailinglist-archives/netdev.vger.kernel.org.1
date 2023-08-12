Return-Path: <netdev+bounces-27032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A70E779EA5
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C4280612
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5E8C02;
	Sat, 12 Aug 2023 09:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A741CCD0
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:34:09 +0000 (UTC)
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD6DA
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:08 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-6418e96c601so17431626d6.3
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832847; x=1692437647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UMLpUluLENDH4N9gmhtp92yEoh+7NGF0JnjDU+TsY=;
        b=GwfT+ISQ+8t/jAgO0c6EMCLVBIyN+QgUOlyVrgAK4nKCUcNWSENxwmclwFzTmk0wWK
         TG2wip6fXOdVf06cdCXHc7RRTxNUesOxOgEVaYimoby8QrOZ2PVW4EK2PvEDhgIA7hfk
         pH1ph0nhVhumcsHLxkZonNZIdBpBCk6l1ogr0NAodoOQaQOaHEs0Rt6r5rx4tCbuHJam
         icQw/qMkI+0VRE0KlMMBJLZu5qauj/RtNv49xysXRKPni361RPco1aIBLArja9xGcvpv
         dpU3aESuyTsnNLsiiEl++ndw3oEQjmwv4IyR2oaPapSFgOwpL0eXE02QE+9OKkcpDv6j
         eFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832847; x=1692437647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5UMLpUluLENDH4N9gmhtp92yEoh+7NGF0JnjDU+TsY=;
        b=UimV15S9wXLfV24IBe0+l7hnPcgN0M+fwNeGyAJoQlW3tiZ4rfmUR9sXqbKMovZTbJ
         MZAjxoNkK9mC9wpR9HmDrXGoXz4fJgCJLMisnzDhwrQ6nWTY43n1avNZS5bA+DXaFuOT
         hD7LsvCeqyeqPDp5G+o0yFHaGLg1mhJMKDzs3SOhZbEIreLKPEJ3Z2RFpWHGMYcmYNoT
         oC0PU/413iAuH6PUw0ZGy/PzhPPCpFrYy9iRrkeYPz+VgPafwmDj1ebb5BykOUpfGyIy
         yVR90MYT0smeEIS3td9i0MxpKEbZo5IvWoEv1GPpHrRz/tUxPzLpomen1r+aZZDb1L5B
         sudw==
X-Gm-Message-State: AOJu0Yzx3r+gDhGpOjsU+F8G6AikNNaloWE9QEcOixiGB5xTgz9SXNs6
	uiFYQb1Ai/PXowqmExwYbnlWPDE1YixNPg==
X-Google-Smtp-Source: AGHT+IE6bvPj/VunXRxBo5D3rsx+3GyQQ2nviTmrgfB3Bi7WZtKKxrgCuZtSPAe7/SgrveeHyH6VWh+OfHJong==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ad4:5591:0:b0:63d:38fe:1657 with SMTP id
 f17-20020ad45591000000b0063d38fe1657mr49511qvx.7.1691832847236; Sat, 12 Aug
 2023 02:34:07 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:43 +0000
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812093344.3561556-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-15-edumazet@google.com>
Subject: [PATCH v3 net-next 14/15] inet: implement lockless IP_TTL
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



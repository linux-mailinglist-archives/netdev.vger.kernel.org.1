Return-Path: <netdev+bounces-26668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F5B77886C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784D11C20B3B
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D76FDA;
	Fri, 11 Aug 2023 07:36:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF376FBB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:49 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CBE73
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586b0ef8b04so21945217b3.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739408; x=1692344208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRXx54Rrv0R6ZUU0HGrbxO1CZZxe1cpmwnOg0j7oCL8=;
        b=d0pAwkQ5bFXwMNexWwnoPB09NymFMwaF+ZcLVGtwniUZvESHn9xo9Qt4t+DJ4u1R7C
         vLWu2Iq3Wm5WJ5uFS1jA102j1cu73MkMNfjeBlP0e9bUXbHr0a9IA8fHEMn8YVepGS0e
         RTMlgiKBhX+M/O/ZIEGs1qKpReb/WjAXrrC5G4aqoWQvks9SRZPUq7o0coYEpNaqPD1w
         wp7q9JZmruq/4nVXEOp/aKrCFAbP1V5usauGXUdLIncm0RLU+LlwLpCY2BvxedymyA8l
         SXE/EEAyJdcwFF8trhDsjVJgC1QXzod4Y4l2clhct5t64xSW+uLoENUej7sjqDEP1GHN
         AV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739408; x=1692344208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRXx54Rrv0R6ZUU0HGrbxO1CZZxe1cpmwnOg0j7oCL8=;
        b=HyryHtfA0SLptuyHU98Ot1LWD41++yJgAfVbH6Lf8V90fH2sgkowPqx3SQsBOyUdu1
         v5TjCBX4L/gRTEkoBoYQqNtRiYrtV1IeM2WV75thnYZlU3GlRkMh97TZNUhdIcDnyAwi
         8mI7OEoD9cVHv2bUReqHoFptQ2xGnVID/SQEn09OSCOQRbxjtLS5TelFUxvd2IqkW85W
         Lu9rPo3CV4PR3HvF6mu64lTBd83CjY/sUTQdAc1r2EZgvNAuiibzdMrFin6J9wJXyQ39
         DzjJz1QMYx9S/RYfIjVTr6UuzGcWhQXVLpqaZ4oep8fdEL0jKwUapAuYt4G2UFihLeB/
         TpZQ==
X-Gm-Message-State: AOJu0YyMcepV3AyQ/3sChs0DUQL2zSUxUTbjfO2lIANlHYj2ywtD0/6C
	6F2F7MliC0lBDisYjJsSKbO/fJ4T3PrU9A==
X-Google-Smtp-Source: AGHT+IEvnsOoyI5jBGG4kymeZC36qUNhF0jlycQ9bWCyjnAEww/d2e6AwUFxMjP8Yn+XJleQqJ4uS0T8D9phmw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:af42:0:b0:573:5797:4b9e with SMTP id
 x2-20020a81af42000000b0057357974b9emr17215ywj.1.1691739407775; Fri, 11 Aug
 2023 00:36:47 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:21 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-16-edumazet@google.com>
Subject: [PATCH v2 net-next 15/15] inet: implement lockless IP_MINTTL
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

inet->min_ttl is already read with READ_ONCE().

Implementing IP_MINTTL socket option set/read
without holding the socket lock is easy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 net/ipv4/ip_sockglue.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index dbb2d2342ebf0c1f1366ee6b6b2158a6118b2659..61b2e7bc7031501ff5a3ebeffc3f90be180fa09e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1030,6 +1030,17 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet->uc_ttl, val);
 		return 0;
+	case IP_MINTTL:
+		if (optlen < 1)
+			return -EINVAL;
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		if (val)
+			static_branch_enable(&ip4_min_ttl);
+
+		WRITE_ONCE(inet->min_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1326,21 +1337,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		err = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 
-	case IP_MINTTL:
-		if (optlen < 1)
-			goto e_inval;
-		if (val < 0 || val > 255)
-			goto e_inval;
-
-		if (val)
-			static_branch_enable(&ip4_min_ttl);
-
-		/* tcp_v4_err() and tcp_v4_rcv() might read min_ttl
-		 * while we are changint it.
-		 */
-		WRITE_ONCE(inet->min_ttl, val);
-		break;
-
 	case IP_LOCAL_PORT_RANGE:
 	{
 		const __u16 lo = val;
@@ -1595,6 +1591,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
 		goto copyval;
+	case IP_MINTTL:
+		val = READ_ONCE(inet->min_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1731,9 +1730,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		len -= msg.msg_controllen;
 		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
-	case IP_MINTTL:
-		val = inet->min_ttl;
-		break;
 	case IP_LOCAL_PORT_RANGE:
 		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
 		break;
-- 
2.41.0.640.ga95def55d0-goog



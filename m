Return-Path: <netdev+bounces-27960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD277DC07
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 10:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608381C20FBD
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF94101DB;
	Wed, 16 Aug 2023 08:16:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A6101CA
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 08:16:18 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB6594
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589c772be14so90577907b3.0
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692173777; x=1692778577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEC+E5TPz+/nIgmiseA3B21BwEML9CKbkuh11Wihp/Y=;
        b=sS6Djgk6Ob6R+V5mPxIPu5p9rfofmqGpNgKh1GeqDRF9Vt4KgkNwfCm3Ftx0ytS76E
         Jhl9qVu5z+Z8Fn0bXE2W5k4zb5ZlisymYhQntoCUzcz9kal1fu/3XKLE5QSeY/fY2E7S
         fQPVLjxIUPNAJn3K6IA4yanI7rAmijAKnW3nHcKBCojd+M99Tx7Pv/Na40ex9Ja7TSd3
         h2StSvufTRbY87yBYNyhSdrndxfg9vtqmMZ4yK8Kd6wmcmxOSIf1AWbQQNjhRBdQXQZA
         6/0aEHcP/5IMrtbATlZvJixStF1cdmxfNAViV2m+1SSOH9bKHvwSvaCMxSAWEBeRbp98
         qC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692173777; x=1692778577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEC+E5TPz+/nIgmiseA3B21BwEML9CKbkuh11Wihp/Y=;
        b=MqEV83Uadmw8o/QXuh+Ggx9ugu7+fZNCuxbDFfKeKvyskYINsH6ZoxvSVWp0XP+mIg
         ZilVKYN+Cw0KsYvtBxEpbcRf37456fbpPDGd++AX/iqDqAqqLtNd+BJ1APw/2YTGHJT6
         oyGmFQo8zcHuAGqplTRJU20+qP4FUNfB2N4IzCoECwH20tJA9Wpmo6ozeP0Ul5pAH+Id
         TEsfHFe+cJQqfI/heRp/z1nS8zd34XxCpKZPcTnc7taeroqac0ymayHOS5FsO7hqdrcm
         lHmOZwuqQFfBpYh4H4tKQUeEC6/ybMCJ5Qm917eARU9hD0okW0XtVPXsp8sjm9NmOXui
         sKMA==
X-Gm-Message-State: AOJu0YyzYZmbfYd0WKbeSK2vMVCwB5qzgBPneMUbywTcnTe1XV3efI6K
	TUqX+e5YLbyCrkLLFkxoDwJ8BTiNKHEQ/g==
X-Google-Smtp-Source: AGHT+IHGCcQMCJ+IQFAwZeNp5nS5w15o0o6SUwUmco6j5RWAp9hMk3+6Pa1ROYs4UbrvRLnz5TjGZm5WNI0bRA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b706:0:b0:58d:f40:e69d with SMTP id
 v6-20020a81b706000000b0058d0f40e69dmr8994ywh.0.1692173776984; Wed, 16 Aug
 2023 01:16:16 -0700 (PDT)
Date: Wed, 16 Aug 2023 08:15:47 +0000
In-Reply-To: <20230816081547.1272409-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230816081547.1272409-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816081547.1272409-16-edumazet@google.com>
Subject: [PATCH v4 net-next 15/15] inet: implement lockless IP_MINTTL
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

inet->min_ttl is already read with READ_ONCE().

Implementing IP_MINTTL socket option set/read
without holding the socket lock is easy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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
2.41.0.694.ge786442a9b-goog



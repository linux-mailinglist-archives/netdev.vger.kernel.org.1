Return-Path: <netdev+bounces-27033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CD9779EA6
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839F21C20355
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96FD1C37;
	Sat, 12 Aug 2023 09:34:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3DF8C0F
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:34:10 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153BDA
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d68c0f22fc9so575963276.0
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832849; x=1692437649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRXx54Rrv0R6ZUU0HGrbxO1CZZxe1cpmwnOg0j7oCL8=;
        b=hpIa1tSwBK8uTz7VBSIoUWw2OL2BlXwh5Ph+0M8R9BQVzU3ZYxWs6sh1pX8BYinhlN
         sw8Gr0q3h/ufjDOouFWoQaVC7qPPMtr8zZnNu0K01o9gNNd8AlF/Jn3RA5EIAuBiSkOk
         9hu1QUOD6WLBI1hDAS8rstk/l9dWgGCHr5CeYv1z8vvMrZWeeBA2LeomT0MsYg+YnQYi
         z63U4x7aLKomtLPX6eSuzjjGEC58e1NAAG1yVyRaxEkJPNAvmTw5N9FKJS3NiErIV6VR
         EO06MMpstCAn+NkulwolSfLAy4J6Dw7w0HpF8GdDOtA9raH8E/9yxlAATQ262DpKYW0l
         WJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832849; x=1692437649;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRXx54Rrv0R6ZUU0HGrbxO1CZZxe1cpmwnOg0j7oCL8=;
        b=ToSsbVODdiFmVF0sw1//yLKBUtOvfEvIfm3k9ouh7+lbTq6r+odctWHZU1/1qgDilx
         ++xCnntiWh/LrPu58O0A0zKe/b6SnLpJWW/mjOZiS79Kyhv59bFZsFfac7TufdsD0VGV
         ak1VOsyEQbTu8+UyfUINrezLhweb+Y1Y92mVrWGKQ757p6+/NHXXNlxEQkBnuITBQOXk
         S1uwpOkdiUOaQ2JapW154NFcfLF0JobXZvEVAyiisqMwmKXakowzvIuUnETGMbag3Dva
         AjMWdFgdcjtyAs/xz5x9X58Ke72KTXRNVmaN/NSAyeWGk627IHdj5dOOTE13qdqQhAap
         UxsA==
X-Gm-Message-State: AOJu0Yzo4my+FutPVyHN1av9vCsBLk/qKCgc2lfT6/6tH/ua44aD39zl
	3wb2rqQP2ymk3FQ0SjAlBVfrqU6QU4b8iA==
X-Google-Smtp-Source: AGHT+IH7EydZMaZ8A2UIT8Yth/ZkKm26sPYUD+mqlE2KpFfFFCb80bC9Blc7IT66BZIF9z/DfMX+F7tP7s4tOQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:23c9:0:b0:d47:3d35:1604 with SMTP id
 j192-20020a2523c9000000b00d473d351604mr85247ybj.2.1691832849156; Sat, 12 Aug
 2023 02:34:09 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:44 +0000
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812093344.3561556-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-16-edumazet@google.com>
Subject: [PATCH v3 net-next 15/15] inet: implement lockless IP_MINTTL
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



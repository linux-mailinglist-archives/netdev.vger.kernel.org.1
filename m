Return-Path: <netdev+bounces-35498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520957A9C4C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B946B1C214F3
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7749998;
	Thu, 21 Sep 2023 17:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314F48EAD
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:56 +0000 (UTC)
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007E16C52F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:32:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-4121ae638c2so11689941cf.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317570; x=1695922370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gi7+E6DCygLfR/lHNV28J0YHAZQjKMKH6TJogCwaNk=;
        b=vUTBS2qii15pmLdZf8p3fSs1yO+DTwYjsiXp5d94Aut3RScWyrwxgw+JOiKDJvYHpr
         X6Xs8mEJTWfsLqhrGumUxAblS+JLg7NQYodH7922aSS+nBWQEQj4j5MjWB9De4OiTxbq
         MWWq15NFNolCwdbkLBq9BCnW59o7yrJ12ZgC3ID29K1MOwnBWbHHMcjHzfLIHyCYeNRy
         T6tovGj7ApYb8sX2w2omhWooNE0jYSyRQFskK1//LDwKoI0HzhmriJB8/IhVHdLUtvFs
         dmMaLGDWwjpFYjzgw6EYioD8tlampwsfetXkCi6AstZ/lR1J9WxhPuUsPek21fsQkmR2
         nDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317570; x=1695922370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gi7+E6DCygLfR/lHNV28J0YHAZQjKMKH6TJogCwaNk=;
        b=rKXFSFsk+QCVxa/fb/jn3zAUkI5ZE8O6uvCQKTkTDj0CKZaTBtZe5aaJWpoWkUYunK
         LpeGedvz6nWRgKEXuajUSX/mS2XLnz8WrleRs0oGdd9SToa0M8FCuK/ukiPHKmUGuT+I
         bmHVKc9XpO/UAY10jTSCGLU61QFsd4ups7gk51xyjdmhqwjvKliZYWniyvaUD2BoYjN2
         xZ09OxxzBv88G71VIb7MPPSU9gAOacGag8OlDIC+5LtaadEB8CyUXeWDgkzDkLnBwCpN
         IYFl2mKbjI1UFU2zAqwXaZhS+6gOAHTJ7BPYN8/9oqJVBlfuq3vqFOgaC05kpUkslmW4
         jRug==
X-Gm-Message-State: AOJu0YxHt+hWms6SRp2bocMlxArtLNomKGLhmAnu3ZBF138Gq+dzTqaa
	m1WU64ZB5k9C5rpY1DLa07ItWNLDg2sX1w==
X-Google-Smtp-Source: AGHT+IGyHqYPR8/9LVDD2iB1EUhQm3ztTovaSLx97WSee69auxvijWyq9xUZJnK4ZQwLCANL1IHspNI1w1LdUA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:d30d:0:b0:565:9bee:22e0 with SMTP id
 y13-20020a81d30d000000b005659bee22e0mr83975ywi.0.1695303032964; Thu, 21 Sep
 2023 06:30:32 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:17 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] inet: lockless getsockopt(IP_OPTIONS)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->inet_opt being RCU protected, we can use RCU instead
of locking the socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_sockglue.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 50c008efbb6de7303621dd30b178c90cb3f5a2fc..45d89487914a12061f05c192004ad79f0abbf756 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1591,27 +1591,20 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_TOS:
 		val = READ_ONCE(inet->tos);
 		goto copyval;
-	}
-
-	if (needs_rtnl)
-		rtnl_lock();
-	sockopt_lock_sock(sk);
-
-	switch (optname) {
 	case IP_OPTIONS:
 	{
 		unsigned char optbuf[sizeof(struct ip_options)+40];
 		struct ip_options *opt = (struct ip_options *)optbuf;
 		struct ip_options_rcu *inet_opt;
 
-		inet_opt = rcu_dereference_protected(inet->inet_opt,
-						     lockdep_sock_is_held(sk));
+		rcu_read_lock();
+		inet_opt = rcu_dereference(inet->inet_opt);
 		opt->optlen = 0;
 		if (inet_opt)
 			memcpy(optbuf, &inet_opt->opt,
 			       sizeof(struct ip_options) +
 			       inet_opt->opt.optlen);
-		sockopt_release_sock(sk);
+		rcu_read_unlock();
 
 		if (opt->optlen == 0) {
 			len = 0;
@@ -1627,6 +1620,13 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
+	}
+
+	if (needs_rtnl)
+		rtnl_lock();
+	sockopt_lock_sock(sk);
+
+	switch (optname) {
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
-- 
2.42.0.459.ge4e396fd5e-goog



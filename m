Return-Path: <netdev+bounces-35476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396C7A9A7F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10D22821FC
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF832179A0;
	Thu, 21 Sep 2023 17:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C135168AB
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:02 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BB90A7C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:47:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68fc1bbc95dso1251538b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695318433; x=1695923233; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ouHl5YF533nNZDFaBTekrHgU3NYIj0h3vkwt42TyVo=;
        b=nG8qOS90bdz5odtT/jj++Dc1CnSLEQ94WXiuZB07dWnj4gItfrYdx7F2+tkCMwMe1M
         5lxshhpS5PB88gDKdBC/bk3zfqVYT+UBqy2mjX33/a8O8rv4B3kstZdL10gdfDiyT0ky
         vauBV7kPRkhWREs5pzwbBMEeoKppK7+0o/VC5GmwM1AyEYV4PM6aNTcQ1IzAqLnnVOm7
         S7YT0bWd6wb4yL8PGw2PLjurlcfWVyMgB0V3FEpXltywPcgUaH5FhzpyIn1ughWoxkSr
         Cw79nbhuk4HmdTi8E/4SfIpbkyOcwtXQ+veDgqDYq45t6ucdHx+nrVookK62LJ68pg3h
         AApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318433; x=1695923233;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ouHl5YF533nNZDFaBTekrHgU3NYIj0h3vkwt42TyVo=;
        b=IHVhfbSIm6CQcyhfNwHpTbos9HBv947COUoibQd6B/a9cl9qkVxqjCbygH8IvYJa/1
         Kldao09YOoos0lDirAiVVO2W2T7J14DBAaxbU0Z3ETfIAfkUV7aXsW3FUyowPPyYkJ2+
         I6zipTVqgdd1JsvmJUv+uvgUad2SXQicAW6W2CetK5Q2PIr1p0OHIBm35JCO2WmBjNC9
         AeYEoClIY43uAtxZIxcXScNDx2EXXITdsjbDVq5sbjjAcKUNcA4HAagE16o3+3PAGVD3
         rYiWYu4hrZwG/agtuScQVem3DjFEc1KAXxWgsgI9vUx3QqOW4PNnqqEIKnRPzoOuF9N8
         X7fQ==
X-Gm-Message-State: AOJu0Yxp22VhbWMjwcQyRzsa8meO9enXDRjFcPK4g4UbvwsVYFZvOk4O
	rN5RQmPPkpBASN156snK7P5laTCZVOlryQ==
X-Google-Smtp-Source: AGHT+IF6cV7ZM7qUZSaI/1T9wUw7z/JpmTuCiGmGFbsd8xQ9PRZAleCj8wqqlku8cqR9/GHJgamy/1ezslOp1w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b14a:0:b0:58c:b45f:3e94 with SMTP id
 p71-20020a81b14a000000b0058cb45f3e94mr82341ywh.8.1695303034763; Thu, 21 Sep
 2023 06:30:34 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:18 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] inet: lockless getsockopt(IP_MTU)
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

sk_dst_get() does not require socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_sockglue.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 45d89487914a12061f05c192004ad79f0abbf756..04579e390ddd4dadb8a107ef0b5da15e7a60f1ff 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1620,13 +1620,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
-	}
-
-	if (needs_rtnl)
-		rtnl_lock();
-	sockopt_lock_sock(sk);
-
-	switch (optname) {
 	case IP_MTU:
 	{
 		struct dst_entry *dst;
@@ -1636,12 +1629,17 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			val = dst_mtu(dst);
 			dst_release(dst);
 		}
-		if (!val) {
-			sockopt_release_sock(sk);
+		if (!val)
 			return -ENOTCONN;
-		}
-		break;
+		goto copyval;
+	}
 	}
+
+	if (needs_rtnl)
+		rtnl_lock();
+	sockopt_lock_sock(sk);
+
+	switch (optname) {
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) inet->uc_index);
 		break;
-- 
2.42.0.459.ge4e396fd5e-goog



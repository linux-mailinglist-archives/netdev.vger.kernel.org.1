Return-Path: <netdev+bounces-35651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019F97AA75F
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id D641F1C20B8B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710CA5B;
	Fri, 22 Sep 2023 03:42:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF1B10FF
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:33 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B57CC
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c0eb18f09so23256837b3.2
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354151; x=1695958951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lN5SHdGTtSiIBimeJqkKHD15hOXuYc81ODJ2mQLbnM8=;
        b=blc/nKwJba9AgQfRbYWPGTKSeuk/544+WXATHnnVhM3VAcHuMkg81r+FZ/DKyG5kJ5
         EqlQGSpeOJvpMz7y1tBN46mr3Zu1WW9BW9XoOObHIbUJpp5PYI2892Ff1aGOsafbjaXd
         1xmzr3lDVnye845SpzYCBmoUOjxTP+L3fcZn7y9tjhP+9anPEStuxPjsFL7YUdIaeLZU
         8dOEp680xg4qRxiSGmYYothwShz23Ol7rE2Q5oRZaZkiTdrS9OyAJFMFKDQfaSm4Rm7s
         JMno23sutOaTe5/sh7OmYALbW98t9sMwUBeVo4iTjvuAF4iRiU4ECSkZ58RF/P0AvkOz
         FzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354151; x=1695958951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN5SHdGTtSiIBimeJqkKHD15hOXuYc81ODJ2mQLbnM8=;
        b=mO2vzjW+ubvCchQCN0ByDRwWW7/dZ0nHHX37ZmnhzRu7I4VXDTahjj3sLmGQlnjYPd
         qUjDAliWO7FkjBZACF4nbjGAcCOcvMiG+Ad06KIDFFupwaP1QJTTtiHmmn8xbMUs2twS
         9Tqh8C5SLMFqE6MBrGehELMaysY51J+c5DOR9EtaaX9SCtZhVsUn3VQgdizMpMZHDrhg
         wJD5U03Fu117zF9f/x8sVMbjIMvsO51heea8XZyk5fW6wOw6NRIoDtSQBWoM0jd7m0+c
         U1ydt7uxwHJSOQ4LCCysdjvBwycjtAIMuGo+BWD4s9nCB8i2t4j0VzSWD3jRQbzAa8vr
         7+qQ==
X-Gm-Message-State: AOJu0Yzvsam3F+nKSz7t3zxLxPQrhzOvF1zsvaJItVmQdYXm07Fa+KYZ
	SaXCiExuYq2za1hvkVC/WBDvfpaMZuH2NA==
X-Google-Smtp-Source: AGHT+IEm2/XBA6F4BSgrsxDukIw4lakWVVxYmNhH555JIjJZysCvRs0v3GbeS82mPJRfi6Lb9ZsOxJW6xya7Hg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c842:0:b0:586:a8ab:f8fe with SMTP id
 k2-20020a81c842000000b00586a8abf8femr128485ywl.10.1695354151164; Thu, 21 Sep
 2023 20:42:31 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:18 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/8] inet: lockless getsockopt(IP_MTU)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_dst_get() does not require socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.42.0.515.g380fc7ccd1-goog



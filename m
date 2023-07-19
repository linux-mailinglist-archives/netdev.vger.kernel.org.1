Return-Path: <netdev+bounces-19256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36E75A09C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E59C1C2121C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DD4263C3;
	Wed, 19 Jul 2023 21:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB51BB23
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:23 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BF31FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cac66969edaso79885276.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802161; x=1690406961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MizDMz97Shkph5Xt6Ug4LWphLAOE0oV4Nx/VzQY4NyA=;
        b=ueARASIvpL2aw08l17nTfWh6P6ZnS26N2IYLu3+T9eNwktqtlUvymFO1OMMtJUWkvL
         uQDOjLtyN5DAxT6R5Yp7OxNrK4FZIsbK4nRvvXhpbM7DtVmwyS/whBxv8lZLgaRfuFUT
         FndGXDxqeIiztn7LmsPcSQSz4ypFVcS1IyHyzakSntyRCNxTKD8uYAG30zEFxJDqqqYJ
         M0d66b8bivPuTAtlZkfJwMmGlORPXgbmWAoNtNPWaaTGQBZ5oqJAmTBAzitNTm76DzRm
         ilcyXUZdrW5mlmckONcpBAysHtchlUlSd4Kc1uvwyActC7zY+4OjtCvtIAPwQ5PHzKC9
         Pbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802161; x=1690406961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MizDMz97Shkph5Xt6Ug4LWphLAOE0oV4Nx/VzQY4NyA=;
        b=QqVHENheTzQny/0JWd/PA5wo5BVDt9oce76Bhv6MfiEiu5VeC//tqJ3GrHcyU2JA11
         44nzLRr8Xjoq7q8MyJbtZG5Tav1yGtAlIIicSUs3hIQyWwbHgGWrf4ArLAoK97stgnTg
         pjqE3ekGR+HebvPyII95WV2U90pzPDyML2GrNWeENE2tk4tgJ9GEp4rxb4b148ZK574f
         4lRNNv7ORfNwo6CApPBByXnmmj7IzwTg8EHxp7DlkETd9Veg8RVxZxGjUa8Uk1wUlXO7
         96ycNtiMa0p7uP7xx4RAlaqa/zuWhISHfNws7o1PZ3MgmbhiQfty3aRComY7qHVZ0yd1
         xvmA==
X-Gm-Message-State: ABy/qLYvUbwcr/re/YQsBxsbasX+RGFW2sm26fTdQH690kBb1vg7cu9i
	KYsUYXpDnEuH4z9hH9tXJN55iChCYVlivg==
X-Google-Smtp-Source: APBJJlEC7IFf7oniWHiMmltXB0fz1JMt0pvYD/KWA8CLkpyY6KoZW0+QWScGweplipAVDHrLrxz3K/NqERUGDw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4889:0:b0:cf0:df68:4106 with SMTP id
 v131-20020a254889000000b00cf0df684106mr32871yba.0.1689802161749; Wed, 19 Jul
 2023 14:29:21 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:56 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-11-edumazet@google.com>
Subject: [PATCH net 10/11] tcp: annotate data-races around icsk->icsk_user_timeout
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This field can be read locklessly from do_tcp_getsockopt()

Fixes: dca43c75e7e5 ("tcp: Add TCP_USER_TIMEOUT socket option.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2b2241e9b492726562a6b5055cf8c168e5fed799..3e137e9a18f552a02d8c74e1af34ba2356e4d8ed 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3300,7 +3300,7 @@ EXPORT_SYMBOL(tcp_sock_set_syncnt);
 void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
 {
 	lock_sock(sk);
-	inet_csk(sk)->icsk_user_timeout = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
@@ -3620,7 +3620,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			err = -EINVAL;
 		else
-			icsk->icsk_user_timeout = val;
+			WRITE_ONCE(icsk->icsk_user_timeout, val);
 		break;
 
 	case TCP_FASTOPEN:
@@ -4141,7 +4141,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_USER_TIMEOUT:
-		val = icsk->icsk_user_timeout;
+		val = READ_ONCE(icsk->icsk_user_timeout);
 		break;
 
 	case TCP_FASTOPEN:
-- 
2.41.0.255.g8b1d071c50-goog



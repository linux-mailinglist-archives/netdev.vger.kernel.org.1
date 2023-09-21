Return-Path: <netdev+bounces-35606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D767A9FF7
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096B4281BE9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB618C14;
	Thu, 21 Sep 2023 20:29:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604EA18C10
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:34 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44155B0A0D
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8571d5e71aso1811055276.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328110; x=1695932910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qyV5WHxWVII5mkdNPEEENpDYgzi1DdHY4B8bVN7gKMQ=;
        b=36vKtRusGaDBXhIZ8rNRHbRzkA1kWvkOJkc1N8VMdqpjBzvc7Lv2nV50fA4PicTfEj
         n/A2rmYHmkNrlBkr/4JhjJGO3dIUI8UWCKCNfCrCsgaBlU97olV/PuhsXoWkkhvjl7ry
         B0UFMm5WgPxNfIj3PzfUaiqj2KigvMLRHgIPD5jOBNc44GD/bLoU4gtCj/zpeJRtelfb
         k6kIJUT5sUu9CvSYAngwYtxWWRp5g5meR2qv5uj+YnaPVIGaolfmbZ4/l/8FZ82CGD9y
         HUI46+TQrOtbjMunPbPbSl+E+K+W9wGsaCFUITelizFpygiKLMpVDp9KG4vUoaqDxPJs
         fjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328110; x=1695932910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyV5WHxWVII5mkdNPEEENpDYgzi1DdHY4B8bVN7gKMQ=;
        b=gNu3aY+ctq3xMepdCc0B0mDa3Fd0c6JD0w0EgYK9Y5Qr3oJVeTBo2DPGZPAskymxJs
         UTPwKwDNJ9+JDMQGCt8yB3mira0KWDAAHW84zBettELxnZlirmOs3EwNPJBvGJuI/RSx
         ZmEauWYGHuwrAn4oR71Kgla2TZR4LonrgEA/8AivCHq95MgmeIQursHJCpIcfyFzMeqo
         xfiZVigLyCKefLDnWqT8l+fBGR8vRN1Pi9Ir7KiTkav7k5YYh7aoZnvC6iUj0soleqfj
         F3vwqJxAWf/MB3EposE1UeE/lWhywFQs9qbMJHBZkf5GxiGS6TImRUb49+Za9no79iqF
         bhYg==
X-Gm-Message-State: AOJu0YxQuftQxGmnXawA3ZU86cUy3qJRQnCA8N9JfjbRpWZI3KpuAW2y
	gGbJX/dP5WhObMBLVPv4QN9k8sXQiZZj3g==
X-Google-Smtp-Source: AGHT+IEhMb7zjEc55wOrArR7pv2SyJMx4bcjU/06sMNTEbm7LJMWNSL30IZ+STX8mwvh3UZIvJKPFlEDxksC9Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:dc5:0:b0:d7b:9830:c172 with SMTP id
 t5-20020a5b0dc5000000b00d7b9830c172mr102069ybr.0.1695328110125; Thu, 21 Sep
 2023 13:28:30 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:16 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] net: lockless implementation of SO_TXREHASH
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_txrehash readers are already safe against
concurrent change of this field.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 4254ed0e4817d60cb2bf9d8e62ffcd98a90f7ec6..f0930f858714b6efdb5b4168d7eb5135f65aded4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1181,6 +1181,16 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			WRITE_ONCE(sk->sk_pacing_rate, ulval);
 		return 0;
 		}
+	case SO_TXREHASH:
+		if (val < -1 || val > 1)
+			return -EINVAL;
+		if ((u8)val == SOCK_TXREHASH_DEFAULT)
+			val = READ_ONCE(sock_net(sk)->core.sysctl_txrehash);
+		/* Paired with READ_ONCE() in tcp_rtx_synack()
+		 * and sk_getsockopt().
+		 */
+		WRITE_ONCE(sk->sk_txrehash, (u8)val);
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -1528,19 +1538,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 
-	case SO_TXREHASH:
-		if (val < -1 || val > 1) {
-			ret = -EINVAL;
-			break;
-		}
-		if ((u8)val == SOCK_TXREHASH_DEFAULT)
-			val = READ_ONCE(sock_net(sk)->core.sysctl_txrehash);
-		/* Paired with READ_ONCE() in tcp_rtx_synack()
-		 * and sk_getsockopt().
-		 */
-		WRITE_ONCE(sk->sk_txrehash, (u8)val);
-		break;
-
 	default:
 		ret = -ENOPROTOOPT;
 		break;
-- 
2.42.0.515.g380fc7ccd1-goog



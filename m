Return-Path: <netdev+bounces-33555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B83679E878
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 14:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8151C20C24
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1451A713;
	Wed, 13 Sep 2023 12:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31217F0
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 12:58:38 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08B19BD
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 05:58:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59285f1e267so17003557b3.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694609916; x=1695214716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DFT+AWTl7eLVy9AYroczgg2Se8+xyJps9lEPHLx/ixw=;
        b=bwe6z0f7dqGwZ0w0QxqNleFNYaXiafP4x4+rAucZ4OIjhHc8wZH6ZQTQ4RJSXISIS4
         vXy31wQp2xUpHXBtAxK6rgd6NE7GSZQuqCkqaHWnm/Mdvw9ibmeMW3lWgSUFSQW9cBW4
         giBSwZXI/O3RsNz1F02GdNI3ey8p8OZgjbxHKD3UtHar0bc7S5K3tsJffnTbA8fjI5up
         i6DBxQFfesTScCZ1mENBdlWrHDvTHmPAlkTjEP45xdYbH/OChnF6Gus1f/pvEKA8YAsQ
         3YIakffoVypFGFYhJTMlBiI/BAjHnqHkp3oJP78egqFikHMdzWs31mM3h79NyZrV96fs
         HzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694609916; x=1695214716;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFT+AWTl7eLVy9AYroczgg2Se8+xyJps9lEPHLx/ixw=;
        b=L3Bfumc8m1okW6suxJgmiXpP2kO7W6+1xa2VP8WCaRbMUfNuan4G6oNo6F5IZPJAHP
         eVdIZdYrtCZFxRhwgzsfJhETgdDJdD3wVDp58JzrQeK7b2CImJn6g6ujkF89v0DaNN9w
         x90xO9vr7EeqUOeTGNjVKqBagTEMXqma9+M1j6Wf1P4DjHkodbDP7vVfk0ZZjT84/p7I
         ShtTkaiuD9P1DefrzOD6kDZnvYSZHbTj4VyZZvBlxatFC5zXgHOzpuK3mAX1hmHnRaFR
         1gtHQtXAtpMpzmbxqlfp+bPE0aAdVe6osarDCrt8F0pK72OyL4Uvg50Eyw+0wRvhWrsT
         xogA==
X-Gm-Message-State: AOJu0YzZIz02HJRnImJNJT4zfl0Aa0/F3FzvMLTBeXIfCMzX09EtrWr/
	LnU6I64NBkGdHIllkxHr/BTGWVUi1L/NUQ==
X-Google-Smtp-Source: AGHT+IE1QCqtKJowlrQn7tIPLx2D8Dpz3iCha9wHC1GSB5Ydu6Igl7ozGBG5RfNjSAT1Os/Shy29xyhsq7hGRg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1022:b0:ca3:3341:6315 with SMTP
 id x2-20020a056902102200b00ca333416315mr93496ybt.0.1694609916624; Wed, 13 Sep
 2023 05:58:36 -0700 (PDT)
Date: Wed, 13 Sep 2023 12:58:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913125835.3445264-1-edumazet@google.com>
Subject: [PATCH net-next] net: use indirect call helpers for sk->sk_prot->release_cb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When adding sk->sk_prot->release_cb() call from __sk_flush_backlog()
Paolo suggested using indirect call helpers to take care of
CONFIG_RETPOLINE=y case.

It turns out Google had such mitigation for years in release_sock(),
it is time to make this public :)

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index bb89b88bc1e8a042c4ee40b3c8345dc58cb1b369..969b11ede8cd8c08138a8164279b4e5923f825e6 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3003,7 +3003,9 @@ void __sk_flush_backlog(struct sock *sk)
 	__release_sock(sk);
 
 	if (sk->sk_prot->release_cb)
-		sk->sk_prot->release_cb(sk);
+		INDIRECT_CALL_INET_1(sk->sk_prot->release_cb,
+				     tcp_release_cb, sk);
+
 	spin_unlock_bh(&sk->sk_lock.slock);
 }
 EXPORT_SYMBOL_GPL(__sk_flush_backlog);
@@ -3523,7 +3525,8 @@ void release_sock(struct sock *sk)
 		__release_sock(sk);
 
 	if (sk->sk_prot->release_cb)
-		sk->sk_prot->release_cb(sk);
+		INDIRECT_CALL_INET_1(sk->sk_prot->release_cb,
+				     tcp_release_cb, sk);
 
 	sock_release_ownership(sk);
 	if (waitqueue_active(&sk->sk_lock.wq))
-- 
2.42.0.283.g2d96d420d3-goog



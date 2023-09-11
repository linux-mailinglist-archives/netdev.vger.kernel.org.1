Return-Path: <netdev+bounces-32881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1A79AA6D
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E26028105F
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D8156C7;
	Mon, 11 Sep 2023 17:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C3156C6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:06:01 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD2123
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8b2d6784so51847227b3.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694451960; x=1695056760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLHXKagUp75BI6OdSs0vVw5ugFWeBckDK23IiluvXQ=;
        b=g4Lk1FsflyksG7bI3qBgroJdZ3ELXP61YnG1Cg+43EjrDkoqEAwrRZatzjnlfPsByE
         r1OIyX5bdVVKUO+a0//d3w44k9uFfzozVMpCDFV3cdFTCAWJB75PAUKGWndnMwfvja4l
         EcVWKm0MURK70g05GwUp3Hn4/2qv6lgCwBqBzWDpxcZEP6NWohFSqrOusTPrVYO1K/8a
         J2fJYKbAvOF1KIy9LMsguoKDp/+/2qUmKTs01pRL5QcNZvAOwk7+isW7BQzI4pL/wzHK
         sa/Edspw1rQepLSmOgSw8ADXsTqUHjvMJtRULDme6qivBaJr5ME7Oai39hXW6eMPvPVo
         G31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451960; x=1695056760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLHXKagUp75BI6OdSs0vVw5ugFWeBckDK23IiluvXQ=;
        b=vg4DCgAvB0o8Ejjg0H5WCeOj5X1fPahrWWZt/jUqAgWYvQuMplnyHZh7aj7qsZMR0n
         nwoBo2NBgqneuWyg3isM7zROARurNzhnCcLFHEipwk62qyApe5IIzhOiELd+WWLj190V
         horcatOLIL33r+8Ssb3nCP+lw4wu4YwDFTDuqk1xgxuGtCDfQsV9Tku60FZQY5hRwFVV
         aMnjLAbR//kHnZKku5nwTyAB9fqrGWov7QbKDa0fCftWDj63aULqoif/DT6n4+rSXSsi
         6miJP1UHDYfmDrDPwgAD7/P8/O2pyoEHFHjykNmIshF4jG5NztmxcIwTIxzTccaLiqQp
         y7pQ==
X-Gm-Message-State: AOJu0YzAhhpQdOrOc4f7bDOLxViVaCZJe/ZgaOaMYvbLzzA2DMGHtS5w
	HS+i9fZcZUIyTBJM+rrK1rEB2k5qT64jVg==
X-Google-Smtp-Source: AGHT+IH+Us4sb6bMYjui8jq2nzxsq/mwS5uyitanrC9xt0s5OwbGjT4ZkAZj2sjKxWywuIHW5+Qa2VznoVghhQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:8b54:0:b0:58f:b749:a50b with SMTP id
 e20-20020a818b54000000b0058fb749a50bmr242162ywk.4.1694451959883; Mon, 11 Sep
 2023 10:05:59 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:05:28 +0000
In-Reply-To: <20230911170531.828100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170531.828100-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170531.828100-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] tcp: no longer release socket ownership in tcp_release_cb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This partially reverts c3f9b01849ef ("tcp: tcp_release_cb()
should release socket ownership").

prequeue has been removed by Florian in commit e7942d0633c4
("tcp: remove prequeue support")

__tcp_checksum_complete_user() being gone, we no longer
have to release socket ownership in tcp_release_cb().

This is a prereq for third patch in the series
("net: call prot->release_cb() when processing backlog").

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c       |  3 ---
 net/ipv4/tcp_output.c | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 16584e2dd6481a3fc28d796db785439f0446703b..21610e3845a5042f7c648ccb3e0d90126df20a0b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3519,9 +3519,6 @@ void release_sock(struct sock *sk)
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
 
-	/* Warning : release_cb() might need to release sk ownership,
-	 * ie call sock_release_ownership(sk) before us.
-	 */
 	if (sk->sk_prot->release_cb)
 		sk->sk_prot->release_cb(sk);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ccfc8bbf745586cd23dcf02d755d6981dc92742e..b4cac12d0e6348aaa3a3957b0091ea7fe6553731 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1101,16 +1101,6 @@ void tcp_release_cb(struct sock *sk)
 		tcp_tsq_write(sk);
 		__sock_put(sk);
 	}
-	/* Here begins the tricky part :
-	 * We are called from release_sock() with :
-	 * 1) BH disabled
-	 * 2) sk_lock.slock spinlock held
-	 * 3) socket owned by us (sk->sk_lock.owned == 1)
-	 *
-	 * But following code is meant to be called from BH handlers,
-	 * so we should keep BH disabled, but early release socket ownership
-	 */
-	sock_release_ownership(sk);
 
 	if (flags & TCPF_WRITE_TIMER_DEFERRED) {
 		tcp_write_timer_handler(sk);
-- 
2.42.0.283.g2d96d420d3-goog



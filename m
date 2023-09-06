Return-Path: <netdev+bounces-32336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D460794448
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48312813FE
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97A11CA0;
	Wed,  6 Sep 2023 20:10:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3911C91
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 20:10:55 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583709E
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 13:10:54 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59504967e00so2997067b3.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694031053; x=1694635853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLHXKagUp75BI6OdSs0vVw5ugFWeBckDK23IiluvXQ=;
        b=Sl6XiOyB5CLSrzfS+ozaR0HVuuIzNg1WXydfwpNL2/AIk+lIxH0OSNVfiCTbV/E57+
         dGRMp+ShxHDtiintd0uU6eW8zosCcwAnNc+qpIdpkahPRnuj8oyiCxnZQxWhnVkPQj2q
         Jx4PZMOiNeGGeJvVPDCZwr587UiPcUKHUWKTFGA20QVhxdOZvtYktCRXNZeH8MdiEk4/
         GQLWaSDn5wZZWvKkYF6bFOvFyR51bQbZImb1P/5fg9hIqajiDD3+vyrmzb0SDk6L/D4s
         sNR+Ew+1ws7C3TUhf1fP6RL3AoUCRAk8Yz1QGHL97MGwYCTh6vVSp6clGBq4KdkRmTrp
         EkqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694031053; x=1694635853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLLHXKagUp75BI6OdSs0vVw5ugFWeBckDK23IiluvXQ=;
        b=UGVvyeID0igLJJjuX9MMVe2QinlM1g5DF8ZHos9EbHrPKY/GNIFnJ21BTiBF9JUDvN
         3KqiiWujYbVqle5a9R0KMKvsKt4VHANCLpnV2zLnyPtpuToCyRpHICh+ZJDuIJaFyGv7
         7H+M0t1ofu3uPY5LF+lFl489Y+2VFSWUkQwhVG7+mGR6RGGbJETatg006h1RQlKuZUPT
         hkKjZ5olyjL+AsXCQzpGwBjhynM+bOBnkOBOtm0ykeQGAQgsiyUBzeKVFGGdNCt31YY8
         lpAaVapFC9PfHw0/kiek9me+Loh0NFiov1h0mTRt2Cp7pYkQNoc2YEr6MtZxz7aOCRdD
         ZGbg==
X-Gm-Message-State: AOJu0YwznTmoua2Rc3vqHEHIhchC6pGIxbMJ5zc294Z/qRl1MRcKeWOJ
	9HvyYXPea8nQzGzW9s1QZ7RdjM54GBnRIQ==
X-Google-Smtp-Source: AGHT+IHP6nGB7uHD/zfSAXRdYmMBoNUbyAzwX3eTe7FnRATD+BZIikpFrBwJ40Cy3vfh54i3lt6kgpdHERgIhw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4101:0:b0:586:896e:58b1 with SMTP id
 o1-20020a814101000000b00586896e58b1mr445952ywa.0.1694031053666; Wed, 06 Sep
 2023 13:10:53 -0700 (PDT)
Date: Wed,  6 Sep 2023 20:10:43 +0000
In-Reply-To: <20230906201046.463236-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230906201046.463236-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906201046.463236-2-edumazet@google.com>
Subject: [RFC net-next 1/4] tcp: no longer release socket ownership in tcp_release_cb()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Eric Dumazet <edumazet@google.com>
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



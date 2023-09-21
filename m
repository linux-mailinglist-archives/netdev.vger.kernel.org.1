Return-Path: <netdev+bounces-35604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9ED7A9FEE
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59704281EB5
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78818C13;
	Thu, 21 Sep 2023 20:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBB19442
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:29:12 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B93B013C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so1793034276.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328106; x=1695932906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rISiTiujlnMhVptNZP1dQuwshQznfcoYMPfBDnZ/ImQ=;
        b=2Z8MrAYkuDdip2wbrGo3JEhsQgX3Q7q7sTxoDqiVLXnGQEuN9ynEYR7avB+/cI+emR
         LH2Q8X9pRpxk7T8tquyQ9UPHc1KQ13I6iBK86JuJDA+ikraq/jyPRNmlW6emXd8Zb2w9
         EO68UC71MRWqNABQO/AM6FAVWQNVh4vJeUKbnTB9Zf+eL4UaqAwvCXBUZLt0nI04WeYp
         FHn+ZsNWmTo0LnlAyIN4yaBog6yt0YLBDrn/XLPUvpEmMYYPEN+kh4mt6w2yX7p20la0
         xLSsVsKyxHs8A76YiAFijfVDaVdyuJ6jcgAiHaz0f25Ozzbh/lLr1Z1XjYrRd8LkI0hL
         JhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328106; x=1695932906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rISiTiujlnMhVptNZP1dQuwshQznfcoYMPfBDnZ/ImQ=;
        b=JlhvfbXhHUhH/06AnmEy/Nqy83SNVg1hrQfzo2maBe+dPNdFCt7o2tDfrdv8XJcpSY
         Cq+wq07r0PigEaohQ/h1qREzhJclZm6DKUZnE3hV4+XmMw3xYRHvJKLf9U6v50o0qtc+
         QsVfyDAbdoZuZ8qlGLoSmqvowRbp/6MuN6mq8ztLBa8Ret0N+rGquTrGvJYrYHf6Tghw
         cug/Xgl+SmmyASrM2LKAo8bpDGOZ5BQLHsiTfo5RxN0r6qAGK+MBhsLgBSAojk7H2rnP
         1w8rVrbINxDplzeXqXmI+PQg4TxKZDhfTjNeT6LdMYKntnFWYadzRHMVOM7ggMAkxyRt
         lQOg==
X-Gm-Message-State: AOJu0YyWm7LBmzxZUKnYGZmg9UF71yuaOc1m/tHModZJmSyjdUMytED5
	3uUMlz856dmV+ddxPlViR1jE3Htk1MJpSw==
X-Google-Smtp-Source: AGHT+IEB+9BBXVeHnNOVHqGfWLaQZeJGTETUmzjrewYIdN9rH8NWcwROq87QKS9zbrTDIfnHgFNYvST8pLKHFQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:4081:0:b0:d10:5b67:843c with SMTP id
 n123-20020a254081000000b00d105b67843cmr87207yba.4.1695328106790; Thu, 21 Sep
 2023 13:28:26 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:14 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] net: lockless implementation of SO_BUSY_POLL,
 SO_PREFER_BUSY_POLL, SO_BUSY_POLL_BUDGET
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

Setting sk->sk_ll_usec, sk_prefer_busy_poll and sk_busy_poll_budget
do not require the socket lock, readers are lockless anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/sock.c | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 4d20b74a93cb57bba58447f37e87b677167b8425..408081549bd777811058d5de3e9df0f459e6e999 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1140,6 +1140,26 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 	case SO_DOMAIN:
 	case SO_ERROR:
 		return -ENOPROTOOPT;
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	case SO_BUSY_POLL:
+		if (val < 0)
+			return -EINVAL;
+		WRITE_ONCE(sk->sk_ll_usec, val);
+		return 0;
+	case SO_PREFER_BUSY_POLL:
+		if (valbool && !sockopt_capable(CAP_NET_ADMIN))
+			return -EPERM;
+		WRITE_ONCE(sk->sk_prefer_busy_poll, valbool);
+		return 0;
+	case SO_BUSY_POLL_BUDGET:
+		if (val > READ_ONCE(sk->sk_busy_poll_budget) &&
+		    !sockopt_capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (val < 0 || val > U16_MAX)
+			return -EINVAL;
+		WRITE_ONCE(sk->sk_busy_poll_budget, val);
+		return 0;
+#endif
 	}
 
 	sockopt_lock_sock(sk);
@@ -1402,30 +1422,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sock_valbool_flag(sk, SOCK_SELECT_ERR_QUEUE, valbool);
 		break;
 
-#ifdef CONFIG_NET_RX_BUSY_POLL
-	case SO_BUSY_POLL:
-		if (val < 0)
-			ret = -EINVAL;
-		else
-			WRITE_ONCE(sk->sk_ll_usec, val);
-		break;
-	case SO_PREFER_BUSY_POLL:
-		if (valbool && !sockopt_capable(CAP_NET_ADMIN))
-			ret = -EPERM;
-		else
-			WRITE_ONCE(sk->sk_prefer_busy_poll, valbool);
-		break;
-	case SO_BUSY_POLL_BUDGET:
-		if (val > READ_ONCE(sk->sk_busy_poll_budget) && !sockopt_capable(CAP_NET_ADMIN)) {
-			ret = -EPERM;
-		} else {
-			if (val < 0 || val > U16_MAX)
-				ret = -EINVAL;
-			else
-				WRITE_ONCE(sk->sk_busy_poll_budget, val);
-		}
-		break;
-#endif
 
 	case SO_MAX_PACING_RATE:
 		{
-- 
2.42.0.515.g380fc7ccd1-goog



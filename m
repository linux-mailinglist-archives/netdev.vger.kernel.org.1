Return-Path: <netdev+bounces-35916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0B7ABB9C
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 917DF28285B
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F35C47C77;
	Fri, 22 Sep 2023 22:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9847C6C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:04:04 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94204A7
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7fd4c23315so3666106276.2
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695420243; x=1696025043; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba76KfzLtltiSCDhSXln8dsbXSoIWpM8tlwuX9Pp/eA=;
        b=VCSKRehiImmtiwkvbS+x7WgErfxkwaAjw0H21OLDg48riXFCyDYvKVOdceHKsDtZBb
         nvBwNyOr9NwxzLuiJ99C+2Lq+bWmHWXjuG9tFrC2VVFyn5nXVLhkqEpTasNV+ZZrEkg7
         /pcvqdNt1Bw7vUmBAmaofmdgSbvbEy6vMmGCw87VY93OrYPr4cKp18yE9W5GNCKmv1Sr
         hrkBLQjsy1PrZ4JYoGRKVpKv1A9oWi2LecXNGU5DDLL2Xmu34uFwFEBJyoIe1uTKcbIz
         4V39DGrJtjBMbE8+pULuW14QBuugFfij2/6LqHdvstNPkKn00MekHmkid0mDWx9+8p6O
         7arg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420243; x=1696025043;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ba76KfzLtltiSCDhSXln8dsbXSoIWpM8tlwuX9Pp/eA=;
        b=tY5CeE0s8lz7tq+zgwEc2b2NjNbz2ifR2W7qpaxB/Mb/4tRm4jaBAxT4tFoc77sTKV
         2CX0rLj53BZpQpk2xSMArZZZ8/iTG2vq42hwsuiSfrPGuRklIKV+ZZzu2IlKOcUqPxV4
         Srnd9rNIhAippd9j/JzaNZ9Tso819I36x3QueYZxCbVqsyjzw5CenzgN3jh4e1PaxnTI
         pt/brIsCq0n0Z31MtLjCD4r5rmjHFK75BkZR5dMrERhHBHcSy8bs2NPz7NyqmlQ3M6qX
         /dKSNQxgJst3ODf5iXcmHCcKYb3YLoNnMI1u+QpGgdy2qKh5vIq/ic0RimUHMYvTf6Y9
         jgNQ==
X-Gm-Message-State: AOJu0YwQ/iThG439Rb/oMFThhgQkiSWgXEI6l9ZHtFpgKi61P+kOhsn9
	dF+fZpoBJaf1yz5zNqaqryEfbuupuwJM7g==
X-Google-Smtp-Source: AGHT+IGOINbPqQvL7zO77US0aiQ+DDXFO4A3NJPhk8KP6i+3Ck25LDz0YlOTnDWqnn/8FbZlMoslAQnFb+gMBQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:46c5:0:b0:d4b:df05:3500 with SMTP id
 t188-20020a2546c5000000b00d4bdf053500mr5505yba.11.1695420242864; Fri, 22 Sep
 2023 15:04:02 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:03:55 +0000
In-Reply-To: <20230922220356.3739090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922220356.3739090-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] tcp_metrics: do not create an entry from tcp_init_metrics()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tcp_init_metrics() only wants to get metrics if they were
previously stored in the cache. Creating an entry is adding
useless costs, especially when tcp_no_metrics_save is set.

Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 0c03f564878ff0a0dbefd9b631f54697346c8fa9..7aca12c59c18483f42276d01252ed0fac326e5d8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -478,7 +478,7 @@ void tcp_init_metrics(struct sock *sk)
 		goto reset;
 
 	rcu_read_lock();
-	tm = tcp_get_metrics(sk, dst, true);
+	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
 		rcu_read_unlock();
 		goto reset;
-- 
2.42.0.515.g380fc7ccd1-goog



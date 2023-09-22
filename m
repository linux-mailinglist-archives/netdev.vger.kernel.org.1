Return-Path: <netdev+bounces-35917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B05F7ABB9D
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 00:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 35A2F2829E2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 22:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CD347C6C;
	Fri, 22 Sep 2023 22:04:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B16447C79
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 22:04:06 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D3ACA
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8186d705a9so3964997276.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695420244; x=1696025044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vOoHuARRoMJdHZshUfr8rtC8fEwoEwY5sGRuZy8YhbQ=;
        b=TWnxwhgi8zvvvPGwIrXr/w0ZtT/ZrOghtJbGbU2hJhJf0ZTbiUKFgOZFC8UkE186LQ
         WAtqBRGWePXE+QVoLFPeciXozflZOflVyCTk83GunmI5UuG0FkpeVwawPDBj48PWvUt6
         a3Ty4l1qVjWqKRCc6NLmPxZVGgnJRzTd5Ibji2BuXL9t2gsQOxnhNXkV8ai5Y9naG3P1
         pIoOfpKyntzPgAGNBccpQyTuWu2NMr3k2B5j2XR0utuccgy4vPyitvwrT9cjR+pDhokF
         gu1icABGTn6gNfyhQM2SPXRRPUXBRzW3CcIXo8ajoS8K0pqpWpWPomvwkoHiKMO8ddtT
         +kNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695420244; x=1696025044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOoHuARRoMJdHZshUfr8rtC8fEwoEwY5sGRuZy8YhbQ=;
        b=bz90WcZz2XDY0K2g3slvXXoWSWH/wrPJy7Cq2vcyEx3oVTin8BPG3Q7IXazD/duJ/d
         BDNHOd4/TKF6DNV8+mJjiXbxgDMesQC0vooZoyYpeTnXi6u3OH2KQpI/5fkXaQZk30F3
         1Vy9r+jdPZr5XxS5Uua6nBthDT+9NcFWVqBiiv8pgm28gGpErpE8HLWFhBKUjfqJ2pIe
         O2866OCo0HbW6rcBsig1jeWUhP/xICpxYKaU2P42pJkF0UYcJYyGIy+pfs7QbexjEmvz
         t4/E10z4ZYaAuykovQWSf5XVkJazPMrqUTgU0gMJkDSEhofkfGZsv6L8bQFv2sbXlIkm
         SyIQ==
X-Gm-Message-State: AOJu0YzMYZ81lpqYMwrxdTuk+FL4/QRUM/YS9nQs1lgX6otXkcV05BiM
	hUuFQdsZXnv5ba3XLvok+QxlsZlezQ106w==
X-Google-Smtp-Source: AGHT+IHwsH8KQoZoPfsoYUrvXmQzpoEsBlAxfujimG58F7a9mdpOPZjAjHm0C8vumhALnEJovOd36qv5IPWGUA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:dbcc:0:b0:d85:ac12:aadb with SMTP id
 g195-20020a25dbcc000000b00d85ac12aadbmr5602ybf.9.1695420244412; Fri, 22 Sep
 2023 15:04:04 -0700 (PDT)
Date: Fri, 22 Sep 2023 22:03:56 +0000
In-Reply-To: <20230922220356.3739090-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922220356.3739090-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] tcp_metrics: optimize tcp_metrics_flush_all()
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

This is inspired by several syzbot reports where
tcp_metrics_flush_all() was seen in the traces.

We can avoid acquiring tcp_metrics_lock for empty buckets,
and we should add one cond_resched() to break potential long loops.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_metrics.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 7aca12c59c18483f42276d01252ed0fac326e5d8..c2a925538542b5d787596b7d76705dda86cf48d8 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -898,11 +898,13 @@ static void tcp_metrics_flush_all(struct net *net)
 	unsigned int row;
 
 	for (row = 0; row < max_rows; row++, hb++) {
-		struct tcp_metrics_block __rcu **pp;
+		struct tcp_metrics_block __rcu **pp = &hb->chain;
 		bool match;
 
+		if (!rcu_access_pointer(*pp))
+			continue;
+
 		spin_lock_bh(&tcp_metrics_lock);
-		pp = &hb->chain;
 		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->ns.count);
@@ -914,6 +916,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			}
 		}
 		spin_unlock_bh(&tcp_metrics_lock);
+		cond_resched();
 	}
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog



Return-Path: <netdev+bounces-19257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572275A09D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667FB1C210FF
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC82263CD;
	Wed, 19 Jul 2023 21:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E221BB23
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:25 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EE41FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c386ccab562so74207276.3
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802163; x=1690406963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHYaw9kuF4VmrxGwh+v702Clz2zatUww9Ka6UoY+WE4=;
        b=3gJfXmYan70UoyekyN9a/cdqBYxkitYtcl+AyEen8C7Kv/Tjs5MtJA5cPRKmiuTarv
         rsGg72Oxphi8wH4uZPFgQ4O9fy47Tzq09c/Ws/DOU10kC3Sw9K4dDoJFBVi1L26GxxW0
         lenwjpOR1PfnhOSso6X64NjJkD4cSVc3NwXMUZBBmAN5PbJXpuyo0JL2gZ5AZdT+Fc6i
         okmZlSj23i/M88rnvGnUUyvYF2e95olWtdN16y4gied9bPoX2R3ROizw3olls4xtyWq1
         DbLtQrwM+XQ/4Z9owJ2ndvHC0aTKCcf5RLWRxXWXE2Cl1l2ZaIog+jeh7elBMl/jYbT0
         wi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802163; x=1690406963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHYaw9kuF4VmrxGwh+v702Clz2zatUww9Ka6UoY+WE4=;
        b=X5ZSyYI0h/ybET6DsG+xGoLTs88QCasi7867Ri1fkHC4beSr6MHR2t6W+4b3Ba2viy
         gMFQyVftLVA84BK+0xAc3bSCQTulZzIdBC/UuoA3NOFlY61/CshVp5BbvhVcOTANQHb5
         l6x+iFALcDeG+xhT5Jfkf6LQ1neICq7WfIYw63Z34gNd2gdXyZWy7ilNGkmxVHyz/LzU
         qxM4ZEFJKbEIT4Nq2Qf9YALGt+G4TYV6kFQgCX58SFrH3WfQd6dNau8mcA2IOSAYKvHz
         vYakXkKK3Xo14Qac4sPPiYmtd1VXK8Q0KFa5oiPc8x2beG1XPsUY7zUrmy+niH+fWdk5
         CMGA==
X-Gm-Message-State: ABy/qLadBgo85JTNyXNjlJIlIfmKVzxn/K+4wuM/Sqw/Qz/hngVsGVqG
	U19WbFgE9JFH+SbKdFLQokGTrCiAllGu3A==
X-Google-Smtp-Source: APBJJlFByTZ0Iz++8awZTrugkwaaDgai4FmTz28PWMeZJjdJUWKEGkKxzVfIdqKOoIPvSTGDXPySPTA4hk5n6A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1805:b0:c4e:3060:41f9 with SMTP
 id cf5-20020a056902180500b00c4e306041f9mr30720ybb.9.1689802163331; Wed, 19
 Jul 2023 14:29:23 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:57 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-12-edumazet@google.com>
Subject: [PATCH net 11/11] tcp: annotate data-races around fastopenq.max_qlen
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

This field can be read locklessly.

Fixes: 1536e2857bd3 ("tcp: Add a TCP_FASTOPEN socket option to get a max backlog on its listner")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h     | 2 +-
 net/ipv4/tcp.c          | 2 +-
 net/ipv4/tcp_fastopen.c | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b4c08ac86983568a9511258708724da15d0b999e..91a37c99ba6651c075d1547c5545700be3e5593c 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -513,7 +513,7 @@ static inline void fastopen_queue_tune(struct sock *sk, int backlog)
 	struct request_sock_queue *queue = &inet_csk(sk)->icsk_accept_queue;
 	int somaxconn = READ_ONCE(sock_net(sk)->core.sysctl_somaxconn);
 
-	queue->fastopenq.max_qlen = min_t(unsigned int, backlog, somaxconn);
+	WRITE_ONCE(queue->fastopenq.max_qlen, min_t(unsigned int, backlog, somaxconn));
 }
 
 static inline void tcp_move_syn(struct tcp_sock *tp,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 3e137e9a18f552a02d8c74e1af34ba2356e4d8ed..8ed52e1e3c99a334a47964d8fd05c720a8f683f9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4145,7 +4145,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_FASTOPEN:
-		val = icsk->icsk_accept_queue.fastopenq.max_qlen;
+		val = READ_ONCE(icsk->icsk_accept_queue.fastopenq.max_qlen);
 		break;
 
 	case TCP_FASTOPEN_CONNECT:
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 45cc7f1ca29618e3ac1066cb49e7d6dc90e1c64d..85e4953f118215ba7100931dccb37ad871c5dfd2 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -296,6 +296,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 static bool tcp_fastopen_queue_check(struct sock *sk)
 {
 	struct fastopen_queue *fastopenq;
+	int max_qlen;
 
 	/* Make sure the listener has enabled fastopen, and we don't
 	 * exceed the max # of pending TFO requests allowed before trying
@@ -308,10 +309,11 @@ static bool tcp_fastopen_queue_check(struct sock *sk)
 	 * temporarily vs a server not supporting Fast Open at all.
 	 */
 	fastopenq = &inet_csk(sk)->icsk_accept_queue.fastopenq;
-	if (fastopenq->max_qlen == 0)
+	max_qlen = READ_ONCE(fastopenq->max_qlen);
+	if (max_qlen == 0)
 		return false;
 
-	if (fastopenq->qlen >= fastopenq->max_qlen) {
+	if (fastopenq->qlen >= max_qlen) {
 		struct request_sock *req1;
 		spin_lock(&fastopenq->lock);
 		req1 = fastopenq->rskq_rst_head;
-- 
2.41.0.255.g8b1d071c50-goog



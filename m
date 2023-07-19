Return-Path: <netdev+bounces-19250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0D75A095
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7325B28179A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E162515A;
	Wed, 19 Jul 2023 21:29:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9022EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:13 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402501FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c64521ac8d6so87947276.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802151; x=1690406951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0CtZnWb03K/Ggxz+fDtbdi3zEefpJl7aAV9QRq78/0=;
        b=upeOVmEk/Lu9GGnDxMKJD1BCOtOa3vQ2pNqd/2G9hUYXpCEmAM/wUm6nOpPdZNZXsD
         Fdma0/vuuumXA+9d2C1XOtSkDN++v0l1SPXS8gmBZl6q6UkWKtOs8u5ael2WaO3rwwA3
         oXDhRUCtMB15guBPP3E1RCsHnxvP0suOsUpNZVfhZIIC4/ML2TwaUI2QkWDPMxqrSLRX
         +HsbxSOeTSXVe3HmAITUGDzrgzC2an4DOACIJaZA9bYBvKqX59cZho41Lq971dzgEECX
         ZQ2+oyHpTvwlSY3e9rX784B+zPdObleD6G2ZWITN0Eadnab3tIaVs1Jx6kXz6FoekwSp
         cGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802151; x=1690406951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0CtZnWb03K/Ggxz+fDtbdi3zEefpJl7aAV9QRq78/0=;
        b=dEdC68yVg/A8RwYMHBynLjQiPo1k3/6TJXzjMBdXPbDbof3l344t+lFhEuVa1ioenj
         Ap3PaIWrDH2Ye4usbhqaYuVXPCdTPStD2TbHXDLntMNcoKXc9XmvyLbrdwmN6EoURtXD
         ektb8qjb+yw/z8RXPmCmnQhehcjsovZ8CV08ysE2my8gJBi+GzhG6cVlyjsURWGynpsv
         5BUbD7HBGEtYaVdTUk+4jywJeFT3na7SAM+4mF5BxresVUAzV904esqb5i0eYgl8XTD0
         f58lmQFqeOdTe0zkMRp3XzY9th8SoQXu0rnciBsrl8mkC6YhQeOsaIECuGlnRGqhWK1/
         C7bQ==
X-Gm-Message-State: ABy/qLZVfbj7Fp7P8m4FK0DiMyd7dxresYsAKD0dukPIW6LJ/C0fGJiu
	qvE0DMHInwTpsX9T7E8j5ZSDw8m/QBQXhQ==
X-Google-Smtp-Source: APBJJlH2hwnLXUD8xxvhmH/wJz5dZ6AdowYYniM381BXdNhZDxpZv/8Cztgs5u0aKhhoaBdxy7vK1SDtE9qtBg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:386:0:b0:c4b:6ed6:6147 with SMTP id
 128-20020a250386000000b00c4b6ed66147mr32134ybd.9.1689802151581; Wed, 19 Jul
 2023 14:29:11 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:50 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-5-edumazet@google.com>
Subject: [PATCH net 04/11] tcp: annotate data-races around tp->keepalive_intvl
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

do_tcp_getsockopt() reads tp->keepalive_intvl while another cpu
might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 9 +++++++--
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ff7372410472246d372402dfdfd6391544be8259..79af16a4028665d51f6ea5f1a4382265b8163309 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1507,9 +1507,14 @@ void tcp_leave_memory_pressure(struct sock *sk);
 static inline int keepalive_intvl_when(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
+	int val;
+
+	/* Paired with WRITE_ONCE() in tcp_sock_set_keepintvl()
+	 * and do_tcp_setsockopt().
+	 */
+	val = READ_ONCE(tp->keepalive_intvl);
 
-	return tp->keepalive_intvl ? :
-		READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
+	return val ? : READ_ONCE(net->ipv4.sysctl_tcp_keepalive_intvl);
 }
 
 static inline int keepalive_time_when(const struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b4f7856dfb1611f02073699ee24d48f1a6fe7b87..d55fe014e7c902859243cdb619d94a230e44f708 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3345,7 +3345,7 @@ int tcp_sock_set_keepintvl(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	tcp_sk(sk)->keepalive_intvl = val * HZ;
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
 	release_sock(sk);
 	return 0;
 }
@@ -3559,7 +3559,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_KEEPINTVL)
 			err = -EINVAL;
 		else
-			tp->keepalive_intvl = val * HZ;
+			WRITE_ONCE(tp->keepalive_intvl, val * HZ);
 		break;
 	case TCP_KEEPCNT:
 		if (val < 1 || val > MAX_TCP_KEEPCNT)
-- 
2.41.0.255.g8b1d071c50-goog



Return-Path: <netdev+bounces-19252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD875A097
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BE0281AFB
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630E25179;
	Wed, 19 Jul 2023 21:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD822EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:17 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0A81FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c4f27858e4eso81477276.1
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802155; x=1690406955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gHYPI+Qrt/gtZuSFqywf6XEc2KLJZUhrJ6gTvOMNcVE=;
        b=tly1Ya0TucM0qh4oUmdycrt2bWQH7tJ7/PJ5r5CuChbmNfgaGRJMr8SN3u7QkS9DBO
         iXlmDJ31qfPZiQEJY3uL+V3H3zzs1bJybWmuZnQrVezWD3njrSuEi5V7Q+vzM8zC6HpQ
         PHN+984/OUnW14dPgCy0OHN+VJIDWZ6dow85huFu+sUnE1Kv2UA/iCjYVFSsS5qM8Rez
         aJvyAAixc2J9Ci+8d3xZ8hXHOyk6KruyGHaZu5zApUfOpPB6x7Pag8sLO3d5P+Mpmdp4
         AxW3tGtLlo2xZuXBadMP1vTsjnnqqM6PZp/6MK9uyfXqZXvS4ISBSmzvdDq49YA2yo3J
         nn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802155; x=1690406955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHYPI+Qrt/gtZuSFqywf6XEc2KLJZUhrJ6gTvOMNcVE=;
        b=Qa45Y77miQxfHGTgC/SdmQ1G8uH3aezZXyRWGIXnq6hGY4/xwJ3cMsa19UoNnLn7pJ
         vt9qXfvYTzTEFAgBycbWEgfTr4EBAw1mThaFV5GkxYZDjKskHEvmF8HIU/OmVoF2yn5A
         KJfy/R85Ocx5Lk7d13HfEfur/iBdXNZv5tcbXypyG7a7ztunx/anPWbmnLYdCYusKfgS
         d8YC6Uzt/gVLJhHGhCl0dOWRpJQ9d6n3d877z/9GklGmZbVzgVRsGDI0iduZ8RtyR9Je
         6nghZBEjdvaERJKdCvEea5/uyBfkrf/hqX6IkV2i8Dm3wpwJ6EDEaRHjE67Z6R6E3yXk
         laeg==
X-Gm-Message-State: ABy/qLbQGCgIA5W8UFGN/gi6kGQZo2Gffmicd9CQUohVp08tibQ07xf2
	l/agAos34nWyTRg0H/PeQlf0UajQusOhbw==
X-Google-Smtp-Source: APBJJlF/F9UbXNg+vFv7UP5k//myTby7YKb1RpWw5OpgUpvJ2sO7gU+G1KCKqIU/P6gfxc3M2cIOBrtM9EY4lQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:aba7:0:b0:c2a:e79a:fc11 with SMTP id
 v36-20020a25aba7000000b00c2ae79afc11mr32285ybi.9.1689802155211; Wed, 19 Jul
 2023 14:29:15 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:52 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-7-edumazet@google.com>
Subject: [PATCH net 06/11] tcp: annotate data-races around icsk->icsk_syn_retries
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

do_tcp_getsockopt() and reqsk_timer_handler() read
icsk->icsk_syn_retries while another cpu might change its value.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/tcp.c                  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0cc19cfbb67345960ef16bdaf6ec330a6eb397fd..aeebe881668996057d1495c84eee0f0b644b7ad0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1019,7 +1019,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 
 	icsk = inet_csk(sk_listener);
 	net = sock_net(sk_listener);
-	max_syn_ack_retries = icsk->icsk_syn_retries ? :
+	max_syn_ack_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(net->ipv4.sysctl_tcp_synack_retries);
 	/* Normally all the openreqs are young and become mature
 	 * (i.e. converted to established socket) for first timeout.
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 574fd0da167339512077c36958578fde2b1181e8..9f74ac16f1c1e53353bd14c6a04e1fa9e3de0c15 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3291,7 +3291,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 		return -EINVAL;
 
 	lock_sock(sk);
-	inet_csk(sk)->icsk_syn_retries = val;
+	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
 	release_sock(sk);
 	return 0;
 }
@@ -3572,7 +3572,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (val < 1 || val > MAX_TCP_SYNCNT)
 			err = -EINVAL;
 		else
-			icsk->icsk_syn_retries = val;
+			WRITE_ONCE(icsk->icsk_syn_retries, val);
 		break;
 
 	case TCP_SAVE_SYN:
@@ -3993,7 +3993,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = keepalive_probes(tp);
 		break;
 	case TCP_SYNCNT:
-		val = icsk->icsk_syn_retries ? :
+		val = READ_ONCE(icsk->icsk_syn_retries) ? :
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 		break;
 	case TCP_LINGER2:
-- 
2.41.0.255.g8b1d071c50-goog



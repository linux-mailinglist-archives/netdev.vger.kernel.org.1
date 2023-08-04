Return-Path: <netdev+bounces-24450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16C770373
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF21C218B1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959212B66;
	Fri,  4 Aug 2023 14:46:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90917FE8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:28 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697849C1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso2210040276.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160385; x=1691765185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdK1/dGGNo1VnismfvCAy93PaS1rC4yyV3Ep7GiUZ/Q=;
        b=SLOraCUKOo2QiibTeZJXMgudjuGEqoMEEKsjl196zztBZ/BJmyDgBB2fu/fDJyk+nO
         vwERnMugFnD1x5qbe40CA/beyxGJpTUd0bHhKwD6i+EWBNdV/ZMSYpRsqspVvM33TOEz
         We/AJK7YhSrjR7jjkYgaMA/dV067LCER+KZQCkRbJ/OFRDGErnjDk/X87nzX5iLr6zBZ
         TSxLuYvKfo4Kffn8IwnPoaenSZqbbR+0VaMxk7RabV4oGT3qfEq0bCC1JXwWGH3F6rX3
         j/fC7M+DIdEQssSm0udXjmGiRkTwZ6MqlJubYsBYAciOi98sc5WiO386EndV0otkGzn0
         +VNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160385; x=1691765185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdK1/dGGNo1VnismfvCAy93PaS1rC4yyV3Ep7GiUZ/Q=;
        b=W2bWr7mCpY3YMa0I1xE4n9c2bAxmcMPkMV7aQN8+HEeNNjUzNhuHCTAym7juEbF1/m
         1BzRHrkbB6rsI12zx6z3raDJMwso+5AuM7CC18ktcI9e1R/VHT6iFRP4t6bCVTCbx1oH
         zfnz+k2Ge4uahsLbk9nHH3yXttWKecMFyG64r2jRSCQJnaaMibWKMdzO5S3NCljo31ys
         HFW39VnNYKeGQuvfZEDY1jXbtCOLnGUlUT3IJvFesjqU9CLuuHnZk7bjOpQfAeX3XHoz
         TATdj2c+qpX6rnJxN2B9d2K1jHSpGPdqts/kunWp2Dgt7QcVgSyIB7OYVShUsAHtyCep
         QUTA==
X-Gm-Message-State: AOJu0YzfhNkN/DYT4VbrKqrPvTAprC1UMNhixofKiJXdxmP0ha8E0tGX
	SLu6xJykmQIh/STkMhzP0yqtNDJSSHZf9g==
X-Google-Smtp-Source: AGHT+IHEi+Dbgzs1RqnCoenaKInJXvCv708/rZk1yhlQ0mCryKlIjRxmp5A4TLT/yIBsumVKUllxuNLg/s2T7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ce94:0:b0:cf9:3564:33cc with SMTP id
 x142-20020a25ce94000000b00cf9356433ccmr9042ybe.13.1691160385651; Fri, 04 Aug
 2023 07:46:25 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:15 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-6-edumazet@google.com>
Subject: [PATCH net-next 5/6] tcp: set TCP_LINGER2 locklessly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tp->linger2 can be set locklessly as long as readers
use READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 19 +++++++++----------
 net/ipv4/tcp_input.c |  2 +-
 net/ipv4/tcp_timer.c |  2 +-
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e74a9593283c91aa23fe23fdd125d4ba680a542c..5c71b4fe11d1c34456976d60eb8742641111dd62 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2865,7 +2865,7 @@ void __tcp_close(struct sock *sk, long timeout)
 
 	if (sk->sk_state == TCP_FIN_WAIT2) {
 		struct tcp_sock *tp = tcp_sk(sk);
-		if (tp->linger2 < 0) {
+		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_set_state(sk, TCP_CLOSE);
 			tcp_send_active_reset(sk, GFP_ATOMIC);
 			__NET_INC_STATS(sock_net(sk),
@@ -3471,6 +3471,14 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		return tcp_sock_set_keepintvl(sk, val);
 	case TCP_KEEPCNT:
 		return tcp_sock_set_keepcnt(sk, val);
+	case TCP_LINGER2:
+		if (val < 0)
+			WRITE_ONCE(tp->linger2, -1);
+		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
+			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
+		else
+			WRITE_ONCE(tp->linger2, val * HZ);
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -3576,15 +3584,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			tp->save_syn = val;
 		break;
 
-	case TCP_LINGER2:
-		if (val < 0)
-			WRITE_ONCE(tp->linger2, -1);
-		else if (val > TCP_FIN_TIMEOUT_MAX / HZ)
-			WRITE_ONCE(tp->linger2, TCP_FIN_TIMEOUT_MAX);
-		else
-			WRITE_ONCE(tp->linger2, val * HZ);
-		break;
-
 	case TCP_DEFER_ACCEPT:
 		/* Translate value in seconds to number of retransmits */
 		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 670c3dab24f2b4d3ab4af84a2715a134cd22b443..f445f5a7c0ebf5f7ab2b2402357f3749d954c0e8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6625,7 +6625,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			break;
 		}
 
-		if (tp->linger2 < 0) {
+		if (READ_ONCE(tp->linger2) < 0) {
 			tcp_done(sk);
 			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
 			return 1;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index f99e2d06ae7cae72efcafe2bd664545fac8f3fee..d45c96c7f5a4473628bd76366c1b5694a2904aec 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -714,7 +714,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 
 	tcp_mstamp_refresh(tp);
 	if (sk->sk_state == TCP_FIN_WAIT2 && sock_flag(sk, SOCK_DEAD)) {
-		if (tp->linger2 >= 0) {
+		if (READ_ONCE(tp->linger2) >= 0) {
 			const int tmo = tcp_fin_time(sk) - TCP_TIMEWAIT_LEN;
 
 			if (tmo > 0) {
-- 
2.41.0.640.ga95def55d0-goog



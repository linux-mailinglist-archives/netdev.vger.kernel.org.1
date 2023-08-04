Return-Path: <netdev+bounces-24451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F28770376
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983B91C2188F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BBB17FE8;
	Fri,  4 Aug 2023 14:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DD718036
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:29 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2F946B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso23896407b3.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160387; x=1691765187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3jydhN5UAsbY+pcwR4cDXJ7Mt5/LfgJ82P0rT9nXoE=;
        b=wGni3e6tkZzrB7kV9Pme0rgkcdDIH2P8SuUSYhzvi7x+U8waEXxWcw4hxhyubE8/KD
         g6ElcyOOMo0aQuR050jbnQbzU7QSGfUQZUBZLfK1aPRSoDscFeKcuYZ1KE0ZljUzer+L
         OboubygLyuuf+YUEtzRo8hV5nG/yXbPf+Tyjx/Btg9RfazwkrwwD6i8BD0+AsIYDAyxo
         2yqoh26OMWEWsuGFrs0C/QRJsnUPBa1izp+ffltA4vnxQwjPfKI3/uTHFBNEHjgdisU+
         JvTZYFBNa2THwW/P2/kOBXeO4zySkVHXXw0xwfWXLgnmCrXVxl0d7pBml92VZp1CLV0Q
         QFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160387; x=1691765187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3jydhN5UAsbY+pcwR4cDXJ7Mt5/LfgJ82P0rT9nXoE=;
        b=YceuOAHfoKKO1ypodYgaqskYHnzp7vNLd+eCEG5ER4oef5UXfe9qFkSHw7L7QbP+Ql
         53t1C+7GRQHJfAJ7gBPjXQf6PXYodixRLDyUuyZGIXV4BjXx7iqG4UyYWCuxgLwE8CbD
         TYSSLoDzg00dy9PtZUsY3Va9n6E4Lt641C8vTKNakzJdSx6jUGZ1l9KD087Rat8SL/Ld
         y4UZKe487qUNQgZnu9JNW6EYHseTgxIyardGssB0TRy7fiQXdin17P3b/NJiajIPpxQN
         ch6yRW6s6Fm0mSN/P4puHV3dLgiByVEfy2d/eVNHF05Sj97wnP11AmBJNdyYjb8RXxIB
         Pagg==
X-Gm-Message-State: AOJu0YwQ2aZorPZW93jo2l8VELAcbwtIvwEJnYgujDTMUvHTRTP4ouii
	hUagJeobzTdv+XfIgHCqhabW7HP7IX2hAw==
X-Google-Smtp-Source: AGHT+IFeMJNwFiCJ0cdalO3ET+X9Q0sDGKmGCA0aGvBX4JdOpcVzcZNvatJGzZ1P0wgur8wpHpLrBwpvPigflQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:e448:0:b0:586:b332:8617 with SMTP id
 t8-20020a81e448000000b00586b3328617mr5795ywl.9.1691160387350; Fri, 04 Aug
 2023 07:46:27 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:16 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-7-edumazet@google.com>
Subject: [PATCH net-next 6/6] tcp: set TCP_DEFER_ACCEPT locklessly
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

rskq_defer_accept field can be read/written without
the need of holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c           | 13 ++++++-------
 net/ipv4/tcp_input.c     |  2 +-
 net/ipv4/tcp_minisocks.c |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5c71b4fe11d1c34456976d60eb8742641111dd62..4fbc7ff8c53c05cbef3d108527239c7ec8c1363e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3479,6 +3479,12 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		else
 			WRITE_ONCE(tp->linger2, val * HZ);
 		return 0;
+	case TCP_DEFER_ACCEPT:
+		/* Translate value in seconds to number of retransmits */
+		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
+			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
+					   TCP_RTO_MAX / HZ));
+		return 0;
 	}
 
 	sockopt_lock_sock(sk);
@@ -3584,13 +3590,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 			tp->save_syn = val;
 		break;
 
-	case TCP_DEFER_ACCEPT:
-		/* Translate value in seconds to number of retransmits */
-		WRITE_ONCE(icsk->icsk_accept_queue.rskq_defer_accept,
-			   secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
-					   TCP_RTO_MAX / HZ));
-		break;
-
 	case TCP_WINDOW_CLAMP:
 		err = tcp_set_window_clamp(sk, val);
 		break;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f445f5a7c0ebf5f7ab2b2402357f3749d954c0e8..972c3b16369589293eb15febe52e72d5c596b032 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6325,7 +6325,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		if (fastopen_fail)
 			return -1;
 		if (sk->sk_write_pending ||
-		    icsk->icsk_accept_queue.rskq_defer_accept ||
+		    READ_ONCE(icsk->icsk_accept_queue.rskq_defer_accept) ||
 		    inet_csk_in_pingpong_mode(sk)) {
 			/* Save one ACK. Data will be ready after
 			 * several ticks, if write_pending is set.
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index c8f2aa0033871ed3f8b6b045c2cbca6e88bf2b61..32a70e3530db3247986ab5cb08c8a46babf86ad6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -794,7 +794,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		return sk;
 
 	/* While TCP_DEFER_ACCEPT is active, drop bare ACK. */
-	if (req->num_timeout < inet_csk(sk)->icsk_accept_queue.rskq_defer_accept &&
+	if (req->num_timeout < READ_ONCE(inet_csk(sk)->icsk_accept_queue.rskq_defer_accept) &&
 	    TCP_SKB_CB(skb)->end_seq == tcp_rsk(req)->rcv_isn + 1) {
 		inet_rsk(req)->acked = 1;
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPDEFERACCEPTDROP);
-- 
2.41.0.640.ga95def55d0-goog



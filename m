Return-Path: <netdev+bounces-28674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59977803AF
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ADB2821C2
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A68808;
	Fri, 18 Aug 2023 02:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35FF39C
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:11:37 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47653358A
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:11:35 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso5662117b3.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 19:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692324694; x=1692929494;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmH8D6GkN3nklyb+azpwGjYz507MrAs8w+OMyYT4eP4=;
        b=1DARFPf/NsOIzRCRy/H6bqipERm1aaIIQHKGycS4xuOO/YXTrtm32E2R0YaD5o/PTP
         GCy4IRpNoOXWT1LAjdsxlNjJA/F9h/2eOeaIBIAK7CQuExzEKxUn2atlYuBqD6iocKCM
         Xauo6N97U1pu+ZWvKc1u6ROpG4FAKUwUjPjHaKsVSVyGR1nKjNkG84sRsBfJtm2nUlZp
         FOiDDnhtxw3AQCE0pLS3/sPGg/iEoasQ4dTnbM6kok/kA4lRlmLztgLWrfbdYYufFu8O
         +0aS4fAPqfO4hfeLEgCuwR/ik+JqD7lhXoJeVPvkrrW2qKVN5Gg+fbtZ5Dj2HCHoCqaL
         BwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324694; x=1692929494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmH8D6GkN3nklyb+azpwGjYz507MrAs8w+OMyYT4eP4=;
        b=KW/Qs+Z0efhpF15Y7yCFI9jDLkVHIw7RbOCmA1BGrm+4mLk2TwXjRm281PbtizzZ6X
         NkfE+8JfjisI6uphISdfHYkRrgqmMmdEQb5CMS0KQxaaDCkHMZVJY3U2p/v6hHTgmWS2
         EW9BkRcc37WZIdUvWfw/CZ8afzOjE2ESiJVWnEdjueECKyK70Z05FhMCvTgpjtI5TaMi
         UW1KrquMxB66toDhsj9GuKCG+C2akhuo7mv4TtXOWLXAZaLL7y7xb3EXxs9Oi2lUHBs1
         6OT2BEHZGuWg4DChgHOkxn2Jihk5vf1E/UcbCYA88Ai/YWaez7gOIXRc6pUiexexmDyf
         YrQA==
X-Gm-Message-State: AOJu0Yz1xuqPaZT5Rl7DkK3Bxu4DM+1oDhRejRmr+hFpsUFEy6grEsMy
	B9QHptAz0kZZryy+hikEU9EoXZrrMxs0rw==
X-Google-Smtp-Source: AGHT+IGBtbu4AycyFeeM/kNeL+1+AD+U78sW/w7XNvDA0vbcI9wgjVAvlEENcrF/NRn+76rlfJ+WQUow3qmQJg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4420:0:b0:583:a8dc:1165 with SMTP id
 r32-20020a814420000000b00583a8dc1165mr15079ywa.10.1692324694421; Thu, 17 Aug
 2023 19:11:34 -0700 (PDT)
Date: Fri, 18 Aug 2023 02:11:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021132.2796092-1-edumazet@google.com>
Subject: [PATCH net-next] net: annotate data-races around sk->sk_lingertime
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

sk_getsockopt() runs locklessly. This means sk->sk_lingertime
can be read while other threads are changing its value.

Other reads also happen without socket lock being held,
and must be annotated.

Remove preprocessor logic using BITS_PER_LONG, compilers
are smart enough to figure this by themselves.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bluetooth/iso.c |  2 +-
 net/bluetooth/sco.c |  2 +-
 net/core/sock.c     | 18 +++++++++---------
 net/sched/em_meta.c |  2 +-
 net/smc/af_smc.c    |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6b66d6a88b9a22adf208b24e0a31d6f236355d9b..3c03e49422c7519167a0a2a6f5bdc8af5b2c0cd0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1475,7 +1475,7 @@ static int iso_sock_release(struct socket *sock)
 
 	iso_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 50ad5935ae47a31cb3d11a8b56f7d462cbaf2366..c736186aba26beadccd76c66f0af72835d740551 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1245,7 +1245,7 @@ static int sco_sock_release(struct socket *sock)
 
 	sco_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/core/sock.c b/net/core/sock.c
index 22d94394335fb75f12da65368e87c5a65167cc0e..e11952aee3777a5df51abdf70d30fbd3ec3a50fc 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -797,7 +797,7 @@ EXPORT_SYMBOL(sock_set_reuseport);
 void sock_no_linger(struct sock *sk)
 {
 	lock_sock(sk);
-	sk->sk_lingertime = 0;
+	WRITE_ONCE(sk->sk_lingertime, 0);
 	sock_set_flag(sk, SOCK_LINGER);
 	release_sock(sk);
 }
@@ -1230,15 +1230,15 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EFAULT;
 			break;
 		}
-		if (!ling.l_onoff)
+		if (!ling.l_onoff) {
 			sock_reset_flag(sk, SOCK_LINGER);
-		else {
-#if (BITS_PER_LONG == 32)
-			if ((unsigned int)ling.l_linger >= MAX_SCHEDULE_TIMEOUT/HZ)
-				sk->sk_lingertime = MAX_SCHEDULE_TIMEOUT;
+		} else {
+			unsigned int t_sec = ling.l_linger;
+
+			if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
+				WRITE_ONCE(sk->sk_lingertime, MAX_SCHEDULE_TIMEOUT);
 			else
-#endif
-				sk->sk_lingertime = (unsigned int)ling.l_linger * HZ;
+				WRITE_ONCE(sk->sk_lingertime, t_sec * HZ);
 			sock_set_flag(sk, SOCK_LINGER);
 		}
 		break;
@@ -1692,7 +1692,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	case SO_LINGER:
 		lv		= sizeof(v.ling);
 		v.ling.l_onoff	= sock_flag(sk, SOCK_LINGER);
-		v.ling.l_linger	= sk->sk_lingertime / HZ;
+		v.ling.l_linger	= READ_ONCE(sk->sk_lingertime) / HZ;
 		break;
 
 	case SO_BSDCOMPAT:
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 6fdba069f6bfd306fa68fc2e68bdcaf0cf4d4e9e..da34fd4c92695f453f1d6547c6e4e8d3afe7a116 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -502,7 +502,7 @@ META_COLLECTOR(int_sk_lingertime)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_lingertime / HZ;
+	dst->value = READ_ONCE(sk->sk_lingertime) / HZ;
 }
 
 META_COLLECTOR(int_sk_err_qlen)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5834af5fad535c420381827548cecdf0d03b0d5..7c77565c39d19c7f1baf1184c4a5bf950c9cfe33 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1820,7 +1820,7 @@ void smc_close_non_accepted(struct sock *sk)
 	lock_sock(sk);
 	if (!sk->sk_lingertime)
 		/* wait for peer closing */
-		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
+		WRITE_ONCE(sk->sk_lingertime, SMC_MAX_STREAM_WAIT_TIMEOUT);
 	__smc_release(smc);
 	release_sock(sk);
 	sock_put(sk); /* sock_hold above */
-- 
2.42.0.rc1.204.g551eb34607-goog



Return-Path: <netdev+bounces-24447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2B770369
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016611C21895
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1645CCA72;
	Fri,  4 Aug 2023 14:46:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A075CA60
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:23 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501A646B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d27ac992539so2197047276.3
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160381; x=1691765181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKhdujCQoEOxwPOVaa+Vpti28UTR5KT8mv1PCuFZsds=;
        b=XDDeP6khV5q/pXoU320ZfKkYXhEoJKiog1/kT4Oswx7EbitZJzei4G6o2QUJVSaQXW
         glAH4RVXke5JyqNNtxH6JqAANbd0Unl+H8DoGNpSXQ/ucy0W6bV4+GF+kJCur2YkjUrr
         X3dhEuIkXwzFwZd8gu/en0ki3OxnrXDRNM7/TnDJPGcpSWJo/2YsuoypTz1v6jMUanbp
         R5W2ofWRUUIpmKUEfDDWd2zZ1rbIy9dVK+OkOeDVUYRbDYfN2ID/uo4ku/r0/OEy5KFq
         ECmfRHloTVdZ+jKQTU5sD/Sr34IFxjstqMnjGO4vz+JpLmHMgyFQ00km6it8Lr27sxhG
         IY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160381; x=1691765181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKhdujCQoEOxwPOVaa+Vpti28UTR5KT8mv1PCuFZsds=;
        b=jVJeh6vZWM2nFAWn3Bxo9sSNigxn1yHa76jl4nR66vO1GPpvwgYp5ambL8ltZQZaUG
         MZ+F2YWwIHXKB+n7HEUZ4IYA2UfTW1wQlVXyx0wMri+ylxA/vhQ5rA4ZGEVA0FXEkgmP
         L1TGHr22yX5oZIG9o39nAKf5cVX5BRuNzvAELam3Q/xLosga1ssHUnluQi1duRdrodx0
         Skd189XE6Syc+2bWo9SVT7fmPf35AfDS+ObSDgyRdf4ug7nzZWVPDOpsRFA/HtAsgyhw
         E2TOr13A15w1yqHW/CxFtL3h6lVggXKnfiV5ievaJOiCi+Oe79DayOXfmIlaGO8eiGqx
         VRDw==
X-Gm-Message-State: AOJu0Yzv17v0hZSSTQhlfIpwoUpAatXmswXjLyLFhZhcO4qwzFGZEC6q
	5wI0YpwSdNlrOH5Xfgw2CedwOC4D9tTYwA==
X-Google-Smtp-Source: AGHT+IEPdEsLtAwBUr2s0MYv0ouJ4nR229f97tyPOtRSVL5+Twp05gnDCchwWrFDAwnYAZaHm99PfXHfXxv8HQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:4a7:b0:d11:3c58:2068 with SMTP
 id r7-20020a05690204a700b00d113c582068mr9431ybs.2.1691160381556; Fri, 04 Aug
 2023 07:46:21 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:12 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-3-edumazet@google.com>
Subject: [PATCH net-next 2/6] tcp: set TCP_USER_TIMEOUT locklessly
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

icsk->icsk_user_timeout can be set locklessly,
if all read sides use READ_ONCE().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h  |  2 +-
 net/ipv4/tcp.c       | 23 ++++++++++-------------
 net/ipv4/tcp_timer.c | 37 ++++++++++++++++++++++---------------
 3 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index d16abdb3541a6c07a5d7db59915089f74ee25092..3c5efeeb024f651c90ae4a9ca704dcf16e4adb11 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -564,6 +564,6 @@ void __tcp_sock_set_nodelay(struct sock *sk, bool on);
 void tcp_sock_set_nodelay(struct sock *sk);
 void tcp_sock_set_quickack(struct sock *sk, int val);
 int tcp_sock_set_syncnt(struct sock *sk, int val);
-void tcp_sock_set_user_timeout(struct sock *sk, u32 val);
+int tcp_sock_set_user_timeout(struct sock *sk, int val);
 
 #endif	/* _LINUX_TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index bcbb33a8c152abe2a060abd644689b54bcca1daa..34c2a40b024779866216402e1d1de1802f8dfde4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3296,11 +3296,16 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 }
 EXPORT_SYMBOL(tcp_sock_set_syncnt);
 
-void tcp_sock_set_user_timeout(struct sock *sk, u32 val)
+int tcp_sock_set_user_timeout(struct sock *sk, int val)
 {
-	lock_sock(sk);
+	/* Cap the max time in ms TCP will retry or probe the window
+	 * before giving up and aborting (ETIMEDOUT) a connection.
+	 */
+	if (val < 0)
+		return -EINVAL;
+
 	WRITE_ONCE(inet_csk(sk)->icsk_user_timeout, val);
-	release_sock(sk);
+	return 0;
 }
 EXPORT_SYMBOL(tcp_sock_set_user_timeout);
 
@@ -3464,6 +3469,8 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case TCP_SYNCNT:
 		return tcp_sock_set_syncnt(sk, val);
+	case TCP_USER_TIMEOUT:
+		return tcp_sock_set_user_timeout(sk, val);
 	}
 
 	sockopt_lock_sock(sk);
@@ -3611,16 +3618,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
 		break;
 #endif
-	case TCP_USER_TIMEOUT:
-		/* Cap the max time in ms TCP will retry or probe the window
-		 * before giving up and aborting (ETIMEDOUT) a connection.
-		 */
-		if (val < 0)
-			err = -EINVAL;
-		else
-			WRITE_ONCE(icsk->icsk_user_timeout, val);
-		break;
-
 	case TCP_FASTOPEN:
 		if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
 		    TCPF_LISTEN))) {
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 66040ab457d46ffa2fac62f875b636f567157793..f99e2d06ae7cae72efcafe2bd664545fac8f3fee 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -26,14 +26,15 @@
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 elapsed, start_ts;
+	u32 elapsed, start_ts, user_timeout;
 	s32 remaining;
 
 	start_ts = tcp_sk(sk)->retrans_stamp;
-	if (!icsk->icsk_user_timeout)
+	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
+	if (!user_timeout)
 		return icsk->icsk_rto;
 	elapsed = tcp_time_stamp(tcp_sk(sk)) - start_ts;
-	remaining = icsk->icsk_user_timeout - elapsed;
+	remaining = user_timeout - elapsed;
 	if (remaining <= 0)
 		return 1; /* user timeout has passed; fire ASAP */
 
@@ -43,16 +44,17 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
-	u32 remaining;
+	u32 remaining, user_timeout;
 	s32 elapsed;
 
-	if (!icsk->icsk_user_timeout || !icsk->icsk_probes_tstamp)
+	user_timeout = READ_ONCE(icsk->icsk_user_timeout);
+	if (!user_timeout || !icsk->icsk_probes_tstamp)
 		return when;
 
 	elapsed = tcp_jiffies32 - icsk->icsk_probes_tstamp;
 	if (unlikely(elapsed < 0))
 		elapsed = 0;
-	remaining = msecs_to_jiffies(icsk->icsk_user_timeout) - elapsed;
+	remaining = msecs_to_jiffies(user_timeout) - elapsed;
 	remaining = max_t(u32, remaining, TCP_TIMEOUT_MIN);
 
 	return min_t(u32, remaining, when);
@@ -270,7 +272,7 @@ static int tcp_write_timeout(struct sock *sk)
 	}
 	if (!expired)
 		expired = retransmits_timed_out(sk, retry_until,
-						icsk->icsk_user_timeout);
+						READ_ONCE(icsk->icsk_user_timeout));
 	tcp_fastopen_active_detect_blackhole(sk, expired);
 
 	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
@@ -384,13 +386,16 @@ static void tcp_probe_timer(struct sock *sk)
 	 * corresponding system limit. We also implement similar policy when
 	 * we use RTO to probe window in tcp_retransmit_timer().
 	 */
-	if (!icsk->icsk_probes_tstamp)
+	if (!icsk->icsk_probes_tstamp) {
 		icsk->icsk_probes_tstamp = tcp_jiffies32;
-	else if (icsk->icsk_user_timeout &&
-		 (s32)(tcp_jiffies32 - icsk->icsk_probes_tstamp) >=
-		 msecs_to_jiffies(icsk->icsk_user_timeout))
-		goto abort;
+	} else {
+		u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
 
+		if (user_timeout &&
+		    (s32)(tcp_jiffies32 - icsk->icsk_probes_tstamp) >=
+		     msecs_to_jiffies(user_timeout))
+		goto abort;
+	}
 	max_probes = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_retries2);
 	if (sock_flag(sk, SOCK_DEAD)) {
 		const bool alive = inet_csk_rto_backoff(icsk, TCP_RTO_MAX) < TCP_RTO_MAX;
@@ -734,13 +739,15 @@ static void tcp_keepalive_timer (struct timer_list *t)
 	elapsed = keepalive_time_elapsed(tp);
 
 	if (elapsed >= keepalive_time_when(tp)) {
+		u32 user_timeout = READ_ONCE(icsk->icsk_user_timeout);
+
 		/* If the TCP_USER_TIMEOUT option is enabled, use that
 		 * to determine when to timeout instead.
 		 */
-		if ((icsk->icsk_user_timeout != 0 &&
-		    elapsed >= msecs_to_jiffies(icsk->icsk_user_timeout) &&
+		if ((user_timeout != 0 &&
+		    elapsed >= msecs_to_jiffies(user_timeout) &&
 		    icsk->icsk_probes_out > 0) ||
-		    (icsk->icsk_user_timeout == 0 &&
+		    (user_timeout == 0 &&
 		    icsk->icsk_probes_out >= keepalive_probes(tp))) {
 			tcp_send_active_reset(sk, GFP_ATOMIC);
 			tcp_write_err(sk);
-- 
2.41.0.640.ga95def55d0-goog



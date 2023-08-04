Return-Path: <netdev+bounces-24446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8B5770368
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D2E1C21872
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE7ECA61;
	Fri,  4 Aug 2023 14:46:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FA0CA60
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:46:21 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AD46B2
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:46:20 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58419550c3aso23018187b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691160380; x=1691765180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll6WOHIDyiGe16b7v0a/9XfMKp3mLiNYGDTYzrthPFs=;
        b=nwxUP3g80ddlFF2yFxZK0V5HX/wkNoTlAomb0IK1sT53YBuyp2N5NMc6X/0VlpLALI
         qfuIrO575TudxjZKZTnHzK5IS4mKcmqNffQ6Dmc+zszKL6lrzsL6ZH4xhR+O/lzW7TTX
         ft5SswKXy3uNZKTZMAsi+EwO00/w1nborF+PcUdJ3bUo6RRz4EXMLQqjkWxjdlA2yBGz
         vYtfUGUSPuQ3eCz0maEW+ftKdnK2n9SBHJ6Ogj6zocCxtdikLx3Ya9bVxqZneuveg35n
         9KzcJ4PWnnXimGvV6DeVKR1aHZ1I3VkyV7UouZtVB14DHFrHMIVdtb1W5dT+KbQp8p+h
         pTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691160380; x=1691765180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll6WOHIDyiGe16b7v0a/9XfMKp3mLiNYGDTYzrthPFs=;
        b=h0MKXkj6oJ4+wimshpn8313rZZo1RGTfX3KVQXrZQXRECjYX/fntGvR1GjZX5ymWDS
         aV+5HTLYrmB7wZiOqGd58tKFmAbuqFSUSjPjFuNiuzfuZDfe1TLwdvRDjcTHwb+qSrvF
         L2c7lM5Dfmzi2O+Bof6Pbz42VP+n3Cfz1hw9BDkTY8UTm9eMncJdHIpUUf4TxW1By2VA
         gh4qkqXOeJUANNMf9LKy878Ye4ug7pqFDmEUjxVP4WKlVFOTvqnxr94ehiV2Em0waKcu
         JTaeKnDCz2mvpmzta569qqlSMPlZ1TRwfV31KgKqZCwP0V4HQ/u9lhqOfX6cIBDydoUk
         VRvg==
X-Gm-Message-State: AOJu0Yxs+ZlXSNtCFxHUm3ewnhQuts6C2c822V+oLZ3JmFr8RmqMyeWq
	ZXzjLK4KnMZL5eOltC55HrvQBGgKPmh+fg==
X-Google-Smtp-Source: AGHT+IF55LQkPHFFLx+B7brlpkO9R65Rp26dCr3I0S+tL4crs5kZcuC44O60oulpj/GaKkMXLL4I2x1+O4pttg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:858b:0:b0:d10:dd00:385 with SMTP id
 x11-20020a25858b000000b00d10dd000385mr12990ybk.0.1691160379980; Fri, 04 Aug
 2023 07:46:19 -0700 (PDT)
Date: Fri,  4 Aug 2023 14:46:11 +0000
In-Reply-To: <20230804144616.3938718-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804144616.3938718-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804144616.3938718-2-edumazet@google.com>
Subject: [PATCH net-next 1/6] tcp: set TCP_SYNCNT locklessly
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

icsk->icsk_syn_retries can safely be set without locking the socket.

We have to add READ_ONCE() annotations in tcp_fastopen_synack_timer()
and tcp_write_timeout().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 15 ++++++---------
 net/ipv4/tcp_timer.c |  9 ++++++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index aca5620cf3ba20be38d81b1b526c22623b145ff7..bcbb33a8c152abe2a060abd644689b54bcca1daa 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3291,9 +3291,7 @@ int tcp_sock_set_syncnt(struct sock *sk, int val)
 	if (val < 1 || val > MAX_TCP_SYNCNT)
 		return -EINVAL;
 
-	lock_sock(sk);
 	WRITE_ONCE(inet_csk(sk)->icsk_syn_retries, val);
-	release_sock(sk);
 	return 0;
 }
 EXPORT_SYMBOL(tcp_sock_set_syncnt);
@@ -3462,6 +3460,12 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 	if (copy_from_sockptr(&val, optval, sizeof(val)))
 		return -EFAULT;
 
+	/* Handle options that can be set without locking the socket. */
+	switch (optname) {
+	case TCP_SYNCNT:
+		return tcp_sock_set_syncnt(sk, val);
+	}
+
 	sockopt_lock_sock(sk);
 
 	switch (optname) {
@@ -3569,13 +3573,6 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		else
 			WRITE_ONCE(tp->keepalive_probes, val);
 		break;
-	case TCP_SYNCNT:
-		if (val < 1 || val > MAX_TCP_SYNCNT)
-			err = -EINVAL;
-		else
-			WRITE_ONCE(icsk->icsk_syn_retries, val);
-		break;
-
 	case TCP_SAVE_SYN:
 		/* 0: disable, 1: enable, 2: start from ether_header */
 		if (val < 0 || val > 2)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 470f581eedd438b3bbd6ae4973c7a6f01ee1724f..66040ab457d46ffa2fac62f875b636f567157793 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -239,7 +239,8 @@ static int tcp_write_timeout(struct sock *sk)
 	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV)) {
 		if (icsk->icsk_retransmits)
 			__dst_negative_advice(sk);
-		retry_until = icsk->icsk_syn_retries ? :
+		/* Paired with WRITE_ONCE() in tcp_sock_set_syncnt() */
+		retry_until = READ_ONCE(icsk->icsk_syn_retries) ? :
 			READ_ONCE(net->ipv4.sysctl_tcp_syn_retries);
 
 		max_retransmits = retry_until;
@@ -421,8 +422,10 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 
 	req->rsk_ops->syn_ack_timeout(req);
 
-	/* add one more retry for fastopen */
-	max_retries = icsk->icsk_syn_retries ? :
+	/* Add one more retry for fastopen.
+	 * Paired with WRITE_ONCE() in tcp_sock_set_syncnt()
+	 */
+	max_retries = READ_ONCE(icsk->icsk_syn_retries) ? :
 		READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_synack_retries) + 1;
 
 	if (req->num_timeout >= max_retries) {
-- 
2.41.0.640.ga95def55d0-goog



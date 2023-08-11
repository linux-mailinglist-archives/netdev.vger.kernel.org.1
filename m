Return-Path: <netdev+bounces-26666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB65778865
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F45281BE0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985074C94;
	Fri, 11 Aug 2023 07:36:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C76FBB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63557E75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5867fe87d16so21505247b3.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739404; x=1692344204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0plM6V3bMnRhL1KXlw03oco6/lGMCEsM4whyHGB68=;
        b=tCi/mg73jMMcGMyD1GGhoqRvq76fISRqR0F9AVkmvcCoKyTdH06Jcs8yR7l48mnuMh
         q/YJxIH/+4zSDKQH5JXZlRmM9qAr5vYjOnJPdzsFeeH6a8wCoRLWxOjcmSpvZhaVd6XH
         qnGst4e3pd3jF9cCmt9HW1p7cv2oK6RGVY7uVEjtCDWqCTp8XU2SPfKTY21mXqbln2hO
         ZgqHbbeyaiQXM/MYzJQg1v+1Is65G32eSUJXj4sDcBa5edO9U0eOiimm2jgK4YpdLBAY
         1XbIKZIX4RoTJJAxCLVgJ2pEZqeq5wQOB35yJ6/iT7x8NxybYP2SxaNMd0Xa1nflT2P7
         Pe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739404; x=1692344204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0plM6V3bMnRhL1KXlw03oco6/lGMCEsM4whyHGB68=;
        b=U/4FRNc4xtmZumA9vMUGIiYQZqUdPE67B7WbICw8r22leY1Jq2sjQ8ITkJIJPYiH9k
         TWmPhSapk6a0fyDmE3v01CB77VPMgMbwLWDia8otok+GZbbjUCHdXJMS8L0ItjbItrOP
         SAkXyIE7zOQKqOGfugPwilMgSU+7GJ5YXd8WVzo7PKnvuUrijZCZ/E8y5bqXrXHp+J8Z
         xS/9o/coiAjNLRcEX0dQRRDEqNK65EVV0jkw5alzHmKjfc8Kvrp1fp0l04c64rx2vddF
         d6O9K1Tw6RHeZVGDqBx1Cukujg5ub14AmTo1gRPZaiO/yrq/jMsHq/WShUNyWzNFtmd1
         +4Hw==
X-Gm-Message-State: AOJu0Yz0zPlmSyV1IIHWB1ewt5w7UO4NXO8gUaNkwZF42wemVlpxcyax
	+J+aDb99Ar5YVd+JbJX8vE+DF6YPJYyWAg==
X-Google-Smtp-Source: AGHT+IERE9AF4EHJbIOe50Rrx4M8++80FF9ufkrUjv8zI5+F79Ies6RTBvHiayuxWPlbWjIPdA5BYKZCeKe0aA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:b623:0:b0:57a:793:7fb0 with SMTP id
 u35-20020a81b623000000b0057a07937fb0mr17791ywh.3.1691739404688; Fri, 11 Aug
 2023 00:36:44 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:19 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/15] inet: move inet->defer_connect to inet->inet_flags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make room in struct inet_sock by removing this bit field,
using one available bit in inet_flags instead.

Also move local_port_range to fill the resulting hole,
saving 8 bytes on 64bit arches.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h | 10 ++++------
 net/ipv4/af_inet.c      |  4 ++--
 net/ipv4/inet_diag.c    |  2 +-
 net/ipv4/tcp.c          | 12 +++++++-----
 net/ipv4/tcp_fastopen.c |  2 +-
 net/mptcp/protocol.c    | 12 ++++++++----
 6 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 5eca2e70cbb2c16d26caa7f219ae53fe066ea3bd..acbb93d7607ab873783802b4be6a23f54e2086d3 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -229,21 +229,18 @@ struct inet_sock {
 	__u8			min_ttl;
 	__u8			mc_ttl;
 	__u8			pmtudisc;
-	__u8			defer_connect:1; /* Indicates that fastopen_connect is set
-						  * and cookie exists so we defer connect
-						  * until first data frame is written
-						  */
 	__u8			rcv_tos;
 	__u8			convert_csum;
 	int			uc_index;
 	int			mc_index;
 	__be32			mc_addr;
-	struct ip_mc_socklist __rcu	*mc_list;
-	struct inet_cork_full	cork;
 	struct {
 		__u16 lo;
 		__u16 hi;
 	}			local_port_range;
+
+	struct ip_mc_socklist __rcu	*mc_list;
+	struct inet_cork_full	cork;
 };
 
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
@@ -270,6 +267,7 @@ enum {
 	INET_FLAGS_IS_ICSK	= 16,
 	INET_FLAGS_NODEFRAG	= 17,
 	INET_FLAGS_BIND_ADDRESS_NO_PORT = 18,
+	INET_FLAGS_DEFER_CONNECT = 19,
 };
 
 /* cmsg flags for inet */
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index c591f04eb6a9fc3b7b37a4b93b826a35488b9b50..3f4ac026b07ddcc8d5d8a791da363b56f2ce2746 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -646,7 +646,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		err = -EISCONN;
 		goto out;
 	case SS_CONNECTING:
-		if (inet_sk(sk)->defer_connect)
+		if (inet_test_bit(DEFER_CONNECT, sk))
 			err = is_sendmsg ? -EINPROGRESS : -EISCONN;
 		else
 			err = -EALREADY;
@@ -669,7 +669,7 @@ int __inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 		sock->state = SS_CONNECTING;
 
-		if (!err && inet_sk(sk)->defer_connect)
+		if (!err && inet_test_bit(DEFER_CONNECT, sk))
 			goto out;
 
 		/* Just entered SS_CONNECTING state; the only
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 128966dea5540caaa94f6b87db4d3960d177caac..e13a84433413ed88088435ff8e11efeb30fc3cca 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -192,7 +192,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 	inet_sockopt.nodefrag	= inet_test_bit(NODEFRAG, sk);
 	inet_sockopt.bind_address_no_port = inet_test_bit(BIND_ADDRESS_NO_PORT, sk);
 	inet_sockopt.recverr_rfc4884 = inet_test_bit(RECVERR_RFC4884, sk);
-	inet_sockopt.defer_connect = inet->defer_connect;
+	inet_sockopt.defer_connect = inet_test_bit(DEFER_CONNECT, sk);
 	if (nla_put(skb, INET_DIAG_SOCKOPT, sizeof(inet_sockopt),
 		    &inet_sockopt))
 		goto errout;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4fbc7ff8c53c05cbef3d108527239c7ec8c1363e..cee1e548660cb93835102836fe8103666c4c4697 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -583,7 +583,8 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 
 		if (urg_data & TCP_URG_VALID)
 			mask |= EPOLLPRI;
-	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
+	} else if (state == TCP_SYN_SENT &&
+		   inet_test_bit(DEFER_CONNECT, sk)) {
 		/* Active TCP fastopen socket with defer_connect
 		 * Return EPOLLOUT so application can call write()
 		 * in order for kernel to generate SYN+data
@@ -1007,7 +1008,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	tp->fastopen_req->size = size;
 	tp->fastopen_req->uarg = uarg;
 
-	if (inet->defer_connect) {
+	if (inet_test_bit(DEFER_CONNECT, sk)) {
 		err = tcp_connect(sk);
 		/* Same failure procedure as in tcp_v4/6_connect */
 		if (err) {
@@ -1025,7 +1026,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	if (tp->fastopen_req) {
 		*copied = tp->fastopen_req->copied;
 		tcp_free_fastopen_req(tp);
-		inet->defer_connect = 0;
+		inet_clear_bit(DEFER_CONNECT, sk);
 	}
 	return err;
 }
@@ -1066,7 +1067,8 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			zc = MSG_SPLICE_PAGES;
 	}
 
-	if (unlikely(flags & MSG_FASTOPEN || inet_sk(sk)->defer_connect) &&
+	if (unlikely(flags & MSG_FASTOPEN ||
+		     inet_test_bit(DEFER_CONNECT, sk)) &&
 	    !tp->repair) {
 		err = tcp_sendmsg_fastopen(sk, msg, &copied_syn, size, uarg);
 		if (err == -EINPROGRESS && copied_syn > 0)
@@ -3088,7 +3090,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 	/* Clean up fastopen related fields */
 	tcp_free_fastopen_req(tp);
-	inet->defer_connect = 0;
+	inet_clear_bit(DEFER_CONNECT, sk);
 	tp->fastopen_client_fail = 0;
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 85e4953f118215ba7100931dccb37ad871c5dfd2..8ed54e7334a9c646dfbbc6dc41b9ef11b925de0a 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -451,7 +451,7 @@ bool tcp_fastopen_defer_connect(struct sock *sk, int *err)
 
 	if (tp->fastopen_connect && !tp->fastopen_req) {
 		if (tcp_fastopen_cookie_check(sk, &mss, &cookie)) {
-			inet_sk(sk)->defer_connect = 1;
+			inet_set_bit(DEFER_CONNECT, sk);
 			return true;
 		}
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 48e649fe2360daf3939fccb0f9ec1a2398670a04..2332e1c4ec7b52a12a1c29d41064b6d8277f864e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1690,7 +1690,7 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
 		if (!mptcp_disconnect(sk, 0))
 			sk->sk_socket->state = SS_UNCONNECTED;
 	}
-	inet_sk(sk)->defer_connect = 0;
+	inet_clear_bit(DEFER_CONNECT, sk);
 
 	return ret;
 }
@@ -1708,7 +1708,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
-	if (unlikely(inet_sk(sk)->defer_connect || msg->msg_flags & MSG_FASTOPEN)) {
+	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
+		     msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
 
 		ret = mptcp_sendmsg_fastopen(sk, msg, len, &copied_syn);
@@ -3618,7 +3619,9 @@ static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 		err = __inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK, 1);
 	else
 		err = inet_stream_connect(ssock, uaddr, addr_len, O_NONBLOCK);
-	inet_sk(sk)->defer_connect = inet_sk(ssock->sk)->defer_connect;
+
+	inet_assign_bit(DEFER_CONNECT, sk,
+			inet_test_bit(DEFER_CONNECT, ssock->sk));
 
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
@@ -3837,7 +3840,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
 			mask |= mptcp_check_writeable(msk);
-	} else if (state == TCP_SYN_SENT && inet_sk(sk)->defer_connect) {
+	} else if (state == TCP_SYN_SENT &&
+		   inet_test_bit(DEFER_CONNECT, sk)) {
 		/* cf tcp_poll() note about TFO */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-- 
2.41.0.640.ga95def55d0-goog



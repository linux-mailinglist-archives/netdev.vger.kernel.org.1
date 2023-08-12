Return-Path: <netdev+bounces-27031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72545779EA2
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8F71C204F6
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 09:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B4187D;
	Sat, 12 Aug 2023 09:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5F18BF3
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 09:34:07 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C10DA
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so3081857276.1
        for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691832845; x=1692437645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0plM6V3bMnRhL1KXlw03oco6/lGMCEsM4whyHGB68=;
        b=h57OqPAAomLLoDmSZY48kUWlUvfLIoJO5lyROtVhMKkV6VIpSPpf5yKbPA07e0umUc
         SZfYp0BdF7nf/oLMhXjZNigZUOwgqxXvFfHCLdH148v5bBEsrGfZkRlk4ODf8gq9+WXV
         abnlyIRnhe5vPM8Eq8Bx7eSTEpLdx0zwvqRuk4Ch7Ej3J2PNZGB+EsAANh1muDyvpskB
         tZsEZunxdBEClSm00G11VBUSU18J0qDPJ8zKn6kB3kjlOVYW496U+68ehSiev4YuCz8P
         b94DEZeT8n4Z5+FHQd8Tkudj7g4ilRh8y/VH9I8CP5Df6W4RZuOwYmCFKGa2TjzDms1p
         1EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691832845; x=1692437645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yA0plM6V3bMnRhL1KXlw03oco6/lGMCEsM4whyHGB68=;
        b=ei1ZBPQuAzeafX7b5liqrMr0UEXgrfdD5mKmwf462cOSx3eDMLK+S5tO6aPitA5xPN
         SfGGjBPp1lEs7NIA07b6cjHTXr4wX5kwmiEmWQfWMaWGgdZ7pWc9w9a66NN957Uz/LQs
         9esRfGWxP428oWEOnAS2y36XRvYxIxN/9xb/sGwVuUMEbWfpyrx65FVLGUEUJISFAxbs
         4bP7Lg67Upg/wNiyadQZSP2Sf/adAq5wITzmsyZhSYiCMkJd42M0PUnL8mBtplaAzv0u
         X0eva/6jZ1yEr//F2DpujxJsMKBJZPVEH5E0wuhRTPKnLDFtJA+5MSxpgqZ57uyfVJoZ
         7j5Q==
X-Gm-Message-State: AOJu0YxAtp2VF52kwXbhivtwaIks+Fuht1cZkXHwTdJx0+eSUtfKsVMj
	66uPUFasGavmXwSz59vIjzLzQ0BtD2jVFQ==
X-Google-Smtp-Source: AGHT+IGHO+yKSumj0TYfMvYHxdw6hgqY2Mrft18WsmVjmdvaxXvNEmCq2LW4lbYbYlClGgTQwsPozyxqitQFwA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:b0c:0:b0:d3d:74b6:e082 with SMTP id
 z12-20020a5b0b0c000000b00d3d74b6e082mr67976ybp.9.1691832845530; Sat, 12 Aug
 2023 02:34:05 -0700 (PDT)
Date: Sat, 12 Aug 2023 09:33:42 +0000
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230812093344.3561556-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230812093344.3561556-14-edumazet@google.com>
Subject: [PATCH v3 net-next 13/15] inet: move inet->defer_connect to inet->inet_flags
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



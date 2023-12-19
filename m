Return-Path: <netdev+bounces-58933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87168818A31
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E72728C8D2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141F1A293;
	Tue, 19 Dec 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhf8Aa0B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020741C68A
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc73761da8so4895491fa.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996719; x=1703601519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qKgoMy076WE34vDGvIcACbz4bJojD67rt9QR1z9EtFk=;
        b=Hhf8Aa0BKfjscoh1OeGrNhZsqh9usnFDbctv3VUnv8ogt0Dr4IS97dWRPcTNz0ktb2
         7+mAwVBwQC08pvpcFBozjKwhlem6W6fRplRjUgD+GhmqJJIJ51yQxZfG5A7epASHGq/I
         BhAahSbMK5LyzrbsIg8K1vGSZlhN7owdI+gZVOUdNc24xfsdSZSLqH5DCVKQsQOdem6i
         AdlCgDDmojRokRYwI4c/Ah7hlY8qcCxN9H8LPx9zdSztZy0aJVzgGgJabARsDLRHXeny
         fDA36g+tFjUg5KD2qTvk+SkC7wWsBwCosGWxqUa7jIiM0J7ix39e7mk2gaOLjSYNO9ql
         y6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996719; x=1703601519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKgoMy076WE34vDGvIcACbz4bJojD67rt9QR1z9EtFk=;
        b=XlaxSRbe2bGYcsGDsUfhxKBnij+9ypShaQY8M9BIP/kHiLc5HfMqAO2zkoCBuLk2O9
         ts2SuDqvdyrYNd5s4yhH58bD7jLrtm4mgZPhpz0Jui66DnKnREz8XYPO+pDW5fudpNWS
         YLXKYkD42+Twyor/06Tp4Z6gKF3zb8VnhhYeHm66Z57AiqxZtwy0Ylin0cyYycaXjyzO
         3SVNiDFNjJfMzn/0OOHRtYX1aYQ1JRy/1/dZVSyfzVZXNrwaGOKqPcVOhpLPSdwsDlYL
         lbDVmg/LnUZZ12eMRdoBRmat5ZRJIHsV2G+yjN8GkX+kdJkrIXVBN7HA0khE5i/5vi6i
         hBXQ==
X-Gm-Message-State: AOJu0YzRUYWXI5Rvk7bW8UFIhV4yQdPK7rbZmchCLhxbQMlpvy1XleXb
	qarqSJ1FGi79Kd+onqh+6Fg+XpvwoyBWWGMg
X-Google-Smtp-Source: AGHT+IHZlynjtMyoJq3VniF+c5LKYULwHY5lh7N8tv46jHe7SWw+9gWnb9h8ypsVWMhrrcv/QPOucw==
X-Received: by 2002:a2e:a99f:0:b0:2cc:6ce9:b927 with SMTP id x31-20020a2ea99f000000b002cc6ce9b927mr4927577ljq.1.1702996718430;
        Tue, 19 Dec 2023 06:38:38 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id c6-20020a2e9d86000000b002cc68cce064sm1011014ljj.62.2023.12.19.06.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:38:38 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH net-next v2 1/2] net: remove SOCK_DEBUG leftovers
Date: Tue, 19 Dec 2023 17:38:19 +0300
Message-Id: <20231219143820.9379-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SOCK_DEBUG comes from the old days. Let's
move logging to standard net core ratelimited logging functions

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>

changes in v2:
 - remove SOCK_DEBUG macro altogether
---
 net/appletalk/ddp.c      | 16 ++++++++--------
 net/dccp/ipv6.c          |  2 +-
 net/x25/af_x25.c         | 14 +++++++-------
 net/x25/x25_facilities.c | 14 +++++++-------
 net/x25/x25_out.c        |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index a852ec093fa8..198f5ba2feae 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1581,7 +1581,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	}
 
 	/* Build a packet */
-	SOCK_DEBUG(sk, "SK %p: Got address.\n", sk);
+	net_dbg_ratelimited("SK %p: Got address.\n", sk);
 
 	/* For headers */
 	size = sizeof(struct ddpehdr) + len + ddp_dl->header_length;
@@ -1602,7 +1602,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	dev = rt->dev;
 
-	SOCK_DEBUG(sk, "SK %p: Size needed %d, device %s\n",
+	net_dbg_ratelimited("SK %p: Size needed %d, device %s\n",
 			sk, size, dev->name);
 
 	hard_header_len = dev->hard_header_len;
@@ -1631,7 +1631,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	skb_reserve(skb, hard_header_len);
 	skb->dev = dev;
 
-	SOCK_DEBUG(sk, "SK %p: Begin build.\n", sk);
+	net_dbg_ratelimited("SK %p: Begin build.\n", sk);
 
 	ddp = skb_put(skb, sizeof(struct ddpehdr));
 	ddp->deh_len_hops  = htons(len + sizeof(*ddp));
@@ -1642,7 +1642,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	ddp->deh_dport = usat->sat_port;
 	ddp->deh_sport = at->src_port;
 
-	SOCK_DEBUG(sk, "SK %p: Copy user data (%zd bytes).\n", sk, len);
+	net_dbg_ratelimited("SK %p: Copy user data (%zd bytes).\n", sk, len);
 
 	err = memcpy_from_msg(skb_put(skb, len), msg, len);
 	if (err) {
@@ -1666,7 +1666,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 		if (skb2) {
 			loopback = 1;
-			SOCK_DEBUG(sk, "SK %p: send out(copy).\n", sk);
+			net_dbg_ratelimited("SK %p: send out(copy).\n", sk);
 			/*
 			 * If it fails it is queued/sent above in the aarp queue
 			 */
@@ -1675,7 +1675,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	}
 
 	if (dev->flags & IFF_LOOPBACK || loopback) {
-		SOCK_DEBUG(sk, "SK %p: Loop back.\n", sk);
+		net_dbg_ratelimited("SK %p: Loop back.\n", sk);
 		/* loop back */
 		skb_orphan(skb);
 		if (ddp->deh_dnode == ATADDR_BCAST) {
@@ -1689,7 +1689,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		}
 		ddp_dl->request(ddp_dl, skb, dev->dev_addr);
 	} else {
-		SOCK_DEBUG(sk, "SK %p: send out.\n", sk);
+		net_dbg_ratelimited("SK %p: send out.\n", sk);
 		if (rt->flags & RTF_GATEWAY) {
 		    gsat.sat_addr = rt->gateway;
 		    usat = &gsat;
@@ -1700,7 +1700,7 @@ static int atalk_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		 */
 		aarp_send_ddp(dev, skb, &usat->sat_addr, NULL);
 	}
-	SOCK_DEBUG(sk, "SK %p: Done write (%zd).\n", sk, len);
+	net_dbg_ratelimited("SK %p: Done write (%zd).\n", sk, len);
 
 out:
 	release_sock(sk);
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 06d7324276ec..ded07e09f813 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -889,7 +889,7 @@ static int dccp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 		u32 exthdrlen = icsk->icsk_ext_hdr_len;
 		struct sockaddr_in sin;
 
-		SOCK_DEBUG(sk, "connect: ipv4 mapped\n");
+		net_dbg_ratelimited("connect: ipv4 mapped\n");
 
 		if (ipv6_only_sock(sk))
 			return -ENETUNREACH;
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index aad8ffeaee04..f7a7c7798c3b 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -704,7 +704,7 @@ static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		rc = -EINVAL;
 	}
 	release_sock(sk);
-	SOCK_DEBUG(sk, "x25_bind: socket is bound\n");
+	net_dbg_ratelimited("x25_bind: socket is bound\n");
 out:
 	return rc;
 }
@@ -1165,10 +1165,10 @@ static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out;
 	}
 
-	SOCK_DEBUG(sk, "x25_sendmsg: sendto: Addresses built.\n");
+	net_dbg_ratelimited("x25_sendmsg: sendto: Addresses built.\n");
 
 	/* Build a packet */
-	SOCK_DEBUG(sk, "x25_sendmsg: sendto: building packet.\n");
+	net_dbg_ratelimited("x25_sendmsg: sendto: building packet.\n");
 
 	if ((msg->msg_flags & MSG_OOB) && len > 32)
 		len = 32;
@@ -1187,7 +1187,7 @@ static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/*
 	 *	Put the data on the end
 	 */
-	SOCK_DEBUG(sk, "x25_sendmsg: Copying user data\n");
+	net_dbg_ratelimited("x25_sendmsg: Copying user data\n");
 
 	skb_reset_transport_header(skb);
 	skb_put(skb, len);
@@ -1211,7 +1211,7 @@ static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	/*
 	 *	Push down the X.25 header
 	 */
-	SOCK_DEBUG(sk, "x25_sendmsg: Building X.25 Header.\n");
+	net_dbg_ratelimited("x25_sendmsg: Building X.25 Header.\n");
 
 	if (msg->msg_flags & MSG_OOB) {
 		if (x25->neighbour->extended) {
@@ -1245,8 +1245,8 @@ static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			skb->data[0] |= X25_Q_BIT;
 	}
 
-	SOCK_DEBUG(sk, "x25_sendmsg: Built header.\n");
-	SOCK_DEBUG(sk, "x25_sendmsg: Transmitting buffer\n");
+	net_dbg_ratelimited("x25_sendmsg: Built header.\n");
+	net_dbg_ratelimited("x25_sendmsg: Transmitting buffer\n");
 
 	rc = -ENOTCONN;
 	if (sk->sk_state != TCP_ESTABLISHED)
diff --git a/net/x25/x25_facilities.c b/net/x25/x25_facilities.c
index 8e1a49b0c0dc..6dadb217e101 100644
--- a/net/x25/x25_facilities.c
+++ b/net/x25/x25_facilities.c
@@ -282,7 +282,7 @@ int x25_negotiate_facilities(struct sk_buff *skb, struct sock *sk,
 	 *	They want reverse charging, we won't accept it.
 	 */
 	if ((theirs.reverse & 0x01 ) && (ours->reverse & 0x01)) {
-		SOCK_DEBUG(sk, "X.25: rejecting reverse charging request\n");
+		net_dbg_ratelimited("X.25: rejecting reverse charging request\n");
 		return -1;
 	}
 
@@ -294,11 +294,11 @@ int x25_negotiate_facilities(struct sk_buff *skb, struct sock *sk,
 		int ours_in  = ours->throughput & 0x0f;
 		int ours_out = ours->throughput & 0xf0;
 		if (!ours_in || theirs_in < ours_in) {
-			SOCK_DEBUG(sk, "X.25: inbound throughput negotiated\n");
+			net_dbg_ratelimited("X.25: inbound throughput negotiated\n");
 			new->throughput = (new->throughput & 0xf0) | theirs_in;
 		}
 		if (!ours_out || theirs_out < ours_out) {
-			SOCK_DEBUG(sk,
+			net_dbg_ratelimited(
 				"X.25: outbound throughput negotiated\n");
 			new->throughput = (new->throughput & 0x0f) | theirs_out;
 		}
@@ -306,22 +306,22 @@ int x25_negotiate_facilities(struct sk_buff *skb, struct sock *sk,
 
 	if (theirs.pacsize_in && theirs.pacsize_out) {
 		if (theirs.pacsize_in < ours->pacsize_in) {
-			SOCK_DEBUG(sk, "X.25: packet size inwards negotiated down\n");
+			net_dbg_ratelimited("X.25: packet size inwards negotiated down\n");
 			new->pacsize_in = theirs.pacsize_in;
 		}
 		if (theirs.pacsize_out < ours->pacsize_out) {
-			SOCK_DEBUG(sk, "X.25: packet size outwards negotiated down\n");
+			net_dbg_ratelimited("X.25: packet size outwards negotiated down\n");
 			new->pacsize_out = theirs.pacsize_out;
 		}
 	}
 
 	if (theirs.winsize_in && theirs.winsize_out) {
 		if (theirs.winsize_in < ours->winsize_in) {
-			SOCK_DEBUG(sk, "X.25: window size inwards negotiated down\n");
+			net_dbg_ratelimited("X.25: window size inwards negotiated down\n");
 			new->winsize_in = theirs.winsize_in;
 		}
 		if (theirs.winsize_out < ours->winsize_out) {
-			SOCK_DEBUG(sk, "X.25: window size outwards negotiated down\n");
+			net_dbg_ratelimited("X.25: window size outwards negotiated down\n");
 			new->winsize_out = theirs.winsize_out;
 		}
 	}
diff --git a/net/x25/x25_out.c b/net/x25/x25_out.c
index dbc0940bf35f..f8922b0e23a4 100644
--- a/net/x25/x25_out.c
+++ b/net/x25/x25_out.c
@@ -72,7 +72,7 @@ int x25_output(struct sock *sk, struct sk_buff *skb)
 					kfree_skb(skb);
 					return sent;
 				}
-				SOCK_DEBUG(sk, "x25_output: fragment alloc"
+				net_dbg_ratelimited("x25_output: fragment alloc"
 					       " failed, err=%d, %d bytes "
 					       "sent\n", err, sent);
 				return err;
-- 
2.35.1



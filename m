Return-Path: <netdev+bounces-55545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6480B39C
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1A71F2103D
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 10:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5279D0;
	Sat,  9 Dec 2023 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoR5MUu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C22610DF
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 02:33:46 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9ba170c89so8883331fa.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 02:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702118023; x=1702722823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx2E76Olk2aHqW3shOlgVGtNTZHR1pZ1hfrapDPlP/0=;
        b=WoR5MUu20a8ONyG0Oz6YucT+9cvSS3diAvQ5LP0rMbfbtrWiIOpaIizJZT/lZPVG2N
         wE+IWyw357/dhcg5S9Mol7Vygor+DtE/9g/9gSekSC121UNub0YTr+daYxXb3Fi3n/mg
         SBag/IsawnUKCmlYck5mOZLghq0CmMLpbYlZTaDuc2yekigYcSUjzvC05HMAXCurC5pI
         p1Y52fJbDudyZa5UsZhQBn1Klc0a2YtEs78tYnrewbyoEQrpRSeaRIWTYlUGhFF/XcKX
         zcJ4ehD+nq/bUwe3ICW1uCcKYmCIH1w8nS7tToS7azwps3eu6n9we2lGYoiWy/iBfMYs
         +TrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118023; x=1702722823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx2E76Olk2aHqW3shOlgVGtNTZHR1pZ1hfrapDPlP/0=;
        b=hwebqTuE0lZbv1H3IRPB2QwyzrRt0FklQ640PbhIyNc74TCv3DDZKYhMrpEi3tyfwG
         sLqJtgmqwnwQssyCoASADEPQHcrOit5/Mysl2rDNEkPWb1w/XbWUGPzj3T4UNfjnT45P
         AY3h2cuqh4ohVsJoMMiPmPvnpwwilRqbaJn7THkDdI19OpKYbr+9m0xbtd/07bO9dafk
         wOl2PsPC2vdf+7g0C4v8NoccUlObT6g4CNkkmSiscLAMyBHs7VL/4HmljEjyN+U61Mgc
         QACdxMidcTFeHZS+OtRsLAYJzMIwRcht0iKo7HZJfJn8SdqJDtwiU361/XPyM8n9FLCV
         n+5g==
X-Gm-Message-State: AOJu0YwPV4O9N9H/e1ua1CHEQPyCLlSVgBBZUeQj5hro2Xrb9G2c3pWc
	dp2Bn+IO5qqqK8TS7BTLsrJP+JDKJgxaqg==
X-Google-Smtp-Source: AGHT+IHkrwFGPC+vhDpXYSTIE6qW+OzbWdjEInAR3HD8D2gwdD4ryZlb6onBIJ9YlbP+ktARLqs1Yg==
X-Received: by 2002:a05:6512:504:b0:50b:c9b2:63bf with SMTP id o4-20020a056512050400b0050bc9b263bfmr1009834lfb.5.1702118023047;
        Sat, 09 Dec 2023 02:33:43 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.24])
        by smtp.gmail.com with ESMTPSA id m12-20020a05651202ec00b0050bf30356d0sm476282lfq.246.2023.12.09.02.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:33:42 -0800 (PST)
From: kda <kirjanov@gmail.com>
X-Google-Original-From: kda <kda@localhost.localdomain>
To: netdev@vger.kernel.org
Cc: Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH net-next] net: remove SOCK_DEBUG leftovers
Date: Sat,  9 Dec 2023 13:33:35 +0300
Message-Id: <20231209103335.11532-1-kda@localhost.localdomain>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Kirjanov <dkirjanov@suse.de>

SOCK_DEBUG comes from the old days. Let's
move logging to standard net core ratelimited logging functions

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 net/appletalk/ddp.c      | 16 ++++++++--------
 net/dccp/ipv6.c          |  2 +-
 net/x25/af_x25.c         | 14 +++++++-------
 net/x25/x25_facilities.c | 14 +++++++-------
 net/x25/x25_out.c        |  2 +-
 5 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 9ba04a69ec2a..a273d6d3c0c8 100644
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
index 4550b680665a..67a68e43fc87 100644
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
2.16.4



Return-Path: <netdev+bounces-35601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE777A9FEB
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 22:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB92C1C20B26
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E0518C13;
	Thu, 21 Sep 2023 20:29:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB45182D1
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:28:59 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09597E4C2
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d77fa2e7771so1792965276.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 13:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328102; x=1695932902; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BY2mthgIzx2xWFb3lchofLBiXDwiVoZGYaXIqe8y3p4=;
        b=O35iFM+hgGsSd9sD+qWYmPURvxbJ3tC+3TGayZj6kPEyFUb39sRK2JFjt8ktol8tuo
         GUokhQ9W6+weFXZ5QXf0gtH0CKcEG9u8FmT+vqvTosDNM1UrsIl048pLq+eNS4i8Zt6S
         KUAd+p3RbJenKrs35yPVnruvzwasVyNw4IwR5AjtRDowrUdj4n9LSgtsiFWSfr3D24gD
         5MA+0BlkVNV5jLZdjaRZ/QB26SOulhuEY7JM6jKZJPNo1Bu9i6oLWkrzZUmPHP8OhYw2
         WF7O5437WCJTLs2lcIQ2JCg84COLZ1INk8Xpx7hhAlS6pcEUY4cWDFkzOq/8MgARW7Aw
         gH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328102; x=1695932902;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY2mthgIzx2xWFb3lchofLBiXDwiVoZGYaXIqe8y3p4=;
        b=roRk37Ts8KCMrl50bZJU689H9kVZ+lMoRxkIgBfvUK7AuXETVwjHBg2sxxpjN79uiT
         K1e8fxsEqx8V4tDy3Fhi4h87fQ+C+lUdVXTZu/r2wjYH4YsBmBAiTeqLOCUenHrIXWno
         zauJobA0zqAsbqXkPCOfS7QSRd0p1ygzPWGf4KlQe+O3dKMxOiW5pv+9IGPnsFh8uS3o
         /rX9Nv+Zil2rjzZIjQOOF9ELNhnq9DbpVgC31BBQ//8ueAsuZ8+aAhjSJ8qyOKrlwGyK
         CC/yivpP5s86BbYE3pYetNss0IMobjd0ecMkOT79yI2zBvK17yzKIpNF+avwMMfl1KAa
         xJ1g==
X-Gm-Message-State: AOJu0Yzn1lwLZ0xKfEBh58NJMI0hiqcrfUM+WDhOoyEUsTrN2tbxKmUK
	WgZ2kyKUIwSPBCTyUdNizxoN5/TAWS9K0Q==
X-Google-Smtp-Source: AGHT+IGJmTbyqfKM6tFBvDLzFw9+cS7JaxY9OwjvjiLzrmdF1KOGJ15DrHkl0WU8o/0/hmu5cKPPJUh/Fr6SVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d849:0:b0:d81:58d3:cc71 with SMTP id
 p70-20020a25d849000000b00d8158d3cc71mr94469ybg.13.1695328101948; Thu, 21 Sep
 2023 13:28:21 -0700 (PDT)
Date: Thu, 21 Sep 2023 20:28:11 +0000
In-Reply-To: <20230921202818.2356959-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921202818.2356959-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921202818.2356959-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] net: implement lockless SO_PRIORITY
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

This is a followup of 8bf43be799d4 ("net: annotate data-races
around sk->sk_priority").

sk->sk_priority can be read and written without holding the socket lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/pppoe.c           |  2 +-
 include/net/bluetooth/bluetooth.h |  2 +-
 net/appletalk/aarp.c              |  2 +-
 net/ax25/af_ax25.c                |  2 +-
 net/bluetooth/l2cap_sock.c        |  2 +-
 net/can/j1939/socket.c            |  2 +-
 net/can/raw.c                     |  2 +-
 net/core/sock.c                   | 23 ++++++++++++-----------
 net/dccp/ipv6.c                   |  2 +-
 net/ipv4/inet_diag.c              |  2 +-
 net/ipv4/ip_output.c              |  2 +-
 net/ipv4/tcp_ipv4.c               |  2 +-
 net/ipv4/tcp_minisocks.c          |  2 +-
 net/ipv6/inet6_connection_sock.c  |  2 +-
 net/ipv6/ip6_output.c             |  2 +-
 net/ipv6/tcp_ipv6.c               |  4 ++--
 net/mptcp/sockopt.c               |  2 +-
 net/netrom/af_netrom.c            |  2 +-
 net/rose/af_rose.c                |  2 +-
 net/sched/em_meta.c               |  2 +-
 net/sctp/ipv6.c                   |  2 +-
 net/smc/af_smc.c                  |  2 +-
 net/x25/af_x25.c                  |  2 +-
 net/xdp/xsk.c                     |  2 +-
 24 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ba8b6bd8233cad65dc96c94fb461a6eb31d85fa1..8e7238e97d0a71708ebcddda9b1e1a50ab28c17d 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -877,7 +877,7 @@ static int pppoe_sendmsg(struct socket *sock, struct msghdr *m,
 
 	skb->dev = dev;
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->protocol = cpu_to_be16(ETH_P_PPP_SES);
 
 	ph = skb_put(skb, total_len + sizeof(struct pppoe_hdr));
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index aa90adc3b2a4d7b8dab5759bd5392c164e238d37..7ffa8c192c3f2eecea9dac1073af4853f59fadc7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -541,7 +541,7 @@ static inline struct sk_buff *bt_skb_sendmsg(struct sock *sk,
 		return ERR_PTR(-EFAULT);
 	}
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 
 	return skb;
 }
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index c7236daa24152a10cec6c7c9a34f8a86367ebd21..9fa0b246902bef97e07349475fe71ca0cacaf85e 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -664,7 +664,7 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 
 sendit:
 	if (skb->sk)
-		skb->priority = skb->sk->sk_priority;
+		skb->priority = READ_ONCE(skb->sk->sk_priority);
 	if (dev_queue_xmit(skb))
 		goto drop;
 sent:
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 5db805d5f74d73902071e04802d658e2abef95b6..558e158c98d01075b7614b754a256124c3700a84 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -939,7 +939,7 @@ struct sock *ax25_make_new(struct sock *osk, struct ax25_dev *ax25_dev)
 	sock_init_data(NULL, sk);
 
 	sk->sk_type     = osk->sk_type;
-	sk->sk_priority = osk->sk_priority;
+	sk->sk_priority = READ_ONCE(osk->sk_priority);
 	sk->sk_protocol = osk->sk_protocol;
 	sk->sk_rcvbuf   = osk->sk_rcvbuf;
 	sk->sk_sndbuf   = osk->sk_sndbuf;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3bdfc3f1e73d0f5e24ca30aaed038e45efab437e..e50d3d102078ec4c82ebc844eba913cc19a00c1e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1615,7 +1615,7 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 		return ERR_PTR(-ENOTCONN);
 	}
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 
 	bt_cb(skb)->l2cap.chan = chan;
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index b28c976f52a0a16e13e23aee7c6fe4a7a8c844af..14c43166323393541bc102f47a311c79199a2acd 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -884,7 +884,7 @@ static struct sk_buff *j1939_sk_alloc_skb(struct net_device *ndev,
 	skcb = j1939_skb_to_cb(skb);
 	memset(skcb, 0, sizeof(*skcb));
 	skcb->addr = jsk->addr;
-	skcb->priority = j1939_prio(sk->sk_priority);
+	skcb->priority = j1939_prio(READ_ONCE(sk->sk_priority));
 
 	if (msg->msg_name) {
 		struct sockaddr_can *addr = msg->msg_name;
diff --git a/net/can/raw.c b/net/can/raw.c
index d50c3f3d892f9382a547b7e8dddcab327623ff88..73468d2ebd51effd2a91e660ce3937ddf9c7b39f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -881,7 +881,7 @@ static int raw_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 	}
 
 	skb->dev = dev;
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = READ_ONCE(sk->sk_mark);
 	skb->tstamp = sockc.transmit_time;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index a5995750c5c542d33e8c8c36a701ee9a9e17783d..1fdc0a0d8ff2fb2342618677c3adef2b485c6776 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -806,9 +806,7 @@ EXPORT_SYMBOL(sock_no_linger);
 
 void sock_set_priority(struct sock *sk, u32 priority)
 {
-	lock_sock(sk);
 	WRITE_ONCE(sk->sk_priority, priority);
-	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_priority);
 
@@ -1118,6 +1116,18 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 
 	valbool = val ? 1 : 0;
 
+	/* handle options which do not require locking the socket. */
+	switch (optname) {
+	case SO_PRIORITY:
+		if ((val >= 0 && val <= 6) ||
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
+		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+			sock_set_priority(sk, val);
+			return 0;
+		}
+		return -EPERM;
+	}
+
 	sockopt_lock_sock(sk);
 
 	switch (optname) {
@@ -1213,15 +1223,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sk->sk_no_check_tx = valbool;
 		break;
 
-	case SO_PRIORITY:
-		if ((val >= 0 && val <= 6) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		    sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
-			WRITE_ONCE(sk->sk_priority, val);
-		else
-			ret = -EPERM;
-		break;
-
 	case SO_LINGER:
 		if (optlen < sizeof(ling)) {
 			ret = -EINVAL;	/* 1003.1g */
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 80b956b392529dbbe0bf8a04f515118e2ad858ff..8d344b219f84ae391f640d9a2d09700883123dce 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -239,7 +239,7 @@ static int dccp_v6_send_response(const struct sock *sk, struct request_sock *req
 		if (!opt)
 			opt = rcu_dereference(np->opt);
 		err = ip6_xmit(sk, skb, &fl6, READ_ONCE(sk->sk_mark), opt,
-			       np->tclass, sk->sk_priority);
+			       np->tclass, READ_ONCE(sk->sk_priority));
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index e13a84433413ed88088435ff8e11efeb30fc3cca..9f0bd518901a7fd037037d05465d5d9be66f42a7 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -165,7 +165,7 @@ int inet_diag_msg_attrs_fill(struct sock *sk, struct sk_buff *skb,
 		 * For cgroup2 classid is always zero.
 		 */
 		if (!classid)
-			classid = sk->sk_priority;
+			classid = READ_ONCE(sk->sk_priority);
 
 		if (nla_put_u32(skb, INET_DIAG_CLASS_ID, classid))
 			goto errout;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 4ab877cf6d35f229761986d5c6a17eb2a3ad4043..6b14097e80ad35e42b9a7d5da977f5f0a7ea2c78 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1449,7 +1449,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 		ip_options_build(skb, opt, cork->addr, rt);
 	}
 
-	skb->priority = (cork->tos != -1) ? cork->priority: sk->sk_priority;
+	skb->priority = (cork->tos != -1) ? cork->priority: READ_ONCE(sk->sk_priority);
 	skb->mark = cork->mark;
 	skb->tstamp = cork->transmit_time;
 	/*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f13eb7e23d03f3681055257e6ebea0612ae3f9b3..95e972be0c05c17138a293ed891a896ba6ea411e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -828,7 +828,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
 		ctl_sk->sk_mark = (sk->sk_state == TCP_TIME_WAIT) ?
 				   inet_twsk(sk)->tw_mark : sk->sk_mark;
 		ctl_sk->sk_priority = (sk->sk_state == TCP_TIME_WAIT) ?
-				   inet_twsk(sk)->tw_priority : sk->sk_priority;
+				   inet_twsk(sk)->tw_priority : READ_ONCE(sk->sk_priority);
 		transmit_time = tcp_transmit_time(sk);
 		xfrm_sk_clone_policy(ctl_sk, sk);
 		txhash = (sk->sk_state == TCP_TIME_WAIT) ?
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index eee8ab1bfa0e4fecde0cd1ff5d480d11c6741049..3f87611077ef21edb61f3d6c751c88c515bb4b5b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -292,7 +292,7 @@ void tcp_time_wait(struct sock *sk, int state, int timeo)
 
 		tw->tw_transparent	= inet_test_bit(TRANSPARENT, sk);
 		tw->tw_mark		= sk->sk_mark;
-		tw->tw_priority		= sk->sk_priority;
+		tw->tw_priority		= READ_ONCE(sk->sk_priority);
 		tw->tw_rcv_wscale	= tp->rx_opt.rcv_wscale;
 		tcptw->tw_rcv_nxt	= tp->rcv_nxt;
 		tcptw->tw_snd_nxt	= tp->snd_nxt;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 0c50dcd35fe8c7179e8ea0d86c49f891a26fe59e..80043e46117c51b720ace671d8b2edafd022841c 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -133,7 +133,7 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 	fl6.daddr = sk->sk_v6_daddr;
 
 	res = ip6_xmit(sk, skb, &fl6, sk->sk_mark, rcu_dereference(np->opt),
-		       np->tclass,  sk->sk_priority);
+		       np->tclass, READ_ONCE(sk->sk_priority));
 	rcu_read_unlock();
 	return res;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 951ba8089b5b44c589f1b497e645ffc15a86c7c8..cdaa9275e99053488c684bb19c4ed651101c2b1c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1984,7 +1984,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	hdr->saddr = fl6->saddr;
 	hdr->daddr = *final_dst;
 
-	skb->priority = sk->sk_priority;
+	skb->priority = READ_ONCE(sk->sk_priority);
 	skb->mark = cork->base.mark;
 	skb->tstamp = cork->base.transmit_time;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 94afb8d0f2d0e4974c3dbe4e3301f0152b5cb9e1..8a6e2e97f673d774f7917d7040bc9dde7c33cbd3 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -565,7 +565,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 		if (!opt)
 			opt = rcu_dereference(np->opt);
 		err = ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk->sk_mark),
-			       opt, tclass, sk->sk_priority);
+			       opt, tclass, READ_ONCE(sk->sk_priority));
 		rcu_read_unlock();
 		err = net_xmit_eval(err);
 	}
@@ -1058,7 +1058,7 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
 			trace_tcp_send_reset(sk, skb);
 			if (inet6_test_bit(REPFLOW, sk))
 				label = ip6_flowlabel(ipv6h);
-			priority = sk->sk_priority;
+			priority = READ_ONCE(sk->sk_priority);
 			txhash = sk->sk_txhash;
 		}
 		if (sk->sk_state == TCP_TIME_WAIT) {
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 8260202c00669fd7d2eed2f94a3c2cf225a0d89c..f3485a6b35e706a3da52bb98ac17f1eeaa455b2e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -89,7 +89,7 @@ static void mptcp_sol_socket_sync_intval(struct mptcp_sock *msk, int optname, in
 			sock_valbool_flag(ssk, SOCK_KEEPOPEN, !!val);
 			break;
 		case SO_PRIORITY:
-			ssk->sk_priority = val;
+			WRITE_ONCE(ssk->sk_priority, val);
 			break;
 		case SO_SNDBUF:
 		case SO_SNDBUFFORCE:
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 96e91ab71573cf391da1627af675f3e6004e94b5..0eed00184adf454d2e06bb44330c079a402a959e 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -487,7 +487,7 @@ static struct sock *nr_make_new(struct sock *osk)
 	sock_init_data(NULL, sk);
 
 	sk->sk_type     = osk->sk_type;
-	sk->sk_priority = osk->sk_priority;
+	sk->sk_priority = READ_ONCE(osk->sk_priority);
 	sk->sk_protocol = osk->sk_protocol;
 	sk->sk_rcvbuf   = osk->sk_rcvbuf;
 	sk->sk_sndbuf   = osk->sk_sndbuf;
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 49dafe9ac72f010c56a5546926ee1a360fa767b7..0cc5a4e19900e10b31172433f36f5835101908ed 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -583,7 +583,7 @@ static struct sock *rose_make_new(struct sock *osk)
 #endif
 
 	sk->sk_type     = osk->sk_type;
-	sk->sk_priority = osk->sk_priority;
+	sk->sk_priority = READ_ONCE(osk->sk_priority);
 	sk->sk_protocol = osk->sk_protocol;
 	sk->sk_rcvbuf   = osk->sk_rcvbuf;
 	sk->sk_sndbuf   = osk->sk_sndbuf;
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index da34fd4c92695f453f1d6547c6e4e8d3afe7a116..09d8afd04a2a78ac55b0ddd1b424ddcb28b9ba83 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -546,7 +546,7 @@ META_COLLECTOR(int_sk_prio)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_priority;
+	dst->value = READ_ONCE(sk->sk_priority);
 }
 
 META_COLLECTOR(int_sk_rcvlowat)
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 5c0ed5909d85a1fc137e8652e32df75d8bef28ac..24368f755ab19a07e6e6ed4be99043fd41b99421 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -247,7 +247,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 		rcu_read_lock();
 		res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
 			       rcu_dereference(np->opt),
-			       tclass, sk->sk_priority);
+			       tclass, READ_ONCE(sk->sk_priority));
 		rcu_read_unlock();
 		return res;
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e43b9bdabcd1395caccd5320e549f..29768160141467515903d994864b16cf0fb19a71 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -493,7 +493,7 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
 	nsk->sk_sndtimeo = osk->sk_sndtimeo;
 	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
 	nsk->sk_mark = READ_ONCE(osk->sk_mark);
-	nsk->sk_priority = osk->sk_priority;
+	nsk->sk_priority = READ_ONCE(osk->sk_priority);
 	nsk->sk_rcvlowat = osk->sk_rcvlowat;
 	nsk->sk_bound_dev_if = osk->sk_bound_dev_if;
 	nsk->sk_err = osk->sk_err;
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0fb5143bec7ac45374f6b2e1c6133072c8e8145c..aad8ffeaee0415ca907c116016d326e43a3018f2 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -598,7 +598,7 @@ static struct sock *x25_make_new(struct sock *osk)
 	x25 = x25_sk(sk);
 
 	sk->sk_type        = osk->sk_type;
-	sk->sk_priority    = osk->sk_priority;
+	sk->sk_priority    = READ_ONCE(osk->sk_priority);
 	sk->sk_protocol    = osk->sk_protocol;
 	sk->sk_rcvbuf      = osk->sk_rcvbuf;
 	sk->sk_sndbuf      = osk->sk_sndbuf;
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7482d0aca5046ed637fcbeca7f5e403ed60eec08..f5e96e0d6e01d4c0121201bc74f40e0785762b2c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -684,7 +684,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	}
 
 	skb->dev = dev;
-	skb->priority = xs->sk.sk_priority;
+	skb->priority = READ_ONCE(xs->sk.sk_priority);
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
 	xsk_set_destructor_arg(skb);
-- 
2.42.0.515.g380fc7ccd1-goog



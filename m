Return-Path: <netdev+bounces-33306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8379D5BB
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 18:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BEA28124E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B719BDB;
	Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7819BD4
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 16:02:29 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5379D1706
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5924b2aac52so62413687b3.2
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694534548; x=1695139348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNWAOaca+giZHJtnQQIkZMfFaWdbRYP0rHesIhWBqi0=;
        b=PG9xXb/vFbev8Ot74F1jauP2lynXMcrSm67iYZjY7E5I56Rdxjg+PCEEGbahjdED4T
         L1osj3IO217WpgJ3oWTzFjKshdBIcuAzC3rYczxSSZh+FHxOICVXxKisXT5HUBVSyJ2U
         UJE6Y9NFOerfIgxYnriHeb3SEpenrKRuDO1xOiKSvTQvOeUSQX8W8eJ1PtvEG6gn0VHp
         fuVltIN6j42em2ShpwWnlcNYEzE3U/vDBN6hCKp/fyKoNIPthfSA3JnUEo7z6OQXRekS
         2MiF4LSjw2BAghItvLLS701p05Y0Q8Rl5xfeF7KO4AjYDnjBQiKCU1hhfg6mMDqfd4mb
         FBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694534548; x=1695139348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNWAOaca+giZHJtnQQIkZMfFaWdbRYP0rHesIhWBqi0=;
        b=XTIQRcxTXjOAHijPkUBCXf6x9HcmiSxQbgyYVDFnKAhpd6fJT+Ub8ed/0F6wYAYaNI
         rMZ2vo4FdfulhlCkH5Inc1GPjGPl+MB49PKLlyV5re+dGlos2H3e9Hdh1Q1jiAnDG8c6
         qwEcvphu8j6GJEyqIMk3tiXCB20E8UHDglQG7InOusqpHYgU5NaCKrbAxCp/vpy9SsfT
         475bQcpqOgMRqUYIZtZmyPXYlwzh5yENYXpF28mWoz2pQ72ECcTvyRJXGzw5lTh7qtkP
         tQMCSXMURBBJY861gRTxzNFMkr9pA7c6NW8yvjWvjEdEYnXILw5apxmSufpApT1tY6Ar
         GN0g==
X-Gm-Message-State: AOJu0YzG1BVSNMsctBVUORoVQxKdPbUqJh10MSuZFgJmwqjvucbCunLk
	VzF/Z0UZB9E4Ar2Vm33dXihz6VZV0MecTg==
X-Google-Smtp-Source: AGHT+IFf3jBkiGyMoeW0HtZKLZbyY09oWi2sWWhO6N5e8+OUoTO5MkybooB9cUoMHJWjWQj98aeyXnIQBkipDw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ae66:0:b0:58c:6ddd:d27c with SMTP id
 g38-20020a81ae66000000b0058c6dddd27cmr314004ywk.6.1694534548535; Tue, 12 Sep
 2023 09:02:28 -0700 (PDT)
Date: Tue, 12 Sep 2023 16:02:07 +0000
In-Reply-To: <20230912160212.3467976-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912160212.3467976-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912160212.3467976-10-edumazet@google.com>
Subject: [PATCH net-next 09/14] ipv6: lockless IPV6_DONTFRAG implementation
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move np->dontfrag flag to inet->inet_flags to fix data-races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h     | 1 -
 include/net/inet_sock.h  | 1 +
 include/net/ipv6.h       | 6 +++---
 include/net/xfrm.h       | 2 +-
 net/ipv6/icmp.c          | 4 ++--
 net/ipv6/ip6_output.c    | 2 +-
 net/ipv6/ipv6_sockglue.c | 9 ++++-----
 net/ipv6/ping.c          | 2 +-
 net/ipv6/raw.c           | 2 +-
 net/ipv6/udp.c           | 2 +-
 net/l2tp/l2tp_ip6.c      | 2 +-
 11 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index e3be5dc21b7d27080b398f1425bf11145896a4f3..57d563f1d4b1707264f0d79406c4c139cc0fa525 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -252,7 +252,6 @@ struct ipv6_pinfo {
 						 * 010: prefer public address
 						 * 100: prefer care-of address
 						 */
-				dontfrag:1,
 				rtalert_isolate:1;
 	__u8			min_hopcount;
 	__u8			tclass;
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index f1af64a4067310258a3bc45b84ad3fd093bddbab..ac75324e9e1eafe68cee7b0581e472cbb4f49aa3 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -273,6 +273,7 @@ enum {
 	INET_FLAGS_MC6_ALL	= 22,
 	INET_FLAGS_AUTOFLOWLABEL_SET = 23,
 	INET_FLAGS_AUTOFLOWLABEL = 24,
+	INET_FLAGS_DONTFRAG	= 25,
 };
 
 /* cmsg flags for inet */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index fe1978a288630a20ba03dc3a36e22938495082e4..d2cf7e176f2b97dac957e65b75d5e69a39c546b5 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -373,12 +373,12 @@ static inline void ipcm6_init(struct ipcm6_cookie *ipc6)
 }
 
 static inline void ipcm6_init_sk(struct ipcm6_cookie *ipc6,
-				 const struct ipv6_pinfo *np)
+				 const struct sock *sk)
 {
 	*ipc6 = (struct ipcm6_cookie) {
 		.hlimit = -1,
-		.tclass = np->tclass,
-		.dontfrag = np->dontfrag,
+		.tclass = inet6_sk(sk)->tclass,
+		.dontfrag = inet6_test_bit(DONTFRAG, sk),
 	};
 }
 
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 363c7d5105542ec7f43f91e5071b877314584bc5..98d7aa78addaab129f7ce060b10b7652fd0acba1 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2166,7 +2166,7 @@ static inline bool xfrm6_local_dontfrag(const struct sock *sk)
 
 	proto = sk->sk_protocol;
 	if (proto == IPPROTO_UDP || proto == IPPROTO_RAW)
-		return inet6_sk(sk)->dontfrag;
+		return inet6_test_bit(DONTFRAG, sk);
 
 	return false;
 }
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 93a594a901d12befb754e7035f56726273eead92..8fb4a791881a48d5efcebc990c8829d8f77fe94f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -588,7 +588,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	else if (!fl6.flowi6_oif)
 		fl6.flowi6_oif = np->ucast_oif;
 
-	ipcm6_init_sk(&ipc6, np);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.sockc.mark = mark;
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
@@ -791,7 +791,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	msg.offset = 0;
 	msg.type = type;
 
-	ipcm6_init_sk(&ipc6, np);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 	ipc6.tclass = ipv6_get_dsfield(ipv6_hdr(skb));
 	ipc6.sockc.mark = mark;
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 47aa42f93ccda8b49ed6ecd7a7a07703ae147928..8851fe5d45a0781c8b78c995c2c4c6c81e10cd52 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -2092,7 +2092,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 		return ERR_PTR(err);
 	}
 	if (ipc6->dontfrag < 0)
-		ipc6->dontfrag = inet6_sk(sk)->dontfrag;
+		ipc6->dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index d5d428a695f728d96a7d075d86f806cc3f926e0a..33dd4dd872e6bca2ee18a634283640007adcc692 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -478,6 +478,9 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		inet6_assign_bit(AUTOFLOWLABEL, sk, valbool);
 		inet6_set_bit(AUTOFLOWLABEL_SET, sk);
 		return 0;
+	case IPV6_DONTFRAG:
+		inet6_assign_bit(DONTFRAG, sk, valbool);
+		return 0;
 	}
 	if (needs_rtnl)
 		rtnl_lock();
@@ -970,10 +973,6 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			goto e_inval;
 		retv = __ip6_sock_set_addr_preferences(sk, val);
 		break;
-	case IPV6_DONTFRAG:
-		np->dontfrag = valbool;
-		retv = 0;
-		break;
 	case IPV6_RECVFRAGSIZE:
 		np->rxopt.bits.recvfragsize = valbool;
 		retv = 0;
@@ -1442,7 +1441,7 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case IPV6_DONTFRAG:
-		val = np->dontfrag;
+		val = inet6_test_bit(DONTFRAG, sk);
 		break;
 
 	case IPV6_AUTOFLOWLABEL:
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 5831aaa53d75eae7b764d54ab52da65db4030d73..4444b61eb23bbf483068d2b119a7559e49ba3880 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -118,7 +118,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	     l3mdev_master_ifindex_by_index(sock_net(sk), oif) != sk->sk_bound_dev_if))
 		return -EINVAL;
 
-	ipcm6_init_sk(&ipc6, np);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 42fcec3ecf5e171a5ebe724b8c971d90885abe41..cc9673c1809fb238f6d9ab6915116cf0dd6eb593 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -898,7 +898,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
 	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = np->dontfrag;
+		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	if (msg->msg_flags&MSG_CONFIRM)
 		goto do_confirm;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 86b5d509a4688cacb2f40667c9ddc10f81ade2fe..d904c5450a07bf1df10d94ee6bb9b2a8fb9381b5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1593,7 +1593,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 do_append_data:
 	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = np->dontfrag;
+		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 	up->len += ulen;
 	err = ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
 			      &ipc6, fl6, (struct rt6_info *)dst,
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index ed8ebb6f59097ac18bb284d1c48f9e801e9a92c2..40af2431e73aad74ab64e97db8a5ee79dda0879d 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -621,7 +621,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
 	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = np->dontfrag;
+		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 
 	if (msg->msg_flags & MSG_CONFIRM)
 		goto do_confirm;
-- 
2.42.0.283.g2d96d420d3-goog



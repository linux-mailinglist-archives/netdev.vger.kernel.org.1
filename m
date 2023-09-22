Return-Path: <netdev+bounces-35652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91B7AA761
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4C371282697
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49978EB8;
	Fri, 22 Sep 2023 03:42:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F113A34
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:35 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F24E8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:33 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c081a44afso25202597b3.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354153; x=1695958953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTYzQNqnSj34IXNKnvLf3Iuo17IYrK4SKVwjGxKpla8=;
        b=YsqC6TbKCKLYIQSDoVm48VjSzSc6TffHbjJkLSvN0bAqKtNxsLCItI3EtxgQV5/MZP
         SL6vIEdEsvn+9WGbghtPtIQa0rJe9hJcdQK9lFd5fmZ8yG+uCFYNKzYhEjH1bDcso+Cg
         aMlRwne1NWWXnr3BLu+oRz0GtljXlnsACSJiI080aLyUKE61AoYk2Vidp+ozTezxrMJg
         A7SEGFZhKWbGBlmDWDpq7osHf8IeOWJR4wRn4KkyOTvdfDuH8CW8pwQ5j3mxnoE7tNcZ
         8DEqWHMJfFRJx97Zd0BoSI+8ShdCX7/RAlUy8pBWM9uil1pmQLP7Go0gkF2XFytv5AkU
         pV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354153; x=1695958953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iTYzQNqnSj34IXNKnvLf3Iuo17IYrK4SKVwjGxKpla8=;
        b=WGQQa2E+crp0QgSzqFdc4GVtKPAwIWlYZ1mw5MHaejOkK8orrcJ9hIr4Al8R9hMyrT
         yWHTY6W2mJGlX/BlrQ73iBpEobNgo/1HSnIJUMHkSdW02gv+fKLPOHJz1prAEI17sTTe
         vVxkAcg8hfZPzXgnxRN9nhnly5VzvjZIqcwrmd4wklgp6cmAcPWCBE360AMhlNT4sG5O
         bZlkecgq3GkXPY/CbnVFgwiYwi3eqrbzkIRxFekCs8NB90LEBsmrupXCg8dxkiKQiX1L
         EHgneBleSQr1J4enPn30k6GsvspznwYUNS3oLmZB1Um/D1z15hnx3RJwBeEy6vJ/EDl+
         er5Q==
X-Gm-Message-State: AOJu0Yx6/aRQHx1Kmdbnwz8WpQUtAi4w6Q4M4h5NI6bE0wKF45xpNTNX
	mKq7FOQ77JasUcqDa1Be8JRlBK4aXVA0og==
X-Google-Smtp-Source: AGHT+IH8rabc10KFH/390qzGOJkYTr4hqRUpOjAAP5IC7oQEe21HYMrEyuVfLlb9KN4Wnf/kbgtplTb9O6CbqQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ac42:0:b0:579:f832:74b with SMTP id
 z2-20020a81ac42000000b00579f832074bmr122557ywj.10.1695354153003; Thu, 21 Sep
 2023 20:42:33 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:19 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/8] inet: implement lockless getsockopt(IP_UNICAST_IF)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add missing READ_ONCE() annotations when reading inet->uc_index

Implementing getsockopt(IP_UNICAST_IF) locklessly seems possible,
the setsockopt() part might not be possible at the moment.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/datagram.c    |  2 +-
 net/ipv4/ip_sockglue.c | 10 +++++-----
 net/ipv4/ping.c        |  2 +-
 net/ipv4/raw.c         | 13 +++++++------
 net/ipv4/udp.c         | 12 +++++++-----
 5 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cb5dbee9e018fbba1bc1e5705e8bec6c4203af56..1480e9ebdfef445960e1f70f34f33a0e0c52b65b 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -43,7 +43,7 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 		if (!saddr)
 			saddr = inet->mc_addr;
 	} else if (!oif) {
-		oif = inet->uc_index;
+		oif = READ_ONCE(inet->uc_index);
 	}
 	fl4 = &inet->cork.fl.u.ip4;
 	rt = ip_route_connect(fl4, usin->sin_addr.s_addr, saddr, oif,
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 04579e390ddd4dadb8a107ef0b5da15e7a60f1ff..58995526c6e965d613b8cdea61b84916d608a6fb 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1113,7 +1113,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 		ifindex = (__force int)ntohl((__force __be32)val);
 		if (ifindex == 0) {
-			inet->uc_index = 0;
+			WRITE_ONCE(inet->uc_index, 0);
 			err = 0;
 			break;
 		}
@@ -1130,7 +1130,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		if (sk->sk_bound_dev_if && midx != sk->sk_bound_dev_if)
 			break;
 
-		inet->uc_index = ifindex;
+		WRITE_ONCE(inet->uc_index, ifindex);
 		err = 0;
 		break;
 	}
@@ -1633,6 +1633,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -ENOTCONN;
 		goto copyval;
 	}
+	case IP_UNICAST_IF:
+		val = (__force int)htonl((__u32) READ_ONCE(inet->uc_index));
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1640,9 +1643,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	sockopt_lock_sock(sk);
 
 	switch (optname) {
-	case IP_UNICAST_IF:
-		val = (__force int)htonl((__u32) inet->uc_index);
-		break;
 	case IP_MULTICAST_IF:
 	{
 		struct in_addr addr;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 50d12b0c8d46fdcd9b448c3ebc90395ebf426075..66ad1f95af49f222afe0ee75b9163dd0af0a2c49 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -777,7 +777,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (!saddr)
 			saddr = inet->mc_addr;
 	} else if (!ipc.oif)
-		ipc.oif = inet->uc_index;
+		ipc.oif = READ_ONCE(inet->uc_index);
 
 	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index ade1aecd7c71184d753a28a67bc9b30087247db4..e2357d23202e5a39832bb1550c365de9a836c363 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -482,7 +482,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int free = 0;
 	__be32 daddr;
 	__be32 saddr;
-	int err;
+	int uc_index, err;
 	struct ip_options_data opt_copy;
 	struct raw_frag_vec rfv;
 	int hdrincl;
@@ -576,24 +576,25 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
+	uc_index = READ_ONCE(inet->uc_index);
 	if (ipv4_is_multicast(daddr)) {
 		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
 			ipc.oif = inet->mc_index;
 		if (!saddr)
 			saddr = inet->mc_addr;
 	} else if (!ipc.oif) {
-		ipc.oif = inet->uc_index;
-	} else if (ipv4_is_lbcast(daddr) && inet->uc_index) {
+		ipc.oif = uc_index;
+	} else if (ipv4_is_lbcast(daddr) && uc_index) {
 		/* oif is set, packet is to local broadcast
 		 * and uc_index is set. oif is most likely set
 		 * by sk_bound_dev_if. If uc_index != oif check if the
 		 * oif is an L3 master and uc_index is an L3 slave.
 		 * If so, we want to allow the send using the uc_index.
 		 */
-		if (ipc.oif != inet->uc_index &&
+		if (ipc.oif != uc_index &&
 		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
-							      inet->uc_index)) {
-			ipc.oif = inet->uc_index;
+							      uc_index)) {
+			ipc.oif = uc_index;
 		}
 	}
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 731a723dc80816f0b5b0803d7397f7e9e8cd8b09..1e0c3aba1e5a88c7ba50a28511412a1710f1bab5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1055,6 +1055,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 	struct sk_buff *skb;
 	struct ip_options_data opt_copy;
+	int uc_index;
 
 	if (len > 0xFFFF)
 		return -EMSGSIZE;
@@ -1173,6 +1174,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (scope == RT_SCOPE_LINK)
 		connected = 0;
 
+	uc_index = READ_ONCE(inet->uc_index);
 	if (ipv4_is_multicast(daddr)) {
 		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
 			ipc.oif = inet->mc_index;
@@ -1180,18 +1182,18 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			saddr = inet->mc_addr;
 		connected = 0;
 	} else if (!ipc.oif) {
-		ipc.oif = inet->uc_index;
-	} else if (ipv4_is_lbcast(daddr) && inet->uc_index) {
+		ipc.oif = uc_index;
+	} else if (ipv4_is_lbcast(daddr) && uc_index) {
 		/* oif is set, packet is to local broadcast and
 		 * uc_index is set. oif is most likely set
 		 * by sk_bound_dev_if. If uc_index != oif check if the
 		 * oif is an L3 master and uc_index is an L3 slave.
 		 * If so, we want to allow the send using the uc_index.
 		 */
-		if (ipc.oif != inet->uc_index &&
+		if (ipc.oif != uc_index &&
 		    ipc.oif == l3mdev_master_ifindex_by_index(sock_net(sk),
-							      inet->uc_index)) {
-			ipc.oif = inet->uc_index;
+							      uc_index)) {
+			ipc.oif = uc_index;
 		}
 	}
 
-- 
2.42.0.515.g380fc7ccd1-goog



Return-Path: <netdev+bounces-35497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 488F57A9C8B
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C363FB2197C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9627B29432;
	Thu, 21 Sep 2023 17:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AA48E83
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:49:53 +0000 (UTC)
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E19720DA
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:33:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 6a1803df08f44-6562fff4a2fso11070486d6.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317610; x=1695922410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zEMZVyVjKUva06I6qbZdF0YySvj2lKgT7U0Rk8yQNq0=;
        b=KM4dREt7F8xDiUGqlPh3VgB/4HU+YuwYgmr5LomyHlsYMxuuv2H0oMtUW1mOa/NMi6
         qYy6ziRx48EXNGocTNko+0ChE10UQfmurLmALmEbaAFCNdeM9pNEwjmHQj9epvXztLTF
         x5qq//4ekKRWlJaVBLwN78ywr6tSZlFF6tnJ/4rgxY+B89aDH8+tfATtFiiD88rhl+3S
         0Yti6h5FsftFoNrFF3XXhqmnAFdSvuCbvu3XfWqthAbnQy+n2G1/Nv3qc5+pHRXJfozp
         FIef2EgNm/jzRDceCDyVKN77r2xwn89/HJYagWt7a3iz83jKkj6AiyTKtX87kt/MBYiJ
         QBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317610; x=1695922410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEMZVyVjKUva06I6qbZdF0YySvj2lKgT7U0Rk8yQNq0=;
        b=COa6SvgNPCP3WWhpZHpVonZItdy5CT8ToWza9qZdwoknRnIcRj67egxvGnvydIlZyu
         +FkvJJzUk831jWeiffesq1seTHtBJ/PaqFT+BgoNjHfUl3XX+l1HT0MOeO09ROn1lT/Q
         YqjoIms+iJcXCTPUUJ+ss8QKbWCLEHavK6UOUVwY6IsYfm0W3AojG6UWVpwIf5E05JMI
         GuuItDXy6LfZhG74/PzVcj5wsdrKvqlZxHNXQap6UFOG2eARrj2cBOEeX5SOhC3LP7Yq
         84XQMBddj7gA8Wu6ex/cN1IPaesUz/ecVybOyKKorDIw2492moCgq9wlWZEuecyqP9Ct
         wXiQ==
X-Gm-Message-State: AOJu0Yw1yLO3cUW4XrUJ1kalkyfRY7gtYwdx38jxQm7dp9iAMOdn0kP2
	eMauqPo2RS9rFAuL4Ivx33bRq/QE893dAw==
X-Google-Smtp-Source: AGHT+IFs0GY6Lu1jpb8565J7cLewO5oIJqulC0j/Wz0yepkkkT7PJO8xGGCTn4QAGoWgQxX3334uKxhNfNNp9A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4103:0:b0:58c:a9b4:a64c with SMTP id
 o3-20020a814103000000b0058ca9b4a64cmr85161ywa.1.1695303036598; Thu, 21 Sep
 2023 06:30:36 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:19 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-7-edumazet@google.com>
Subject: [PATCH net-next 6/8] inet: implement lockless getsockopt(IP_UNICAST_IF)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add missing READ_ONCE() annotations when reading inet->uc_index

Implementing getsockopt(IP_UNICAST_IF) locklessly seems possible,
the setsockopt() part might not be possible at the moment.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
2.42.0.459.ge4e396fd5e-goog



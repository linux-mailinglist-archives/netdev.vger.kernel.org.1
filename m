Return-Path: <netdev+bounces-35471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419B7A99DF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 20:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DA1C20490
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 18:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D420330;
	Thu, 21 Sep 2023 17:27:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A668E20305
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 17:27:33 +0000 (UTC)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFC94F3A6
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:25:19 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-414bbfbdf37so11729011cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695317118; x=1695921918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0crHyXdHYPym1CLXkg6zEVLmg9WXyH0yywED079rw2k=;
        b=w72ip+0fp3qEzR8MDmTE2mwpiZ6f17iKXgFn32ylyNvrqLku6zC0vsRSgiU8OFUxuQ
         YpPALfRIJ5FTFVvsSAZpLyRvWBISUSQDni9P8MQB/5oXcFOYcLKO6JgKdOKj9UH4QAxA
         jywT7Ao2YojZTRLzETrNxuJqDpD1cd41Wylsi2kqt8Tw0onOInH0Xap5eagN2Rz6BCZk
         LRBohHTaLBNfb0fkMjrKjtSyvaPD/btdpRIB5UCwIbudG1aPbcGy2qyYiaGh213tIxLK
         xlCt7eTI0ZmTRkMEBosnl4RaTR05lNfbTx7Cmq/ZR2Gmgr8X7lr1yAHEyebgTdvo/bMm
         p/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317118; x=1695921918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0crHyXdHYPym1CLXkg6zEVLmg9WXyH0yywED079rw2k=;
        b=Q7cD0ySmLo0N+KDMD3jMNsY2g+Ol6fe11aR1AWSU3yRMTjUnxu915F73S4vwCar6OC
         i2H0Yf4d79UYof8k8KLV/YUa2HCdgJBgtv/xNToog+zpFskWqtw59KtnJTYREzUK42a1
         sWGjpIXrqXOiw9x1Zl1zrK+fz5Nc17FtSzT4AFbv4MI+aCYf8MCpjkqYdKqA15hMqZFC
         8+IW6CF2nxtAcM47SOB9O2gTRF2R3kfyLexYMjCHdoic2wQbowLsIQo6ZwSAPAT0BPsM
         ZmCNTwpjft3eYPjRX42LLyoIWUpLkrOlfBbm012eyF1/JyF0GdVnc45FXVTdKbGkQL6z
         5/dQ==
X-Gm-Message-State: AOJu0YxnQO+scU59k4Esz0V+a547nYf1pLpmItBy198N/TyQheZCKtuq
	x+G2cEyFtrqGE/5yZ45dKvidk7uCbl1wVA==
X-Google-Smtp-Source: AGHT+IFGYtKU4EtdRmaIMUdnjL8Q3eRVg9I0GSEdDz3mCNtw+o5T279loRPrUHlGbCfdPF09CgyOYkK1NygXjg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ac0d:0:b0:59b:ec33:ec6d with SMTP id
 k13-20020a81ac0d000000b0059bec33ec6dmr82828ywh.5.1695303040759; Thu, 21 Sep
 2023 06:30:40 -0700 (PDT)
Date: Thu, 21 Sep 2023 13:30:21 +0000
In-Reply-To: <20230921133021.1995349-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921133021.1995349-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921133021.1995349-9-edumazet@google.com>
Subject: [PATCH net-next 8/8] inet: implement lockless getsockopt(IP_MULTICAST_IF)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add missing annotations to inet->mc_index and inet->mc_addr
to fix data-races.

getsockopt(IP_MULTICAST_IF) can be lockless.

setsockopt() side is left for later.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/datagram.c    |  4 ++--
 net/ipv4/ip_sockglue.c | 25 ++++++++++++-------------
 net/ipv4/ping.c        |  4 ++--
 net/ipv4/raw.c         |  4 ++--
 net/ipv4/udp.c         |  4 ++--
 5 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 1480e9ebdfef445960e1f70f34f33a0e0c52b65b..2cc50cbfc2a31ec91fbdc4a541cb89df689cd9ae 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -39,9 +39,9 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 	saddr = inet->inet_saddr;
 	if (ipv4_is_multicast(usin->sin_addr.s_addr)) {
 		if (!oif || netif_index_is_l3_master(sock_net(sk), oif))
-			oif = inet->mc_index;
+			oif = READ_ONCE(inet->mc_index);
 		if (!saddr)
-			saddr = inet->mc_addr;
+			saddr = READ_ONCE(inet->mc_addr);
 	} else if (!oif) {
 		oif = READ_ONCE(inet->uc_index);
 	}
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index 1ee01ff64171c94b6b244589518a53ce807a212d..0b74ac49d6a6f82f5e8ffe5279dba3baf30f874e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1168,8 +1168,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 
 		if (!mreq.imr_ifindex) {
 			if (mreq.imr_address.s_addr == htonl(INADDR_ANY)) {
-				inet->mc_index = 0;
-				inet->mc_addr  = 0;
+				WRITE_ONCE(inet->mc_index, 0);
+				WRITE_ONCE(inet->mc_addr, 0);
 				err = 0;
 				break;
 			}
@@ -1194,8 +1194,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		    midx != sk->sk_bound_dev_if)
 			break;
 
-		inet->mc_index = mreq.imr_ifindex;
-		inet->mc_addr  = mreq.imr_address.s_addr;
+		WRITE_ONCE(inet->mc_index, mreq.imr_ifindex);
+		WRITE_ONCE(inet->mc_addr, mreq.imr_address.s_addr);
 		err = 0;
 		break;
 	}
@@ -1673,19 +1673,11 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 	case IP_UNICAST_IF:
 		val = (__force int)htonl((__u32) READ_ONCE(inet->uc_index));
 		goto copyval;
-	}
-
-	if (needs_rtnl)
-		rtnl_lock();
-	sockopt_lock_sock(sk);
-
-	switch (optname) {
 	case IP_MULTICAST_IF:
 	{
 		struct in_addr addr;
 		len = min_t(unsigned int, len, sizeof(struct in_addr));
-		addr.s_addr = inet->mc_addr;
-		sockopt_release_sock(sk);
+		addr.s_addr = READ_ONCE(inet->mc_addr);
 
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
@@ -1693,6 +1685,13 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			return -EFAULT;
 		return 0;
 	}
+	}
+
+	if (needs_rtnl)
+		rtnl_lock();
+	sockopt_lock_sock(sk);
+
+	switch (optname) {
 	case IP_MSFILTER:
 	{
 		struct ip_msfilter msf;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 66ad1f95af49f222afe0ee75b9163dd0af0a2c49..2c61f444e1c7d322e75e020c41af02977d8814f0 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -773,9 +773,9 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (ipv4_is_multicast(daddr)) {
 		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = inet->mc_index;
+			ipc.oif = READ_ONCE(inet->mc_index);
 		if (!saddr)
-			saddr = inet->mc_addr;
+			saddr = READ_ONCE(inet->mc_addr);
 	} else if (!ipc.oif)
 		ipc.oif = READ_ONCE(inet->uc_index);
 
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e2357d23202e5a39832bb1550c365de9a836c363..27da9d7294c0b4fb9027bb7feb704063dc6302db 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -579,9 +579,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	uc_index = READ_ONCE(inet->uc_index);
 	if (ipv4_is_multicast(daddr)) {
 		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = inet->mc_index;
+			ipc.oif = READ_ONCE(inet->mc_index);
 		if (!saddr)
-			saddr = inet->mc_addr;
+			saddr = READ_ONCE(inet->mc_addr);
 	} else if (!ipc.oif) {
 		ipc.oif = uc_index;
 	} else if (ipv4_is_lbcast(daddr) && uc_index) {
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 1e0c3aba1e5a88c7ba50a28511412a1710f1bab5..7f7724beca33781f8ff12750d1c9c9ccc420f481 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1177,9 +1177,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	uc_index = READ_ONCE(inet->uc_index);
 	if (ipv4_is_multicast(daddr)) {
 		if (!ipc.oif || netif_index_is_l3_master(sock_net(sk), ipc.oif))
-			ipc.oif = inet->mc_index;
+			ipc.oif = READ_ONCE(inet->mc_index);
 		if (!saddr)
-			saddr = inet->mc_addr;
+			saddr = READ_ONCE(inet->mc_addr);
 		connected = 0;
 	} else if (!ipc.oif) {
 		ipc.oif = uc_index;
-- 
2.42.0.459.ge4e396fd5e-goog



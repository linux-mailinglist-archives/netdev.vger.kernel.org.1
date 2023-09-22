Return-Path: <netdev+bounces-35654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D27AA763
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 05:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 22058282CB3
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD217FD;
	Fri, 22 Sep 2023 03:42:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4384E211F
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 03:42:38 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F2AF7
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bee08c13aso23326937b3.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695354156; x=1695958956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Juutre+yi4BpZqiVckzcbN1GkYN+N+Vn3GYokg3Is=;
        b=SxNjbLsiAdURtwfF4L8bxnwBBNLBHI35nlorzD5JC2xejq66tZE+7sfNltiDUKzNDP
         GYVQab6qcQ6P+m2EPtwQ1aqCsJAawLa2zdpPxp6hFHGebmcO+3ocjnxfehSa05lAhbzN
         rGm8vK9Dv3m0ItBv/If9ZH6d9C1qje/uKC4eadh92q4pkeJpCBOtCF4rCsAeIdzZdkNC
         GlI3jbmi1nqMYP+z2XqTuuu/Nz40NEffem45vlEuBindKDF9odJmc+OhMIVjEAMv4bK2
         79jthPwCpAEl+W69/ob/4kwWEU2s48XPOlhDm+G262Qy10wgkB0kVSHu0QzCCfu5iOuq
         etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695354156; x=1695958956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Juutre+yi4BpZqiVckzcbN1GkYN+N+Vn3GYokg3Is=;
        b=GEy7s8r1nA43q0SwdLubtNmFfoG+ErX0c1A78VvKsvuglZE7PvnH4sTY+gghTMP8E5
         skzneBmgnKVhTy4xetvH65KOOIL0WAd0N/MIeNyNMqZtBmfArE/jZlxKJHv1cWrODS6F
         XjpFOG+D5saOxQ0Tx81mfVSlEdTOXdTyWzZtqT7dQejz+pvCtmL6VT5RT+w34mOefQIr
         QJVvDq1nHX9XI4NHLqbGjYdKVETGmuNFQJ64TKR5ClItFPNO0VsdPav+wNXcCsv6bgXs
         IPOLU1LJLAT4GfeBNudOP4GXYTbQEQlqJwkAXttakRQgsoZjBPE3PQDkeZXaU+x7/OmQ
         SeCg==
X-Gm-Message-State: AOJu0Yz8XT79SrVXy0sc77dNmMopcFq8njH0rioK5QfAioNb8rUmoM44
	931ldgXQQ9nK8qQOaLCZwwnS+1NavVCV/w==
X-Google-Smtp-Source: AGHT+IGc+EhskLxVOVfKWZaLXPWdZJNNMXGw5GsAA9TqoL2/QZnsVNyi6ierZBPfi8DgmS3o93UkaiDaHe2MFw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4323:0:b0:59b:d857:8317 with SMTP id
 q35-20020a814323000000b0059bd8578317mr102911ywa.2.1695354155866; Thu, 21 Sep
 2023 20:42:35 -0700 (PDT)
Date: Fri, 22 Sep 2023 03:42:21 +0000
In-Reply-To: <20230922034221.2471544-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230922034221.2471544-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922034221.2471544-9-edumazet@google.com>
Subject: [PATCH v2 net-next 8/8] inet: implement lockless getsockopt(IP_MULTICAST_IF)
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

Add missing annotations to inet->mc_index and inet->mc_addr
to fix data-races.

getsockopt(IP_MULTICAST_IF) can be lockless.

setsockopt() side is left for later.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.42.0.515.g380fc7ccd1-goog



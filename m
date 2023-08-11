Return-Path: <netdev+bounces-26654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB4577884C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210BD281BF6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811935224;
	Fri, 11 Aug 2023 07:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711614C9E
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:36:26 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F6CE75
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d4b1ec7e918so1900422276.2
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739384; x=1692344184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PGF1qJ90kVQQMA8MllDBS/o3lweHdLYmoqRPMU2O+f8=;
        b=3rcE2b8R1+ZZgzNt0GBVlGKgstTCHw92o/TzzV8qMUsof7VZ1RA4TwkJ+vmBYywwPV
         Z/bmo/CKlSOr/rBr8VuJmIgvQNKlUXCuah9ZB90G9W2VCIr+baBMegCDCAi5hvXkoG1B
         D+RTmgvXwjTvja6jXpAyGgXovwJYHZNIWGKWKk9119C2N44BlosPHVb7R0VrfwhDhM4M
         mXWNtzIXE97PSxqfTvlMxhYC73MjWP9vcwOGEr+dw9sTHnSpa8n154Q5b+zC4EU+W9Gy
         Vx95m0qDzYU50QnveiLEy5H7ijOxVl1q76p8FjiLcuMF/aY0KYXHIuvBL4Mf7zPvWXmA
         jhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739384; x=1692344184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGF1qJ90kVQQMA8MllDBS/o3lweHdLYmoqRPMU2O+f8=;
        b=MIjP8XO/1CjMzTg7EiV1erCcDAj6Zd+QqacO562/ItZXTITnPplvx3cQNj4dtAJ5Lp
         Ek5Dj2QnBZ3fIHritw8rZ9q2a7NK6WCUjgynqMMk3CiBFWAcjmeYlTPLZ6JAnpAYJB8o
         1syWP7noiBXgtKhUzvWBqWnuC29xktIhLuGAQGw/HfIVKi3Kn6VKqrRij91EgdEg4Su1
         6enqUlSxFxunm39wuaHqmk5WDwZU8K3sqWc3gAer/D3nAIwPWmd9YtLeTe1ggc4yeS5F
         yqQkUKOCXHh5iptEmowCPnv3jmPIX86SyHddHt7kkFHg2mbE97G205xiEkiRc6b851HH
         76iA==
X-Gm-Message-State: AOJu0YzSWFcpl+c5BmIMg0LybrXjcx0J7FZfpTueix6hLutRzHbuz46N
	OJ/2XqKQ08wq7y2buEiJgmCA1Q9ycR1Cbg==
X-Google-Smtp-Source: AGHT+IGhurWxKJ0nh/apucGPqg5fnZM4Qxa149eBga5xl+a1c0D4O4t3yXBJoR0ZGQWvqd7d+UpNir6v1TiaNw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1816:b0:d08:ea77:52d4 with SMTP
 id cf22-20020a056902181600b00d08ea7752d4mr13886ybb.12.1691739384370; Fri, 11
 Aug 2023 00:36:24 -0700 (PDT)
Date: Fri, 11 Aug 2023 07:36:07 +0000
In-Reply-To: <20230811073621.2874702-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230811073621.2874702-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811073621.2874702-2-edumazet@google.com>
Subject: [PATCH v2 net-next 01/15] inet: introduce inet->inet_flags
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

Various inet fields are currently racy.

do_ip_setsockopt() and do_ip_getsockopt() are mostly holding
the socket lock, but some (fast) paths do not.

Use a new inet->inet_flags to hold atomic bits in the series.

Remove inet->cmsg_flags, and use instead 9 bits from inet_flags.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/inet_sock.h | 55 +++++++++++++++++++++------
 net/ipv4/ip_sockglue.c  | 84 +++++++++++++++--------------------------
 net/ipv4/ping.c         |  5 ++-
 net/ipv4/raw.c          |  2 +-
 net/ipv4/udp.c          |  2 +-
 net/ipv6/datagram.c     |  2 +-
 net/ipv6/udp.c          |  2 +-
 net/l2tp/l2tp_ip.c      |  2 +-
 8 files changed, 83 insertions(+), 71 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 0bb32bfc61832dd787abcb2db3ee85d55c83f2c9..e3b35b0015f335fefa350fd81797a9466ba32f32 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -194,6 +194,7 @@ struct rtable;
  * @inet_rcv_saddr - Bound local IPv4 addr
  * @inet_dport - Destination port
  * @inet_num - Local port
+ * @inet_flags - various atomic flags
  * @inet_saddr - Sending source
  * @uc_ttl - Unicast TTL
  * @inet_sport - Source port
@@ -218,11 +219,11 @@ struct inet_sock {
 #define inet_dport		sk.__sk_common.skc_dport
 #define inet_num		sk.__sk_common.skc_num
 
+	unsigned long		inet_flags;
 	__be32			inet_saddr;
 	__s16			uc_ttl;
-	__u16			cmsg_flags;
-	struct ip_options_rcu __rcu	*inet_opt;
 	__be16			inet_sport;
+	struct ip_options_rcu __rcu	*inet_opt;
 	__u16			inet_id;
 
 	__u8			tos;
@@ -259,16 +260,48 @@ struct inet_sock {
 #define IPCORK_OPT	1	/* ip-options has been held in ipcork.opt */
 #define IPCORK_ALLFRAG	2	/* always fragment (for ipv6 for now) */
 
+enum {
+	INET_FLAGS_PKTINFO	= 0,
+	INET_FLAGS_TTL		= 1,
+	INET_FLAGS_TOS		= 2,
+	INET_FLAGS_RECVOPTS	= 3,
+	INET_FLAGS_RETOPTS	= 4,
+	INET_FLAGS_PASSSEC	= 5,
+	INET_FLAGS_ORIGDSTADDR	= 6,
+	INET_FLAGS_CHECKSUM	= 7,
+	INET_FLAGS_RECVFRAGSIZE	= 8,
+};
+
 /* cmsg flags for inet */
-#define IP_CMSG_PKTINFO		BIT(0)
-#define IP_CMSG_TTL		BIT(1)
-#define IP_CMSG_TOS		BIT(2)
-#define IP_CMSG_RECVOPTS	BIT(3)
-#define IP_CMSG_RETOPTS		BIT(4)
-#define IP_CMSG_PASSSEC		BIT(5)
-#define IP_CMSG_ORIGDSTADDR	BIT(6)
-#define IP_CMSG_CHECKSUM	BIT(7)
-#define IP_CMSG_RECVFRAGSIZE	BIT(8)
+#define IP_CMSG_PKTINFO		BIT(INET_FLAGS_PKTINFO)
+#define IP_CMSG_TTL		BIT(INET_FLAGS_TTL)
+#define IP_CMSG_TOS		BIT(INET_FLAGS_TOS)
+#define IP_CMSG_RECVOPTS	BIT(INET_FLAGS_RECVOPTS)
+#define IP_CMSG_RETOPTS		BIT(INET_FLAGS_RETOPTS)
+#define IP_CMSG_PASSSEC		BIT(INET_FLAGS_PASSSEC)
+#define IP_CMSG_ORIGDSTADDR	BIT(INET_FLAGS_ORIGDSTADDR)
+#define IP_CMSG_CHECKSUM	BIT(INET_FLAGS_CHECKSUM)
+#define IP_CMSG_RECVFRAGSIZE	BIT(INET_FLAGS_RECVFRAGSIZE)
+
+#define IP_CMSG_ALL	(IP_CMSG_PKTINFO | IP_CMSG_TTL |		\
+			 IP_CMSG_TOS | IP_CMSG_RECVOPTS |		\
+			 IP_CMSG_RETOPTS | IP_CMSG_PASSSEC |		\
+			 IP_CMSG_ORIGDSTADDR | IP_CMSG_CHECKSUM |	\
+			 IP_CMSG_RECVFRAGSIZE)
+
+static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
+{
+	return READ_ONCE(inet->inet_flags) & IP_CMSG_ALL;
+}
+
+#define inet_test_bit(nr, sk)			\
+	test_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet_set_bit(nr, sk)			\
+	set_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet_clear_bit(nr, sk)			\
+	clear_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags)
+#define inet_assign_bit(nr, sk, val)		\
+	assign_bit(INET_FLAGS_##nr, &inet_sk(sk)->inet_flags, val)
 
 static inline bool sk_is_inet(struct sock *sk)
 {
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index d41bce8927b2cca825a804dc113450b62262cc94..66f55f3db5ec88e1c771847444eba1d554aca8dc 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -171,8 +171,10 @@ static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset)
 {
-	struct inet_sock *inet = inet_sk(sk);
-	unsigned int flags = inet->cmsg_flags;
+	unsigned long flags = inet_cmsg_flags(inet_sk(sk));
+
+	if (!flags)
+		return;
 
 	/* Ordered by supposed usage frequency */
 	if (flags & IP_CMSG_PKTINFO) {
@@ -568,7 +570,7 @@ int ip_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 	if (ipv4_datagram_support_cmsg(sk, skb, serr->ee.ee_origin)) {
 		sin->sin_family = AF_INET;
 		sin->sin_addr.s_addr = ip_hdr(skb)->saddr;
-		if (inet_sk(sk)->cmsg_flags)
+		if (inet_cmsg_flags(inet_sk(sk)))
 			ip_cmsg_recv(msg, skb);
 	}
 
@@ -635,7 +637,7 @@ EXPORT_SYMBOL(ip_sock_set_mtu_discover);
 void ip_sock_set_pktinfo(struct sock *sk)
 {
 	lock_sock(sk);
-	inet_sk(sk)->cmsg_flags |= IP_CMSG_PKTINFO;
+	inet_set_bit(PKTINFO, sk);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(ip_sock_set_pktinfo);
@@ -990,67 +992,43 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		break;
 	}
 	case IP_PKTINFO:
-		if (val)
-			inet->cmsg_flags |= IP_CMSG_PKTINFO;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_PKTINFO;
+		inet_assign_bit(PKTINFO, sk, val);
 		break;
 	case IP_RECVTTL:
-		if (val)
-			inet->cmsg_flags |=  IP_CMSG_TTL;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_TTL;
+		inet_assign_bit(TTL, sk, val);
 		break;
 	case IP_RECVTOS:
-		if (val)
-			inet->cmsg_flags |=  IP_CMSG_TOS;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_TOS;
+		inet_assign_bit(TOS, sk, val);
 		break;
 	case IP_RECVOPTS:
-		if (val)
-			inet->cmsg_flags |=  IP_CMSG_RECVOPTS;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_RECVOPTS;
+		inet_assign_bit(RECVOPTS, sk, val);
 		break;
 	case IP_RETOPTS:
-		if (val)
-			inet->cmsg_flags |= IP_CMSG_RETOPTS;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_RETOPTS;
+		inet_assign_bit(RETOPTS, sk, val);
 		break;
 	case IP_PASSSEC:
-		if (val)
-			inet->cmsg_flags |= IP_CMSG_PASSSEC;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_PASSSEC;
+		inet_assign_bit(PASSSEC, sk, val);
 		break;
 	case IP_RECVORIGDSTADDR:
-		if (val)
-			inet->cmsg_flags |= IP_CMSG_ORIGDSTADDR;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_ORIGDSTADDR;
+		inet_assign_bit(ORIGDSTADDR, sk, val);
 		break;
 	case IP_CHECKSUM:
 		if (val) {
-			if (!(inet->cmsg_flags & IP_CMSG_CHECKSUM)) {
+			if (!(inet_test_bit(CHECKSUM, sk))) {
 				inet_inc_convert_csum(sk);
-				inet->cmsg_flags |= IP_CMSG_CHECKSUM;
+				inet_set_bit(CHECKSUM, sk);
 			}
 		} else {
-			if (inet->cmsg_flags & IP_CMSG_CHECKSUM) {
+			if (inet_test_bit(CHECKSUM, sk)) {
 				inet_dec_convert_csum(sk);
-				inet->cmsg_flags &= ~IP_CMSG_CHECKSUM;
+				inet_clear_bit(CHECKSUM, sk);
 			}
 		}
 		break;
 	case IP_RECVFRAGSIZE:
 		if (sk->sk_type != SOCK_RAW && sk->sk_type != SOCK_DGRAM)
 			goto e_inval;
-		if (val)
-			inet->cmsg_flags |= IP_CMSG_RECVFRAGSIZE;
-		else
-			inet->cmsg_flags &= ~IP_CMSG_RECVFRAGSIZE;
+		inet_assign_bit(RECVFRAGSIZE, sk, val);
 		break;
 	case IP_TOS:	/* This sets both TOS and Precedence */
 		__ip_sock_set_tos(sk, val);
@@ -1415,7 +1393,7 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
 {
 	struct in_pktinfo *pktinfo = PKTINFO_SKB_CB(skb);
-	bool prepare = (inet_sk(sk)->cmsg_flags & IP_CMSG_PKTINFO) ||
+	bool prepare = inet_test_bit(PKTINFO, sk) ||
 		       ipv6_sk_rxinfo(sk);
 
 	if (prepare && skb_rtable(skb)) {
@@ -1601,31 +1579,31 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		return 0;
 	}
 	case IP_PKTINFO:
-		val = (inet->cmsg_flags & IP_CMSG_PKTINFO) != 0;
+		val = inet_test_bit(PKTINFO, sk);
 		break;
 	case IP_RECVTTL:
-		val = (inet->cmsg_flags & IP_CMSG_TTL) != 0;
+		val = inet_test_bit(TTL, sk);
 		break;
 	case IP_RECVTOS:
-		val = (inet->cmsg_flags & IP_CMSG_TOS) != 0;
+		val = inet_test_bit(TOS, sk);
 		break;
 	case IP_RECVOPTS:
-		val = (inet->cmsg_flags & IP_CMSG_RECVOPTS) != 0;
+		val = inet_test_bit(RECVOPTS, sk);
 		break;
 	case IP_RETOPTS:
-		val = (inet->cmsg_flags & IP_CMSG_RETOPTS) != 0;
+		val = inet_test_bit(RETOPTS, sk);
 		break;
 	case IP_PASSSEC:
-		val = (inet->cmsg_flags & IP_CMSG_PASSSEC) != 0;
+		val = inet_test_bit(PASSSEC, sk);
 		break;
 	case IP_RECVORIGDSTADDR:
-		val = (inet->cmsg_flags & IP_CMSG_ORIGDSTADDR) != 0;
+		val = inet_test_bit(ORIGDSTADDR, sk);
 		break;
 	case IP_CHECKSUM:
-		val = (inet->cmsg_flags & IP_CMSG_CHECKSUM) != 0;
+		val = inet_test_bit(CHECKSUM, sk);
 		break;
 	case IP_RECVFRAGSIZE:
-		val = (inet->cmsg_flags & IP_CMSG_RECVFRAGSIZE) != 0;
+		val = inet_test_bit(RECVFRAGSIZE, sk);
 		break;
 	case IP_TOS:
 		val = inet->tos;
@@ -1737,7 +1715,7 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		msg.msg_controllen = len;
 		msg.msg_flags = in_compat_syscall() ? MSG_CMSG_COMPAT : 0;
 
-		if (inet->cmsg_flags & IP_CMSG_PKTINFO) {
+		if (inet_test_bit(PKTINFO, sk)) {
 			struct in_pktinfo info;
 
 			info.ipi_addr.s_addr = inet->inet_rcv_saddr;
@@ -1745,11 +1723,11 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 			info.ipi_ifindex = inet->mc_index;
 			put_cmsg(&msg, SOL_IP, IP_PKTINFO, sizeof(info), &info);
 		}
-		if (inet->cmsg_flags & IP_CMSG_TTL) {
+		if (inet_test_bit(TTL, sk)) {
 			int hlim = inet->mc_ttl;
 			put_cmsg(&msg, SOL_IP, IP_TTL, sizeof(hlim), &hlim);
 		}
-		if (inet->cmsg_flags & IP_CMSG_TOS) {
+		if (inet_test_bit(TOS, sk)) {
 			int tos = inet->rcv_tos;
 			put_cmsg(&msg, SOL_IP, IP_TOS, sizeof(tos), &tos);
 		}
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 25dd78cee1792fdbd46873e58a503ab5a45d85b2..7e8702cb6634465f5e319a10e8f845093a354f47 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -894,7 +894,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 			*addr_len = sizeof(*sin);
 		}
 
-		if (isk->cmsg_flags)
+		if (inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -921,7 +921,8 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		if (skb->protocol == htons(ETH_P_IPV6) &&
 		    inet6_sk(sk)->rxopt.all)
 			pingv6_ops.ip6_datagram_recv_specific_ctl(sk, msg, skb);
-		else if (skb->protocol == htons(ETH_P_IP) && isk->cmsg_flags)
+		else if (skb->protocol == htons(ETH_P_IP) &&
+			 inet_cmsg_flags(isk))
 			ip_cmsg_recv(msg, skb);
 #endif
 	} else {
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index cb381f5aa46438394cdec520a99f7a8bc67fcfb9..e6e813f4aa317c3a5f242776a889610ccc1aa72f 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -767,7 +767,7 @@ static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
 		*addr_len = sizeof(*sin);
 	}
-	if (inet->cmsg_flags)
+	if (inet_cmsg_flags(inet))
 		ip_cmsg_recv(msg, skb);
 	if (flags & MSG_TRUNC)
 		copied = skb->len;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3e2f29c14fa8c4ec10009b08e5740b7be052132d..4b791133989c0abe4f869ef0c56649c9d671db1a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1870,7 +1870,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	if (udp_sk(sk)->gro_enabled)
 		udp_cmsg_recv(msg, sk, skb);
 
-	if (inet->cmsg_flags)
+	if (inet_cmsg_flags(inet))
 		ip_cmsg_recv_offset(msg, sk, skb, sizeof(struct udphdr), off);
 
 	err = copied;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index d80d6024cafa90932ba7d749c0b8d4cd8f9d9cc3..41ebc4e574734456357169e883c3d13e42fa66b2 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -524,7 +524,7 @@ int ipv6_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 		} else {
 			ipv6_addr_set_v4mapped(ip_hdr(skb)->saddr,
 					       &sin->sin6_addr);
-			if (inet_sk(sk)->cmsg_flags)
+			if (inet_cmsg_flags(inet_sk(sk)))
 				ip_cmsg_recv(msg, skb);
 		}
 	}
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 1ea01b0d9be383b2f7095ca40d89fd1599e0e33f..ebc6ae47cfeadc699e3f5a1f46be85803ff37fdd 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -420,7 +420,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		ip6_datagram_recv_common_ctl(sk, msg, skb);
 
 	if (is_udp4) {
-		if (inet->cmsg_flags)
+		if (inet_cmsg_flags(inet))
 			ip_cmsg_recv_offset(msg, sk, skb,
 					    sizeof(struct udphdr), off);
 	} else {
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index f9073bc7281f96267f6b40b830a19fa0e8df140f..9a2a9ed3ba478b9d00885b1a00e87f0edde5cb33 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -552,7 +552,7 @@ static int l2tp_ip_recvmsg(struct sock *sk, struct msghdr *msg,
 		memset(&sin->sin_zero, 0, sizeof(sin->sin_zero));
 		*addr_len = sizeof(*sin);
 	}
-	if (inet->cmsg_flags)
+	if (inet_cmsg_flags(inet))
 		ip_cmsg_recv(msg, skb);
 	if (flags & MSG_TRUNC)
 		copied = skb->len;
-- 
2.41.0.640.ga95def55d0-goog



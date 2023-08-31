Return-Path: <netdev+bounces-31592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CD78EF02
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854831C20AFE
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 13:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E064125AC;
	Thu, 31 Aug 2023 13:52:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9B4125AB
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 13:52:26 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAFE50
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d74711fd72eso663348276.3
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693489944; x=1694094744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cWrQpMUhDTwCIggC4MvVk9cDN3cCyq18JFdnHi2O/2U=;
        b=RxSDgtG5YP7ucgbl56T9eU18rZUtPZh3uyjDkiKevx/Yz75LDi8m6qFIm9kVBsEvOK
         JavBWg1G1j9JTsoLDgRa7AsW3geOj/QYulJkW4gOKVfV/3Hnc1XvyjlSJvqD7OCE0qAx
         HAx5WB9aPUil5vzwQnTldWOC3olkb51gPXo3e5jsi1vPZN0RfLKHTkvB4uz0RWYoiK/u
         P45eBFQXSgU/E31maxEdYYtvyEprsr0YawlpN9xau6LvAoklpnMccBcpFodB/1qtQ1xa
         T+SHOXVdWBf5HgXD4f4C7XWB2nDmkcNw1vhEoYtomQO0yVb86HGoWUTWicw9L/fYPgU/
         dLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489944; x=1694094744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWrQpMUhDTwCIggC4MvVk9cDN3cCyq18JFdnHi2O/2U=;
        b=UoU3hAMVlqKzeJU7lLBEyQwNrNBogS6b4uKH3IMhD5OEtv8rS58FyFOODUuUhsmndr
         c0Qva9y5aPK1PzLbeJO9FzCXnAmoN8xzX0um64T1cx6VtVlsiB38Nf808A5D1eF8dMHq
         jc2lSPeAhVZyI6AWI9lB93AIuckcdzzeusPnK+7cW864yHX+bweEjknyDGP6220D+ORn
         qLVw0SjEfQN2GlkInm/gwZmbl5L95HtdIQtB4eRp3ctFK0RX3h4F54DzZnRW1atBr1mq
         DHhY2cqHrPIQlfuDwEF29PYPSJBdCq/LZLtO7kYgyk3KYO3dtAALJXo+2MhyBbzTJMOl
         IWqQ==
X-Gm-Message-State: AOJu0YyBPYE7c+IxaJnRQNCYKr7c/g/gBi5ZaUQ35Xjyc4n5+A8kFeIo
	j9DF92RUXsyB4ojjDqmJY5z/U30U9OpAEw==
X-Google-Smtp-Source: AGHT+IH8Enx5a3XxMo4Qc2GRmRNNn9dBWjU0il/mHx5pCcR1+0SK3q6bfcElDiAHvPPTFTD6O0QBfNvRjsuTCg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:5f4d:0:b0:c6a:caf1:e601 with SMTP id
 h13-20020a255f4d000000b00c6acaf1e601mr163579ybm.13.1693489943896; Thu, 31 Aug
 2023 06:52:23 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:52:11 +0000
In-Reply-To: <20230831135212.2615985-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230831135212.2615985-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831135212.2615985-5-edumazet@google.com>
Subject: [PATCH net 4/5] net: annotate data-races around sk->sk_tsflags
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk->sk_tsflags can be read locklessly, add corresponding annotations.

Fixes: b9f40e21ef42 ("net-timestamp: move timestamp flags out of sk_flags")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
---
 include/net/ip.h       |  2 +-
 include/net/sock.h     | 17 ++++++++++-------
 net/can/j1939/socket.c | 10 ++++++----
 net/core/skbuff.c      | 10 ++++++----
 net/core/sock.c        |  4 ++--
 net/ipv4/ip_output.c   |  2 +-
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv4/tcp.c         |  4 ++--
 net/ipv6/ip6_output.c  |  2 +-
 net/ipv6/ping.c        |  2 +-
 net/ipv6/raw.c         |  2 +-
 net/ipv6/udp.c         |  2 +-
 net/socket.c           | 13 +++++++------
 13 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 19adacd5ece031547e3ad70d524e89d8a6301a55..9276cea775cc2c26ccabcfea34822b19cfedb1a7 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -94,7 +94,7 @@ static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 	ipcm_init(ipcm);
 
 	ipcm->sockc.mark = READ_ONCE(inet->sk.sk_mark);
-	ipcm->sockc.tsflags = inet->sk.sk_tsflags;
+	ipcm->sockc.tsflags = READ_ONCE(inet->sk.sk_tsflags);
 	ipcm->oif = READ_ONCE(inet->sk.sk_bound_dev_if);
 	ipcm->addr = inet->inet_saddr;
 	ipcm->protocol = inet->inet_num;
diff --git a/include/net/sock.h b/include/net/sock.h
index f04869ac1d92283bc3e4ecea2909babfc5096003..b770261fbdaf59d4d1c0b30adb2592c56442e9e3 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1906,7 +1906,9 @@ struct sockcm_cookie {
 static inline void sockcm_init(struct sockcm_cookie *sockc,
 			       const struct sock *sk)
 {
-	*sockc = (struct sockcm_cookie) { .tsflags = sk->sk_tsflags };
+	*sockc = (struct sockcm_cookie) {
+		.tsflags = READ_ONCE(sk->sk_tsflags)
+	};
 }
 
 int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
@@ -2701,9 +2703,9 @@ void __sock_recv_wifi_status(struct msghdr *msg, struct sock *sk,
 static inline void
 sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 {
-	ktime_t kt = skb->tstamp;
 	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-
+	u32 tsflags = READ_ONCE(sk->sk_tsflags);
+	ktime_t kt = skb->tstamp;
 	/*
 	 * generate control messages if
 	 * - receive time stamping in software requested
@@ -2711,10 +2713,10 @@ sock_recv_timestamp(struct msghdr *msg, struct sock *sk, struct sk_buff *skb)
 	 * - hardware time stamps available and wanted
 	 */
 	if (sock_flag(sk, SOCK_RCVTSTAMP) ||
-	    (sk->sk_tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
-	    (kt && sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
+	    (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE) ||
+	    (kt && tsflags & SOF_TIMESTAMPING_SOFTWARE) ||
 	    (hwtstamps->hwtstamp &&
-	     (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
+	     (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)))
 		__sock_recv_timestamp(msg, sk, skb);
 	else
 		sock_write_timestamp(sk, kt);
@@ -2736,7 +2738,8 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
-	if (sk->sk_flags & FLAGS_RECV_CMSGS || sk->sk_tsflags & TSFLAGS_ANY)
+	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
+	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index feaec4ad6d163d6c898f7e63671a3e264bb2cd1b..b28c976f52a0a16e13e23aee7c6fe4a7a8c844af 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -974,6 +974,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	struct sock_exterr_skb *serr;
 	struct sk_buff *skb;
 	char *state = "UNK";
+	u32 tsflags;
 	int err;
 
 	jsk = j1939_sk(sk);
@@ -981,13 +982,14 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	if (!(jsk->state & J1939_SOCK_ERRQUEUE))
 		return;
 
+	tsflags = READ_ONCE(sk->sk_tsflags);
 	switch (type) {
 	case J1939_ERRQUEUE_TX_ACK:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_ACK))
+		if (!(tsflags & SOF_TIMESTAMPING_TX_ACK))
 			return;
 		break;
 	case J1939_ERRQUEUE_TX_SCHED:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_TX_SCHED))
+		if (!(tsflags & SOF_TIMESTAMPING_TX_SCHED))
 			return;
 		break;
 	case J1939_ERRQUEUE_TX_ABORT:
@@ -997,7 +999,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	case J1939_ERRQUEUE_RX_DPO:
 		fallthrough;
 	case J1939_ERRQUEUE_RX_ABORT:
-		if (!(sk->sk_tsflags & SOF_TIMESTAMPING_RX_SOFTWARE))
+		if (!(tsflags & SOF_TIMESTAMPING_RX_SOFTWARE))
 			return;
 		break;
 	default:
@@ -1054,7 +1056,7 @@ static void __j1939_sk_errqueue(struct j1939_session *session, struct sock *sk,
 	}
 
 	serr->opt_stats = true;
-	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	if (tsflags & SOF_TIMESTAMPING_OPT_ID)
 		serr->ee.ee_data = session->tskey;
 
 	netdev_dbg(session->priv->ndev, "%s: 0x%p tskey: %i, state: %s\n",
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 45707059082f2d706a9820f4484d0d4636aaa930..24f26e816184ebdc3317b07f7b3854b9908642f2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5207,7 +5207,7 @@ static void __skb_complete_tx_timestamp(struct sk_buff *skb,
 	serr->ee.ee_info = tstype;
 	serr->opt_stats = opt_stats;
 	serr->header.h4.iif = skb->dev ? skb->dev->ifindex : 0;
-	if (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID) {
+	if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID) {
 		serr->ee.ee_data = skb_shinfo(skb)->tskey;
 		if (sk_is_tcp(sk))
 			serr->ee.ee_data -= atomic_read(&sk->sk_tskey);
@@ -5263,21 +5263,23 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 {
 	struct sk_buff *skb;
 	bool tsonly, opt_stats = false;
+	u32 tsflags;
 
 	if (!sk)
 		return;
 
-	if (!hwtstamps && !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if (!hwtstamps && !(tsflags & SOF_TIMESTAMPING_OPT_TX_SWHW) &&
 	    skb_shinfo(orig_skb)->tx_flags & SKBTX_IN_PROGRESS)
 		return;
 
-	tsonly = sk->sk_tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
+	tsonly = tsflags & SOF_TIMESTAMPING_OPT_TSONLY;
 	if (!skb_may_tx_timestamp(sk, tsonly))
 		return;
 
 	if (tsonly) {
 #ifdef CONFIG_INET
-		if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
+		if ((tsflags & SOF_TIMESTAMPING_OPT_STATS) &&
 		    sk_is_tcp(sk)) {
 			skb = tcp_get_timestamping_opt_stats(sk, orig_skb,
 							     ack_skb);
diff --git a/net/core/sock.c b/net/core/sock.c
index 40e1bda4bde0cd0ddbb0315deb4df45d60f65081..d05a290300b6c8c765d6733520c50978f35f2dd0 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -937,7 +937,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 			return ret;
 	}
 
-	sk->sk_tsflags = val;
+	WRITE_ONCE(sk->sk_tsflags, val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
 
 	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
@@ -1719,7 +1719,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_TIMESTAMPING_OLD:
 		lv = sizeof(v.timestamping);
-		v.timestamping.flags = sk->sk_tsflags;
+		v.timestamping.flags = READ_ONCE(sk->sk_tsflags);
 		v.timestamping.bind_phc = sk->sk_bind_phc;
 		break;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b2e0ad3120280d360aebb1c116af85506a237e05..4ab877cf6d35f229761986d5c6a17eb2a3ad4043 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -981,7 +981,7 @@ static int __ip_append_data(struct sock *sk,
 	paged = !!cork->gso_size;
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index d1c73660b844949b57960630e0467112da4f0abd..cce9cb25f3b31cd57fa883ae0dedb6829d8da2fa 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -511,7 +511,7 @@ static bool ipv4_datagram_support_cmsg(const struct sock *sk,
 	 * or without payload (SOF_TIMESTAMPING_OPT_TSONLY).
 	 */
 	info = PKTINFO_SKB_CB(skb);
-	if (!(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_CMSG) ||
+	if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_CMSG) ||
 	    !info->ipi_ifindex)
 		return false;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index cee1e548660cb93835102836fe8103666c4c4697..cc4b250262c19ae5f18e806dca63ad7b05e03ab2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2259,14 +2259,14 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 			}
 		}
 
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
 			has_timestamping = true;
 		else
 			tss->ts[0] = (struct timespec64) {0};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
+		if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
 			tss->ts[2] = (struct timespec64) {0};
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 4ab50169a5a9dc4fabee86398906b3a4cefda049..54fc4c711f2c545f2ca625d6b0e09f2bb8e6d513 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1501,7 +1501,7 @@ static int __ip6_append_data(struct sock *sk,
 	orig_mtu = mtu;
 
 	if (cork->tx_flags & SKBTX_ANY_TSTAMP &&
-	    sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)
+	    READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_OPT_ID)
 		tskey = atomic_inc_return(&sk->sk_tskey) - 1;
 
 	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 1b27728349725e212ab5d988dd96cf87464c9531..5831aaa53d75eae7b764d54ab52da65db4030d73 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -119,7 +119,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		return -EINVAL;
 
 	ipcm6_init_sk(&ipc6, np);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	fl6.flowi6_oif = oif;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0eae7661a85c4487a64384c6054a3fb827387ce7..42fcec3ecf5e171a5ebe724b8c971d90885abe41 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -772,7 +772,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_uid = sk->sk_uid;
 
 	ipcm6_init(&ipc6);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
 
 	if (sin6) {
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ebc6ae47cfeadc699e3f5a1f46be85803ff37fdd..86b5d509a4688cacb2f40667c9ddc10f81ade2fe 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1339,7 +1339,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	ipcm6_init(&ipc6);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
-	ipc6.sockc.tsflags = sk->sk_tsflags;
+	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
 
 	/* destination address check */
diff --git a/net/socket.c b/net/socket.c
index 848116d06b51168585b9d8ed26c9f20730cd46c9..98ffffab949e850fe07904f1cf20ff2ce4a9b5d1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -825,7 +825,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
 
 static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
 {
-	bool cycles = sk->sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;
+	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
 	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
 	struct net_device *orig_dev;
 	ktime_t hwtstamp;
@@ -877,12 +877,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	int need_software_tstamp = sock_flag(sk, SOCK_RCVTSTAMP);
 	int new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
 	struct scm_timestamping_internal tss;
-
 	int empty = 1, false_tstamp = 0;
 	struct skb_shared_hwtstamps *shhwtstamps =
 		skb_hwtstamps(skb);
 	int if_index;
 	ktime_t hwtstamp;
+	u32 tsflags;
 
 	/* Race occurred between timestamp enabling and packet
 	   receiving.  Fill in the current time for now. */
@@ -924,11 +924,12 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	}
 
 	memset(&tss, 0, sizeof(tss));
-	if ((sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+	tsflags = READ_ONCE(sk->sk_tsflags);
+	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
 	    ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
 		empty = 0;
 	if (shhwtstamps &&
-	    (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+	    (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
 		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
@@ -936,14 +937,14 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 		else
 			hwtstamp = shhwtstamps->hwtstamp;
 
-		if (sk->sk_tsflags & SOF_TIMESTAMPING_BIND_PHC)
+		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
 			hwtstamp = ptp_convert_timestamp(&hwtstamp,
 							 sk->sk_bind_phc);
 
 		if (ktime_to_timespec64_cond(hwtstamp, tss.ts + 2)) {
 			empty = 0;
 
-			if ((sk->sk_tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
+			if ((tsflags & SOF_TIMESTAMPING_OPT_PKTINFO) &&
 			    !skb_is_err_queue(skb))
 				put_ts_pktinfo(msg, skb, if_index);
 		}
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog



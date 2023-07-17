Return-Path: <netdev+bounces-18348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCC9756810
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D97A1C20B2A
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E70253DD;
	Mon, 17 Jul 2023 15:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8A8253B4
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 15:30:16 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957C6173A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:29:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c850943cf9aso4018347276.1
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689607760; x=1692199760;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOQ63MUwlm+HNiDBvKJBOAGddTpodh5b+JAzdkbgA54=;
        b=GixLuwIJfNgzDOrvrrW4V1rr9pEld2ePP7nhLqs3MH0W16/1evvqtXnaHAadAXbmco
         GFbnew36ih3SQzNJm0NBAl0a5OGDt5ScV1YSxTpNgqfuv32GTwkwzr0sjWJnhDpnH469
         6QUX0Zk66azyJlco5gJk6q2a+gCiM8eg2Rpib6Y3ekqgAKORtg84w8J0vhU7DAwx60SF
         CziLtpkOCvU55IYPtBESNEhFCminLVOcPrduPvBD8j3oIX5+C5BSX/pzLjkmZ7c3HMLS
         is1oWxwE0Lb8iuFUPP9TYV/LECU0o0uaW3GZ8/Laz2gDL3w9KRiB9BPaXqeiW9O/D3UD
         B8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689607760; x=1692199760;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOQ63MUwlm+HNiDBvKJBOAGddTpodh5b+JAzdkbgA54=;
        b=SIHH/VFwENPyvTiBfOABG7ZR9PBBTtGWWCZjSRrE89nXhjqcbDVd5Ly/fwQiAtsrA5
         /ub1OKPL51oZvalRKJeaDcajKJHDLwFVL2jC104qoaNOuBBJUncDRVbzo1tVqU8o66L5
         2EkpYErw6U5Ikm3gmdv4a0juxQxyRTyyw1bZJ6Pa3MPRTmwIdVjaZxN/2fweC2iFlcAD
         7Gu59Owbx42zhuROqJktgcOjCXbsSURsT2knrv8aisGLYuT+0Nr7iQDd6qORxPs4p/x2
         ptIykOuFUc9Z8kdkDohciESzpLChWbXqvY9Ecx9ip3OgoWoFvh/3U7aIJgl5SzCKGfxj
         tu4g==
X-Gm-Message-State: ABy/qLZn4MDanZpIBII1YsF6Z4h3IKnJ4RZO/s5V75tGHQu8C4rKWUUr
	UHY2ZEuvQA8Qs9W9nkfvD9++E8sTRztz7Q==
X-Google-Smtp-Source: APBJJlHKVSzJPDQ8e109VmhV63RRHiFR8S7RA+hw7djDuObOHAPVv2x1nAXIKn4+5KurWuqadtnimxk+nQLryg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:8550:0:b0:c73:9cb6:3cb4 with SMTP id
 f16-20020a258550000000b00c739cb63cb4mr106862ybn.10.1689607760220; Mon, 17 Jul
 2023 08:29:20 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:29:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717152917.751987-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With modern NIC drivers shifting to full page allocations per
received frame, we face the following issue:

TCP has one per-netns sysctl used to tweak how to translate
a memory use into an expected payload (RWIN), in RX path.

tcp_win_from_space() implementation is limited to few cases.

For hosts dealing with various MSS, we either under estimate
or over estimate the RWIN we send to the remote peers.

For instance with the default sysctl_tcp_adv_win_scale value,
we expect to store 50% of payload per allocated chunk of memory.

For the typical use of MTU=1500 traffic, and order-0 pages allocations
by NIC drivers, we are sending too big RWIN, leading to potential
tcp collapse operations, which are extremely expensive and source
of latency spikes.

This patch makes sysctl_tcp_adv_win_scale obsolete, and instead
uses a per socket scaling factor, so that we can precisely
adjust the RWIN based on effective skb->len/skb->truesize ratio.

This patch alone can double TCP receive performance when receivers
are too slow to drain their receive queue, or by allowing
a bigger RWIN when MSS is close to PAGE_SIZE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst |  1 +
 include/linux/tcp.h                    |  4 +++-
 include/net/netns/ipv4.h               |  2 +-
 include/net/tcp.h                      | 24 ++++++++++++++++++++----
 net/ipv4/tcp.c                         | 11 ++++++-----
 net/ipv4/tcp_input.c                   | 19 ++++++++++++-------
 6 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 4a010a7cde7f8085db5ba6f1b9af53e9e5223cd5..82f2117cf2b36a834e5e391feda0210d916bff8b 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -321,6 +321,7 @@ tcp_abort_on_overflow - BOOLEAN
 	option can harm clients of your server.
 
 tcp_adv_win_scale - INTEGER
+	Obsolete since linux-6.6
 	Count buffering overhead as bytes/2^tcp_adv_win_scale
 	(if tcp_adv_win_scale > 0) or bytes-bytes/2^(-tcp_adv_win_scale),
 	if it is <= 0.
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b4c08ac86983568a9511258708724da15d0b999e..fbcb0ce13171d46aa3697abcd48482b08e78e5e0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -172,6 +172,8 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 	return (struct tcp_request_sock *)req;
 }
 
+#define TCP_RMEM_TO_WIN_SCALE 8
+
 struct tcp_sock {
 	/* inet_connection_sock has to be the first member of tcp_sock */
 	struct inet_connection_sock	inet_conn;
@@ -238,7 +240,7 @@ struct tcp_sock {
 
 	u32	window_clamp;	/* Maximal window to advertise		*/
 	u32	rcv_ssthresh;	/* Current window clamp			*/
-
+	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	/* Information of the most recently (s)acked skb */
 	struct tcp_rack {
 		u64 mstamp; /* (Re)sent time of the skb */
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index f003747181593559a4efe1838be719d445417041..7a41c4791536732005cedbb80c223b86aa43249e 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -152,7 +152,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_abort_on_overflow;
 	u8 sysctl_tcp_fack; /* obsolete */
 	int sysctl_tcp_max_reordering;
-	int sysctl_tcp_adv_win_scale;
+	int sysctl_tcp_adv_win_scale; /* obsolete */
 	u8 sysctl_tcp_dsack;
 	u8 sysctl_tcp_app_win;
 	u8 sysctl_tcp_frto;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 226bce6d1e8c30185260baadec449b67323db91c..2104a71c75ba7eee40612395be4103ae370b3c03 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1434,11 +1434,27 @@ void tcp_select_initial_window(const struct sock *sk, int __space,
 
 static inline int tcp_win_from_space(const struct sock *sk, int space)
 {
-	int tcp_adv_win_scale = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_adv_win_scale);
+	s64 scaled_space = (s64)space * tcp_sk(sk)->scaling_ratio;
 
-	return tcp_adv_win_scale <= 0 ?
-		(space>>(-tcp_adv_win_scale)) :
-		space - (space>>tcp_adv_win_scale);
+	return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
+}
+
+/* inverse of tcp_win_from_space() */
+static inline int tcp_space_from_win(const struct sock *sk, int win)
+{
+	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
+
+	do_div(val, tcp_sk(sk)->scaling_ratio);
+	return val;
+}
+
+static inline void tcp_scaling_ratio_init(struct sock *sk)
+{
+	/* Assume a conservative default of 1200 bytes of payload per 4K page.
+	 * This may be adjusted later in tcp_measure_rcv_mss().
+	 */
+	tcp_sk(sk)->scaling_ratio = (1200 << TCP_RMEM_TO_WIN_SCALE) /
+				    SKB_TRUESIZE(4096);
 }
 
 /* Note: caller must be prepared to deal with negative returns */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e03e08745308189c9d64509c2cff94da56c86a0c..88f4ebab12acc11d5f3feb6b13974a0b8e565671 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
 
 	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_wmem[1]));
 	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[1]));
+	tcp_scaling_ratio_init(sk);
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
@@ -1700,7 +1701,7 @@ EXPORT_SYMBOL(tcp_peek_len);
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
 {
-	int cap;
+	int space, cap;
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		cap = sk->sk_rcvbuf >> 1;
@@ -1715,10 +1716,10 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
 
-	val <<= 1;
-	if (val > sk->sk_rcvbuf) {
-		WRITE_ONCE(sk->sk_rcvbuf, val);
-		tcp_sk(sk)->window_clamp = tcp_win_from_space(sk, val);
+	space = tcp_space_from_win(sk, val);
+	if (space > sk->sk_rcvbuf) {
+		WRITE_ONCE(sk->sk_rcvbuf, space);
+		tcp_sk(sk)->window_clamp = val;
 	}
 	return 0;
 }
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 57c8af1859c16eba5e952a23ea959b628006f9c1..3cd92035e0902298baa8afd89ae5edcbfce300e5 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -237,6 +237,16 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 	 */
 	len = skb_shinfo(skb)->gso_size ? : skb->len;
 	if (len >= icsk->icsk_ack.rcv_mss) {
+		/* Note: divides are still a bit expensive.
+		 * For the moment, only adjust scaling_ratio
+		 * when we update icsk_ack.rcv_mss.
+		 */
+		if (unlikely(len != icsk->icsk_ack.rcv_mss)) {
+			u64 val = (u64)skb->len << TCP_RMEM_TO_WIN_SCALE;
+
+			do_div(val, skb->truesize);
+			tcp_sk(sk)->scaling_ratio = val ? val : 1;
+		}
 		icsk->icsk_ack.rcv_mss = min_t(unsigned int, len,
 					       tcp_sk(sk)->advmss);
 		/* Account for possibly-removed options */
@@ -727,8 +737,8 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int rcvmem, rcvbuf;
 		u64 rcvwin, grow;
+		int rcvbuf;
 
 		/* minimal window to cope with packet losses, assuming
 		 * steady state. Add some cushion because of small variations.
@@ -740,12 +750,7 @@ void tcp_rcv_space_adjust(struct sock *sk)
 		do_div(grow, tp->rcvq_space.space);
 		rcvwin += (grow << 1);
 
-		rcvmem = SKB_TRUESIZE(tp->advmss + MAX_TCP_HEADER);
-		while (tcp_win_from_space(sk, rcvmem) < tp->advmss)
-			rcvmem += 128;
-
-		do_div(rcvwin, tp->advmss);
-		rcvbuf = min_t(u64, rcvwin * rcvmem,
+		rcvbuf = min_t(u64, tcp_space_from_win(sk, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 		if (rcvbuf > sk->sk_rcvbuf) {
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
-- 
2.41.0.255.g8b1d071c50-goog



Return-Path: <netdev+bounces-202342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B6EAED69C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C0677A762B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72317238C05;
	Mon, 30 Jun 2025 08:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1EF4A23;
	Mon, 30 Jun 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270718; cv=none; b=l+cMbCWY//n2TtKreZkmDn/wp2WofrYZK/mJ3H0/2zm9q2GQBEPYB5ZmsF4oZ8Ur26KZCu4+EwSGMa8W9vIt70cwbcPfDDp8uZxA6sFEFOdsVfFYpYR8icJDKZlMsL6Febt/MC9wEZ98jyzS0AjePmH3v1NpO1pY7MxL/u+7T5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270718; c=relaxed/simple;
	bh=UnDG+RGaC/E/rcaTg09jRcXzVPbJxQYBm4gVZR4+/hs=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=eG8+2AyeJnmkxxlF2M3st0JEo5DOYGSfVUA63AE0b2qxKQNFxglI1DIwxZZXuEejuWQOu0yAAtuuk8qFIuJL0SjGR+lPijJJxnTLaW67IXy4B3KhaHOTP1day5NZCx+oVuEas0Y3iIz7aMy3qHBGRIH054IHKn3w6oi+iJOOv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bVzGv4TZ7z5F2lr;
	Mon, 30 Jun 2025 16:05:11 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 55U84mDn044609;
	Mon, 30 Jun 2025 16:04:48 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 30 Jun 2025 16:04:50 +0800 (CST)
Date: Mon, 30 Jun 2025 16:04:50 +0800 (CST)
X-Zmail-TransId: 2afb68624522ffffffffe3f-35612
X-Mailer: Zmail v1.0
Message-ID: <2025063016045077919B2mfJO_YO81tg6CKfHY@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
        <ncardwell@google.com>, <davem@davemloft.net>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <jiang.kun2@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0XSB0Y3A6IGFkZCByZXRyYW5zbWlzc2lvbiBxdWl0IHJlYXNvbnMgdG8gdHJhY2Vwb2ludA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55U84mDn044609
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68624537.000/4bVzGv4TZ7z5F2lr

From: Fan Yu <fan.yu9@zte.com.cn>

Problem
=======
When TCP retransmits a packet due to missing ACKs, the retransmission
may fail for various reasons (e.g., packets stuck in driver queues,
sequence errors, or routing issues). Currently, these failure reasons
are internally handled in __tcp_retransmit_skb() but lack visibility to
userspace, which makes it difficult to diagnose retransmission failures in
production environments.

Solution
=======
This patch adds a reason field to the tcp_retransmit_skb tracepoint,
enumerating with explicit failure cases:
TCP_RETRANS_IN_HOST_QUEUE	   (packet still queued in driver)
TCP_RETRANS_END_SEQ_ERROR	   (invalid end sequence)
TCP_RETRANS_TRIM_HEAD_NOMEM	 (trim head no memory)
TCP_RETRANS_UNCLONE_NOMEM    (skb unclone keeptruesize no memory)
TCP_RETRANS_FRAG_NOMEM       (fragment no memory)
TCP_RETRANS_ROUTE_FAIL       (routing failure)
TCP_RETRANS_RCV_ZERO_WINDOW  (closed recevier window)
TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
TCP_RETRANS_QUIT_UNDEFINED   (quit reason undefined)

Impact
======
1. Enables BPF programs to filter retransmission failures by reason.
2. Allows precise failure rate monitoring via ftrace.

Co-developed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 include/linux/tcp.h        | 13 +++++++++
 include/trace/events/tcp.h | 54 +++++++++++++++++++++++++-------------
 net/ipv4/tcp_output.c      | 52 ++++++++++++++++++++++++++----------
 3 files changed, 87 insertions(+), 32 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 29f59d50dc73..ca04d0e69b7b 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -530,6 +530,19 @@ enum tsq_flags {
 	TCPF_ACK_DEFERRED		= BIT(TCP_ACK_DEFERRED),
 };

+enum tcp_retransmit_quit_reason {
+	TCP_RETRANS_SUCCESS = 1,
+	TCP_RETRANS_IN_HOST_QUEUE,
+	TCP_RETRANS_END_SEQ_ERROR,
+	TCP_RETRANS_TRIM_HEAD_NOMEM,
+	TCP_RETRANS_UNCLONE_NOMEM,
+	TCP_RETRANS_FRAG_NOMEM,
+	TCP_RETRANS_ROUTE_FAIL,
+	TCP_RETRANS_RCV_ZERO_WINDOW,
+	TCP_RETRANS_PSKB_COPY_NOBUFS,
+	TCP_RETRANS_QUIT_UNDEFINED,
+};
+
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)

 /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket.
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 54e60c6009e3..530cfa9b23af 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -13,17 +13,38 @@
 #include <linux/sock_diag.h>
 #include <net/rstreason.h>

-/*
- * tcp event with arguments sk and skb
- *
- * Note: this class requires a valid sk pointer; while skb pointer could
- *       be NULL.
- */
-DECLARE_EVENT_CLASS(tcp_event_sk_skb,
+#define TCP_RETRANSMIT_QUIT_REASON		\
+		ENUM(TCP_RETRANS_SUCCESS,		"retransmit successfully")		\
+		ENUM(TCP_RETRANS_IN_HOST_QUEUE,		"packet still queued in driver")	\
+		ENUM(TCP_RETRANS_END_SEQ_ERROR,		"invalid end sequence")			\
+		ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,	"trim head no memory")			\
+		ENUM(TCP_RETRANS_UNCLONE_NOMEM,		"skb unclone keeptruesize no memory")	\
+		ENUM(TCP_RETRANS_FRAG_NOMEM,		"fragment no memory")			\
+		ENUM(TCP_RETRANS_ROUTE_FAIL,		"routing failure")			\
+		ENUM(TCP_RETRANS_RCV_ZERO_WINDOW,	"closed recevier window")		\
+		ENUM(TCP_RETRANS_PSKB_COPY_NOBUFS,	"no buffer for skb copy")		\
+		ENUMe(TCP_RETRANS_QUIT_UNDEFINED,	"quit reason undefined")
+
+/* Redefine for export. */
+#undef ENUM
+#undef ENUMe
+#define ENUM(a, b)	TRACE_DEFINE_ENUM(a);
+#define ENUMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+TCP_RETRANSMIT_QUIT_REASON
+
+/* Redefine for symbolic printing. */
+#undef ENUM
+#undef ENUMe
+#define ENUM(a, b)	{ a, b },
+#define ENUMe(a, b)	{ a, b }
+
+TRACE_EVENT(tcp_retransmit_skb,

-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		enum tcp_retransmit_quit_reason quit_reason),

-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, quit_reason),

 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
@@ -36,6 +57,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
 		__array(__u8, daddr_v6, 16)
+		__field(enum tcp_retransmit_quit_reason, quit_reason)
 	),

 	TP_fast_assign(
@@ -58,21 +80,17 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,

 		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->quit_reason = quit_reason;
 	),

-	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s quit_reason=%s",
 		  __entry->skbaddr, __entry->skaddr,
 		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport, __entry->saddr, __entry->daddr,
 		  __entry->saddr_v6, __entry->daddr_v6,
-		  show_tcp_state_name(__entry->state))
-);
-
-DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
-
-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
-
-	TP_ARGS(sk, skb)
+		  show_tcp_state_name(__entry->state),
+		  __print_symbolic(__entry->quit_reason, TCP_RETRANSMIT_QUIT_REASON))
 );

 #undef FN
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..6038661689e2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3326,6 +3326,7 @@ static void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to,
  */
 int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 {
+	enum tcp_retransmit_quit_reason reason = TCP_RETRANS_QUIT_UNDEFINED;
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int cur_mss;
@@ -3336,8 +3337,11 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (icsk->icsk_mtup.probe_size)
 		icsk->icsk_mtup.probe_size = 0;

-	if (skb_still_in_host_queue(sk, skb))
-		return -EBUSY;
+	if (skb_still_in_host_queue(sk, skb)) {
+		reason = TCP_RETRANS_IN_HOST_QUEUE;
+		err = -EBUSY;
+		goto out;
+	}

 start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
@@ -3348,14 +3352,22 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
-			return -EINVAL;
+			reason = TCP_RETRANS_END_SEQ_ERROR;
+			err = -EINVAL;
+			goto out;
+		}
+		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq)) {
+			reason = TCP_RETRANS_TRIM_HEAD_NOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
-		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
-			return -ENOMEM;
 	}

-	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
-		return -EHOSTUNREACH; /* Routing failure or similar. */
+	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
+		reason = TCP_RETRANS_ROUTE_FAIL;
+		err = -EHOSTUNREACH; /* Routing failure or similar. */
+		goto out;
+	}

 	cur_mss = tcp_current_mss(sk);
 	avail_wnd = tcp_wnd_end(tp) - TCP_SKB_CB(skb)->seq;
@@ -3366,8 +3378,11 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	 * our retransmit of one segment serves as a zero window probe.
 	 */
 	if (avail_wnd <= 0) {
-		if (TCP_SKB_CB(skb)->seq != tp->snd_una)
-			return -EAGAIN;
+		if (TCP_SKB_CB(skb)->seq != tp->snd_una) {
+			reason = TCP_RETRANS_RCV_ZERO_WINDOW;
+			err = -EAGAIN;
+			goto out;
+		}
 		avail_wnd = cur_mss;
 	}

@@ -3379,11 +3394,17 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	}
 	if (skb->len > len) {
 		if (tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len,
-				 cur_mss, GFP_ATOMIC))
-			return -ENOMEM; /* We'll try again later. */
+				 cur_mss, GFP_ATOMIC)) {
+			reason = TCP_RETRANS_FRAG_NOMEM;
+			err = -ENOMEM;  /* We'll try again later. */
+			goto out;
+		}
 	} else {
-		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
-			return -ENOMEM;
+		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC)) {
+			reason = TCP_RETRANS_UNCLONE_NOMEM;
+			err = -ENOMEM;
+			goto out;
+		}

 		diff = tcp_skb_pcount(skb);
 		tcp_set_skb_tso_segs(skb, cur_mss);
@@ -3421,6 +3442,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				nskb->dev = NULL;
 				err = tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC);
 			} else {
+				reason = TCP_RETRANS_PSKB_COPY_NOBUFS;
 				err = -ENOBUFS;
 			}
 		} tcp_skb_tsorted_restore(skb);
@@ -3438,7 +3460,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				  TCP_SKB_CB(skb)->seq, segs, err);

 	if (likely(!err)) {
-		trace_tcp_retransmit_skb(sk, skb);
+		reason = TCP_RETRANS_SUCCESS;
 	} else if (err != -EBUSY) {
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
 	}
@@ -3448,6 +3470,8 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	 */
 	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;

+out:
+	trace_tcp_retransmit_skb(sk, skb, reason);
 	return err;
 }

-- 
2.25.1


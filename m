Return-Path: <netdev+bounces-204547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA1AFB19C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCDF1664D1
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871E292B56;
	Mon,  7 Jul 2025 10:49:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592033993;
	Mon,  7 Jul 2025 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751885341; cv=none; b=RdxeJwgrJypNm2AB8C5II5NyIOjZaTWoxgbBG8XhxGgq3yNMTGpDIj+yDbq1Z4RPvyRGYlP4mKuPLRpamFjL1cag1DpVz+WLkCgvqVyY2LHcE8N9Tjsd4w4Owu+MQq9LlXzkgydXEQ5KswCQHZIU05ZI/7h9HmlAGhFaK0brTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751885341; c=relaxed/simple;
	bh=kgg/tgajn2cTprTpj6VqDUFp1WsHdCgdqmeFUWR+VPQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=aaFziE2ehCSxDrDl6kJ8GuM7nPrN5MlfvYUZ0ruUfN9dClrazhdwySF5CjT7KczhKTvW6aa05psgkwFWrpi40Z48QRprziQec1K0+hV1fJ4mMoO9Y9WPs9vQ+FrIi3aj1orRDPeK3Fe27GE2zlO+L8PeehCyObcT2/ihzXzJtX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bbLZR46ljz8RVFB;
	Mon,  7 Jul 2025 18:48:47 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 567AmFe8041933;
	Mon, 7 Jul 2025 18:48:15 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 7 Jul 2025 18:48:18 +0800 (CST)
Date: Mon, 7 Jul 2025 18:48:18 +0800 (CST)
X-Zmail-TransId: 2af9686ba5f2ffffffff991-ad308
X-Mailer: Zmail v1.0
Message-ID: <20250707184818342bR393AELVsx664C8wwNiK@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
        <ncardwell@google.com>, <davem@davemloft.net>, <horms@kernel.org>,
        <dsahern@kernel.org>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <fan.yu9@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHYzXSB0Y3A6IGV4dGVuZCB0Y3BfcmV0cmFuc21pdF9za2IgdHJhY2Vwb2ludCB3aXRoIGZhaWx1cmUgcmVhc29uc8KgwqA=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 567AmFe8041933
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 686BA60F.003/4bbLZR46ljz8RVFB

From: Fan Yu <fan.yu9@zte.com.cn>

Background
==========
When TCP retransmits a packet due to missing ACKs, the
retransmission may fail for various reasons (e.g., packets
stuck in driver queues, sequence errors, or routing issues).

The original tcp_retransmit_skb tracepoint:
'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
lacks visibility into these failure causes, making production
diagnostics difficult.

Solution
========
Adds a "result" field to the tcp_retransmit_skb tracepoint,
enumerating with explicit failure cases:
TCP_RETRANS_ERR_DEFAULT (retransmit terminate unexpectedly)
TCP_RETRANS_IN_HOST_QUEUE (packet still queued in driver)
TCP_RETRANS_END_SEQ_ERROR (invalid end sequence)
TCP_RETRANS_TRIM_HEAD_NOMEM (trim head no memory)
TCP_RETRANS_UNCLONE_NOMEM (skb unclone keeptruesize no memory)
TCP_RETRANS_FRAG_NOMEM (fragment no memory)
TCP_RETRANS_ROUTE_FAIL (routing failure)
TCP_RETRANS_RCV_ZERO_WINDOW (closed receiver window)
TCP_RETRANS_PSKB_COPY_NOBUFS (no buffer for skb copy)
Note: distinct "NOMEM" status pinpoint exact failure stages
in packet retransmission.

Functionality
=============
Enables users to know why some tcp retransmission failed and filter
retransmission failures by reason.

Compatibility description
=========================
This patch extends the tcp_retransmit_skb tracepoint
by adding a new "result" field at the end of its
existing structure (within TP_STRUCT__entry). The
compatibility implications are detailed as follows:

1) Structural compatibility for legacy user-space tools

Legacy tools/BPF programs accessing existing fields
(by offset or name) can still work without modification
or recompilation.The new field is appended to the end,
preserving original memory layout.

2) Note: semantic changes

The original tracepoint primarily only focused on
successfully retransmitted packets. With this patch,
the tracepoint now covers all packets that trigger
retransmission attempts, including those that may
terminate early due to specific reasons. For accurate
statistics, users should filter using "result" to
distinguish outcomes.

Before patched:
# cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
field:const void * skbaddr; offset:8; size:8; signed:0;
field:const void * skaddr; offset:16; size:8; signed:0;
field:int state; offset:24; size:4; signed:1;
field:__u16 sport; offset:28; size:2; signed:0;
field:__u16 dport; offset:30; size:2; signed:0;
field:__u16 family; offset:32; size:2; signed:0;
field:__u8 saddr[4]; offset:34; size:4; signed:0;
field:__u8 daddr[4]; offset:38; size:4; signed:0;
field:__u8 saddr_v6[16]; offset:42; size:16; signed:0;
field:__u8 daddr_v6[16]; offset:58; size:16; signed:0;
print fmt: "skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s"

After patched:
# cat /sys/kernel/debug/tracing/events/tcp/tcp_retransmit_skb/format
field:unsigned short common_type;       offset:0;       size:2; signed:0;
field:unsigned char common_flags;       offset:2;       size:1; signed:0;
field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
field:int common_pid;   offset:4;       size:4; signed:1;

field:const void * skbaddr;     offset:8;       size:8; signed:0;
field:const void * skaddr;      offset:16;      size:8; signed:0;
field:int state;        offset:24;      size:4; signed:1;
field:__u16 sport;      offset:28;      size:2; signed:0;
field:__u16 dport;      offset:30;      size:2; signed:0;
field:__u16 family;     offset:32;      size:2; signed:0;
field:__u8 saddr[4];    offset:34;      size:4; signed:0;
field:__u8 daddr[4];    offset:38;      size:4; signed:0;
field:__u8 saddr_v6[16];        offset:42;      size:16;        signed:0;
field:__u8 daddr_v6[16];        offset:58;      size:16;        signed:0;
field:enum tcp_retransmit_result result;        offset:76;      size:4; signed:0;

print fmt: "skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s result=%s"


Co-developed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
v2->v3

1) Rename "quit_reason" to "result"
Also, keep "key=val" format concise(no space in vals).

2) Reclaim necessity of different 'NOMEMORY' status
Distinct "NOMEM" status codes are necessary to pinpoint
exactly where memory allocation fails during packet
retransmission, rather than just reporting a generic
'out of memory' error.

 include/linux/tcp.h        | 13 +++++++++
 include/trace/events/tcp.h | 54 +++++++++++++++++++++++++-------------
 net/ipv4/tcp_output.c      | 52 ++++++++++++++++++++++++++----------
 3 files changed, 87 insertions(+), 32 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 29f59d50dc73..b48169332d85 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -530,6 +530,19 @@ enum tsq_flags {
 	TCPF_ACK_DEFERRED		= BIT(TCP_ACK_DEFERRED),
 };

+enum tcp_retransmit_result {
+	TCP_RETRANS_ERR_DEFAULT,
+	TCP_RETRANS_SUCCESS,
+	TCP_RETRANS_IN_HOST_QUEUE,
+	TCP_RETRANS_END_SEQ_ERROR,
+	TCP_RETRANS_TRIM_HEAD_NOMEM,
+	TCP_RETRANS_UNCLONE_NOMEM,
+	TCP_RETRANS_FRAG_NOMEM,
+	TCP_RETRANS_ROUTE_FAIL,
+	TCP_RETRANS_RCV_ZERO_WINDOW,
+	TCP_RETRANS_PSKB_COPY_NOBUFS,
+};
+
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)

 /* Variant of tcp_sk() upgrading a const sock to a read/write tcp socket.
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 54e60c6009e3..25014297fc0a 100644
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
+#define TCP_RETRANSMIT_RESULT		\
+		ENUM(TCP_RETRANS_ERR_DEFAULT,		"retrans_err_default")	\
+		ENUM(TCP_RETRANS_SUCCESS,		"retrans_succ")		\
+		ENUM(TCP_RETRANS_IN_HOST_QUEUE,		"packet_in_driver")	\
+		ENUM(TCP_RETRANS_END_SEQ_ERROR,		"end_seq_error")	\
+		ENUM(TCP_RETRANS_TRIM_HEAD_NOMEM,	"trim_head_nomem")	\
+		ENUM(TCP_RETRANS_UNCLONE_NOMEM,		"skb_unclone_nomem")	\
+		ENUM(TCP_RETRANS_FRAG_NOMEM,		"frag_nomem")		\
+		ENUM(TCP_RETRANS_ROUTE_FAIL,		"route_fail")		\
+		ENUM(TCP_RETRANS_RCV_ZERO_WINDOW,	"rcv_zero_window")	\
+		ENUMe(TCP_RETRANS_PSKB_COPY_NOBUFS,	"pskb_copy_nobufs")	\
+
+/* Redefine for export. */
+#undef ENUM
+#undef ENUMe
+#define ENUM(a, b)	TRACE_DEFINE_ENUM(a);
+#define ENUMe(a, b)	TRACE_DEFINE_ENUM(a);
+
+TCP_RETRANSMIT_RESULT
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
+		enum tcp_retransmit_result result),

-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, result),

 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
@@ -36,6 +57,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
 		__array(__u8, daddr_v6, 16)
+		__field(enum tcp_retransmit_result, result)
 	),

 	TP_fast_assign(
@@ -58,21 +80,17 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,

 		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->result = result;
 	),

-	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s result=%s",
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
+		  __print_symbolic(__entry->result, TCP_RETRANSMIT_RESULT))
 );

 #undef FN
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1f..f60e6b61ab63 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3326,6 +3326,7 @@ static void tcp_retrans_try_collapse(struct sock *sk, struct sk_buff *to,
  */
 int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 {
+	enum tcp_retransmit_result result = TCP_RETRANS_ERR_DEFAULT;
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned int cur_mss;
@@ -3336,8 +3337,11 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (icsk->icsk_mtup.probe_size)
 		icsk->icsk_mtup.probe_size = 0;

-	if (skb_still_in_host_queue(sk, skb))
-		return -EBUSY;
+	if (skb_still_in_host_queue(sk, skb)) {
+		result = TCP_RETRANS_IN_HOST_QUEUE;
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
+			result = TCP_RETRANS_END_SEQ_ERROR;
+			err = -EINVAL;
+			goto out;
+		}
+		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq)) {
+			result = TCP_RETRANS_TRIM_HEAD_NOMEM;
+			err = -ENOMEM;
+			goto out;
 		}
-		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
-			return -ENOMEM;
 	}

-	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
-		return -EHOSTUNREACH; /* Routing failure or similar. */
+	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
+		result = TCP_RETRANS_ROUTE_FAIL;
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
+			result = TCP_RETRANS_RCV_ZERO_WINDOW;
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
+			result = TCP_RETRANS_FRAG_NOMEM;
+			err = -ENOMEM;  /* We'll try again later. */
+			goto out;
+		}
 	} else {
-		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
-			return -ENOMEM;
+		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC)) {
+			result = TCP_RETRANS_UNCLONE_NOMEM;
+			err = -ENOMEM;
+			goto out;
+		}

 		diff = tcp_skb_pcount(skb);
 		tcp_set_skb_tso_segs(skb, cur_mss);
@@ -3421,6 +3442,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				nskb->dev = NULL;
 				err = tcp_transmit_skb(sk, nskb, 0, GFP_ATOMIC);
 			} else {
+				result = TCP_RETRANS_PSKB_COPY_NOBUFS;
 				err = -ENOBUFS;
 			}
 		} tcp_skb_tsorted_restore(skb);
@@ -3438,7 +3460,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				  TCP_SKB_CB(skb)->seq, segs, err);

 	if (likely(!err)) {
-		trace_tcp_retransmit_skb(sk, skb);
+		result = TCP_RETRANS_SUCCESS;
 	} else if (err != -EBUSY) {
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
 	}
@@ -3448,6 +3470,8 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	 */
 	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;

+out:
+	trace_tcp_retransmit_skb(sk, skb, result);
 	return err;
 }

-- 
2.25.


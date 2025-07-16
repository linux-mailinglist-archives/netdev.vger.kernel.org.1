Return-Path: <netdev+bounces-207346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B89B06B5D
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 04:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D043171AED
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C95D269811;
	Wed, 16 Jul 2025 02:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EE1581EE;
	Wed, 16 Jul 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752631226; cv=none; b=dPs9+gMcJbQQqGkS/YX30WNajD2CAZWKDBvNRXi6wxIED7RsVHbUztQNypWrRMb9mcrK5vUEXdLyQLTy3l0H8G2GwSjDVC8Vxa4nVTFAEpBz2eortNnQmslZBn/A7uQyAwqBNs8pQaa5QMtAhWxH6s/i6iFBEUm/iADgeHTbAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752631226; c=relaxed/simple;
	bh=UTPMJMXu3gVXw7OpSH5sp6TL7U+GSM+lvDW6DuVq6n0=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=acy3FZB5OKRSvrQua7id4STAdTKVTsflnwH3+SmIG7AhAj1kB7gxHStEhZaEn1ceJN8BnwgxkqCHFsbnuOIe00mckCYcxYL68WRjnw2RLa8g6OyaWZEYKabB3zqqmgyKAxBsGCYb2STUE6Wc9+Kh/a0broMOSRjqSLCsPr8PKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bhfQT5tphz8R03y;
	Wed, 16 Jul 2025 10:00:17 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 56G205DB001099;
	Wed, 16 Jul 2025 10:00:05 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 16 Jul 2025 10:00:06 +0800 (CST)
Date: Wed, 16 Jul 2025 10:00:06 +0800 (CST)
X-Zmail-TransId: 2afc687707a628c-d7b06
X-Mailer: Zmail v1.0
Message-ID: <20250716100006458kPWBPIJB6IdzWuUKlv4tF@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <kuba@kernel.org>, <edumazet@google.com>, <ncardwell@google.com>,
        <davem@davemloft.net>, <dsahern@kernel.org>, <pabeni@redhat.com>,
        <horms@kernel.org>, <kuniyu@google.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <jiang.kun2@zte.com.cn>, <qiu.yutan@zte.com.cn>,
        <wang.yaxin@zte.com.cn>, <he.peilin@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIG5ldC1uZXh0IHY2XSB0Y3A6IHRyYWNlIHJldHJhbnNtaXQgZmFpbHVyZXMgaW4gdGNwX3JldHJhbnNtaXRfc2ti?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56G205DB001099
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 687707B1.001/4bhfQT5tphz8R03y

From: Fan Yu <fan.yu9@zte.com.cn>

Background
==========
When TCP retransmits a packet due to missing ACKs, the
retransmission may fail for various reasons (e.g., packets
stuck in driver queues, receiver zero windows, or routing issues).

The original tcp_retransmit_skb tracepoint:

'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'

lacks visibility into these failure causes, making production
diagnostics difficult.

Solution
========
Adds the retval("err") to the tcp_retransmit_skb tracepoint.
Enables users to know why some tcp retransmission failed and
users can filter retransmission failures by retval.

Compatibility description
=========================
This patch extends the tcp_retransmit_skb tracepoint
by adding a new "err" field at the end of its
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
the tracepoint now can figure out packets that may
terminate early due to specific reasons. For accurate
statistics, users should filter using "err" to
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
field:int err; offset:76; size:4; signed:1;

print fmt: "skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s err=%d"

Suggested-by: KuniyukiIwashima <kuniyu@google.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Suggested-by: Eric Dumazet <edumazet@google.com>
Co-developed-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
Change Log
=========
v5->v6:
Some fixes according to
https://lore.kernel.org/all/20250715183335.860529-1-kuniyu@google.com/
1. fixed HTML entity conversion in email and adjusted error counting logic.

v4->v5:
Some fixes according to
https://lore.kernel.org/all/20250715072058.12f343bb@kernel.org/
1. Instead of introducing new TCP_RETRANS_* enums, directly
passing the retval to the tracepoint.

v3->v4:
Some fixes according to
https://lore.kernel.org/all/CANn89i+JGSt=_CtWfhDXypWW-34a6SoP3RAzWQ9B9VL4+PHjDw@mail.gmail.com/
1. Consolidate ENOMEMs into a unified TCP_RETRANS_NOMEM.

v2->v3:
Some fixes according to
https://lore.kernel.org/all/CANn89iJvyYjiweCESQL8E-Si7M=gosYvh1BAVWwAWycXW8GSdg@mail.gmail.com/
1. Rename "quit_reason" to "result". Also, keep "key=val" format concise(no space in vals).

v1->v2:
Some fixes according to
https://lore.kernel.org/all/CANn89iK-6kT-ZUpNRMjPY9_TkQj-dLuKrDQtvO1140q4EUsjFg@mail.gmail.com/
1.Rename TCP_RETRANS_QUIT_UNDEFINED to TCP_RETRANS_ERR_DEFAULT.
2.Added detailed compatibility consequences section.

 include/trace/events/tcp.h | 27 ++++++++--------------
 net/ipv4/tcp_output.c      | 46 ++++++++++++++++++++++++--------------
 2 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 54e60c6009e3..9d2c36c6a0ed 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -13,17 +13,11 @@
 #include <linux/sock_diag.h>
 #include <net/rstreason.h>

-/*
- * tcp event with arguments sk and skb
- *
- * Note: this class requires a valid sk pointer; while skb pointer could
- *       be NULL.
- */
-DECLARE_EVENT_CLASS(tcp_event_sk_skb,
+TRACE_EVENT(tcp_retransmit_skb,

-	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb, int err),

-	TP_ARGS(sk, skb),
+	TP_ARGS(sk, skb, err),

 	TP_STRUCT__entry(
 		__field(const void *, skbaddr)
@@ -36,6 +30,7 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,
 		__array(__u8, daddr, 4)
 		__array(__u8, saddr_v6, 16)
 		__array(__u8, daddr_v6, 16)
+		__field(int, err)
 	),

 	TP_fast_assign(
@@ -58,21 +53,17 @@ DECLARE_EVENT_CLASS(tcp_event_sk_skb,

 		TP_STORE_ADDRS(__entry, inet->inet_saddr, inet->inet_daddr,
 			      sk->sk_v6_rcv_saddr, sk->sk_v6_daddr);
+
+		__entry->err = err;
 	),

-	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s",
+	TP_printk("skbaddr=%p skaddr=%p family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c state=%s err=%d",
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
+		  __entry->err)
 );

 #undef FN
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b616776e3354..caf11920a878 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3330,8 +3330,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	if (icsk->icsk_mtup.probe_size)
 		icsk->icsk_mtup.probe_size = 0;

-	if (skb_still_in_host_queue(sk, skb))
-		return -EBUSY;
+	if (skb_still_in_host_queue(sk, skb)) {
+		err = -EBUSY;
+		goto out;
+	}

 start:
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
@@ -3342,14 +3344,19 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		}
 		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
 			WARN_ON_ONCE(1);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
+		}
+		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq)) {
+			err = -ENOMEM;
+			goto out;
 		}
-		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
-			return -ENOMEM;
 	}

-	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk))
-		return -EHOSTUNREACH; /* Routing failure or similar. */
+	if (inet_csk(sk)->icsk_af_ops->rebuild_header(sk)) {
+		err = -EHOSTUNREACH; /* Routing failure or similar. */
+		goto out;
+	}

 	cur_mss = tcp_current_mss(sk);
 	avail_wnd = tcp_wnd_end(tp) - TCP_SKB_CB(skb)->seq;
@@ -3360,8 +3367,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	 * our retransmit of one segment serves as a zero window probe.
 	 */
 	if (avail_wnd <= 0) {
-		if (TCP_SKB_CB(skb)->seq != tp->snd_una)
-			return -EAGAIN;
+		if (TCP_SKB_CB(skb)->seq != tp->snd_una) {
+			err = -EAGAIN;
+			goto out;
+		}
 		avail_wnd = cur_mss;
 	}

@@ -3373,11 +3382,15 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 	}
 	if (skb->len > len) {
 		if (tcp_fragment(sk, TCP_FRAG_IN_RTX_QUEUE, skb, len,
-				 cur_mss, GFP_ATOMIC))
-			return -ENOMEM; /* We'll try again later. */
+				 cur_mss, GFP_ATOMIC)) {
+			err = -ENOMEM;  /* We'll try again later. */
+			goto out;
+		}
 	} else {
-		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
-			return -ENOMEM;
+		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC)) {
+			err = -ENOMEM;
+			goto out;
+		}

 		diff = tcp_skb_pcount(skb);
 		tcp_set_skb_tso_segs(skb, cur_mss);
@@ -3431,17 +3444,16 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
 				  TCP_SKB_CB(skb)->seq, segs, err);

-	if (likely(!err)) {
-		trace_tcp_retransmit_skb(sk, skb);
-	} else if (err != -EBUSY) {
+	if (unlikely(err) && err != -EBUSY)
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPRETRANSFAIL, segs);
-	}

 	/* To avoid taking spuriously low RTT samples based on a timestamp
 	 * for a transmit that never happened, always mark EVER_RETRANS
 	 */
 	TCP_SKB_CB(skb)->sacked |= TCPCB_EVER_RETRANS;

+out:
+	trace_tcp_retransmit_skb(sk, skb, err);
 	return err;
 }

-- 
2.25.1


Return-Path: <netdev+bounces-43019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 560BE7D1002
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C9528243C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CF11A716;
	Fri, 20 Oct 2023 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QG2QFXRJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264D1A5BF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:03 +0000 (UTC)
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9997D52
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:59 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 6a1803df08f44-66cffe51b07so9928876d6.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806679; x=1698411479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YyLbbYLzNp5nrq8dHpNdkBkvl1SP5QTsaaqb8mwCJ78=;
        b=QG2QFXRJlM+xh/ey3gTPARj2IoPyAuSafTnbV5TotzLuE0ThV/gr2U4Y9yz1VKo1j0
         EnKiIDzhL21U5EXtxCx0V9XSucJRg86gmi2YTmX8HWb1uGcFDXUMe8wnb/E1svbU1orp
         azRm82kmrhTuartDybxq7UaqqB9WpJzGEPAO6UWyRdrtcBhVHJi2gyTdtQuWRy9emW7W
         pz5bk3NSAcWjy8PLMSw6c1R2LNPHeP3CoPbBOBHv+wxaq6I5ULD8MZc+cdyOLpX3lE6D
         E0Dp+/EU+FKxv6XSlbELx9A8F5tyNYYS836nLyiUauaLz3vBkmOpVaCf79mODNYWeKV2
         vucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806679; x=1698411479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyLbbYLzNp5nrq8dHpNdkBkvl1SP5QTsaaqb8mwCJ78=;
        b=D61YBZ/paOfc6VsutdmSWMbEGYEpf/XMUEMVvj43HFQS7465k/EK5vhio5/t1tlD1W
         x6iPp9a0h55n9dwZQCfY7t/HrkP3gsVd+zhjcRb1QJE+06lpSS0wYOHkEKL4iPDVa0RO
         UqSZF5/Py/DHHqgvBepE8AsM34yjYj6035X/nzf0VZWH75F5kGL54KpNs8t4RKL1gCCs
         fBDXSuFnfSuOUh3+yWmeTNRFiSyIRdErwgmu0MiZ8WRRBvgsOWzOJNzZlyyRWE9//8DK
         nkEtlZ3BTCChA3evIbCDLiBXDlS6Hm/P1H9DZEB3LS4CnHE7X87MbHupRxrROVD7mLgk
         JNUQ==
X-Gm-Message-State: AOJu0YwRzfN18vkgy7xvFmnu/1lBXMQPw0hzldU7QBWZrWPrpRsBaswC
	awdlOCg1hYYd/0CVwtSgmNE8fvq4iB9KWA==
X-Google-Smtp-Source: AGHT+IGG/m4CurYn4/FfdKNhYDnXeFtCFgmcDTIN/quPak4/NQ9g+xHqMPTT1yCvr1doETuXhVwORq9iiS+1Dg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:4a89:b0:66d:51f:c1a9 with SMTP
 id pi9-20020a0562144a8900b0066d051fc1a9mr38213qvb.9.1697806678824; Fri, 20
 Oct 2023 05:57:58 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:40 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-6-edumazet@google.com>
Subject: [PATCH net-next 05/13] tcp: replace tcp_time_stamp_raw()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation of usec TCP TS support, remove tcp_time_stamp_raw()
in favor of tcp_clock_ts() helper. This helper will return a suitable
32bit result to feed TS values, depending on a socket field.

Also add tcp_tw_tsval() and tcp_rsk_tsval() helpers to factorize
the details.

We do not yet support usec timestamps.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   | 25 +++++++++++++++++++------
 net/ipv4/tcp.c      |  4 ++--
 net/ipv4/tcp_ipv4.c |  4 ++--
 net/ipv6/tcp_ipv6.c |  4 ++--
 4 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3bdf1141f5a2c11e30ad85c68aafd062e7bf548c..0534526a535da7cee7d8d49fd556fe4d7a4eefb6 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -803,6 +803,16 @@ static inline u64 tcp_clock_ms(void)
 	return div_u64(tcp_clock_ns(), NSEC_PER_MSEC);
 }
 
+/* TCP Timestamp included in TS option (RFC 1323) can either use ms
+ * or usec resolution. Each socket carries a flag to select one or other
+ * resolution, as the route attribute could change anytime.
+ * Each flow must stick to initial resolution.
+ */
+static inline u32 tcp_clock_ts(bool usec_ts)
+{
+	return usec_ts ? tcp_clock_us() : tcp_clock_ms();
+}
+
 /* This should only be used in contexts where tp->tcp_mstamp is up to date */
 static inline u32 tcp_time_stamp(const struct tcp_sock *tp)
 {
@@ -820,12 +830,6 @@ static inline u64 tcp_ns_to_ts(u64 ns)
 	return div_u64(ns, NSEC_PER_SEC / TCP_TS_HZ);
 }
 
-/* Could use tcp_clock_us() / 1000, but this version uses a single divide */
-static inline u32 tcp_time_stamp_raw(void)
-{
-	return tcp_ns_to_ts(tcp_clock_ns());
-}
-
 void tcp_mstamp_refresh(struct tcp_sock *tp);
 
 static inline u32 tcp_stamp_us_delta(u64 t1, u64 t0)
@@ -844,6 +848,15 @@ static inline u64 tcp_skb_timestamp_us(const struct sk_buff *skb)
 	return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
 }
 
+static inline u32 tcp_tw_tsval(const struct tcp_timewait_sock *tcptw)
+{
+	return tcp_clock_ts(false) + tcptw->tw_ts_offset;
+}
+
+static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
+{
+	return tcp_clock_ts(false) + treq->ts_off;
+}
 
 #define tcp_flag_byte(th) (((u_int8_t *)th)[13])
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5b034b0356ecbd2b7d2dcafd9caac2b8de5886f1..805f8341064fec4fe0504e14c579185cfe11d896 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3632,7 +3632,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		if (!tp->repair)
 			err = -EPERM;
 		else
-			WRITE_ONCE(tp->tsoffset, val - tcp_time_stamp_raw());
+			WRITE_ONCE(tp->tsoffset, val - tcp_clock_ts(false));
 		break;
 	case TCP_REPAIR_WINDOW:
 		err = tcp_repair_set_window(tp, optval, optlen);
@@ -4143,7 +4143,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		break;
 
 	case TCP_TIMESTAMP:
-		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
+		val = tcp_clock_ts(false) + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
 		val = READ_ONCE(tp->notsent_lowat);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index a67a5de86253ba40e38154e81ffef11f68a55a3a..cdd65cc594bc4571fa5793bc14d6e9ab892dfd2a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -954,7 +954,7 @@ static void tcp_v4_timewait_ack(struct sock *sk, struct sk_buff *skb)
 	tcp_v4_send_ack(sk, skb,
 			tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
-			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
+			tcp_tw_tsval(tcptw),
 			tcptw->tw_ts_recent,
 			tw->tw_bound_dev_if,
 			tcp_twsk_md5_key(tcptw),
@@ -988,7 +988,7 @@ static void tcp_v4_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 	tcp_v4_send_ack(sk, skb, seq,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
-			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
+			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent),
 			0,
 			tcp_md5_do_lookup(sk, l3index, addr, AF_INET),
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d410703bb5a1e483848104e7e4cb379e45d7b216..1ee6517e9b2f9d549268dea240a725976a9e2720 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1096,7 +1096,7 @@ static void tcp_v6_timewait_ack(struct sock *sk, struct sk_buff *skb)
 
 	tcp_v6_send_ack(sk, skb, tcptw->tw_snd_nxt, tcptw->tw_rcv_nxt,
 			tcptw->tw_rcv_wnd >> tw->tw_rcv_wscale,
-			tcp_time_stamp_raw() + tcptw->tw_ts_offset,
+			tcp_tw_tsval(tcptw),
 			tcptw->tw_ts_recent, tw->tw_bound_dev_if, tcp_twsk_md5_key(tcptw),
 			tw->tw_tclass, cpu_to_be32(tw->tw_flowlabel), tw->tw_priority,
 			tw->tw_txhash);
@@ -1123,7 +1123,7 @@ static void tcp_v6_reqsk_send_ack(const struct sock *sk, struct sk_buff *skb,
 			tcp_rsk(req)->snt_isn + 1 : tcp_sk(sk)->snd_nxt,
 			tcp_rsk(req)->rcv_nxt,
 			req->rsk_rcv_wnd >> inet_rsk(req)->rcv_wscale,
-			tcp_time_stamp_raw() + tcp_rsk(req)->ts_off,
+			tcp_rsk_tsval(tcp_rsk(req)),
 			READ_ONCE(req->ts_recent), sk->sk_bound_dev_if,
 			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr, l3index),
 			ipv6_get_dsfield(ipv6_hdr(skb)), 0,
-- 
2.42.0.655.g421f12c284-goog



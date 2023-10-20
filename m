Return-Path: <netdev+bounces-43020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F637D1003
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB90A1C20E44
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DB21A72F;
	Fri, 20 Oct 2023 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sH+7V8U2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3F1A706
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 12:58:02 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3139F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ebc70d33so10900317b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697806680; x=1698411480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXlmdGoUA3/OHMacQpvAI4M9eHXnfU3t+DEkdejpF6c=;
        b=sH+7V8U2Xvys/LjlLvwBYYN3kirijXmQAemgwNqoCXTAitTjAY+RTElaHfY6xcH3fl
         8/JVVP1RFYMwRUVsBttZG2nzZ4oGWKI6KwrhJ5j5t2rPgyl7G4e52UG188jEA2QUC1if
         I/l73sCQCCvFoPAib+PO+uUjINeQ0v8FRY9hOxV/hAAt5GwYTVzUeOtmkpDt5tnTZckH
         mYwsUWVaUATQOwZvFtBYWn6E93ocUOlPKTYJHbyDWTwB/hWP7Yhps7oaw/IxEek8RI5U
         ab/FlceN15Fjfp4ne7XQfjHui0kL1qEhmXLibRe7qE5RadObHeaKMUsTgsXq/argXq7b
         Av2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806680; x=1698411480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YXlmdGoUA3/OHMacQpvAI4M9eHXnfU3t+DEkdejpF6c=;
        b=toiluOJ1w6NQrZpmCQCDH+v+TMryNkXVtbmIcPR3XxB2SI09BqE3Tu/HzeT8dX2br0
         KxJIo4qeDrUftG7PC3EF2q4S5o8aW7izfM7Yf8dB7qsMQnjk3G/pJB+tlW3Uf7UOxOod
         KkxBjEz8foV4dWhwa2I9FCZu486F1asup5U1MJb+QhnAbjkUkcEhXG7S1cXMybYQAzW2
         MoZdGsiSJJBJgt3fuTb9jm/ImGRhhKp2LHo5hKzqOZLBPpAhKwNSxugzVyufFBNumROQ
         sEOehOemVEjvnMAkwfUlkPoOijZKzYnVYyitZQ/65hLDGToVw5e5KgaXCcaey9IHx7X/
         SyDQ==
X-Gm-Message-State: AOJu0YxJ/UXPAfWDM369f3y6rMCFOSGQY8taUpz/Fia11PtHiQW5XxD+
	Rua1l3XliffZF3QXo/UWfRRUCRmJ7WFoyQ==
X-Google-Smtp-Source: AGHT+IHnNuhMMnBgVZjS6MOYxY9RGBswEJGspl2wv6c5Lf1W5YPIzh2LORVu2E/tjaTL9C9meP6Nj4Ydg5+Ncw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:d9a:6007:223a with SMTP
 id v3-20020a056902108300b00d9a6007223amr54369ybu.8.1697806680622; Fri, 20 Oct
 2023 05:58:00 -0700 (PDT)
Date: Fri, 20 Oct 2023 12:57:41 +0000
In-Reply-To: <20231020125748.122792-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231020125748.122792-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231020125748.122792-7-edumazet@google.com>
Subject: [PATCH net-next 06/13] tcp: rename tcp_skb_timestamp()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>, Kevin Yang <yyd@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Wei Wang <weiwan@google.com>, Van Jacobson <vanj@google.com>, 
	Florian Westphal <fw@strlen.de>, eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This helper returns a 32bit TCP TSval from skb->tstamp.

As we are going to support usec or ms units soon, rename it
to tcp_skb_timestamp_ts() and add a boolean to select the unit.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     | 14 +++++++++-----
 net/ipv4/tcp_input.c  |  2 +-
 net/ipv4/tcp_output.c |  8 ++++----
 net/ipv4/tcp_timer.c  |  4 ++--
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0534526a535da7cee7d8d49fd556fe4d7a4eefb6..493f8550055bca09b69a9d3129d6ba781a1233f8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -837,17 +837,21 @@ static inline u32 tcp_stamp_us_delta(u64 t1, u64 t0)
 	return max_t(s64, t1 - t0, 0);
 }
 
-static inline u32 tcp_skb_timestamp(const struct sk_buff *skb)
-{
-	return tcp_ns_to_ts(skb->skb_mstamp_ns);
-}
-
 /* provide the departure time in us unit */
 static inline u64 tcp_skb_timestamp_us(const struct sk_buff *skb)
 {
 	return div_u64(skb->skb_mstamp_ns, NSEC_PER_USEC);
 }
 
+/* Provide skb TSval in usec or ms unit */
+static inline u32 tcp_skb_timestamp_ts(bool usec_ts, const struct sk_buff *skb)
+{
+	if (usec_ts)
+		return tcp_skb_timestamp_us(skb);
+
+	return div_u64(skb->skb_mstamp_ns, NSEC_PER_MSEC);
+}
+
 static inline u32 tcp_tw_tsval(const struct tcp_timewait_sock *tcptw)
 {
 	return tcp_clock_ts(false) + tcptw->tw_ts_offset;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ffce17545b62c78595c5dd569665a6ebe6a29bbc..de68cad82d19e37171deadc45c5acc0cfd90c315 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2442,7 +2442,7 @@ static bool tcp_skb_spurious_retrans(const struct tcp_sock *tp,
 				     const struct sk_buff *skb)
 {
 	return (TCP_SKB_CB(skb)->sacked & TCPCB_RETRANS) &&
-	       tcp_tsopt_ecr_before(tp, tcp_skb_timestamp(skb));
+	       tcp_tsopt_ecr_before(tp, tcp_skb_timestamp_ts(false, skb));
 }
 
 /* Nothing was retransmitted or returned timestamp is less
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 909f85aefd7401aeffcd098356c5e3823bffd89e..03a2a9fc0dc191d7066d679913d41bd2ef2d685a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -799,7 +799,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 
 	if (likely(READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps) && !*md5)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = tcp_skb_timestamp(skb) + tp->tsoffset;
+		opts->tsval = tcp_skb_timestamp_ts(false, skb) + tp->tsoffset;
 		opts->tsecr = tp->rx_opt.ts_recent;
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -884,7 +884,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	}
 	if (likely(ireq->tstamp_ok)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
+		opts->tsval = tcp_skb_timestamp_ts(false, skb) + tcp_rsk(req)->ts_off;
 		opts->tsecr = READ_ONCE(req->ts_recent);
 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -943,7 +943,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (likely(tp->rx_opt.tstamp_ok)) {
 		opts->options |= OPTION_TS;
-		opts->tsval = skb ? tcp_skb_timestamp(skb) + tp->tsoffset : 0;
+		opts->tsval = skb ? tcp_skb_timestamp_ts(false, skb) + tp->tsoffset : 0;
 		opts->tsecr = tp->rx_opt.ts_recent;
 		size += TCPOLEN_TSTAMP_ALIGNED;
 	}
@@ -3379,7 +3379,7 @@ int tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 
 	/* Save stamp of the first (attempted) retransmit. */
 	if (!tp->retrans_stamp)
-		tp->retrans_stamp = tcp_skb_timestamp(skb);
+		tp->retrans_stamp = tcp_skb_timestamp_ts(false, skb);
 
 	if (tp->undo_retrans < 0)
 		tp->undo_retrans = 0;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 63247c78dc13d445c1e1c5cf24e7ffd7a1faa403..8764a9a2dc213f648ffc64f79950037b1f44ee99 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -479,7 +479,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 		return false;
 
 	rtx_delta = (u32)msecs_to_jiffies(tcp_time_stamp(tp) -
-			(tp->retrans_stamp ?: tcp_skb_timestamp(skb)));
+			(tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb)));
 
 	return rtx_delta > timeout;
 }
@@ -534,7 +534,7 @@ void tcp_retransmit_timer(struct sock *sk)
 		struct inet_sock *inet = inet_sk(sk);
 		u32 rtx_delta;
 
-		rtx_delta = tcp_time_stamp(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp(skb));
+		rtx_delta = tcp_time_stamp(tp) - (tp->retrans_stamp ?: tcp_skb_timestamp_ts(false, skb));
 		if (sk->sk_family == AF_INET) {
 			net_dbg_ratelimited("Probing zero-window on %pI4:%u/%u, seq=%u:%u, recv %ums ago, lasting %ums\n",
 				&inet->inet_daddr, ntohs(inet->inet_dport),
-- 
2.42.0.655.g421f12c284-goog



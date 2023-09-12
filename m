Return-Path: <netdev+bounces-33005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF88879C304
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 04:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16576280F59
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C2B651;
	Tue, 12 Sep 2023 02:33:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F109466
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:33:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D7421F9E
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e49935630so94752307b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694486026; x=1695090826; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUaEHyRiHirItH5KYX3gEZbeuXKBS3G+qJ9k23FCjNo=;
        b=jOhAZCg6rIztidC1b2H3W67ftlzlWWcajq/iIsy6tqc8B7BUw4w8yWjsmPROVL5Xcr
         GELpOEUwM7lxcaSKPoHaZyWTmZ3N/H6S3SaoPwMgMBvYuND+SjtyG0NdK2QCK2ya8T3S
         aASNW17KET21SN9RYr2hRXdFQsjnHoPc5mganvH69UoDPy9z1ULFz1xZjGZFeLRhsAEL
         x+ZRxaR641fXpHHTyB0zjGXY+xI5OvpeMOqt2ZDt73gTC0m0ImCoecslGE2Qeyik01rL
         /pu26KGplx0R0vPQFim1pSvNSxeugX9/l1FmdP6p0dmyJIVch6LjvVOj23WEJt99amHu
         QI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694486026; x=1695090826;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SUaEHyRiHirItH5KYX3gEZbeuXKBS3G+qJ9k23FCjNo=;
        b=efiqTaOwG9YyMisMteT7sTy1kqhTQvzsZUHpsGWzS3pV3Dca1F4h6B8QNZonInzkEA
         2mlDHVogprsiQDt1vBm5tZIKQIAgAXF37paHby83bhbEe48wMbjJic6XaPb/wVnNzNzD
         B9UdKwFKf17iz6UbxVPeXDcA3n2MrZVtJNHJVt2781Qm7W7biiPaS21E80IYexv8qqZr
         P7RYNX97Gz2L8hF5dGgz3eN/Oa3oCRAquEQQxGmtLQ4Ov2nlXTe+6ROqI4J86fNB43Ut
         u4tW3t4QZjwELz6A8s/O0cuaHCaOnDdlkvTNZH24lZkaB+nHMbJGZIT3dM0C84msKgoc
         Ttmw==
X-Gm-Message-State: AOJu0YzkwBxxXFSYgBLdF476E8QYtp1Pj1c+71riAwu8PgBAPZo6BMiw
	Oe+9ddkPUQazkQakASSNvZag6YDQOvRHlA==
X-Google-Smtp-Source: AGHT+IGqci35TX1srgDc9mdwBeK5NXnC819wMo9EBPYfndUs75HViZJCYsi6Bgxexx+Ek4hgkkbW+Jg+xJVZjg==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a81:b727:0:b0:586:e2b5:f364 with SMTP id
 v39-20020a81b727000000b00586e2b5f364mr36636ywh.4.1694486026357; Mon, 11 Sep
 2023 19:33:46 -0700 (PDT)
Date: Tue, 12 Sep 2023 02:33:09 +0000
In-Reply-To: <20230912023309.3013660-1-aananthv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230912023309.3013660-1-aananthv@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230912023309.3013660-3-aananthv@google.com>
Subject: [PATCH net-next 2/2] tcp: new TCP_INFO stats for RTO events
From: Aananth V <aananthv@google.com>
To: David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Aananth V <aananthv@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"

The 2023 SIGCOMM paper "Improving Network Availability with Protective
ReRoute" has indicated Linux TCP's RTO-triggered txhash rehashing can
effectively reduce application disruption during outages. To better
measure the efficacy of this feature, this patch adds three more
detailed stats during RTO recovery and exports via TCP_INFO.
Applications and monitoring systems can leverage this data to measure
the network path diversity and end-to-end repair latency during network
outages to improve their network infrastructure.

The following counters are added to tcp_sock in order to track RTO
events over the lifetime of a TCP socket.

1. u16 total_rto - Counts the total number of RTO timeouts.
2. u16 total_rto_recoveries - Counts the total number of RTO recoveries.
3. u32 total_rto_time - Counts the total time spent (ms) in RTO
                        recoveries. (time spent in CA_Loss and
                        CA_Recovery states)

To compute total_rto_time, we add a new u32 rto_stamp field to
tcp_sock. rto_stamp records the start timestamp (ms) of the last RTO
recovery (CA_Loss).

Corresponding fields are also added to the tcp_info struct.

Signed-off-by: Aananth V <aananthv@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h      |  8 ++++++++
 include/uapi/linux/tcp.h | 12 ++++++++++++
 net/ipv4/tcp.c           |  9 +++++++++
 net/ipv4/tcp_input.c     | 15 +++++++++++++++
 net/ipv4/tcp_minisocks.c |  4 ++++
 net/ipv4/tcp_timer.c     | 17 +++++++++++++++--
 6 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3c5efeeb024f..91731cd3bc3d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -377,6 +377,14 @@ struct tcp_sock {
 				 * Total data bytes retransmitted
 				 */
 	u32	total_retrans;	/* Total retransmits for entire connection */
+	u32	rto_stamp;	/* Start time (ms) of the last RTO recovery (CA_Loss) */
+	u16	total_rto;	/* Total number of RTO timeouts, including
+				 * SYN/SYN-ACK and recurring timeouts.
+				 */
+	u16	total_rto_recoveries;	/* Total number of RTO recoveries,
+					 * including any unfinished recovery.
+					 */
+	u32	total_rto_time;	/* ms spent in (completed) RTO recoveries. */
 
 	u32	urg_seq;	/* Seq of received urgent pointer */
 	unsigned int		keepalive_time;	  /* time before keep alive takes place */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 879eeb0a084b..d1d08da6331a 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -289,6 +289,18 @@ struct tcp_info {
 				      */
 
 	__u32   tcpi_rehash;         /* PLB or timeout triggered rehash attempts */
+
+	__u16	tcpi_total_rto;	/* Total number of RTO timeouts, including
+				 * SYN/SYN-ACK and recurring timeouts.
+				 */
+	__u16	tcpi_total_rto_recoveries;	/* Total number of RTO
+						 * recoveries, including any
+						 * unfinished recovery.
+						 */
+	__u32	tcpi_total_rto_time;	/* Total time spent in RTO recoveries
+					 * in milliseconds, including any
+					 * unfinished recovery.
+					 */
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c3040a63ebd..69b8d7073708 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3818,6 +3818,15 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	info->tcpi_rcv_wnd = tp->rcv_wnd;
 	info->tcpi_rehash = tp->plb_rehash + tp->timeout_rehash;
 	info->tcpi_fastopen_client_fail = tp->fastopen_client_fail;
+
+	info->tcpi_total_rto = tp->total_rto;
+	info->tcpi_total_rto_recoveries = tp->total_rto_recoveries;
+	info->tcpi_total_rto_time = tp->total_rto_time;
+	if (tp->rto_stamp) {
+		info->tcpi_total_rto_time += tcp_time_stamp_raw() -
+						tp->rto_stamp;
+	}
+
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(tcp_get_info);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index fe2ab0db2eb7..d04f501a7590 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2088,6 +2088,10 @@ void tcp_clear_retrans(struct tcp_sock *tp)
 	tp->undo_marker = 0;
 	tp->undo_retrans = -1;
 	tp->sacked_out = 0;
+	tp->rto_stamp = 0;
+	tp->total_rto = 0;
+	tp->total_rto_recoveries = 0;
+	tp->total_rto_time = 0;
 }
 
 static inline void tcp_init_undo(struct tcp_sock *tp)
@@ -2825,6 +2829,14 @@ void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 	tcp_set_ca_state(sk, TCP_CA_Recovery);
 }
 
+static inline void tcp_update_rto_time(struct tcp_sock *tp)
+{
+	if (tp->rto_stamp) {
+		tp->total_rto_time += tcp_time_stamp(tp) - tp->rto_stamp;
+		tp->rto_stamp = 0;
+	}
+}
+
 /* Process an ACK in CA_Loss state. Move to CA_Open if lost data are
  * recovered or spurious. Otherwise retransmits more on partial ACKs.
  */
@@ -3029,6 +3041,8 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		break;
 	case TCP_CA_Loss:
 		tcp_process_loss(sk, flag, num_dupack, rexmit);
+		if (icsk->icsk_ca_state != TCP_CA_Loss)
+			tcp_update_rto_time(tp);
 		tcp_identify_packet_loss(sk, ack_flag);
 		if (!(icsk->icsk_ca_state == TCP_CA_Open ||
 		      (*ack_flag & FLAG_LOST_RETRANS)))
@@ -6446,6 +6460,7 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 		tcp_try_undo_recovery(sk);
 
 	/* Reset rtx states to prevent spurious retransmits_timed_out() */
+	tcp_update_rto_time(tp);
 	tp->retrans_stamp = 0;
 	inet_csk(sk)->icsk_retransmits = 0;
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b98d476f1594..eee8ab1bfa0e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -565,6 +565,10 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 		newtp->undo_marker = treq->snt_isn;
 		newtp->retrans_stamp = div_u64(treq->snt_synack,
 					       USEC_PER_SEC / TCP_TS_HZ);
+		newtp->total_rto = req->num_timeout;
+		newtp->total_rto_recoveries = 1;
+		newtp->total_rto_time = tcp_time_stamp_raw() -
+						newtp->retrans_stamp;
 	}
 	newtp->tsoffset = treq->ts_off;
 #ifdef CONFIG_TCP_MD5SIG
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 984ab4a0421e..d630db3d899a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -415,6 +415,19 @@ abort:		tcp_write_err(sk);
 	}
 }
 
+static inline void tcp_update_rto_stats(struct sock *sk)
+{
+	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!icsk->icsk_retransmits) {
+		tp->total_rto_recoveries++;
+		tp->rto_stamp = tcp_time_stamp(tp);
+	}
+	icsk->icsk_retransmits++;
+	tp->total_rto++;
+}
+
 /*
  *	Timer for Fast Open socket to retransmit SYNACK. Note that the
  *	sk here is the child socket, not the parent (listener) socket.
@@ -447,7 +460,7 @@ static void tcp_fastopen_synack_timer(struct sock *sk, struct request_sock *req)
 	 */
 	inet_rtx_syn_ack(sk, req);
 	req->num_timeout++;
-	icsk->icsk_retransmits++;
+	tcp_update_rto_stats(sk);
 	if (!tp->retrans_stamp)
 		tp->retrans_stamp = tcp_time_stamp(tp);
 	inet_csk_reset_xmit_timer(sk, ICSK_TIME_RETRANS,
@@ -575,7 +588,7 @@ void tcp_retransmit_timer(struct sock *sk)
 
 	tcp_enter_loss(sk);
 
-	icsk->icsk_retransmits++;
+	tcp_update_rto_stats(sk);
 	if (tcp_retransmit_skb(sk, tcp_rtx_queue_head(sk), 1) > 0) {
 		/* Retransmission failed because of local congestion,
 		 * Let senders fight for local resources conservatively.
-- 
2.42.0.283.g2d96d420d3-goog



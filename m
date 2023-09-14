Return-Path: <netdev+bounces-33852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6297A0789
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA951C20445
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520728E11;
	Thu, 14 Sep 2023 14:37:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5128E09
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:37:45 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81CECC7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59b56dab74bso14993607b3.2
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694702264; x=1695307064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fmEl5FxKWeam6HJzkXdi3BJTmWF91ARVHvGYR9qoSU=;
        b=uKrSLhboCJ+vDNwVwj+5775h6ZQegmdZoKWrlTVMPz7VEKzEP8HDdDuImucyBeGy/i
         +co161e8FYrmfgsxjthElT28W2YKL8hTvIPnZqaAksZYHEO5nrLaeUw4VoDudlSVmsoS
         uTx1InjXU9rpZjdL7F8k788abJuRNW+pqxwUMzA+vNzPO4wbFXasXDbd5hVw7/Kovc86
         23D9Rz4f8WDvAET6TPKSWr67Hu0i3/EtMImwUmTMuA2shIinIdOZtH03VOrf937dc9Ey
         VFViR7PiwDW69L2hmJPgmJLwi+AFqRumrTkGLznPEVbVHJpKFgBXp0yCEHnW1T1zcTJ3
         e3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702264; x=1695307064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fmEl5FxKWeam6HJzkXdi3BJTmWF91ARVHvGYR9qoSU=;
        b=om4zdZjExLSGNGO/pk9mmSUny1LAHR7e6fHK5v8eOZEJvx21KD6wYTvv4woCBe+/4N
         K5Ep2QldzAaW+6pjK1UCb6Fk5VVBE1+SY1s1ikKdr4DePNLRIdEg0uR5ZuqUmfcaXuKA
         oNe7B3FaZYtJhPHGs/vbf49BMJa5+DrpIUS8PyjLIJEPUcs4IKyqyPMH9f5+cE0Nuxaq
         lcmDY0OL4dAVToOHkHEWoRSQjHSfO5XO726s+yy3Y+zOHuPVk0zgkJNcNZ5O0jwqzqjq
         3U6AlZgM8YwlS49k53Fjm4T0fcmDYkwuOsSefO6YPZjUH1txCwonYCyGD8nnX7tst+cA
         Mg2g==
X-Gm-Message-State: AOJu0YwSvMZvYTC/4N9s1rZEKkDIGm3M2ioNgXfT0rpi6YNICGn1nTVi
	eH47MoHZPBVUBS/DLmiCO1/D4YjXGVY/Rw==
X-Google-Smtp-Source: AGHT+IE9w+5HNtCLMOqVMry1poFx1pvja2FQsSJtv33ew3SbYvtS2qMCl79s2qJ6D88jOKHkjKArAmPQy6v3Kg==
X-Received: from aananthv.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:44a6])
 (user=aananthv job=sendgmr) by 2002:a05:690c:2513:b0:59b:eea4:a5a6 with SMTP
 id dt19-20020a05690c251300b0059beea4a5a6mr40431ywb.0.1694702264151; Thu, 14
 Sep 2023 07:37:44 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:36:21 +0000
In-Reply-To: <20230914143621.3858667-1-aananthv@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914143621.3858667-1-aananthv@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914143621.3858667-3-aananthv@google.com>
Subject: [PATCH net-next v2 2/2] tcp: new TCP_INFO stats for RTO events
From: Aananth V <aananthv@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Aananth V <aananthv@google.com>
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
index 3c5efeeb024f..9b371aa7c796 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -377,6 +377,14 @@ struct tcp_sock {
 				 * Total data bytes retransmitted
 				 */
 	u32	total_retrans;	/* Total retransmits for entire connection */
+	u32	rto_stamp;	/* Start time (ms) of last CA_Loss recovery */
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
index fe2ab0db2eb7..f199e0ca0786 100644
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
 
+static void tcp_update_rto_time(struct tcp_sock *tp)
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
index 984ab4a0421e..9e0c34175cfb 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -415,6 +415,19 @@ abort:		tcp_write_err(sk);
 	}
 }
 
+static void tcp_update_rto_stats(struct sock *sk)
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



Return-Path: <netdev+bounces-41647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B717CB81E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F6FB20FC8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0464402;
	Tue, 17 Oct 2023 01:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5y13iFC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E06747B
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:47:33 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F875D9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso7102683276.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697507251; x=1698112051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0/hq9ZIMkjWutRe3jEs9Bx8tuu9IBK4IuHRT+S2eTc=;
        b=z5y13iFCVShQUXmPoQ5cPGjKj1mcYt5h8eQJfZ250+siOeOIml9PT0clyL4wlljlo9
         mTkaJCNfGwj6Al+V8c9OF/1hyG+AysCBHpLg7FY1wP4pOO+Wp5BmScqh73YAyC+eXobB
         4LXJ2mN1x7V/o49/dF5ac/jnds3tNIu9/7FkprliQHWzFJlHbZELNSZ4c1doT4CAuOo6
         3E1zgj7p8aVuKMZIni5Q8MYELyDfpdgq1q6DNrAW+TmtUnrK0zsmtuMLTLxknl0hraAE
         knHkc5FLyeaymYKog3/6w8tALwvhH7bbVrm7P+Ff9xDaQ7LmdLGPZbmZHbt34Op0IP6r
         n+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507251; x=1698112051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0/hq9ZIMkjWutRe3jEs9Bx8tuu9IBK4IuHRT+S2eTc=;
        b=j8dlR+eVp6qcybHVecy0gGMj1hrgIH825tk6/PKOWnXE6uu2l7+VT9RERgRW0puBkH
         +rCkmwo1xBx/pUVE8Dzv8zStcKMF/r4StQMq/zUFjW3KK/2AWOv4FAOmDnZZKMuY2zIH
         H57RO7rlWEHxqDiVymHNvGgzkXOwXPIPZTHhUc6f4z+J/1lF96K43EkTw/Jw7KO0cMGc
         o2jD07fDZLgtGv0kGNZa/ow+KdYEPDSXP9nzsdzkJ5drOMfEq+MqwPGclETiSovePhMj
         ErW/UE0hvL87w+10PPbZDntX49JBTfDMFtBDGEbWhES78ua9rETLADbjRb0WVuYrOdBM
         X52Q==
X-Gm-Message-State: AOJu0Yx5XUIeyeXNGk1JgZ1XHNbWzle4DXHvVrBOwpNb/cO/E9gc/fEO
	/2JuWzmjzQDCom1aEhCd8sznk4CdXS+pGyc=
X-Google-Smtp-Source: AGHT+IESmAHFneRFrf0Fr2yoLah6HMDlcAdvQ5MQDvz6KKWU3eev/3Zt7rZex9CQhm76NwLuun4r+Y7eNeb+8YA=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:dc0f:0:b0:d9a:6658:1781 with SMTP id
 y15-20020a25dc0f000000b00d9a66581781mr14685ybe.10.1697507250826; Mon, 16 Oct
 2023 18:47:30 -0700 (PDT)
Date: Tue, 17 Oct 2023 01:47:16 +0000
In-Reply-To: <20231017014716.3944813-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017014716.3944813-6-lixiaoyan@google.com>
Subject: [PATCH v2 net-next 5/5] tcp: reorganize tcp_sock fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The variables are organized according in the following way:

- TX read-mostly hotpath cache lines
- TXRX read-mostly hotpath cache lines
- RX read-mostly hotpath cache lines
- TX read-write hotpath cache line
- TXRX read-write hotpath cache line
- RX read-write hotpath cache line

Fastpath cachelines end after rcvq_space.

Cache line boundaries are enfored only between read-mostly and
read-write. That is, if read-mostly tx cachelines bleed into
read-mostly txrx cachelines, we do not care. We care about the
boundaries between read and write cachelines because we want
to prevent false sharing.

Fast path variables span cache lines before change: 12
Fast path variables span cache lines after change: 8

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/linux/tcp.h | 238 +++++++++++++++++++++++---------------------
 1 file changed, 124 insertions(+), 114 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e15452df9804f..5195a0657997a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -175,23 +175,110 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 #define TCP_RMEM_TO_WIN_SCALE 8
 
 struct tcp_sock {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/tcp_sock.rst.
+	 * Please update the document when adding new fields.
+	 */
+
 	/* inet_connection_sock has to be the first member of tcp_sock */
 	struct inet_connection_sock	inet_conn;
-	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
+
+	/* TX read-mostly hotpath cache lines */
+	/* timestamp of last sent data packet (for restart window) */
+	u32	max_window;	/* Maximal window ever seen from peer	*/
+	u32	rcv_ssthresh;	/* Current window clamp			*/
+	u32	reordering;	/* Packet reordering metric.		*/
+	u32	notsent_lowat;	/* TCP_NOTSENT_LOWAT */
 	u16	gso_segs;	/* Max number of segs per GSO packet	*/
+	/* from STCP, retrans queue hinting */
+	struct sk_buff *lost_skb_hint;
+	struct sk_buff *retransmit_skb_hint;
+
+	/* TXRX read-mostly hotpath cache lines */
+	u32	tsoffset;	/* timestamp offset */
+	u32	snd_wnd;	/* The window we expect to receive	*/
+	u32	mss_cache;	/* Cached effective mss, not including SACKS */
+	u32	snd_cwnd;	/* Sending congestion window		*/
+	u32	prr_out;	/* Total number of pkts sent during Recovery. */
+	u32	lost_out;	/* Lost packets			*/
+	u32	sacked_out;	/* SACK'd packets			*/
+	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
+	u8	chrono_type : 2,	/* current chronograph type */
+		repair      : 1,
+		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
+		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
+
+	/* RX read-mostly hotpath cache lines */
+	u32	copied_seq;	/* Head of yet unread data */
+	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
+	u32	snd_wl1;	/* Sequence for window update		*/
+	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
+	u32	rttvar_us;	/* smoothed mdev_max			*/
+	u32	retrans_out;	/* Retransmitted packets out		*/
+	u16	advmss;		/* Advertised MSS			*/
+	u16	urg_data;	/* Saved octet of OOB data and control flags */
+	u32	lost;		/* Total data packets lost incl. rexmits */
+	struct  minmax rtt_min;
+	/* OOO segments go in this rbtree. Socket lock must be held. */
+	struct rb_root	out_of_order_queue;
+	u32	snd_ssthresh;	/* Slow start size threshold		*/
 
+	/* TX read-write hotpath cache lines */
+	u32	segs_out ____cacheline_aligned;	/* RFC4898 tcpEStatsPerfSegsOut
+				 * The total number of segments sent.
+				 */
+	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
+				 * total number of data segments sent.
+				 */
+	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
+				 * total number of data bytes sent.
+				 */
+	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
+	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
+	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
+	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
+	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
+	u32	lsndtime;
+	u32	mdev_us;	/* medium deviation			*/
+	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
+	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
+	u64	tcp_mstamp;	/* most recent packet received/sent */
+	u32	rtt_seq;	/* sequence number to update rttvar	*/
+	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
+	struct sk_buff *highest_sack;   /* skb just after the highest
+					 * skb with SACKed bit set
+					 * (validity guaranteed only if
+					 * sacked_out > 0)
+					 */
+	u8	ecn_flags;	/* ECN status bits.			*/
+
+	/* TXRX read-write hotpath cache lines */
 /*
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
 	__be32	pred_flags;
-
+	u32	rcv_nxt;	/* What we want to receive next 	*/
+	u32	snd_nxt;	/* Next sequence we send		*/
+	u32	snd_una;	/* First byte we want an ack for	*/
+	u32	window_clamp;	/* Maximal window to advertise		*/
+	u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
+	u32	packets_out;	/* Packets which are "in flight"	*/
+	u32	snd_up;		/* Urgent pointer		*/
+	u32	delivered;	/* Total data packets delivered incl. rexmits */
+	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	app_limited;	/* limited until "delivered" reaches this val */
+	u32	rcv_wnd;	/* Current receiver window		*/
 /*
- *	RFC793 variables by their proper names. This means you can
- *	read the code and the spec side by side (and laugh ...)
- *	See RFC793 and RFC1122. The RFC writes these in capitals.
+ *      Options received (usually on last packet, some only on SYN packets).
  */
-	u64	bytes_received;	/* RFC4898 tcpEStatsAppHCThruOctetsReceived
+	struct tcp_options_received rx_opt;
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+
+	/* RX read-write hotpath cache lines */
+	u64	bytes_received;
+				/* RFC4898 tcpEStatsAppHCThruOctetsReceived
 				 * sum(delta(rcv_nxt)), or how many bytes
 				 * were acked.
 				 */
@@ -201,45 +288,44 @@ struct tcp_sock {
 	u32	data_segs_in;	/* RFC4898 tcpEStatsPerfDataSegsIn
 				 * total number of data segments in.
 				 */
- 	u32	rcv_nxt;	/* What we want to receive next 	*/
-	u32	copied_seq;	/* Head of yet unread data		*/
 	u32	rcv_wup;	/* rcv_nxt on last window update sent	*/
- 	u32	snd_nxt;	/* Next sequence we send		*/
-	u32	segs_out;	/* RFC4898 tcpEStatsPerfSegsOut
-				 * The total number of segments sent.
-				 */
-	u32	data_segs_out;	/* RFC4898 tcpEStatsPerfDataSegsOut
-				 * total number of data segments sent.
-				 */
-	u64	bytes_sent;	/* RFC4898 tcpEStatsPerfHCDataOctetsOut
-				 * total number of data bytes sent.
-				 */
+	u32	max_packets_out;  /* max packets_out in last window */
+	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
+	u32	rate_delivered;    /* saved rate sample: packets delivered */
+	u32	rate_interval_us;  /* saved rate sample: time elapsed */
+	u32	rcv_rtt_last_tsecr;
+	u64	first_tx_mstamp;  /* start of window send phase */
+	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
 				 * sum(delta(snd_una)), or how many bytes
 				 * were acked.
 				 */
+	struct {
+		u32	rtt_us;
+		u32	seq;
+		u64	time;
+	} rcv_rtt_est;
+/* Receiver queue space */
+	struct {
+		u32	space;
+		u32	seq;
+		u64	time;
+	} rcvq_space;
+
+	/* End of Hot Path */
+
+/*
+ *	RFC793 variables by their proper names. This means you can
+ *	read the code and the spec side by side (and laugh ...)
+ *	See RFC793 and RFC1122. The RFC writes these in capitals.
+ */
 	u32	dsack_dups;	/* RFC4898 tcpEStatsStackDSACKDups
 				 * total number of DSACK blocks received
 				 */
- 	u32	snd_una;	/* First byte we want an ack for	*/
- 	u32	snd_sml;	/* Last byte of the most recently transmitted small packet */
-	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
-	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
 	u32	compressed_ack_rcv_nxt;
-
-	u32	tsoffset;	/* timestamp offset */
-
 	struct list_head tsq_node; /* anchor in tsq_tasklet.head list */
-	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
-
-	u32	snd_wl1;	/* Sequence for window update		*/
-	u32	snd_wnd;	/* The window we expect to receive	*/
-	u32	max_window;	/* Maximal window ever seen from peer	*/
-	u32	mss_cache;	/* Cached effective mss, not including SACKS */
 
-	u32	window_clamp;	/* Maximal window to advertise		*/
-	u32	rcv_ssthresh;	/* Current window clamp			*/
 	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	/* Information of the most recently (s)acked skb */
 	struct tcp_rack {
@@ -253,23 +339,16 @@ struct tcp_sock {
 		   dsack_seen:1, /* Whether DSACK seen after last adj */
 		   advanced:1;	 /* mstamp advanced since last lost marking */
 	} rack;
-	u16	advmss;		/* Advertised MSS			*/
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
 		unused:5;
-	u32	chrono_start;	/* Start time in jiffies of a TCP chrono */
-	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
-	u8	chrono_type:2,	/* current chronograph type */
-		rate_app_limited:1,  /* rate_{delivered,interval_us} limited? */
+
+	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
+		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
-		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
-		fastopen_client_fail:2; /* reason why fastopen failed */
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		thin_lto    : 1,/* Use linear timeouts for thin streams */
-		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
-		repair      : 1,
+		fastopen_client_fail:2, /* reason why fastopen failed */
 		frto        : 1;/* F-RTO (RFC5682) activated in CA_Loss */
 	u8	repair_queue;
 	u8	save_syn:2,	/* Save headers of SYN packet */
@@ -277,45 +356,19 @@ struct tcp_sock {
 		syn_fastopen:1,	/* SYN includes Fast Open option */
 		syn_fastopen_exp:1,/* SYN includes Fast Open exp. option */
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
-		syn_data_acked:1,/* data in SYN is acked by SYN-ACK */
-		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
-	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
+		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
 
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
-	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 
 /* RTT measurement */
-	u64	tcp_mstamp;	/* most recent packet received/sent */
-	u32	srtt_us;	/* smoothed round trip time << 3 in usecs */
-	u32	mdev_us;	/* medium deviation			*/
 	u32	mdev_max_us;	/* maximal mdev for the last rtt period	*/
-	u32	rttvar_us;	/* smoothed mdev_max			*/
-	u32	rtt_seq;	/* sequence number to update rttvar	*/
-	struct  minmax rtt_min;
 
-	u32	packets_out;	/* Packets which are "in flight"	*/
-	u32	retrans_out;	/* Retransmitted packets out		*/
-	u32	max_packets_out;  /* max packets_out in last window */
-	u32	cwnd_usage_seq;  /* right edge of cwnd usage tracking flight */
-
-	u16	urg_data;	/* Saved octet of OOB data and control flags */
-	u8	ecn_flags;	/* ECN status bits.			*/
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u32	reordering;	/* Packet reordering metric.		*/
 	u32	reord_seen;	/* number of data packet reordering events */
-	u32	snd_up;		/* Urgent pointer		*/
-
-/*
- *      Options received (usually on last packet, some only on SYN packets).
- */
-	struct tcp_options_received rx_opt;
 
 /*
  *	Slow start and congestion control (see also Nagle, and Karn & Partridge)
  */
- 	u32	snd_ssthresh;	/* Slow start size threshold		*/
- 	u32	snd_cwnd;	/* Sending congestion window		*/
 	u32	snd_cwnd_cnt;	/* Linear increase counter		*/
 	u32	snd_cwnd_clamp; /* Do not allow snd_cwnd to grow above this */
 	u32	snd_cwnd_used;
@@ -323,32 +376,10 @@ struct tcp_sock {
 	u32	prior_cwnd;	/* cwnd right before starting loss recovery */
 	u32	prr_delivered;	/* Number of newly delivered packets to
 				 * receiver in Recovery. */
-	u32	prr_out;	/* Total number of pkts sent during Recovery. */
-	u32	delivered;	/* Total data packets delivered incl. rexmits */
-	u32	delivered_ce;	/* Like the above but only ECE marked packets */
-	u32	lost;		/* Total data packets lost incl. rexmits */
-	u32	app_limited;	/* limited until "delivered" reaches this val */
-	u64	first_tx_mstamp;  /* start of window send phase */
-	u64	delivered_mstamp; /* time we reached "delivered" */
-	u32	rate_delivered;    /* saved rate sample: packets delivered */
-	u32	rate_interval_us;  /* saved rate sample: time elapsed */
-
- 	u32	rcv_wnd;	/* Current receiver window		*/
-	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
-	u32	notsent_lowat;	/* TCP_NOTSENT_LOWAT */
-	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
-	u32	lost_out;	/* Lost packets			*/
-	u32	sacked_out;	/* SACK'd packets			*/
 
 	struct hrtimer	pacing_timer;
 	struct hrtimer	compressed_ack_timer;
 
-	/* from STCP, retrans queue hinting */
-	struct sk_buff* lost_skb_hint;
-	struct sk_buff *retransmit_skb_hint;
-
-	/* OOO segments go in this rbtree. Socket lock must be held. */
-	struct rb_root	out_of_order_queue;
 	struct sk_buff	*ooo_last_skb; /* cache rb_last(out_of_order_queue) */
 
 	/* SACKs data, these 2 need to be together (see tcp_options_write) */
@@ -357,12 +388,6 @@ struct tcp_sock {
 
 	struct tcp_sack_block recv_sack_cache[4];
 
-	struct sk_buff *highest_sack;   /* skb just after the highest
-					 * skb with SACKed bit set
-					 * (validity guaranteed only if
-					 * sacked_out > 0)
-					 */
-
 	int     lost_cnt_hint;
 
 	u32	prior_ssthresh; /* ssthresh saved at recovery start	*/
@@ -413,21 +438,6 @@ struct tcp_sock {
 
 	u32 rcv_ooopack; /* Received out-of-order packets, for tcpinfo */
 
-/* Receiver side RTT estimation */
-	u32 rcv_rtt_last_tsecr;
-	struct {
-		u32	rtt_us;
-		u32	seq;
-		u64	time;
-	} rcv_rtt_est;
-
-/* Receiver queue space */
-	struct {
-		u32	space;
-		u32	seq;
-		u64	time;
-	} rcvq_space;
-
 /* TCP-specific MTU probe information. */
 	struct {
 		u32		  probe_seq_start;
-- 
2.42.0.655.g421f12c284-goog



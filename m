Return-Path: <netdev+bounces-32884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131A79AA70
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 19:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F5A2811F4
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12C156E8;
	Mon, 11 Sep 2023 17:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF8A156C6
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:06:07 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C818D
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so49917027b3.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694451964; x=1695056764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKKNWyps7l382fNgNn4c+Z/O2THi4IJe7Ne1FzDgSv4=;
        b=U8xGBQyz4u94w4RzXEywQak5RaATdJgaecjX3A4Ghr/iPyDC+HzSuhfE6p48G6x2m9
         uh/Jxgc7sfgoI3wjq3OZ9iqOtS6dUExObZUtPenLcJe/R1W4Qx+0wM0tTVev5yp6qlRN
         OBKYNd2CXI1zepSdDwtNRN/RZ9W6Aatwer0soUuJP7qdGCm4Q5edO63/66hDnODiPHmu
         6Ni4Uz2aMTtcSxu5iv3aAlDD0K+d21azMo1iGJ+2yPP7SsKb8nlyM0uGouEs/GEplDGm
         pLdYq5t6a+ZkD20HSOild+pT+QdjM4B5uqx3Eqdcgzk9yv7P4kaYYGrvej3+3zR2rFEe
         eawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694451964; x=1695056764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKKNWyps7l382fNgNn4c+Z/O2THi4IJe7Ne1FzDgSv4=;
        b=ul4XNVdlEV43mCVGlYYdit4/Qi5yYwEhZ1sh80lGu6EriLORIVkd5m1f4u4iPXILrW
         TF6wDDhHk+8aXYHipxY3iGtKVSX3eRg7qPedxBcUFUBQ7nKs/jJ8roXpefK4sp9xgxVn
         7CLJ3TncLh8702WEqFukW+RTAaU89+0fblX48Akx1oB6dWTVpCY4RQd+WoTMLl1aaern
         kmvxqKVChCVxxIUh754SmZI9HL1Cqi36m5KoVI2KnFBUoLJmG4BzoIS3S1vASVt/r+ig
         mJhIx5sL3N8khSE+Xd0f9IF0DIw8oZ+iBeTWUWA7NF19VJ3yykKjD+oDwmm+bxLey8pC
         jIxA==
X-Gm-Message-State: AOJu0YxNxiXUK7mBZNS7BuLfE7FEjirtjE8l+dsHj7Sw/k8AEQGh4Ocj
	Igo5/ElsF1Myny/7+/nvYSjy6u2XAie+gg==
X-Google-Smtp-Source: AGHT+IGayKlM4TTGUMCc+4Aazl1crhIJCZ18ZaVlcWyKSlhEjVdVAmOMlUlY77eaxrBrkd0GhZMkzNATBhrvxw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:c40b:0:b0:565:9bee:22e0 with SMTP id
 j11-20020a81c40b000000b005659bee22e0mr254033ywi.0.1694451964737; Mon, 11 Sep
 2023 10:06:04 -0700 (PDT)
Date: Mon, 11 Sep 2023 17:05:31 +0000
In-Reply-To: <20230911170531.828100-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230911170531.828100-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911170531.828100-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] tcp: defer regular ACK while processing socket backlog
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Dave Taht <dave.taht@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This idea came after a particular workload requested
the quickack attribute set on routes, and a performance
drop was noticed for large bulk transfers.

For high throughput flows, it is best to use one cpu
running the user thread issuing socket system calls,
and a separate cpu to process incoming packets from BH context.
(With TSO/GRO, bottleneck is usually the 'user' cpu)

Problem is the user thread can spend a lot of time while holding
the socket lock, forcing BH handler to queue most of incoming
packets in the socket backlog.

Whenever the user thread releases the socket lock, it must first
process all accumulated packets in the backlog, potentially
adding latency spikes. Due to flood mitigation, having too many
packets in the backlog increases chance of unexpected drops.

Backlog processing unfortunately shifts a fair amount of cpu cycles
from the BH cpu to the 'user' cpu, thus reducing max throughput.

This patch takes advantage of the backlog processing,
and the fact that ACK are mostly cumulative.

The idea is to detect we are in the backlog processing
and defer all eligible ACK into a single one,
sent from tcp_release_cb().

This saves cpu cycles on both sides, and network resources.

Performance of a single TCP flow on a 200Gbit NIC:

- Throughput is increased by 20% (100Gbit -> 120Gbit).
- Number of generated ACK per second shrinks from 240,000 to 40,000.
- Number of backlog drops per second shrinks from 230 to 0.

Benchmark context:
 - Regular netperf TCP_STREAM (no zerocopy)
 - Intel(R) Xeon(R) Platinum 8481C (Saphire Rapids)
 - MAX_SKB_FRAGS = 17 (~60KB per GRO packet)

This feature is guarded by a new sysctl, and enabled by default:
 /proc/sys/net/ipv4/tcp_backlog_ack_defer

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
---
 Documentation/networking/ip-sysctl.rst |  7 +++++++
 include/linux/tcp.h                    | 14 ++++++++------
 include/net/netns/ipv4.h               |  1 +
 net/ipv4/sysctl_net_ipv4.c             |  9 +++++++++
 net/ipv4/tcp_input.c                   |  8 ++++++++
 net/ipv4/tcp_ipv4.c                    |  1 +
 net/ipv4/tcp_output.c                  |  5 ++++-
 7 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a66054d0763a69d9e7cfae8e6242ac6d254e9169..5bfa1837968cee5eacafc77b216729b495bf65b8 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -745,6 +745,13 @@ tcp_comp_sack_nr - INTEGER
 
 	Default : 44
 
+tcp_backlog_ack_defer - BOOLEAN
+	If set, user thread processing socket backlog tries sending
+	one ACK for the whole queue. This helps to avoid potential
+	long latencies at end of a TCP socket syscall.
+
+	Default : true
+
 tcp_slow_start_after_idle - BOOLEAN
 	If set, provide RFC2861 behavior and time out the congestion
 	window after an idle period.  An idle period is defined at
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3c5efeeb024f651c90ae4a9ca704dcf16e4adb11..44d946161d4a7e52b05c196a1e1d37db25329650 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -463,15 +463,17 @@ enum tsq_enum {
 	TCP_MTU_REDUCED_DEFERRED,  /* tcp_v{4|6}_err() could not call
 				    * tcp_v{4|6}_mtu_reduced()
 				    */
+	TCP_ACK_DEFERRED,	   /* TX pure ack is deferred */
 };
 
 enum tsq_flags {
-	TSQF_THROTTLED			= (1UL << TSQ_THROTTLED),
-	TSQF_QUEUED			= (1UL << TSQ_QUEUED),
-	TCPF_TSQ_DEFERRED		= (1UL << TCP_TSQ_DEFERRED),
-	TCPF_WRITE_TIMER_DEFERRED	= (1UL << TCP_WRITE_TIMER_DEFERRED),
-	TCPF_DELACK_TIMER_DEFERRED	= (1UL << TCP_DELACK_TIMER_DEFERRED),
-	TCPF_MTU_REDUCED_DEFERRED	= (1UL << TCP_MTU_REDUCED_DEFERRED),
+	TSQF_THROTTLED			= BIT(TSQ_THROTTLED),
+	TSQF_QUEUED			= BIT(TSQ_QUEUED),
+	TCPF_TSQ_DEFERRED		= BIT(TCP_TSQ_DEFERRED),
+	TCPF_WRITE_TIMER_DEFERRED	= BIT(TCP_WRITE_TIMER_DEFERRED),
+	TCPF_DELACK_TIMER_DEFERRED	= BIT(TCP_DELACK_TIMER_DEFERRED),
+	TCPF_MTU_REDUCED_DEFERRED	= BIT(TCP_MTU_REDUCED_DEFERRED),
+	TCPF_ACK_DEFERRED		= BIT(TCP_ACK_DEFERRED),
 };
 
 #define tcp_sk(ptr) container_of_const(ptr, struct tcp_sock, inet_conn.icsk_inet.sk)
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 7a41c4791536732005cedbb80c223b86aa43249e..d96d05b0881973aafd064ffa9418a22038bbfbf4 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -132,6 +132,7 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_syncookies;
 	u8 sysctl_tcp_migrate_req;
 	u8 sysctl_tcp_comp_sack_nr;
+	u8 sysctl_tcp_backlog_ack_defer;
 	int sysctl_tcp_reordering;
 	u8 sysctl_tcp_retries1;
 	u8 sysctl_tcp_retries2;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 6ac890b4073f4583b0f98ee3294babb91bbcf482..e7f024d93572a6682ac951f9cb1debbaa0450443 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1366,6 +1366,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
 	},
+	{
+		.procname	= "tcp_backlog_ack_defer",
+		.data		= &init_net.ipv4.sysctl_tcp_backlog_ack_defer,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname       = "tcp_reflect_tos",
 		.data           = &init_net.ipv4.sysctl_tcp_reflect_tos,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 06fe1cf645d5a386331548484de2beb68e846404..41b471748437b646709158339bd6f79719661198 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5553,6 +5553,14 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 	    tcp_in_quickack_mode(sk) ||
 	    /* Protocol state mandates a one-time immediate ACK */
 	    inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOW) {
+		/* If we are running from __release_sock() in user context,
+		 * Defer the ack until tcp_release_cb().
+		 */
+		if (sock_owned_by_user_nocheck(sk) &&
+		    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_backlog_ack_defer)) {
+			set_bit(TCP_ACK_DEFERRED, &sk->sk_tsq_flags);
+			return;
+		}
 send_now:
 		tcp_send_ack(sk);
 		return;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 27140e5cdc060ddcdc8973759f68ed612a60617a..f13eb7e23d03f3681055257e6ebea0612ae3f9b3 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3263,6 +3263,7 @@ static int __net_init tcp_sk_init(struct net *net)
 	net->ipv4.sysctl_tcp_comp_sack_delay_ns = NSEC_PER_MSEC;
 	net->ipv4.sysctl_tcp_comp_sack_slack_ns = 100 * NSEC_PER_USEC;
 	net->ipv4.sysctl_tcp_comp_sack_nr = 44;
+	net->ipv4.sysctl_tcp_backlog_ack_defer = 1;
 	net->ipv4.sysctl_tcp_fastopen = TFO_CLIENT_ENABLE;
 	net->ipv4.sysctl_tcp_fastopen_blackhole_timeout = 0;
 	atomic_set(&net->ipv4.tfo_active_disable_times, 0);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b4cac12d0e6348aaa3a3957b0091ea7fe6553731..1fc1f879cfd6c28cd655bb8f02eff6624eec2ffc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1077,7 +1077,8 @@ static void tcp_tasklet_func(struct tasklet_struct *t)
 #define TCP_DEFERRED_ALL (TCPF_TSQ_DEFERRED |		\
 			  TCPF_WRITE_TIMER_DEFERRED |	\
 			  TCPF_DELACK_TIMER_DEFERRED |	\
-			  TCPF_MTU_REDUCED_DEFERRED)
+			  TCPF_MTU_REDUCED_DEFERRED |	\
+			  TCPF_ACK_DEFERRED)
 /**
  * tcp_release_cb - tcp release_sock() callback
  * @sk: socket
@@ -1114,6 +1115,8 @@ void tcp_release_cb(struct sock *sk)
 		inet_csk(sk)->icsk_af_ops->mtu_reduced(sk);
 		__sock_put(sk);
 	}
+	if ((flags & TCPF_ACK_DEFERRED) && inet_csk_ack_scheduled(sk))
+		tcp_send_ack(sk);
 }
 EXPORT_SYMBOL(tcp_release_cb);
 
-- 
2.42.0.283.g2d96d420d3-goog



Return-Path: <netdev+bounces-47528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2671C7EA6F9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1626D1C209DD
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4F63E46F;
	Mon, 13 Nov 2023 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDh0+Iut"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DD3E464
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:33:16 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7009D55
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so6115912276.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699918395; x=1700523195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U1eUbv+/QW4P9AkLnWnYmvlWdReUseo+zhfSxoG2Dlw=;
        b=GDh0+Iut+vleiOWcWvhDxVLEHs9v7DoPKvlWW7JKumahTJmD1j5822g3np2bNlBHAU
         VOEBtXliq2OTtXP1RpjX88P5KHZwg81flxvpnWqgNoCkvyQ2E+OAUKCd+ReszwvIjdy+
         qyuR8NTZPv8JnzfcOq4ZydCcE/s+rSHMa15b4cFxi29I2LgrxXoioU1QkfhAi9IYGLIY
         OvRo3Yqgo8aJwKRHbqZa0AdGvPtSSLJ3HiQuEczZCVmqPg458Rt49lC5GXRyY36aLjS9
         TcgpfBMqui57rVUlCS7U5pM5xn4I9uptzV7xvjZIEpFlaMz2g+44c7nGELMImxDH0LwG
         JKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918395; x=1700523195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1eUbv+/QW4P9AkLnWnYmvlWdReUseo+zhfSxoG2Dlw=;
        b=qaxHj4hSqauCVf2Xi/RJopGXHKkGPInwRS5BTCew7Agsj16b88x0dfZZSizM6U4cTS
         8G6qTNurJ+HhmWQgQDgV1XX4vkTOkJuvUog6+38kypZHuoPYNe7nKPY8JZUFD7DQPQMc
         YlP4ZqpXvKqOHdGeKmEDCuLvfPtTpxpG7lJsA5Q/4yHLbiyGABosyU1x46PrB30c6HrX
         5IVSzVGpm5ijfJrJr7HeDGcin7ZuQotUfQMFOwJLU3+hRn+t0TumfR5SD5+9UGgf+Har
         LADQXH8cnp/DwxKPnpRTAZM6v3IjkyF0KKbfdEMm1HBZYnbH/refM8S70vVzprXqWwI0
         F8og==
X-Gm-Message-State: AOJu0YzEUanP3TZqFISI/sZXIEnNHbGslyn49JbwAXo/RDHZHpSSvFy8
	4Q+RbinBjIDSJ4nJy8OPHhXesqm5uTI0G4o=
X-Google-Smtp-Source: AGHT+IGpApVLALIGFSut1Nd/rUgyGhsR/nO6sTDa57b9oU3Tzx+ZA5x0nyGJlQMULQ5UCUJYr7y481M5UAkJNc8=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a05:6902:302:b0:da0:567d:f819 with SMTP
 id b2-20020a056902030200b00da0567df819mr208330ybs.10.1699918394851; Mon, 13
 Nov 2023 15:33:14 -0800 (PST)
Date: Mon, 13 Nov 2023 23:32:59 +0000
In-Reply-To: <20231113233301.1020992-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231113233301.1020992-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231113233301.1020992-4-lixiaoyan@google.com>
Subject: [PATCH v7 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>, 
	David Ahern <dsahern@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Reorganize fast path variables on tx-txrx-rx order.
Fastpath cacheline ends after sysctl_tcp_rmem.
There are only read-only variables here. (write is on the control path
and not considered in this case)

Below data generated with pahole on x86 architecture.
Fast path variables span cache lines before change: 4
Fast path variables span cache lines after change: 2

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/netns/ipv4.h | 47 +++++++++++++++++++++++++++-------------
 net/core/net_namespace.c | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 15 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 73f43f6991999..ea882964c71ee 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -42,6 +42,38 @@ struct inet_timewait_death_row {
 struct tcp_fastopen_context;
 
 struct netns_ipv4 {
+	/* Cacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
+	 * Please update the document when adding new fields.
+	 */
+
+	/* TX readonly hotpath cache lines */
+	__cacheline_group_begin(netns_ipv4_read_tx);
+	u8 sysctl_tcp_early_retrans;
+	u8 sysctl_tcp_tso_win_divisor;
+	u8 sysctl_tcp_tso_rtt_log;
+	u8 sysctl_tcp_autocorking;
+	int sysctl_tcp_min_snd_mss;
+	unsigned int sysctl_tcp_notsent_lowat;
+	int sysctl_tcp_limit_output_bytes;
+	int sysctl_tcp_min_rtt_wlen;
+	int sysctl_tcp_wmem[3];
+	u8 sysctl_ip_fwd_use_pmtu;
+	__cacheline_group_end(netns_ipv4_read_tx);
+
+	/* TXRX readonly hotpath cache lines */
+	__cacheline_group_begin(netns_ipv4_read_txrx);
+	u8 sysctl_tcp_moderate_rcvbuf;
+	__cacheline_group_end(netns_ipv4_read_txrx);
+
+	/* RX readonly hotpath cache line */
+	__cacheline_group_begin(netns_ipv4_read_rx);
+	u8 sysctl_ip_early_demux;
+	u8 sysctl_tcp_early_demux;
+	int sysctl_tcp_reordering;
+	int sysctl_tcp_rmem[3];
+	__cacheline_group_end(netns_ipv4_read_rx);
+
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
@@ -96,17 +128,14 @@ struct netns_ipv4 {
 
 	u8 sysctl_ip_default_ttl;
 	u8 sysctl_ip_no_pmtu_disc;
-	u8 sysctl_ip_fwd_use_pmtu;
 	u8 sysctl_ip_fwd_update_priority;
 	u8 sysctl_ip_nonlocal_bind;
 	u8 sysctl_ip_autobind_reuse;
 	/* Shall we try to damage output packets if routing dev changes? */
 	u8 sysctl_ip_dynaddr;
-	u8 sysctl_ip_early_demux;
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	u8 sysctl_raw_l3mdev_accept;
 #endif
-	u8 sysctl_tcp_early_demux;
 	u8 sysctl_udp_early_demux;
 
 	u8 sysctl_nexthop_compat_mode;
@@ -119,7 +148,6 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
-	int sysctl_tcp_min_snd_mss;
 	int sysctl_tcp_probe_threshold;
 	u32 sysctl_tcp_probe_interval;
 
@@ -135,17 +163,14 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_backlog_ack_defer;
 	u8 sysctl_tcp_pingpong_thresh;
 
-	int sysctl_tcp_reordering;
 	u8 sysctl_tcp_retries1;
 	u8 sysctl_tcp_retries2;
 	u8 sysctl_tcp_orphan_retries;
 	u8 sysctl_tcp_tw_reuse;
 	int sysctl_tcp_fin_timeout;
-	unsigned int sysctl_tcp_notsent_lowat;
 	u8 sysctl_tcp_sack;
 	u8 sysctl_tcp_window_scaling;
 	u8 sysctl_tcp_timestamps;
-	u8 sysctl_tcp_early_retrans;
 	u8 sysctl_tcp_recovery;
 	u8 sysctl_tcp_thin_linear_timeouts;
 	u8 sysctl_tcp_slow_start_after_idle;
@@ -161,21 +186,13 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_frto;
 	u8 sysctl_tcp_nometrics_save;
 	u8 sysctl_tcp_no_ssthresh_metrics_save;
-	u8 sysctl_tcp_moderate_rcvbuf;
-	u8 sysctl_tcp_tso_win_divisor;
 	u8 sysctl_tcp_workaround_signed_windows;
-	int sysctl_tcp_limit_output_bytes;
 	int sysctl_tcp_challenge_ack_limit;
-	int sysctl_tcp_min_rtt_wlen;
 	u8 sysctl_tcp_min_tso_segs;
-	u8 sysctl_tcp_tso_rtt_log;
-	u8 sysctl_tcp_autocorking;
 	u8 sysctl_tcp_reflect_tos;
 	int sysctl_tcp_invalid_ratelimit;
 	int sysctl_tcp_pacing_ss_ratio;
 	int sysctl_tcp_pacing_ca_ratio;
-	int sysctl_tcp_wmem[3];
-	int sysctl_tcp_rmem[3];
 	unsigned int sysctl_tcp_child_ehash_entries;
 	unsigned long sysctl_tcp_comp_sack_delay_ns;
 	unsigned long sysctl_tcp_comp_sack_slack_ns;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f4183c4c1ec82..cb8bcbff9e83a 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -1099,11 +1099,56 @@ static void rtnl_net_notifyid(struct net *net, int cmd, int id, u32 portid,
 	rtnl_set_sk_err(net, RTNLGRP_NSID, err);
 }
 
+#ifdef CONFIG_NET_NS
+static void __init netns_ipv4_struct_check(void)
+{
+	/* TX readonly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_early_retrans);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_tso_win_divisor);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_tso_rtt_log);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_autocorking);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_min_snd_mss);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_notsent_lowat);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_limit_output_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_min_rtt_wlen);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_tcp_wmem);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_tx,
+				      sysctl_ip_fwd_use_pmtu);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_tx, 33);
+
+	/* TXRX readonly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_txrx,
+				      sysctl_tcp_moderate_rcvbuf);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_txrx, 1);
+
+	/* RX readonly hotpath cache line */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_ip_early_demux);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_early_demux);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_reordering);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read_rx,
+				      sysctl_tcp_rmem);
+	CACHELINE_ASSERT_GROUP_SIZE(struct netns_ipv4, netns_ipv4_read_rx, 18);
+}
+#endif
+
 void __init net_ns_init(void)
 {
 	struct net_generic *ng;
 
 #ifdef CONFIG_NET_NS
+	netns_ipv4_struct_check();
 	net_cachep = kmem_cache_create("net_namespace", sizeof(struct net),
 					SMP_CACHE_BYTES,
 					SLAB_PANIC|SLAB_ACCOUNT, NULL);
-- 
2.43.0.rc0.421.g78406f8d94-goog



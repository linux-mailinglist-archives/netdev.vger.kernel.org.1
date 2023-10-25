Return-Path: <netdev+bounces-44066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 418527D5F7A
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9AE1B21097
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0275315C1;
	Wed, 25 Oct 2023 01:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vdxn1rd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4A1FCE
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:24:25 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80347128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9cb79eb417so4841047276.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 18:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698197063; x=1698801863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2329PzFaDDHR/ezRbfC4cpjs4VFyXNZ4kS+DxEcbIfs=;
        b=0vdxn1rdvUueuwJSvFGgu2oIXWpjFDKlw3OfKzcChM+6F46DiS937c0e4vPCQRh1g1
         sjVkhbRb5H+WWm3fDNpQ0TE+C89liQASRQZtJESdyFHemXuyxssdH4zw7loZuAakYGsL
         UK43Vx6+9ZoiNFVaayXfefYWtKag+Lb9JgVREnJMLrQ9zEjCCbVoA2DWU0THkfAe1unQ
         u1SQRW+Au1b0fvm9KZ8arALCffwCoFvv6PBBmgrVB1L1Tp+o/aN/GuQgJbHDWp7bgQr6
         clrnFrosV0N+uue10zXThjR190zaZOdEGf6wRmyaSJFjo1TZ4fPTox36evprOvJf3mUR
         rDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698197063; x=1698801863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2329PzFaDDHR/ezRbfC4cpjs4VFyXNZ4kS+DxEcbIfs=;
        b=O+8aGDHWhMVy4S1dUFiJfBVvResq42TLaU2UhBB4Nq+NjGKMwBF0VqluRkIqLSdo2D
         CBwMnFB2s7Z/JcXLlLIni6F56BwcQ6K92NpzixNFRP0QFi96jHtgWwkdG9HClf4TDILk
         aL5maqGsbYKe1cUC14fDWBb9N5mKACYhV3Ft4oneSxp4qmSKV3JdH4cpdvGR4QE+n40g
         MRl6qQ0ELu7AveyogAEpnmMkp4MBz/G8N1IL7CjqHjusrpGgrZFMqnpggftHegsHXIhC
         apvu7fbD6a3L388UyY+OyUgotB23kS03fN8kFJGRD5pUFzWkKLr7QNwnLcFV+ljAl/VK
         /58g==
X-Gm-Message-State: AOJu0Yws0RU1Otl29ziCybKyE/bPVLBT23aLao19iJWNHfETsEZTCFuZ
	vLizfbiLL9Wc5QPybnrSymQU1m62CTqYuqk=
X-Google-Smtp-Source: AGHT+IEoETZvAfcYb/edHrc2MfLgsE202m2RTAUnr6U1+GWMUKu2qckuBQJDfmsgMiOz8t9Gqi6fRjZTy3ToIuI=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:d3d1:0:b0:d9a:6b0b:1bc8 with SMTP id
 e200-20020a25d3d1000000b00d9a6b0b1bc8mr273342ybf.11.1698197063719; Tue, 24
 Oct 2023 18:24:23 -0700 (PDT)
Date: Wed, 25 Oct 2023 01:24:09 +0000
In-Reply-To: <20231025012411.2096053-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025012411.2096053-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025012411.2096053-5-lixiaoyan@google.com>
Subject: [PATCH v3 net-next 4/6] netns-ipv4: reorganize netns_ipv4 fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Pradeep Nemavat <pnemavat@google.com>, Coco Li <lixiaoyan@google.com>, 
	David Ahern <dsahern@kernel.org>
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
 fs/proc/proc_net.c       | 39 ++++++++++++++++++++++++++++++++++++
 include/net/netns/ipv4.h | 43 ++++++++++++++++++++++++++--------------
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 2ba31b6d68c07..38846be34acd9 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -344,6 +344,43 @@ const struct file_operations proc_net_operations = {
 	.iterate_shared	= proc_tgid_net_readdir,
 };
 
+static void __init netns_ipv4_struct_check(void)
+{
+	/* TX readonly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_early_retrans);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_tso_win_divisor);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_tso_rtt_log);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_autocorking);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_min_snd_mss);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_notsent_lowat);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_limit_output_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_min_rtt_wlen);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_wmem);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_ip_fwd_use_pmtu);
+	/* TXRX readonly hotpath cache lines */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_moderate_rcvbuf);
+	/* RX readonly hotpath cache line */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_ip_early_demux);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_early_demux);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_reordering);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct netns_ipv4, netns_ipv4_read,
+				      sysctl_tcp_rmem);
+}
+
 static __net_init int proc_net_ns_init(struct net *net)
 {
 	struct proc_dir_entry *netd, *net_statd;
@@ -351,6 +388,8 @@ static __net_init int proc_net_ns_init(struct net *net)
 	kgid_t gid;
 	int err;
 
+	netns_ipv4_struct_check();
+
 	/*
 	 * This PDE acts only as an anchor for /proc/${pid}/net hierarchy.
 	 * Corresponding inode (PDE(inode) == net->proc_net) is never
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 73f43f6991999..03821b73ece70 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -42,6 +42,34 @@ struct inet_timewait_death_row {
 struct tcp_fastopen_context;
 
 struct netns_ipv4 {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
+	 * Please update the document when adding new fields.
+	 */
+
+	__cacheline_group_begin(netns_ipv4_read);
+	/* TX readonly hotpath cache lines */
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
+
+	/* TXRX readonly hotpath cache lines */
+	u8 sysctl_tcp_moderate_rcvbuf;
+
+	/* RX readonly hotpath cache line */
+	u8 sysctl_ip_early_demux;
+	u8 sysctl_tcp_early_demux;
+	int sysctl_tcp_reordering;
+	int sysctl_tcp_rmem[3];
+	__cacheline_group_end(netns_ipv4_read);
+
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
@@ -96,17 +124,14 @@ struct netns_ipv4 {
 
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
@@ -119,7 +144,6 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
-	int sysctl_tcp_min_snd_mss;
 	int sysctl_tcp_probe_threshold;
 	u32 sysctl_tcp_probe_interval;
 
@@ -135,17 +159,14 @@ struct netns_ipv4 {
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
@@ -161,21 +182,13 @@ struct netns_ipv4 {
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
-- 
2.42.0.758.gaed0368e0e-goog



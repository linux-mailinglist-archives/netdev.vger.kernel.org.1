Return-Path: <netdev+bounces-41644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2185E7CB81B
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 03:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC0B281615
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB34520FC;
	Tue, 17 Oct 2023 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1nMWhZo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBE33D82
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 01:47:29 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D85FB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a4cbdad3fso6652322276.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697507247; x=1698112047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBP2kA3jMhZH4dMZbaiYjMjp7HNsW49FUqFSJzZDsuI=;
        b=K1nMWhZou0gZYXZoeJnPd7VGGA36DL6NMMJdYqxtH8iMeO/h0+Ed0l4L85q23rMY6x
         3yXe/GiBnmcWKHm85KKGohDLGJX41iTl6tdaLjxVdGYnM+/m2G0fHCCokH2uuCgmj4uQ
         CSOwHi/UqZxM5c5Vb5AFwT43ZzF98NxUCqyxFDw3hfHpZVL5d8nBvvTw02WpS4xLMnP3
         sPJe2qBCocCWi7uPave0t0ElWQCLwb+2zosC/idCtbs3+V0+OQ6pxzSI0vCpZ69kcVep
         PCsh0dqTkKoTY1PWuqa2VikN2mV+mpQ6u2iBGZ1jmImuZt3SsdPyIdf09vEXJ8O7eMYI
         UXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697507247; x=1698112047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBP2kA3jMhZH4dMZbaiYjMjp7HNsW49FUqFSJzZDsuI=;
        b=E5Kn/m25twCNWsoSZKnudmip8f079v22prv8jH7dB5ib1pmmh2uZhqK+w+SEAyHyfr
         OdPrX5KQtQQSjhbuf2+/LFT765X2ylBEMgVBbX0bKD2SYsTAOTkrk4a/EZzHKGzWtXwx
         6ldR1tuRMwWENsx5gn8TQKJETbN/J/seROeGZMoZHLo18t7C/aFUKBlxYa6kQgPNcBrr
         O4YOWvu8LoCaBm7SGddaoLYY34MCXR/IRZ+7F8DXhTNnh2T5AOJ0mhtEtXMdKP8q/MwR
         pUpUR48Wh+x/lZz9vG7gY8jW7dyLtiFyMs63+zXGYpF/2NHGnvqajbSpvYmGe/Yam7s2
         35KA==
X-Gm-Message-State: AOJu0YyGrz4aFtsc1Pvh/iL64oZR13OMVwFQvwOqrm+3YWv3szwAcRPx
	1g2mhYgDCmwBJMbMfNMF1NV4DPIVBb6jJrE=
X-Google-Smtp-Source: AGHT+IEZ2819FWmhRUjcK/Y0ibC56gMmxKKr5nwazNFFkiCeIxltjAmtA2DpmpZzHz90eYr8YvGl7AyAJNRf8MY=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:b01:0:b0:d13:856b:c10a with SMTP id
 1-20020a250b01000000b00d13856bc10amr16470ybl.3.1697507247571; Mon, 16 Oct
 2023 18:47:27 -0700 (PDT)
Date: Tue, 17 Oct 2023 01:47:14 +0000
In-Reply-To: <20231017014716.3944813-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231017014716.3944813-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017014716.3944813-4-lixiaoyan@google.com>
Subject: [PATCH v2 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast path variables
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
 include/net/netns/ipv4.h | 41 +++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 73f43f6991999..809e8cef87f64 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -42,6 +42,32 @@ struct inet_timewait_death_row {
 struct tcp_fastopen_context;
 
 struct netns_ipv4 {
+	/* Caacheline organization can be found documented in
+	 * Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst.
+	 * Please update the document when adding new fields.
+	 */
+
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
+
 	struct inet_timewait_death_row tcp_death_row;
 	struct udp_table *udp_table;
 
@@ -96,17 +122,14 @@ struct netns_ipv4 {
 
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
@@ -119,7 +142,6 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
-	int sysctl_tcp_min_snd_mss;
 	int sysctl_tcp_probe_threshold;
 	u32 sysctl_tcp_probe_interval;
 
@@ -135,17 +157,14 @@ struct netns_ipv4 {
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
@@ -161,21 +180,13 @@ struct netns_ipv4 {
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
2.42.0.655.g421f12c284-goog



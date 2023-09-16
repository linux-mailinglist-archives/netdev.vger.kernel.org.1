Return-Path: <netdev+bounces-34211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D607A2CD5
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 03:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6024B1C20B9F
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 01:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212246BA;
	Sat, 16 Sep 2023 01:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E8020E4
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:06:35 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1599
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ea08906b3so3186226276.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694826393; x=1695431193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0bK6ULrtNX2DuCdsYiIZqeCSKJ2lyeHjtXdrDJF3wQ=;
        b=Tq8pTvc3zP9LWmK91t/CxCV7B52YsYYHhSFOOesw7w8Gt1HCYrd3XvKX6O3jhqyBXQ
         FhzhJMG3w9O+n3Md+D4a84C75uPYm3txfUIjW93FuExWaILEvE8A8JgYe4h1Skf0NTSk
         sgRM9cEJSSHcVziE2tnRwu1R55SEXnzNsnEM97jWwVFVIozdBMwhX4vYk7vDzWXuyc2G
         c5yIOGZHLCDyxZ5gYr3+dSVheUu9EJa7V7IljyDAIxZDiFTtWydc3FuCn6QOEfd9KbrG
         9+vFlPrpcRVHILyOzgghbDQ12MW+Ej8lDqGyYn/GONXtFNd+eC9ZU/5mbvhXdZxPTo69
         64PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826393; x=1695431193;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0bK6ULrtNX2DuCdsYiIZqeCSKJ2lyeHjtXdrDJF3wQ=;
        b=oo82ZI/u12CA/5pjU6wIgPMkOmwxPsEwvtX3H52pQ4xseJShjw3Xk7pXtGgk8Vq4mV
         K9Fq9W4+m4chrbbyx1D+BkevsJJdXltJ7yA14RWhr8UEEozj2AJDnittweAQzNrvhyRC
         ch+mgmXGpYg0TmNsSEOIXz9f3ka4tifNtny6r6tPnLJkOpl0/ET0Ru+cfTQ5xWIXnLre
         3msveVmp5KlxZ2O4vue3Pe4tLi35QYEZnGfYwjkrJoE5ZmSmhv9rFO0Lgd7Eij1NCXfk
         5c8Lqvcmn0cf0V76eAHzvxDBidRJ+zV8PtbxljgZMWrPVFJdPuDg9XK8pgTg2PQrJerB
         TxzQ==
X-Gm-Message-State: AOJu0YzKJrHLD/q1k+L/J6hjyUJzsZRsMAwtZsryjWfkaPtF1psT2NVQ
	GFvZfsYDqGuMj7a/l0/4d0k9wYkCsD3YqXw=
X-Google-Smtp-Source: AGHT+IEoMiDscVJtr3I3tMbXxeJW2uDJPqzhCJVubP5MFKrorQP008/xWg4YR/IIRmJA/z7R7tGF7bFK3RZJea4=
X-Received: from coco0920.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a23])
 (user=lixiaoyan job=sendgmr) by 2002:a25:add3:0:b0:d81:754a:7cbb with SMTP id
 d19-20020a25add3000000b00d81754a7cbbmr71762ybe.11.1694826393566; Fri, 15 Sep
 2023 18:06:33 -0700 (PDT)
Date: Sat, 16 Sep 2023 01:06:23 +0000
In-Reply-To: <20230916010625.2771731-1-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916010625.2771731-4-lixiaoyan@google.com>
Subject: [PATCH v1 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast path variables
From: Coco Li <lixiaoyan@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>, 
	Coco Li <lixiaoyan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reorganize fast path variables on tx-txrx-rx order.
Fastpath cacheline ends after sysctl_tcp_rmem.
There are only read-only variables here. (write is on the control path
and not considered in this case)

Below data generated with pahole on x86 architecture.

Fast path variables span cache lines before change: 4
Fast path variables span cache lines after change: 2

Tested:
Built and installed.

Signed-off-by: Coco Li <lixiaoyan@google.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
---
 include/net/netns/ipv4.h | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index d96d05b088197..41f5597aa01fd 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -42,6 +42,27 @@ struct inet_timewait_death_row {
 struct tcp_fastopen_context;
 
 struct netns_ipv4 {
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
 
@@ -96,17 +117,14 @@ struct netns_ipv4 {
 
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
@@ -119,7 +137,6 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_mtu_probing;
 	int sysctl_tcp_mtu_probe_floor;
 	int sysctl_tcp_base_mss;
-	int sysctl_tcp_min_snd_mss;
 	int sysctl_tcp_probe_threshold;
 	u32 sysctl_tcp_probe_interval;
 
@@ -133,17 +150,14 @@ struct netns_ipv4 {
 	u8 sysctl_tcp_migrate_req;
 	u8 sysctl_tcp_comp_sack_nr;
 	u8 sysctl_tcp_backlog_ack_defer;
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
@@ -159,21 +173,13 @@ struct netns_ipv4 {
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
2.42.0.459.ge4e396fd5e-goog



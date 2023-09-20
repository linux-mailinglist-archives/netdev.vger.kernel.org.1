Return-Path: <netdev+bounces-35320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E30F7A8DAF
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97395B207E4
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49FE405CF;
	Wed, 20 Sep 2023 20:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BE405C8
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:23 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B42DAB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bfccec7f3so3236927b3.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241040; x=1695845840; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTyV3qBKvPgtR6a3vBwMNMCjYmUClP8Mmq+rt3HAyTA=;
        b=uJqporbYYQiOICCRVN7RwcMS8rIXG6P1e4BsIuIiD3mFYXrb7TaDoV4af/WNDxqWXP
         XQQywN1ap9T51Vt+UXCUG08seBBJeYpmARHqGEiSkvmSmkqcmQkPU0WWN7MENPsrO8EL
         0xzdjD+YsJSyI0eIiHHKC72U3layg0LYu/3jYMer5Onjji7zqFk04Aw19FCqSp4Lx9Q1
         T9UqUXmpA5UkLfCk8xPMlgrPLIofgNognCRe615BZNonzN8iaid4vE+Nq9WsUPHAtPEc
         Q15yF8aUiMsdr/p4TVne9pMCGtTFfGxDFiBfnCfEcwyx2IotdF+OJBU1Xq47f8Heaa/4
         ATgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241040; x=1695845840;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTyV3qBKvPgtR6a3vBwMNMCjYmUClP8Mmq+rt3HAyTA=;
        b=a7WjhKlZ4fL4xh/2Fb9bIlCEP57oyEn1fe4mxfXnMrZkE/27fy10VsRWnZ+vfK0KSG
         vhW0n9WCQYRuH+pjxVXHvGorE/ulvHeiD5KVyvzioO1JohraYUOMUl996ixyQVck0S+Q
         exd72QchJt4ZYlzaCxotXo5uW1mlEJEQKgI1o+q1iAemBV5BHrH+kXyQJZfxA1W3WMu7
         2ISa7KuLKvyYT3WOhxgz4rJ3D6dIjFp2sT79dPTo7+onRWWAILTSMU1nutJFFCAWt3ua
         dn661pEe+hRV69jA02oqTbA5D/I8vvTKCymO/vcd0YNSMIkHBd6wNcI3n4iEobLz468l
         ZAcQ==
X-Gm-Message-State: AOJu0Yy+/d0/wN+fnF2i2YEFUZNgOp3GSsu2HxZdTe8FrXKqhk3uLu1u
	JWL3vYf/u99QPhgwsjsGsdH8B2mxrMhiVA==
X-Google-Smtp-Source: AGHT+IF3MdZ6X9o8BADtACsVvqVRK5zCGA1DPmHc/w6VfGl6I86/Kuj+DI4FhvfAThiwjSs1q5mEL7LWibbMeA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10ce:b0:d85:ac7a:a9a4 with SMTP
 id w14-20020a05690210ce00b00d85ac7aa9a4mr44409ybu.9.1695241040649; Wed, 20
 Sep 2023 13:17:20 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:12 +0000
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/5] net_sched: sch_fq: struct sched_data reorg
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

q->flows can be often modified, and q->timer_slack is read mostly.

Exchange the two fields, so that cache line countaining
quantum, initial_quantum, and other critical parameters
stay clean (read-mostly).

Move q->watchdog next to q->stat_throttled

Add comments explaining how the structure is split in
three different parts.

pahole output before the patch:

struct fq_sched_data {
	struct fq_flow_head        new_flows;            /*     0  0x10 */
	struct fq_flow_head        old_flows;            /*  0x10  0x10 */
	struct rb_root             delayed;              /*  0x20   0x8 */
	u64                        time_next_delayed_flow; /*  0x28   0x8 */
	u64                        ktime_cache;          /*  0x30   0x8 */
	unsigned long              unthrottle_latency_ns; /*  0x38   0x8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct fq_flow             internal __attribute__((__aligned__(64))); /*  0x40  0x80 */

	/* XXX last struct has 16 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) --- */
	u32                        quantum;              /*  0xc0   0x4 */
	u32                        initial_quantum;      /*  0xc4   0x4 */
	u32                        flow_refill_delay;    /*  0xc8   0x4 */
	u32                        flow_plimit;          /*  0xcc   0x4 */
	unsigned long              flow_max_rate;        /*  0xd0   0x8 */
	u64                        ce_threshold;         /*  0xd8   0x8 */
	u64                        horizon;              /*  0xe0   0x8 */
	u32                        orphan_mask;          /*  0xe8   0x4 */
	u32                        low_rate_threshold;   /*  0xec   0x4 */
	struct rb_root *           fq_root;              /*  0xf0   0x8 */
	u8                         rate_enable;          /*  0xf8   0x1 */
	u8                         fq_trees_log;         /*  0xf9   0x1 */
	u8                         horizon_drop;         /*  0xfa   0x1 */

	/* XXX 1 byte hole, try to pack */

<bad>	u32                        flows;                /*  0xfc   0x4 */
	/* --- cacheline 4 boundary (256 bytes) --- */
	u32                        inactive_flows;       /* 0x100   0x4 */
	u32                        throttled_flows;      /* 0x104   0x4 */
	u64                        stat_gc_flows;        /* 0x108   0x8 */
	u64                        stat_internal_packets; /* 0x110   0x8 */
	u64                        stat_throttled;       /* 0x118   0x8 */
	u64                        stat_ce_mark;         /* 0x120   0x8 */
	u64                        stat_horizon_drops;   /* 0x128   0x8 */
	u64                        stat_horizon_caps;    /* 0x130   0x8 */
	u64                        stat_flows_plimit;    /* 0x138   0x8 */
	/* --- cacheline 5 boundary (320 bytes) --- */
	u64                        stat_pkts_too_long;   /* 0x140   0x8 */
	u64                        stat_allocation_errors; /* 0x148   0x8 */
<bad>	u32                        timer_slack;          /* 0x150   0x4 */

	/* XXX 4 bytes hole, try to pack */

	struct qdisc_watchdog      watchdog;             /* 0x158  0x48 */

	/* size: 448, cachelines: 7, members: 34 */
	/* sum members: 411, holes: 2, sum holes: 5 */
	/* padding: 32 */
	/* paddings: 1, sum paddings: 16 */
	/* forced alignments: 1 */
};

pahole output after the patch:

struct fq_sched_data {
	struct fq_flow_head        new_flows;            /*     0  0x10 */
	struct fq_flow_head        old_flows;            /*  0x10  0x10 */
	struct rb_root             delayed;              /*  0x20   0x8 */
	u64                        time_next_delayed_flow; /*  0x28   0x8 */
	u64                        ktime_cache;          /*  0x30   0x8 */
	unsigned long              unthrottle_latency_ns; /*  0x38   0x8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct fq_flow             internal __attribute__((__aligned__(64))); /*  0x40  0x80 */

	/* XXX last struct has 16 bytes of padding */

	/* --- cacheline 3 boundary (192 bytes) --- */
	u32                        quantum;              /*  0xc0   0x4 */
	u32                        initial_quantum;      /*  0xc4   0x4 */
	u32                        flow_refill_delay;    /*  0xc8   0x4 */
	u32                        flow_plimit;          /*  0xcc   0x4 */
	unsigned long              flow_max_rate;        /*  0xd0   0x8 */
	u64                        ce_threshold;         /*  0xd8   0x8 */
	u64                        horizon;              /*  0xe0   0x8 */
	u32                        orphan_mask;          /*  0xe8   0x4 */
	u32                        low_rate_threshold;   /*  0xec   0x4 */
	struct rb_root *           fq_root;              /*  0xf0   0x8 */
	u8                         rate_enable;          /*  0xf8   0x1 */
	u8                         fq_trees_log;         /*  0xf9   0x1 */
	u8                         horizon_drop;         /*  0xfa   0x1 */

	/* XXX 1 byte hole, try to pack */

<good>	u32                        timer_slack;          /*  0xfc   0x4 */
	/* --- cacheline 4 boundary (256 bytes) --- */
<good>	u32                        flows;                /* 0x100   0x4 */
	u32                        inactive_flows;       /* 0x104   0x4 */
	u32                        throttled_flows;      /* 0x108   0x4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        stat_throttled;       /* 0x110   0x8 */
<better> struct qdisc_watchdog     watchdog;             /* 0x118  0x48 */
	/* --- cacheline 5 boundary (320 bytes) was 32 bytes ago --- */
	u64                        stat_gc_flows;        /* 0x160   0x8 */
	u64                        stat_internal_packets; /* 0x168   0x8 */
	u64                        stat_ce_mark;         /* 0x170   0x8 */
	u64                        stat_horizon_drops;   /* 0x178   0x8 */
	/* --- cacheline 6 boundary (384 bytes) --- */
	u64                        stat_horizon_caps;    /* 0x180   0x8 */
	u64                        stat_flows_plimit;    /* 0x188   0x8 */
	u64                        stat_pkts_too_long;   /* 0x190   0x8 */
	u64                        stat_allocation_errors; /* 0x198   0x8 */

	/* Force padding: */
	u64                        :64;
	u64                        :64;
	u64                        :64;
	u64                        :64;

	/* size: 448, cachelines: 7, members: 34 */
	/* sum members: 411, holes: 2, sum holes: 5 */
	/* padding: 32 */
	/* paddings: 1, sum paddings: 16 */
	/* forced alignments: 1 */
};

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f59a2cb2c803d79bd1f0eb1806464a0220824f9e..230300aac3ed1c86c8a52f405a03f67b60848a05 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -104,6 +104,9 @@ struct fq_sched_data {
 	unsigned long	unthrottle_latency_ns;
 
 	struct fq_flow	internal;	/* for non classified or high prio packets */
+
+/* Read mostly cache line */
+
 	u32		quantum;
 	u32		initial_quantum;
 	u32		flow_refill_delay;
@@ -117,22 +120,27 @@ struct fq_sched_data {
 	u8		rate_enable;
 	u8		fq_trees_log;
 	u8		horizon_drop;
+	u32		timer_slack; /* hrtimer slack in ns */
+
+/* Read/Write fields. */
+
 	u32		flows;
 	u32		inactive_flows;
 	u32		throttled_flows;
 
+	u64		stat_throttled;
+	struct qdisc_watchdog watchdog;
 	u64		stat_gc_flows;
+
+/* Seldom used fields. */
+
 	u64		stat_internal_packets;
-	u64		stat_throttled;
 	u64		stat_ce_mark;
 	u64		stat_horizon_drops;
 	u64		stat_horizon_caps;
 	u64		stat_flows_plimit;
 	u64		stat_pkts_too_long;
 	u64		stat_allocation_errors;
-
-	u32		timer_slack; /* hrtimer slack in ns */
-	struct qdisc_watchdog watchdog;
 };
 
 /*
-- 
2.42.0.459.ge4e396fd5e-goog



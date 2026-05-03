Return-Path: <netdev+bounces-283665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMGDBvCn92k/kQIAu9opvQ
	(envelope-from <netdev+bounces-283665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBFF4B7308
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BE1E300D148
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A33E3A7844;
	Sun,  3 May 2026 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="r2LY6ugu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961F3A75BC
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838035; cv=none; b=shieIHSnOKuy7f23Vj9cqSEMYvopCsVr0DUscAfKlQEIT5vtecz2Fk7hzDmc9Hx4asTPbJfr9LwTb8FQhvkkqnBb69y/4sDMwfz1rkKAOdrUWXDisx+YkbpXYbr2FJJCfSO2hHSW5S5BPfDpVtg5V6eE/5glnSgbvmw5Dv9DH5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838035; c=relaxed/simple;
	bh=ETBgXWvuGUMvNTgMZSFEQOcUtlGp2R15xSPoE/AyTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Odbg8Agtd1mM3zyY36MI4Q1nhJOzjPCi4LFMPyR2uTRcyff/CDKPe/XAK1jET8HWVxpE3IBewHT4qv8r3G+7P/Nh4U4kuJGBQKWVmGSfzkuAhPynblKrd5xG7QYFvhArZqd8Huv87m8zPzex1Cl5rdPrRYnREF0/sUjLnPPZAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=r2LY6ugu; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4552916eec.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838034; x=1778442834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=r2LY6ugutTGkIPlhXMJFNbGvcyqxKQB2jE6yAwAgEbbASZ4f7xW+GElwv/mOuj0gsH
         r6DJ6m91EWr/cR4AQC5mGNmP0wEVOISRJCRbNUhoaS52wLXXxxCqQXrV4dfHaq9R0iA/
         l7s7Lu2D+DuHbuIskSjFyPm4SH7Tz6qqNtlz0zRXZWPquovqXXZVO41KovG+k8C5L0Q4
         6LzLPrFKAeebsmjZji+mmueeJNzJhaAlwCVCQ60d2qXJLgv+xjKWwkMC2AD8l809Oxfs
         oYSKBCKlUS+a3mrB9wvbvkdfur7UG38E+2dxiVHdv08XM6yIvcBLvYbHDftY5hL7yynQ
         M4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838034; x=1778442834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=B8A9dqh45k+30P2uJNgV1gIS/KyTSWCn7yUkq0w10TzrqZ6jjwDLJRa8ng+LvY8WrV
         ksgHJuctInPJ0U5fPtUdwwgdoJPPEwrDixk3Zq5GQgaJYjSQRNqnU0pm4LeXH7Vtvy0X
         9u3zXJMtq9HmCODoSWBlRIvFU2C8dSXIzut6cTNddOGDQMGoNdXGglY+U9LOfNmcSDf2
         heq+YvoVN5PESNms9Id+XWZoLWSrWORxVGQGDHvtPPCpOTag+r7u7qLZL3DLjAFNwMVN
         LA2lLizDnWPTv+MixXKQFqcfBsRKqSzjvfQ22B725Tduo6PMNotTmkvNw+z7rSliNoxE
         dbrQ==
X-Gm-Message-State: AOJu0Yzo6b2J3r2fJ9a959DsXChhxZYdOKkm2x0FX7xJOKdnQunXumcC
	TyIdnq+2FTVDZjw1z+ISJK/8WKLmNpCDUN5ezWUbrqyRBo4jveWK+FlFaOE5dlGqqlSLo1SVk66
	ELS50
X-Gm-Gg: AeBDieuh9F5T/nIq+FksfhFtucXH1PQH+l1LaP8gi6dt2knoWMPcxwtuK/MRhGdD2Tx
	uQHyb+OetZC8s3ec8CHwy55qto70yhRLC6euT6N3Z3zXoXzXJ8CIW1KO+GjAgXGkDyCr2hXS1eU
	wiuJlXZMepynv5lBK+1mhpsfgSsp9d9wrxx0STmm/eMckSOC7KEK3dRvwjJVhxDdrs255uozw+4
	qkp9bwhNSVKu/CgC4t4mPr0RzrCeOoY/0T0+93k/FjIso/99QqLCEDbxs5C2ENKeVcT/JUBXs0d
	DaGca23EpNeGjzNM7ANVdVsBvKTKI4hAYwYA10f5LMv7cfPx9vhjQLx8Q7PYFtt4Y9lpL9UZN3d
	qZmkn9hiWnjGEBU6CTm4/HIGSj+fusXo/MksAPBdQlLOOyc3BYPVNkqwB6ls9yeq72QLfF49hpX
	BnZ1gpc6iYRAU2AyUsNkbOtZOsUjSHxMPnXx1KWnXukt8=
X-Received: by 2002:a05:7300:7fa2:b0:2ed:e14:42e9 with SMTP id 5a478bee46e88-2efba7afa62mr2611601eec.34.1777838033358;
        Sun, 03 May 2026 12:53:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 1/5] net/sched: netem: reorder struct netem_sched_data
Date: Sun,  3 May 2026 12:51:59 -0700
Message-ID: <20260503195348.521225-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503195348.521225-1-stephen@networkplumber.org>
References: <20260503195348.521225-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEBFF4B7308
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283665-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email]

The current layout of struct netem_sched_data can be improved
by optimizing cache locality, compacting data types (use u8
for enum) and eliminating unused elements.

Reorganize the struct as follows:

  - Cacheline 0 holds the tfifo state (t_root/t_head/t_tail/t_len),
    counter, and the unconditional enqueue scalars
    latency/jitter/rate/gap/loss.

  - Cacheline 1 holds the remaining zero-check scalars
    (duplicate/reorder/corrupt/ecn), all five crndstate correlation
    structures, and loss_model.

  - Cacheline 2 holds prng, delay_dist, the slot dequeue state,
    slot_dist, and the inner classful qdisc pointer.

  - Rate-shaping fields, q->limit (config-only; the fast path reads
    sch->limit), and the CLG Markov state move to the warm tail.

  - tc_netem_slot slot_config and qdisc_watchdog (only consulted on
    slot reschedule and watchdog wake) move to the cold tail.

Also reorder struct clgstate to place the u8 state member after the
u32 transition probabilities.  This removes the 3-byte interior hole
without changing the struct's size.

Should have no functional change.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 123 +++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 60 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index bc18e1976b6e..616d33879fdc 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -71,89 +71,92 @@ struct disttable {
 	s16 table[] __counted_by(size);
 };
 
-struct netem_sched_data {
-	/* internal t(ime)fifo qdisc uses t_root and sch->limit */
-	struct rb_root t_root;
-
-	/* a linear queue; reduces rbtree rebalancing when jitter is low */
-	struct sk_buff	*t_head;
-	struct sk_buff	*t_tail;
-
-	u32 t_len;
-
-	/* optional qdisc for classful handling (NULL at netem init) */
-	struct Qdisc	*qdisc;
-
-	struct qdisc_watchdog watchdog;
+/* Loss models */
+enum {
+	CLG_RANDOM,
+	CLG_4_STATES,
+	CLG_GILB_ELL,
+};
 
-	s64 latency;
-	s64 jitter;
+/* States in GE model */
+enum {
+	GOOD_STATE = 1,
+	BAD_STATE,
+};
 
-	u32 loss;
-	u32 ecn;
-	u32 limit;
-	u32 counter;
-	u32 gap;
-	u32 duplicate;
-	u32 reorder;
-	u32 corrupt;
-	u64 rate;
-	s32 packet_overhead;
-	u32 cell_size;
-	struct reciprocal_value cell_size_reciprocal;
-	s32 cell_overhead;
+/* States in 4 state model */
+enum {
+	TX_IN_GAP_PERIOD = 1,
+	TX_IN_BURST_PERIOD,
+	LOST_IN_GAP_PERIOD,
+	LOST_IN_BURST_PERIOD,
+};
 
+struct netem_sched_data {
+	/* Cacheline 0: tfifo state and per-packet enqueue/dequeue scalars. */
+	struct rb_root		t_root;
+	struct sk_buff		*t_head;
+	struct sk_buff		*t_tail;
+	u32			t_len;
+	u32			counter;
+	s64			latency;
+	s64			jitter;
+	u64			rate;
+	u32			gap;
+	u32			loss;
+
+	/* Cacheline 1: zero-check scalars and correlation states. */
+	u32			duplicate;
+	u32			reorder;
+	u32			corrupt;
+	u32			ecn;
 	struct crndstate {
 		u32 last;
 		u32 rho;
 	} delay_cor, loss_cor, dup_cor, reorder_cor, corrupt_cor;
+	u8			loss_model;
 
-	struct prng  {
+	/* Cacheline 2: PRNG, distribution tables, slot dequeue state etc. */
+	struct prng {
 		u64 seed;
 		struct rnd_state prng_state;
 	} prng;
+	struct disttable	*delay_dist;
+	struct slotstate {
+		u64 slot_next;
+		s32 packets_left;
+		s32 bytes_left;
+	} slot;
+	struct disttable	*slot_dist;
+	struct Qdisc		*qdisc;
 
-	struct disttable *delay_dist;
-
-	enum  {
-		CLG_RANDOM,
-		CLG_4_STATES,
-		CLG_GILB_ELL,
-	} loss_model;
-
-	enum {
-		TX_IN_GAP_PERIOD = 1,
-		TX_IN_BURST_PERIOD,
-		LOST_IN_GAP_PERIOD,
-		LOST_IN_BURST_PERIOD,
-	} _4_state_model;
-
-	enum {
-		GOOD_STATE = 1,
-		BAD_STATE,
-	} GE_state_model;
+	/*
+	 * Warm: rate-shaping parameters (only read when rate != 0) and
+	 * configuration-only fields.  The fast path reads sch->limit, not
+	 * q->limit.
+	 */
+	s32			packet_overhead;
+	u32			cell_size;
+	struct reciprocal_value	cell_size_reciprocal;
+	s32			cell_overhead;
+	u32			limit;
 
 	/* Correlated Loss Generation models */
 	struct clgstate {
-		/* state of the Markov chain */
-		u8 state;
-
 		/* 4-states and Gilbert-Elliot models */
 		u32 a1;	/* p13 for 4-states or p for GE */
 		u32 a2;	/* p31 for 4-states or r for GE */
 		u32 a3;	/* p32 for 4-states or h for GE */
 		u32 a4;	/* p14 for 4-states or 1-k for GE */
 		u32 a5; /* p23 used only in 4-states */
-	} clg;
 
-	struct tc_netem_slot slot_config;
-	struct slotstate {
-		u64 slot_next;
-		s32 packets_left;
-		s32 bytes_left;
-	} slot;
+		/* state of the Markov chain */
+		u8  state;
+	} clg;
 
-	struct disttable *slot_dist;
+	/* Cold tail: slot reschedule config and the watchdog timer. */
+	struct tc_netem_slot	slot_config;
+	struct qdisc_watchdog	watchdog;
 };
 
 /* Time stamp put into socket buffer control block
-- 
2.53.0



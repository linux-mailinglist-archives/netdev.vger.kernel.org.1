Return-Path: <netdev+bounces-284533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFlcJBgs+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 896614D23C5
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30FB6302D188
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C854A33E5;
	Tue,  5 May 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="erbBXxUm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B15C495528
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002866; cv=none; b=lLGPIxrJboua/eg/6X+NPUNXeQWHwPoNgq1CKEtCmWGXZn8MvdoLg0rKspSGeXPL0+A9fslU6fJNczXRx7u6V1k0MmkBdJU6RMkQZi4XVWiDYIWJz5hqrdT8Ujz9YgGMCFOnak7zFm31AT5omE6KEeaHyb87Q4CeetySl0gYc1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002866; c=relaxed/simple;
	bh=ETBgXWvuGUMvNTgMZSFEQOcUtlGp2R15xSPoE/AyTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYfHPHbWgJWSvIgwUloOGAPQXLtpvypvlXI7vBHXp/P8fuBJXbs8gXacJLSlEeU0x54ljv3kU+1PtejcZUMBnkynX8Lgld1uWh1nKK1tIyE3ezSPeNESYUQCKbCBuw39u8vpCoy3YTKq0zdkBP04MDuskiK9D/dAMTweDbNM+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=erbBXxUm; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463f00cda04so2670019b6e.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002864; x=1778607664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=erbBXxUmlY8E/BqtEclf+KIl34Oix8P3m9wUMSw2GRkYdM+WxvaZlvfBv0z/5b84eP
         KmYWkifGU+bDsH/AeJpj7pOVZXTUqjvqwyw0pggA6P/am03BsqERkf6vds708Pf0rjOQ
         FZgVeUPTGzPJjSIIA2WlIa9qk6H3FZ2yRTVJcsG8B9uMS0H4ZjXBD5yUB/zBeRPjTsYA
         W0AAFqAwj1FxGR/RveYJ8aBlvFSD8HJSirdWSfgj78wLJBWGGpV9NNYWFnKWv87GMOZL
         VLMA5EvSQeMmklbtFBhb2nPHJJ/ZGLKUlIxTeBscMa+IjvfBZZymGWhTzR5/B28u/V1t
         W/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002864; x=1778607664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=J0a6UgQYbYdFRJFATsXF6gjpocWgGPSjqdF6IF8ZCvqxNZApDK+6+zmUdz+lLwBeB3
         jMDXCJDg/tvqd3uWax5k1cKJjMUB7ki2KDYLuYvAAi6Rwe2FvQY6N+GY10fiG0hX3JPJ
         8XFS7DmDnPRico8KXqIjTAlieTvoY4NphYoghVqLsi+qoM//uvdBiPz01AwUZDK2/APo
         ukHyDudwJ3DWv4Kfs4ZMFYvlqUHhms2Lao67fiPlkTDM7JZtkMVpLfDCmE2UlHlOZua5
         boU0Nu5UWUQqXzXGvVhE87oXymmviVY17mLhTGpDl47erZiqBma74SV0jrbThflS909B
         m6hg==
X-Gm-Message-State: AOJu0Yz3TveRL9YbjRf4LrT+w/poTLft8v/30qB3gfkEajVu+T4a6SaI
	Gy94HWYEybVWwV6/rkqQg5Y0FT5uvRt85z8YrmI6e79NaBPjvIMlWfsKDPlfBdnRO2hBUKMUxpl
	qMrek
X-Gm-Gg: AeBDiesDOA9LLaNTRWHyUpm4PBbG9S/eoYz7uP4PhF+6PFq6BwtrfXXO0iBE1vWGn7u
	DU3/PQo6m7z0S2mVu51OOnrX/esEDQ8o5zw8oEkVPzWCvmrbpsbQYyoGTCJOjB6PBABGzv5qfeo
	1R9rMX36TXAYgUMC5fv9mfl7WWL6dlxJltesvQezodESO8nAmDYR5wF63vJMZnfG1YoC4EvIwJy
	Th4zwtzHhWrcMUfBxFhSddAs5xZAI32Ce8k6/2yZgN/PYd2ODNyjWOhDyYSz+uzwiCWenStoL7E
	HmhYKc3hgoRKmlETuwgAZFg7n3p/YvjXdOQn9qHavwu1hLXRJIu5+m6taJQJLFZnMcOpNG/3Ufj
	LmRR+cvG/DQE1umOMTbhCKlM8VvIzbpDLQ5bh5ta4tFZA4NoQXCJq8FrkdA+rVj6ouU3duue9Od
	FD1qo7SYCFQQqT9Zxmh4aNHAC4xb/AaryzWFNAhx59QK8=
X-Received: by 2002:a05:6808:3a14:b0:479:db65:8db0 with SMTP id 5614622812f47-480420941a1mr35193b6e.3.1778002864114;
        Tue, 05 May 2026 10:41:04 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/5] net/sched: netem: reorder struct netem_sched_data
Date: Tue,  5 May 2026 10:38:41 -0700
Message-ID: <20260505174059.651260-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505174059.651260-1-stephen@networkplumber.org>
References: <20260505174059.651260-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 896614D23C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284533-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

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



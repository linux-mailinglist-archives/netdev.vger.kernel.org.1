Return-Path: <netdev+bounces-286197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHpGAcRq/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D90C500A6F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C988E3004629
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA2F3BD22F;
	Sat,  9 May 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="HkZqO/XM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98B82F0C7E
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346690; cv=none; b=I1nElso7N0cPdLv6ZAhV+RlLqngKx1B90WPlpCjsk+xDpnErcpbwqxaWYz0CASM1CTjPZnXWNmGTy24WrBSM/NHrjubxNc05TxbqvEWDm3wuRZ+nr27dinju/0CCqcjDYbdhZhFFKr6/1mCrBuq1KvulzKotXXPTM0k67Y/abZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346690; c=relaxed/simple;
	bh=ETBgXWvuGUMvNTgMZSFEQOcUtlGp2R15xSPoE/AyTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sohK1ENaePp7U4Pq4wGHRB/UnZpDqMnR06uU0oE8qlV0kfRMhtmoFYzoXUbi0b6JsdxZ7nUC6WizSOnKwGPFD1ZypCt4LpPOG0Qe81n9/61mLGZ74TBVAwiPXGOXH3UJPIRcnWsSaJ0LxRrGeF9ACnUJPKXhipcu1e+U+EtBjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=HkZqO/XM; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so7715427eec.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346688; x=1778951488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=HkZqO/XMIODi8hhRXwTck8d7ZKmaCsJWqz/Pi7r+JK01qvxS51XuSXkwpufmz/XFGa
         4tzzXrIXPTnFGM8Bl8HnQXVYCUSICLU8Q08F0IaR4fjA6FV+gzhbHjtMncnV+XYvXuOC
         RnBH082y4a/LJwaWVSW53KoQGmsuAi33V1Bi47tp9Oj0DAWANHScNifm1KJqrQf4b1Pm
         BySfjLjyPrNtFcIfjYY5OcbpYeNzmbOjya50uSkOBPLkUNxiPBYcH5uXfRrJOqJHyZrX
         kNl7IJwVSDB5EY1ko/wH0/k/spZbOXIScF4vAFO26Cr1EZAGBlqtrvamUjbuXG+wX329
         jzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346688; x=1778951488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=M3WiQHesBNrKFu2DU/hciZzmONr/JZi7qjyjNnKMaIY6zfRxiMQCDGP5jX4vywM17f
         AOPVmmWCp7VryjxwIJxQOQ4iDT9beuXwdCdPlkZg+Eygc4PN0of8iBoZpU0IAKo7z5dA
         tQ484mzC2tpsRPRpaPFb2zPMz4CUuRU/x3vtRlabcC9/vrdiwUoJEE3HjnzBO5uF4P2p
         amCr8tGe1YZzR40SFPEmtXxH8yDmeyYkjPjTBO0WqTvFlqS+Lqel+XPYwed1Lscxo8Gp
         YBPD8K7RRtCfEuhoApS4oJ7Iah0I8EvYMR3KmaMf7hVLeHdkhHymZVetCK7y8Axcdojp
         2FlA==
X-Gm-Message-State: AOJu0YwSCRakPti/E1wDt7ZEP6Kf0fiIluM7RB4i+k0g3ukEn0LSYfZs
	C5uH+gk45qpb/gYPXR7yTxmPe4/byQ7tZNex5P4dkDXFZItRnLAY2IUcfA9nrgaqUbPYSQ9XBdS
	GLrmW
X-Gm-Gg: Acq92OEFPwYf8UsntA0YppgrDOT5UMTWT2amU3LVzpmZNg9V2jrwuTvalKJBoxU9CvK
	Cgiu+9s5QvJ3i3Xx94i4PDfSqIgQGvYq6y5JYzJmxFYzGjYYOKiCspyPmSw3DRWw4DHl/0wHh8F
	VyeKXZEa2dH8LIEq2mGYZIFEgkSVOYCmfK3UvAF6Cm09GlAcDLGV5ypNLuuPPdZ+M47omMMPZgG
	DfyaE53+YXNPTBZb7yJU5JTCFWmDtNuzcvXoirpNdNLC4StvYkVaB9sYy0VGnBNIks/z2s8ij8M
	s6Roc/V3cj7Y5fInbOSxt4Pp5xp3tcGIR7sdlStOHayAOCc2Ckf30qIH/13wt1sKHsxd9Yaewkd
	suXUe7A85fhyIBtDcDmHzQ4Jw9XfCT/TXVuuw7OlVzTVKaqaZnanXQ6ybe8LALnel1dky+HYTWK
	+b5dbdMDS89BoeI60p+JKJY2bu5ULlrOzGhZrxGkxLAYE=
X-Received: by 2002:a05:7300:d704:b0:2c1:7b61:8731 with SMTP id 5a478bee46e88-2f5490931d5mr9146989eec.10.1778346687769;
        Sat, 09 May 2026 10:11:27 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v5 1/5] net/sched: netem: reorder struct netem_sched_data
Date: Sat,  9 May 2026 10:03:22 -0700
Message-ID: <20260509171123.307549-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509171123.307549-1-stephen@networkplumber.org>
References: <20260509171123.307549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D90C500A6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286197-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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



Return-Path: <netdev+bounces-285568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM4XO61D/WkoZwAAu9opvQ
	(envelope-from <netdev+bounces-285568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B954F0A9D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E900302BA73
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A542517AC;
	Fri,  8 May 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="UBum0ndc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BB244665
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205590; cv=none; b=BAuK+GtgmCdeAEWKw7TDsv5h97xiviVdt6PEqZMEQbwxKP69oKmjdZ9eT3sJUMzobcjrMGznDOj7raIhc0kiG9LrGZVLAxrbh+OKMB4NS0n7h+I6fgxsvWvV7NVkvqVG5yhAhj7xE7PKcWYt5/PQqHpzTAOVQrJsHs/LEKo0L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205590; c=relaxed/simple;
	bh=ETBgXWvuGUMvNTgMZSFEQOcUtlGp2R15xSPoE/AyTkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+m+VrfuMaw7HO9k2BmIiFr0st8EzHounTDVGkSvVjNyEA/pXKawU4ukAA3HuA/z6DbzLM8AvBwDQroIu0If0SfQ2F6cR+6beBhLeDNUqUZWRKVjip/vGnCBi4wyMwD5XWCRZeCPV6RzECULaSAax7MIn3IObUYe9Whb1T8hqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=UBum0ndc; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso1748870eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205588; x=1778810388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=UBum0ndc/wdgLrhe391hKYVeHoBJXTBvAwdV8yzy4PDcZiS6pvWvcqcV+nPPbAj9tP
         AypLSZm8sT/3FwF8ADY2aYzC0hNw3/WLCTCt39mW9IEGT8r2RV6XeMyzXPSFeQtoJl2C
         jDBvfulh9uS4sd3oadSmVTKOIGsnfSBOt9sEUBbqJ0uobgcl0sm/njs+1kd7TP2xx/CI
         C/UQZQz77xKGsPrx7UGohYchJjpkVr3CJifaLPJrDq4KArQd9WU1M9WNp8gd8NRd44wL
         RBhBFDH6G6OlPaLWqX1Uzk1beiSGDTDhDQHDdnu/f1z9upgsy4LmSJdvh6+PSGL8FIMp
         NAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205588; x=1778810388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HY5nzQn5cAP1hhmSxoB6k29oHeedYWHjPnLvZY8TJyw=;
        b=e+C2YEhdDkO94ot65MswvNKTScu28Fpqc61WjvFpNFxd+ElzAc9GfMmYF9gJwYRP0Q
         yX4+M9BDQErQ34fmGolysU+WNVNJB3so63Tujjr+GTjnqViQHdftSFi3WoWPsCtp+e+4
         xDgWT+fxcG4sqCnjbWQ3L0BAzcItu6Y24DLOkDS13YMzmyhwXvzGxxUFGKsAaIQSFQ6o
         IM2OEuDLSL3rYzsbGkBnTXmXfPjRJC4/8WuOFWaOWhgjt4mk1R54WLHcHykO1PR9rvqH
         08nFDOAjHjw1KtLNpQZ2zpNa/wVuuf3QBmWWRdte0jP1eKJDOsT7L/Nz3MKv5XxW1Eyu
         5KQA==
X-Gm-Message-State: AOJu0Yz/0RVR9bV+KtwAGRopYGl/2CtuOjDnXcXC6/W9NHRVzmB/w9SV
	Gx9BaYtUuubsfYA4yQP31oZfy4HeeuudxOT5hfmLoKTl1C8Os9LRKwMJyyV9QtUJ7coMKH6y5qZ
	k9Bof
X-Gm-Gg: Acq92OEyc23kAqxJrYFyFIPK6isxbq0aEVBIg5Lif3EZ6TxFlteCB3SS99rUvVmUE5t
	NGPYF5uRzq5aEts+ZlXdRy/ZTsIF62Hj1Egw8vXEhMaMezPbjNknZ8SBiFevfIISLCTFH5W37mn
	WhRRitvR61rTPbAwBnxdsEdZs5MePKi8k+D1Zd16idvMHHmtN3DqaP3J9luMPZ/hIsv0qSyHA96
	HUCzVSxeWxkFTpx0bAQmESXzIIiLd6YvTd7Kwy1KvwYB5PmNAf04N0/wBqWRsTGPYh4FmNNTGxj
	dQ5aZoWgok3TpAxlANNN+ILuO0E+Jsa49a40OXuoA9oy0eJlOtDKWMlm/YkKG/I3BbAdfLlh3t9
	NjRW39d0fV43TU8FedhHR6dG4k2yvImIocY598hdiC+I5nRvZkGd+/7s2sE5CMUmjnw8tQt2omW
	ZlKQhtT9+pExelVjbe0RZB0+IxxldcMFEI
X-Received: by 2002:a05:7300:cd92:b0:2c5:50fe:c78f with SMTP id 5a478bee46e88-2f548f9e753mr5220329eec.12.1778205588198;
        Thu, 07 May 2026 18:59:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:47 -0700 (PDT)
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
Subject: [PATCH v4 1/5] net/sched: netem: reorder struct netem_sched_data
Date: Thu,  7 May 2026 18:55:17 -0700
Message-ID: <20260508015940.554462-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508015940.554462-1-stephen@networkplumber.org>
References: <20260508015940.554462-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 56B954F0A9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285568-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
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



Return-Path: <netdev+bounces-283668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJpFAvyn92k/kQIAu9opvQ
	(envelope-from <netdev+bounces-283668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9628A4B730F
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 21:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C4513008D42
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 19:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7563A7F54;
	Sun,  3 May 2026 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="HG9fOw95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA8C3A7583
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777838039; cv=none; b=uggZGmmij2Mf3zl/Hd/kRj0Uzm7riFmjAKTQwj0F4kzs8ISD6IZNLJVsrYNoBCZiPPaEtIi2WQaz8f6lsu68LwmBo7LAjk+jzcSQXEiM65rRSzTUCVCzA6yFeDgSON9PiOtL7syAsdXtmqLs/enk0pEc6r+puF5elRv5rGrv81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777838039; c=relaxed/simple;
	bh=gWI8A0er5RS6rvQntuEohOAvY/PItZZAG4OTxIUaRVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NULy6W30LcNtO1hhMB2g/aZ1AFkoCjsEfzgxLlSY/arJqO26ZLQ2JSvdXsk+0NHwL8exMnkkoaS3ZXIrFYHwOcecoEvRpsw9YYjz0QqqaJ7gW6Kyw22eBXOMZTD1fBcXmRY/1c8wmaUuJI0+fJk9DgqMnqJ2Jw8bszuJeJI439M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=HG9fOw95; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2f0ad52830cso1085110eec.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 12:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777838037; x=1778442837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6CSwkJqrew1gGA4+lA/P1ASp+TQLdxP0vOxho8MxPU=;
        b=HG9fOw950UnCGrSROyLyCNlpC7DyWYCtUMmJ/E7ABEbr3W+PPYh1wRGR223/9EuDg6
         e2dZs2l0L5+tMykZ2GnE04eR3vreKLWubej9PKe1riWK+lt6nfksOrQZLmPHXmFt2mhV
         lhWbTeRtD8SWvCV4u2PJyv/DD8VxxIYSYuGdAareINS4l2G3+OMjibFTE+SlWwYhTIWE
         zuaO1Xid1kEJWQ3g1VSOclqRTuLYsduI64xPad8P3r2xTKCTTtSQde1rKQXsafetl+8c
         sO52sUzu0O3O9Wl/xUCzw2aSvOd0y4KX3mXDzj1/q3KbpAt9iIA1cZDovEh+cbvfvehO
         MIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777838037; x=1778442837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6CSwkJqrew1gGA4+lA/P1ASp+TQLdxP0vOxho8MxPU=;
        b=lw8J79X+W88ZRnQRKiQE82NAjsS4ygk0G98YR6y9Sd2yH4/8ubEQC7cleE4VqknWJe
         7S+WrfdZZbYDSpOLgh9u0D/KSziS5LheQEuN0mlwMXs3uul0rg8NXbrTBNwgNzaipmyu
         W+Ic0t+wl7zH115uGUSzUBeVXg3itUFWplWlzmpJ0QJuOg6om6medWUGkBoWfPeffxg8
         ZQbShrejP49HDpEnRwALEV/GbX5nwXV3Rrlf9DwfGifa7mRSHVhP3KdPmJzT3EGkPEAl
         DtaIz9+Shr4YkgIgKpqkJgwzZScU2BRITbQmwF0MU/4c89Wt4xNqytvBayHjdQlAwXkv
         /o9Q==
X-Gm-Message-State: AOJu0YyfEXlyQ0qt7Yw8ztuq3C0+NJxBt7j1lpj2EmLcLRp0j4MBPO59
	1UGebCWqfRBqW4PMSaBus6t1m1cY2Di0ROPnbmQLCVPMbliqTDcjL/yMmfJZDw/Jv8An6gxfo+N
	m/FV5
X-Gm-Gg: AeBDietQo5aU3Cy09+GCkTWKPGd2WRNjya2nsabx8xIPP99YFrQtbAwlDENIU1lK38B
	l8rHaLMkXYWoZpBRDmoc3oY/drlzaUtSW+itti6xiZoqerkI0XrWmk9TF6rg6uiWOCvV0TqnuWF
	hIChnwyeFCD71/mZDQ6YShs/Hm4QfrhEIor7gFg2XanCbO9aUYqvQDaYFw2LTAnVQudxILJVP5i
	c/INJziKknQ9KLhK6y0/eMzJQv74hQlE2RgJGRwsZo8QnLUCTXNejjkm1g+wcCOmGw3zwr8HXvc
	FH0wgjc3nHOfiw5TvHAMadOAZLqv34WCYgvoQJpaCD3CEy80KxX6uRbYEAhDwwTMwyuKp7m0Vjt
	qNTsSEpwgcIoo9LjJ5OHKryFpaumZOA5k4w62Xv4Ur3CgxuXbB5rTqGNmJdIzn4pDx14jaV3GQb
	zmM4K+bRjKPNRbjWi46DhRetLW0EPrm+9PwHkYGRH7M6UW57+3K/tLnw==
X-Received: by 2002:a05:7301:2f8f:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2efb9c85952mr2710042eec.18.1777838037143;
        Sun, 03 May 2026 12:53:57 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3c24e738sm12834365eec.31.2026.05.03.12.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 12:53:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH net-next v2 4/5] net/sched: netem: add per-impairment extended statistics
Date: Sun,  3 May 2026 12:52:02 -0700
Message-ID: <20260503195348.521225-5-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 9628A4B730F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283668-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:mid,networkplumber.org:email,networkplumber-org.20251104.gappssmtp.com:dkim]

Adds new counters that keep track of when netem applied
impairments (delay, loss, corruption, duplication, reordering).
Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

Use the WRITE_ONCE/READ_ONCE pattern to allow for lockless
qdisc usage.

Accompanying iproute2 change is submitted separately.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/pkt_sched.h |  9 ++++++
 net/sched/sch_netem.c          | 55 ++++++++++++++++++++++++++--------
 2 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 66e8072f44df..1c84c8076e22 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -569,6 +569,15 @@ struct tc_netem_gemodel {
 #define NETEM_DIST_SCALE	8192
 #define NETEM_DIST_MAX		16384
 
+struct tc_netem_xstats {
+	__u64	delayed;	/* packets delayed */
+	__u64	dropped;	/* packets dropped by loss model      */
+	__u64	corrupted;	/* packets with bit errors injected   */
+	__u64	duplicated;	/* duplicate packets generated        */
+	__u64	reordered;	/* packets sent out of order          */
+	__u64	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
+};
+
 /* DRR */
 
 enum {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 53961d1e70d7..e710898ce96e 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -100,8 +100,7 @@ struct netem_sched_data {
 	s64			latency;
 	s64			jitter;
 	u64			rate;
-	u32			gap;
-	u32			loss;
+	u64			delayed;
 
 	/* Cacheline 1: zero-check scalars and correlation states. */
 	u32			duplicate;
@@ -112,7 +111,8 @@ struct netem_sched_data {
 		u32 last;
 		u32 rho;
 	} delay_cor, loss_cor, dup_cor, reorder_cor, corrupt_cor;
-	u8			loss_model;
+	u32			gap;
+	u32			loss;
 
 	/* Cacheline 2: PRNG, distribution tables, slot dequeue state etc. */
 	struct prng {
@@ -125,21 +125,27 @@ struct netem_sched_data {
 		s32 packets_left;
 		s32 bytes_left;
 	} slot;
-	struct disttable	*slot_dist;
 	struct Qdisc		*qdisc;
+	u8			loss_model;
 
 	/*
-	 * Warm: rate-shaping parameters (only read when rate != 0) and
-	 * configuration-only fields.  The fast path reads sch->limit, not
-	 * q->limit.
+	 * Rare-write impairment counters (read together by netem_dump) and
+	 * rate-shaping parameters (only consulted when rate != 0).  The
+	 * fast path reads sch->limit, not q->limit.
 	 */
+	u64			dropped;
+	u64			corrupted;
+	u64			duplicated;
+	u64			ecn_marked;
+	u64			reordered;
 	s32			packet_overhead;
 	u32			cell_size;
 	struct reciprocal_value	cell_size_reciprocal;
 	s32			cell_overhead;
 	u32			limit;
 
-	/* Correlated Loss Generation models */
+	/* Cold tail: slot reschedule config and the watchdog timer. */
+	struct disttable	*slot_dist;
 	struct clgstate {
 		/* 4-states and Gilbert-Elliot models */
 		u32 a1;	/* p13 for 4-states or p for GE */
@@ -152,7 +158,6 @@ struct netem_sched_data {
 		u8  state;
 	} clg;
 
-	/* Cold tail: slot reschedule config and the watchdog timer. */
 	struct tc_netem_slot	slot_config;
 	struct qdisc_watchdog	watchdog;
 };
@@ -462,17 +467,23 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng)) {
 		++count;
+		WRITE_ONCE(q->duplicated, q->duplicated + 1);
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
-		if (q->ecn && INET_ECN_set_ce(skb))
+		if (q->ecn && INET_ECN_set_ce(skb)) {
 			qdisc_qstats_drop(sch); /* mark packet */
-		else
+			WRITE_ONCE(q->ecn_marked, q->ecn_marked + 1);
+		} else {
 			--count;
+		}
 	}
+
 	if (count == 0) {
+		WRITE_ONCE(q->dropped, q->dropped + 1);
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
@@ -498,6 +509,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * do it now in software before we mangle it.
 	 */
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
+		WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -603,12 +615,15 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		cb->time_to_send = now + delay;
 		++q->counter;
+		WRITE_ONCE(q->delayed, q->delayed + 1);
+
 		tfifo_enqueue(skb, sch);
 	} else {
 		/*
 		 * Do re-ordering by putting one out of N packets at the front
 		 * of the queue.
 		 */
+		WRITE_ONCE(q->reordered, q->reordered + 1);
 		cb->time_to_send = ktime_get_ns();
 		q->counter = 0;
 
@@ -1348,6 +1363,21 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
 	return -1;
 }
 
+static int netem_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+	struct tc_netem_xstats st = {
+		.delayed    = READ_ONCE(q->delayed),
+		.dropped    = READ_ONCE(q->dropped),
+		.corrupted  = READ_ONCE(q->corrupted),
+		.duplicated = READ_ONCE(q->duplicated),
+		.reordered  = READ_ONCE(q->reordered),
+		.ecn_marked = READ_ONCE(q->ecn_marked),
+	};
+
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
 static int netem_dump_class(struct Qdisc *sch, unsigned long cl,
 			  struct sk_buff *skb, struct tcmsg *tcm)
 {
@@ -1410,6 +1440,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



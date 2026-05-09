Return-Path: <netdev+bounces-286201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAceLlpr/2kR6QAAu9opvQ
	(envelope-from <netdev+bounces-286201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:14:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36280500ABD
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0896303B716
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D04F3BBA1D;
	Sat,  9 May 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="ESHIIILZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6992FD695
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778346701; cv=none; b=ew8QhksVbuBY9TCOU0paKK/tZ4PQoR6qZqA5vWZSyi6GtKbpGxgK2DSR+JpxE2DQR6dFTsYv/76soeUwMgKsQ5awFXy5xp9uHh+YpDNbPi5iVkInlzhhICqlv3AF0mKVLvukB7I1pNMRhX5DBUWDwnWG9XOeOT4TGL8wNVck+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778346701; c=relaxed/simple;
	bh=FMZ1tRA3ka8Q1nkGxkTHNa//8o9gocm0JiKYQHDx330=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLC/z/gs2fCVjM4qwnVPAg6v5TBGpc+I31+XBHt5yK8rOhUILV3X65sFMgpqHsGCEaDd9Y+/D/4ehh7pINLigmZ0IOaAfK5WOgF55DpZft9IGySTekLKrFZ3dzS9FyBKCQR9dmuN0rDxvP0+nLN/aJAKWzVtjSC2Frr9h0HupFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=ESHIIILZ; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c15849aa2cso3790840eec.0
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 10:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778346694; x=1778951494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btSrECOLXP80fkog/hbOs+29e1P11S2qrsGpUwU2SCk=;
        b=ESHIIILZ6YomoIsD8TDX7HCJRdsHtf59AioxeUzbtUGIQuHcGigaKIF3YLCWIqAJ7G
         oLE7mBe2a1s2n6+Y4Fe2r8H+pWqjSO8R9oULiIGzdFjTZldgIpJBT6h2sT3R5QHU0sV2
         1OUn8WSsQcCkxBFpL7wP9ss3b8EMqkxzrW8br7t/4v87tjz9Yt08IgDv5YD1hoI4xyNb
         vkLwK70Ex9xLs7y5WNkQqrpGQ4idX9mrfsQehkkTeEZSu5zD7MyFez2EGVirB4101jDN
         8cwQtn0qo6kzXpn547d0gaDoVtincF+VKeyLutqwrBXV68cVJxe1gGqpWFe3fg8FTMnX
         tOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778346694; x=1778951494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=btSrECOLXP80fkog/hbOs+29e1P11S2qrsGpUwU2SCk=;
        b=m6cfgOrftAXpkxiNFqBVeB9+1zqC2W7Org0iYXkyjyqe/8yQ1fYgD7cX/Yvj5hYR7L
         6MjAqsmqYVEHyYX1iTqab3xWm3IVtI1IhPNeR40j4gFSjJlUZJlMrrP+sCxJSjZ2HeRJ
         dh0r5gNsym8on6rlEH09CIBSxj0htgWuYOFKy20BkX7LaYzBfqhpqbzEX3jHAWTGlG18
         tNzQhEjPG3pmoxRDNuR+kEmWKvIzcc+4W1ETqs+QLgeEX4ywjahdpO8Mm06SdlUp4+Yg
         Jl/rAa1BrgcelETqRIM2RAyji4tH6k62PnnXSnUAF6dfQFTclM+jqza9Iz5SYDZSWc/q
         S3rg==
X-Gm-Message-State: AOJu0YxHA0r/oup1Bnn/pbs41JMA+jIVN1sDRAnKWYrNZSXHjiZ+PcME
	T01dtQTq49DHNxWcufuVDjVdDn6/qGAMLUmzPgTONjjbXEN7P9DfFSQyvoa31+ojwhD5wxyo+kY
	Ba8px
X-Gm-Gg: Acq92OFRQPqS2DHW636rgnAX3/n3wqXp3DcfCwqhdi9fvpheZwI7B70WpoKPc26hXOn
	g6Pz91p5mfj4yXkRparPZLsnKvqtWUa6nFqLhu9rsoB59M7zVIo0kzlZvzJe0Aa4Bq9G7lH7ukW
	aN64tZElOQW00c5ho8Ity6wop5KyXXn5oQBc5S0hNez0dXMz04YVQ9SSRwcuijEaSrCxHckyS9U
	K8fZKCgtGvFqKMWOxMvB24SzYhhsEowRTmbDy3gYpdH3CVGJhCO+WBRRfWkCJpkQyhHUq794ZbT
	G4H7eDRIUPzEBrM8vmVLRw7oSco3AcTBsm+I8ARiImlYc15r5+XncaZY7IYVGq4Qyz7Ola0AS7K
	guQ4B0MwIoAOU0+WyZlLGRIRSLyjE7fqarEOfVyN76mqJdAAs0qTFnchGGHsVvSNYpeNzyU+j8v
	nbqvvZ36zFBdE0HyJOIvnjZt3yUtWodoU6
X-Received: by 2002:a05:7300:6424:b0:2da:a813:a60c with SMTP id 5a478bee46e88-2f549f8389bmr9015305eec.20.1778346694371;
        Sat, 09 May 2026 10:11:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8859eafcdsm8524568eec.6.2026.05.09.10.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 10:11:34 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/5] net/sched: netem: add per-impairment extended statistics
Date: Sat,  9 May 2026 10:03:26 -0700
Message-ID: <20260509171123.307549-6-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 36280500ABD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286201-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Add 64-bit counters for each impairment netem applies (delay, loss,
ECN marking, corruption, duplication, reordering) and for skb
allocation failures during enqueue. Exposed through TCA_STATS_APP
as struct tc_netem_xstats.

Counters increment when an impairment is occurs, independent of later
events that may mask its on-wire effect. Added allocation_errors
(similar to sch_fq) to account for when impairment could not be
applied due to memory pressure, etc.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

Note to reviewers. The READ_ONCE/WRITE_ONCE pattern is to
align with upcoming changes removing qdisc_lock.
For some reason current AI prompts are obsessed with complaining
about 64 bit torn read/write on these, since the counters are
informational only, any such complaints are false positive.

Addition to iproute2 will be sent seperately.

 include/uapi/linux/pkt_sched.h | 10 +++++++
 net/sched/sch_netem.c          | 55 ++++++++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 66e8072f44df..490efd288526 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -569,6 +569,16 @@ struct tc_netem_gemodel {
 #define NETEM_DIST_SCALE	8192
 #define NETEM_DIST_MAX		16384
 
+struct tc_netem_xstats {
+	__u64	delayed;	/* packets delayed */
+	__u64	dropped;	/* packets dropped by loss model      */
+	__u64	corrupted;	/* packets with bit errors injected   */
+	__u64	duplicated;	/* duplicate packets generated        */
+	__u64	reordered;	/* packets sent out of order          */
+	__u64	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
+	__u64	allocation_errors;
+};
+
 /* DRR */
 
 enum {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 699c734e4c8b..2433295c3920 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -152,6 +152,15 @@ struct netem_sched_data {
 		u8  state;
 	} clg;
 
+	/* Impairment counters */
+	u64			delayed;
+	u64			dropped;
+	u64			corrupted;
+	u64			duplicated;
+	u64			ecn_marked;
+	u64			reordered;
+	u64			allocation_errors;
+
 	/* Cold tail: slot reschedule config and the watchdog timer. */
 	struct tc_netem_slot	slot_config;
 	struct qdisc_watchdog	watchdog;
@@ -462,16 +471,21 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
-			qdisc_qstats_drop(sch); /* mark packet */
-		else
+		if (q->ecn && INET_ECN_set_ce(skb)) {
+			WRITE_ONCE(q->ecn_marked, q->ecn_marked + 1);
+		} else {
+			WRITE_ONCE(q->dropped, q->dropped + 1);
 			--count;
+		}
 	}
+
 	if (count == 0) {
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
@@ -488,8 +502,11 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * If we need to duplicate packet, then clone it before
 	 * original is modified.
 	 */
-	if (count > 1)
+	if (count > 1) {
 		skb2 = skb_clone(skb, GFP_ATOMIC);
+		if (!skb2)
+			WRITE_ONCE(q->allocation_errors, q->allocation_errors + 1);
+	}
 
 	/*
 	 * Randomized packet corruption.
@@ -500,8 +517,10 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
-			if (!skb)
+			if (!skb) {
+				WRITE_ONCE(q->allocation_errors, q->allocation_errors + 1);
 				goto finish_segs;
+			}
 
 			segs = skb->next;
 			skb_mark_not_on_list(skb);
@@ -510,11 +529,13 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (unlikely(!skb)) {
+			WRITE_ONCE(q->allocation_errors, q->allocation_errors + 1);
 			qdisc_qstats_drop(sch);
 			goto finish_segs;
 		}
 		if (skb_linearize(skb) ||
 		    (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb))) {
+			WRITE_ONCE(q->allocation_errors, q->allocation_errors + 1);
 			qdisc_drop(skb, sch, to_free);
 			skb = NULL;
 			goto finish_segs;
@@ -523,6 +544,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb->len) {
 			u32 offset = get_random_u32_below(skb->len);
 			skb->data[offset] ^= 1 << get_random_u32_below(8);
+			WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		}
 	}
 
@@ -604,12 +626,16 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 		cb->time_to_send = now + delay;
 		++q->counter;
+		if (delay)
+			WRITE_ONCE(q->delayed, q->delayed + 1);
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
 
@@ -1348,6 +1374,22 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
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
+		.allocation_errors = READ_ONCE(q->allocation_errors),
+	};
+
+	return gnet_stats_copy_app(d, &st, sizeof(st));
+}
+
 static int netem_dump_class(struct Qdisc *sch, unsigned long cl,
 			  struct sk_buff *skb, struct tcmsg *tcm)
 {
@@ -1410,6 +1452,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



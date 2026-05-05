Return-Path: <netdev+bounces-284537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DCWODks+mlXKgMAu9opvQ
	(envelope-from <netdev+bounces-284537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:43:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA524D23F6
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 19:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C7CB3094D45
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 17:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF844B8DC7;
	Tue,  5 May 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="hxuOu+A9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D954ADDAD
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002874; cv=none; b=XieZZx3sBTUohiAApskfcNOwyw9+iRUSCFZ/qiHrqKv0NdJFBDnpurmzk6FB1E1nuV89+vV9AdICvq/nsvIv4tVLkxRun4ykj/5aYHiEV2dyfK3Y8XSjhGnG6mLLmivPV7gn8SAnsn5pVyq1GrVrJF4nKFKI8TuAccSeSf76RpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002874; c=relaxed/simple;
	bh=EnTG8alGX62BlSaTh/EG/FYevc50EF3ylf4RTorWL54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLkw/0vcmUymq5hCVaspeT0DgQaqqTFO/RQrBpm1DjrZyLCzK0FvHRB1RISLU1aUMlDKZXd+p8iCWIwuAOT7anINYUe8Fp5bFyj1NNVxVRkkzJsdtEQeIJODLoHJD9y7LvZnnN1+VpAMOe33VkWov77eRV2QGP0DeRHEAyXF32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=hxuOu+A9; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45f053b7b90so3319793b6e.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778002872; x=1778607672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R33vpz8C7Nvv6zy2OI1gkQlfv6u57xiLq2UJ5nX01+4=;
        b=hxuOu+A9yyneRfW+YfvGppc8Gmdi1FXT5QyLH0fIgS35enUw94YXDj7MvkolAhTb51
         T1jwme2hMfPdtNa5bWouFETVSIKh4MTbzMtAQrVJAPBrMBbOt3w8SSbLT3U4nsWpyUJX
         MlnHOkci794+yHu1p3hNNeFiQcnGOgC3/EHJFmwepU/XvT/1jDTAs5Z5VAmmSyFWk5wU
         6ublOVM6bx6OCSEmURBAdaVwiuNfOJxhoy+MF1OcXqjxCD1dNF3zjjyA/Gbt+JmQ/j2h
         Mrh0tiHOdQmHKyI29qY/dpbjNIAT0oBrVox9u3C+cArhHmzbBZScyDgupP8WCSXMykFj
         WMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002872; x=1778607672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R33vpz8C7Nvv6zy2OI1gkQlfv6u57xiLq2UJ5nX01+4=;
        b=TARlc6+cCeaEP6P+ctr8vc8h9XOihsHPM+7aYnvz0m8cVnEma19Jr3qmOZFL3FwIb4
         xOKLPeb5bm5I65eOJd77ZInKawnCeKEK5wJb8pRckP+UbcFoYDDL5uwnd4R5ppDKLgen
         rz+NGIb+OVNEd+sERboReYRRDe5s6MwYxTr1W6uHbo3HvaspvIMOm4dth6fNRHL7Rkj+
         LEh/a8Bl3wc8tho9GbdQM0+st9SCZEQ/Y+LeloXTkbA23d0UyFmLxA1qKt6NwLdENCKT
         7GPAJR5TdLzPqPP+wdCwrW8ViIS7zc27z1DCRVyhDgEYnorpNx5Xg6/R7A/bwmCQAKbh
         Tm3w==
X-Gm-Message-State: AOJu0YxfIa+LlWddhxVXtuHUW3xPpb9a5oAygpXPe0eUbe81KKJjN5GG
	inQIJeLtUYMrVcugR/Ps0lpNLwlSu2U/cv87jtklRm48CFWP2mj1luCD2lZfJ+Jn+sVRiaura6e
	EWDe4
X-Gm-Gg: AeBDievuJEaedUpbVJyQg7M+FrNDWvLHbwx3I5G42iNNwZORaeaDAt18YKMFJkDH/qP
	h4/n4uGRVq7GXJvSGSsYAUuOcZWNgDaJz2ZNxi0CJoPhdTbCX5lzhI6ABYs6CoZ9UHZkeXxHMwC
	TjKkxemGokHiNwdxJlO9QaGJWqiz5TyEpLYEKLxIa6gVJXhjH/WSv4NiorKBpqudBbTPgs1naJh
	lzAfGg0IPZ/9IRIZDfJJ6AQHGNeHSaGSjiM3qvmH4LDKW9msV6hrYh/cBOO2PbHdFBLo9GBrW0B
	hobWq7tUj5OBYNh5oVUjaHTVKQWhldOFJsidpbGnN7LrOsPicE0aV0rLjKU7jCTViPX6jPk2+PN
	QRs5ajc8CpYaog2d9Ng3dA8jc3IcQnZ9Yv0c6hjoxzYEmE4aCZeJ9Coe43gczS08oDa9e++rjTA
	s2Gz3o/mC3vpso6lWM1fDF2KdnLhn2MDgHRdej/bQx0to=
X-Received: by 2002:a05:6808:1a21:b0:479:ac7d:6d94 with SMTP id 5614622812f47-4804247a9e7mr2740b6e.24.1778002871632;
        Tue, 05 May 2026 10:41:11 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769c9b12sm9006504b6e.17.2026.05.05.10.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:41:11 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/5] net/sched: netem: add per-impairment extended statistics
Date: Tue,  5 May 2026 10:38:45 -0700
Message-ID: <20260505174059.651260-6-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 5FA524D23F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284537-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

Adds new counters that keep track of when netem applied
impairments (delay, loss, corruption, duplication, reordering).
Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

Also fixes a pre-existing accounting bug: ECN CE-marked packets
were being counted as drops (that is not what other qdisc's do).
Instead, now that ther is a proper ecn_marked counter,
the spurious qdisc_qstats_drop() call can be removed.

These counters are for information only and follow the
access pattern done by other qdisc implementations.

Accompanying iproute2 change is submitted separately.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/pkt_sched.h |  9 +++++++++
 net/sched/sch_netem.c          | 36 ++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

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
index 020dbfb6e4a7..af6b95922a5d 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -152,6 +152,14 @@ struct netem_sched_data {
 		u8  state;
 	} clg;
 
+	/* Impairment counters */
+	u64			delayed;
+	u64			dropped;
+	u64			corrupted;
+	u64			duplicated;
+	u64			ecn_marked;
+	u64			reordered;
+
 	/* Cold tail: slot reschedule config and the watchdog timer. */
 	struct tc_netem_slot	slot_config;
 	struct qdisc_watchdog	watchdog;
@@ -462,17 +470,21 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng)) {
 		++count;
+		WRITE_ONCE(q->duplicated, q->duplicated + 1);
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
 		if (q->ecn && INET_ECN_set_ce(skb))
-			qdisc_qstats_drop(sch); /* mark packet */
+			WRITE_ONCE(q->ecn_marked, q->ecn_marked + 1);
 		else
 			--count;
 	}
+
 	if (count == 0) {
+		WRITE_ONCE(q->dropped, q->dropped + 1);
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
@@ -518,6 +530,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb->len) {
 			u32 offset = get_random_u32_below(skb->len);
 			skb->data[offset] ^= 1 << get_random_u32_below(8);
+			WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		}
 	}
 
@@ -599,12 +612,15 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
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
 
@@ -1345,6 +1361,21 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -1407,6 +1438,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



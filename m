Return-Path: <netdev+bounces-285572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE7DAkdE/WlDZwAAu9opvQ
	(envelope-from <netdev+bounces-285572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 649854F0AE2
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 04:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1733055D63
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056BD2AD20;
	Fri,  8 May 2026 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="AQuuTF4W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541224E4B4
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205597; cv=none; b=MPlPft3H49VeGamZgaR5NDzOdDyi1mHl2ozkwX+4nWGLZYGd1w9H5L23gRwfWM4KKq2aTCTSxTMhCtcESbe1WCQeqQIx65+xK5t6o6MiwxJEQzpFiEaQCURFcXLJTCJkA4c5zuRrJKIPTJJ6+98fGNzsgVpgfRXChyowr45jkEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205597; c=relaxed/simple;
	bh=zDZZU1Z3DfyjTFMKqFayRyXWNU+msBLAqyMWqy6Tf5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UCr+s2bXacZovu497MwDml0SJ8ZueFAaGqEqideimlCjLI125Zy9e3sDuJVHdwZlMZpGt4xi9hQpVPEdaziNETiwTdDuFJj4bCisTjcsbR8wpR/9sTtR99okNF0VvGo81tZjQJVvLTsGJrtdV4USmG/USoUU80ZRxGmwcvrhUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=AQuuTF4W; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef38cf04f0so1172342eec.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 18:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778205594; x=1778810394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ektXhM/nH1iZmXUIf3cTS2OfeEcpGx9AtCtI+vX/hM=;
        b=AQuuTF4WjkSlzEmFfO2CVYYtYq6kp/D9kdmTygrVbVPAUeBT7FCLu33ki4uCQjuiJh
         3uVhP5OqHD4V2MT4Ov7+upxqO0658/Clqemw8GiaotGSlgZVFgILaHxM6t48LjLNFpme
         G/Jbz5kbxxaPr+FFbjyZ/2fNUnFUtU6VFmRejk0CaksL2S+yuUOQ50DxXPjkwQrYN0kf
         Zj7AViW0RCs4Gvg0rV+PatY83fu41rJi6WlWE/OL1D1I63y24k7Ss+xuQ4R+fCZUf4lm
         oW6Jv3DIZt2ei9Rm6uV6IG6CNsHa/lY/PFIXWoieo79ENZnGQ5iq3/CH1oBw/PPPbuf9
         DKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778205594; x=1778810394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1ektXhM/nH1iZmXUIf3cTS2OfeEcpGx9AtCtI+vX/hM=;
        b=Gg3QIi44H/ZqmcvEZ7+DckddxFgvB61pisfOOEcij4wBXfTI+60tqPJplB4DSgzv6G
         v3gXkpFIuVzWtVqNV6p/dJOugPKBgTrADIIxhck7mC5uoEpCYZkZFkWij/JZrBkm+X9v
         yl6aMswH62tkj+BBXtXaFcoecAWhA+bwbgSkk6NgT7tqXAjEl6CVZXkeXqIQzs4VWWDI
         fuupPEMicJTEXR9DFBbrWQBr+ZoiJHDWOZaeLYR5CIYRBjSYK/16WjHh1MeycooJw0cw
         YFahagsYN5bMs94WugpuWEmzQiiHgqvo7uzCf5r88CKSJDAORFEjHkWwe29fLf/3JOLa
         fi1w==
X-Gm-Message-State: AOJu0YyuS2FLzG1CwXleLoHXGL6u/kTLZFnDEQ0i48FY7xCjfQSNflFZ
	qi0MMnYv8dlNuT2C5GpXNV1RmJCbfyU7wq9W0VF8VQXS0j19uYFdF5FagpmPalvQ3W64LZP07x8
	OSBOG
X-Gm-Gg: Acq92OGR8xeDByA45X0/AkKs2n8L/H9aZ/n2V5FQH4hKH4wUbGeBy+uMpvH8TeLyKYy
	4WQ4SJioCc2PA5FJPan353lSJHg6qFTvLVW4TmeRYf4JpGXuCL6675wXjQGB/usbNG24RvUVdrY
	tpgRaxQK4c9Mn4K9Q6oYE31Jn1t8eKyij7yiZuNy+kBKoBIjB6Lvchp3L9/MHpEA7Q60bfq1Nb/
	4VgJrRLc6zgGVhHE+vkkvNP6Oxxfgs6PtFY/gsFSqx5mWXURm9v2g60PpAjLkF1Co/YPu4rq58x
	lRifvzHEL61Ofl82kdScFH7DakDNQ2f3QUTB+b3GIPQb2L8xb5edv8G3fIv0uKFIGgwPI9QA985
	3nRMwfx6U8e/HjrzAgniP1qqXJAG95w22Ty9+XsRViP2BnwZCRrYmKfNs9fb4L23EOrSnDYdVGP
	xrBKFKdI0djzVJT3ZG7tF8+eTPrgeoyOFa8LqT3rfJgLY=
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr5287816eec.12.1778205594423;
        Thu, 07 May 2026 18:59:54 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm324090eec.15.2026.05.07.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 18:59:54 -0700 (PDT)
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
Subject: [PATCH v4 5/5] net/sched: netem: add per-impairment extended statistics
Date: Thu,  7 May 2026 18:55:21 -0700
Message-ID: <20260508015940.554462-6-stephen@networkplumber.org>
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
X-Rspamd-Queue-Id: 649854F0AE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Adds new counters that keep track of when netem applied
impairments (delay, loss, corruption, duplication, reordering).
Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

The READ_ONCE/WRITE_ONCE pairing here matches the model used
elsewhere for xstats in the qdisc layer.

Also fixes a pre-existing accounting bug: ECN CE-marked packets
were being counted as drops (that is not what other qdisc's do).
Instead, now that there is a proper ecn_marked counter,
the spurious qdisc_qstats_drop() call can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

Note to reviewers. The READ_ONCE/WRITE_ONCE pattern is allowed.
For some reason current AI prompts are obsessed with complaining
about 64 bit torn read/write on these, since the counters are
informational only, any such complaints are false positive.

Addition to iproute2 will be sent seperately.


 include/uapi/linux/pkt_sched.h |  9 +++++++++
 net/sched/sch_netem.c          | 37 ++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

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
index 37df05bf43ee..6d8f4c4cedf3 100644
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
@@ -523,6 +535,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (skb->len) {
 			u32 offset = get_random_u32_below(skb->len);
 			skb->data[offset] ^= 1 << get_random_u32_below(8);
+			WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		}
 	}
 
@@ -604,12 +617,16 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
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
 
@@ -1350,6 +1367,21 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -1412,6 +1444,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



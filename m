Return-Path: <netdev+bounces-283326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG/5EzpD9WmXJwIAu9opvQ
	(envelope-from <netdev+bounces-283326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:20:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 070CE4B0797
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 02:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F2643042407
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 00:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74901253B58;
	Sat,  2 May 2026 00:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="yzpNPLtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473122A7F0
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 00:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777681136; cv=none; b=dyzVi/fQE033FhAw6oWOZPSSHq98+S7e0TOBqq7eA69je6uIyhPfksIpcmQfjQrrUc4U0iFucWLoqYAmsNcTduwZwc+v5MeLCgbRc0QDAGiezRUtGbs3Ib6G3CwaUgJgxekoOGdIom5FPFPYlqRb/KE47cgDaOzoywnUWhA3JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777681136; c=relaxed/simple;
	bh=03X85ak6aFDdg+QjaCGxAhcr6g7GQHx1izWx1mPpeVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FjbS9rYAUuuBoN3h2/dqj5FRjcoWsK5G8ftqK08EEBa+vR2jAz7wtQWtcdF/J+hAck6EEoMHoKREAK3NE0F2yYwfytLFsMsDkpDuUhQyLv4Zvze2/qC+nE2vgj7XdMqjoX0fbZhC+Cgtyg8IpJefQ6Zse1wqoiCttxEhDtpoQOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=yzpNPLtq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so4458744eec.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 17:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777681133; x=1778285933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Fo0R2O/NW/7EIp8nuaTunWiLomiuWqyBBw33q7U+4o=;
        b=yzpNPLtqgJJy+KW5URw0CWZ2QZYyjwLjY+kTOW10+9stMwlXf/On7fZCyX9uaDhWCk
         YihwUfbFNUO+HGNOjSUjNtg1kJ+uYiBx7VTvKqTgZXb8qrYGz174lNdAWI5G42Zxksl0
         YDOGrk9qieuLJFJk38J3FJqmour7Rf2vsbmPnxs7uTvdkj4XUHnB4+XAZDxYR9Ym5ktz
         xis2j652g0mDxMCWJSdJdSMrh3bGTwgzlIwL8sPFvA7Tjs8dzmYvB97sxLm+dLx0EQbB
         SoCeW3SScJaHcRQlraheI4nHXWGXlDXuZ6p+ip5/MDb8jL45pDcu5xDc9nUSNuu9U/Pc
         gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777681133; x=1778285933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Fo0R2O/NW/7EIp8nuaTunWiLomiuWqyBBw33q7U+4o=;
        b=jfPr6MtZ1Z1Gf6B/OlajBs+YhVvjQfvu2O5+78aUYdQ4Toe5FbHnXVpjnsLLJx+oY0
         WIWysIzVteIBCWOdBMMpKnjQzRis/WhDdg0aRB7cASzx1nbuStrfYAdjWlw/C6faot+V
         0Ghi7YKTc9E3duA8YHVEKEwsYDKuFBVQath5Rqjyh2SmH7vcmv0ukcpUWXB/j4YVW9HJ
         SSluKxJXs74eVVdLikw2MQ0h0dYHgJ5wbJ3W3S3HwZYLtn0MVPgzz6nf1ebQv3VuQEqI
         bucU1gfk5e16+7Prc2yVDPUQSM9f19GclHlN7+7NYDJqnEdUUZViZGGmZGcwYfzcayrJ
         t5ig==
X-Forwarded-Encrypted: i=1; AFNElJ8HeJJ7SnT0qhN5MECrAoUOf3suARaFYGyg5vxhOXGkwqG7b9RMTqloJmNXdWDJ0ERLOxAtLDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtphohahhtWRj3+TRcmLpZSVIZwrcZw4fD8uo7VAoHDCWhIdAp
	83pSRAWwf2nO53cNvwLD+7vwhC5dXB4on8p1HgCT4Pa8UUAqdvry0SKTa9ccqZeJrLM=
X-Gm-Gg: AeBDietJQQJZQvQQFwgTg9klKlBKhEfHTb98mSvvzTfE/O+MkRUkbiWDtj8NY4jnN2z
	2FyHbbwqg9gwKAhSawj07WmcNQRKyPQfH9R+Z0p74ciX2JHofdFJHNsGlQRgxk8tw/YytyjP9+i
	nmHU2tWyFkVq/G0blIAWYDbNf8jGa49NPrrtmMeIXZz8C2iwVJ392C1TNAdwWNBkl213oN0QROn
	gkCKXYCWr6ym3wrn/UwClfVtGscmvmTvHPbZvQLn638lr2nbt57tzfeomK3wAZ07LQvK/AI02Ps
	NpqYyzqLGIRfLet1HaBSvdU++hR1hQdAL3AEySQy/gzmuBl8YW01stu4OHWpga6S3AXjvFoVeun
	pL0HsHo28e6L6wSc6MfwwDTom/17xkmxKZCE7q8aeUQ4KMgomjRbQsOtWmffxNu4GUN9rnB3OTk
	sJJKtJboe4KNLzdi28rWelnYFnhR4ZZXrSGA7jni1UScI=
X-Received: by 2002:a05:7300:690a:b0:2e7:120:137b with SMTP id 5a478bee46e88-2efb4f2c0f8mr695595eec.0.1777681133126;
        Fri, 01 May 2026 17:18:53 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2e0sm6419484eec.16.2026.05.01.17.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:18:52 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/4] netem: add per-impairment extended statistics
Date: Fri,  1 May 2026 17:17:12 -0700
Message-ID: <20260502001844.19107-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502001844.19107-1-stephen@networkplumber.org>
References: <20260502001844.19107-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 070CE4B0797
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283326-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email]

Adds new counters that keep track of when netem applied
impairments (delay, loss, corruption, duplication, reordering).
Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

Use the WRITE_ONCE/READ_ONCE pattern to allow for lockless
qdisc usage.

Accompanying iproute2 change is submitted separately.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/pkt_sched.h |  9 ++++++++
 net/sched/sch_netem.c          | 40 +++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

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
index 116e96d79ddf..c871c7a3b117 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -152,6 +152,14 @@ struct netem_sched_data {
 	} slot;
 
 	struct disttable *slot_dist;
+
+	/* Per-impairment counters */
+	__u64	delayed;
+	__u64	dropped;
+	__u64	corrupted;
+	__u64	duplicated;
+	__u64	reordered;
+	__u64	ecn_marked;
 };
 
 /* Time stamp put into socket buffer control block
@@ -459,17 +467,23 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -495,6 +509,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * do it now in software before we mangle it.
 	 */
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
+		WRITE_ONCE(q->corrupted, q->corrupted + 1);
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -600,12 +615,15 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
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
 
@@ -1344,6 +1362,21 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
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
@@ -1406,6 +1439,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



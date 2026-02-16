Return-Path: <netdev+bounces-258912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFbRICo4k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:30:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 006641459A7
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A4743005E87
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3933033C;
	Mon, 16 Feb 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC68oIR8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E8330329;
	Mon, 16 Feb 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771255847; cv=none; b=hTSxh1pjwaAryq+VWqQfe2OU0gY5lBpy5HFF3322845CHSS68oJPrmw+Ojwr6YkQTn4EeVcaqqkEVZ3RhQvR4I5O6WvT2OCecdI56Jmk8hsWOu0JezfbrDh4GVo+PQo1zsXyj6GbihtA7ZWqBsFETbm+OowXrqi5qCv9BXbufK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771255847; c=relaxed/simple;
	bh=PIGMkmdv49cS95Y7wuDl9V2A1m/OZtDH7JrRw1dIPcA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RFSBSUgrod50TME25cHiZLzguybPQwlgHTyS1eLi3hQgOGAh2FFziAH+xJOwBFlyVWpsWZPDin+mEsTOX2jbuy8WOj1XQacsU3VVKqYBltiB52Yq3QH3lssCjE577GJw+XZaew7kPEqKFLG+r4RSCwcw5Zhl912r5DHt43bEQ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC68oIR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3106AC116C6;
	Mon, 16 Feb 2026 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771255847;
	bh=PIGMkmdv49cS95Y7wuDl9V2A1m/OZtDH7JrRw1dIPcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tC68oIR80rNhDk2nMmYq7p6ywQpfu93Ah6jadJ0JHqI3jnPYJA6lcIlecl+F8ZIvW
	 NiTFyJzJ2TGX7tRhYudkQKZEAzxbCpm2/FVIz4WLbg4WzoO54WhVkyowegJBYR5XQG
	 r7NdIyiBiOCPaJX8Ysd7Ieoc1xEWwxUiY9/vy0g0sj3k5L1dHvlPVb+gz7R5rcEFzu
	 o7xVvsxvjNzFvJqK39TVDpZe6fM3UDKLc1+Osh4OE9zw6ER9ZUqqsC4MCGqLFbxns5
	 88k0o4yVgB37Dee+5nGCR41yU5Y6ArbsW0wMs6W5qU77EMgDdFILGM9AafIWStT3B1
	 jBRlSO8qWfP8g==
Subject: [PATCH net-next v4 3/5] net: sched: rename QDISC_DROP_FQ_* to generic
 names
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Mon, 16 Feb 2026 16:30:42 +0100
Message-ID: <177125584235.2500844.14186567555259783733.stgit@firesoul>
In-Reply-To: <177125575993.2500844.8718737675156179479.stgit@firesoul>
References: <177125575993.2500844.8718737675156179479.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258912-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 006641459A7
X-Rspamd-Action: no action

Rename FQ-specific drop reasons to generic names:
- QDISC_DROP_FQ_BAND_LIMIT -> QDISC_DROP_BAND_LIMIT
- QDISC_DROP_FQ_HORIZON_LIMIT -> QDISC_DROP_HORIZON_LIMIT

This follows the principle that drop reasons should describe the drop
mechanism rather than being tied to a specific qdisc implementation.
These concepts (priority band limits, timestamp horizon) could apply
to other qdiscs as well.

Remove the local macro define FQDR() and instead use the
full QDISC_DROP_* name to make it easier to navigate code.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/dropreason-qdisc.h |   19 ++++++++++---------
 net/sched/sch_fq.c             |    7 ++-----
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/net/dropreason-qdisc.h b/include/net/dropreason-qdisc.h
index 02a9f580411b..a167302e79e5 100644
--- a/include/net/dropreason-qdisc.h
+++ b/include/net/dropreason-qdisc.h
@@ -11,8 +11,8 @@
 	FN(CONGESTED)			\
 	FN(MAXFLOWS)			\
 	FN(CAKE_FLOOD)			\
-	FN(FQ_BAND_LIMIT)		\
-	FN(FQ_HORIZON_LIMIT)		\
+	FN(BAND_LIMIT)		\
+	FN(HORIZON_LIMIT)		\
 	FN(FLOW_LIMIT)			\
 	FNe(MAX)
 
@@ -74,16 +74,17 @@ enum qdisc_drop_reason {
 	 */
 	QDISC_DROP_CAKE_FLOOD,
 	/**
-	 * @QDISC_DROP_FQ_BAND_LIMIT: FQ (Fair Queue) dropped packet because
-	 * the priority band's packet limit was reached. Each priority band
-	 * in FQ has its own limit.
+	 * @QDISC_DROP_BAND_LIMIT: packet dropped because the priority band's
+	 * limit was reached. Used by qdiscs with priority bands that have
+	 * per-band packet limits (e.g., FQ).
 	 */
-	QDISC_DROP_FQ_BAND_LIMIT,
+	QDISC_DROP_BAND_LIMIT,
 	/**
-	 * @QDISC_DROP_FQ_HORIZON_LIMIT: FQ dropped packet because its
-	 * timestamp is too far in the future (beyond the configured horizon).
+	 * @QDISC_DROP_HORIZON_LIMIT: packet dropped because its timestamp
+	 * is too far in the future (beyond the configured horizon).
+	 * Used by qdiscs with time-based scheduling (e.g., FQ).
 	 */
-	QDISC_DROP_FQ_HORIZON_LIMIT,
+	QDISC_DROP_HORIZON_LIMIT,
 	/**
 	 * @QDISC_DROP_FLOW_LIMIT: packet dropped because an individual flow
 	 * exceeded its per-flow packet/depth limit. Used by FQ and SFQ qdiscs
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index eb5ae2b15cc0..9a550f832d78 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -539,8 +539,6 @@ static bool fq_packet_beyond_horizon(const struct sk_buff *skb,
 	return unlikely((s64)skb->tstamp > (s64)(now + q->horizon));
 }
 
-#define FQDR(reason) QDISC_DROP_FQ_##reason
-
 static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		      struct sk_buff **to_free)
 {
@@ -552,7 +550,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	band = fq_prio2band(q->prio2band, skb->priority & TC_PRIO_MAX);
 	if (unlikely(q->band_pkt_count[band] >= sch->limit)) {
 		q->stat_band_drops[band]++;
-		return qdisc_drop_reason(skb, sch, to_free, FQDR(BAND_LIMIT));
+		return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_BAND_LIMIT);
 	}
 
 	now = ktime_get_ns();
@@ -564,7 +562,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			if (q->horizon_drop) {
 				q->stat_horizon_drops++;
 				return qdisc_drop_reason(skb, sch, to_free,
-							 FQDR(HORIZON_LIMIT));
+							 QDISC_DROP_HORIZON_LIMIT);
 			}
 			q->stat_horizon_caps++;
 			skb->tstamp = now + q->horizon;
@@ -603,7 +601,6 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	return NET_XMIT_SUCCESS;
 }
-#undef FQDR
 
 static void fq_check_throttled(struct fq_sched_data *q, u64 now)
 {




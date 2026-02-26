Return-Path: <netdev+bounces-261357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNZIEJtPoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:50:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B381A6F7C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6E9930E11C4
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAC32A3D1;
	Thu, 26 Feb 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klBuuhm9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BEA26CE2D;
	Thu, 26 Feb 2026 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113474; cv=none; b=Z+JdoNDjMRidqIzz7WUXxV65JWakIzvtV0EprL3X6Qmo8hhVnyoVoOPMmeLHZG9g6MF59hMSW3pwANP4G+uNf5GpM18UUsJ7jUIdIZhP+akZDYEPXjF3A7eT8BhSwFTGKyT2OYZkOJIVH55VTuY6lgrthSNjWemz6BP44huxUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113474; c=relaxed/simple;
	bh=PIGMkmdv49cS95Y7wuDl9V2A1m/OZtDH7JrRw1dIPcA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVcVYXYN4bMZ9sBhoQ+C8EZ9kK5rM9DjUJh8d3+UEyM0xtTUKwV+8LrTFKXuEnkPBpIORUswzttnj1hOpHqoPEHhNvCI99I93mDRqUwh/sTvUokpLDw5rcRllGjPpchKWfTwJpCRWF3zWuy9ChuhVxQUUZWqlcMKYQ7TbobpmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klBuuhm9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A62C116C6;
	Thu, 26 Feb 2026 13:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113474;
	bh=PIGMkmdv49cS95Y7wuDl9V2A1m/OZtDH7JrRw1dIPcA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=klBuuhm9RyPIvzpPSYXG2ODnunKdAePCAc2wvtcoNwpHz581tvZZIIYyuL9mcSc9R
	 BZb1XxDRedyMV1JSespR2oWP2mparZiY8tr4xwi633mCzCiJ4ny0lICa4EAvjzL4xT
	 TOd+FL9bysTXYFwozuvdaae6v9kGRUWvdMSPo4hKBkqnsiTcx9WyLVpxNJ9zSfrWlf
	 LuQ7C2aHZCzKvxxlsfoxDO4uHIWJ/TvqIaHiFH2pnufLMJX+2NFmPqmg83CWNTXd2+
	 4pU69Qxb7MJX5qtAKIN8cYVEJryUUUnYuhHOhrTXq4aKGopoJDUHnbXYibCRliOehD
	 YuASJAe80FHAA==
Subject: [PATCH net-next v5 3/5] net: sched: rename QDISC_DROP_FQ_* to generic
 names
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Date: Thu, 26 Feb 2026 14:44:29 +0100
Message-ID: <177211346902.3011628.12523261489552097455.stgit@firesoul>
In-Reply-To: <177211325634.3011628.9343837509740374154.stgit@firesoul>
References: <177211325634.3011628.9343837509740374154.stgit@firesoul>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261357-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,davemloft.net,redhat.com,toke.dk];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0B381A6F7C
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




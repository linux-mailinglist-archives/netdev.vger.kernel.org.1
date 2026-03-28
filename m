Return-Path: <netdev+bounces-272794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM7QNnsdyGkShAUAu9opvQ
	(envelope-from <netdev+bounces-272794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:27:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469334F913
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC990304B39B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74753A451F;
	Sat, 28 Mar 2026 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="iwQZr9dB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547233A75B7
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722227; cv=none; b=mDgGfM/Iy5IT92P4vEtCOT/Y07MF/k7o4IK+II8GzJRZubcdamMrlcLXeFEfYNn57QOrLiS1fOG9Z71f3VAkh1LkqbdG4IX5wWnRdxJEc5vD7NSIKh0tAO6p4B4SOmXC8tsKbB1j3IKX6PgHT46q+Lc/JT4Sjga1RRN5uIjl/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722227; c=relaxed/simple;
	bh=TOAKlDfWzkgQtJ9z1HH1Fm0oFhes+H4PHDuXFVXaQj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/BY5+dmAzgnTKI5Dv+qK+Sc+yPHohD7PTR9i3jwjA/fn058Ku0oyxFlDOSq9G5Z7XPnhbkXApW8FNiL0Kr7oQqXI4Vv65GR/3pw+NGmHyitrQXjN/jRi+1H06WloslFdXY66qeuK7bzC7NUUvgzTTSft/R0saqK6NT+8HxL3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=iwQZr9dB; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9694so3705568c88.1
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722225; x=1775327025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muqqZpGr47aKejirv9NV6VhTuEnxkRoIgVczQSZpOIU=;
        b=iwQZr9dBx57bWYQuPp7yK5lTCiZfqOrhEmIy/S26qHcifWMFAXFcIVJ5GRRaaQ6Xt1
         fsZ4NsQW3vifRgILWQLuHqnwkAC+OEr9vuLSrWtiTLffs9FEblFhx485Lc1tR43xjOZQ
         HZJv6Cgn6ldz48PRt1ZJpVvtXGA5CqervvL5WtRZkKe+xXtSUYqWccsXSkVPQJDbWOSq
         v83NhK9HIP7D8masXBsJ07TIbfF9RncLwc3bdBpMMXA5dqlsj39a0svpYa+Tei+owXJ+
         DQUCY8dSrZNfdV8XIhyL75KsjHO96VzAVPOeicdhdThsdPHztef1J6Ovlpyj5WraJK6j
         aekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722225; x=1775327025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muqqZpGr47aKejirv9NV6VhTuEnxkRoIgVczQSZpOIU=;
        b=lir1GcEdOVGXQpMvPP24gmXPXzHBbNy3F+mPZwsGPW1N8Ddq8Rolgb/asVgfw+50uB
         ReLyIwax2RbN4IhedXog9MP0w55+DvlQkgVSao5KFt+sWGfNTnQ3VwVK5vaekrb4l6AB
         aMVOR6LcdBvtYX9lMa+PxCLNKkCFzLNOZQzlEj1qyst4p9qjvoJK3N5OcnW0ftZKetZl
         lvRhijz9FnEUXJpbiAVtMmA3148cVbi+6yx7LscURjlijEAuubw7JRvSQcJVY1W7Q+MC
         5MqwgWLJ7AboZIJqeW6L09SGW4lRRDRQC/4Yx9y5Hr2orma7LhcN/Ka/bHLmiTonpt5Y
         HeIw==
X-Gm-Message-State: AOJu0Yxh322WQYRAHeoyo6XaNiUw+amaNA3KMCboghS+OIw7+r0liJl8
	vx8t/dx4DXeEUaMdSeaCkC3kVTvYbCF9U9FjBmAfGztYoNFVdy06qPfF4XlbUv6z5Za1DER/90v
	2RONA
X-Gm-Gg: ATEYQzz/46XigoPnPLj45Snh9Pt8MxC6MJRc9wpLHnplz1K65SiJyK38hsV+sFGlmDb
	xzu84XwDZc1rN6VtBrcWnI7gvTh4WoF5uP0buWbyraGxkDFcR1A+msgMJf5SsXOpWBvneL+nwb7
	ZYn10CQ7l2JsPR/67SfR/YQCHPW5szZCSTK+6m1c4DHuXMneC0OJycZb7YarODauAkdVsTXjBIl
	27vvI85HUKouxKNJr2RsHdD1HUxrTZOrvTOHVmVKj01F9FWGbYqZJwe7TfXS2MeETHAfN38s5FV
	OHiB4M0kaPf+KEZ0pOiOzO84rs+0IOXV/g4j3UZ7TzBin7FXBKWpzHrwl84kwZBPKeGAx2px5rv
	IGmqomVsiYrVUbwYfaeiqBRguDNRGk5AsYKs3WfVec9QrIOM+D410pas1mvf7jdi9GbfbT0o8GK
	mndOYIgCyjVVALyDywaJqbESB6d7EdOD/9
X-Received: by 2002:a05:7022:b98:b0:128:d967:466c with SMTP id a92af1059eb24-12ab28e4c8amr3659107c88.24.1774722225390;
        Sat, 28 Mar 2026 11:23:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aba581027sm3133008c88.4.2026.03.28.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:23:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 4/5] net/sched: netem: restructure dequeue to avoid re-entrancy with child qdisc
Date: Sat, 28 Mar 2026 11:21:48 -0700
Message-ID: <20260328182336.392817-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182336.392817-1-stephen@networkplumber.org>
References: <20260328182336.392817-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272794-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4469334F913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_dequeue() enqueues packets into its child qdisc while being
called from the parent's dequeue path. This causes two problems:

- HFSC tracks class active/inactive state on qlen transitions.
  A child enqueue during dequeue causes double-insertion into
  the eltree (CVE-2025-37890, CVE-2025-38001).

- Non-work-conserving children like TBF may refuse to dequeue
  packets just enqueued, causing netem to return NULL despite
  having backlog. Parents like DRR then incorrectly deactivate
  the class.

Split the dequeue into helpers:

  netem_pull_tfifo()    - remove head packet from tfifo
  netem_slot_account()  - update slot pacing counters
  netem_dequeue_child() - batch-transfer ready packets to the
                          child, then dequeue from the child
  netem_dequeue_direct()- dequeue from tfifo when no child

When a child qdisc is present, all time-ready packets are moved
into the child before calling its dequeue. This separates the
enqueue and dequeue phases so the parent sees consistent qlen
transitions.

Fixes: 50612537e9ab ("netem: fix classful handling")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 201 +++++++++++++++++++++++++++---------------
 1 file changed, 128 insertions(+), 73 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 448097fc88a4..ce12b64603b2 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -688,99 +688,154 @@ static struct sk_buff *netem_peek(struct netem_sched_data *q)
 	return q->t_head;
 }
 
-static void netem_erase_head(struct netem_sched_data *q, struct sk_buff *skb)
+/*
+ * Pop the head packet from the tfifo and prepare it for delivery.
+ * skb->dev shares the rbnode area and must be restored after removal.
+ */
+static struct sk_buff *netem_pull_tfifo(struct netem_sched_data *q,
+					struct Qdisc *sch)
 {
-	if (skb == q->t_head) {
+	struct sk_buff *skb;
+
+	if (q->t_head) {
+		skb = q->t_head;
 		q->t_head = skb->next;
 		if (!q->t_head)
 			q->t_tail = NULL;
 	} else {
-		rb_erase(&skb->rbnode, &q->t_root);
+		struct rb_node *p = rb_first(&q->t_root);
+
+		if (!p)
+			return NULL;
+		skb = rb_to_skb(p);
+		rb_erase(p, &q->t_root);
 	}
+
+	q->t_len--;
+	skb->next = NULL;
+	skb->prev = NULL;
+	skb->dev = qdisc_dev(sch);
+
+	return skb;
 }
 
-static struct sk_buff *netem_dequeue(struct Qdisc *sch)
+/* Update slot pacing counters after releasing a packet */
+static void netem_slot_account(struct netem_sched_data *q,
+			       const struct sk_buff *skb, u64 now)
+{
+	if (!q->slot.slot_next)
+		return;
+
+	q->slot.packets_left--;
+	q->slot.bytes_left -= qdisc_pkt_len(skb);
+	if (q->slot.packets_left <= 0 || q->slot.bytes_left <= 0)
+		get_slot_next(q, now);
+}
+
+/*
+ * Transfer all time-ready packets from the tfifo into the child qdisc,
+ * then dequeue from the child.  Batching the transfers avoids calling
+ * qdisc_enqueue() inside the parent's dequeue path, which confuses
+ * parents that track active/inactive state on qlen transitions (HFSC).
+ */
+static struct sk_buff *netem_dequeue_child(struct Qdisc *sch)
 {
 	struct netem_sched_data *q = qdisc_priv(sch);
+	u64 now = ktime_get_ns();
 	struct sk_buff *skb;
 
-tfifo_dequeue:
-	skb = __qdisc_dequeue_head(&sch->q);
-	if (skb) {
-deliver:
-		qdisc_qstats_backlog_dec(sch, skb);
-		qdisc_bstats_update(sch, skb);
-		return skb;
-	}
-	skb = netem_peek(q);
-	if (skb) {
-		u64 time_to_send;
-		u64 now = ktime_get_ns();
-
-		/* if more time remaining? */
-		time_to_send = netem_skb_cb(skb)->time_to_send;
-		if (q->slot.slot_next && q->slot.slot_next < time_to_send)
-			get_slot_next(q, now);
-
-		if (time_to_send <= now && q->slot.slot_next <= now) {
-			netem_erase_head(q, skb);
-			q->t_len--;
-			skb->next = NULL;
-			skb->prev = NULL;
-			/* skb->dev shares skb->rbnode area,
-			 * we need to restore its value.
-			 */
-			skb->dev = qdisc_dev(sch);
-
-			if (q->slot.slot_next) {
-				q->slot.packets_left--;
-				q->slot.bytes_left -= qdisc_pkt_len(skb);
-				if (q->slot.packets_left <= 0 ||
-				    q->slot.bytes_left <= 0)
-					get_slot_next(q, now);
-			}
+	while ((skb = netem_peek(q)) != NULL) {
+		struct sk_buff *to_free = NULL;
+		unsigned int pkt_len;
+		int err;
 
-			if (q->qdisc) {
-				unsigned int pkt_len = qdisc_pkt_len(skb);
-				struct sk_buff *to_free = NULL;
-				int err;
-
-				err = qdisc_enqueue(skb, q->qdisc, &to_free);
-				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS) {
-					if (net_xmit_drop_count(err))
-						qdisc_qstats_drop(sch);
-					sch->qstats.backlog -= pkt_len;
-					sch->q.qlen--;
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
-				}
-				goto tfifo_dequeue;
-			}
+		if (netem_skb_cb(skb)->time_to_send > now)
+			break;
+		if (q->slot.slot_next && q->slot.slot_next > now)
+			break;
+
+		skb = netem_pull_tfifo(q, sch);
+		netem_slot_account(q, skb, now);
+
+		pkt_len = qdisc_pkt_len(skb);
+		err = qdisc_enqueue(skb, q->qdisc, &to_free);
+		kfree_skb_list(to_free);
+		if (unlikely(err != NET_XMIT_SUCCESS)) {
+			if (net_xmit_drop_count(err))
+				qdisc_qstats_drop(sch);
+			sch->qstats.backlog -= pkt_len;
 			sch->q.qlen--;
-			goto deliver;
+			qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 		}
+	}
 
-		if (q->qdisc) {
-			skb = q->qdisc->ops->dequeue(q->qdisc);
-			if (skb) {
-				sch->q.qlen--;
-				goto deliver;
-			}
-		}
+	skb = q->qdisc->ops->dequeue(q->qdisc);
+	if (skb)
+		sch->q.qlen--;
 
-		qdisc_watchdog_schedule_ns(&q->watchdog,
-					   max(time_to_send,
-					       q->slot.slot_next));
-	}
+	return skb;
+}
 
-	if (q->qdisc) {
-		skb = q->qdisc->ops->dequeue(q->qdisc);
-		if (skb) {
-			sch->q.qlen--;
-			goto deliver;
-		}
+/* Dequeue directly from the tfifo when no child qdisc is configured. */
+static struct sk_buff *netem_dequeue_direct(struct Qdisc *sch)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+	u64 time_to_send;
+	u64 now;
+
+	skb = netem_peek(q);
+	if (!skb)
+		return NULL;
+
+	now = ktime_get_ns();
+	time_to_send = netem_skb_cb(skb)->time_to_send;
+
+	if (q->slot.slot_next && q->slot.slot_next < time_to_send)
+		get_slot_next(q, now);
+
+	if (time_to_send > now || q->slot.slot_next > now)
+		return NULL;
+
+	skb = netem_pull_tfifo(q, sch);
+	netem_slot_account(q, skb, now);
+	sch->q.qlen--;
+
+	return skb;
+}
+
+static struct sk_buff *netem_dequeue(struct Qdisc *sch)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+	struct sk_buff *skb;
+
+	/* First check the reorder queue */
+	skb = __qdisc_dequeue_head(&sch->q);
+	if (skb)
+		goto deliver;
+
+	if (q->qdisc)
+		skb = netem_dequeue_child(sch);
+	else
+		skb = netem_dequeue_direct(sch);
+
+	if (skb)
+		goto deliver;
+
+	/* Nothing ready — schedule watchdog for next packet */
+	skb = netem_peek(q);
+	if (skb) {
+		u64 time_to_send = netem_skb_cb(skb)->time_to_send;
+
+		qdisc_watchdog_schedule_ns(&q->watchdog,
+					   max(time_to_send, q->slot.slot_next));
 	}
 	return NULL;
+
+deliver:
+	qdisc_qstats_backlog_dec(sch, skb);
+	qdisc_bstats_update(sch, skb);
+	return skb;
 }
 
 static void netem_reset(struct Qdisc *sch)
-- 
2.53.0



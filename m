Return-Path: <netdev+bounces-274686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aATMOlPQzmmRqQYAu9opvQ
	(envelope-from <netdev+bounces-274686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDF38DEBC
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 22:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FE6030A8569
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8838C2CC;
	Thu,  2 Apr 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tyssuoWu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64F38839D
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161271; cv=none; b=pVb/uSBXnrMwVeoXXEGZDl0tDv72lhEw/YxIg/cIVGqxdMen3ATGhJ80FIVHGeVK93kBwScw2ih6LTrD6DUUYADQjK3tPEGzvxx7v3YU6+EbKpRgq4hanjEu3IWxTavZWRNCfVtT+3amiE6e7V1sL+I7L7tOuHepjaW5z7hF7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161271; c=relaxed/simple;
	bh=7TJYTLuF4sHA0EmD+U6zjmSvI+LNfwNGb257beaOCMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCfSwgaBjOODyQbkGcSZB9K/j0DYsVG/4rC2D9xc7WFrhiX8vXznNKCx4TIadB7IcPJ5aFjZhAPpkJi8XMLrwqYRclDyYA1QSprGjAZFNOgWggBjCWL6MxPlu6Ww2mzWmXkIWLY2M9gSfbXZ1O8U+0CRQVpAWlXAKB2RH2SFIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tyssuoWu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c741db5d610so452084a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 13:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1775161269; x=1775766069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hBa0wPZWS88g78DRr5aUdb+T0deoLeGFO+Tb4NXLo4=;
        b=tyssuoWuP9EbDdumhyOqIwDVPnj0o5axLia6DWXxQ1A4CKNPJ9jHgvrFUyauoursZr
         hWVS6/2ke3KMQJiN5nNDq83moGiNS1k0lpnAZhU1G1LwmBYzE4SfPweJaCrbd+MgslnP
         FLNi4cElMKZAnb0TR2rxB//7aYjV783bx2xcoEHEDMIwbXP4dmJWrYIeAY1GEh7pyIWo
         kSPAu7+vmrN4Ly9otDdu2mxIGn+WYAsfWliHJWUbp+Al7/hvoVxVAf+Mn23sZdI0gs7h
         AvNHNCN36ObNidBUSjGWz53oN43XmZm4uCZK5ImdM4VzMiOMaYF90Bitt05Tl2Jv4Onx
         BfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775161269; x=1775766069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9hBa0wPZWS88g78DRr5aUdb+T0deoLeGFO+Tb4NXLo4=;
        b=M+MCN4Y63PXqTN/W+tCPWKa+OXf59/JvuH6EHdIpJQa+VlhH9sOFRoR3LZGUaRy2Fb
         IDH7WaAMMQzu8DM+RHYpZ3Xinz9EhL8pnIpMVfMEpB5KzNYprRwqvesO98piZ9G1eqVx
         NiRb/EwKcJgVRZuIuHoE1oNVUxRCp8cMHMF93dgXQvfLesqTvgj1+rIa7/18leeEy2f+
         QQ0Typpyid00yyH7P+jv3Sq5M4I5gq2rXjgxvy/rWSYp1BC5LClSbv2zmmifLukf97Yr
         5zYEfANqLcu+iT6MSTP+NR5GwW4vQsjNBvbNEqw8aXCwKS2Zsgh+NgKetMs8m1mDjMeq
         B+mA==
X-Gm-Message-State: AOJu0YyCO6nr61tZv95Dib6tFR1R027SgGz+FLuUdPL10nDpbkNPfJC6
	A5QsYBX6uepR7ZwotMAps1a81haC1YvEjlzJ5x5wud4oMt4tKs+lKpecTIPSS8sorKG5xfIwU/E
	o5TDJ
X-Gm-Gg: ATEYQzx35uhxw9XsKgrbh3ydxRghAdQ91TUHH5yzJtF/7tRdR+ZTY6CcuAuM4CzEkpX
	Zbzf6tQO+4PwdNKrgkOG7ff7bnTuh7mics8Btp1CSHoPoqqqogLr73HUcNhOyzMj0jRP+b97ypK
	RNmu7kuLIEcHoxvrE4vyBPXIfjRZGD5LCzqmT7RcAYIqvQN4bRSH8XHYxYUbWHlApEGzorCmkLc
	wf6K3jtohpNsqukAi5lzU1tOPWet2wuUijggwCf+fPlDzzdY0h2N6HpN6Z1H1+R3dY62v7ysije
	znuB7sWXtUNst+WAeEh63knuMLmhFJtn9F7wIi7CNzxL+hDcnv9EYmlukIBM6JvqKwnargUmKM/
	tH5LTWo5w6ltJrF2myTOHNRZNm12UZeMUqSLJEwmLzTZeZDK8phYo90b7NXVQvA32H13vpPo2c3
	1DAaGRjJwExurPi49BLFMdw7p2/3j8LpIr
X-Received: by 2002:a05:6a20:3d0a:b0:398:9c9e:996c with SMTP id adf61e73a8af0-39f2f3be49emr212093637.64.1775161268757;
        Thu, 02 Apr 2026 13:21:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm3345621a12.24.2026.04.02.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:21:08 -0700 (PDT)
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
Subject: [PATCH net v3 4/7] net/sched: netem: restructure dequeue to avoid re-entrancy with child qdisc
Date: Thu,  2 Apr 2026 13:19:32 -0700
Message-ID: <20260402202037.176299-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402202037.176299-1-stephen@networkplumber.org>
References: <20260402202037.176299-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274686-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3DDDF38DEBC
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
index 556f9747f0e7..b93f0e886a2b 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -689,99 +689,154 @@ static struct sk_buff *netem_peek(struct netem_sched_data *q)
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



Return-Path: <netdev+bounces-294624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yxpZJnLcH2pDrQAAu9opvQ
	(envelope-from <netdev+bounces-294624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:49:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EE56355FA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:49:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=DmHfAfxS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294624-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294624-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 827633088077
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF071400E01;
	Wed,  3 Jun 2026 07:25:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A565B3FE675
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471544; cv=none; b=tXAU0hkinGrUWj1QdnLdAqEPc8vWA5dWmXRWFzY9LriggVUADLcYP/koroDC73iw2d9wWHHBIblvlhcFfcecXYgB41VQLUW8443e/h8VKBLglNQPeuP8XhEooT2mbOwCkP2Xv7Sm51rZKZXiI9ciWsw+02pi4QPSa4VveJ/w8vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471544; c=relaxed/simple;
	bh=HYe614qMKq2sZiO1SMWKPJWYHLBEkjjTZAR4BXo0GCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFOr/5gFeAdz2+n9D07Iiipt8oJJbSp9h0JzQv0pKYiXyo1qoAOwzTlHxZysH8QAjOKP4a7/6jdHI6A1nllqTKJvsTqQTpmybdz4Z4fSsfnhBgNepGsnqz5jsSoZ9beuHxsLkMWucvE6stzN8LRi+Wsrr1wPg0ycU6BaJOzBZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=DmHfAfxS; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0h9j2XX2JpfUXM4ycXiooac/sZ7E+PW7+rvAlmRnvjo=;
	b=DmHfAfxSMou98KaFoRoWal+gWKd0rSoKsAV/njn4L6nHDDG6iCzdZgpMER0vkJyqm19iO1
	kIq8Xe+7O1sy2y56b9tD0iTxJ8w+i2foHfBYjl4Hsk4R3FNXXqw4JD8q50WR4gbT4YhTkc
	r5kK+nof8DP7eEITCz0A+nlH5sCzIasIjO0G0ro+cqD8uug32tiAaSirXCif3o0iBe4Plm
	HvchWXJbTzrUTKD/ByDDyFG0WZNUUB72sp8kUJg0XM+Dk9pP8f0aVZLqWcd9Naq9qTQIHs
	IVl+JMj36xBTZflqNGAyq9fKnIpFtrb0JEKHJRlXnG3wNKKFw+FcMy8MNIFAHw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 10/15] batman-adv: tp_meter: use locking for all congestion control variables
Date: Wed,  3 Jun 2026 09:25:21 +0200
Message-ID: <20260603072527.174487-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294624-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,narfation.org:email,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99EE56355FA

From: Sven Eckelmann <sven@narfation.org>

Some variables used atomic_t for concurrent access while others relied on
cwnd_lock, leading to an inconsistent locking model. This can be simplified
by:

* keeping all congestion control decisions inside the cc_lock
* variables which can be accessed without a lock must use
  READ_ONCE/WRITE_ONE

This is only possible, by extracting the congestion control logic from
batadv_tp_recv_ack() into a new helper batadv_tp_handle_ack(). Its
decisions are returned as a batadv_tp_ack_reaction enum value and then
applied by the caller. This separates the algorithm (deciding what to do)
from the mechanism (actually doing it).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 272 +++++++++++++++++++++++---------------
 net/batman-adv/types.h    |   8 +-
 2 files changed, 170 insertions(+), 110 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c088d88804533..e9ba1c45a285d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -143,14 +143,12 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * increased by MSS * MSS / CWND for every unique received ACK
  */
 static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
+	__must_hold(&tp_vars->cwnd_lock)
 {
-	spin_lock_bh(&tp_vars->cwnd_lock);
-
 	/* slow start... */
 	if (tp_vars->cwnd <= tp_vars->ss_threshold) {
 		tp_vars->dec_cwnd = 0;
 		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
-		spin_unlock_bh(&tp_vars->cwnd_lock);
 		return;
 	}
 
@@ -160,15 +158,11 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
 	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
 				   ((mss * mss) << 3) / tp_vars->cwnd);
-	if (tp_vars->dec_cwnd < (mss << 3)) {
-		spin_unlock_bh(&tp_vars->cwnd_lock);
+	if (tp_vars->dec_cwnd < (mss << 3))
 		return;
-	}
 
 	tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
 	tp_vars->dec_cwnd = 0;
-
-	spin_unlock_bh(&tp_vars->cwnd_lock);
 }
 
 /**
@@ -178,6 +172,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
  */
 static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
+	__must_hold(&tp_vars->cwnd_lock)
 {
 	long m = new_rtt;
 
@@ -197,14 +192,14 @@ static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 		tp_vars->rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
 	} else {
 		/* first measure getting in */
-		tp_vars->srtt = m << 3;	/* take the measured time to be srtt */
+		tp_vars->srtt = m << 3; /* take the measured time to be srtt */
 		tp_vars->rttvar = m << 1; /* new_rtt / 2 */
 	}
 
 	/* rto = srtt + 4 * rttvar.
 	 * rttvar is scaled by 4, therefore doesn't need to be multiplied
 	 */
-	tp_vars->rto = (tp_vars->srtt >> 3) + tp_vars->rttvar;
+	WRITE_ONCE(tp_vars->rto, (tp_vars->srtt >> 3) + tp_vars->rttvar);
 }
 
 /**
@@ -525,7 +520,8 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
-	mod_timer(&tp_vars->common.timer, jiffies + msecs_to_jiffies(tp_vars->rto));
+	mod_timer(&tp_vars->common.timer,
+		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->rto)));
 }
 
 /**
@@ -544,8 +540,11 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
+	spin_lock_bh(&tp_vars->cwnd_lock);
+
 	/* if the user waited long enough...shutdown the test */
 	if (unlikely(tp_vars->rto >= BATADV_TP_MAX_RTO)) {
+		spin_unlock_bh(&tp_vars->cwnd_lock);
 		batadv_tp_sender_shutdown(tp_vars,
 					  BATADV_TP_REASON_DST_UNREACHABLE);
 		return;
@@ -554,9 +553,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	/* RTO exponential backoff
 	 * Details in Section 5.5 of RFC6298
 	 */
-	tp_vars->rto <<= 1;
-
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	WRITE_ONCE(tp_vars->rto, tp_vars->rto * 2);
 
 	tp_vars->ss_threshold = tp_vars->cwnd >> 1;
 	if (tp_vars->ss_threshold < BATADV_TP_PLEN * 2)
@@ -565,14 +562,15 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
 		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
-		   atomic_read(&tp_vars->last_acked));
+		   tp_vars->last_acked);
 
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
 
+	WRITE_ONCE(tp_vars->last_sent, tp_vars->last_acked);
+
 	spin_unlock_bh(&tp_vars->cwnd_lock);
 
 	/* resend the non-ACKed packets.. */
-	tp_vars->last_sent = atomic_read(&tp_vars->last_acked);
 	wake_up(&tp_vars->more_bytes);
 
 	batadv_tp_reset_sender_timer(tp_vars);
@@ -670,6 +668,115 @@ static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 	return BATADV_TP_REASON_CANT_SEND;
 }
 
+/**
+ * enum batadv_tp_ack_reaction - expected reaction to ack packet
+ */
+enum batadv_tp_ack_reaction {
+	/** @BATADV_TP_ACK_REACTION_OLD_ACK: ignore old ack packet */
+	BATADV_TP_ACK_REACTION_OLD_ACK,
+
+	/** @BATADV_TP_ACK_REACTION_IGNORE: ignore duplicated ack but reset timer */
+	BATADV_TP_ACK_REACTION_IGNORE,
+
+	/** @BATADV_TP_ACK_REACTION_RESEND_WAKEUP: resend data and wakeup "more_bytes" */
+	BATADV_TP_ACK_REACTION_RESEND_WAKEUP,
+
+	/** @BATADV_TP_ACK_REACTION_WAKEUP: wakeup "more_bytes" */
+	BATADV_TP_ACK_REACTION_WAKEUP,
+};
+
+/**
+ * batadv_tp_handle_ack() - Calculate reaction to ACK and update congestion control
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tp_vars: the private data of the current TP meter session
+ * @recv_ack: received ACK seqno
+ * @mss: maximum segment size for transmission
+ *
+ * Return: expected reaction to this ack
+ */
+static enum batadv_tp_ack_reaction
+batadv_tp_handle_ack(struct batadv_priv *bat_priv,
+		     struct batadv_tp_sender *tp_vars,
+		     u32 recv_ack, size_t mss)
+	__must_hold(&tp_vars->cwnd_lock)
+{
+	enum batadv_tp_ack_reaction reaction;
+
+	if (batadv_seq_before(recv_ack, tp_vars->last_acked))
+		return BATADV_TP_ACK_REACTION_OLD_ACK;
+
+	/* check if this ACK is a duplicate */
+	if (tp_vars->last_acked == recv_ack) {
+		/* if this is the third duplicate ACK do Fast Retransmit */
+		if (tp_vars->dup_acks > 3)
+			return BATADV_TP_ACK_REACTION_IGNORE;
+
+		tp_vars->dup_acks++;
+		if (tp_vars->dup_acks != 3)
+			return BATADV_TP_ACK_REACTION_IGNORE;
+
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
+			return BATADV_TP_ACK_REACTION_IGNORE;
+
+		/* Fast Recovery */
+		tp_vars->fast_recovery = true;
+
+		/* Set recover to the last outstanding seqno when Fast Recovery
+		 * is entered. RFC6582, Section 3.2, step 1
+		 */
+		tp_vars->recover = tp_vars->last_sent;
+		tp_vars->ss_threshold = tp_vars->cwnd >> 1;
+		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+			   "Meter: Fast Recovery, (cur cwnd=%u) ss_thr=%u last_sent=%u recv_ack=%u\n",
+			   tp_vars->cwnd, tp_vars->ss_threshold,
+			   tp_vars->last_sent, recv_ack);
+		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 3 * mss,
+					       mss);
+		tp_vars->dec_cwnd = 0;
+		WRITE_ONCE(tp_vars->last_sent, recv_ack);
+
+		return BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
+	}
+
+	/* count the acked data */
+	atomic64_add(recv_ack - tp_vars->last_acked, &tp_vars->tot_sent);
+
+	/* reset the duplicate ACKs counter */
+	tp_vars->dup_acks = 0;
+
+	if (tp_vars->fast_recovery) {
+		/* partial ACK */
+		if (batadv_seq_before(recv_ack, tp_vars->recover)) {
+			/* this is another hole in the window. React
+			 * immediately as specified by NewReno (see
+			 * Section 3.2 of RFC6582 for details)
+			 */
+			reaction = BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
+			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
+						       mss, mss);
+		} else {
+			tp_vars->fast_recovery = false;
+			/* set cwnd to the value of ss_threshold at the
+			 * moment that Fast Recovery was entered.
+			 * RFC6582, Section 3.2, step 3
+			 */
+			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold,
+						       0, mss);
+			reaction = BATADV_TP_ACK_REACTION_WAKEUP;
+		}
+	} else {
+		if (recv_ack - tp_vars->last_acked >= mss)
+			batadv_tp_update_cwnd(tp_vars, mss);
+
+		reaction = BATADV_TP_ACK_REACTION_WAKEUP;
+	}
+
+	/* move the Transmit Window */
+	WRITE_ONCE(tp_vars->last_acked, recv_ack);
+
+	return reaction;
+}
+
 /**
  * batadv_tp_recv_ack() - ACK receiving function
  * @bat_priv: the bat priv with all the mesh interface information
@@ -683,16 +790,19 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	const struct batadv_icmp_tp_packet *icmp;
+	enum batadv_tp_ack_reaction reaction;
 	struct batadv_tp_sender *tp_vars;
-	const unsigned char *dev_addr;
-	size_t packet_len, mss;
-	u32 rtt, recv_ack, cwnd;
+	size_t packet_len;
+	u32 recv_ack;
+	size_t mss;
+	u32 rtt;
 
 	packet_len = BATADV_TP_PLEN;
 	mss = BATADV_TP_PLEN;
 	packet_len += sizeof(struct batadv_unicast_packet);
 
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
+	recv_ack = ntohl(icmp->seqno);
 
 	/* find the tp_vars */
 	tp_vars = batadv_tp_list_find_sender_session(bat_priv, icmp->orig,
@@ -704,8 +814,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* old ACK? silently drop it.. */
-	if (batadv_seq_before(ntohl(icmp->seqno),
-			      (u32)atomic_read(&tp_vars->last_acked)))
+	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->last_acked)))
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -716,93 +825,36 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!orig_node))
 		goto out;
 
+	spin_lock_bh(&tp_vars->cwnd_lock);
 	/* update RTO with the new sampled RTT, if any */
 	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
 	if (icmp->timestamp && rtt)
 		batadv_tp_update_rto(tp_vars, rtt);
 
-	/* ACK for new data... reset the timer */
-	batadv_tp_reset_sender_timer(tp_vars);
-
-	recv_ack = ntohl(icmp->seqno);
+	reaction = batadv_tp_handle_ack(bat_priv, tp_vars, recv_ack, mss);
+	spin_unlock_bh(&tp_vars->cwnd_lock);
 
-	/* check if this ACK is a duplicate */
-	if (atomic_read(&tp_vars->last_acked) == recv_ack) {
-		atomic_inc(&tp_vars->dup_acks);
-		if (atomic_read(&tp_vars->dup_acks) != 3)
-			goto out;
+	if (reaction == BATADV_TP_ACK_REACTION_OLD_ACK)
+		goto out;
 
-		if (!batadv_seq_before(tp_vars->recover, recv_ack))
-			goto out;
+	/* ACK for new data... reset the timer */
+	batadv_tp_reset_sender_timer(tp_vars);
 
-		/* if this is the third duplicate ACK do Fast Retransmit */
+	switch (reaction) {
+	default:
+	case BATADV_TP_ACK_REACTION_IGNORE:
+		goto out;
+	case BATADV_TP_ACK_REACTION_RESEND_WAKEUP:
 		batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 				   orig_node, recv_ack, packet_len,
 				   icmp->session, icmp->uid,
 				   jiffies_to_msecs(jiffies));
-
-		spin_lock_bh(&tp_vars->cwnd_lock);
-
-		/* Fast Recovery */
-		tp_vars->fast_recovery = true;
-		/* Set recover to the last outstanding seqno when Fast Recovery
-		 * is entered. RFC6582, Section 3.2, step 1
-		 */
-		tp_vars->recover = tp_vars->last_sent;
-		tp_vars->ss_threshold = tp_vars->cwnd >> 1;
-		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
-			   "Meter: Fast Recovery, (cur cwnd=%u) ss_thr=%u last_sent=%u recv_ack=%u\n",
-			   tp_vars->cwnd, tp_vars->ss_threshold,
-			   tp_vars->last_sent, recv_ack);
-		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 3 * mss,
-					       mss);
-		tp_vars->dec_cwnd = 0;
-		tp_vars->last_sent = recv_ack;
-
-		spin_unlock_bh(&tp_vars->cwnd_lock);
-	} else {
-		/* count the acked data */
-		atomic64_add(recv_ack - atomic_read(&tp_vars->last_acked),
-			     &tp_vars->tot_sent);
-		/* reset the duplicate ACKs counter */
-		atomic_set(&tp_vars->dup_acks, 0);
-
-		if (tp_vars->fast_recovery) {
-			/* partial ACK */
-			if (batadv_seq_before(recv_ack, tp_vars->recover)) {
-				/* this is another hole in the window. React
-				 * immediately as specified by NewReno (see
-				 * Section 3.2 of RFC6582 for details)
-				 */
-				dev_addr = primary_if->net_dev->dev_addr;
-				batadv_tp_send_msg(tp_vars, dev_addr,
-						   orig_node, recv_ack,
-						   packet_len, icmp->session,
-						   icmp->uid,
-						   jiffies_to_msecs(jiffies));
-				tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
-							       mss, mss);
-			} else {
-				tp_vars->fast_recovery = false;
-				/* set cwnd to the value of ss_threshold at the
-				 * moment that Fast Recovery was entered.
-				 * RFC6582, Section 3.2, step 3
-				 */
-				cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 0,
-						      mss);
-				tp_vars->cwnd = cwnd;
-			}
-			goto move_twnd;
-		}
-
-		if (recv_ack - atomic_read(&tp_vars->last_acked) >= mss)
-			batadv_tp_update_cwnd(tp_vars, mss);
-move_twnd:
-		/* move the Transmit Window */
-		atomic_set(&tp_vars->last_acked, recv_ack);
+		fallthrough;
+	case BATADV_TP_ACK_REACTION_WAKEUP:
+		wake_up(&tp_vars->more_bytes);
+		break;
 	}
 
-	wake_up(&tp_vars->more_bytes);
 out:
 	batadv_hardif_put(primary_if);
 	batadv_orig_node_put(orig_node);
@@ -819,16 +871,19 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
-	u32 last_sent = READ_ONCE(tp_vars->last_sent);
 	u32 win_left, win_limit;
 
-	win_limit = atomic_read(&tp_vars->last_acked) + tp_vars->cwnd;
+	spin_lock_bh(&tp_vars->cwnd_lock);
+
+	win_limit = tp_vars->last_acked + tp_vars->cwnd;
 
-	if (batadv_seq_before(last_sent, win_limit))
-		win_left = win_limit - last_sent;
+	if (batadv_seq_before(tp_vars->last_sent, win_limit))
+		win_left = win_limit - tp_vars->last_sent;
 	else
 		win_left = 0;
 
+	spin_unlock_bh(&tp_vars->cwnd_lock);
+
 	return win_left >= payload_len;
 }
 
@@ -867,6 +922,7 @@ static int batadv_tp_send(void *arg)
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	size_t payload_len, packet_len;
+	u32 last_sent;
 	int err = 0;
 
 	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->common.other_end);
@@ -908,10 +964,10 @@ static int batadv_tp_send(void *arg)
 		 * the size of the unicast header
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
+		last_sent = READ_ONCE(tp_vars->last_sent);
 
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
-					 orig_node, tp_vars->last_sent,
-					 packet_len,
+					 orig_node, last_sent, packet_len,
 					 tp_vars->common.session, tp_vars->icmp_uid,
 					 jiffies_to_msecs(jiffies));
 
@@ -926,8 +982,12 @@ static int batadv_tp_send(void *arg)
 		}
 
 		/* right-shift the TWND */
-		if (!err)
-			tp_vars->last_sent += payload_len;
+		if (!err) {
+			spin_lock_bh(&tp_vars->cwnd_lock);
+			if (tp_vars->last_sent == last_sent)
+				WRITE_ONCE(tp_vars->last_sent, last_sent + payload_len);
+			spin_unlock_bh(&tp_vars->cwnd_lock);
+		}
 
 		cond_resched();
 	}
@@ -1044,9 +1104,9 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
-	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
-	atomic_set(&tp_vars->dup_acks, 0);
-	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->last_sent, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->dup_acks, 0);
+	WRITE_ONCE(tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
 
@@ -1065,7 +1125,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	/* RTO initial value is 3 seconds.
 	 * Details in Section 2.1 of RFC6298
 	 */
-	tp_vars->rto = 1000;
+	WRITE_ONCE(tp_vars->rto, 1000);
 	tp_vars->srtt = 0;
 	tp_vars->rttvar = 0;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f7817a68a29ca..c782f04aea9c4 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1387,7 +1387,7 @@ struct batadv_tp_sender {
 	u32 last_sent;
 
 	/** @fast_recovery: true if in Fast Recovery mode */
-	unsigned char fast_recovery:1;
+	bool fast_recovery:1;
 
 	/** @recover: last sent seqno when entering Fast Recovery */
 	u32 recover;
@@ -1410,7 +1410,7 @@ struct batadv_tp_sender {
 	/** @cwnd: current size of the congestion window */
 	u32 cwnd;
 
-	/** @cwnd_lock: lock do protect @cwnd & @dec_cwnd */
+	/** @cwnd_lock: lock do protect congestion control variables */
 	spinlock_t cwnd_lock;
 
 	/**
@@ -1420,13 +1420,13 @@ struct batadv_tp_sender {
 	u32 ss_threshold;
 
 	/** @last_acked: last acked byte */
-	atomic_t last_acked;
+	u32 last_acked;
 
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
 	/** @dup_acks: duplicate ACKs counter */
-	atomic_t dup_acks;
+	u8 dup_acks;
 
 	/** @rto: sender timeout */
 	u32 rto;
-- 
2.47.3



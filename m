Return-Path: <netdev+bounces-272802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FApBkIeyGlHhAUAu9opvQ
	(envelope-from <netdev+bounces-272802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:30:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1730434F9B3
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0096B30259B7
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40063A9018;
	Sat, 28 Mar 2026 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="o+3qh9Qv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F003A8727
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722437; cv=none; b=hPtcwPRtYOpazW0U5bZQOgPGZQk4nBkRzoSV4Q1iMJcvOBHGvCfG6KQvDh1uZV8ozzrFNc12GWV4ewThyppDiV1rYwXSAFowuGpD1IJhMfGMWiJJmRuEKLS/E02BuTZ/Cnic/az4VF1NGaZKJezCPBewoCm4t/ihrxb0Vd4lohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722437; c=relaxed/simple;
	bh=4E8Rh3OuNCsSvMlcjVPrrdMmqddynYyC/PcqgR+IY1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxd5K8wDGwv9Lao8RbviqnmhpsJeD1zVnPW66qyK8FZNpzCMAH1mYNZ+unq2xdRKtCOmF8ner2TmUJZ9quGiwoM8L2Yt18LQsEx5GZ4OQPBulX9JawscY4ywkRM/2WBS2iPiNHInw5pofDkgSwVw/2YmpiOKR4szhGh5SxhatiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=o+3qh9Qv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1279eced0b9so4605882c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 11:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774722435; x=1775327235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYPRUSIe18E54vjKGuGhcRXs1lIGpEBWxAwIKYxRS+4=;
        b=o+3qh9QvCKRKJ/VXXu1omUCNrPlB193CSfrHg6BnR7ItoFo7ehh6T7NeWOd0eEechz
         9NmJahHstPqi/So4VA/t2JI2FCkvuTuWHqCUqEbeGp3Jp/Vnz4SiWTwFS+uOAIXg+Nhc
         mUyRAlD1msO5rheMAcKy8xQvg3zW/7okduF8PwMXAHZOX0iH2VYVMIsF0xHFHHMd3iT9
         ORymrxm2V4QxacAitdvooPsN2H/9FySHhLz5vhShdQWdYzRO5zgQK45CdD61zxl7kqbr
         CZr9d4kccOuDrCrqEqjMwUuxJuJ4njn0p+x8IhBQyD9bzFWxfZQt04699jR/zMlatLf3
         KFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774722435; x=1775327235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYPRUSIe18E54vjKGuGhcRXs1lIGpEBWxAwIKYxRS+4=;
        b=VA52R3qa9UiUV1JFXeePy+Np6R07pRH7uoFvf1KBRrMSMH222rD+P6o0zlWF2A/PEh
         dEpX+qYX3fKnH7U3xIlm1ZdMlNpHBeC1sufPndX9Frd57FJy7C6LjD8jrj0WVTVN57Sb
         Q5k2Rv40F+3oZL1Xj9zHBMNt7Cuc4kZDRjcKq/OY96XclbomjY1KQz/7/ZjiTNbiCGH6
         RpXCf3rUC66qiWv/LwCHHgB49ua6m3mlejpnxWC7/10J8jyMsSUojiPy5NOxOZTN8HFt
         J0mJh7MhH7KSj8wNsFuhLWPEFbeyGl4jkOapsLVpDxriVzVey+QoH1GSHo0RDfQiDPwQ
         t0tg==
X-Gm-Message-State: AOJu0Ywrpev0faNTSo6st41Em8L/0B5uJnVd8T1ZimS5t0/l5Ph5JyiA
	A8DaVtifk1bymM1Bay4XUNu1e2SAPzsV/12pcBL9M67wHV9sli8xAWOmWQbiewNTEIs9kpJVbid
	xHEmT
X-Gm-Gg: ATEYQzz29Chuu9ea6n491kw12RF06AOZO1wegZk5Y9L6gzHIxMaTb6cBoM9+tT0ZPmP
	g+9vhwmnPwvQzfF1T9d6eJxZQmzLnnEsjNDpbqZf5c6M8HSUJmjG2YB8O2idpotYWTQD+ehPhfw
	cbWLpG0JQ2yexEim86pNY9lH3uYkoB1N2WHeMI+zvn+u2Ig6YUGeoJimKx/DQ5Sksqd6IAdR1Ff
	+VLxYeZy3PILJOfAZbUT1zy4Q91NRemxPsCLo7NDVVlukU2VLDp2NnbaqXu0yNxzveMUeap0NRe
	n8buR16d8FxRSqU4LDxo9JzQ8SNsPUdaWARwQMXgAnaV0puZ0noEvNbs7ek+vyFDURsm+I/lc83
	xNKez87TaFOUoPzdK6ePghr2un4QrcSe899qwid1HFMP9LIAIe1gdFSJCCpCC5akHIGZ34S/yym
	LdbC9mFGhhkwKD2RD5NrsUUP9SNil0I4Tq
X-Received: by 2002:a05:701a:c950:b0:12a:6a64:81f1 with SMTP id a92af1059eb24-12ab28389cemr3279086c88.5.1774722435485;
        Sat, 28 Mar 2026 11:27:15 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab97cb08csm3909263c88.3.2026.03.28.11.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 11:27:15 -0700 (PDT)
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
Subject: [PATCH net-next 6/6] net/sched: netem: add per-impairment extended statistics
Date: Sat, 28 Mar 2026 11:26:07 -0700
Message-ID: <20260328182704.456993-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328182704.456993-1-stephen@networkplumber.org>
References: <20260328182704.456993-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272802-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1730434F9B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem applies several impairments (delay, loss, corruption, duplication,
reordering) but exposes no counters distinguishing which impairment
affected a given packet.

Add a struct tc_netem_xstats reported via TCA_STATS_APP so that
userspace (tc -s qdisc show) can display per-impairment counters.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 include/uapi/linux/pkt_sched.h |  9 +++++++++
 net/sched/sch_netem.c          | 27 ++++++++++++++++++++++++---
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 66e8072f44df..fada10cb9b7b 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -569,6 +569,15 @@ struct tc_netem_gemodel {
 #define NETEM_DIST_SCALE	8192
 #define NETEM_DIST_MAX		16384
 
+struct tc_netem_xstats {
+	__u32	delayed;	/* packets delayed */
+	__u32	dropped;	/* packets dropped by loss model      */
+	__u32	corrupted;	/* packets with bit errors injected   */
+	__u32	duplicated;	/* duplicate packets generated        */
+	__u32	reordered;	/* packets sent out of order          */
+	__u32	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
+};
+
 /* DRR */
 
 enum {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 26fc68e34b91..755e8d009f85 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -152,6 +152,9 @@ struct netem_sched_data {
 	} slot;
 
 	struct disttable *slot_dist;
+
+	/* Per-impairment counters */
+	struct tc_netem_xstats xstats;
 };
 
 /* Time stamp put into socket buffer control block
@@ -459,17 +462,22 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng)) {
 		++count;
+		q->xstats.duplicated++;
+	}
 
 	/* Drop packet? */
 	if (loss_event(q)) {
-		if (q->ecn && INET_ECN_set_ce(skb))
+		if (q->ecn && INET_ECN_set_ce(skb)) {
 			qdisc_qstats_drop(sch); /* mark packet */
-		else
+			q->xstats.ecn_marked++;
+		} else {
 			--count;
+		}
 	}
 	if (count == 0) {
+		q->xstats.dropped++;
 		qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
@@ -495,6 +503,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * do it now in software before we mangle it.
 	 */
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
+		q->xstats.corrupted++;
 		if (skb_is_gso(skb)) {
 			skb = netem_segment(skb, sch, to_free);
 			if (!skb)
@@ -597,6 +606,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			delay += packet_time_ns(qdisc_pkt_len(skb), q);
 		}
 
+		if (delay > 0)
+			q->xstats.delayed++;
+
 		cb->time_to_send = now + delay;
 		++q->counter;
 		tfifo_enqueue(skb, sch);
@@ -605,6 +617,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		 * Do re-ordering by putting one out of N packets at the front
 		 * of the queue.
 		 */
+		q->xstats.reordered++;
 		cb->time_to_send = ktime_get_ns();
 		q->counter = 0;
 
@@ -1311,6 +1324,13 @@ static int netem_dump(struct Qdisc *sch, struct sk_buff *skb)
 	return -1;
 }
 
+static int netem_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
+{
+	struct netem_sched_data *q = qdisc_priv(sch);
+
+	return gnet_stats_copy_app(d, &q->xstats, sizeof(q->xstats));
+}
+
 static int netem_dump_class(struct Qdisc *sch, unsigned long cl,
 			  struct sk_buff *skb, struct tcmsg *tcm)
 {
@@ -1373,6 +1393,7 @@ static struct Qdisc_ops netem_qdisc_ops __read_mostly = {
 	.destroy	=	netem_destroy,
 	.change		=	netem_change,
 	.dump		=	netem_dump,
+	.dump_stats	=	netem_dump_stats,
 	.owner		=	THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("netem");
-- 
2.53.0



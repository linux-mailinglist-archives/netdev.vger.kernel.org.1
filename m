Return-Path: <netdev+bounces-291311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMFHHh5AFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D725CA77F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 815803009F23
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CC338229D;
	Mon, 25 May 2026 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="PPXp7Q7d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D40382391
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711981; cv=none; b=fBt+9Mw4ZTqcW228iVyK8fGpBZbVOHNByTsOP3hD2hWxZZlqqZF3olKRd1jDX/QVtBd4VbYmWl/OKUmEFdVBdzGJZAp4U0yFgxHqCyESxosggLCvHL1pQFRQDdUo55ivEi5aPV8YAN5v3uxk1R+fq57QvnnS4D5uIMeS4S093Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711981; c=relaxed/simple;
	bh=AA4u1HTRhjSQ+Bsh4uhwxKGoLj4Xl60WrCoNpL+15Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X0sev7OBL2BIexbhccIk05xWOJSqTp478zBojEy3lLqMx6MeF9EpxnxOwktNq2z2DhphA7hlPypl1aulSA+vCW/1HQJZgt9C5WQ2vuUiO9UnAJp9q0PSlS7UtV3AyjIwPG91WpLbLooqk8g+p0zh6wGsZmtnBqHNzJxtkgJ4/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=PPXp7Q7d; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516de78c4dcso24214351cf.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711978; x=1780316778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRqJfsjT19G2qMbCV+v756mroy/Cd1xhqLS3yukG3js=;
        b=PPXp7Q7dYSP1wRUOjHzwF5l96x2fFQ2ZKvwsDj4gGbbO3k/rK7vcT3Hfxsdc4Xl/qs
         PU+GZw+K4kVasw7dYvTwbiAwOG3h6j1L+NMEaiR+G0VSIvbKwq2iesM9PPQDXG1ouXJU
         igzEpgDouAopjkyLgT4NzBl5Rqz0KzdAyvzEEMKUos0zFPCWK4fiVr/tHIIPXu0unDTL
         xRYqk7pRSFR4k32UC2hF30nwAOxpK457TFgXwpXkTIRmPGTUCaT7eh0EVR7IkCbzfhjk
         8/SFAX7lBOXz2fuBHxm/SCFiRoRnr/AiYgDeFpVxMG8De3mSmB5GHwwEqbDOMIy4vtyx
         aiuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711978; x=1780316778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bRqJfsjT19G2qMbCV+v756mroy/Cd1xhqLS3yukG3js=;
        b=Dr5XXqDtWJt+aoEdwt/gIDhosXbt6gUA9yS5SASJxPhobmP/Yqv2hyGnBRVyylK2/X
         D54p792oIk1Tapwf/S0DPTzFUmE0WYYyhmNVB0UaJVqEopnjHZV6zRf1yxz724zQsNR7
         LGeeKrHt8WRpF9DZIkwu4AEryFr8I15HdYnb0BOfV4mWr+wkBxJtMkTIDV0Qk4TzigdG
         sj9SVb4P/phzzyVdczuNI6lp4Rc4QYnYR4VquLYbRJzTqYiNw7sUrZHZQlv7VRJDGtZq
         YeFAZ3hflCRaMITzi+dAHEzSGuwIY9zrffSHfPMxZyMcId/rTCaQs9svLoejM20FiNZa
         9DIw==
X-Gm-Message-State: AOJu0YyBzrzvZP7ulSUbKJiHpInFLWbs+AMogm4D7fTS6QF5qPrwp5mq
	vLKfesXFqPAaECtXE9Zpx7O6Z6b1lYMBBVDhf0gYDpux8YqZa2XGjERlkja90U7X0qKZkj47Ssi
	c2p1CGg==
X-Gm-Gg: Acq92OHmgg4mW8ngQoqsi/aW+8VEt115yyg/NIG3feS3QUYK5W9eLwlAdikLp00fiK5
	7WdAidn2i651ccSfJ2a2mG6BEpPy66PzNX8wWrsV5kvZg1Q+pbO1aRvsAXkuMbHNmaFJmRjgdnX
	mx1oOk9nr3N/lSBiF0H624OzLsUINXO4RPNMpJZKfqw1i2sUrnGT++b/vSHO3YJLPoEmrZe40hN
	crkOgzIoNQnnWFiLOJzZDDnRCPDwFHr/mAyXosuOeaQr6EX05cM+CoR7Uo1REc01YvOag2rfmNW
	jZP4eejPJCt9lqC3KVY9fu+Ik6y4zoCJSPt0FShhImj5ImGipO9lmMGvZSzh/AeUtEM0GnoYcbp
	rNNGSYEJSYluCvfbZCHLH89WxkB9/MiaMh5/ZgsMoG36eXUUO8KtWOwu1yCJc+nZfxwSVHUeMA7
	ofg4bgQQFXNa4Zvtxj+NRb/nnqSJo=
X-Received: by 2002:ac8:5a42:0:b0:516:d812:c35e with SMTP id d75a77b69052e-516d812c62dmr185519921cf.21.1779711978315;
        Mon, 25 May 2026 05:26:18 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:17 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 5/9] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Mon, 25 May 2026 08:25:52 -0400
Message-Id: <20260525122556.973584-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291311-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,networkplumber.org:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 79D725CA77F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When mirred redirects to ingress (from either ingress or egress) the loop
state from sched_mirred_dev array dev is lost because of 1) the packet
deferral into the backlog and 2) the fact the sched_mirred_dev array is
cleared. In such cases, if there was a loop we won't discover it.

Here's a simple test to reproduce:
ip a add dev port0 10.10.10.11/24

tc qdisc add dev port0 clsact
tc filter add dev port0 egress protocol ip \
   prio 10 matchall action mirred ingress redirect dev port1

tc qdisc add dev port1 clsact
tc filter add dev port1 ingress protocol ip \
   prio 10 matchall action mirred egress redirect dev port0

ping -c 1 -W0.01 10.10.10.10

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 47 +++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 2c5a7a321a94..dd5e7ea7ef26 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -26,6 +26,10 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_wrapper.h>
 
+#define MIRRED_DEFER_LIMIT 3
+_Static_assert(MIRRED_DEFER_LIMIT <= 3,
+	       "MIRRED_DEFER_LIMIT exceeds tc_depth bitfield width");
+
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
@@ -234,12 +238,15 @@ tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
-	if (!want_ingress)
+	if (!want_ingress) {
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (!at_ingress)
-		err = netif_rx(skb);
-	else
-		err = netif_receive_skb(skb);
+	} else {
+		skb->tc_depth++;
+		if (!at_ingress)
+			err = netif_rx(skb);
+		else
+			err = netif_receive_skb(skb);
+	}
 
 	return err;
 }
@@ -426,6 +433,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	struct netdev_xmit *xmit;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
+	bool want_ingress;
 	int i, m_eaction;
 	u32 blockid;
 
@@ -434,7 +442,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT ||
+		     skb->tc_depth >= MIRRED_DEFER_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
@@ -453,23 +462,27 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		tcf_action_inc_overlimit_qstats(&m->common);
 		return retval;
 	}
-	for (i = 0; i < xmit->sched_mirred_nest; i++) {
-		if (xmit->sched_mirred_dev[i] != dev)
-			continue;
-		pr_notice_once("tc mirred: loop on device %s\n",
-			       netdev_name(dev));
-		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
-	}
 
-	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	if (!want_ingress) {
+		for (i = 0; i < xmit->sched_mirred_nest; i++) {
+			if (xmit->sched_mirred_dev[i] != dev)
+				continue;
+			pr_notice_once("tc mirred: loop on device %s\n",
+				       netdev_name(dev));
+			tcf_action_inc_overlimit_qstats(&m->common);
+			return retval;
+		}
+		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	}
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 
 	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
 				   retval);
-	xmit->sched_mirred_nest--;
+	if (!want_ingress)
+		xmit->sched_mirred_nest--;
 
 	return retval;
 }
-- 
2.54.0



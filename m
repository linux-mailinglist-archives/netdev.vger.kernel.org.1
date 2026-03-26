Return-Path: <netdev+bounces-272198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHaqDEB6xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:26:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22433A096
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B3BF3015FED
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8843A0E99;
	Thu, 26 Mar 2026 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="q97iVZo9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6603A873C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549072; cv=none; b=VxFZ0AqIFrvaBLIyoA1HBTcs+gt9UnWm99zct4O78v6lJHdEpMy1W2JzaCj7/7Z/rCu2j63B+sGT9J39k6XZskuQe8O9BSmiXp2AudMWUw0ncqcYT2KqwhXiNcdxJFK0d3d8d6SnIEPFnSoWsqpFWCGG8o+v+zOvIwHM3KKmtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549072; c=relaxed/simple;
	bh=Ovj2Oa/Xx0/i5kgTK1bEvMR8Q57H9OPDgytFvPXI9Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8/Oa/qZU4rbzlnR9G7EheK/uBbLeLfT9s09gyqC6XeGsGNvEbqDkBI/XFwPTqggPWkR0RPW14UbIDfmtOUvOFz293QlOSYtaaYadbT1LPXaMMDof4FEONLt+3tcFOwZodivyvyNpnZjYl0PAEHBZbqVxrHvNQsaPmmi/q4zqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=q97iVZo9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-359fea895b5so999807a91.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549068; x=1775153868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AGIDQzjfRL8P4QWldXUcJASNu3iP9dOlm2OUCKQD7M=;
        b=q97iVZo9BAAap4BOVJN8d66JjzMRFQmkRl+EeyK5WFjjJJy+7o+8jWrLBrcdDYGjDA
         VGoVwvnpagQDuilKMksFmE8yYbLClPREmNwIIk2W15jlZF67As3a/SYDEgqe1hw2z+vN
         LShUH4vLIw1IZAlh+2rzoxx04IC1jpl0UQSgF0K6DWBOZ/eofCs+2JzXttsCe4DQpjhx
         A1/2DHiCYvezkF4DSQYJ805PCuSXiBDKAt/4+/Axaidu8qI41/wzznyVtvrLjeQHAMu7
         mR/0RbJCamako/xFSOnSaYUELNpzBM0Xj7OqP0QgyCz7sHQPsRwVjWMcEn9u3fG7PEIj
         r0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549068; x=1775153868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7AGIDQzjfRL8P4QWldXUcJASNu3iP9dOlm2OUCKQD7M=;
        b=FbEZiUAHT+L4wyXHVkIE1RgMJ8yrGkF6mwOwfK9Q6qK0WCZXosAt5/Awnv5cfTGjgI
         yAU/AIhBjKzxtJSAXFdQ+G7+ZV3xLBBVWhEKKj0QNq1H5QbLiNWK7QRWJTB1ALfnlaIE
         hlPFFpOwjNnQmIU8aN9w2xdtxaRASBM+Z/bjhiybRMtd4g7oryeqoPl/B+lfzghv1G+G
         ZuC8ujotoZz8clzl/2yYfTbDdZJV+7zsscP2r4rRcpP0nLAexLpu5oujXPWTFznkF+Vz
         ZFdAlAIOb8zn/5IqZh9l5WulVgZtwyAb5z5/zGTU2v3zapZ7EJRQMNVYxt9p36ZPxfao
         d0qA==
X-Gm-Message-State: AOJu0YyPNA4mNiP16TiCPV1vY6AQwL8G4igrBFjfCfqqZc5hOFp2m7hP
	UieLh/hkMHpPXgB/vbkxa+UqnEN4p/JrN7qVHhNOpRhA3WZJgkvK63RhJ4xDKIZoXNPjhq82NS2
	IKvlj
X-Gm-Gg: ATEYQzxsNTcqNk339rvkJ+1Bp4vWbSLnxg9blx5RGn2MZt0NwBFYc8kU1MUzLO6IJDu
	Bn5jg5Vfy2hgx80B0kyh0lpwNe4Yjfmsq04EiAzUqxPRxpWv1HlAkwwNI5ai57YwY5alkgIbXii
	+zy8VF9lX3hCnQAopGwUiNaU6QU+C/4/0WWlTSkmBdMPcRzOoqd2CQog+lBYkwDnynAAHaM76Bt
	M7s85Qc4k5Fd2P+6JIEZ3ovCRMn9cu0uPTaeiNInTRSsca9J3/f4Jf4rJWY4gP5yjhL7R48cORo
	ANxf7LTmeEFXClaLXCumTAr9WchtSHRhmT/2KldL9CE1D3q87nkHYBy/lgUN88YjdUgZSTv4sEL
	vvN8k+WnylZsoz3+TsT5Y2cl67hb0Va5xiCr+dI+oVxXxQQaGwrob0csqhXbUxJlgnT9aIhRCBy
	8GwI99EEad9lcjo2ha29yUhwdSKPnvcdBb
X-Received: by 2002:a17:903:2c7:b0:2ae:593c:48fc with SMTP id d9443c01a7336-2b0b0b2c128mr99486165ad.53.1774549068175;
        Thu, 26 Mar 2026 11:17:48 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/7] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Thu, 26 Mar 2026 11:01:04 -0700
Message-ID: <20260326181701.308275-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272198-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,mojatatu.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2B22433A096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

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
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/act_mirred.c | 47 +++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 05e0b14b5773..001dd9275e9b 100644
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
2.53.0



Return-Path: <netdev+bounces-288010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5v+uLqriBWrSdAIAu9opvQ
	(envelope-from <netdev+bounces-288010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14610543940
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 365CC30EF84F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766BF423144;
	Thu, 14 May 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="EgnRjeDL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C373AE712
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770095; cv=none; b=Vur+7njt5UoKpWA/i6asGtPs9q86MF7guNJqrVY6/mgQMoJ7TQcEfdipAo57osZtDapaGMRvwrCBxGB9PMJs/iik203KHPGpMy+eHB7bgoc8/iZ5p9caucUN0M2PvZDRyiHzv7H1nSHbMGUrQGsSHUb8CAm7B1sF4pXppm9K8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770095; c=relaxed/simple;
	bh=YY90nE4vZKN4pnoHEAP6ce7sBKDSpGFrCFx9JDhF80g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebRmnVT5Bvy8uUiYsRZp2rJzyIpIA8iYTnEJ8OrKyrO0cz42JQJ2fdJds4bRrSFIrrimlXp+HjGuHDrqEvvsLgwHGNYmgJ5mEUZP0uK1YEo6zi1Jls83aHGmvV08mU2Xq+wDQhQa4gFuk/QmpeZmARS8NT1YyTJ0jwMvGT+SqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=EgnRjeDL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50fc496c8baso76386021cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770089; x=1779374889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+Bwc5DM0WNlHuiZG8q6zRAP7BUsWWwkgfwQAh2UPXw=;
        b=EgnRjeDLZJnMsGvrJzN3g4WYjq6ctjlw39wzY/sFOyoBCo8+LKxYTAq7VGfWQBb+es
         zXvQiXKsnWo6AzfFZXeqxHj/waAqWyyFGy7u+uHzeSlOk8cQv9Z5UQtIoAGXPtWNaMfm
         a/uGMiF2ETswUN/pjcqhZBrM3+3NubElsH9DHcV4ViIHsJO8uW9qBHezb4C9pvPiE5Js
         RwmO/UJqQdbLDzXDdasPrGLmffo9viso/ZVKbo+Y6hrKbnXPGXOYlokLSSvj/35S77qt
         5AkOEt1rTFrtHT2hRHj+xof3YxZIUXq7WaFmUFrovUgZsBPggFRX1ZBXJiaGrbEDUbMt
         bd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770089; x=1779374889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+Bwc5DM0WNlHuiZG8q6zRAP7BUsWWwkgfwQAh2UPXw=;
        b=QqCkwzHz0Ev5EEMM/qAIt3KMGYf8qCKWTsugsGgfuk7jbVtP1488bUv/e8XdcziDGq
         p9A4UGprv9JOHygIrJyqcXxCSYBEXjplm5uJRNc1j0fdtBLqF2jQF0Isq1UBjlHkUjbZ
         Ex6FXhgGE+5E2vIdTKpc3sbjrQJ1+8KnFUJBZw43mRiYbRp8Tzi6dH1//blkk80UuxuZ
         oi6YALl0A/0fRun9wrzKS1pJK457sJtrP25J51lJbX3HJ1LXJ2rQeUCF2TAwSJVQxwql
         f70Sa1CQ/GYsscHhPvCrsh9VuqyBPL8ERVOD3XEpCeAO7KaflY4f3DJkCfwCrKQVmUpS
         cPPw==
X-Gm-Message-State: AOJu0YxW/NBPE3HeKON8kXof3clB+REdNtKnRIxcnvdSwDlCf0MOJBpg
	h+fAH4Ep6PZOkIcst9a1Dl8ssNv5c36qU9Cdm0yPROmSDJQAmkSC2ODxnuIJLLGYU5CE+5gj5Po
	YUVxCOQ==
X-Gm-Gg: Acq92OG97DJ+QevJ6ppMNxspD23/1UP0S/AyLV6eSdXlNcCVvQmPrSTdQzf++sUZfjV
	q6M/PdpZ8MZigUcxKTGlA1N9KtO4Z9fJ1ggAp5hKiLE1u1X+773ZOL+QYRrFrpgxl4EJ9yU62bG
	nCrUS/PsjxWPZ59Eas1AYW+GpXYGTvtwiony6H/eSB/b2/mWRLNgImxrrFl3Wmx9p6W3SnDwHEh
	FHLvHBv2zM1/iiV9JHzGeLliL2SgfRzs1LNmuaWYIwNo6DEnPW5xvoO6SRD6RAC7HR0A/zaFcnQ
	OU8+ht0f8VwX32qwAvdOJDyvoWOVN2C8B/QivwoVuZ7SiRgzk0XR9rtFdBztI1I30Cp9uUsA0rb
	QTA5hwXSLTOL2djNMnKVM9OtPjlDzg5PT65VgvrI6e9ibiFPHU0/6XIlyUmgPWJ4VRsDmj9L936
	RpDEtu7nn1K59+Gwc4Kz4bMdUMGBk=
X-Received: by 2002:a05:622a:1910:b0:50d:9b2e:7ee3 with SMTP id d75a77b69052e-5162f58f4aemr102165791cf.38.1778770089418;
        Thu, 14 May 2026 07:48:09 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:08 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 5/9] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Thu, 14 May 2026 10:47:43 -0400
Message-Id: <20260514144747.527175-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514144747.527175-1-jhs@mojatatu.com>
References: <20260514144747.527175-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 14610543940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288010-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email,mojatatu.com:mid,networkplumber.org:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

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
2.34.1



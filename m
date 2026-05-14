Return-Path: <netdev+bounces-288012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEySCqDhBWpsdAIAu9opvQ
	(envelope-from <netdev+bounces-288012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF05543827
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A56A4302FF69
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDF426D08;
	Thu, 14 May 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Lq9tW9Ky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837A423148
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770097; cv=none; b=H0bEDBnGnwjc6oMyifmk+X+GCrMaKm4g2GcjV09SSmcQuYSyarXgiaIwMykpwFUcfwDQG4AW2RCq3vzuoI6WXZJJeDSCkTJlDCo4lVMs5tGi1VSTp0GcmGeR6HTSlS/LyWChNExkp17GqNVnyUjbd7do3DjUnPcQGQZ3BosQfpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770097; c=relaxed/simple;
	bh=S1H9KuR4CQlp0ArePGaPjstzYtFmfwP7PG5mYyROHMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ORggdK0lhMqBneInj72cveFSuuS/erszFu9IpREVUjq3ajl0t+2rKegSPIbU+xI/0nFo/kwpStvTB6PfT+JkG64dUoD6lz4RKbu9CjgPgLOgLYGdThmazgBYxpub4eF5OL5Z29GBPKk/97dRg4QbP32hUhDdyeKlSiPJID5K8vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Lq9tW9Ky; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e5bea4045so58874461cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770092; x=1779374892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSX5EMIChUIpPjobkEYrWFyOPpSxx/2oJIRRqSqdDzs=;
        b=Lq9tW9KyASKu0DV77d3eD6F12NN9Hwxp0v5r7Nm+uOo2DXXCKuXItQ+JzKaNw7geb8
         B4IsGSZzMxXiV3ABa1UfGnw1zLJTAYxWgFaWoS1YwKvSd+ypINSYFLDCict2bsUPzcAY
         oMZOLV4f8OCeaiDGFPeDvJba3oBBVcPCrrew1UqW0pVZQA7cFFgJrWTpKni2GRRVgAUZ
         kMC05l21BwPApdmshMVU+oQWmJ2NaC+FktEwe1/nmo3deYnVHHV3nGgF0T9xG9C2t6Yd
         4Vgax/XogcL72kpJX7uQO/1GxQng53idzZRyryCjo4f1gR74Bz1Lv3pQtW7eCdq7Rsox
         cm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770092; x=1779374892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSX5EMIChUIpPjobkEYrWFyOPpSxx/2oJIRRqSqdDzs=;
        b=ZyAz5Fm43e0jA7h+W3b7zFurWL1wXPnZukD0ygj10jvX9e0zm6r685Srz8XE12ccd6
         DdfXakJxTHpQ22SEw/7qzdZB9zGZ4aVQBG0SGs/vakd1sBCQ7Fj4+pgfGPrTPnAa3kvY
         wk2SExUJeBG/H5eTKyPnjVwro89DzZ99NyMoggvXubFc4rl6GVEfgTx5Myr7WZjVgqiH
         WK6xlEXAFKl8HOeb6NMy6U5gGnPXf9iKiYyRjQU5I19dSkGyIfwrfFekfJL8jwXGR/wT
         +RtzizrplX/lhyHq3o/LSgoyGvmzNPLFJslCkmQaTQqJtcsabAYONZiG6L7EWsJdCgiC
         9uxA==
X-Gm-Message-State: AOJu0YzxkXGB9vfhekWr7MfSAelRBesVKwZo4db7WOFpy8MvNSLgaIqx
	etr3FG1vK6uvXaf5VKBdxF3xg1IzABzFQfAISYdWYVRpNmMtMNh/eTs69ZrldTG7qmbKh81jSpO
	O1nejJA==
X-Gm-Gg: Acq92OGdikRluJQyLF85XWnlbhoP51rvKDj1NE/TVpYG6TNUjT9lsCduiuIDTZ1nPVL
	qW7jXjZilfpHuzECuX2U0kULyZuGADXHqBduWbW5sOyctdAzlCZsYqE36r9Jz3Hz40vQ0OX9HaB
	pPoGTB9fBraPKn7llOmoD+oUjceRSy2eYKOL67PorCeAPaLa4KVS8UwCRQ5WDGbKd610ikhrnLk
	02OZUrrhYEu7bnYN4P3v1DeRmpRTJC7s+TPpnxiCtg2RJy3lhiGa1CVAzvUn7RoAGiyvkf6KrZd
	wa+uAjFIzBaV1H5pcvHfNTLcIi/0SVMFQ06r3iK3x22C7vCFsJvmDnhTQZWGK5sklS0YP+GmfGe
	DJfyu/kLdFaOXq+RObLIEoM8MB/IRjF/g9VJEzwaafk0syOHslfhoJWK1uZbwzsIHX9YZTqcn2X
	KowcRM3KXg6iG+yDnllISu/bjEuqA=
X-Received: by 2002:a05:622a:189a:b0:50f:b1e6:a8f6 with SMTP id d75a77b69052e-5162f4edccbmr107092961cf.26.1778770091814;
        Thu, 14 May 2026 07:48:11 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:11 -0700 (PDT)
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
	Sashiko <sashiko-bot@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v5 7/9] net/sched: act_mirred: Fix skb leak in early mirred redirect returns
Date: Thu, 14 May 2026 10:47:45 -0400
Message-Id: <20260514144747.527175-8-jhs@mojatatu.com>
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
X-Rspamd-Queue-Id: BCF05543827
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288012-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,mojatatu.com:email,mojatatu.com:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Victor Nogueira <victor@mojatatu.com>

Since retval is set as TC_ACT_STOLEN in the mirred redirect case,
returning retval in cases where redirect failed will make the core
code not free the skb and thus cause a leak.

Fix this by returning TC_ACT_SHOT instead in such scenarios.

Fixes: 16085e48cb48 ("net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260413082027.2244884-1-hxzene%40gmail.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 2ce7ca6b5cc7..97f73cb20efa 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -372,7 +372,8 @@ static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
 					 dev_is_mac_header_xmit(dev_prev),
 					 m_eaction, retval);
 
-	return retval;
+	/* If the packet wasn't redirected, we have to ask core to free it */
+	return TC_ACT_SHOT;
 }
 
 static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
@@ -412,7 +413,7 @@ static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 	block = tcf_block_lookup(dev_net(skb->dev), blockid);
 	if (!block || xa_empty(&block->ports)) {
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		return is_redirect ? TC_ACT_SHOT : retval;
 	}
 
 	if (is_redirect)
@@ -430,8 +431,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 {
 	struct tcf_mirred *m = to_mirred(a);
 	int retval = READ_ONCE(m->tcf_action);
+	bool m_mac_header_xmit, is_redirect;
 	struct netdev_xmit *xmit;
-	bool m_mac_header_xmit;
 	struct net_device *dev;
 	bool want_ingress;
 	int i, m_eaction;
@@ -464,11 +465,13 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		goto err_out;
 	}
 
 	if (!want_ingress) {
@@ -478,7 +481,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 			pr_notice_once("tc mirred: loop on device %s\n",
 				       netdev_name(dev));
 			tcf_action_inc_overlimit_qstats(&m->common);
-			return retval;
+			goto err_out;
 		}
 		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
 	}
@@ -491,6 +494,11 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		xmit->sched_mirred_nest--;
 
 	return retval;
+
+err_out:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	return retval;
 }
 
 static void tcf_stats_update(struct tc_action *a, u64 bytes, u64 packets,
-- 
2.34.1



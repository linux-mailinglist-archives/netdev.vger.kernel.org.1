Return-Path: <netdev+bounces-281187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI5ECmtj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DE46ADEF
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 932A9302A078
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C161F37B41C;
	Sun, 26 Apr 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="Z7WRO6xA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80C1552FD
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230576; cv=none; b=buJAb3zmbPpTS2O/JbZzRzaX+Ts+OfSvhLcwXvchufdRenSa3X0l3bjfvspsTGSMoJK9EWZSuLkU3LppIJAjpvU/z9/Zq2cJmavovQCRI2BV69Txh5jDe7DiJC9nA7ZKuiZdRMZbjcknUqmNvvfbB9KPlgGyhER9MJyqE5XwcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230576; c=relaxed/simple;
	bh=zXl7idAP3nki5eOkWZ1Fue9mr/ZzARr05tpWsVB0W68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/Ni0+qAMhcTJ8ZC9i6hPRMdMxZ381HsD93In2+DQCfEGmQlZX6aFIF1aMoGtrLiqO5mO8otJIsshp3NZH2hjJNw2FiivKuJRcQ2DekEFHWyN28tufbhdczP/dXcizqRY1x3RtTugxI9FJPO3TBoqHdaxlIBtUCTgsPJRyCvOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=Z7WRO6xA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89f87257904so80325256d6.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230574; x=1777835374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mAE7PvH4LrM4kB9zp/uyafGfEcS7apvEjrGXBtZ6c6E=;
        b=Z7WRO6xAvEbKqFLLNT02o6O/PUc7QVzVwogqTqpwBIsLmu0AmMd3OCJkZrVuQd830q
         81F4dI6Nv8gbViMh+eQK9b4Pg7plx7Y2P794dvDRAhqjgwmP9azLxAI+cMz9juh+FhgQ
         x1LRmdslTTPwVXZNMgx5aXEobrTn5bG47YpRrM34NhUlwc84p1f5QxLMoFdjDuggixyg
         eCdnWVV2lJaX1aPeZjAZHA5g2q4ve1I4TLAQej9u84G55QeuQtxjOTOd8Z2yfWOoXXuq
         ImCDDa2h3jhFnroUSYwxkD9p7ouOdsOHkgorNwd7Z37XFDlDt8uzGhvqlJM6CrKIAF74
         2DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230574; x=1777835374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mAE7PvH4LrM4kB9zp/uyafGfEcS7apvEjrGXBtZ6c6E=;
        b=liF/caKRgreqOUkOMST3o7aETBHpkvqvLKoOB6GOSjD5TCq7Vg8lJyO8U/0HBquOk4
         3jXhN+OSwkP5/1ucLOGlLqAwEAFfG3Ic6mZXhsHkDDP/akaSgXj+juhGz4sjbZ5F6TXL
         ycQUn+bat5rXLgIOM7kSdgYeJ2GKDqPTP3lfrKeIAco8s7fMpRSEDvIzuOTxX+BzN7Gj
         WK2m1GlSO5vquAL/EktwZpvLA+ccm/E2MDSY2OaehgQcV1Oo0XfIEDu4UQCLt2Hq9fuU
         afPeBwtRflDXd8i/vPFiljJzMooyIH0CD+duXaZEgX/UP45vP6V+sBX+uZUcVFl4h3Eq
         Fk5A==
X-Gm-Message-State: AOJu0YztlPxqn86L7MaBvHNzX5SmwY76J5QfegBvsgRzaEAPzIOLLjVn
	TGrc2BaeQi1nTUvpGNf9r9UimhckWE2mvlDLDRPyfNMhjQiDgqLqecxykR7XU8xvse0fuvFwiCw
	JsD8=
X-Gm-Gg: AeBDievCELncSduZuwga18QWmxpSJH7JjXg7p2zH+k596hj/T43gkrIA+6uL2jqDocq
	MA1V7Diu9NhTPeeCsB5CiUVJgzUUdlp71MaESB5mifrCfnPhPfotu4KmE1zBI26U356XnDMlmcj
	xaf6Gutu8pRFh/OEnDkhPDctL9MNG51PweodBaV3YR6qSvXtIcC2YNfnwWwMK/+9f/HvxraS+VX
	RMpOO+d0PXoE1X05RmbMXGKFOjs3tlxlapJ/L/KOPMaEM95FLbJnplbqpDNVPHrbgB+7NpDUoWf
	+oaJxTRu3x1fsJysBOuyJ1L/Rf6CU16sxOL/HXgRDlNxzh8NtyCVLyNBs+NIpmMcjI7jErnfMk1
	aML87m4/pEi6aRPpWQCkWW0RS65Y5Thw+09YLUIeXDqCIXhRhOtaJgFE7CSPyzodiSMY1bjjZyI
	R9lqQhisRin03XsQ7VGT/Ee5EsgBbW896wJdbUxT7vvx2J+NAo94sMpaeN/2Xgv2C4ZwW1PH01C
	FiiMm00Fft0iEpjGC6OVjM238FDFTA=
X-Received: by 2002:a05:6214:e84:b0:89a:90e:3a1b with SMTP id 6a1803df08f44-8b0280cc334mr603811196d6.25.1777230573742;
        Sun, 26 Apr 2026 12:09:33 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:33 -0700 (PDT)
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
	Sashiko <sashiko-dev@lists.linux.dev>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 7/9] net/sched: act_mirred: Fix skb leak in early mirred redirect returns
Date: Sun, 26 Apr 2026 15:09:14 -0400
Message-Id: <20260426190916.128489-8-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 675DE46ADEF
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-281187-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:mid,mojatatu.com:email,linux.dev:email]

From: Victor Nogueira <victor@mojatatu.com>

Since retval is set as TC_ACT_STOLEN in the mirred redirect case,
returning retval in cases where redirect failed will make the core
code not free the skb and thus cause a leak.

Fix this by returning TC_ACT_SHOT instead in such scenarios.

Fixes: 16085e48cb48 ("net/sched: act_mirred: Create function tcf_mirred_to_dev and improve readability")
Reported-by: Sashiko <sashiko-dev@lists.linux.dev>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_mirred.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index ea64faf7f469..4c7af7bd7c0d 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -412,7 +412,7 @@ static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 	block = tcf_block_lookup(dev_net(skb->dev), blockid);
 	if (!block || xa_empty(&block->ports)) {
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		return is_redirect ? TC_ACT_SHOT : retval;
 	}
 
 	if (is_redirect)
@@ -430,8 +430,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 {
 	struct tcf_mirred *m = to_mirred(a);
 	int retval = READ_ONCE(m->tcf_action);
+	bool m_mac_header_xmit, is_redirect;
 	struct netdev_xmit *xmit;
-	bool m_mac_header_xmit;
 	struct net_device *dev;
 	bool want_ingress;
 	int i, m_eaction;
@@ -460,14 +460,15 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		return retval;
 	}
 
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
+
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		goto err_out;
 	}
-
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
 	if (!want_ingress) {
 		for (i = 0; i < xmit->sched_mirred_nest; i++) {
@@ -476,7 +477,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 			pr_notice_once("tc mirred: loop on device %s\n",
 				       netdev_name(dev));
 			tcf_action_inc_overlimit_qstats(&m->common);
-			return retval;
+			goto err_out;
 		}
 		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
 	}
@@ -489,6 +490,11 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
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



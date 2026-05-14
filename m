Return-Path: <netdev+bounces-288007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODrwEHzhBWqNdAIAu9opvQ
	(envelope-from <netdev+bounces-288007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21DC5437EA
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0DA3A3024A3C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9968241C30F;
	Thu, 14 May 2026 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="DeIJZqtM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B02580EE
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770090; cv=none; b=N5QW9XbXZYK9nNDmymQiPnL+sUmSZkJz4BLbd0LUEU2ZILyVImPpXfzwCzngFCnvsyL/X1Syg77ggsE5rTtnLMfRW7ePvqVda/fdwddK7MI/darpFQMRYPvB0omZedxh7FtBUPGgj3dOscBe+VWp3AlrTuuL+WBFY3mRQxeHB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770090; c=relaxed/simple;
	bh=ZxGD1vGUxXz1Nso2stDwLf4W5wwL4ZIaS5D/F7ofFF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvly6cjrsrt21YZ7NZZaAbbxx+YE1aLyvBOMnt23xNmuMSiCQO5TVDqSX4f7WTpyaBMxWTYzcbajAd9/rOL0ktG7nAe3Ja7ymTqLzbYWDZSBYM7lwY/p1l6a2LzOPNmucXAXIDPzy+ur+IwdzZlU+P7lgn18PcI6gND/b6h4Kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=DeIJZqtM; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e5bea4045so58873311cf.3
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 07:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1778770085; x=1779374885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FABW4Vn122jXr7jY0HP3ryxRD6pI3feCWaTANBaoWU=;
        b=DeIJZqtMyVgJQ4CuSvzVgManDsrhX9v0AEnudm2kKV88CyVKUyP+jD8dlqONO7C8OH
         x8Aba4EK/I2H6EXUkfWXbQt2boFDUk3YGWQ+IBrXajKilAUrLDfLuMb3xFoKJCHc5De9
         xt9jdIaepddP/kpytMQfTUB/qd2kr5o5LQ5qD29lhkNkU0rR+zcVbT+MqlHLooiZJKDP
         2cmtvIJOarNKm11LqkTOTEmpfxKetE091ugGN4s69q+BuVUdSwSIPavox4PY7ub4e5Ig
         XTFhq+/fIUZaB1Iq6JNx9dy1kcTTrXfSpDVGQw8uFkeEpsKAvAGCKdg8QcXP0LYBFrKJ
         ZPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770085; x=1779374885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FABW4Vn122jXr7jY0HP3ryxRD6pI3feCWaTANBaoWU=;
        b=l/6Tv1vmCQ/nGqmeZM2SecEoAhVmVNASBudt6SRF/gfgUgytbsfVZfmHsNLzoBHFo2
         pL5nj6ZcQamzvpgOQaX7Z9XTmO7rSoCoyKWvpDLDXLsZnxu/+cWv9styfuOu1Z3v7IFR
         D3uBydvTOa4+EsGjrIOoszLrQnO/yK+z0AaehAGU7sF80LptlOrDDUPU3OpFJY7OTYfR
         AiPsFRbjCkk6bsDimg4CRqPSO984w3rhymWw5S37+SuQDDwiaqmaGkDS7bdZKSAdhotc
         YvOBj7tBsGFECs+Mwn1pyCGqsFeEN3kdyMnJqdTgVqUg68N/3rdZa3bO360rTbpNbMVx
         2szA==
X-Gm-Message-State: AOJu0YzPtN88bC/0TWEgtRL3Po7gSl6jho0WQ6ERY+XGO7oN7GEh31nb
	lcK/Vuhkt+691Xo1OyHnCe7HdYl6BPwjic9I/U7PN9NqCF7D1iBdu2nrfbp4gd9jqM6i9WvtocZ
	dO2R46g==
X-Gm-Gg: Acq92OH8HT9TaZCSgtvXE574LX//eqigENUTOlxken1XHYdDEI1KQwObup53F6uS9sI
	WgyBYCkqXt6p0LWVIRGXYbXkPOErYE0sOqSDElk2pPQcofJfB3yyd8pWUg89nGQGk4IYLwVdiCp
	cq/g47yaVM8TU63G1OtbI+XQU8gdFKhJXGQTsDCSp11rRjT3e/QFEiepomi7g65615/sQNB/gN6
	OKZ6zIZVMeUxacBzauYH7Bx5/ZvuyybEcdq5R1N7OJz0QArCA+kcAblzhVGQF4bMVcitYqpSAhO
	2paKqPlVJav/3JIPKYItXOFS0Ky/FBUC47hoI3koPm2c7r5H5CPfSaeNH8A7HGIpVqY/wvti7zJ
	n7VFvArPQU/U+723Qnpk9jOamUpsW4WZFLH8OcjONTE6y3NLSO45fgShKtkgYRxvSR+aDaFL+TV
	gH5pDXTrNSGD4c/WnU0y7x4M4MyFk=
X-Received: by 2002:ac8:594c:0:b0:514:d48c:f69f with SMTP id d75a77b69052e-5162f5eae22mr109691061cf.51.1778770085355;
        Thu, 14 May 2026 07:48:05 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456c0a42sm19125461cf.10.2026.05.14.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:48:04 -0700 (PDT)
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
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	zyc zyc <zyc199902@zohomail.cn>,
	Manas Ghandat <ghandatmanas@gmail.com>
Subject: [PATCH net v5 2/9] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Thu, 14 May 2026 10:47:40 -0400
Message-Id: <20260514144747.527175-3-jhs@mojatatu.com>
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
X-Rspamd-Queue-Id: B21DC5437EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288007-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com,proton.me,mailfence.com,zohomail.cn];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailfence.com:email,mojatatu.com:email,mojatatu.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

The original patch rejects any tree containing two netems when
either has duplication set, even when they sit on unrelated classes
of the same classful parent. That broke configurations that have
worked since netem was introduced.

The re-entrancy problem the original commit was trying to solve is
handled by later patch using tc_depth flag.

Doing this revert will (re)expose the original bug with multiple
netem duplication. When this patch is backported make sure
and get the full series.

Fixes: ec8e0e3d7ade ("net/sched: Restrict conditions for adding duplicating netems to qdisc tree")
Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Reported-by: zyc zyc <zyc199902@zohomail.cn>
Closes: https://lore.kernel.org/all/19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn/
Reported-by: Manas Ghandat <ghandatmanas@gmail.com>
Closes: https://lore.kernel.org/netdev/f69b2c8f-8325-4c2e-a011-6dbc089f30e4@gmail.com/
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index bc18e1976b6e..d97acd2f3923 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1007,41 +1007,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
-static const struct Qdisc_class_ops netem_class_ops;
-
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
-{
-	struct Qdisc *root, *q;
-	unsigned int i;
-
-	root = qdisc_root_sleeping(sch);
-
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
-
-	if (!qdisc_dev(root))
-		return 0;
-
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
-	return -EINVAL;
-}
-
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1118,11 +1083,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
-- 
2.34.1



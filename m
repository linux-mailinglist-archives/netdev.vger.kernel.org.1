Return-Path: <netdev+bounces-291308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KuiGAFAFGoXLQcAu9opvQ
	(envelope-from <netdev+bounces-291308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CECAB5CA753
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 128393016268
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458F73815EE;
	Mon, 25 May 2026 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="dBWykKZH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B42381AFB
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711977; cv=none; b=QTKfHG4Mz2mW6Li573NIPwLd2wIlIQD65bfPlcoEBkfn3YCcFUnZhwEgYieEhznAFQ2OwwnWq/5vkcq7Qwe0rkFRnVVP+PVVLdRtXqPAgbxMxpg/qk+4usEQTxm2VnHtV+pmccOa/965z4NiAGRPEOPuOUTYuyAR9x4LeK7yC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711977; c=relaxed/simple;
	bh=DlslhHtAvsdm9e0yswXJegBB4n6O5ERdHjgGx+K3mXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERq/y8x3+cklqnKFUhaP9NAG3weWX69ipOaumoI4KsKdvq0uLrXkTgfT4tgagRyhAlN1Kon677CRVHRBVtz72GgQ1q7Ji/SJziXUs+qVmQ5NxZP3t2v5cZlKzHQcN75kO7iT6GKuOaz3nvguIY5a/+wMUBjy4PbIoF09ASkkH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=dBWykKZH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso112469261cf.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711974; x=1780316774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvzA5Q8VTxTUwBY59m3eDvTuSG3i9RjyEErj/qw1SAA=;
        b=dBWykKZHo+lBbkowcDfdRCYnC4ODPwiEiRWQyA3DKEnC5ijdr7h/bf7JgWsiS1CBlC
         QUgSBkFm5pOTaJfIKIWsXFfGlGknsPtvfo0pn1OBPAx8BsOOi7nAaR8f4cNoGPOdXdAr
         HeJgDmyA17TIZlUtjD87Wn43ssQhxFBIJoxGJ+x0NGzeWIMlxhk6ECFHF5CTRqFhsSAU
         BE3ZcCmHhkRwe7LJk6kvoB38I2MONmZERhFYhQFP5fu5TvCnX2jnLW5nAwz0+X5Sl2S5
         2q9xm9aDwsROst0WNp1XDX7dntiifmf4L23KxJ5Hs9qsXnTb/C2Rfrmi6rNqIOF18g/u
         6TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711974; x=1780316774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DvzA5Q8VTxTUwBY59m3eDvTuSG3i9RjyEErj/qw1SAA=;
        b=GBtCs3A+CTFxkymD4PusHCBb32F8aa9tHLhIdpzB3yuN4MiUuHL0amTL9sfzmI111A
         hNDY8Ejo0HF6NVTknJeKJWGMqUN2ntOj6DSuoac3zuUVZNQD166uEosBjaqH0KtlbtOT
         7XgWJChGRvFSfHNQnAC4Yh/21oGObw+4veHUsAUuRz5+SKamRTOR0tTlmryqSVmAwdmT
         uRojly37snsokFaXMJPpYidxnLLhapMPKtAbvBwJ+kn8fh3ET+SGGLDeIai09MgwUCiV
         Fq0MPaOvWwGXsBfRFrtq97IwZsKL0QnfrdbZpJIBqAczsDfMMLUeK5QXR4RIwOFYahx+
         SyJA==
X-Gm-Message-State: AOJu0YxCtcespSuUdz6BXdH/gTFsrJ7XMbedT05mjPINlrcdLyCAQlI2
	zu3mzmi4/g2EV3HuKo4mUOu7qQ4z3bOjF/vPko0+M3tzv65GKdPxrrpJ1yzjUN/wyEKSaGd5M2/
	mj0L8Xg==
X-Gm-Gg: Acq92OGRXu+MV6q5NyBgP9xSlN5xfTd04wrZHab0M1XNo/7tcft6b4G1ehzh0eroJf+
	tE52K2v+TsFsork6wJueN1UFgmTvmqIw3hJIlVmJ4mG+veSjfG36rwgCi+jywxiSJ646DR1ybSi
	Xotxo4783htq40JGeFYYg93Fjm3wgJBJLnfHpf5MTABbKBL8m7/fUBPHFz7XH0ycoye7HbzVGSW
	uIwFsANSUVME34RsPhzsAnhCv8f4kNbKVJnmy4imG5+EG3DbW6lsm57jHEHEow9ihgGVoKKExe+
	Dwu77/okrWn7rgR9HXBBvfanNtyvXw9SmSTNtQVplGXDZtEWq0oSHnFEWLhc/cWGG4hOqr/9Glp
	UGFzJMPBc8/UXLZhyD6c9NFSwPLpwXoWUuusQUsgBNAFKg25gfVvKKHQ9UMsgV4Zo1iMtwb6awj
	KmLUEEmYYRv4m+QhVpillrJj1WTKU=
X-Received: by 2002:a05:622a:43:b0:516:ea00:2eb2 with SMTP id d75a77b69052e-516ea00353amr96373861cf.21.1779711974528;
        Mon, 25 May 2026 05:26:14 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:13 -0700 (PDT)
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
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	zyc zyc <zyc199902@zohomail.cn>,
	Manas Ghandat <ghandatmanas@gmail.com>
Subject: [PATCH net v6 2/9] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Mon, 25 May 2026 08:25:49 -0400
Message-Id: <20260525122556.973584-3-jhs@mojatatu.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291308-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com,proton.me,mailfence.com,zohomail.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,networkplumber.org:email,proton.me:email]
X-Rspamd-Queue-Id: CECAB5CA753
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.54.0



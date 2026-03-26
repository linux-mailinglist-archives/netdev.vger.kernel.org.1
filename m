Return-Path: <netdev+bounces-272194-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMAfBZR4xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272194-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:19:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FA339F22
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB708302FBCB
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCA288CA3;
	Thu, 26 Mar 2026 18:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="qn+L6/4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58023A0E8E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549046; cv=none; b=bi0QikBKYZAVDQv/zjuqIoWgu5tf2fJkV1VNB/ZawOxi2kOvk9/UnUci7Kj0JQzrLtPfTdMP0rC1t2IyFzkvru48L+kSJcTI6xDBui2t1XjOQkyFKOWDUvMhWkEjvokbGoKCvJLG+eSYFA02WjFmY4GlY7F48Xd6FdQ7JCxUCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549046; c=relaxed/simple;
	bh=3QA7aqOs7NdMeZQANITREyYa0BBBRtzKjmLQSGKI2aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9H2PIBBUo9HWH/H+jXL8KopMu5s2ljEtawuQ6A4P9qTwNrt7p4NtzxyIQNvoHBGRzXgB9QeYByyJDuIjLYtavozOip41maOjv4e/5xytDaXr5fqMShpTN9xJX5H8TW1piv8aRsV1Re8k3wkQ5aTWjuddTTQ5eBlwd57BI7hZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=qn+L6/4Y; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso540711a12.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549044; x=1775153844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po2OlVBw+U8MMEUlTvgdwAWaKuBpw4x1Cc+xzNEMXsE=;
        b=qn+L6/4YYvm8eTTV4gt9Q9it35HN6F212tNVCZnTmzLMTO/HyKKwFGTXqEs7bBGcbt
         wGuuaYv7PaAniF/e20orhJd9y54+PM4feSRo+w2y8/6dhY8/OqcHmevBJrsJFVOOIIH8
         qbUQBT8OVSuvZgIfRiqM3OHskkMZwDlTO32GNa2lizYiVCxFTe7Ygf2ianxxILgT8E61
         KzvkzddjdpVbvELfvyjfPMTO5SyVBkDnZNCO29OZhzr61PLcWe9i9SbgN37Q5X7zMrXa
         vGFjh6Af2mfrKcqKirQcKSaRhw6NKBHGS/u7ZBQWYg45NMm1kfktQUG2LrfRew7RU0YQ
         mHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549044; x=1775153844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=po2OlVBw+U8MMEUlTvgdwAWaKuBpw4x1Cc+xzNEMXsE=;
        b=QGOkoWXiXPpWiii/jMUZu11730HpHFfIZ2uESQV7dJ3lxdaIpA7toHVhcGceCn0Mmh
         eYUzOvF4PInJNCUt+fMbj4JZNtW8rqjCM8EW16ULfuy4G6GIE8MwpJC02A3nDOQWffpi
         EW8fRmeDta+YYpxASGux001WJeBmLSbA2WroJc5hMeyfmY1DxCR9z+ugN6orcCLb2Zi9
         6CHYNUat7422CZxiZOJSQYANeyT/GC5xyBee85yXHlh1uRT5ndkvikmCAc1rfR0fwVSY
         mfvWBW1+ILrjAbVKAeksyVz6tGqbDu3BpSiiq+1jDYNv368MWGRu8/Ayd2rmUvEs0wjo
         FFpw==
X-Gm-Message-State: AOJu0Yy4lwJBK6OCgrb17SjAZbyxnVr211/kHVxDZ8a4ZI5nrfU7HoTT
	vuwfcZGu2i3jQl8S+ENKoJM/yeLG0nbdfN6A+KAOB2Rcw53i7NrDe2G98yb1eVHg32io6czkDk7
	0q3Pp
X-Gm-Gg: ATEYQzyTsTBOXJyRwFAenQJputJyGXAlPDJ1/72+DU5NIy43+F4hbs76V+pRHFJJKI2
	NAqubgjaBmgqinIGdalFikfFpm2jo6gDMwYMozsIoJXALtx+bD3Mzf2h8aaXFih0omYc3l5iXEi
	XhE2/0WA8gqpjHe2cDNrLVcNEu+17ypLMR68A5nK+5UfZKbe+P71tCQ8gcXGJILxxND2adzoZGa
	sdlqeyxQfkj3CYDnfrh3+FgH/0xCLYBS2CeRKLIM9u+O9sHIagDD2iICicy2KNQRgj2g945Anl0
	kFFsIz/I+/llRsYPVLKhAINRtWaG9bRVCNaN+eg0Ae2rHk1uxDS/4AyzNwS0quES8D0xnVTgPPW
	0jp4A2ENmmBq1KhvIa+WlL1+c0+/nq54qSyf9oLK8V1WG/2bmbk9Ud1Mi6e8rAt8VSt//ZQRkom
	UYBFkatmB+Gbay5yCg9S1+HhMXHzzlTC+6v/UrJ8Kk0ck=
X-Received: by 2002:a17:903:3890:b0:2b0:6365:21a9 with SMTP id d9443c01a7336-2b0b0a7591amr89177155ad.31.1774549043898;
        Thu, 26 Mar 2026 11:17:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	zyc zyc <zyc199902@zohomail.cn>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/7] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Thu, 26 Mar 2026 11:01:01 -0700
Message-ID: <20260326181701.308275-3-stephen@networkplumber.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[mojatatu.com,proton.me,mailfence.com,zohomail.cn,gmail.com,networkplumber.org,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,willsroot.io,syst3mfailure.io,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272194-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,mojatatu.com:email,networkplumber-org.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,proton.me:email]
X-Rspamd-Queue-Id: C24FA339F22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jamal Hadi Salim <jhs@mojatatu.com>

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
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/sch_netem.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 5de1c932944a..0ccf74a9cb82 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -974,41 +974,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
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
@@ -1067,11 +1032,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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
2.53.0



Return-Path: <netdev+bounces-267605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODnOLtN+tGmuowAAu9opvQ
	(envelope-from <netdev+bounces-267605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C928A142
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DDD3301CFE4
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068D36B050;
	Fri, 13 Mar 2026 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QV2JyA1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4A37CD4C
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773436622; cv=none; b=uCL29/W0H5tz4MFJK4k8pBCC9hAKa6ktBTd0KR984G0A8PufgwOTnuai0BnVlgFFYMmcMGdY2MalQ5dGhLQfMm+PWiFYEs+eIcEp6xfYEgYpbWRlqwzzlo8n9mchySOAhj5wh0wsh6mIkbNTBe2viLvBdlPGVjGChqBnL011IF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773436622; c=relaxed/simple;
	bh=wwGrUQgxU7uePMbyqhRtqzF8vy1orYlCZoYEmlnK1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX4Ochr0GUy9v4can5ssT4pqDj37l1ZNNBA7h+7z0795pM3r0KN91SOaxZi0QgFgDsZAZf83289SwkWzBrOoLa5r7CT6ZUG9yYpa//3ilrAsDvEuDyHP0uB0hzC95CSy2PJehBFmTwZzUnV+kRxssxd/spYzoDDqNWEAsRugZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=QV2JyA1D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ae3a2f6007so19647695ad.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773436620; x=1774041420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=QV2JyA1D4jqSD4VBBSOsumGdgjqL8bGG2Dkgc5u4ZwrnVS0VSUTG0N7GFTSKGzDtJh
         Sjc8DoYVaUJgbZ7HNmXf7P8bHzRIb3qssixlDH+LWBa2xcLQOHPwIWvNqwEx9UNXr3eB
         r4lke7WLeaNfHss4Thr38QofR0HUMNmO9iQIgb2wLwowN1Errn8fzNG4YJaaT3BnCShB
         WBByDmfKGbOmlRX4xwkhm0xzqHKjW9I441jC/SpHOlasX11gDFc6gG82Qy7Man+vjWi2
         JU1gqqc1mq53rqMaxnuMPK9h/ETxNuPWwG2sznATXQ99cZrn0BsS+oAvYDMLLS6kOzq3
         9olQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773436620; x=1774041420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xX9Tgk0PCVdVHRhl80KArNy/HrovadxDUjYA1eEpUQM=;
        b=FduZJgz8teRKEc65ObpxZ6NdZn7VdmoqfwWaSTmgwfXzoHmK57+qpTXijcVk4rk9s+
         IcUY/Pxo0X42kqA4turSJ7kxZgScKwaJNmQsjbR9L8t+xEj+HRpSqmYaRC8TX9+GkFaW
         71aoJ0HjMi9ShHnnH02Fn6yKpOO6nWanTXPLpX/joEwi++nJneXQCzWHnDzUusZlUXpC
         yxpcywPl2kIuItiOctyaRmQ+Y6e8HU/bbB9t/YmWubzb8AC7mSIWE25Rv3sebZEfAB/X
         8zrTUWvjmAxucWLSYCmKGvN1+YstO9dK7lZOLP0RrPehOHRg//rhkNbnqZC0YYKANpIH
         wcBQ==
X-Gm-Message-State: AOJu0YxqolFABc+ImDJwNzK4m5GFExzmVN3X6MKeeovMXUD0jNdt9gUd
	0Rf4bcfrGsCw3QBtGyHAZWa9UNN44jvO2i85qjItrrP+sAMqPjYRm3+hu4J3wgRFq9jMPPWu8iR
	IorFoYdY=
X-Gm-Gg: ATEYQzzXxM0585AA/PngP1mNEx5S0i6DPScsJZtsINWbK8XuRiRegUFhGh7EUQf0/Yv
	JzxVgYMKjzS6uXGaBmYlgV4OAszBIISDVKAIe5hbYqyEONCfUw5tVLHBVzTiZWVO9P4oiQNV3kC
	vh7Gj3Qd6rRpfbv67p6IkYnPZD0SMlmlCgERt+6DOFBcV88tlngwBf0AEvmhy/U8gdnfNNH0I36
	ooE6DWx3RXtN577rlKZOCGyi0ipx3jOKs6++rnK2dHUxoBwItwJHPu+kIL9rC0eknvw8yBy19of
	a4sLPK3TQJbjb7SMVi5lgMEjRMNN6BMpbP6vKnG/bcP5RtP6ARgme+xinE4D6yt8eMN2hsm+VUR
	fPRsrjPMeF/bCY+xI/Tgr3HNpwVuMF89uoTGzBpv2Y3JQmiTQxRRpnqaTEDwTtYKf88kM8fIwg7
	vrjr9uAE3i1CwKjheFj41yBw4RalNvHEv6
X-Received: by 2002:a17:902:ccc3:b0:2ae:4645:6f77 with SMTP id d9443c01a7336-2aecaa2f920mr49528875ad.20.1773436620333;
        Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece81afccsm31204195ad.68.2026.03.13.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 14:17:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ji-Soo Chung <jschung2@proton.me>,
	Gerlinde <lrGerlinde@mailfence.com>,
	stable@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 02/12] Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Fri, 13 Mar 2026 14:15:02 -0700
Message-ID: <20260313211646.12549-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313211646.12549-1-stephen@networkplumber.org>
References: <20260313211646.12549-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267605-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[networkplumber.org,proton.me,mailfence.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,networkplumber.org:mid,proton.me:email]
X-Rspamd-Queue-Id: 323C928A142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This reverts commit ec8e0e3d7adef940cdf9475e2352c0680189d14e.

The restriction breaks valid uses of netem such as using different
netem values on different branches of HTB. This even broke some
of the examples in the netem documentation.

The intent of blocking recursion is handled in next patch.

Fixes: ec8e0e3d7adef ("net/sched: Restrict conditions for adding duplicating netems to qdisc tree")
Reported-by: Ji-Soo Chung <jschung2@proton.me>
Reported-by: Gerlinde <lrGerlinde@mailfence.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=220774
Cc: stable@vger.kernel.org
Originally-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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
2.51.0



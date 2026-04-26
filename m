Return-Path: <netdev+bounces-281182-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHUUHQpj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281182-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C18EB46ADA0
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B42623005768
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456737C107;
	Sun, 26 Apr 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="NT2AvaQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4137C0F7
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230569; cv=none; b=CGoakaPQ0+vVGT4fI7eEJIeaVs30iRYyiM86E3FqHi3nExcuzbOlgaZcUJwXELGboHNdwgy2IyNpMzjCCBHGDm673o+YHpiL0IOVnYHpnbB3G6lzgsBnbVta6g62WrxvIilHYyY+/NtOKgsRKglqldNfr5Cig7y3MZ3OfRKpbio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230569; c=relaxed/simple;
	bh=h/iE82qeH9csepVFncZQdPCHPa5eNu2saC7zEOBGHoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3WFbliKn7lb4TIPAcYJO1ZE0ip0a37Fej49kegLwhvwx2b2cQojzA6lxJi+mfs+ScMKZD2eJsADLzx0P0/jnMA/BTC0a3bMjykSyF7HGB2gOqBxjzP3CGxdAoolImTgacWuJZdTu1JIjslgQFvlSqmDgSaz6UiNxc+TJRzGJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=NT2AvaQW; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a15ebb3abbso133413856d6.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230565; x=1777835365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQgz/WjUv9OCnKYWZ9i7ppC9XPBIIWVegkR/J5S2lgk=;
        b=NT2AvaQWes+bAx5elJ824KIoPwANhUouOYy69h3dxPgOckSMiQNaAqOGzv0FsS1BGt
         jYyFytGD2HqfFqZMZIjAfs032/GeZtxnZL46jzRn8seH3m9D0TwDPAilxiB2Xx5jmEa6
         9M52dXY9UfQvvFuwk0hkOf4Q+yQ5vMUTurkVv0/zJwSw6dyQVDxRFmwRuMNOiUYw2Ott
         jDQaZ+m9jisJGfkU8zxE4KwLmx+UMKMCU+q0k5g7KqpJATLw9UL6EsIf+EAZdsKdpaoR
         X8xj91s/nFFRJUCLw2OCGQ4xVnqk4g0HmI2jf+BmrpBhNENIdaUrXraQmYMmjpICL63w
         l/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230565; x=1777835365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQgz/WjUv9OCnKYWZ9i7ppC9XPBIIWVegkR/J5S2lgk=;
        b=fbyPApMUEQyegjU7fPq007If6qy9sF5i3Si7TYDu+9OWzeuiqBJgXuuUbRjkkKln4s
         SFBQqSlZKvjaGWdykKyYdSNMrCgKHmK5xHf5uqBC530vAeaj/pBouUROphFxwXhsS+TH
         OqYeRDdMS4U0PVUJ6nYy8o0vc4g13E4qG7A1Pa2TX2rq4wItyK4InZWapOxukfhPbHy9
         nAy0c4NlJ+jGiNTNOZ+nLwlTruG/OZwLSXUw/bebNwdjLRBrPpQUOxG+L9tAoXdhCzk7
         BewLNpd5oD3cgEJZlqm5ATTgitbljTQm1KF/gxqSt5uHrysCSTOMsQ7O4/wLWlVXWuXr
         NaRQ==
X-Gm-Message-State: AOJu0YzAjNzxZcHV8QCqJZVYPOKerRK4/0pawDulteh7+8BNBn2PnfE+
	sW3U+3xTy3Vq6tmR1g14huAimStmcJVqldlzdAZsm1zmB8ZPCINmVWi55yx0zvhIPG9anVs9aro
	M3pQ=
X-Gm-Gg: AeBDietBVpMFjllCZSuHmNcx/scq6NP3YaVqJR4inZ/VxjfiHr74A21EnoVZjl6xrY+
	D4cYfZl7QHM4cAmP/bIhyX6u5/FCAMX69hxT2Wwgpgu/CbWw8V1WHdhfbvx9ln6MdL0HlsIkuKx
	qt/IV7XZUqNMhqu1c+kLk+14m3Dk2iKXcuJC5CPXiuVEKm8pMxeLOlnDxJE6pAW9a9WpOkN5j2A
	EeID6BDEb2aUbmv6DjnL/4xtAb7SU/mKQ+DWd+M46SmeDGgOJtUy8ZL5DZiZzEus7nL6HaWdgWL
	4nbV2mtL54ZhK1jCh3oTfGVLomIMAVo/ygEpFdgVHvHpPl4hYXjWUYf7dWk+UE81RI7LlKkZ13o
	kH20aRQk+IEBJhd0wPA0XZy3KxzFPJMMppSzQLzw/7lxS3MOLX8tbEE3dzfO0caC3ZkvPWXQ7nF
	pQJBtZ6oI12ADe/T6vAlHiobJsYZTOk7x9tJnYG6mPjDzDYg/6glQnII7FQjk9X2uQY6c5ZUeeW
	qFBr+QctCxZvz9UJ57MMpHZwVryGss=
X-Received: by 2002:a05:6214:5901:b0:899:f993:f2a3 with SMTP id 6a1803df08f44-8b0280cdf0amr686668856d6.23.1777230565395;
        Sun, 26 Apr 2026 12:09:25 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:24 -0700 (PDT)
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
Subject: [PATCH net 2/9] net/sched: Revert "net/sched: Restrict conditions for adding duplicating netems to qdisc tree"
Date: Sun, 26 Apr 2026 15:09:09 -0400
Message-Id: <20260426190916.128489-3-jhs@mojatatu.com>
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
X-Rspamd-Queue-Id: C18EB46ADA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281182-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com,proton.me,mailfence.com,zohomail.cn];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:mid,mojatatu.com:email,networkplumber.org:email,mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:email,mailfence.com:email,zohomail.cn:email]

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
index 20df1c08b1e9..8c6dea196089 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -975,41 +975,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
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
@@ -1068,11 +1033,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
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



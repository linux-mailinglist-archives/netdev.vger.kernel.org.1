Return-Path: <netdev+bounces-296804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7NsLA4FgJ2r2vQIAu9opvQ
	(envelope-from <netdev+bounces-296804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:38:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5F65B63E
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:38:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=gA5qxBbH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296804-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296804-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DA903037BC6
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33CC2561A2;
	Tue,  9 Jun 2026 00:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC09923F40D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:38:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965497; cv=none; b=rx3Yuq94gMAeQkjvht/8RxYVg40rH/q5yDK5lLc66/AobhqrW+MGLuPaxUbhro+oAxS0wFZ8cHAPH/zHgLR4GWYCMavoTTElbjJrev/HlHOiLXb9twGbYuGIZUihC/HEkTmMvGOwjPLunVdgF9nyTR3R5W9QR5IZ4O0/F1matew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965497; c=relaxed/simple;
	bh=N1qH2FvaRu8zuEAqh5JOS6b/DeUcQLZgljy5SGvFX78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djLZpSHKZwdaCj/Fs18Pt2tzkCsP0a9YfF4P0Q8HWjJeDENnEoN4TwcLe6MHmwdMmrsvf7HI5q3OW+7/83+jQ2zjT/WXVfJHXUStUNYqu8T33A2O4EGwNqwQhMdJaiW+83MJlNEaIpgge0RlcxakNU6rVVCZEnly9siWD7Pu028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=gA5qxBbH; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ce9df4732cso52096466d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965495; x=1781570295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kuda5vr68FXGwAr3iPeQpShs0cz3w1r9VhYxWIcwjP8=;
        b=gA5qxBbHsFXVXxVeG+j2dnFwG1wUtN8duDCdVR0mkWJXOCBHQCWiqKN2Bt/RfcAZCF
         gqwAUoEokVbKW3NngTmgts4C8dT1RB6eGFqcpF3xt+fJLTEOilMxywoJjfqkh0WSl8jg
         tPTU861XFJ1Cim5hJnfeXZ35JT2i61b0dXNTJdIqeJZx8YXz1DrWChxLYjRwwLoH/xEZ
         KtOOG+8Xlr+5BruaxSM4cf4TVXiVKE7XOTWlHyk0B4szlZSo7kPVY63ZTASNL/LxuTYW
         1LPHPqH09uuI3XQBBjMSFNiL875eai1ZFzS9fIBzbg7AyzGqBUs3fZ2xAeFhXAU7aXJu
         5vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965495; x=1781570295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kuda5vr68FXGwAr3iPeQpShs0cz3w1r9VhYxWIcwjP8=;
        b=PHXR75Kdj6GduNeNLBW1kyohz2/7lSHc0qcQ/r/japt8YAM/NKMxAyHeejOzQXHKFq
         0tfzTKULKvzK9MSxb/0qqVRmtR8SAqLpTU12JXpOOVyUkiOHSxMwZ4voApwr5RCkMeHK
         m6I7r6PhDVD53W7kFqVBZZ/61V7EodJ6ZtEI0jpyQZ5u1GnCsFFnOV+Vd7Z4xXKNgsXr
         IL3HHl2KQCpyzpNHe/rIowSkioZ5LGQKlGlrLJL1Cemv9L3YsgQ+S6yi5SlGw71z3f0W
         gN7LyfZVzydwPKsI/17X45QHlEpWNo2BdOSphmZWZomarkppwwUakVeGXGb53v/N5U6W
         m/TQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zBFC3VPzdblZtJPctkzZVzhZlrLu4CUuILQe54JxdUUJkvgK6T4tgbGwHi+BeCnFGKgUqtRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMOhNRuXKazRdkR22m9Wq+juFgkcQ+tZvDxYYbvNm0PWFtAC8
	wPaX/sTZ4FjpZh9eHZGTJOmVQTiviEIOECJ4u6IK3hgND7i1WNZPjbldWLcUIVxPoFw=
X-Gm-Gg: Acq92OFzQTSC7LqwJavUp8IVcEjNM9uhtsQbLSJbwzr8cdO4NS6jTpqWRXEvmLn1zQs
	G/OHh9HtS04HCzcROBFaHGaf/N72LkoQbTpE+koAmkU/jKb2NXZ9Qcj7W4EI/SWDJIIH3UguP7x
	mZIQ+K4kimFAASK5+5sR+wJkucl4OoPcelC5FU74IHfohYaves/SwAL4SlL75qsuIoUQeHM7LwP
	sOhbjPl2/yuPo3bYvhGydcNkOO5CAU2rShOpWArlKXZqyt6gNIdnvG+hjk3UxUnvC+yYd+KawHs
	xV3CPGFizrd2d9ZhgWJkitJg+Ui6XK1YgUfVqxbO21zvmHMWv31XbdbTjcXpVawxqAGwFZj1vnl
	Wgpz7Re7OKix3VhOtlQtj78bnjp+FDqioO+rxbzzru7QFveYJmNzW+Nt8Z+zj6xKqobpQdOEFYM
	G2ivqt+WDdZI9neOSZn//52mDOX8AumUhL5KQGBQ==
X-Received: by 2002:a0c:e749:0:b0:8cc:60dc:a249 with SMTP id 6a1803df08f44-8cee63b0d08mr223565166d6.42.1780965494623;
        Mon, 08 Jun 2026 17:38:14 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd263003sm184948076d6.42.2026.06.08.17.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:38:13 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org (open list:TC subsystem),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net/sched: ets: reseed class deficit after quantum changes
Date: Tue,  9 Jun 2026 00:37:50 +0000
Message-ID: <20260609003749.1238146.66c32a2beed5.ets-change-class-stale-deficit@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296804-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:sam.moelius@trailofbits.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCA5F65B63E

ETS class reconfiguration can change a class quantum while the class
remains active.  The scheduler keeps the old deficit and spends that
stale credit under the new configuration.

This can be observed by making a class active, changing its quantum, and
then dequeuing with the old deficit still present.

When an active class quantum changes, reseed its deficit from the new
quantum so the new class parameters take effect immediately.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_ets.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b77..8e7c90689ed3 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -249,6 +249,8 @@ static int ets_class_change(struct Qdisc *sch, u32 classid, u32 parentid,
 
 	sch_tree_lock(sch);
 	cl->quantum = quantum;
+	if (cl_is_active(cl))
+		cl->deficit = quantum;
 	sch_tree_unlock(sch);
 
 	ets_offload_change(sch);
-- 
2.43.0



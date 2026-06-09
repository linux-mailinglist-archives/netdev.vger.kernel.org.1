Return-Path: <netdev+bounces-296793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VswABulZJ2o9vAIAu9opvQ
	(envelope-from <netdev+bounces-296793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:10:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0F65B48A
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 02:10:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=jx9DNjlo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66EE730316CC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE75548EE;
	Tue,  9 Jun 2026 00:10:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0933AC00
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 00:10:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963813; cv=none; b=A3Tb32pJlM4zcLnmpamomTb+dqBfsXWupafWdJz8+oUFE+LRo9HgydeSxXBwTmgxiXa2PJBVOFVP7VUPGYrCRzfpvROJ/HX8LC1zLsXDKozrIc1KEv/4L7QqrVyIKQb8+ehOk/ZMJYmqO8QUllhjvGRIl6yDa1IB+00xTT9TrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963813; c=relaxed/simple;
	bh=CBLXBsl+/GKva8H+PWvMh4HA73Qy3u0e+6+UwWe22TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDOGiYgldQUnWHHtEuV1ptU97a1DgBizBEIYaiZzpuS5lluQQEMe4fK9fb6ioxHWKEkmE4ZieoNAYgQE97FnQ5yPe2O7KF116OenU4JLDnsqBnbd1yTYRkAyLPu7UsoT0MR2WZgNKoV19VrZ3fNqtHd3r8K8mYj5xA9ZuxsuPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=jx9DNjlo; arc=none smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915c36e32abso189184785a.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780963811; x=1781568611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfJRQNth12Vv3rJ4W2UKh/f0U7VaUwjoEIMtP/Wtlic=;
        b=jx9DNjloXtFs/e2bVPCpPlr/2FEhZYI55BK1p1hgiEe2Bjrw/qyGae7DTYC/o7xbmN
         C5jdyFRZiOfQX0s5HfduqF9h1bAm+GHeF4vs7ZD62l4ivhJDWybh9TSe/rqoTBxv1oRJ
         JFmuXT7mphyK5GnNkiHL3TSYl8LS6ekW4Wgg1JbSWTQvg+9r8tIH0xtZya5Mev0shBsS
         XCXbehxHkBq3PNrKAWcsCbsJvZt2E6rJ3jmMZNh0Y997IzqcMx08Qr0aQlIAN8raRGeT
         hT5vkYlnQGacEsw2fr5ZDfqaL/HlL/J+zx/X9RJCOXSQYf1lvMPnq0wBr3EyPOfWjGFK
         8oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963811; x=1781568611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfJRQNth12Vv3rJ4W2UKh/f0U7VaUwjoEIMtP/Wtlic=;
        b=odLTehlrVXsvYN2aMM02GpJm3V31WFtWQeQZyOuzYEi2znMJJ5P2c/uwT9SvM8WS1V
         PcIZQ25CyJ+rdH5dpoDM9Oov5Fp6DX+s5lRxLKHiNkKV4Y2+N5FEFj8kyOWaJ2hhrR26
         /GALmC7br3rwYrOO2vMtZdyod839SBLCeOVcKR8exJ4Srzvnh2LkRrRo+IMUYGIZpuRM
         Lg4Mwfs7CWK2iY9AIge9QNzwfqKp2Sc+bNVYjaCBMOZBDR+h0tl0K9dN3mzRUG52Aumi
         3YL80MJTgMRcMW+p09bg+ArN4vUilBQqJdTrzf6eIJd9mw73T3kP/1tLP6dzXIMguBcl
         2hDg==
X-Forwarded-Encrypted: i=1; AFNElJ9ZEMtb4ouTdK2IK8/Da68q3kFVWHhadhnaM3PvJe6sVuOvPSoK7xu1TQVOECM0oO7d8y2eHpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGjmIv5XLqXfJtD7W3qbanPOqoVUXk9tUnfEyrHpQXAhjG8RR
	+u/n5nHpeMxEiuW0uBwAYwjL+Pyg+xS4ur0kbifkD8XPvEYCLYdOc7a7libXdX+saXk=
X-Gm-Gg: Acq92OH2Y9g39jUGUqQANe1gEYUXdE1myx7dIsay+aCz9uCtHtV2K2ETk7LKvPeDthx
	eTbcuJ9/jO87H6uV5Ef4FEIz5JiY9xCBuNrwByKokvfDEq2z2VqLzfXO0WDIkiL8uX4hegbOFO7
	OyeCOFGH6yyv/sOASojnISOZXFMIKLE1t4i1oRkW0GXOLNiO31m99Dib75CMsThOyx+Xi3vERxn
	UA2neLqCT8Fbwm9NX8YZ7rCI5c6/6Dg/JBcr+r9p6gAT8bR4LiP3UZ4CQWMzpByuVWHdqzWw+j4
	cClAKx7l13SjxEzf1dJZ5nKTS0H4g6k1JInKlTek57qNaFN6mKakFNsaPZsiDDBQwJzotBta++9
	iQJxdmjLUe62QXe2F+QxAUh8H+8ywLCWiBJuNeM7bmoggw1J+rqTKxbJz1IWESA2vTky/+4c741
	cIbwMV93mW3HpWxHrPfHZJ+hQ4udv4FFPf1COLQw==
X-Received: by 2002:a05:620a:44c2:b0:914:b65f:6b00 with SMTP id af79cd13be357-915a9c13262mr2630434385a.6.1780963810824;
        Mon, 08 Jun 2026 17:10:10 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8cecd054d2asm183008646d6.23.2026.06.08.17.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:10:09 -0700 (PDT)
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
Subject: [PATCH] net/sched: choke: trim backlog when the limit shrinks
Date: Tue,  9 Jun 2026 00:08:51 +0000
Message-ID: <20260609000850.1234569.a788bb380be5.choke-limit-shrink@trailofbits.com>
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
	TAGGED_FROM(0.00)[bounces-296793-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,trailofbits.com:dkim,trailofbits.com:email,trailofbits.com:mid,trailofbits.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FB0F65B48A

CHOKE accepts a new packet limit that is smaller than the current queue
length without trimming the existing backlog.  The queue can remain
above its hard limit until later enqueue and dequeue activity eventually
brings it down.

Userspace expects a reduced limit to take effect immediately.

Drop excess packets when a configured CHOKE limit is reduced below the
current queue length.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 net/sched/sch_choke.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 2875bcdb18a4..c355c7a05da3 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -371,7 +371,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	mask = roundup_pow_of_two(ctl->limit + 1) - 1;
-	if (mask != q->tab_mask) {
+	if (mask != q->tab_mask || sch->q.qlen > ctl->limit) {
 		struct sk_buff **ntab;
 
 		ntab = kvzalloc_objs(struct sk_buff *, mask + 1);
@@ -390,7 +390,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 				q->head = (q->head + 1) & q->tab_mask;
 				if (!skb)
 					continue;
-				if (tail < mask) {
+				if (tail < ctl->limit) {
 					ntab[tail++] = skb;
 					continue;
 				}
-- 
2.43.0



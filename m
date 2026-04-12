Return-Path: <netdev+bounces-277816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI6lIaC522keFwkAu9opvQ
	(envelope-from <netdev+bounces-277816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:26:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EF03E478C
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 17:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CF9F303B4D3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640A382374;
	Sun, 12 Apr 2026 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="E0oddAdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D7382F06
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007481; cv=none; b=fDxznnefAZspsVOhLk7NwHWv8+Eu16Oi/13wpaPdnGXRht2KS32FFpe6NRzsou0hRElsfpEtd1118/ez9d839ZkLtaq9NBdS9W+RFnaOfWGLYxxjycwR4R5cng44uqWDeZSOoSn/iM/y/b/PktAaMvs5kN9+p8ilLIyVehB1KR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007481; c=relaxed/simple;
	bh=fL0OfMMtDWSxHR0JJrLSv+7El8c9nsPcZEBdX0sgkzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGz93Xf+lZaFjp/sf10Ldzj/c59cBTJMkZKo+IFQXarJ5fUMTJiCyCDqOGaVYzfEI38U4yOEAbiUrou/h1FhgAoiZbpnPcNRZA4fIbt4HQClpQekbcIf7pbHrTxRTS8xrc2H/N+S/6MeEM3fi5eh5L5yExYFiG40OnqJ8GIlu+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=E0oddAdA; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4764484296eso2172444b6e.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776007479; x=1776612279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=E0oddAdAts+4N5MC7F3rpX4mfoGgtxRCs3Yd2xls0IzARFlnFvKCwZUuULRJGJiZ6V
         xPYzvwcrqnySsXPFaQ9aqS5AxZTJlnayyUk7C4PMDNIu5QZ0EdTrIP6xe8qaOxQ+oCdE
         GPT+UDHZKt1evhB7azIf1Onpd5rEBp8aXLEIuQ9u+Uot0z0qZfzoHj7BYDaGkS5/TNWp
         l2wc4vkKSaHHMx/usInnBu+OCydfOx8qbYauZVOLHXQyTiE/dlQNL9k0HVLlLQCzLbak
         CEvZBlCTYcXYBSx7sVryaBGhW7KZGNlTkHiOXUOd2/rr+aqrcVPe2x/otPTDvdorG5AP
         cJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776007479; x=1776612279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsjmygR14oJm2Bm37kTyDucyaRPKWbtE7XhkLO/lfZI=;
        b=hQFb5g90QwFCL0J0ajcl0OYkW6y4iJ3feH9PIHQz89sJBhjfV/WqaR1KmFJb4SUJXy
         T5+dTdvNaK5GCcavZ9S4GNh3I6ERC+c8E1Y+x84DefztS4nMu9OVJDD8TItr8Uk3ym8W
         yFHfcaCLKXSN96XEs46eZOnHoQr4hzp+VFsRr5pZaPwEe9UGKikIvxXp57JUdCqzEwy0
         E7RegvkCCHGlnk9wA6rP0MXqW4BK2AhcC/G/2CD1fVQ8TeOxXb51OyONrPc0xLCvvuE6
         5lJlieHdf+qGp7kQ/RRYvBMhULdGG00yl6JpBsIgCawDYKiNrduk2pnCRoN6N2nW6tQD
         H0UQ==
X-Gm-Message-State: AOJu0YwUY9aEznUJ7prm1bC6BB98mIxNXg6oboyGck1mWhiDC66sTQby
	3FRvLlmzABS3d/RAa7gONwIhOIw70n1GZbJqEBPyiY7Iuq2m2/uMU9S0V98ervuqz+QFzhImYYj
	XqBzT
X-Gm-Gg: AeBDiespgGkUBHNdtd89E7YJ1ZnI0ed8Ljbzx2kvxd65d0t5IhuxzWm6xRj1qIkiYQY
	sioDVwxGkQ9I1x26P+Nb/moQOiBVWq9+H0/OOcdEdJrljiikWonC1dTdVqPl+Czj1+7TXdOF6bu
	mrdvjrK0bIIMQwkJYSRfv6gvtWZOi3xidf24sxTXI0Nzr6NqhgbnS689tsRanUAk4guIPwiBhuJ
	nM0I9WR2VQAh+kWe9zYEUjEJCJMGVYWTmdsL7VBIwWKIvBUFiTcRUYUeXFpyGbWbjB46d7SowLW
	ikElQmmAmmPz1CO1KIKM7zqIiDhsslWPbyeEMxuYEALQWqDjwBj0Prdy3LX9XzMBbveLFuQxyhH
	VB5F6LJsZUuO1BQ3UEYbfFi968O6u+ru8dRRitEQlJNier4A8dEC/HJEOra9C0vsX+7swzTFiHv
	PNEivD3NLZUFsny3wleUPDd6sJEWKHfw+P
X-Received: by 2002:a05:6808:1b0f:b0:468:6a2:8c1 with SMTP id 5614622812f47-4789d03c394mr5775365b6e.11.1776007478806;
        Sun, 12 Apr 2026 08:24:38 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f557b5sm4911726b6e.11.2026.04.12.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:24:38 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Fran=C3=A7ois=20Michel?= <francois.michel@uclouvain.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATTCH net v6 3/5] net/sched: netem: only reseed PRNG when seed is explicitly provided
Date: Sun, 12 Apr 2026 08:23:53 -0700
Message-ID: <20260412152429.143474-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412152429.143474-1-stephen@networkplumber.org>
References: <20260412152429.143474-1-stephen@networkplumber.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277816-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,networkplumber.org:email,networkplumber.org:mid,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D2EF03E478C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

netem_change() unconditionally reseeds the PRNG on every tc change
command. If TCA_NETEM_PRNG_SEED is not specified, a new random seed
is generated, destroying reproducibility for users who set a
deterministic seed on a previous change.

Move the initial random seed generation to netem_init() and only
reseed in netem_change() when TCA_NETEM_PRNG_SEED is explicitly
provided by the user.

Fixes: 4072d97ddc44 ("netem: add prng attribute to netem_sched_data")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index d400a730eadd..556f9747f0e7 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -1112,11 +1112,10 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
-	if (tb[TCA_NETEM_PRNG_SEED])
+	if (tb[TCA_NETEM_PRNG_SEED]) {
 		q->prng.seed = nla_get_u64(tb[TCA_NETEM_PRNG_SEED]);
-	else
-		q->prng.seed = get_random_u64();
-	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+		prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+	}
 
 unlock:
 	sch_tree_unlock(sch);
@@ -1139,6 +1138,9 @@ static int netem_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->loss_model = CLG_RANDOM;
+	q->prng.seed = get_random_u64();
+	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+
 	ret = netem_change(sch, opt, extack);
 	if (ret)
 		pr_info("netem: change failed\n");
-- 
2.53.0



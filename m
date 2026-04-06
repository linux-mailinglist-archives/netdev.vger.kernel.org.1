Return-Path: <netdev+bounces-275663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHAfA/Ls02nInwcAu9opvQ
	(envelope-from <netdev+bounces-275663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EAF3A5AE2
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2836C30182AA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D843390222;
	Mon,  6 Apr 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="spevHRfr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3D38F251
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496402; cv=none; b=NmK9ZZbih1dnCyTNXHa/LQkLswi43stuveGHNia3LvahvMS2uiNNcTSAdvS5hfv6Bugy7rDEEgM0jSrM6s9VDdNqlIzlDxGd4ZAArtcFRatcj00q75AVgoJaCx+bbneyj8dLKeC0ogYvrcOi6Ybe2WRvwK4P7pd4gIMV2/KTOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496402; c=relaxed/simple;
	bh=fbqM3x3GD1CCUD2vyX99XNBmMghubH80srElmDJt3Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp4bM1090DwBMvYl/5w5W/aY7T4xfsFIAVZe6toCmVoe8W1ZreOvT3JDxik6iCZAq5jb5g+Tdh9nx3FJ/rHfPR4vQdphxNuDtb18Po6C8sYlH+qku+1QW1jC4o0QDqyAzVnJNEhDjs7YFU+IAAcAM7h+lAcHHnW0GG4VQ92Q8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=spevHRfr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b0afa0210bso20539125ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775496401; x=1776101201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=spevHRfrEFTM6w/QwNjUXW9NK9d9AoyrgGUw9oBTBr2UMy1LRfrly3HSleZhvKjsQB
         qJGPaBsF7iZR/55rY7lz8A53jeadZuyLtpQhI9Y7RghUiQH8kU6yPFq1ic9uDY6wMn61
         hx8s/dwNOqsiTVDsWoq8QG1+uoDYBcPPRS8gr+RLvnbg3569ZqJxm7tdnbZBBc5769lq
         hOgxkCM//OhNQp6jzVEC23p2zmPgIQcTRHY096KJIgbTG7rlqTbluz6eY45B2nPXl4TV
         rC/aKYgf7sFOvYs0lRcE3fM1QHOYWvwd0BMKdhJV/q9TrZzFnUi+odVXZG6AgjWh4pP1
         XtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496401; x=1776101201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oOcv5DNu9r7imH370nri24gXDO5w1oyBmadAxFQ0=;
        b=e32o2kZ1V+W4iGSpshN7886HSJnSQ0kdFZWMU8SDveRDiOOdVYAu3Phz+1dqrj+zo5
         4smhvUzAPTjf0OgzfU/NjHN4m6K/8hTpfDCjsAYDKp+PYfr+zNKFvwdy2UnaGNXrwia+
         vcVt8qkgS8Rngy6cQn+8QjJN6B1Ooc8/gWGMT6b7/CoKHjpfE8OqzHL/+wv0BltMK9+6
         9/fZH9dynjWMkYsM25fcrxbB1JazUhLhOlX9Q9qh6jC+0NeV+52sWagvdw2mWxuHQe94
         3fGlEg0MIlj8sXMx6L5UBeKx+Ru4gLIpRMcN1NkYfqE1U3zH1YSOu/ZUQGq59D4TsxHG
         958w==
X-Gm-Message-State: AOJu0Yzl6yzxkmIvYyJVEXoZLLDiB6Ou9Bi0gqAh1qgs/1MR05tpJoaB
	BPQOCLb6p8f5FDJkIa8dKvgr0utBaBOSlyTKd7Z29qTgcgRzH/7sEeP/2Q3h2ZV9sG/FZQ3AKz0
	f1rb9
X-Gm-Gg: AeBDiesino32zmJhpFPchtEGZPn0xpqXOJsXNJT5K/bySdXKj50xoC1mzjXdC0qQeSY
	/74OJUQ1ITyNGTq371GDCbvl7DNLgX2YG3zO08BQ1LVLQW42jChy1IDkW9HKg1Bko6ACe026e/O
	boWxXTpOTZUjFoTwVpC+WwtD7Mk5lYLZSGk3RejPKbTwf7i+YYZdTjRNG/03+HCUhxaJBOzfUOX
	zDGhda2m0e0D44o7pWI9MubfjUdR8T9nyNOoSduKQJlqgrlXaG5Vn3NmXGVUvOZWn/YGGewqf3l
	BWXaCRX1p07iEBs2YYZH8za6Fowqt9pcHdJUk1YAnwBHsqLkkVvkL43ZYhgLQDWco7NqI++sM2D
	2o3MYJSL9Wb0zDgSIx/DmRwGebQVJdZqtA6MSYdgQu4IBjQWALMhhwVotZX5OMK5gO46MAFbuaa
	0aTS0tjSYctlHZo/siMh+5OU5pSbgvmC/F
X-Received: by 2002:a17:903:fb0:b0:2b2:4d08:9e02 with SMTP id d9443c01a7336-2b28184aa83mr134487755ad.21.1775496400769;
        Mon, 06 Apr 2026 10:26:40 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477a13dsm146437945ad.26.2026.04.06.10.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:26:40 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 1/8] net/sched: netem: fix probability gaps in 4-state loss model
Date: Mon,  6 Apr 2026 10:25:09 -0700
Message-ID: <20260406172627.210894-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406172627.210894-1-stephen@networkplumber.org>
References: <20260406172627.210894-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 60EAF3A5AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 4-state Markov chain in loss_4state() has gaps at the boundaries
between transition probability ranges. The comparisons use:

  if (rnd < a4)
  else if (a4 < rnd && rnd < a1 + a4)

When rnd equals a boundary value exactly, neither branch matches and
no state transition occurs. The redundant lower-bound check (a4 < rnd)
is already implied by being in the else branch.

Remove the unnecessary lower-bound comparisons so the ranges are
contiguous and every random value produces a transition, matching
the GI (General and Intuitive) loss model specification.

This bug goes back to original implementation of this model.

Fixes: 661b79725fea ("netem: revised correlated loss generator")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 20df1c08b1e9..8ee72cac1faf 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -227,10 +227,10 @@ static bool loss_4state(struct netem_sched_data *q)
 		if (rnd < clg->a4) {
 			clg->state = LOST_IN_GAP_PERIOD;
 			return true;
-		} else if (clg->a4 < rnd && rnd < clg->a1 + clg->a4) {
+		} else if (rnd < clg->a1 + clg->a4) {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
-		} else if (clg->a1 + clg->a4 < rnd) {
+		} else {
 			clg->state = TX_IN_GAP_PERIOD;
 		}
 
@@ -247,9 +247,9 @@ static bool loss_4state(struct netem_sched_data *q)
 	case LOST_IN_BURST_PERIOD:
 		if (rnd < clg->a3)
 			clg->state = TX_IN_BURST_PERIOD;
-		else if (clg->a3 < rnd && rnd < clg->a2 + clg->a3) {
+		else if (rnd < clg->a2 + clg->a3) {
 			clg->state = TX_IN_GAP_PERIOD;
-		} else if (clg->a2 + clg->a3 < rnd) {
+		} else {
 			clg->state = LOST_IN_BURST_PERIOD;
 			return true;
 		}
-- 
2.53.0



Return-Path: <netdev+bounces-133518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6289962AA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B32871CB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5E18E03E;
	Wed,  9 Oct 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QY2C6JuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BGrwc7zb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631718C91A;
	Wed,  9 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462561; cv=none; b=nx9LdiSEpu/n0o4ECOgCdm+vh2uu6/P1XPdV5DAMO9bGCSQ23f4xUmIqxhmg0q0LP7P6m+BL0Ibgy/XWdcL1th8GkOMkigUkLsGsZLfrDuZEwupT6jYtzeGG75l1igzXjiuOyHj7QpK2kr3PgJvid2yQLWCq5JDjPeEvAFuPHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462561; c=relaxed/simple;
	bh=Lmnv1b2ucOFQSUA24R7e7ebxT8F4nIGS58fa4J9BytE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tbfaaLxS1xSARo4egNU5xtHm105rp72T7l2NsOrrRW/09EtAbGr1CuncGGKeXveUv/BnwPxv7vuTb5Z0oE/z+bTA4dq7TMjuS0dfWSU60yp6jQ9kZSkkpZHeFvaq4avDF59hxIRCPu/nLi4bpSfpKGTOfp9675em5Ti49zE8iE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QY2C6JuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BGrwc7zb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gKqhrrEtuUuIiu1c0v+h4KjnR2UQ6QcFIf5LjmxyqA=;
	b=QY2C6JuR4KT02bGdvaqaeEq8+eYbz7Phz512iuZBq1wlrQm0pZNc60ZLyyCqknXNfSn5Wb
	/bZttYmgJ96ry3XvJd/jhcrty4wZMDK+yBBD+wcwZkod30U4GSFVHFIB+SDMsB6mHUzX3x
	KqGMSYKUapxNsk+2DrUKBJu0SwBZ+nEfomXTKYww4rr95efxyd994/67rzqf/JAywkDhOl
	syeLuOgLsksTmxRURzE2eQchWlzhSh7IfzAT7H2nRnZWqA0Ci++JPGpFkORm2ol8VkoQgF
	eRbPbkgFk33WBSUMYknqU6PqgU9qWzL1ZC9cwn/auMLkj30WWN9VVSuQm57amw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gKqhrrEtuUuIiu1c0v+h4KjnR2UQ6QcFIf5LjmxyqA=;
	b=BGrwc7zbAeMl1Mei92Pf/PRBzcsi68gso2N2IljcxgYKXjZ6ewt+qOm5e5cXkeYIMshT/8
	fQJ4SuWEOfTAh9BA==
Date: Wed, 09 Oct 2024 10:29:00 +0200
Subject: [PATCH v2 07/25] timekeeping: Move shadow_timekeeper into tk_core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-7-554456a44a15@linutronix.de>
References: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
In-Reply-To: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-0-554456a44a15@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

tk_core requires shadow_timekeeper to allow timekeeping_advance() updating
without holding the timekeeper sequence count write locked. This allows the
readers to make progress up to the actual update where the shadow
timekeeper is copied over to the real timekeeper.

As long as there is only a single timekeeper, having them separate is
fine. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, shadow_timekeeper needs to be part of tk_core.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e747e46a1a2d..267b28cf2ab0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,11 +50,11 @@ DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
+	struct timekeeper	shadow_timekeeper;
 } tk_core ____cacheline_aligned = {
 	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
 };
 
-static struct timekeeper shadow_timekeeper;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -776,8 +776,7 @@ static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 	 * timekeeper structure on the next update with stale data
 	 */
 	if (action & TK_MIRROR)
-		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
-		       sizeof(tk_core.timekeeper));
+		memcpy(&tk_core.shadow_timekeeper, &tk_core.timekeeper, sizeof(tk_core.timekeeper));
 }
 
 /**
@@ -2274,8 +2273,8 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
  */
 static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
-	struct timekeeper *tk = &shadow_timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
 	u64 offset;

-- 
2.39.5



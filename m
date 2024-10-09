Return-Path: <netdev+bounces-133526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AC9962BF
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25ED0281D2C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5FB18FDBE;
	Wed,  9 Oct 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiS84X8s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmBQl7H9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638218C91B;
	Wed,  9 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462563; cv=none; b=q3AmGggeewBlM60hyXjoLDxqUVQc7puBVxzbySnB1/JFxuczncr+drpiBlpsV7v91prhDQcmTGuiKjnPxZksi/uqhcAyFHV+CnuPSzQDmJzcAOMJ6DzTj6GTjdpEStrXmHQkPG4oeJJMNuhbD8/3zLlLmOZCrmYo4Wk3VNdWDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462563; c=relaxed/simple;
	bh=bP6PT+BjsxnxKJYQnixZ0YZkzL5ONtzGBN692fn+CXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNupCQojJ9TsOzo+uh90q6VTgaIiF6EKT1eg3OkZ8cVQob9JMIy+MsyjWZl+p/EAev6hE4tdqEOgeEGnoMWqsoFbT2Nj3sDQUAiWLbQECu15sZ+dr+KeTqjPNrxtTh9w0n1HKZiH8OuUf5nXyj8g7M6ktPoq2uDEPtXCvTYQcV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiS84X8s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmBQl7H9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0QD9rffq9aVVw2zmPBZOEcSey8yBIu2G1fc+/IahHg=;
	b=HiS84X8slIUVYKRdo9+rhCw28+nWEGrsqoesfOi2JmDpLYHdB2hDqklemAiUy67IMV93/U
	5oOCRCqZ5TR2qIN8Ypd1CBUA6hIULW1g8IuOQLhX3X51utHlRbhzwyh+2SQLoSLG9PZava
	a8UnVkQOMVOBw7uFu/IYe8hLQfFSHjP9ScqihdhUXSK9W0zzBGWsUkb4hcP6d2bhNusaAv
	D9RtQS2E8GYRHsgKewzVXWWlbpVVhl6h2a05MeUpyTjam4wP4R7Bj3fOny2gaHuovixvrI
	cj11KWtDGHH6ln0kiRxhHXeaTtQlOS0Dw05WLb2kim7vzPNI4wQ+PxJs5djZtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0QD9rffq9aVVw2zmPBZOEcSey8yBIu2G1fc+/IahHg=;
	b=RmBQl7H9TEbo6aYmLgzBRkOYzDKdEqxc0j+nl/eSSp27sKklyp/OwQ0E8dw6Fq+Gk+Z4Np
	hOdjWT96g9cX9ECA==
Date: Wed, 09 Oct 2024 10:28:58 +0200
Subject: [PATCH v2 05/25] timekeeping: Simplify code in
 timekeeping_advance()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-5-554456a44a15@linutronix.de>
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

timekeeping_advance() takes the timekeeper_lock and releases it before
returning. When an early return is required, goto statements are used to
make sure the lock is realeased properly. When the code was written the
locking guard() was not yet available.

Use the guard() to simplify the code and while at it cleanup ordering of
function variables. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 0ae35a71f8cc..e747e46a1a2d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2276,23 +2276,22 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 {
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	struct timekeeper *tk = &shadow_timekeeper;
-	u64 offset;
-	int shift = 0, maxshift;
 	unsigned int clock_set = 0;
-	unsigned long flags;
+	int shift = 0, maxshift;
+	u64 offset;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&timekeeper_lock);
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
-		goto out;
+		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
-		goto out;
+		return false;
 
 	/* Do some additional sanity checking */
 	timekeeping_check_update(tk, offset);
@@ -2311,8 +2310,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
 	shift = min(shift, maxshift);
 	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift,
-							&clock_set);
+		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
 		if (offset < tk->cycle_interval<<shift)
 			shift--;
 	}
@@ -2341,8 +2339,6 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	memcpy(real_tk, tk, sizeof(*tk));
 	/* The memcpy must come last. Do not put anything here! */
 	write_seqcount_end(&tk_core.seq);
-out:
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	return !!clock_set;
 }

-- 
2.39.5



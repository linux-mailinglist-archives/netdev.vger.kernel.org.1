Return-Path: <netdev+bounces-133522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013579962B9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6770283534
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294718F2F8;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FKGVTMeT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="grGEs+Q5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABC18D645;
	Wed,  9 Oct 2024 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462562; cv=none; b=pRUVQN9KERpcUVhpkD3IBhpbnoZ4bn5gqmD7ogJcshQfSlD2BPeur/+jRhHMYp7MrfCwfGw4l0mErEhts7mUz2OmsJD/fyzxQxiV0p4uQ6CjNEMOlfaoqxtONmAQLBJ67XKTt4yq6c2yPag1mpRcrrZKzyw4jstZyzgAOnVgGf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462562; c=relaxed/simple;
	bh=obVFLu8V+n6TI61DhdW8w4lee9Lzx6rSm9FQxifHM5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0VjY8vaQqc3rg7R96FTPJzSO7ocVGOpankqE7QTgZ7J72sA1Wg70j6uGP8k+XAN5lAQYerOqw4IgpjoTNt4LeORMy1ipCI44ScAWxwfqLhBcHq0vv2al4fB88Tl66epcHxEwbjUaHn8Ue4osbIWhAPr1kfv33+I7eDu6F/R/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FKGVTMeT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=grGEs+Q5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxYJUNMlmiuyRG4rAKJCLjd4R1BXiz2qhdWO0TNO0rk=;
	b=FKGVTMeT/JWtH423tps92Cton1G4pd/c6eUjer+kSnbprvaQgM9dVElUAhzRVAeG9xHxrX
	ieAUZ1QTftuyEVf9p/Cgc5FyezFsJpktjW0bLFE5h/XY5Bs/y+k4ep4C/6zlFV2pU/wRsj
	zPYtzmOJ/E6yQTRN6/pljN3NC7DbVzpW4ZwTCPOJK8NTmQJWqPwiJLc+h+an+VO5XC6TEg
	lbBiy7fJke15z1PlJxVR7Ss/ewjyEtBDzreCj6+i5SruyP9Lz4m+5Ft9ZCXE9djoqOc+Y3
	iP02wH7P5rQ/VEoarvjn/RWxfkRNCwzg3dHsEie4JhCGmSuBBajBKwT75XpDfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxYJUNMlmiuyRG4rAKJCLjd4R1BXiz2qhdWO0TNO0rk=;
	b=grGEs+Q5KR6ZEXc7gdjJIzu2sd6zgSeIuzxzffm9yyq5qlhcP9tMLomoHjLN/i0xeTyvlD
	+yq3Tld6EccN4FDg==
Date: Wed, 09 Oct 2024 10:29:05 +0200
Subject: [PATCH v2 12/25] timekeeping: Add struct tk_data as argument to
 timekeeping_update()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-12-554456a44a15@linutronix.de>
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

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Updates of the timekeeper are done in two ways:

 1. Updating timekeeper and afterwards memcpy()'ing the result into
    shadow_timekeeper using timekeeping_update(). Used everywhere for
    updates except in timekeeping_advance(); the sequence counter protected
    region starts before the first change to the timekeeper is done.

 2. Updating shadow_timekeeper and then memcpy()'ing the result into
    timekeeper.  Used only by in timekeeping_advance(); The seqence counter
    protected region is only around timekeeping_update() and the memcpy for
    copy from shadow to timekeeper.

The second option is fast path optimized. The sequence counter protected
region is as short as possible.

As this behaviour is mainly documented by commit messages, but not in code,
it makes the not easy timekeeping code more complicated to read.

There is no reason why updates to the timekeeper can't use the optimized
version everywhere. With this, the code will be cleaner, as code is reused
instead of duplicated.

To be able to access tk_data which contains all required information, add a
pointer to tk_data as an argument to timekeeping_update(). With that
convert the comment about holding the lock into a lockdep assert.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a98f823be6db..878f9606946d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -528,7 +528,7 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  *    timekeeping_inject_sleeptime64()
  *    __timekeeping_inject_sleeptime(tk, delta);
  *                                                 timestamp();
- *    timekeeping_update(tk, TK_CLEAR_NTP...);
+ *    timekeeping_update(tkd, tk, TK_CLEAR_NTP...);
  *
  * (2) On 32-bit systems, the 64-bit boot offset (tk->offs_boot) may be
  * partially updated.  Since the tk->offs_boot update is a rare event, this
@@ -753,9 +753,10 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
-/* must hold tk_core.lock */
-static void timekeeping_update(struct timekeeper *tk, unsigned int action)
+static void timekeeping_update(struct tk_data *tkd, struct timekeeper *tk, unsigned int action)
 {
+	lockdep_assert_held(&tkd->lock);
+
 	if (action & TK_CLEAR_NTP) {
 		tk->ntp_error = 0;
 		ntp_clear();
@@ -1467,7 +1468,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 
 	tk_set_xtime(tk, ts);
 out:
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1517,7 +1518,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *ts));
 
 error: /* even if we error out, we forwarded the time, so call update */
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1602,7 +1603,7 @@ static int change_clocksource(void *data)
 	timekeeping_forward_now(tk);
 	old = tk->tkr_mono.clock;
 	tk_setup_internals(tk, new);
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1801,7 +1802,7 @@ void __init timekeeping_init(void)
 
 	tk_set_wall_to_mono(tk, wall_to_mono);
 
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 }
@@ -1893,7 +1894,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 
 	__timekeeping_inject_sleeptime(tk, delta);
 
-	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -1956,7 +1957,7 @@ void timekeeping_resume(void)
 
 	tk->ntp_error = 0;
 	timekeeping_suspended = 0;
-	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
@@ -2025,7 +2026,7 @@ int timekeeping_suspend(void)
 		}
 	}
 
-	timekeeping_update(tk, TK_MIRROR);
+	timekeeping_update(&tk_core, tk, TK_MIRROR);
 	halt_fast_timekeeper(tk);
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
@@ -2343,7 +2344,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	 * memcpy under the tk_core.seq against one before we start
 	 * updating.
 	 */
-	timekeeping_update(tk, clock_set);
+	timekeeping_update(&tk_core, tk, clock_set);
 	memcpy(real_tk, tk, sizeof(*tk));
 	/* The memcpy must come last. Do not put anything here! */
 	write_seqcount_end(&tk_core.seq);
@@ -2593,7 +2594,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 
 	if (tai != orig_tai) {
 		__timekeeping_set_tai_offset(tk, tai);
-		timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
+		timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 		clock_set = true;
 	} else {
 		tk_update_leap_state(tk);

-- 
2.39.5



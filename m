Return-Path: <netdev+bounces-127391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410F975404
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745FEB28FAE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016F1AB53E;
	Wed, 11 Sep 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tfc1DX7P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C738bIN5"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5691A303C;
	Wed, 11 Sep 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061409; cv=none; b=AeBUf7W6t3lSUpwLv4U1V76pFYK8bzEmlRQfZ23vCgmluyREnK69dkPy0qGNTBsFTlio6an1x7gF6/4LphK/7NTQkDC4EpzCyLzYExB5CjHhgTohvDLpr2cK4z558OObdbbi4FhYS1ct5cpVQfiT8fNCjRTm6+DtSPVWh6EAabI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061409; c=relaxed/simple;
	bh=ODhXrGnVWSIGZQ2Jn4+Txxyjl2tcDSpnEmqplkegi80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhXf+3UEKTFALdlugcGKByosb90+lJAx3WWXzx/vDAHGre2tlSkDF+4s2DITVVyNB61H+RjS6TrzlZXORo+4JhJrKsYgULjXv7XE5sBhVzX8PtGW5FwG1VedgOwvKQtiC/dTHp5qhabYYl+knSUYcmXD0D9z/Vyw0ick0bk5uSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tfc1DX7P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C738bIN5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kLdaEQ7/PvnOBrd9Oxxc0GInZPXHgNgHezYdQRC81U=;
	b=Tfc1DX7PWMutc5w2uyFWoO0JhjiI5L1m83nnyTqjM1ZLPNNmyx38uJTZVk2/B23ucbxvnM
	+bA2hgh9s4dPKjRgjx2HZsnWry+bTIlx38f3msfLJxaiSKF4OyxcuU2TxMIrHgUBZ3XbU/
	TG351n1gew8UtwNkRfT8rzdwCnTSSNj+ry4Agi83BVG33P791MRfo2QEylounDxFeguRc2
	8AgilQJwUYwY3gEnrQ39H/R+9LAsOJC5tNzuzVUYpBxJZQq/JLjxOWC499oXPbbYnSFQMC
	Vuf8VV3R2osHDCfxGuT406MNmFNlMKblZQerQye5HcjNid0/Ep4Oa8uFQITOhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kLdaEQ7/PvnOBrd9Oxxc0GInZPXHgNgHezYdQRC81U=;
	b=C738bIN5F3dClma8gZNr8mmz4CNxIv9JblGaDVARlbRkEfFs8SfZbp/usUHwvqQRiWx+4c
	EuPCjR7u+W4POWAA==
Date: Wed, 11 Sep 2024 15:29:53 +0200
Subject: [PATCH 09/24] timekeeping: Move timekeeper_lock into tk_core
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-9-f7cae09e25d6@linutronix.de>
References: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-0-f7cae09e25d6@linutronix.de>
To: John Stultz <jstultz@google.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher S Hall <christopher.s.hall@intel.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

timekeeper_lock protects updates to struct tk_core but is not part of
struct tk_core. As long as there is only a single timekeeper, this is not a
problem. But when the timekeeper infrastructure will be reused for per ptp
clock timekeepers, timekeeper_lock needs to be part of tk_core.

Move the lock into tk_core, move initialisation of the lock and sequence
counter into timekeeping_init() and update all users of timekeeper_lock.

As this is touching all lock sites, convert them to use:

  guard(raw_spinlock_irqsave)(&tk_core.lock);

instead of lock/unlock functions whenever possible.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 77 +++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 43 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e0b6d088a33b..f8ffab5bb790 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -41,8 +41,6 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
-
 /*
  * The most important data for readout fits into a single 64 byte
  * cache line.
@@ -51,10 +49,8 @@ static struct {
 	seqcount_raw_spinlock_t	seq;
 	struct timekeeper	timekeeper;
 	struct timekeeper	shadow_timekeeper;
-} tk_core ____cacheline_aligned = {
-	.seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
-};
-
+	raw_spinlock_t		lock;
+} tk_core ____cacheline_aligned;
 
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
@@ -118,13 +114,13 @@ unsigned long timekeeper_lock_irqsave(void)
 {
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	return flags;
 }
 
 void timekeeper_unlock_irqrestore(unsigned long flags)
 {
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 }
 
 static inline void tk_normalize_xtime(struct timekeeper *tk)
@@ -197,7 +193,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * the tkr's clocksource may change between the read reference, and the
  * clock reference passed to the read function.  This can cause crashes if
  * the wrong clocksource is passed to the wrong read function.
- * This isn't necessary to use when holding the timekeeper_lock or doing
+ * This isn't necessary to use when holding the tk_core.lock or doing
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
@@ -689,13 +685,11 @@ static void update_pvclock_gtod(struct timekeeper *tk, bool was_set)
 int pvclock_gtod_register_notifier(struct notifier_block *nb)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
 	int ret;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	ret = raw_notifier_chain_register(&pvclock_gtod_chain, nb);
 	update_pvclock_gtod(tk, true);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	return ret;
 }
@@ -708,14 +702,8 @@ EXPORT_SYMBOL_GPL(pvclock_gtod_register_notifier);
  */
 int pvclock_gtod_unregister_notifier(struct notifier_block *nb)
 {
-	unsigned long flags;
-	int ret;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
-	ret = raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
-
-	return ret;
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
+	return raw_notifier_chain_unregister(&pvclock_gtod_chain, nb);
 }
 EXPORT_SYMBOL_GPL(pvclock_gtod_unregister_notifier);
 
@@ -763,7 +751,7 @@ static inline void tk_update_ktime_data(struct timekeeper *tk)
 	tk->tkr_raw.base = ns_to_ktime(tk->raw_sec * NSEC_PER_SEC);
 }
 
-/* must hold timekeeper_lock */
+/* must hold tk_core.lock */
 static void timekeeping_update(struct timekeeper *tk, unsigned int action)
 {
 	if (action & TK_CLEAR_NTP) {
@@ -1460,7 +1448,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	if (!timespec64_valid_settod(ts))
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1480,7 +1468,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
@@ -1510,7 +1498,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	if (ts->tv_nsec < 0 || ts->tv_nsec >= NSEC_PER_SEC)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1530,7 +1518,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL);
@@ -1606,7 +1594,7 @@ static int change_clocksource(void *data)
 		return 0;
 	}
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
@@ -1615,7 +1603,7 @@ static int change_clocksource(void *data)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	if (old) {
 		if (old->disable)
@@ -1744,6 +1732,12 @@ read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = ns_to_timespec64(local_clock());
 }
 
+static __init void tkd_basic_setup(struct tk_data *tkd)
+{
+	raw_spin_lock_init(&tkd->lock);
+	seqcount_raw_spinlock_init(&tkd->seq, &tkd->lock);
+}
+
 /*
  * Flag reflecting whether timekeeping_resume() has injected sleeptime.
  *
@@ -1770,7 +1764,8 @@ void __init timekeeping_init(void)
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
-	unsigned long flags;
+
+	tkd_basic_setup(&tk_core);
 
 	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
 	if (timespec64_valid_settod(&wall_time) &&
@@ -1790,7 +1785,7 @@ void __init timekeeping_init(void)
 	 */
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
 
@@ -1807,7 +1802,6 @@ void __init timekeeping_init(void)
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 
 /* time in seconds when suspend began for persistent clock */
@@ -1888,7 +1882,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	suspend_timing_needed = false;
@@ -1900,7 +1894,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
@@ -1924,7 +1918,7 @@ void timekeeping_resume(void)
 	clockevents_resume();
 	clocksource_resume();
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	/*
@@ -1962,7 +1956,7 @@ void timekeeping_resume(void)
 	timekeeping_suspended = 0;
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	touch_softlockup_watchdog();
 
@@ -1993,7 +1987,7 @@ int timekeeping_suspend(void)
 
 	suspend_timing_needed = true;
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
 	timekeeping_suspended = 1;
@@ -2032,7 +2026,7 @@ int timekeeping_suspend(void)
 	timekeeping_update(tk, TK_MIRROR);
 	halt_fast_timekeeper(tk);
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	tick_suspend();
 	clocksource_suspend();
@@ -2292,7 +2286,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	int shift = 0, maxshift;
 	u64 offset;
 
-	guard(raw_spinlock_irqsave)(&timekeeper_lock);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
@@ -2587,7 +2581,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	ktime_get_real_ts64(&ts);
 	add_device_randomness(&ts, sizeof(ts));
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	raw_spin_lock_irqsave(&tk_core.lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	orig_tai = tai = tk->tai_offset;
@@ -2602,7 +2596,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 	}
 
 	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	audit_ntp_log(&ad);
 
@@ -2626,11 +2620,8 @@ int do_adjtimex(struct __kernel_timex *txc)
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	guard(raw_spinlock_irqsave)(&tk_core.lock);
 	__hardpps(phase_ts, raw_ts);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 }
 EXPORT_SYMBOL(hardpps);
 #endif /* CONFIG_NTP_PPS */

-- 
2.39.2



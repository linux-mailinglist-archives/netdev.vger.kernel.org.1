Return-Path: <netdev+bounces-127389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F29753FD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E03831C20C7A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A21A302D;
	Wed, 11 Sep 2024 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CXPoQ62Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LW2CYqxm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8431A3A92;
	Wed, 11 Sep 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061408; cv=none; b=qZX7Ibl4N86w1QFTzgYEhnsoKK23Mf0Wo9cQL5DoqpvmbdYZ9fN2e6y0PzXOgmcT2bii7wYpDXN6jtIDq93iD9EbUwUgs4HHy8wjWyrFenwZx3AB0xNtw5xCuHaBlMaAoiaih/kmUW3hVONjIZlmyaUHkKKiicKhBhgQLkbmAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061408; c=relaxed/simple;
	bh=jSUFNViXFDFewvDCLCg5ppMtN092LyN9G4DUPCA35/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vx/r45llO/HmbUNDSAyFBFxKly9wSsDFbr6op00dvED7qQ8ajXcbRYJ94VWjxMop9M5IrvUMXXUymHJKrbthEj7PBml8tyEITwdgXB9uGTN7reYXmMETDp0oYS3Milg47W5GZhokpYKXUO3eNZAMYT5kGLjkgyXMiCR3MdrnOn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CXPoQ62Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LW2CYqxm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeKBPpJLDsCADQvy1qvGnmjLCzx0cHKY8ieuOdOdZrE=;
	b=CXPoQ62QXUZGvjjtC0Elg8qGP+tU7uIrV5S8uFEwl5YRKsHegT+s4ELvalDOeLRPU58wUk
	kHP6CH/69DXMRoY5E8YfcwKRMQxMqCA63myKhyedAxnSFoak5JS/AemFMlq+5r7E60iUYz
	c5vxwQI8zXmmVrPg0uFSPhVNTga4HFuNdz2L/QF7VZFB1oRXtjf0p/uAIYNzBq5FvXIMBx
	HWsRqfpdbF3dPFNAxPq/Zs0j/7oqbC8h4rgg8PkM1e5vRienB8EIlJwLDx7KnK6uVGDZOE
	6/C8asUjf/gwEJGzNmuA5XebPafDpcOzpzVcFI4NvZu5oHPzLbEy8L/0XBzKBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeKBPpJLDsCADQvy1qvGnmjLCzx0cHKY8ieuOdOdZrE=;
	b=LW2CYqxmjd/NnCMg5G325UGVbsMf3M5X9s9USOtIknpidpa0BF0F593WW8MAWyirX70Au7
	WHBNBFtAZeA8ekAg==
Date: Wed, 11 Sep 2024 15:29:52 +0200
Subject: [PATCH 08/24] timekeeping: Encapsulate locking/unlocking of
 timekeeper_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-8-f7cae09e25d6@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

timekeeper_lock protects updates of timekeeper (tk_core). It is also used
by vdso_update_begin/end() and not only internally by the timekeeper code.

As long as there is only a single timekeeper, this works fine.  But when
the timekeeper infrastructure will be reused for per ptp clock timekeepers,
timekeeper_lock needs to be part of tk_core..

Therefore encapuslate locking/unlocking of timekeeper_lock and make the
lock static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c          | 15 ++++++++++++++-
 kernel/time/timekeeping_internal.h |  3 ++-
 kernel/time/vsyscall.c             |  5 ++---
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e35e00b0cdd4..e0b6d088a33b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -41,7 +41,7 @@ enum timekeeping_adv_mode {
 	TK_ADV_FREQ
 };
 
-DEFINE_RAW_SPINLOCK(timekeeper_lock);
+static DEFINE_RAW_SPINLOCK(timekeeper_lock);
 
 /*
  * The most important data for readout fits into a single 64 byte
@@ -114,6 +114,19 @@ static struct tk_fast tk_fast_raw  ____cacheline_aligned = {
 	.base[1] = FAST_TK_INIT,
 };
 
+unsigned long timekeeper_lock_irqsave(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	return flags;
+}
+
+void timekeeper_unlock_irqrestore(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+}
+
 static inline void tk_normalize_xtime(struct timekeeper *tk)
 {
 	while (tk->tkr_mono.xtime_nsec >= ((u64)NSEC_PER_SEC << tk->tkr_mono.shift)) {
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787d1642..3babb2bac579 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -34,6 +34,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 #endif
 
 /* Semi public for serialization of non timekeeper VDSO updates. */
-extern raw_spinlock_t timekeeper_lock;
+unsigned long timekeeper_lock_irqsave(void);
+void timekeeper_unlock_irqrestore(unsigned long flags);
 
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 9193d6133e5d..98488b20b594 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -151,9 +151,8 @@ void update_vsyscall_tz(void)
 unsigned long vdso_update_begin(void)
 {
 	struct vdso_data *vdata = __arch_get_k_vdso_data();
-	unsigned long flags;
+	unsigned long flags = timekeeper_lock_irqsave();
 
-	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	vdso_write_begin(vdata);
 	return flags;
 }
@@ -172,5 +171,5 @@ void vdso_update_end(unsigned long flags)
 
 	vdso_write_end(vdata);
 	__arch_sync_vdso_data(vdata);
-	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+	timekeeper_unlock_irqrestore(flags);
 }

-- 
2.39.2



Return-Path: <netdev+bounces-133533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9859962CB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E83E1C2112E
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADB1917F9;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loBhx1E+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GoBj7OTt"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B6618FC83;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=MJZFC0ynAz2uGzJbTLgZP5lV4yRPMjBjk4lL8Pt0nTms/VatmZjLEgj/Qxt7QYRl3w8ieEQhkz+bwXw6NGPpOxktqSLiggyJiKgHvoQhx6pGlZs0ILCdlHlAu5QMkqqwGK9uxq6vylc9OKW6Y5b9uE1M04ao0umQ2mLSG5low7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=JPb37VDuKMoRNJ9vp81Du4hr25S86cQJYo5RCttwRE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mGmVACGNlZdqr2GAontVda/787G1/2QMTjDgPJHmE2hvxJhvFEUBW6zZ0lUzfs8jzDmyh7Ejz/iiuq8+3yPP6Fuc84lS4Lp1Tk5PDqWZabd4EU/c4rYMWTVM9vabUs7jwIfO0rYWsu+0GyOFSSTQ1ts2P2ffXlVNT0NNkrNysPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loBhx1E+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GoBj7OTt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXKFPtRu4Sx6Ya+F6FaITcYNeyub0Jgc6BL9e6PKQT8=;
	b=loBhx1E+vYnrxsr3U8V1ED4dJ0+WiD8wUa7ZlWp5tOHE7T7epQMBepx1ZqfpGodvrbE+MZ
	FTsmwawfoxtUt7bJhaLANkcT8pjyRBdaV7P7uq9yc30BraPuoBKeSnbOyM/E5RFIs2Darc
	4fMHa8JFwMVz/OG9gELy5DGNdNvbZ4BiGtCnZwa95x30b7qA3JbdTTXKKnxarRPTrluRDI
	WUPd4y/GXXNv4KAtW3yOe2LwmQsxdj07L8RbcS5DC2oXBQJUnQuRTseeDBgaQnJSfLCQw4
	CQ/7XvRifOQ+57EozhG6m9zP0JueJuRROyf7LIqMvLitf2HMW5C8Ku70fVG0Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXKFPtRu4Sx6Ya+F6FaITcYNeyub0Jgc6BL9e6PKQT8=;
	b=GoBj7OTtmqRlNlZCMMFa2AL8ftdeBqxfxnd/wtyir8pLMhX5AEJIqGQSAekXOyqiou14OB
	4a6olzOLA2zxl5Cg==
Date: Wed, 09 Oct 2024 10:29:15 +0200
Subject: [PATCH v2 22/25] timekeeping: Rework timekeeping_suspend() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-22-554456a44a15@linutronix.de>
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

Updates of the timekeeper can be done by operating on the shadow timekeeper
and afterwards copying the result into the real timekeeper. This has the
advantage, that the sequence count write protected region is kept as small
as possible.

While the sequence count held time is not relevant for the resume path as
there is no concurrency, there is no reason to have this function
different than all the other update sites.

Convert timekeeping_inject_offset() to use this scheme and cleanup the
variable declarations while at it.

As halt_fast_timekeeper() does not need protection sequence counter, it is
no problem to move it with this change outside of the sequence counter
protected area. But it still needs to be executed while holding the lock.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 63b7a1379ae8..e15e843ba2b8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1972,11 +1972,11 @@ void timekeeping_resume(void)
 
 int timekeeping_suspend(void)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-	struct timespec64		delta, delta_delta;
-	static struct timespec64	old_delta;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
+	struct timespec64 delta, delta_delta;
+	static struct timespec64 old_delta;
 	struct clocksource *curr_clock;
+	unsigned long flags;
 	u64 cycle_now;
 
 	read_persistent_clock64(&timekeeping_suspend_time);
@@ -1992,7 +1992,6 @@ int timekeeping_suspend(void)
 	suspend_timing_needed = true;
 
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
 	timekeeping_suspended = 1;
 
@@ -2027,9 +2026,8 @@ int timekeeping_suspend(void)
 		}
 	}
 
-	timekeeping_update(&tk_core, tk, TK_MIRROR);
+	timekeeping_update_staged(&tk_core, 0);
 	halt_fast_timekeeper(tk);
-	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	tick_suspend();

-- 
2.39.5



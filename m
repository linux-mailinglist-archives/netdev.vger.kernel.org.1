Return-Path: <netdev+bounces-133535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AEB9962D3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 661C91F22E0A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB911922D4;
	Wed,  9 Oct 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DxC0b7wF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PctOmlZU"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A318F2FB;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462566; cv=none; b=GC02LrGLOHqxiTpwoZcvbLi716p15D5JoT6WkdVHfIfDCb4QsJ+xQ30T5JvwtOagxV4W0Y0G+Tmy1a1ORxhvw6rQuxfiYZX0/LNG/UGnI7d12VdTzEpMDApO8rc2UtCBpOmstRNBFINdlDSeVXSRHY0CMGlzHnvcTSXBhEFMvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462566; c=relaxed/simple;
	bh=tM7sTcZmZRY3Zvk3KpyPvf+k6AIMdSK74Z/iy7bhhdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH+Ln5Gll6b4AHOKekCYi5PWnOPuUXhXKR8YR08pHzN4f8puyL9CBBgz2XiIfTUEMa/9QqvjzVkJxd+TYyh9QCtmxSVSzgvcGbXJorYESY5B2oDQGnhOa8EF1oDDMEsSgh7+K2oAwoXrxFiosAk+Nq/wQgw4FuEanWghD3Ujrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DxC0b7wF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PctOmlZU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1hjixVzWyEI6kbexIge7cPNj3aTuExc8IijWH/Vafg=;
	b=DxC0b7wFueSrXRrGbIHhxxFlAo9IUiTFKBVCSlS/ONckolGkJtHYaKxDIs3b6nMD5jR+94
	/x6PFkKsta2Mj4n6IZBnO3mGBaTW5VYIRQDXpL1fsVWWQWiiEqf8VySLhKBYiSYpcHJtJk
	6MzQvqLr93UDvZzGhl03e4B54P7SbLxfjpxPyUXT2J4/mTaTyYB4yPjPALTYuuxctVR5Xl
	MNYNFfZ9U0g3R4fhfpPYwesrc+fofHc2qPg5+A2zasIy3Uc8ne3OBFlY6eDOtpCsV6rqMV
	Tzk+G7bivpK4o6RSFtxUpSvQyzgUxJcqViTuV2arO8ON0cIGLVevfZp82F7nLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1hjixVzWyEI6kbexIge7cPNj3aTuExc8IijWH/Vafg=;
	b=PctOmlZUHkreDdQWJIxOTK3Xnf8MuPkvmEBpyEB5T8yGj7DMUjhxAcVcrUfv5u61aDaqHv
	aZSwpmBamYkQJ3DA==
Date: Wed, 09 Oct 2024 10:29:14 +0200
Subject: [PATCH v2 21/25] timekeeping: Rework timekeeping_resume() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-21-554456a44a15@linutronix.de>
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
variable declaration while at it.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c1a2726a0d41..63b7a1379ae8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1912,12 +1912,12 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
  */
 void timekeeping_resume(void)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct clocksource *clock = tk->tkr_mono.clock;
-	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
-	u64 cycle_now, nsec;
 	bool inject_sleeptime = false;
+	u64 cycle_now, nsec;
+	unsigned long flags;
 
 	read_persistent_clock64(&ts_new);
 
@@ -1925,7 +1925,6 @@ void timekeeping_resume(void)
 	clocksource_resume();
 
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
 
 	/*
 	 * After system resumes, we need to calculate the suspended time and
@@ -1960,8 +1959,7 @@ void timekeeping_resume(void)
 
 	tk->ntp_error = 0;
 	timekeeping_suspended = 0;
-	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, TK_CLOCK_WAS_SET);
 	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
 
 	touch_softlockup_watchdog();

-- 
2.39.5



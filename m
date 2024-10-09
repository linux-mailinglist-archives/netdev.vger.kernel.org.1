Return-Path: <netdev+bounces-133532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248889962C8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6E82827CC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2881917F4;
	Wed,  9 Oct 2024 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R7HyOkfJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwKQ/GXi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17718E35F;
	Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462565; cv=none; b=CEC3zCnN3fl09sLxcWIUrfoD5ElA6CV9BtWe2cjVRU1y0kweOk3EC0DFEwO8HSOJiaZLYPdeyJMGfbNPkQVJBusRZ2xtgJbb/wiJYT3G6HW6sDWXAl54ZkcnaV2v9+opMjPLIT0QcFsLyqlSotbAYEFokK7o5Eq9OenWW4U3EFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462565; c=relaxed/simple;
	bh=Ro9wXRsRW3pwaaOyyuMDj0Rd4VJ5BecOwketZ6eYHgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKIC4GnQ7AZPCxtUlzB1/ENq/x7duw5d5BNPpz4h62dmc7u+MvqE86kD6ayDIfA7WCgE7alnB/xAKy4Tlp7/sVfKti31C45tnRQwpqu6vez5XJooUkQwZp3Czxvsf6NGBNhkiJlbBGomELjWIG64Z7YYlNS5asXpSWlcFvqPJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R7HyOkfJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwKQ/GXi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVHw94u6ZhSsv2Z/b/AuuBVF799Bd06TmChz9mXDUYQ=;
	b=R7HyOkfJsSj27VWd7JVkmZTveh52E2mLCUT+NcKoqMyZ0zOHNMUMtrmPqzONE0GrqI3e0g
	ahGiN1gkTSg8kA9jGmurVlm7ERUpC0xn0vsYvz80s5Aq2qEOQ5wxDe3LDQdY2k7fQkbv8X
	4Mmkwn1+Kt8YVzCd7wH9OWmOmBodv+2qGmTh3fCYmP65LmmSnlg5Finw4l0COBZ0muWPoR
	SvHuT+aOsDfQiltHBPi9zXTikNHCqYjY5Xv9L/xh9uOSVHZ7sAnv6u2CGwZjZDWehqJwC7
	8MVXfc9Pou71ldc5LuFFXoWMFXHqNk4Gt9iUXZu5cppovFgk2D3Tghls9SIZMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVHw94u6ZhSsv2Z/b/AuuBVF799Bd06TmChz9mXDUYQ=;
	b=bwKQ/GXiRn2Ilil/lb3rTpDYr3n8BE983xjzB4sjHrzYhP966XfDljsaBDdT7ArLlq48/o
	SZBXom/vnk/+SXBQ==
Date: Wed, 09 Oct 2024 10:29:13 +0200
Subject: [PATCH v2 20/25] timekeeping: Rework
 timekeeping_inject_sleeptime64() to use shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-20-554456a44a15@linutronix.de>
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

Convert timekeeping_inject_sleeptime64() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index bb225534fee1..c1a2726a0d41 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1893,22 +1893,14 @@ bool timekeeping_rtc_skipsuspend(void)
  */
 void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 {
-	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&tk_core.lock, flags);
-	write_seqcount_begin(&tk_core.seq);
-
-	suspend_timing_needed = false;
-
-	timekeeping_forward_now(tk);
-
-	__timekeeping_inject_sleeptime(tk, delta);
-
-	timekeeping_update(&tk_core, tk, TK_UPDATE_ALL | TK_MIRROR);
+	scoped_guard(raw_spinlock_irqsave, &tk_core.lock) {
+		struct timekeeper *tk = &tk_core.shadow_timekeeper;
 
-	write_seqcount_end(&tk_core.seq);
-	raw_spin_unlock_irqrestore(&tk_core.lock, flags);
+		suspend_timing_needed = false;
+		timekeeping_forward_now(tk);
+		__timekeeping_inject_sleeptime(tk, delta);
+		timekeeping_update_staged(&tk_core, TK_UPDATE_ALL);
+	}
 
 	/* Signal hrtimers about time change */
 	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);

-- 
2.39.5



Return-Path: <netdev+bounces-127401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30B5975419
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85214283691
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290A51B2EFA;
	Wed, 11 Sep 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYUP5zSf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hab2UX6Q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC8191F9F;
	Wed, 11 Sep 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061414; cv=none; b=czrv+5W/GDXGDXXIQ9mhCPqr/mlfV2zIn/MAtQj0WahsF2oMP5gnp9LA3XN+fYIG8bONcjsxsQwYpv62T4nKI5SKmiGLGZ9k1AT8TlidiULg/93XlXlI5oq5B6DOdpfx1X5H9hlL/OELohGrFfJZITLuEelaNhLcPbjqS0Tue6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061414; c=relaxed/simple;
	bh=2Qm6nLpykvFlHhOJLqadWGJKowCKhpDGyESxT4y10a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUkLIxBcbFCQ+rtz8eCNCfGHcTILnl56vDqH9+DrBK3iWXSw//ouTcE7TiupJ1XqooFU9b2Yr5ZCRVsJqYNZNjsRq9GNLjX1UHdZ17T4dSPHB2Epp/QByp6mDe7AoNy79E2hArOfFG448uC3cu7nxnBsncI4uiKjI9f6+KZts04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYUP5zSf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hab2UX6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGlb+KqZTo18QmNObNQ+c2RouGIN1eMARsowlyH2Frs=;
	b=IYUP5zSflb7vHETb6Z0jFkjtiHqXdYAEqjsqTJqZzbYBCRK53yx+CSiQGKPQIoDoicTfqH
	Q8VoiHwXWgcvic2m50eocJC/943ls7RN1XNgO8Uh3LCQJd/pWe2iAE5sqG8Z3F7lrkgiHZ
	xkKc+F3Tt3kdEftlu50I9TVf8tZdYt9wLjaF3wwHNn1QChK6hfKnLaiC/76nI0l3NhS4Uo
	VY5T6lJG2Z6khwoPFL4edVRSnCe6hXSJWkE9wUPGw8Omr4/wWvRqK+Od4Dvyj69pJpw75f
	i+IpMsgNYrrXhb+vkr3FdcrxqDs+3r78zsxY/2/OzfYqAgYoeRhBHnG9dggL5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mGlb+KqZTo18QmNObNQ+c2RouGIN1eMARsowlyH2Frs=;
	b=hab2UX6QZYN6IHtvfQwFv7y2X2VjoUOjlrBwoz7RjCpCTH2sPuVUixzn6JkLA9xEdvpn44
	yNZYimVN6SV0mXDQ==
Date: Wed, 11 Sep 2024 15:30:05 +0200
Subject: [PATCH 21/24] timekeeping: Rework timekeeping_suspend() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-21-f7cae09e25d6@linutronix.de>
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
index d4a0d37f88f5..e3eb11ccdf5b 100644
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
2.39.2



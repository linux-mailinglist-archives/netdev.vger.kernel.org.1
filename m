Return-Path: <netdev+bounces-127405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25404975422
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E601F22779
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1A1B81A5;
	Wed, 11 Sep 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k9Keo4Qo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8fgySdYY"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F31AC8A3;
	Wed, 11 Sep 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061415; cv=none; b=r7Xb/acpwKuZYQUayGcSFTuT/ptoI1+AuT/vRiDXuVf2BeOaGciK0c8WHcpq3RFKIo8aIpV92YsO/WN+QkjRzGG450YoIl+dUeC+E5doAM/xZr6wCiwHaR4yJX0/DRRRu4YwMtYI9m6MnaMalBTh9I7sDyETiagxefv1RCtQwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061415; c=relaxed/simple;
	bh=5kskezftqXH5tjvjLiOu2UaXf3ww0dfSozmmELKWZMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cQ3tfo9OzPk3HyTs1xD7MYVapzzQBuERme6ejh6NQkpQsCofjrZX3Mig41BNAghfgS980K8CZYothMR+T2HLkhsDIBdGSIFQLBEkyNMGUQIRupCGumH9tLyXwz7xZIEVXDDpBePIwIEVFJjXn9Yo5gQRv3MhOQohmjt5pYgJ8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k9Keo4Qo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8fgySdYY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnkgY5EEf+tSEdiS0FM2oNqC9upPmA4xGg33OJxUNdM=;
	b=k9Keo4QonC0Yqm3cnM6LR0VGRcbSBSOBOvtIDt0tpMMwcd4sGkU5y+5FrRHDaBL2WqGLI3
	ZRVXP6q2sTy7KtD0fTX0jv3lxytgfPFj+fhXyhPdq+h8ugaEYVvukEi6Anm8Re3BhhaUaa
	Dxyt8ijqRq1guF/MhuovMiKsALyNhx3PitAIj+HOcZQyPcfiwDAZS9cThvdUtOVSPxSKW5
	xBXoT9+EmCtEtLdhyaKVBfqXqkNdd6juDOu+sMQ1iD2fBNF/PU2QjMMPC5wSX9wyeCNj6z
	Ob8ImQ9lk0XQgiDhmlmDfUOaWklFLetOBk4MJsZSJhhfWZ4/Rp73YgEXV46BCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnkgY5EEf+tSEdiS0FM2oNqC9upPmA4xGg33OJxUNdM=;
	b=8fgySdYYm6ifiAEEabzUWN89HWR37RTQwPj843g8TJvpes6WM1sgnuWXXMjzP2XCw17PaY
	HmIAMgEMGcvY1WAQ==
Date: Wed, 11 Sep 2024 15:30:03 +0200
Subject: [PATCH 19/24] timekeeping: Rework timekeeping_inject_sleeptime64()
 to use shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-19-f7cae09e25d6@linutronix.de>
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

Convert timekeeping_inject_sleeptime64() to use this scheme.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 223429b1ca06..244bb58dcda9 100644
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
2.39.2



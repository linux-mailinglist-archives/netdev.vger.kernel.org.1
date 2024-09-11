Return-Path: <netdev+bounces-127399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6B975412
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678E1C243FC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6C1ACDF9;
	Wed, 11 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NE9e93mi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzIAPHKj"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4B51ABEBA;
	Wed, 11 Sep 2024 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061412; cv=none; b=bpvco6mOVWpql5147xAdD3qvClesT3YS0c+3ZrPtDvLRxbnPjleoBxCBiybz8dY8lQzee1J4W70Qhl3FAX5SYjqSIjORCLJSKe9y/KoTXf7cqklkHxPfiQsjcBIn2d694p4kz1fDSsBvncU24umUkXiohZJxMfEEELJY1h+Wc2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061412; c=relaxed/simple;
	bh=11k2zg2iWHkeGOqyjca+7sno045Z743cSq0hqnRE8VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btwz8XfcEXVG8O98nkAyP815bj9FY5F9wT0JhrD6VpRKuZd0+s4gBUiC+E6dKF17vKAbZ8P/6Q1GcUunwY4fwx01N7geOXxoPKF2hVGQ6H55D0+XwYpc2VPDTX7N/wmtfYqm5S6jJkq4Oh+AHZwvPmEfX0fro4xr0urI9ZmSe8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NE9e93mi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzIAPHKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAOR7ivePhht6tHAppOLIeJDMDAplgh861T+7mUgea0=;
	b=NE9e93mia4vb1EFuX+WN65jId2v4/VfCHFmtPUm4oXklvPhuUSB2h0OrOyAYw7Dfre5wQ0
	OCJVzRMyY9+UpnsgvKTjT9aE+SwQL8v02eNuuesggS9+kYNciPI8O6eo6cIC+FC/n399Ov
	6CWxhsG8L6Ie48VczJf0ay4fpg0T5wVO42/AwbF1UXu7S5XC9C2jWYgPi/HIsx8bt7TDvM
	5tTDL3WS9XKTJ9CRvJsoNMKgEkVNPClbIY5cKpMji3fdWe9WArtwi7D/Xj20nqCPqu0Wm8
	nBkI9KenRY0djYPQ0fjmXSgWKuxnZPyGzZLN68i44K0E365OInZBFmxeWaNwMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAOR7ivePhht6tHAppOLIeJDMDAplgh861T+7mUgea0=;
	b=dzIAPHKjMms06kzgzsbBsUZxfDHX5vEDjNOQHOMZjT6iX9PC7BzM6pduWnkDvxIR1+DQ1E
	u4cEqHjkvQHzNDCA==
Date: Wed, 11 Sep 2024 15:30:02 +0200
Subject: [PATCH 18/24] timekeeping: Rework timekeeping_init() to use
 shadow_timekeeper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-18-f7cae09e25d6@linutronix.de>
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

For timekeeping_init() the sequence count write held time is not relevant
and it could keep working on the real timekeeper, but there is no reason to
make it different from other timekeeper updates.

Convert it to operate on the shadow timekeeper.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 9b4fd620f895..223429b1ca06 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1778,7 +1778,7 @@ static bool persistent_clock_exists;
 void __init timekeeping_init(void)
 {
 	struct timespec64 wall_time, boot_offset, wall_to_mono;
-	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct clocksource *clock;
 
 	tkd_basic_setup(&tk_core);
@@ -1802,7 +1802,7 @@ void __init timekeeping_init(void)
 	wall_to_mono = timespec64_sub(boot_offset, wall_time);
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
-	write_seqcount_begin(&tk_core.seq);
+
 	ntp_init();
 
 	clock = clocksource_default_clock();
@@ -1815,9 +1815,7 @@ void __init timekeeping_init(void)
 
 	tk_set_wall_to_mono(tk, wall_to_mono);
 
-	timekeeping_update(&tk_core, tk, TK_MIRROR | TK_CLOCK_WAS_SET);
-
-	write_seqcount_end(&tk_core.seq);
+	timekeeping_update_staged(&tk_core, TK_CLOCK_WAS_SET);
 }
 
 /* time in seconds when suspend began for persistent clock */

-- 
2.39.2



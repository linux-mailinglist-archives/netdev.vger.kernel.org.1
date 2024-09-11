Return-Path: <netdev+bounces-127385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C49753F5
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E7B1F220DA
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C215C1A303B;
	Wed, 11 Sep 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xH5zMWNZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bak4uDoW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352119E973;
	Wed, 11 Sep 2024 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061405; cv=none; b=Ab7B7SdGmS81FPZ2YRcnO0nNJp4HCwjelN5QdcgTYy3R1ptde/SmxRR3QHE3e0S64+8IRvf/KzJ4QJPc+HiE/TtoISZx0rYixUa8EtW8EpYfzsfXIY7osAIHVKhlsjsScZrtgtxwRFPqDDOJvC4LruE0i/L4wWluokMj3Nw2d2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061405; c=relaxed/simple;
	bh=tt3A5eJHa/2iVsuRVo1WQOjrhyaCN2hfa0cAUYrZY+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LiI+0x8Y8YgXpIVE8r16O8kEUdCnYFMeB65Va5eOTVBcI2Iwrl72l4Ca5mnSYeS6T1T7aC5Sa9dXDBGv4u8hIzOSWfp6ZwAFs1T8/b+AbpB467r6Clc95GXxMTfAw/27W/dBbev1xADFKCl7J9tGEOT/7j83/uHI77EG7sm7l3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xH5zMWNZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bak4uDoW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1OCiJ956B+lVO6X7ZOjrSYj+KbykSrrWsWmDzkB17o=;
	b=xH5zMWNZZkjckTZVYIbFJ6mOwFSfew/0/gwIsEFt8jXVyLRIxEpVfHe1dQ644g9SZJz6cR
	Iha4PkUQiHdOYxUpH3590RYcnLhm7gPV21mOagyS8BIcgEUGC4wsVL6SLzcCeEMd4zv51e
	MzcxTsC4X2y2AczhWcstDjC0aVTRdtL9pLIFpBrWVoW2FjRdVNVbvGDDZ4ix5zVfnzK1VL
	BEeGPp+ybkm9SXoKS/1Xi/60Hk0YVlru2x/Qs2ed9qy8WAKRpVv3L6Af2C9L/HBk4mNd4J
	e7g/MUKP3T6DMtI4iU+ASJ1Lv7hCIdB3wPpk64E8jKkyKxodgQN7Kn4AnrIruw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726061402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1OCiJ956B+lVO6X7ZOjrSYj+KbykSrrWsWmDzkB17o=;
	b=bak4uDoWNIpndtdnk2U6MZ5v3xTa/rc/o1MTRAMUpvF3feYVRdpL/xcxGb2RdbFVOU9Qza
	OQExpZNAezdg49Dw==
Date: Wed, 11 Sep 2024 15:29:48 +0200
Subject: [PATCH 04/24] timekeeping: Abort clocksource change in case of
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-devel-anna-maria-b4-timers-ptp-timekeeping-v1-4-f7cae09e25d6@linutronix.de>
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

There is no point to go through a full timekeeping update when acquiring a
module reference or enabling the new clocksource fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index bdc4a6fe040d..7b80dd70062c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1577,33 +1577,29 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
 static int change_clocksource(void *data)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	struct clocksource *new, *old = NULL;
+	struct clocksource *new = data, *old = NULL;
 	unsigned long flags;
-	bool change = false;
-
-	new = (struct clocksource *) data;
 
 	/*
-	 * If the cs is in module, get a module reference. Succeeds
-	 * for built-in code (owner == NULL) as well.
+	 * If the clocksource is in a module, get a module reference.
+	 * Succeeds for built-in code (owner == NULL) as well. Abort if the
+	 * reference can't be acquired.
 	 */
-	if (try_module_get(new->owner)) {
-		if (!new->enable || new->enable(new) == 0)
-			change = true;
-		else
-			module_put(new->owner);
+	if (!try_module_get(new->owner))
+		return 0;
+
+	/* Abort if the device can't be enabled */
+	if (new->enable && new->enable(new) != 0) {
+		module_put(new->owner);
+		return 0;
 	}
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
 	timekeeping_forward_now(tk);
-
-	if (change) {
-		old = tk->tkr_mono.clock;
-		tk_setup_internals(tk, new);
-	}
-
+	old = tk->tkr_mono.clock;
+	tk_setup_internals(tk, new);
 	timekeeping_update(tk, TK_CLEAR_NTP | TK_MIRROR | TK_CLOCK_WAS_SET);
 
 	write_seqcount_end(&tk_core.seq);
@@ -1612,7 +1608,6 @@ static int change_clocksource(void *data)
 	if (old) {
 		if (old->disable)
 			old->disable(old);
-
 		module_put(old->owner);
 	}
 

-- 
2.39.2



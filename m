Return-Path: <netdev+bounces-133516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083D09962A2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F0C1F2327B
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1262C18A959;
	Wed,  9 Oct 2024 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tl8D/Rr4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/jxvWJF"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228A188739;
	Wed,  9 Oct 2024 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462559; cv=none; b=D3rxKmCkc0xDzUuw731t1qIlwj0HlfTsTLuCL9i9f6emokJ7b03ewb6Rq1KEq9oFxT2VFGtVltYGLvqDvlDnw1yItfR2Ttk0XAsXJPI7Hi0sYMMzWwXt7ILEySaSscvFptHbXJjW0qvorRbVPjh1wmeOK9awtzP0IKlFdW8Wn3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462559; c=relaxed/simple;
	bh=zlJbCDZ6B9SeUKQDoLwvls4pdXQE7EYEHEQq9ledjk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AQnltbBGpcUPM4D0LWtcI2lH/HKrqhabBSSp3WEiEnJa+xVaMSR85paeTI/lMJQioE15kd7wmAU/Rjjs13WA+IOegEPjth67mHBqGqx64tQ0YeCZNSpXGl4IPoP5MuNv5bet1sv66MbvcKFp4j3Z4yXeZ0qwnQtz4wx3GOweo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tl8D/Rr4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/jxvWJF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wzvWtgEBSrKgOrWII19Tdc3v5jZTMrQEdlErVE1mMc=;
	b=Tl8D/Rr4dRkEQBUdDIEJQIy8B3ylOFTKqY+ynnnRegsIc2USTBxv1X3rhThZf3y4T/sptX
	oMmpfloa58p1T93bhifLCu4KoLk8CMbEmMT4sYG4g8qdl75PLJP56walDndjzsFbN5syzv
	ErSSnwcPKozTkKbmhVERas53tEDXG+evmgxczKLRpnr/xRa2NjPvzQEfOV/rPdrHFvJskt
	VOJjtlLquTSz9QeMOBbajhO/tTHGyxZez95c/J79RnHaZKN8r3B5xcbOOZolrRV/xcc2bf
	urdfJPfGTWox4x/wX3VxJDnkq9O4aEb63rE1R7u2n62pWe3PB9g/AenseG4jcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728462555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wzvWtgEBSrKgOrWII19Tdc3v5jZTMrQEdlErVE1mMc=;
	b=Q/jxvWJFjHojB2i1lX6/MZ1fDbU5/1AKfPXakao1PdpAsHR9JeN6RVhTLv50sRgVRwVWXN
	a4JGbe1T/S+RIUCg==
Date: Wed, 09 Oct 2024 10:28:57 +0200
Subject: [PATCH v2 04/25] timekeeping: Abort clocksource change in case of
 failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-devel-anna-maria-b4-timers-ptp-timekeeping-v2-4-554456a44a15@linutronix.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to go through a full timekeeping update when acquiring a
module reference or enabling the new clocksource fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timekeeping.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c4dd460b6f2b..0ae35a71f8cc 100644
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
2.39.5


